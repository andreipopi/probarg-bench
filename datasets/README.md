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

TSV files are text tables with tab-separated columns; JSON files store named
settings. SHA-256 hashes identify file contents so results can be matched to
the correct instance. `instances_asp/` contains alternate encodings of the
same PAFs.

Users choose their own training, validation and test splits.

## Adding solver answers

The pilot and main complete-extension runs have finished externally; their
labels await import. The large run is in progress. For all three datasets:

1. Read the native `.lp` files in `instances/`. Use `extension(...)` as the
   candidate set; ignore `query(...)` and `%` comments.
2. Run journal `ver-td-COM` externally for complete-extension probabilities
   under the constellation model. Solver code and logs stay outside this repo.
3. Return `labels_results.tsv` and `labels_settings.json` under
   `labels/complete-extension-td-v1/`.

**Results:** one row per instance, with these columns:

| Column | Value |
| --- | --- |
| `instance_path` | Path relative to the dataset directory. |
| `instance_sha256` | Copy from `generation_instances.tsv`. |
| `status` | `ok`, `timeout`, `error` or `invalid_td`. |
| `probability_numerator` | Exact numerator. |
| `probability_denominator` | Exact positive denominator. |
| `probability_decimal` | Decimal text derived from the fraction; scientific notation allowed. |
| `runtime_seconds` | Wall-clock seconds, including HTD. |

Export the internal fraction, not the solver's printed float. Zero is `0/1`;
leave probability fields blank on failure. Existing `.td` certificates are
not direct inputs to this solver's traversal parser.

**Settings:** use `task="extension_verification"`, `semantics="complete"` and
`arithmetic="rational"`. Record the solver revision, command, Python/packages,
HTD settings and time/memory limits.

Keep results for other semantics in separate label runs.

See the [generation and analysis walkthrough](../README.md#generating-and-measuring-a-paf-dataset)
and [dataset README template](../templates/paf-collection.md).
