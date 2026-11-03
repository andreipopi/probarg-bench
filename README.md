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
docs/         Instructions for generating, measuring, and labeling datasets
templates/    A README template for new datasets
evaluation/   Separate space for scoring model predictions
```

## Generating a new PAF dataset

The [PAF guide](docs/paf-workflow.md) gives the commands for these steps:

1. Choose the graph sizes, number of instances, and seed.
2. Generate the `.lp` files.
3. Compute graph statistics and decomposition widths.
4. Generate the family/parameter table, structural coverage table, and plots
   in the dataset README.
5. Run the exact solvers and add their answers when ready.

A seed is a number used to initialize the generator's random choices. Using
the same seed, parameters, and generator version allows the instances to be
reproduced. The generator saves these settings automatically.

Each dataset has one README describing its families. A family groups instances
by their generation method or a shared setting, such as the probability of
selecting a grid edge.

For PBAFs, use `PW25-generator.py` as described in the
[generator instructions](generators/README.md). Its native format includes
support relations and scaled probabilities. The current graph-measurement
and report scripts support PAFs; their PBAF extension is still to be added.

## File formats

| Format | What it contains |
| --- | --- |
| `.lp` | The instance itself: arguments, attacks, probabilities and candidate set; PBAFs also have support relations. PAF files may include a separate query argument. |
| `.tsv` | TSV means tab-separated values: a plain-text table with columns separated by tabs. For example, `index.tsv` has one row per instance, while `families.tsv` lists generator parameters. These files can be opened in a text editor or spreadsheet program. |
| `.json` | A text file containing named settings. For example, `generation.json` saves the generation command, parameters, seed, and Python version. `run.json` saves the settings used to measure widths or compute labels. |

The scripts write these tables and settings files automatically. They keep
the information needed to repeat a computation and match an answer to the
correct instance.

The PAF generator also preserves the original integer-scaled solver inputs
under `instances_asp/`. These are alternate encodings of the same instances.

## Available datasets

| Dataset | Task | Instances | Solver answers | Status |
| --- | --- | ---: | ---: | --- |
| [`paf-grid-grounded-pext`](datasets/paf-grid-grounded-pext/) | Extension verification under grounded semantics | 528 | 448 | Draft; imported from existing experiments |

This dataset comes from the later PAF journal experiments. All 528 instances
have measured decomposition widths. The README explains the missing solver
answers and how the measurements were obtained.

The original KR 2024 and SAC 2025 instance sets will be added separately.
Their original solvers and experiment files are available in
[PAF-TD](https://github.com/andreipopi/paf-td) and
[PBAF-TD](https://github.com/andreipopi/pbaf-td).

Dataset releases are also planned for Hugging Face. GitHub holds the scripts,
documentation, and development history.

## License and citation

The code and dataset licenses will be stated before the first release. Each
dataset will also include the relevant research citations.
