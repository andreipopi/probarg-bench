#!/usr/bin/env python3
"""Inventory native PAFs and optionally measure validated HTD decomposition widths."""

import argparse
from collections import Counter, defaultdict
import csv
from decimal import Decimal
import hashlib
import json
from pathlib import Path
import re
import shlex
import subprocess
import sys
import time


def read_paf(path):
    arguments, attacks, candidate, query = set(), set(), set(), set()
    pargs, patts, metadata, seen = {}, {}, {}, set()
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        if raw.startswith("% probarg "):
            key, value = raw[len("% probarg "):].split("=", 1)
            metadata[key] = value
        line = raw.split("%", 1)[0].strip()
        if not line:
            continue
        match = re.fullmatch(r"(arg|att|p|extension|in|query)\(([^()]*)\)\.", line)
        if not match:
            raise ValueError(f"{path}:{number}: unsupported fact: {line}")
        predicate, body = match.groups()
        values = tuple(value.strip() for value in body.split(","))
        fact = (predicate, values)
        if fact in seen:
            raise ValueError(f"{path}:{number}: duplicate fact")
        seen.add(fact)
        if predicate == "arg" and len(values) == 1:
            arguments.add(values[0])
        elif predicate == "att" and len(values) == 2:
            attacks.add(values)
        elif predicate == "extension" and len(values) == 1:
            candidate.add(values[0])
        elif predicate in ("in", "query") and len(values) == 1:
            query.add(values[0])
        elif predicate == "p" and len(values) in (2, 4):
            value = Decimal(values[-1])
            if not value.is_finite() or not 0 <= value <= 1:
                raise ValueError(f"{path}:{number}: expected a probability in [0,1]")
            table, key = (pargs, values[0]) if len(values) == 2 else (patts, values[1:3])
            if key in table:
                raise ValueError(f"{path}:{number}: duplicate probability declaration")
            table[key] = value
        else:
            raise ValueError(f"{path}:{number}: unsupported arity")
    if not arguments or set(pargs) != arguments or set(patts) != attacks:
        raise ValueError(f"{path}: declarations and probability facts do not match")
    if not candidate | query <= arguments or any(a not in arguments or b not in arguments for a, b in attacks):
        raise ValueError(f"{path}: undeclared argument")
    return arguments, attacks, candidate, query, pargs, patts, metadata


def reachable(start, adjacency, allowed=None):
    visited, stack = {start}, [start]
    while stack:
        for neighbor in adjacency[stack.pop()]:
            if neighbor not in visited and (allowed is None or neighbor in allowed):
                visited.add(neighbor)
                stack.append(neighbor)
    return visited


def parse_decomposition(text):
    """Accept standard PACE .td or the research HTD's Traversal section."""
    bags, edges, header = {}, set(), None
    if re.search(r"^s td ", text, re.MULTILINE):
        section = text[text.index("s td "):]
        for line in section.splitlines():
            parts = line.split()
            if not parts or parts[0] == "c":
                continue
            if parts[:2] == ["s", "td"] and len(parts) == 5:
                if header is not None:
                    raise ValueError("multiple decomposition headers")
                header = tuple(map(int, parts[2:]))
            elif parts[0] == "b" and len(parts) >= 2:
                bag = int(parts[1])
                if bag in bags:
                    raise ValueError("duplicate bag id")
                bags[bag] = set(map(int, parts[2:]))
            elif len(parts) == 2 and all(value.isdigit() for value in parts):
                edge = tuple(sorted(map(int, parts)))
                if edge in edges:
                    raise ValueError("duplicate decomposition edge")
                edges.add(edge)
            else:
                raise ValueError(f"unsupported decomposition line: {line}")
    elif "Traversal\n" in text:
        roots = 0
        for line in text.split("Traversal\n", 1)[1].splitlines():
            if not line.strip():
                continue
            match = re.fullmatch(r"(\d+)\s+\[([\d,\s]*)\]\s+(?:intro|rem|join|leaf)\b.*\s+(\d+)", line)
            if not match:
                raise ValueError(f"unsupported HTD traversal line: {line}")
            node, vertices, parent = match.groups()
            node, parent = int(node), int(parent)
            if node in bags:
                raise ValueError("duplicate bag id")
            bags[node] = set(map(int, re.findall(r"\d+", vertices)))
            if parent:
                edges.add(tuple(sorted((node, parent))))
            else:
                roots += 1
        if roots != 1:
            raise ValueError("expected one traversal root")
    else:
        raise ValueError("HTD returned neither PACE .td nor a recognized Traversal section")
    return bags, edges, header


def validate_decomposition(bags, edges, graph_edges, vertex_count, header=None):
    if not bags or len(edges) != len(bags) - 1:
        raise ValueError("bag graph is not a tree")
    adjacency = {bag: set() for bag in bags}
    for a, b in edges:
        if a == b or a not in bags or b not in bags:
            raise ValueError("invalid bag-tree edge")
        adjacency[a].add(b)
        adjacency[b].add(a)
    if len(reachable(next(iter(bags)), adjacency)) != len(bags):
        raise ValueError("bag tree is disconnected")
    vertex_bags = defaultdict(set)
    for bag, vertices in bags.items():
        for vertex in vertices:
            vertex_bags[vertex].add(bag)
    if set(vertex_bags) != set(range(1, vertex_count + 1)):
        raise ValueError("decomposition does not cover exactly the graph's vertices")
    if any(not vertex_bags[a] & vertex_bags[b] for a, b in graph_edges):
        raise ValueError("decomposition leaves a graph edge uncovered")
    for containing in vertex_bags.values():
        if reachable(next(iter(containing)), adjacency, containing) != containing:
            raise ValueError("bags containing a vertex do not form a connected subtree")
    largest_bag = max(map(len, bags.values()))
    if header is not None and header != (len(bags), largest_bag, vertex_count):
        raise ValueError("decomposition header disagrees with actual bag contents")
    return largest_bag


def write_table(path, rows):
    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, list(rows[0]), delimiter="\t", lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def measure(arguments, attacks, program, extra_args, timeout, destination):
    names = sorted(arguments)
    mapping = {name: i + 1 for i, name in enumerate(names)}
    edges = sorted({tuple(sorted((mapping[a], mapping[b]))) for a, b in attacks if a != b})
    graph = f"p tw {len(names)} {len(edges)}\n" + "".join(f"{a} {b}\n" for a, b in edges)
    result = {"width_status": "error", "largest_bag_size": "", "decomposition_width": "",
              "width_kind": "upper_bound", "width_seconds": "", "width_error": ""}
    start = time.monotonic()
    output = ""
    try:
        completed = subprocess.run([str(program), *extra_args], input=graph, text=True,
                                   capture_output=True, timeout=timeout)
        output = completed.stdout + "\nSTDERR\n" + completed.stderr
        if completed.returncode:
            raise ValueError(f"HTD exited with code {completed.returncode}")
        bags, td_edges, header = parse_decomposition(completed.stdout)
        largest = validate_decomposition(bags, td_edges, edges, len(names), header)
        ids = {old: new for new, old in enumerate(sorted(bags), 1)}
        lines = [f"c vertex {i} {name}" for name, i in mapping.items()]
        lines += [f"s td {len(bags)} {largest} {len(names)}"]
        lines += [f"b {ids[bag]} " + " ".join(map(str, sorted(vertices))) for bag, vertices in sorted(bags.items())]
        lines += [f"{min(ids[a], ids[b])} {max(ids[a], ids[b])}" for a, b in sorted(td_edges)]
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text("\n".join(lines) + "\n", encoding="utf-8")
        result.update(width_status="ok", largest_bag_size=largest, decomposition_width=largest - 1)
    except subprocess.TimeoutExpired:
        result.update(width_status="timeout", width_error=f"exceeded {timeout:g} seconds")
    except (ValueError, OSError) as error:
        result.update(width_status="invalid_td" if isinstance(error, ValueError) and "HTD exited" not in str(error) else "error",
                      width_error=str(error))
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.with_suffix(".error.txt").write_text(str(error) + "\n" + output, encoding="utf-8")
    result["width_seconds"] = f"{time.monotonic() - start:.6f}"
    return result


def summarize(rows, output):
    grouped = defaultdict(list)
    for row in rows:
        grouped[(row["family"], row["generator_k"], row["generator_n"])].append(row)
    summaries = []
    for (family, k, n), group in sorted(grouped.items()):
        widths = [int(row["decomposition_width"]) for row in group if row["width_status"] == "ok"]
        summaries.append(dict(family=family, generator_k=k, generator_n=n, count=len(group),
                              arguments_min=min(row["argument_count"] for row in group),
                              arguments_max=max(row["argument_count"] for row in group),
                              attacks_mean=f"{sum(row['attack_count'] for row in group) / len(group):.3f}",
                              width_ok=len(widths), width_min=min(widths) if widths else "",
                              width_max=max(widths) if widths else ""))
    write_table(output / "analysis_summary.tsv", summaries)
    counts = Counter(row["width_status"] for row in rows)
    text = ["# Structural statistics", "", f"Instances inventoried: {len(rows)}.", "",
            "Graph: all declared arguments; an undirected edge for either attack direction.",
            "Reciprocal attacks are collapsed and self-attacks are omitted for width computation.",
            "Widths are validated decomposition upper bounds, not certified exact treewidth.", "",
            "Width status: " + ", ".join(f"{key}={value}" for key, value in sorted(counts.items())) + ".", "",
            "| Family | Instances | Arguments | Directed attacks | Weak components | Width range |",
            "| --- | ---: | --- | --- | --- | --- |"]
    for family in sorted({row["family"] for row in rows}):
        group = [row for row in rows if row["family"] == family]
        ranges = []
        for key in ("argument_count", "attack_count", "weak_component_count"):
            ranges.append(f"{min(row[key] for row in group)}--{max(row[key] for row in group)}")
        widths = [int(row["decomposition_width"]) for row in group if row["width_status"] == "ok"]
        text.append(f"| {family} | {len(group)} | " + " | ".join(ranges) + f" | {min(widths) if widths else 'pending'}--{max(widths) if widths else 'pending'} |")
    text += ["", "The complete measurements are in [analysis_instances.tsv](analysis_instances.tsv); grouped statistics are in [analysis_summary.tsv](analysis_summary.tsv).", ""]
    (output / "analysis_summary.md").write_text("\n".join(text), encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("collection", type=Path)
    parser.add_argument("--output", type=Path, required=True, help="new analysis directory")
    parser.add_argument("--htd", type=Path, help="HTD executable; omit for structural statistics only")
    parser.add_argument("--htd-args", default="", help="quoted arguments for stock HTD; custom research binary needs none")
    parser.add_argument("--timeout", type=float, default=60, help="wall-clock limit per instance")
    parser.add_argument("--limit", type=int, help="analyze a small prefix for a pilot")
    args = parser.parse_args()
    if args.timeout <= 0 or (args.limit is not None and args.limit < 1):
        parser.error("timeout and limit must be positive")
    paths = sorted((args.collection / "instances").rglob("*.lp"))
    if args.limit:
        paths = paths[:args.limit]
    if not paths:
        parser.error("no .lp instances found under collection/instances")
    if args.output.exists():
        parser.error("output already exists; choose a new analysis directory")
    program = args.htd.resolve() if args.htd else None
    if program is not None and not program.is_file():
        parser.error("HTD executable not found")
    extra_args = shlex.split(args.htd_args)
    args.output.mkdir(parents=True)
    rows = []
    for path in paths:
        arguments, attacks, candidate, query, pargs, patts, metadata = read_paf(path)
        adjacency = {a: set() for a in arguments}
        for a, b in attacks:
            if a != b:
                adjacency[a].add(b)
                adjacency[b].add(a)
        remaining, components = set(arguments), 0
        while remaining:
            remaining -= reachable(next(iter(remaining)), adjacency)
            components += 1
        relative = path.relative_to(args.collection)
        legacy_name = re.fullmatch(r"k(\d+)_n(\d+)_q[^_]+_(\d+)\.lp", path.name)
        k, n, replicate = (legacy_name.groups() if legacy_name else ("", "", ""))
        row = dict(instance_id=str(path.relative_to(args.collection / "instances").with_suffix("")),
                   instance_path=relative.as_posix(), family=relative.parts[1] if len(relative.parts) > 2 else "default",
                   instance_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                   generator=metadata.get("generator", "legacy_unrecorded"),
                   generator_k=metadata.get("k", k), generator_n=metadata.get("n", n),
                   replicate=metadata.get("replicate", replicate), seed=metadata.get("seed", ""),
                   edge_probability=metadata.get("edge_probability", ""),
                   argument_count=len(arguments), attack_count=len(attacks),
                   undirected_edge_count=sum(map(len, adjacency.values())) // 2,
                   self_attack_count=sum(a == b for a, b in attacks),
                   unattacked_argument_count=len(arguments - {b for _, b in attacks}),
                   isolated_argument_count=sum(not neighbors for neighbors in adjacency.values()),
                   weak_component_count=components, candidate_size=len(candidate),
                   query_argument=";".join(sorted(query)),
                   uncertain_argument_count=sum(p not in (0, 1) for p in pargs.values()),
                   uncertain_attack_count=sum(p not in (0, 1) for p in patts.values()),
                   width_status="not_run", largest_bag_size="", decomposition_width="",
                   width_kind="", width_seconds="", width_error="")
        if program:
            row.update(measure(arguments, attacks, program, extra_args, args.timeout,
                               args.output / "decompositions" / relative.relative_to("instances").with_suffix(".td")))
        rows.append(row)
        if len(rows) % 25 == 0:
            print(f"Analyzed {len(rows)}/{len(paths)}", flush=True)
    write_table(args.output / "analysis_instances.tsv", rows)
    summarize(rows, args.output)
    record = dict(command=sys.argv, python_version=sys.version,
                  script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  graph_definition="underlying_undirected_declared_attacks_v1",
                  htd_command=[str(program), *extra_args] if program else None,
                  htd_binary_sha256=hashlib.sha256(program.read_bytes()).hexdigest() if program else None,
                  timeout_seconds=args.timeout, instance_count=len(rows), limit=args.limit)
    (args.output / "analysis_settings.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {len(rows)} rows to {args.output}")


if __name__ == "__main__":
    main()
