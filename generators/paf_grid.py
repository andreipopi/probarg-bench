#!/usr/bin/env python3
"""Generate seeded independent PAFs using the journal grid construction.

Construction source: paf-ver-acc-journal-experiments,
699275f093cc4c68c688d93c8f3ac10635be3a30,
instance-generator/paf_grid_generator_stats.py. See generators/README.md.
"""

import argparse
import csv
from decimal import Decimal
import hashlib
import json
from pathlib import Path
import random
import sys


VERSION = "paf-grid-v1"


def probability(text):
    try:
        value = Decimal(text)
    except ArithmeticError as error:
        raise argparse.ArgumentTypeError("expected a decimal probability") from error
    if not value.is_finite() or not 0 <= value <= 1:
        raise argparse.ArgumentTypeError("probability must be between 0 and 1")
    return format(value.normalize(), "f")


def render(k, n, edge_probability, replicate, config, source_hash):
    parameters = dict(config, k=k, n=n, edge_probability=edge_probability,
                      replicate=replicate, generator=VERSION)
    encoded = json.dumps(parameters, sort_keys=True).encode()
    seed = int.from_bytes(hashlib.sha256(encoded).digest()[:8], "big")
    rng = random.Random(seed)
    arguments = [f"a{i}" for i in range(k * n)]
    grid = arguments.copy()
    rng.shuffle(grid)
    probabilities = [f"0.{i}" for i in range(1, 10)] + ["1"]
    weights = [10] * 9 + [float(config["certainty_weight"])]
    pargs, attacks, candidate = {}, [], []
    visited = set()
    for row in range(n):
        for col in range(k):
            source = grid[row * k + col]
            pargs[source] = rng.choices(probabilities, weights=weights)[0]
            if rng.random() < float(config["candidate_probability"]):
                candidate.append(source)
            for r, c in ((row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)):
                if not (0 <= r < n and 0 <= c < k):
                    continue
                target = grid[r * k + c]
                pair = tuple(sorted((source, target)))
                if pair in visited:
                    continue
                visited.add(pair)
                if rng.random() >= float(edge_probability):
                    continue
                direction = rng.choice(("forward", "backward", "both"))
                if direction in ("forward", "both"):
                    attacks.append((source, target, rng.choices(probabilities, weights=weights)[0]))
                if direction in ("backward", "both"):
                    attacks.append((target, source, rng.choices(probabilities, weights=weights)[0]))
    query = rng.choice(grid)
    metadata = dict(parameters, seed=seed, generator_sha256=source_hash)
    lines = [f"% probarg {key}={value}" for key, value in sorted(metadata.items())]
    lines += [f"arg({a})." for a in arguments]
    lines += [f"p({a},{pargs[a]})." for a in arguments]
    lines += [f"att({a},{b})." for a, b, _ in attacks]
    lines += [f"p({i},{a},{b},{p})." for i, (a, b, p) in enumerate(attacks)]
    lines += [f"extension({a})." for a in sorted(candidate)]
    lines += [f"in({query})."]
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True, help="new collection directory")
    parser.add_argument("--k", type=int, nargs="+", required=True)
    parser.add_argument("--n", type=int, nargs="+", required=True)
    parser.add_argument("--edge-probabilities", type=probability, nargs="+", default=["0.5", "0.75", "1"])
    parser.add_argument("--replicates", type=int, default=4)
    parser.add_argument("--seed", type=int, required=True, help="master seed; each instance gets a derived seed")
    parser.add_argument("--candidate-probability", type=probability, default="0.04")
    parser.add_argument("--certainty-weight", type=float, default=0.1,
                        help="sampling weight of probability 1; each uncertain value has weight 10")
    parser.add_argument("--dry-run", action="store_true", help="show planned count without writing")
    args = parser.parse_args()
    if min(args.k + args.n + [args.replicates]) < 1:
        parser.error("k, n, and replicates must be positive")
    if not 0 <= args.certainty_weight < float("inf"):
        parser.error("certainty weight must be finite and nonnegative")
    widths, heights, densities = sorted(set(args.k)), sorted(set(args.n)), sorted(set(args.edge_probabilities))
    count = len(widths) * len(heights) * len(densities) * args.replicates
    print(f"{count} PAFs; {min(widths) * min(heights)}--{max(widths) * max(heights)} arguments each")
    if args.dry_run:
        return
    if args.output.exists():
        parser.error("output already exists; choose a new collection directory")
    config = {"master_seed": args.seed, "candidate_probability": args.candidate_probability,
              "certainty_weight": args.certainty_weight}
    source_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    args.output.mkdir(parents=True)
    for density in densities:
        family = "grid_p" + density.replace(".", "p")
        folder = args.output / "instances" / family
        folder.mkdir(parents=True)
        for k in widths:
            for n in heights:
                for replicate in range(1, args.replicates + 1):
                    path = folder / f"k{k}_n{n}_r{replicate:04d}.lp"
                    path.write_text(render(k, n, density, replicate, config, source_hash), encoding="utf-8")
    record = dict(config, generator=VERSION, generator_sha256=source_hash,
                  python_version=sys.version, k=widths, n=heights,
                  edge_probabilities=densities, replicates=args.replicates,
                  command=sys.argv)
    (args.output / "generation.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    families = [dict(family="grid_p" + density.replace(".", "p"),
                     edge_probability=density, k_values=", ".join(map(str, widths)),
                     n_values=", ".join(map(str, heights)), replicates=args.replicates,
                     instance_count=len(widths) * len(heights) * args.replicates,
                     master_seed=args.seed, candidate_probability=args.candidate_probability,
                     certainty_weight=args.certainty_weight, generator=VERSION)
                for density in densities]
    with (args.output / "families.tsv").open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, list(families[0]), delimiter="\t", lineterminator="\n")
        writer.writeheader()
        writer.writerows(families)
    family_table = ["| Family | Grid-edge probability | k | n | Replicates | Instances | Master seed |",
                    "| --- | ---: | --- | --- | ---: | ---: | ---: |"]
    for family in families:
        percent = format((Decimal(family["edge_probability"]) * 100).normalize(), "f")
        family_table.append(f"| {family['family']} | {percent}% | {family['k_values']} | "
                            f"{family['n_values']} | {family['replicates']} | "
                            f"{family['instance_count']} | {family['master_seed']} |")
    readme = f"""# {args.output.name}

Independent PAFs generated by `{VERSION}` from shuffled grids.

- Instances: {count}
- Master seed: {args.seed}

Each PAF is native `.lp`. Its comments record its parameters, seed and
generator source hash. `generation.json` records this generation run.
`extension(...)` encodes a candidate set; `in(...)` encodes an acceptance query.
No solver labels have been computed yet. `families.tsv` records the family
parameters used to build the collection.

<!-- probarg-report:start -->
## Families and generator parameters

{chr(10).join(family_table)}

## Structural coverage

Measurements are pending. After running `scripts/paf_stats.py`, run
`scripts/paf_report.py` with `--plot --update-readme` to refresh these tables
and embed the coverage figure.
<!-- probarg-report:end -->

## Provenance

This is a new seeded implementation of the grid construction used by the PAF
journal experiments. It does not reproduce historical instance bytes. See
`generators/README.md` and `docs/paf-workflow.md` in ProbArgBench for the source
mapping, graph definition, labeling procedure and release checklist.

## License and citation

Fill in the dataset license and applicable publication citation before release.
"""
    (args.output / "README.md").write_text(readme, encoding="utf-8")


if __name__ == "__main__":
    main()
