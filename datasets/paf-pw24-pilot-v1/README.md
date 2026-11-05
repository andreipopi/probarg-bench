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
## Generator parameters

| k | n | Replicates | Grid connection probability |
| --- | --- | --- | --- |
| 2, 3, 4, 5, 6 | 2, 3, 5, 10, 15, 20 | 10 | 75% |

Each PAF has `k × n` arguments; replicates are instances per `(k, n)` pair.
A grid connection means at least one attack between neighbouring vertices.

## Dataset summary

| Instances | Arguments | Attacks | Candidate size | Width upper bound |
| --- | --- | --- | --- | --- |
| 300 | 4–120 | 3–236 | 0–8 | 1–5 |

Attacks are directed. Widths are validated upper bounds on treewidth of the undirected attack graph.

All 300 instances analysed successfully.

Empty candidate sets: 114/300 (38%).

![PAF size and width distribution](analysis/htd-v1/analysis_coverage.png)

Circle area represents the number of instances at each size and width.

Details: [generator settings](families_parameters.tsv) · [measurements](analysis/htd-v1/analysis_instances.tsv) · [analysis settings](analysis/htd-v1/analysis_settings.json).
<!-- probarg-report:end -->

## License

The original code's MIT notice is retained in `generators/LICENSE-PW24-source`
in ProbArgBench. The dataset license remains to be stated before publication.
