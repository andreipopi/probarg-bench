# Dataset report

## Families and generator parameters

| Family | Grid-edge probability | k | n | Replicates | Instances | Master seed |
| --- | --- | --- | --- | --- | --- | --- |
| grid_075 | 75% | 2, 3, 4, 5, 6 | 2, 3, 5, 10, 15, 20 | 10 | 300 | 20261105 |

- `grid_075`: generator `PW24-original-dense-v1`; candidate inclusion probability 0.04; sampling weight of probability one 0.1 (each value 0.1–0.9 has weight 10).

## Structural coverage

| Family | Instances | Analyzed | Arguments | Directed attacks | Weak components | Decomposition width | Valid widths | Other statuses |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| grid_075 | 300 | 300 | 4–120 | 3–236 | 1–7 | 1–5 | 300 | none |

Graph: the underlying undirected graph of declared attacks, with reciprocal attacks collapsed and self-attacks omitted for width computation.
Widths are validated decomposition upper bounds on treewidth. Ranges describe the analyzed rows; instances outside a partial analysis have no measurements in this report.

![PAF size and width coverage](analysis_coverage.png)

Sources: [family parameters](../../families_parameters.tsv), [per-instance measurements](analysis_instances.tsv), [measurement configuration](analysis_settings.json).
