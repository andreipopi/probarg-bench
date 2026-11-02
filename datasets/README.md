# Dataset collections

Each collection belongs in its own directory. For newly generated PAFs:

```text
datasets/<collection-name>/
├── README.md
├── generation.json
├── instances/
├── analysis/<measurement-run>/
│   ├── index.tsv
│   ├── summary.tsv
│   ├── summary.md
│   ├── run.json
│   └── decompositions/
└── labels/<solver-run>/
    ├── results.tsv
    └── run.json
```

The native instance files are authoritative. A structural `index.tsv`
associates stable instance identifiers and hashes with generator parameters
and graph measurements. Labels join to it by instance ID and SHA-256.
The existing imported collection retains its original combined `index.tsv`;
new measurements do not overwrite that historical index.

Collections are not required to define machine-learning train, validation, or
test splits.

An index must distinguish a usable result from a timeout, invalid tree
decomposition, or other failed run. When a solver emitted an exact rational,
the numerator and denominator should be retained rather than only a rounded
decimal rendering.

Use one collection README to explain all families and embed its generated
coverage plot. The [PAF workflow](../docs/paf-workflow.md) contains the commands,
metadata conventions and source-script audit; a [README template](../templates/paf-collection.md)
is available for new collections.

Current collection:

- [`paf-grid-grounded-pext`](paf-grid-grounded-pext/): 528 native PAFs and 448
  usable grounded-extension-verification labels.
