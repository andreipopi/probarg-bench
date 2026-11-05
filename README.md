# ProbArgBench

ProbArgBench is an open benchmark collection for probabilistic argumentation.
It publishes graph instances in their native formats, the generators that
produce them, and reference labels produced by exact solvers.

The provided generators retain the original functions from the code
accompanying these papers:

- **PAFs — [`PW24-generator.py`](generators/PW24-generator.py):**

  > Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
  > Probabilistic Argumentation under the Constellation Approach*. KR 2024.
  > [https://doi.org/10.24963/kr.2024/55](https://doi.org/10.24963/kr.2024/55)

- **PBAFs — [`PW25-generator.py`](generators/PW25-generator.py):**

  > Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
  > Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
  > [https://doi.org/10.1145/3672608.3707819](https://doi.org/10.1145/3672608.3707819)

Both scripts keep the original random choices, parameters, filenames and file
writers. Added code sets the seed and saves dataset information around those
functions. Unchanged source copies and comparisons are explained in
[generators/README.md](generators/README.md).

## Scope

Each dataset includes:

- PAF and PBAF instances in `.lp` format;
- answers computed by exact solvers, where available, with the task and
  semantics stated;
- graph statistics, such as the numbers of arguments and attacks, connected
  components, and measured decomposition widths;
- generation scripts and the settings used to produce the instances; and
- a README explaining how the instances were generated and which research
  papers and code they come from.

The solver answers are also called **labels**. When an answer is available as
an exact fraction, its numerator and denominator are kept alongside any
decimal representation.

Users choose their own training, validation, and test splits. Scripts for
scoring model predictions can be added separately under `evaluation/`.

## Repository layout

```text
datasets/     Instance files, solver answers, statistics, and dataset READMEs
generators/   Scripts for generating new instances
scripts/      Scripts for measuring graphs and producing tables and plots
templates/    A README template for new datasets
evaluation/   Separate space for scoring model predictions
```

## Generating and measuring a PAF dataset

This example generates 300 PAFs, measures their graphs and decomposition
widths, and adds tables and a plot to the dataset README. Run the commands
from the repository root. If you have already generated this pilot, start
at step 2.

The scripts perform each step and save its settings. You do not need to
count the graphs or edit the tables by hand.

### 1. Generate the instances

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-pilot-v1 \
  --k 2 3 4 5 6 \
  --n 2 3 5 10 15 20 \
  --replicates 10 \
  --seed 20261105
```

This uses every combination of the five `k` and six `n` values, with ten
instances per combination: `5 * 6 * 10 = 300`. Each PAF has `k * n`
arguments, giving 4–120 arguments in this example. The original generator's
fixed settings are used, including a 75% chance of an attack in at least one
direction between neighbouring grid vertices. There is currently no density
option on the command line.

The seed fixes the random choices. The runner calculates and saves a separate
seed for each instance. Repeating the command with the same code and Python
version reproduces the instances. Append `--dry-run` to preview the count.
The output directory must be new.

The files are saved under `instances/`; `instances_asp/` contains alternate
integer-scaled encodings of the same PAFs. The generator also writes the
dataset README, parameter table, settings and seeds. The `% probarg ...`
comments in each instance record its generation information. See the
[generator README](generators/README.md) for all options and source details.

### 2. Compute graph statistics and decomposition widths

Use a compiled HTD executable, such as the modified HTD used by the PAF
solvers. Set `HTD_BIN` to its location on your computer:

```bash
HTD_BIN="/absolute/path/to/htd_main"

python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/htd-v1 \
  --htd "$HTD_BIN" \
  --timeout 60
```

Replace the example HTD path before running this command. The script reads
all native instances, checks their facts and probabilities, counts their
arguments, attacks, connected components and candidate sizes, and calls HTD
for each graph. `--timeout 60` limits each HTD call to 60 seconds; it is
separate from any later probability-solver timeout.

The modified research HTD needs no extra arguments. For stock HTD, add
`--htd-args '--seed 1 --strategy min-fill --output td'` to the command.
See the [measurement instructions](scripts/README.md) for HTD details and
the option to compute counts without HTD.

Results are saved under `analysis/htd-v1/`:

| File | Contents |
| --- | --- |
| `analysis_instances.tsv` | One row per instance, with graph counts, decomposition width and measurement status. |
| `analysis_summary.tsv`, `analysis_summary.md` | Statistics grouped by family and grid parameters, and a readable summary. |
| `decompositions/` | The validated tree-decompositions, saved as `.td` files. |
| `analysis_settings.json` | The command, Python version, HTD executable hash and time limit. |

Check `analysis_summary.md` after the command finishes. `width_status=ok` in
`analysis_instances.tsv` means a valid decomposition was found. Timeouts and failures are recorded
with blank width values. The analysis output directory must be new; use a
name such as `analysis/htd-v2` for another measurement run.

The measured graph has an undirected edge for an attack in either direction.
Decomposition width is the largest bag size minus one. It is an upper bound
on treewidth; the script checks the decomposition but does not prove that
the width is optimal. The generator parameter `k` is not a measured width.

### 3. Generate the tables and plot

Plotting requires Matplotlib. Create a Python environment and install it once,
or use an existing environment that already has Matplotlib:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install matplotlib
```

Then run:

```bash
.venv/bin/python scripts/paf_report.py datasets/paf-pw24-pilot-v1 \
  --analysis analysis/htd-v1 \
  --plot \
  --update-readme
```

This reads the saved measurements and family parameters, checks the instance
counts and file hashes, and writes the family/parameter table, structural
coverage table and figure into the dataset README. The figure shows argument
count against decomposition width and directed attack count. It also saves
`analysis_report.md`, `analysis_coverage.tsv`, `analysis_coverage.png` and
`analysis_report_settings.json` under the analysis directory. This step can be
repeated without recomputing widths.

Each dataset has one README describing its families. A family groups instances
by their generation method or a shared setting, such as the probability of
selecting a grid edge.

### 4. Compute the probability labels

The preceding commands produce instances and structural measurements. Next,
run the appropriate exact probability solver with a stated task and semantics,
and save its answers under `labels/<solver-run>/`. Keep exact fractions when
available and record timeouts and errors with blank answers. See
[adding solver answers](datasets/README.md#adding-solver-answers) for the
expected files and settings.

The benchmark launcher and results exporter for the original solvers still
need to be connected; there is no labelling command in this walkthrough yet.

For another dataset, change the generator parameters and output directory,
and use that dataset directory in the measurement and report commands.
For PBAFs, use `PW25-generator.py` as described in the
[generator instructions](generators/README.md). The current graph-measurement
and report scripts support PAFs; PBAF support still needs to be added.

## File formats

| Format | What it contains |
| --- | --- |
| `.lp` | The instance itself: arguments, attacks, probabilities and candidate set; PBAFs also have support relations. PAF files may include a separate query argument. |
| `.tsv` | TSV means tab-separated values: a plain-text table with columns separated by tabs. For example, `analysis_instances.tsv` has one row per instance, while `families_parameters.tsv` lists generator parameters. These files can be opened in a text editor or spreadsheet program. |
| `.json` | A text file containing named settings. For example, `generation_settings.json` saves the generation command, parameters, seed, and Python version. Graph measurements use `analysis_settings.json`; solver runs will use `labels_settings.json`. |

The scripts write these tables and settings files automatically. They keep
the information needed to repeat a computation and match an answer to the
correct instance.

The PAF generator also preserves the original integer-scaled solver inputs
under `instances_asp/`. These are alternate encodings of the same instances.

## Available datasets

| Dataset | Task | Instances | Solver answers | Status |
| --- | --- | ---: | ---: | --- |
| [`paf-grid-grounded-pext`](datasets/paf-grid-grounded-pext/) | Extension verification under grounded semantics | 528 | 448 | Draft; imported from existing experiments |
| [`paf-pw24-pilot-v1`](datasets/paf-pw24-pilot-v1/) | Labels pending | 300 | 0 | Pilot generated with the KR 2024 generator and recorded seeds |

The imported dataset comes from the later PAF journal experiments. All 528 instances
have measured decomposition widths. The README explains the missing solver
answers and how the measurements were obtained.

The historical KR 2024 and SAC 2025 instance sets will be added separately.
Their original solvers and experiment files are available in
[PAF-TD](https://github.com/andreipopi/paf-td) and
[PBAF-TD](https://github.com/andreipopi/pbaf-td).

Dataset releases are also planned for Hugging Face. GitHub holds the scripts,
documentation, and development history.

## License and citation

The code and dataset licenses will be stated before the first release. Each
dataset will also include the relevant research citations.
