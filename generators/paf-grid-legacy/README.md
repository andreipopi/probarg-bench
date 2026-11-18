# Legacy PAF grid generator snapshots

These files are preserved from `paf-ver-acc-journal-experiments` commit
`699275f093cc4c68c688d93c8f3ac10635be3a30` to document the historical
generator variants. The main and large datasets use `PW24-generator.py`.

These copies document the original generator settings:

- randomness is not seeded;
- output directories and density settings are hard-coded;
- the 50% and 75% families were produced by editing the density choice and
  output-directory settings in place; and
- `call_generator.py` launches the historical parameter grid but does not
  record seeds or a manifest.

`paf_grid_generator_stats.py` is the captured 50% configuration. Its comments
record the corresponding 75% choice. `praaf_grid_generator.py` is the captured
connected-grid variant, retained because it belongs to the same generator
lineage. The imported journal instance set is no longer included in ProbArgBench.

[`PW24-generator.py`](../PW24-generator.py) now contains the original KR 2024
dense generator with a seeded runner. Its default reproduces the original
75% connection setting; `--connection-probability 1` enables full grids.
The historical files here have no
recorded seeds, so those particular instances cannot be recreated from a seed.
