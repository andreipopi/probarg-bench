# Dataset collections

Each collection belongs in its own directory:

```text
datasets/<collection-name>/
├── README.md
├── instances/
└── index.tsv
```

The native instance files are authoritative. `index.tsv` associates stable
instance identifiers and paths with reference labels, generator parameters,
and structural metadata that are not naturally represented in the instance
file.

Collections are not required to define machine-learning train, validation, or
test splits.

An index must distinguish a usable result from a timeout, invalid tree
decomposition, or other failed run. When a solver emitted an exact rational,
the numerator and denominator should be retained rather than only a rounded
decimal rendering.

Current collection:

- [`paf-grid-grounded-pext`](paf-grid-grounded-pext/): 528 native PAFs and 448
  usable grounded-extension-verification labels.
