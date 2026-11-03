# Datasets

Each dataset has its own directory. For newly generated PAFs:

```text
datasets/<dataset-name>/
├── README.md
├── generation.json
├── families.tsv
├── instances/
├── analysis/<measurement-run>/
│   ├── index.tsv
│   ├── summary.tsv
│   ├── summary.md
│   ├── report.md
│   ├── coverage.tsv
│   ├── coverage.png
│   ├── run.json
│   └── decompositions/
└── labels/<solver-run>/
    ├── results.tsv
    └── run.json
```

The `.lp` files contain the PAFs. `index.tsv` is a table with one row per
instance, giving its name, generator parameters, and graph measurements.
TSV means tab-separated values: columns are separated by tabs rather than
commas. A spreadsheet program or text editor can open these files.

`generation.json` saves the generation settings, including the seed and
command. Each `run.json` saves the settings for a width measurement or solver
run. JSON stores named values in a text file; these files are written by the
scripts so the computations can be repeated.

The labels table records solver answers. It uses the same instance names and
SHA-256 hashes as the graph table. A hash is a fingerprint of a file's
contents, used here to check that an answer refers to the same PAF file.
Failed or timed-out computations have a status and a blank answer, rather
than an answer of zero. Exact fractions are kept when available.

The imported dataset retains its original combined `index.tsv`; later
measurements are stored under `analysis/`.

Users choose their own training, validation, and test splits.

Use one dataset README to explain its families and show its tables and plots.
See the [PAF guide](../docs/paf-workflow.md) for commands and the
[README template](../templates/paf-collection.md) for a starting point.

Current dataset:

- [`paf-grid-grounded-pext`](paf-grid-grounded-pext/): 528 PAFs and 448
  grounded-extension-verification answers.
