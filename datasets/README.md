# Datasets

Each dataset has a README and native `.lp` files, with generation records,
measurements and labels stored alongside them:

```text
datasets/<dataset-name>/
├── README.md
├── families_parameters.tsv
├── generation_settings.json
├── generation_instances.tsv
├── instances/
├── instances_asp/                 # Alternate PAF encoding
├── analysis/<measurement-run>/
└── labels/<solver-run>/
```

Dataset names describe the instances. Task and semantics belong to each label run.

## Files

| File | Contents |
| --- | --- |
| `families_parameters.tsv` | Generator families, parameter ranges and instance counts. |
| `generation_settings.json` | Generation command, seeds, code versions and settings. |
| `generation_instances.tsv` | Per-instance seeds and hashes of the full file and original body. |
| `analysis_instances.tsv` | Per-instance graph measurements and width statuses. |
| `analysis_summary.tsv`, `analysis_summary.md` | Grouped statistics and readable summary. |
| `analysis_settings.json` | Measurement command and tool settings. |
| `analysis_report.md`, `analysis_coverage.tsv`, `analysis_coverage.png` | Tables and coverage figure. |
| `analysis_report_settings.json` | Report command and input hashes. |
| `decompositions/` | Validated `.td` files under the analysis run. |
| `labels_results.tsv` | One row per instance, including exact labels and run status. |
| `labels_settings.json` | Task, semantics, solver revision, limits and source-log checks. |

TSV files are text tables with tab-separated columns; JSON files store named
settings. SHA-256 hashes identify file contents so results can be matched to
the correct instance. `instances_asp/` contains alternate encodings of the
same PAFs.

Users choose their own training, validation and test splits.

## Solver answers

Each label run belongs under `labels/<run-name>/`. The included PW24 runs use
journal `ver-td-COM` for exact complete-extension probabilities under the
constellation model. Solver code and raw logs stay outside this repository;
the compact tables record their hashes and provenance.

**Results:** one row per instance, with these columns:

| Column | Value |
| --- | --- |
| `instance_path` | Path relative to the dataset directory. |
| `instance_sha256` | Copy from `generation_instances.tsv`. |
| `status` | `ok`, `not_run`, `timeout`, `memoryout`, `error` or `invalid_td`. |
| `probability_numerator` | Exact numerator. |
| `probability_denominator` | Exact positive denominator. |
| `probability_decimal` | Decimal text derived from the fraction; scientific notation allowed. |
| `runtime_seconds` | Wall-clock seconds, including HTD. |
| `cpu_seconds`, `peak_memory_kib` | Resource measurements recorded by the run. |
| `largest_bag_size`, `decomposition_width` | Checked decomposition measurements, when available. |
| `source_log`, `source_log_sha256` | External raw-log name and content hash. |

Zero is `0/1`; probability fields are blank unless `status` is `ok`. A dataset
may contain both labelled and `not_run` rows so the original instance set does
not need to be split. Training exports should select only `status=ok` rows.

Keep results for other semantics in separate label runs.

See the [generation and analysis walkthrough](../README.md#generating-and-measuring-a-paf-dataset)
and [dataset README template](../templates/paf-collection.md).
