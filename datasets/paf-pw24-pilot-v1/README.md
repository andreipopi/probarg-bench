# paf-pw24-pilot-v1

300 PAFs with 4–120 arguments, generated with recorded seeds using the
original KR 2024 dense-grid generator. Complete-extension labels are pending.

> Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
> Probabilistic Argumentation under the Constellation Approach*. KR 2024.
> [Published paper](https://doi.org/10.24963/kr.2024/55).

## Files and format

`instances/` contains decimal-probability PAFs; `instances_asp/` contains the
same PAFs scaled to integers out of 10000. `extension(...)` is the candidate
set; `query(...)` is the separate acceptance query. Generation information is
prepended as `% probarg ...` comments.

[Generation settings](generation_settings.json) record the command, source
versions and hashes. [Per-instance records](generation_instances.tsv) contain
seeds and file hashes. See the [workflow](../../README.md#generating-and-measuring-a-paf-dataset)
for the commands and the [measured summary](analysis/htd-v1/analysis_summary.md)
for graph statistics and decomposition widths.

<!-- probarg-report:start -->
## Families and generator parameters

| Family | Grid-edge probability | k | n | Replicates | Instances | Master seed |
| --- | --- | --- | --- | --- | --- | --- |
| grid_075 | 75% | 2, 3, 4, 5, 6 | 2, 3, 5, 10, 15, 20 | 10 | 300 | 20261105 |

## Structural coverage

The [report command](../../README.md#3-generate-the-tables-and-plot) adds the
coverage tables and figure here.
<!-- probarg-report:end -->

## License

The original code's MIT notice is retained in `generators/LICENSE-PW24-source`
in ProbArgBench. The dataset license remains to be stated before publication.
