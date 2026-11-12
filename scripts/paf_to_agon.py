#!/usr/bin/env python3
"""Convert a native decimal-probability PAF to an AgonProject JSON document."""

import argparse
from decimal import Decimal
import json
import math
from pathlib import Path
import re

from paf_stats import read_paf


def to_agon(path):
    arguments, attacks, candidate, query, pargs, patts, _ = read_paf(path)
    # AgonProject currently raises probabilities below 0.01 to 0.01 on import.
    if any(p < Decimal("0.01") for p in [*pargs.values(), *patts.values()]):
        raise ValueError("AgonProject clamps probabilities below 0.01; cannot preserve this PAF")

    def name_key(name):
        return [int(part) if part.isdigit() else part for part in re.split(r"(\d+)", name)]

    names = sorted(arguments, key=name_key)
    ids = {name: index for index, name in enumerate(names)}
    radius = max(140, 25 * len(names))
    nodes = {}
    for index, name in enumerate(names):
        angle = 2 * math.pi * index / len(names)
        nodes[str(index)] = {
            "name": name,
            "x": round(radius * math.cos(angle), 2),
            "y": round(radius * math.sin(angle), 2),
            "probability": float(pargs[name]),
        }

    return {
        "apiVersion": "probabilistic-argumentation-framework/v1",
        "name": path.stem,
        "description": (
            f"Source: {path.name}\n"
            f"Candidate extension: {{{', '.join(sorted(candidate, key=name_key))}}}\n"
            f"Query arguments: {{{', '.join(sorted(query, key=name_key))}}}\n"
            "Candidate and query are notes only; this document visualizes the PAF."
        ),
        "arguments": nodes,
        "attacks": [[ids[a], ids[b], float(patts[a, b])]
                    for a, b in sorted(attacks, key=lambda pair: (ids[pair[0]], ids[pair[1]]))],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="native .lp file from instances/")
    parser.add_argument("--output", "-o", type=Path, required=True, help="new AgonProject .json file")
    args = parser.parse_args()
    try:
        document = to_agon(args.input)
        with args.output.open("x", encoding="utf-8") as handle:
            json.dump(document, handle, indent=2, ensure_ascii=False, allow_nan=False)
            handle.write("\n")
    except (OSError, ValueError) as error:
        parser.exit(1, f"Error: {error}\n")
    print(f"Written: {args.output}")


if __name__ == "__main__":
    main()
