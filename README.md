# ProbArgBench

ProbArgBench is an open benchmark collection for probabilistic argumentation.
It publishes graph instances in their native formats and the generators that
produce them. Reference labels from exact solvers are stored with a dataset
when they are available.

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

## Benchmark task

An abstract argumentation framework is a directed graph `F = (A, R)` of
arguments and attacks. An argumentation semantics `sigma` assigns a collection
of extensions to each framework.

In a probabilistic argumentation framework (PAF) under the independent
constellation model, arguments and attacks have existence probabilities. A
possible framework `F'` is obtained by sampling arguments independently and
then sampling, also independently, the attacks whose endpoints are present.
Probabilistic extension verification asks,
for a candidate set `S`, for

```text
PEXT_sigma(P, S) = sum over F' of Pr(F') * 1[S is a sigma-extension of F'].
```

Under complete semantics, an extension is conflict-free, defends all its
members, and contains every argument it defends. The grounded extension is the
unique complete extension that is least under set inclusion. The current PW24
label run uses complete semantics.
In the native files, `extension(a).` identifies members of `S`. The separate
`query(a).` fact belongs to an acceptance task and is not used for extension
verification. Exact labels are probabilities between zero and one.

## Repository layout

```text
datasets/     Instances, labels, measurements and dataset READMEs
generators/   Original generators with seeded batch runners
scripts/      Label import, graph measurements, tables and plots
templates/    Dataset README template
evaluation/   Separate space for scoring model predictions
```

## Generating and measuring a PAF dataset

The instances are already included. These commands document generation and
analysis; use a new output directory when generating another dataset.
Run them from the repository root.

### 1. Generate the instances

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-pilot-v1 \
  --k 2 3 4 5 6 \
  --n 2 3 5 10 15 20 \
  --replicates 10 \
  --seed 20261105
```

The command lists 5 values for `k` and 6 values for `n`, giving 30 `(k, n)`
combinations. It generates 10 separately seeded instances for each combination:
`30 × 10 = 300` files in total. An individual instance has `k × n` arguments,
from `2 × 2 = 4` to `6 × 20 = 120`. The default uses the original 75%
grid-connection probability.
Use a new output directory; append `--dry-run` to preview the count.
See [generator options and formats](generators/README.md).

For the main dataset, use the [12,000-instance command with 100% grid connections](generators/README.md#main-dataset-100-grid-connections).
The [large extension](generators/README.md#large-extension) contains instances
with up to 1,000 arguments.

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

### 4. Import exact-solver labels

The solvers and their raw logs stay in the algorithms project. Import a run
with `scripts/import_solver_logs.py`; the command and output format are
documented in [scripts/README.md](scripts/README.md#import-exact-solver-results).
The importer matches every log to an instance hash and checks saved tree
decompositions before accepting their widths.

For another dataset, change the parameters and dataset path throughout.
PBAF generation is available through `PW25-generator.py`; PBAF measurements
and reports still need to be added.

## Available datasets

| Dataset | Instances | Arguments | Grid connections | Label run |
| --- | ---: | --- | --- | --- |
| [`paf-pw24-pilot-v1`](datasets/paf-pw24-pilot-v1/) | 300 | 4–120 | 75% | 300 complete-extension probabilities |
| [`paf-pw24-main-v1`](datasets/paf-pw24-main-v1/) | 12,000 | 4–120 | 100% | 7,202 complete-extension probabilities |
| [`paf-pw24-main-large-v1`](datasets/paf-pw24-main-large-v1/) | 9,541 | 50–1,000 | 100% | Labelling in progress externally |
| [`paf-pw24-main-large-unlabelled-v1`](datasets/paf-pw24-main-large-unlabelled-v1/) | 4,859 | 50–1,000 | 100% | Unlabelled after solver cutoff |

See [dataset files and formats](datasets/README.md) for the directory structure.

## Visualize a PAF

You can visualize and edit a PAF in [AgonProject](https://agonproject.aig.fernuni-hagen.de/),
a web tool from the Artificial Intelligence Group at FernUniversität in Hagen.
It also offers random framework generation. Convert a native `.lp` instance to
its JSON format, then open that file in AgonProject. See the
[converter command and import steps](scripts/README.md#visualize-a-paf-in-agonproject).

Reference: Lars Bengel, Matti Berthold, Oleksandr Dzhychko, and Matthias Thimm.
*AgonProject: An Online Platform for Exploring Approaches to Formal Argumentation*.
SAFA 2026, CEUR Workshop Proceedings 4262, pp. 2–12.
[Paper](https://ceur-ws.org/Vol-4262/paper1.pdf) ·
[Source code](https://github.com/aig-hagen/AgonProject).

## License and citation

Code and dataset licenses will be stated before the first release. Cite the
source paper listed in each dataset README.
