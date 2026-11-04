# Graph statistics, tables and plots

These scripts currently support PAF datasets. PBAF support relations and
probability scaling still need to be added. Run the commands from the
repository root after [generating a dataset](../generators/README.md).

## Measure the graphs

To compute counts and other graph statistics:

```bash
python3 scripts/paf_stats.py datasets/paf-pw24-v1 \
  --output datasets/paf-pw24-v1/analysis/structure-v1
```

To also compute decomposition widths, give the path to your HTD executable:

```bash
python3 scripts/paf_stats.py datasets/paf-pw24-v1 \
  --output datasets/paf-pw24-v1/analysis/htd-v1 \
  --htd /absolute/path/to/htd_main --timeout 60
```

The modified research HTD needs no extra arguments. For stock HTD, add
`--htd-args '--seed 1 --strategy min-fill --output td'`. Use `--limit 12` for
a small trial. Each measurement run needs a new output directory.

The script saves one row per PAF in `index.tsv`, grouped statistics in
`summary.tsv`, a readable `summary.md`, and settings in `run.json`. It saves
valid decompositions under `decompositions/`. Timeouts and failures remain in
the table with their status and no width value.

The measured graph contains all arguments and an undirected edge whenever an
attack is declared in either direction. Reciprocal attacks are combined;
self-attacks are omitted for width computation. The script checks the
decomposition's tree structure, vertex and edge coverage, and connectedness
of the bags containing each vertex.

Decomposition width is the largest bag size minus one. It is an upper bound
on treewidth; checking a decomposition does not prove that its width is optimal.

## Generate tables and plots

Plotting requires Matplotlib. If needed, create an environment and install it:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install matplotlib
```

Then rebuild both tables and the coverage figure in the dataset README:

```bash
.venv/bin/python scripts/paf_report.py datasets/paf-pw24-v1 \
  --analysis analysis/htd-v1 --plot --update-readme
```

This reads `families.tsv` and the measurement index, checks the instance counts
and file hashes, and writes `report.md`, `coverage.tsv`, `report.json` and
`coverage.png`. It replaces only the marked generated section of the README.
It can be rerun without repeating width measurements.

For tables only, omit `--plot` and use standard Python. Omit `--update-readme`
to save the report without changing the dataset README. Standalone plotting
is available through `plot_paf_stats.py`; use `--overwrite` when replacing an
existing figure.

The figure shows argument count against measured width and directed attack
count, with a separate color for each family. It describes the sizes and
structures present in the dataset.
