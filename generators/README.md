# Instance generators

Each generator documents its parameters, required software, output format,
source paper and code, and how it uses random seeds.

## PAFs: PW24

[`PW24-generator.py`](PW24-generator.py) is based on the grid generator
accompanying:

> Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
> Probabilistic Argumentation under the Constellation Approach*. KR 2024.
> [Published paper](https://doi.org/10.24963/kr.2024/55).

It accepts `k`,
`n`, grid-edge probability, replicate count, master seed, candidate inclusion
probability and the sampling weight of probability one. It writes native
`.lp` files and saves the generation settings in `generation.json`. Use
`--dry-run` to see how many instances a command would generate without writing
them. See the [PAF guide](../docs/paf-workflow.md) for commands.

A seed is required. Every `.lp` records the master and derived instance seeds.
The generator also writes `families.tsv` and the README's family/parameter
table. `scripts/paf_report.py` combines those parameters with measured
statistics to refresh both README tables and the coverage plot.

This version uses the adjacent-grid construction in
`paf-td/InstanceGenerator/praaf_grid_generator_dense.py`. Its configurable
density options also cover the later journal variants in
`paf-ver-acc-journal-experiments` commit
`699275f093cc4c68c688d93c8f3ac10635be3a30`, specifically
`instance-generator/paf_grid_generator_stats.py`. It adds explicit seeds and
output paths and produces new instances rather than recreating historical
files byte-for-byte. The original sparse long-range construction is not yet
implemented here.

## PBAFs: PW25

[`PW25-generator.py`](PW25-generator.py) is adapted from the generator
accompanying:

> Andrei Popescu and Johannes P. Wallner. *Dynamic Programming Algorithms for
> Probabilistic Bipolar Argumentation Frameworks*. SAC 2025, pp. 1051–1052.
> [Published paper](https://doi.org/10.1145/3672608.3707819).

Source: [`pbaf-td/InstanceGenerator/pbaf_grid_generator.py`](https://github.com/andreipopi/pbaf-td/blob/4526927ed60bad79087a883e6c73dd62efdadd57/InstanceGenerator/pbaf_grid_generator.py).
The source file's SHA-256 is
`202b4017aded0a0ecb03208d6f0bf68758d1b783d86e500a53904a7a42b3500f`.
Its MIT notice is retained in [LICENSE-PW25-source](LICENSE-PW25-source).

The defaults retain 75% of neighboring grid pairs and choose support rather
than attack with probability 0.1. For a retained pair, either direction or
both directions are equally likely. Both directions of a pair use the same
relation type. The generator adds seed and output-path options and writes a
README, `families.tsv`, and `generation.json`.

```bash
python3 generators/PW25-generator.py --output datasets/pbaf-pw25-v1 \
  --k 3 4 --n 5 10 --replicates 4 --seed 20261103
```

The PBAF format is the original solver format: `support(...)` declares
supports, `in(...)` specifies the candidate set, and integers 1–10 encode
probabilities 0.1–1.0. The PAF format instead uses `extension(...)` for its
candidate and `in(...)` for a separate acceptance query.

`paf_stats.py` and `paf_report.py` currently support PAFs. PBAF structural
measurements, report generation, and labels will be added separately.

## Historical generator copies

The [`paf-grid-legacy`](paf-grid-legacy/) directory contains copies of the
generator code used for the first imported PAF dataset. Those scripts have no
seed option and use fixed output directories. They are kept to document how
the historical instances were generated.

Both named generators write to a new dataset directory and refuse to overwrite an
existing dataset.
