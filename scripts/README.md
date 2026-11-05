# Graph statistics, tables and plots

These scripts support PAFs. See the [complete workflow](../README.md#generating-and-measuring-a-paf-dataset)
for generation and environment setup. Run commands from the repository root.

## Measure the graphs

Requires Python 3 and a compiled HTD executable for your computer. Use the
modified HTD from the solver repositories or [stock HTD](https://github.com/mabseher/htd).
Replace the example executable path:

```bash
HTD_BIN="/absolute/path/to/htd_main"

python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/htd-v1 \
  --htd "$HTD_BIN" \
  --timeout 60
```

The script reads `instances/`, counts graph properties and candidate sizes,
and computes and checks decompositions. The timeout applies per HTD call.

- Stock HTD needs `--htd-args '--seed 1 --strategy min-fill --output td'`;
  the modified research HTD needs no extra arguments.
- Add `--limit 12` for a small trial.
- Use a new output directory for each run, such as `analysis/htd-v2`.

For counts without HTD:

```bash
python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/structure-v1
```

| Output | Contents |
| --- | --- |
| `analysis_instances.tsv` | Per-instance counts, widths and statuses. |
| `analysis_summary.tsv`, `analysis_summary.md` | Grouped statistics and readable summary. |
| `analysis_settings.json` | Command, tool hashes and settings. |
| `decompositions/` | Validated `.td` files. |

Open `analysis_summary.md` after the run. Successful widths have status `ok`;
timeouts and failures have blank widths; counts-only runs use `not_run`.

Width computation uses all arguments and an undirected edge for either attack
direction, combining reciprocal attacks and omitting self-attacks. The script
checks the bag tree, vertex and edge coverage, and running intersection.
Widths are largest bag size minus one: validated upper bounds on treewidth,
without an optimality proof. Generator `k` is a separate parameter.

## Generate tables and plots

Requires Matplotlib for `--plot`:

```bash
.venv/bin/python scripts/paf_report.py datasets/paf-pw24-pilot-v1 \
  --analysis analysis/htd-v1 --plot --update-readme
```

The report reads family parameters and measurements, checks counts and file
hashes, and updates the marked section of the dataset README. It writes:

- `analysis_report.md` and `analysis_coverage.tsv`: tables;
- `analysis_coverage.png`: argument count against width and directed attacks;
- `analysis_report_settings.json`: report command and input hashes.

Rerun this command to refresh reports without recomputing widths. Omit
`--update-readme` to save reports only. For tables without a plot, omit
`--plot` and use `python3`. The plotting script, `plot_paf_stats.py`, can also
be called separately; `--overwrite` replaces an existing figure.
