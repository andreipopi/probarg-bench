#!/usr/bin/env python3
"""Plot size versus decomposition width, with circle area showing instance count."""

import argparse
from collections import Counter
import csv
from pathlib import Path


def count_width_positions(rows):
    return Counter((int(row["argument_count"]), int(row["decomposition_width"]))
                   for row in rows if row.get("decomposition_width", "") != ""
                   and row.get("width_status", "ok") == "ok")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("index", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--overwrite", action="store_true", help="replace an existing generated figure")
    args = parser.parse_args()
    with args.index.open(encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    if not rows:
        parser.error("index is empty")
    if args.output.exists() and not args.overwrite:
        parser.error("output already exists")
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        from matplotlib.ticker import MaxNLocator
    except ImportError:
        parser.error("plotting requires matplotlib; see scripts/README.md")
    fig, axis = plt.subplots(figsize=(9, 4.3), constrained_layout=True)
    families = sorted({row["family"] for row in rows})
    groups = {family: count_width_positions([row for row in rows if row["family"] == family])
              for family in families}
    maximum = max((count for group in groups.values() for count in group.values()), default=0)
    area_per_instance = 120 / maximum if maximum else 1
    for family in families:
        counts = groups[family]
        positions = sorted(counts)
        if positions:
            axis.scatter([point[0] for point in positions], [point[1] for point in positions],
                         s=[area_per_instance * counts[point] for point in positions],
                         alpha=0.65, edgecolors="#475569", linewidths=0.4, label=family)
    axis.set(xlabel="Arguments", ylabel="Decomposition width (upper bound)",
             title="PAF size and decomposition width")
    axis.yaxis.set_major_locator(MaxNLocator(integer=True))
    if not maximum:
        axis.text(0.5, 0.5, "Widths have not been measured", ha="center", transform=axis.transAxes)
    else:
        if len(families) > 1:
            axis.add_artist(axis.legend(title="Family", loc="upper left", frameon=False))
        legend_counts = sorted({1, (maximum + 1) // 2, maximum})
        handles = [axis.scatter([], [], s=area_per_instance * count, color="#64748b",
                                alpha=0.65, edgecolors="#475569", linewidths=0.4, label=str(count))
                   for count in legend_counts]
        axis.legend(handles=handles, title="Instances per point", loc="center left",
                    bbox_to_anchor=(1.02, 0.5), frameon=False, labelspacing=1.2)
    axis.grid(alpha=0.2)
    axis.set_axisbelow(True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, dpi=180)
    plt.close(fig)
    print(f"Wrote {args.output}")


if __name__ == "__main__":
    main()
