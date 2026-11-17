#!/usr/bin/env python3
"""Import exact ver-td-COM results and saved decomposition statistics."""

import argparse
import ast
from collections import Counter
import csv
from fractions import Fraction
import hashlib
import json
from pathlib import Path
import re
import sys

import paf_stats


LOG_SUFFIX = ".lp.ver-td-COM.log"


def read_table(path):
    with path.open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def exact_decimal(value):
    """Return the complete decimal expansion of a terminating Fraction."""
    if value == 0:
        return "0"
    denominator = value.denominator
    twos = fives = 0
    while denominator % 2 == 0:
        denominator //= 2
        twos += 1
    while denominator % 5 == 0:
        denominator //= 5
        fives += 1
    if denominator != 1:
        raise ValueError("probability does not have a terminating decimal expansion")
    scale = max(twos, fives)
    scaled = value.numerator * 2 ** (scale - twos) * 5 ** (scale - fives)
    if scale == 0:
        return str(scaled)
    digits = str(scaled).zfill(scale + 1)
    return digits[:-scale] + "." + digits[-scale:]


def one_value(pattern, text, label, required=True):
    values = re.findall(pattern, text, re.MULTILINE)
    if not values and not required:
        return ""
    if len(values) != 1:
        raise ValueError(f"expected one {label}, found {len(values)}")
    return values[0]


def parse_saved_decomposition(text):
    """Read the traversal dictionary printed by ver-td-COM."""
    bags, edges = {}, set()
    for line in text.splitlines():
        match = re.fullmatch(r"(\d+)\s+(\[.*\])", line)
        if not match:
            continue
        try:
            data = ast.literal_eval(match.group(2))
        except (SyntaxError, ValueError):
            continue
        if not isinstance(data, list) or not data or not isinstance(data[0], list):
            continue
        node = int(match.group(1))
        if node in bags:
            raise ValueError("duplicate traversal node")
        bags[node] = set(data[0])
        if "children" in data:
            children = data[data.index("children") + 1]
            if not isinstance(children, list):
                raise ValueError("invalid traversal children")
            edges.update(tuple(sorted((node, int(child)))) for child in children)
    return bags, edges


def argument_order(path):
    names = []
    for line in path.read_text(encoding="utf-8").splitlines():
        match = re.fullmatch(r"arg\(([^(),\s]+)\)\.", line.strip())
        if match:
            names.append(match.group(1))
    return names


def parse_log(path, instance_path, arguments, attacks):
    text = path.read_text(encoding="utf-8")
    command = one_value(r"^# command: (.*)$", text, "solver command")
    if Path(command.split()[-1]).name != instance_path.name:
        raise ValueError("solver command names a different instance")

    results = re.findall(r"^RESULT(?::)?\s+(\S+)\s*$", text, re.MULTILINE)
    if len(results) == 1 and not any(marker in text for marker in
                                     ("Maximum CPU time exceeded", "Maximum memory exceeded",
                                      "Maximum VSize exceeded", "INVALID TREE DECOMPOSITION", "ERROR:")):
        status = "ok"
        value = Fraction(results[0])
        if not 0 <= value <= 1:
            raise ValueError("result is outside [0,1]")
    elif "Maximum CPU time exceeded" in text:
        status, value = "timeout", None
    elif "Maximum memory exceeded" in text or "Maximum VSize exceeded" in text:
        status, value = "memoryout", None
    elif "INVALID TREE DECOMPOSITION" in text:
        status, value = "invalid_td", None
    else:
        status, value = "error", None

    largest_text = one_value(r"^Largest bag size:\s*(\d+)\s*$", text,
                             "largest bag size", required=False)
    largest = int(largest_text) if largest_text else None
    bags, bag_edges = parse_saved_decomposition(text)
    if largest is not None:
        order = argument_order(instance_path)
        if set(order) != arguments or len(order) != len(arguments):
            raise ValueError("argument order does not match parsed arguments")
        mapping = {name: number for number, name in enumerate(order, 1)}
        graph_edges = {tuple(sorted((mapping[a], mapping[b]))) for a, b in attacks if a != b}
        computed = paf_stats.validate_decomposition(bags, bag_edges, graph_edges, len(arguments))
        if computed != largest:
            raise ValueError("reported largest bag size disagrees with saved decomposition")
    elif status == "ok":
        raise ValueError("successful log has no decomposition measurement")

    return dict(
        status=status,
        probability_numerator=str(value.numerator) if value is not None else "",
        probability_denominator=str(value.denominator) if value is not None else "",
        probability_decimal=exact_decimal(value) if value is not None else "",
        runtime_seconds=one_value(r"^#\s+real time \(s\):\s*([0-9.]+)\s*$",
                                  text, "real time", required=False),
        cpu_seconds=one_value(r"^#\s+total CPU time \(s\):\s*([0-9.]+)\s*$",
                              text, "CPU time", required=False),
        peak_memory_kib=one_value(r"^#\s+peak process-group .*? \(KiB\):\s*(\d+)\s*$",
                                  text, "peak memory", required=False),
        largest_bag_size=str(largest) if largest is not None else "",
        decomposition_width=str(largest - 1) if largest is not None else "",
        source_log=path.name,
        source_log_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        solver_command="python3 ../ver-td-COM/post_order.py <INSTANCE>",
    )


def structural_row(dataset, instance_path, manifest_row, parsed, result):
    arguments, attacks, candidate, query, pargs, patts, metadata = parsed
    adjacency = {argument: set() for argument in arguments}
    for a, b in attacks:
        if a != b:
            adjacency[a].add(b)
            adjacency[b].add(a)
    remaining, components = set(arguments), 0
    while remaining:
        remaining -= paf_stats.reachable(next(iter(remaining)), adjacency)
        components += 1
    relative = instance_path.relative_to(dataset)
    row = dict(
        instance_id=str(relative.relative_to("instances").with_suffix("")),
        instance_path=relative.as_posix(),
        family=relative.parts[1],
        instance_sha256=manifest_row["instance_sha256"],
        generator=metadata.get("generator", ""),
        generator_k=metadata.get("k", ""),
        generator_n=metadata.get("n", ""),
        replicate=metadata.get("replicate", ""),
        seed=manifest_row["seed"],
        edge_probability=metadata.get("edge_probability", ""),
        argument_count=len(arguments),
        attack_count=len(attacks),
        undirected_edge_count=sum(map(len, adjacency.values())) // 2,
        self_attack_count=sum(a == b for a, b in attacks),
        unattacked_argument_count=len(arguments - {b for _, b in attacks}),
        isolated_argument_count=sum(not neighbors for neighbors in adjacency.values()),
        weak_component_count=components,
        candidate_size=len(candidate),
        query_argument=";".join(sorted(query)),
        uncertain_argument_count=sum(probability not in (0, 1) for probability in pargs.values()),
        uncertain_attack_count=sum(probability not in (0, 1) for probability in patts.values()),
        width_status=("ok" if result and result["largest_bag_size"] else
                      result["status"] if result else "not_run"),
        largest_bag_size=result["largest_bag_size"] if result else "",
        decomposition_width=result["decomposition_width"] if result else "",
        width_kind="validated_solver_decomposition_upper_bound" if result and result["largest_bag_size"] else "",
        width_seconds="",
        width_error="",
    )
    return row


def aggregate_hash(paths):
    digest = hashlib.sha256()
    for path in sorted(paths, key=lambda item: item.name):
        digest.update(path.name.encode("utf-8"))
        digest.update(b"\0")
        digest.update(hashlib.sha256(path.read_bytes()).digest())
    return digest.hexdigest()


def import_logs(dataset, logs, labels_output, analysis_output, solver_repository,
                solver_commit, time_limit_seconds, memory_limit_mib):
    if labels_output.exists() or (analysis_output is not None and analysis_output.exists()):
        raise ValueError("output already exists")
    manifest_path = dataset / "generation_instances.tsv"
    manifest = read_table(manifest_path)
    if not manifest:
        raise ValueError("generation manifest is empty")
    by_name = {}
    for row in manifest:
        name = Path(row["instance_path"]).name
        if name in by_name:
            raise ValueError(f"duplicate instance filename: {name}")
        by_name[name] = row

    log_paths = sorted(logs.glob(f"*{LOG_SUFFIX}"))
    if not log_paths:
        raise ValueError("no solver logs found")
    by_instance = {}
    for path in log_paths:
        name = path.name.removesuffix(".ver-td-COM.log")
        if name not in by_name or name in by_instance:
            raise ValueError(f"unknown or duplicate solver log: {path.name}")
        by_instance[name] = path

    label_rows, analysis_rows = [], []
    for number, manifest_row in enumerate(manifest, 1):
        instance_path = dataset / manifest_row["instance_path"]
        if not instance_path.is_file():
            raise ValueError(f"missing instance: {manifest_row['instance_path']}")
        digest = hashlib.sha256(instance_path.read_bytes()).hexdigest()
        if digest != manifest_row["instance_sha256"]:
            raise ValueError(f"instance hash mismatch: {manifest_row['instance_path']}")
        parsed = paf_stats.read_paf(instance_path)
        log_path = by_instance.get(instance_path.name)
        result = parse_log(log_path, instance_path, parsed[0], parsed[1]) if log_path else None
        label_rows.append(dict(
            instance_path=manifest_row["instance_path"],
            instance_sha256=digest,
            status=result["status"] if result else "not_run",
            probability_numerator=result["probability_numerator"] if result else "",
            probability_denominator=result["probability_denominator"] if result else "",
            probability_decimal=result["probability_decimal"] if result else "",
            runtime_seconds=result["runtime_seconds"] if result else "",
            cpu_seconds=result["cpu_seconds"] if result else "",
            peak_memory_kib=result["peak_memory_kib"] if result else "",
            largest_bag_size=result["largest_bag_size"] if result else "",
            decomposition_width=result["decomposition_width"] if result else "",
            source_log=result["source_log"] if result else "",
            source_log_sha256=result["source_log_sha256"] if result else "",
        ))
        if analysis_output is not None:
            analysis_rows.append(structural_row(dataset, instance_path, manifest_row, parsed, result))
        if number % 1000 == 0:
            print(f"Imported {number}/{len(manifest)}", flush=True)

    labels_output.mkdir(parents=True)
    paf_stats.write_table(labels_output / "labels_results.tsv", label_rows)
    counts = Counter(row["status"] for row in label_rows)
    settings = dict(
        task="extension_verification",
        semantics="complete",
        formalism="PAF",
        arithmetic="rational",
        solver="ver-td-COM",
        solver_repository=solver_repository,
        solver_commit=solver_commit,
        solver_command="python3 ../ver-td-COM/post_order.py <INSTANCE>",
        solver_python_environment="not recorded in source logs",
        htd_configuration="selected internally by the solver at the recorded revision",
        time_limit_seconds=time_limit_seconds,
        memory_limit_mib=memory_limit_mib,
        source_log_directory=f"{logs.parent.name}/{logs.name}",
        source_log_count=len(log_paths),
        source_logs_sha256=aggregate_hash(log_paths),
        dataset_manifest_sha256=hashlib.sha256(manifest_path.read_bytes()).hexdigest(),
        importer_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        instance_count=len(manifest),
        status_counts=dict(sorted(counts.items())),
    )
    (labels_output / "labels_settings.json").write_text(json.dumps(settings, indent=2) + "\n",
                                                         encoding="utf-8")

    if analysis_output is not None:
        analysis_output.mkdir(parents=True)
        paf_stats.write_table(analysis_output / "analysis_instances.tsv", analysis_rows)
        paf_stats.summarize(analysis_rows, analysis_output)
        analysis_settings = dict(
            graph_definition="underlying_undirected_declared_attacks_v1",
            width_source="saved ver-td-COM traversals",
            width_validation="bag tree, vertex coverage, edge coverage and running intersection",
            labels_results=(labels_output / "labels_results.tsv").relative_to(dataset).as_posix(),
            labels_results_sha256=hashlib.sha256((labels_output / "labels_results.tsv").read_bytes()).hexdigest(),
            importer_sha256=settings["importer_sha256"],
            instance_count=len(analysis_rows),
            width_status_counts=dict(sorted(Counter(row["width_status"] for row in analysis_rows).items())),
        )
        (analysis_output / "analysis_settings.json").write_text(
            json.dumps(analysis_settings, indent=2) + "\n", encoding="utf-8")
    print(f"Labels: {dict(sorted(counts.items()))}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("dataset", type=Path)
    parser.add_argument("--logs", type=Path, required=True)
    parser.add_argument("--labels-run", default="complete-extension-td-v1")
    parser.add_argument("--analysis-run", help="also write structural statistics and imported widths")
    parser.add_argument("--solver-repository", required=True)
    parser.add_argument("--solver-commit", required=True)
    parser.add_argument("--time-limit-seconds", type=int, required=True)
    parser.add_argument("--memory-limit-mib", type=int, required=True)
    args = parser.parse_args()
    if not args.dataset.is_dir() or not args.logs.is_dir():
        parser.error("dataset and logs must be directories")
    if args.time_limit_seconds < 1 or args.memory_limit_mib < 1:
        parser.error("limits must be positive")
    import_logs(args.dataset.resolve(), args.logs.resolve(),
                args.dataset.resolve() / "labels" / args.labels_run,
                args.dataset.resolve() / "analysis" / args.analysis_run if args.analysis_run else None,
                args.solver_repository, args.solver_commit,
                args.time_limit_seconds, args.memory_limit_mib)


if __name__ == "__main__":
    main()
