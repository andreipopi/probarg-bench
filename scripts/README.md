# Graph statistics, tables and plots

These scripts currently support PAF datasets. PBAF support relations and
probability scaling still need to be added. Run the commands from the
repository root after [generating a dataset](../generators/README.md).

For a complete example starting with generation of the 300-instance pilot,
see the [main README walkthrough](../README.md#generating-and-measuring-a-paf-dataset).
If you have already generated that pilot, the next command is the measurement
command below.

| Script | Purpose |
| --- | --- |
| `paf_stats.py` | Read native PAFs, compute graph counts, call HTD when requested, and check and save its decompositions. |
| `paf_report.py` | Read the saved measurements and generate the tables and plot in the dataset README. |
| `plot_paf_stats.py` | Generate the figure separately; also called automatically by `paf_report.py --plot`. |

## Measure the graphs

Python 3 is sufficient for the measurement script itself. Width computation
also needs a compiled HTD executable. Use the modified HTD from the original
solver repositories, or [stock HTD](https://github.com/mabseher/htd).
The executable must be built for the computer where it will run.

Set `HTD_BIN` to the executable's path on your computer, replacing the example
path below. Then compute counts and decomposition widths in one pass:

```bash
HTD_BIN="/absolute/path/to/htd_main"

python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/htd-v1 \
  --htd "$HTD_BIN" \
  --timeout 60
```

The script reads `instances/`. Counts include arguments, directed attacks,
undirected edges, connected components, candidate size, and uncertain arguments
and attacks. The original `.lp` files and generation information are preserved.
The 60-second timeout applies separately to each HTD call.

For counts without width computation, omit HTD and use a separate output
directory:

```bash
python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/structure-v1
```

The modified research HTD needs no extra arguments. For stock HTD, add
`--htd-args '--seed 1 --strategy min-fill --output td'`. Use `--limit 12` for
a small trial. Each measurement run needs a new output directory.

The script saves one row per PAF in `analysis_instances.tsv`, grouped statistics in
`analysis_summary.tsv`, a readable `analysis_summary.md`, and settings in `analysis_settings.json`. It saves
valid decompositions under `decompositions/`. Timeouts and failures remain in
the table with their status and no width value.

Open `analysis_summary.md` after the command finishes. The successful width status in
`analysis_instances.tsv` is `ok`; other statuses explain missing widths. The counts-only
command records width status `not_run`. For another HTD run, use a new output
directory such as `analysis/htd-v2`.

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
.venv/bin/python scripts/paf_report.py datasets/paf-pw24-pilot-v1 \
  --analysis analysis/htd-v1 --plot --update-readme
```

This reads `families_parameters.tsv` and the measurement index, checks the instance counts
and file hashes, and writes `analysis_report.md`, `analysis_coverage.tsv`, `analysis_report_settings.json` and
`analysis_coverage.png`. It replaces only the marked generated section of the README.
It can be rerun without repeating width measurements.

For tables only, omit `--plot` and use standard Python. Omit `--update-readme`
to save the report without changing the dataset README. Standalone plotting
is available through `plot_paf_stats.py`; use `--overwrite` when replacing an
existing figure.

The figure shows argument count against measured width and directed attack
count, with a separate color for each family. It describes the sizes and
structures present in the dataset.
