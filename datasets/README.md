# Datasets

Each dataset has its own directory. For newly generated PAFs:

```text
datasets/<dataset-name>/
├── README.md
├── generation_settings.json
├── generation_instances.tsv
├── families_parameters.tsv
├── instances/
├── instances_asp/                     # Original alternate PAF encoding
├── analysis/<measurement-run>/
│   ├── analysis_instances.tsv
│   ├── analysis_summary.tsv
│   ├── analysis_summary.md
│   ├── analysis_report.md
│   ├── analysis_coverage.tsv
│   ├── analysis_coverage.png
│   ├── analysis_settings.json
│   ├── analysis_report_settings.json
│   └── decompositions/
└── labels/<solver-run>/
    ├── labels_results.tsv
    └── labels_settings.json
```

The `.lp` files contain the PAFs. `analysis_instances.tsv` is a table with one
row per instance, giving its name, generator parameters, and graph measurements.
TSV means tab-separated values: columns are separated by tabs rather than
commas. A spreadsheet program or text editor can open these files.

`generation_settings.json` saves the generation settings, including the seed
and command. `analysis_settings.json` saves the settings for graph measurements;
`analysis_report_settings.json` saves the command and input hashes used to
produce a report. `labels_settings.json` is the planned settings file for each
solver run. JSON stores named values in a text file; the scripts save these
settings so the computations can be repeated.

`generation_instances.tsv` saves the seed and file hash for each generated instance.
It also saves the hash of the original file body before generation comments
were added. The original PW24 generator's alternate integer-scaled files are
kept under `instances_asp/`; they are the same examples in another encoding.

The labels table records solver answers. It uses the same instance names and
SHA-256 hashes as the graph table. A hash is a fingerprint of a file's
contents, used here to check that an answer refers to the same PAF file.
Failed or timed-out computations have a status and a blank answer, rather
than an answer of zero. Exact fractions are kept when available.

The imported dataset keeps its existing combined labels and measurements in
`labels_results.tsv`; fresh measurements are stored under `analysis/`.

Users choose their own training, validation, and test splits.

Use one dataset README to explain its families and show its tables and plots.
See the [generator commands](../generators/README.md),
[measurement and plotting commands](../scripts/README.md), and the
[README template](../templates/paf-collection.md) for a starting point.

## Adding solver answers

Run the exact solvers on the generated `.lp` files. Save each experiment under
`labels/<solver-run>/`, with its settings in `labels_settings.json` and answers
in `labels_results.tsv`. Record the solver version, command, task, semantics,
arithmetic mode, time and memory limits, and decomposition settings.

The results table should contain the instance name and hash, status, probability
and runtime. Keep exact numerators and denominators when available. Failed
computations have blank probability fields. Keep extension-verification and
acceptance results in separate runs, with their semantics stated.

The solver launcher and answer export still need to be connected for each task.

Current dataset:

- [`paf-grid-grounded-pext`](paf-grid-grounded-pext/): 528 PAFs and 448
  grounded-extension-verification answers.
