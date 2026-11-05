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

Original generation functions are unchanged. Added code sets seeds and records
settings; [source versions and checks](generators/originals/README.md) are provided.
Each dataset states its format, task, semantics and available labels.
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
`k * n` arguments. Attack sampling retains the original fixed settings.
Use a new output directory; append `--dry-run` to preview the count.
See [generator options and formats](generators/README.md).

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

This updates the dataset README with family parameters, structural coverage
and a figure of graph sizes, attack counts and widths. It can be rerun
without repeating measurements.

### 4. Compute the probability labels

The pilot will use complete-extension probabilities; grounded-extension labels
can be added in a separate solver run. The batch solver launcher and result
exporter still need to be connected. See [label files and settings](datasets/README.md#adding-solver-answers).

For another dataset, change the parameters and dataset path throughout.
PBAF generation is available through `PW25-generator.py`; PBAF measurements
and reports still need to be added.

## Available datasets

| Dataset | Task | Instances | Labels | Status |
| --- | --- | ---: | ---: | --- |
| [`paf-grid-grounded-pext`](datasets/paf-grid-grounded-pext/) | Grounded-extension verification | 528 | 448 | Imported journal experiments; widths available |
| [`paf-pw24-pilot-v1`](datasets/paf-pw24-pilot-v1/) | Complete-extension verification | 300 | 0 | New pilot; instances and widths available |

See [dataset files and formats](datasets/README.md) for the directory structure.
Historical KR 2024 and SAC 2025 instance sets will be added separately.

## License and citation

Code and dataset licenses will be stated before the first release. Cite the
source paper listed in each dataset README.
