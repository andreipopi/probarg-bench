#!/usr/bin/env python3
"""Plot size versus decomposition width from a PAF index (requires matplotlib)."""

import argparse
import csv
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("index", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    with args.index.open(encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    if not rows:
        parser.error("index is empty")
    if args.output.exists():
        parser.error("output already exists")
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        from matplotlib.ticker import MaxNLocator
    except ImportError:
        parser.error("plotting requires matplotlib; see docs/paf-workflow.md")
    fig, axes = plt.subplots(1, 2, figsize=(11, 4), constrained_layout=True)
    families = sorted({row["family"] for row in rows})
    measured = 0
    for family in families:
        group = [row for row in rows if row["family"] == family]
        widths = [row for row in group if row.get("decomposition_width", "") != ""
                  and row.get("width_status", "ok") == "ok"]
        measured += len(widths)
        axes[0].scatter([int(row["argument_count"]) for row in widths],
                        [int(row["decomposition_width"]) for row in widths],
                        s=17, alpha=0.55, label=f"{family} ({len(widths)})")
        axes[1].scatter([int(row["argument_count"]) for row in group],
                        [int(row["attack_count"]) for row in group],
                        s=17, alpha=0.4, label=family)
    axes[0].set(xlabel="Arguments", ylabel="Decomposition width (upper bound)",
                title=f"Measured widths: {measured}/{len(rows)} instances")
    axes[1].set(xlabel="Arguments", ylabel="Directed attacks", title="Graph size coverage")
    axes[0].yaxis.set_major_locator(MaxNLocator(integer=True))
    if measured == 0:
        axes[0].text(0.5, 0.5, "Widths have not been measured", ha="center", transform=axes[0].transAxes)
    for axis in axes:
        axis.grid(alpha=0.2)
        axis.set_axisbelow(True)
        axis.legend(fontsize=8)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, dpi=180)
    plt.close(fig)
    print(f"Wrote {args.output}")


if __name__ == "__main__":
    main()
