#!/usr/bin/env python3
"""Rebuild family and coverage tables, optionally plot and refresh the README."""

import argparse
from collections import Counter
import csv
from decimal import Decimal
import hashlib
import json
from pathlib import Path
import subprocess
import sys


START = "<!-- probarg-report:start -->"
END = "<!-- probarg-report:end -->"


def read_table(path):
    with path.open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def markdown(headers, rows):
    def line(values):
        return "| " + " | ".join(str(value).replace("|", "\\|") for value in values) + " |"
    return "\n".join([line(headers), line(["---"] * len(headers)), *(line(row) for row in rows)])


def interval(rows, key):
    values = [int(row[key]) for row in rows if row.get(key, "") != ""]
    if not values:
        return "pending"
    return str(min(values)) if min(values) == max(values) else f"{min(values)}–{max(values)}"


def coverage(collection, families, rows):
    """Check input identity, then aggregate measured rows without hiding failures."""
    declared = {row["family"]: row for row in families}
    if len(declared) != len(families):
        raise ValueError("duplicate family in families.tsv")
    paths = {path.relative_to(collection).as_posix(): path
             for path in (collection / "instances").rglob("*.lp")}
    actual = Counter(Path(relative).parts[1] for relative in paths)
    if set(actual) != set(declared):
        raise ValueError("families.tsv does not describe exactly the instance families")
    for family, row in declared.items():
        if int(row["instance_count"]) != actual[family]:
            raise ValueError(f"{family}: declared instance count disagrees with native files")
    seen = set()
    for row in rows:
        relative = row["instance_path"]
        if relative not in paths or relative in seen:
            raise ValueError(f"unknown or duplicate instance path: {relative}")
        seen.add(relative)
        if Path(relative).parts[1] != row["family"]:
            raise ValueError(f"instance family mismatch: {relative}")
        if hashlib.sha256(paths[relative].read_bytes()).hexdigest() != row["instance_sha256"]:
            raise ValueError(f"instance hash changed since analysis: {relative}")
        if row["width_status"] == "ok" and row["decomposition_width"] == "":
            raise ValueError(f"successful width record has no width: {relative}")

    result = []
    for family in declared:
        group = [row for row in rows if row["family"] == family]
        valid = [row for row in group if row["width_status"] == "ok"]
        statuses = Counter(row["width_status"] for row in group if row["width_status"] != "ok")
        result.append(dict(family=family, instances=actual[family], analyzed=len(group),
                           arguments=interval(group, "argument_count"),
                           directed_attacks=interval(group, "attack_count"),
                           weak_components=interval(group, "weak_component_count"),
                           decomposition_width=interval(valid, "decomposition_width"),
                           valid_widths=len(valid),
                           other_width_statuses=", ".join(f"{s}={n}" for s, n in sorted(statuses.items())) or "none"))
    return result


def report_text(families, structural, relative_analysis, has_plot):
    parameter_rows = []
    for family in families:
        value = family.get("edge_probability", "")
        percent = format((Decimal(value) * 100).normalize(), "f") + "%" if value else "unrecorded"
        parameter_rows.append([family["family"], percent, family["k_values"], family["n_values"],
                               family["replicates"], family["instance_count"],
                               family.get("master_seed", "") or "unrecorded"])
    sections = ["## Families and generator parameters", "",
                markdown(["Family", "Grid-edge probability", "k", "n", "Replicates", "Instances", "Master seed"], parameter_rows), ""]
    for family in families:
        sections.append(f"- `{family['family']}`: generator `{family['generator']}`; "
                        f"candidate inclusion probability {family['candidate_probability']}; "
                        f"sampling weight of probability one {family['certainty_weight']} "
                        "(each value 0.1–0.9 has weight 10).")
    if any(not family.get("master_seed", "") for family in families):
        sections += ["", "Seeds marked unrecorded are unavailable for historical instances."]
    sections += ["", "## Structural coverage", "",
                 markdown(["Family", "Instances", "Analyzed", "Arguments", "Directed attacks", "Weak components", "Decomposition width", "Valid widths", "Other statuses"],
                          [[r["family"], r["instances"], r["analyzed"], r["arguments"], r["directed_attacks"],
                            r["weak_components"], r["decomposition_width"], r["valid_widths"], r["other_width_statuses"]]
                           for r in structural]), "",
                 "Graph: the underlying undirected graph of declared attacks, with reciprocal attacks collapsed and self-attacks omitted for width computation.",
                 "Widths are validated decomposition upper bounds on treewidth. Ranges describe the analyzed rows; instances outside a partial analysis have no measurements in this report.", ""]
    if has_plot:
        sections += [f"![PAF size and width coverage]({relative_analysis}/coverage.png)", ""]
    sections += [f"Sources: [family parameters](families.tsv), [per-instance measurements]({relative_analysis}/index.tsv), "
                 f"[measurement configuration]({relative_analysis}/run.json).", ""]
    return "\n".join(sections)


def replace_report(readme, text):
    if START not in readme and END not in readme:
        return readme.rstrip() + "\n\n" + START + "\n" + text + END + "\n"
    if readme.count(START) != 1 or readme.count(END) != 1 or readme.index(START) >= readme.index(END):
        raise ValueError("README has malformed generated-report markers")
    before, rest = readme.split(START, 1)
    _, after = rest.split(END, 1)
    return before + START + "\n" + text + END + after


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("collection", type=Path)
    parser.add_argument("--analysis", required=True, type=Path, help="analysis directory relative to the collection")
    parser.add_argument("--plot", action="store_true", help="regenerate coverage.png using Matplotlib")
    parser.add_argument("--update-readme", action="store_true", help="refresh only the marked generated section")
    args = parser.parse_args()
    collection = args.collection.resolve()
    analysis = (collection / args.analysis).resolve()
    try:
        relative = analysis.relative_to(collection).as_posix()
        families_path, index_path = collection / "families.tsv", analysis / "index.tsv"
        families, rows = read_table(families_path), read_table(index_path)
        if not families or not rows:
            raise ValueError("family parameters and analysis index must both contain rows")
        structural = coverage(collection, families, rows)
        if args.update_readme:
            readme = (collection / "README.md").read_text(encoding="utf-8")
            replace_report(readme, "")  # Check markers before writing anything.
        if args.plot:
            subprocess.run([sys.executable, str(Path(__file__).with_name("plot_paf_stats.py")),
                            str(index_path), "--output", str(analysis / "coverage.png"), "--overwrite"], check=True)
        text = report_text(families, structural, relative, (analysis / "coverage.png").exists())
        # report.md is in the analysis directory, so its relative links need that base.
        report = text.replace("](families.tsv)", f"]({Path('../' * len(Path(relative).parts)).as_posix()}/families.tsv)")
        report = report.replace(f"]({relative}/", "](")
        (analysis / "report.md").write_text("# Dataset report\n\n" + report, encoding="utf-8")
        with (analysis / "coverage.tsv").open("w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, list(structural[0]), delimiter="\t", lineterminator="\n")
            writer.writeheader()
            writer.writerows(structural)
        record = dict(command=sys.argv, script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                      families_sha256=hashlib.sha256(families_path.read_bytes()).hexdigest(),
                      index_sha256=hashlib.sha256(index_path.read_bytes()).hexdigest())
        (analysis / "report.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
        if args.update_readme:
            (collection / "README.md").write_text(replace_report(readme, text), encoding="utf-8")
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as error:
        parser.error(str(error))
    print(f"Updated tables in {analysis}" + (" and collection README" if args.update_readme else ""))


if __name__ == "__main__":
    main()
