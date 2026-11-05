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

The imported journal dataset keeps its combined labels and historical
measurements in `labels_results.tsv`; fresh measurements are under `analysis/`.
Users choose their own training, validation and test splits.

## Adding solver answers

Save each task/semantics/solver run under `labels/<solver-run>/`:

- `labels_results.tsv`: instance path and hash, status, probability and runtime;
- `labels_settings.json`: solver version, command, task, semantics, arithmetic,
  resource limits and decomposition settings;
- `logs/`: original solver output.

Keep exact numerators and denominators when available. Timeouts and errors
have blank answers. Store complete- and grounded-extension labels in separate
runs. The solver launcher and result exporter still need to be connected.

See the [generation and analysis walkthrough](../README.md#generating-and-measuring-a-paf-dataset)
and [dataset README template](../templates/paf-collection.md).
