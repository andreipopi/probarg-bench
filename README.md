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

The terminology follows Definitions 1–3 and 6–7 of the
[KR 2024 paper](https://doi.org/10.24963/kr.2024/55).

### Argumentation frameworks and semantics

An **argumentation framework (AF)** is a pair $F=(A,R)$, where $A$ is a finite
set of arguments and $R\subseteq A\times A$ is the attack relation. An
argumentation semantics $\sigma$ assigns to $F$ a collection of extensions
$\sigma(F)\subseteq 2^A$.

For a set $S\subseteq A$:

- **Conflict-free:** no arguments $a,b\in S$ satisfy $(a,b)\in R$.
- **Defense:** $S$ defends $a$ if every attacker $b$ of $a$ is itself attacked
  by some $c\in S$.
- **Complete:** $S$ is conflict-free, defends every argument in $S$, and
  contains every argument it defends.
- **Grounded:** $S$ is complete and no strict subset of $S$ is complete. Every
  AF has a unique grounded extension.

### Probabilistic argumentation

A **probabilistic argumentation framework (PAF)** is a triple
$\mathcal{P}=(A,R,P)$, where $(A,R)$ is an AF and $P$ is a probability
distribution over its subframeworks. A subframework $F'=(A',R')$ has
$A'\subseteq A$ and $R'\subseteq R\cap(A'\times A')$; the set of all such
subframeworks is denoted by $\mathcal{F}(F)$. Under the independent constellation
model, $P$ is determined by independent marginal probabilities of arguments
and attacks. An attack can occur only when both of its endpoints are present.

### Probabilistic extension verification

Given a candidate set $S\subseteq A$ and a semantics $\sigma$, its probability
of being a $\sigma$-extension is

```math
P^{\mathrm{ext}}_{\sigma}(S)
= \sum_{\substack{F'\in\mathcal{F}(F) \\ S\in\sigma(F')}} P(F').
```

Thus, $P^{\mathrm{ext}}_{\sigma}(S)$ is the sum of the probabilities of
exactly those subframeworks in which $S$ is a $\sigma$-extension. The current
PW24 label run uses complete semantics and therefore records
$P^{\mathrm{ext}}_{\mathrm{com}}(S)$.

### Native encoding

| Fact | Meaning for this benchmark task |
| --- | --- |
| `extension(a).` | $a$ belongs to the candidate set $S$. |
| `query(a).` | Query for the separate probabilistic-acceptance task; ignored for extension verification. |

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
