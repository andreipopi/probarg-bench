# Legacy PAF grid generator snapshots

These files are preserved from `paf-ver-acc-journal-experiments` commit
`699275f093cc4c68c688d93c8f3ac10635be3a30` because they document how the
instances in [`paf-grid-grounded-pext`](../../datasets/paf-grid-grounded-pext/)
were constructed.

They are provenance artifacts, not yet a polished generator API:

- randomness is not seeded;
- output directories and density settings are hard-coded;
- the 50% and 75% families were produced by editing the density choice and
  output-directory settings in place; and
- `call_generator.py` launches the historical parameter grid but does not
  record seeds or a manifest.

`paf_grid_generator_stats.py` is the captured 50% configuration. Its comments
record the corresponding 75% choice. `praaf_grid_generator.py` is the captured
connected-grid variant, retained because it belongs to the same generator
lineage; the connected family is not part of the current labeled collection.

A future curated generator should expose the family, `k`, `n`, replicate, and
seed explicitly and write an accompanying manifest. It must be introduced as a
new generator version rather than presented as capable of recreating the
historical files byte-for-byte.
