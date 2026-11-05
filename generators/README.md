# Instance generators

The original generation functions and writers are unchanged. The added runner
sets seeds, generates every parameter combination and records the settings.
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
These settings are fixed in the original code; there is no density option.

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
| `--k`, `--n` | Grid dimensions; each PAF has `k * n` arguments. |
| `--replicates` | Instances per parameter pair; default 4. |
| `--seed` | Master seed. |
| `--dry-run` | Preview the instance count without writing files. |

The example uses `5 * 6 * 10 = 300` instances. Each parameter pair and replicate
gets its own seed, so adding more combinations preserves existing instances.
Reproduction requires the same code and Python version.

PW25 accepts the same options:

```bash
python3 generators/PW25-generator.py --output datasets/pbaf-pw25-v1 \
  --k 3 4 --n 5 10 --replicates 4 --seed 20261103
```

## Formats and generation records

| Output | Format |
| --- | --- |
| PAF `instances/` | Decimal probabilities; `extension(...)` is the candidate, `query(...)` the acceptance query. |
| PAF `instances_asp/` | The same PAFs with probabilities scaled to integers out of 10000. |
| PBAF `instances/` | Includes `support(...)`; `in(...)` is the candidate; probabilities use integers 1–10 for 0.1–1.0. |

In PBAF filenames, `qa...` records the original unused query draw. Imported
journal PAFs use `in(...)` for their acceptance query; see their dataset README.
Current measurement scripts support PAFs.

[`dataset_support.py`](dataset_support.py) writes `generation_settings.json`,
`generation_instances.tsv`, `families_parameters.tsv` and the dataset README.
It prepends `% probarg ...` comments while preserving the original file body.

Original source copies are in [`originals/`](originals/). MIT notices are kept
in [LICENSE-PW24-source](LICENSE-PW24-source) and
[LICENSE-PW25-source](LICENSE-PW25-source). The
[historical journal generators](paf-grid-legacy/) are separate copies whose
original seeds are unavailable.

Tests compare original function source, native output bytes and final random
states:

```bash
python3 -m unittest discover -s tests -v
```
