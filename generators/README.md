# Instance generators

The defaults reproduce the original generators. PW24 also provides a full-grid
option. The runner sets seeds, generates every parameter combination and records the settings.
See [source versions and checks](originals/README.md) and the
[complete workflow](../README.md#generating-and-measuring-a-paf-dataset).

## PAFs: PW24

[`PW24-generator.py`](PW24-generator.py) uses the original dense-grid generator
from:

> Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
> Probabilistic Argumentation under the Constellation Approach*. KR 2024.
> [Published paper](https://doi.org/10.24963/kr.2024/55).

For each grid-neighbour pair, no attack, a forward attack, a reverse attack
or both are chosen with probability 0.25 each. Candidate inclusion probability
is 0.04. Probabilities
0.1–0.9 each have sampling weight 10; probability 1 has weight 0.1.
The default is unchanged. With `--connection-probability 1`, the no-attack
choice is removed: forward, reverse and bidirectional attacks each have
probability 1/3. Every neighbouring grid pair is then connected. This concerns
the declared attack graph; attack existence probabilities remain unchanged.

## PBAFs: PW25

[`PW25-generator.py`](PW25-generator.py) uses the original generator from:

> Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
> Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
> [Published paper](https://doi.org/10.1145/3672608.3707819).

It retains the original attack/support selection weights (0.9/0.1), four-way
direction selection, probability weights and candidate selection.

## Running the generators

Run from the repository root. For the 300-instance PAF pilot:

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-pilot-v1 \
  --k 2 3 4 5 6 \
  --n 2 3 5 10 15 20 \
  --replicates 10 \
  --seed 20261105
```

| Option | Meaning |
| --- | --- |
| `--output` | New dataset directory; existing directories are refused. |
| `--k`, `--n` | Lists of grid dimensions; every listed `k` is paired with every listed `n`. Each PAF has `k × n` arguments. |
| `--replicates` | Number of separately seeded instances generated for each `(k, n)` pair; default 4. |
| `--seed` | Master seed. |
| `--connection-probability` | PW24 only: `0.75` (original default) or `1` (every neighbouring grid pair connected). |
| `--dry-run` | Preview the instance count without writing files. |

The example lists 5 values for `k` and 6 for `n`, giving 30 `(k, n)` pairs.
With 10 replicates for each pair, it creates `30 × 10 = 300` files. Each file
has `k × n` arguments, between 4 and 120 in this example. Every file gets its
own seed, so adding more combinations preserves existing instances.
Reproduction requires the same code and Python version.

### Main dataset: 100% grid connections

This command lists 5 values for `k` and 6 for `n`: `5 × 6 = 30` parameter
pairs. It produces 400 instances for every pair, so `30 × 400 = 12,000` PAFs
in total. Each PAF has 4–120 arguments. Run it yourself from the repository root:

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-main-v1 \
  --k 2 3 4 5 6 \
  --n 2 3 5 10 15 20 \
  --replicates 400 \
  --seed 20261106 \
  --connection-probability 1
```

The output family is `grid_100`, with generator ID `PW24-full-grid-v1`.
It uses separate instance seeds from the original 75% variant. This is a
new variant of the publication's generator, not the original KR 2024 setting.
Then follow the [measurement and reporting steps](../README.md#2-compute-graph-statistics-and-decomposition-widths)
using `datasets/paf-pw24-main-v1` as the dataset path.

### Large extension

The second part lists 9 values for `k` and 4 for `n`: `9 × 4 = 36` parameter
pairs. It produces 400 instances for every pair, so `36 × 400 = 14,400` PAFs
in total. Each PAF has 50–1,000 arguments. These parameter pairs extend the
main set beyond `n = 20`:

```bash
python3 generators/PW24-generator.py \
  --output datasets/paf-pw24-main-large-v1 \
  --k 2 3 4 5 6 7 8 9 10 \
  --n 25 50 75 100 \
  --replicates 400 \
  --seed 20261107 \
  --connection-probability 1
```

Both main parts are already generated. These commands record how to reproduce
them; existing output directories are refused.

### PBAFs

For PW25:

```bash
python3 generators/PW25-generator.py --output datasets/pbaf-pw25-v1 \
  --k 3 4 --n 5 10 --replicates 4 --seed 20261103
```

PW25 retains its original 75% connection setting and does not accept
`--connection-probability`.

## Formats and generation records

| Output | Format |
| --- | --- |
| PAF `instances/` | Decimal probabilities; `extension(...)` is the candidate, `query(...)` the acceptance query. |
| PAF `instances_asp/` | The same PAFs with probabilities scaled to integers out of 10000. |
| PBAF `instances/` | Includes `support(...)`; `in(...)` is the candidate; probabilities use integers 1–10 for 0.1–1.0. |

In PBAF filenames, `qa...` records the original unused query draw.
Current measurement scripts support PAFs.

[`dataset_support.py`](dataset_support.py) writes `generation_settings.json`,
`generation_instances.tsv`, `families_parameters.tsv` and the dataset README.
It prepends `% probarg ...` comments while preserving the original file body.

Original source copies are in [`originals/`](originals/). MIT notices are kept
in [LICENSE-PW24-source](LICENSE-PW24-source) and
[LICENSE-PW25-source](LICENSE-PW25-source). The
[historical journal generators](paf-grid-legacy/) are kept as source snapshots;
the current datasets use `PW24-generator.py`.

Tests compare original code, native output bytes and final random states
under the default settings, and check that full grids contain every neighbour pair:

```bash
python3 -m unittest discover -s tests -v
```
