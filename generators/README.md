# Instance generators

These scripts start from the original generator files. Every original
function is unchanged, including the graph-generation functions and file
writers. The added runner sets a seed before calling them and saves the
outputs, tables and settings afterward.

Unchanged source files are kept in [`originals/`](originals/), with their
original filenames, commits and file hashes. See its
[README](originals/README.md) for the comparisons used to check this.

## PAFs: PW24

[`PW24-generator.py`](PW24-generator.py) contains the original dense grid
generator accompanying:

> Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
> Probabilistic Argumentation under the Constellation Approach*. KR 2024.
> [Published paper](https://doi.org/10.24963/kr.2024/55).

The original `directions` dictionary and `random.sample(range(1,5),1)` call
choose no edge, one direction, the other direction, or both, with equal
probability. The argument and attack probability weights and candidate
selection probability 0.04 are unchanged. No extra density, candidate or
probability-weight options are introduced.

The added runner accepts `--k`, `--n`, `--replicates`, `--seed` and `--output`.
Use `--dry-run` to preview the count. See the [PAF guide](../docs/paf-workflow.md).

Source: `paf-td/InstanceGenerator/praaf_grid_generator_dense.py`, commit
`df7961a39dc666610298d7d2539ee2a8da315508`. The source file's SHA-256 is
`54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38`.
Its MIT notice is kept in [LICENSE-PW24-source](LICENSE-PW24-source).

Both original output files are preserved: decimal probabilities under
`instances/` and probabilities scaled to integers out of 10000 under
`instances_asp/`. They encode the same PAFs and are not separate examples.
`extension(...)` is the candidate set and `query(...)` the query argument.
The original sparse long-range PAF generator and later journal density
variants are separate generators and are not folded into this script.

## PBAFs: PW25

[`PW25-generator.py`](PW25-generator.py) contains the original generator
accompanying:

> Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
> Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
> [Published paper](https://doi.org/10.1145/3672608.3707819).

Source: [`pbaf-td/InstanceGenerator/pbaf_grid_generator.py`](https://github.com/andreipopi/pbaf-td/blob/4526927ed60bad79087a883e6c73dd62efdadd57/InstanceGenerator/pbaf_grid_generator.py).
The source file's SHA-256 is
`202b4017aded0a0ecb03208d6f0bf68758d1b783d86e500a53904a7a42b3500f`.
Its MIT notice is retained in [LICENSE-PW25-source](LICENSE-PW25-source).

The original `random.choices([True, False], weights=[0.9, 0.1])` call chooses
attack or support. Its original four-way direction selection, probability
weights, candidate selection, and final unused query draw are unchanged.
The added runner has the same options as the PW24 runner.

```bash
python3 generators/PW25-generator.py --output datasets/pbaf-pw25-v1 \
  --k 3 4 --n 5 10 --replicates 4 --seed 20261103
```

The native PBAF format uses `support(...)` for supports, `in(...)` for the
candidate set, and integers 1–10 for probabilities 0.1–1.0. The PAF format
uses `extension(...)` for the candidate and `query(...)` for a separate query.
The imported journal PAF dataset uses `in(...)` for its query instead.

`paf_stats.py` and `paf_report.py` currently support PAFs. PBAF structural
measurements, report generation, and labels will be added separately.

## Added dataset code

[`dataset_support.py`](dataset_support.py) contains the added code. It calls
the original functions in the original order, in a temporary working folder
so their fixed output paths need no edits. Each instance gets a recorded seed.

The original file body is preserved byte-for-byte. Settings are prepended as
`% probarg ...` comments. `generation.tsv` records the seeds and hashes of both
the full files and their original bodies. `generation.json` saves the settings,
and `families.tsv` and the README contain the parameter table. Tables and plots
based on measured graph properties remain in the separate analysis scripts.

The tests run both unchanged originals with injected seeds and compare native
filenames, every output byte, and final random-generator states. They also
check that all original function source text is unchanged:

```bash
python3 -m unittest discover -s tests -v
```

## Historical journal generator copies

The [`paf-grid-legacy`](paf-grid-legacy/) directory contains the generator code
used for the imported journal dataset. These files and their dataset are kept
as they were; the original paper generators do not recreate those particular
instances without their missing historical seeds.

Both named generators write to a new dataset directory and refuse to overwrite
an existing dataset.
