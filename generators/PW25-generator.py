#!/usr/bin/env python3
"""Generate seeded PBAFs using the Popescu-Wallner SAC 2025 grid construction.

Paper: doi:10.1145/3672608.3707819.
Source: andreipopi/pbaf-td, commit 4526927ed60bad79087a883e6c73dd62efdadd57,
InstanceGenerator/pbaf_grid_generator.py. See LICENSE-PW25-source.
"""

import argparse
import csv
from decimal import Decimal
import hashlib
import json
from pathlib import Path
import random
import sys


VERSION = "pbaf-grid-v1"
SOURCE_COMMIT = "4526927ed60bad79087a883e6c73dd62efdadd57"


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
    probabilities = list(range(1, 11))
    weights = [10] * 9 + [float(config["certainty_weight"])]
    pargs, relations, candidate = {}, [], []
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
                # Both directions of a grid pair share the same relation type.
                kind = "support" if rng.random() < float(config["support_probability"]) else "att"
                if rng.random() >= float(edge_probability):
                    continue
                direction = rng.choice(("forward", "backward", "both"))
                if direction in ("forward", "both"):
                    relations.append((kind, source, target, rng.choices(probabilities, weights=weights)[0]))
                if direction in ("backward", "both"):
                    relations.append((kind, target, source, rng.choices(probabilities, weights=weights)[0]))
    metadata = dict(parameters, seed=seed, generator_sha256=source_hash,
                    formalism="PBAF", probability_scale=10, source_commit=SOURCE_COMMIT)
    lines = [f"% probarg {key}={value}" for key, value in sorted(metadata.items())]
    lines += [f"arg({a})." for a in arguments]
    lines += [f"p({a},{pargs[a]})." for a in arguments]
    lines += [f"{kind}({a},{b})." for kind, a, b, _ in relations]
    lines += [f"p({i},{a},{b},{p})." for i, (_, a, b, p) in enumerate(relations)]
    lines += [f"in({a})." for a in sorted(candidate)]
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True, help="new dataset directory")
    parser.add_argument("--k", type=int, nargs="+", required=True)
    parser.add_argument("--n", type=int, nargs="+", required=True)
    parser.add_argument("--edge-probabilities", type=probability, nargs="+", default=["0.75"])
    parser.add_argument("--support-probability", type=probability, default="0.1",
                        help="chance that a selected grid pair is a support rather than an attack")
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
    print(f"{count} PBAFs; {min(widths) * min(heights)}--{max(widths) * max(heights)} arguments each")
    if args.dry_run:
        return
    if args.output.exists():
        parser.error("output already exists; choose a new dataset directory")
    config = {"master_seed": args.seed, "candidate_probability": args.candidate_probability,
              "certainty_weight": args.certainty_weight, "support_probability": args.support_probability}
    source_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    args.output.mkdir(parents=True)
    for density in densities:
        family = "pbaf_grid_p" + density.replace(".", "p") + "_s" + args.support_probability.replace(".", "p")
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
                  formalism="PBAF", probability_scale=10, source_commit=SOURCE_COMMIT,
                  source_doi="10.1145/3672608.3707819", command=sys.argv)
    (args.output / "generation.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    families = [dict(family="pbaf_grid_p" + density.replace(".", "p") + "_s" + args.support_probability.replace(".", "p"),
                     edge_probability=density, k_values=", ".join(map(str, widths)),
                     n_values=", ".join(map(str, heights)), replicates=args.replicates,
                     instance_count=len(widths) * len(heights) * args.replicates,
                     master_seed=args.seed, candidate_probability=args.candidate_probability,
                     certainty_weight=args.certainty_weight, generator=VERSION,
                     support_probability=args.support_probability)
                for density in densities]
    with (args.output / "families.tsv").open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, list(families[0]), delimiter="\t", lineterminator="\n")
        writer.writeheader()
        writer.writerows(families)
    family_table = ["| Family | Grid-edge probability | Support probability | k | n | Replicates | Instances | Master seed |",
                    "| --- | ---: | ---: | --- | --- | ---: | ---: | ---: |"]
    for family in families:
        percent = format((Decimal(family["edge_probability"]) * 100).normalize(), "f")
        family_table.append(f"| {family['family']} | {percent}% | {family['support_probability']} | {family['k_values']} | "
                            f"{family['n_values']} | {family['replicates']} | "
                            f"{family['instance_count']} | {family['master_seed']} |")
    readme = f"""# {args.output.name}

PBAFs generated by `PW25-generator.py` (`{VERSION}`) from shuffled grids.

- Instances: {count}
- Master seed: {args.seed}

Each PBAF is stored as `.lp`. Its comments record its parameters, seed and
generator source hash. `generation.json` saves this generation run's settings.
`support(...)` declares supports, and `in(...)` encodes the candidate set.
Probabilities are integers from 1 to 10: for example, 8 represents 0.8.
There is no separate acceptance-query argument.
No solver labels have been computed yet. `families.tsv` records the family
parameters used to build the dataset.

## Families and generator parameters

{chr(10).join(family_table)}

Support versus attack is chosen once per grid pair. A bidirectional pair has
the same relation type in both directions. Each logical probability 0.1–0.9
has sampling weight 10, while probability one has weight {args.certainty_weight}.
Candidate inclusion probability is {args.candidate_probability}.

## Structural coverage

Measurements are pending. The current `paf_stats.py` and `paf_report.py`
workflow supports PAF datasets. PBAF support relations and probability scaling
must be added to that workflow before using it with these instances.

## Source paper and code

Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
[Published paper](https://doi.org/10.1145/3672608.3707819).

Adapted from `pbaf-td/InstanceGenerator/pbaf_grid_generator.py` at commit
`{SOURCE_COMMIT}`. This version adds explicit seeds, output paths and
parameters, and generates new instances rather than recreating historical files.

## License and citation

The source code's MIT notice is kept in `generators/LICENSE-PW25-source` in
ProbArgBench. Choose the dataset license before publication and cite SAC 2025.
"""
    (args.output / "README.md").write_text(readme, encoding="utf-8")


if __name__ == "__main__":
    main()
