# ProbArgBench

ProbArgBench is an open benchmark collection for probabilistic argumentation.
It publishes graph instances in their native formats, the generators that
produce them, and reference labels produced by exact solvers.

The provided generators use the original code accompanying:

- **PAFs — [`PW24-generator.py`](generators/PW24-generator.py):**

  > Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
  > Probabilistic Argumentation under the Constellation Approach*. KR 2024.
  > [https://doi.org/10.24963/kr.2024/55](https://doi.org/10.24963/kr.2024/55)

- **PBAFs — [`PW25-generator.py`](generators/PW25-generator.py):**

  > Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
  > Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
  > [https://doi.org/10.1145/3672608.3707819](https://doi.org/10.1145/3672608.3707819)

The default settings reproduce the original generators; PW24 also offers a
100% grid-connection variant. [Source versions and checks](generators/originals/README.md)
are provided. Instances can be used with different semantics. Each set of
labels states its task and semantics.
Users choose their own training, validation and test splits.

## Repository layout

```text
datasets/     Instances, labels, measurements and dataset READMEs
generators/   Original generators with seeded batch runners
scripts/      Graph measurements, tables and plots
templates/    Dataset README template
evaluation/   Separate space for scoring model predictions
```

## Generating and measuring a PAF dataset

Run these commands from the repository root. This example produces 300 PAFs
with 4–120 arguments. If the pilot already exists, start at step 2.

### 1. Generate the instances

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-pilot-v1 \
  --k 2 3 4 5 6 \
  --n 2 3 5 10 15 20 \
  --replicates 10 \
  --seed 20261105
```

All `k, n` combinations are used: `5 * 6 * 10 = 300` instances, each with
`k * n` arguments. The default uses the original 75% grid-connection probability.
Use a new output directory; append `--dry-run` to preview the count.
See [generator options and formats](generators/README.md).

For the main dataset, use the [12,000-instance command with 100% grid connections](generators/README.md#main-dataset-100-grid-connections).

### 2. Compute graph statistics and decomposition widths

Set `HTD_BIN` to a compiled HTD executable for your computer:

```bash
HTD_BIN="/absolute/path/to/htd_main"

python3 scripts/paf_stats.py datasets/paf-pw24-pilot-v1 \
  --output datasets/paf-pw24-pilot-v1/analysis/htd-v1 \
  --htd "$HTD_BIN" \
  --timeout 60
```

Open `analysis/htd-v1/analysis_summary.md` afterward. The script saves graph
counts, validated decompositions and settings. Widths are upper bounds on
treewidth. Use a new analysis directory for each measurement run.
See [HTD options and output files](scripts/README.md), including stock HTD
arguments and counts without HTD.

### 3. Generate the tables and plot

Install Matplotlib once, or use an environment that already has it:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install matplotlib
```

```bash
.venv/bin/python scripts/paf_report.py datasets/paf-pw24-pilot-v1 \
  --analysis analysis/htd-v1 \
  --plot \
  --update-readme
```

This updates the dataset README with generator parameters, graph and candidate
sizes, and a size-versus-width plot. Circle area shows instance count. It can
be rerun without repeating measurements.

### 4. Compute the probability labels

Run solvers in an external project and import their result tables and settings.
The planned pilot labels are complete-extension probabilities. Keep results
for each task and semantics in separate label runs. See the
[expected solver outputs](datasets/README.md#adding-solver-answers).

For another dataset, change the parameters and dataset path throughout.
PBAF generation is available through `PW25-generator.py`; PBAF measurements
and reports still need to be added.

## Available datasets

| Dataset | Instances | Labels in this repo | Status |
| --- | ---: | --- | --- |
| [`paf-grid-journal-v1`](datasets/paf-grid-journal-v1/) | 528 | 448 grounded-extension probabilities | Imported journal instances; widths available |
| [`paf-pw24-pilot-v1`](datasets/paf-pw24-pilot-v1/) | 300 | Not yet imported | Seeded pilot; instances and widths available |

The 12,000-instance `paf-pw24-main-v1` dataset is planned and has not yet been generated.

See [dataset files and formats](datasets/README.md) for the directory structure.
Historical KR 2024 and SAC 2025 instance sets will be added separately.

## License and citation

Code and dataset licenses will be stated before the first release. Cite the
source paper listed in each dataset README.
