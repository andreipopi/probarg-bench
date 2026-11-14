# paf-pw24-main-large-v1

9,541 label-candidate PAFs with 50–1,000 arguments, extending the
[main dataset](../paf-pw24-main-v1/). They were retained from 14,400 generated
instances; 4,859 instances without an exact result are stored in the
[unlabelled split](../paf-pw24-main-large-unlabelled-v1/).
They use the same full-grid variant of the KR 2024 generator.
Every neighbouring grid pair has a forward, reverse or bidirectional attack,
chosen with equal probability. Argument and attack probabilities retain the original settings.
The runner records seeds and settings. The instances can be used with different
semantics; each set of labels specifies its task and semantics.

## Source paper and code

Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to Probabilistic Argumentation under the Constellation Approach*. KR 2024.
[Published paper](https://doi.org/10.24963/kr.2024/55).

Source: `https://gitlab.tugraz.at/krr/paf-td`, commit `df7961a39dc666610298d7d2539ee2a8da315508`,
`InstanceGenerator/praaf_grid_generator_dense.py`. Its SHA-256 is `54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38`.

## Files

`instances/` contains the original native files with generation settings
prepended as `%` comments. Their names, facts and ordering are preserved.
`extension(...)` specifies the candidate set and `query(...)` the separate query argument.
`instances_asp/` contains the same instances with probabilities scaled to integers out of 10000.
These are alternate solver inputs, not additional benchmark examples.

`generation_settings.json` saves the original generation settings;
`families_parameters.tsv` lists the family parameters and current instance count.

<!-- probarg-report:start -->
## Families and generator parameters

| Family | Grid-edge probability | k | n | Replicates | Instances | Master seed |
| --- | --- | --- | --- | --- | --- | --- |
| grid_100 | 100% | 2, 3, 4, 5, 6, 7, 8, 9, 10 | 25, 50, 75, 100 | up to 400 retained | 9541 | 20261107 |

`k` and `n` are grid dimensions, so each instance has `k × n` arguments.
The source generated 400 replicates per pair; retained counts now vary by pair.

## Structural coverage

Run `scripts/paf_stats.py`, then `scripts/paf_report.py --plot --update-readme`
to add graph statistics, width measurements and the coverage figure.
<!-- probarg-report:end -->

## Labels

The complete-extension run is in progress externally. Failed and skipped
instances are in the [unlabelled split](../paf-pw24-main-large-unlabelled-v1/).
Results have not yet been imported into this repo.

## License and citation

The original code's MIT notice is retained in `generators/LICENSE-PW24-source`
in ProbArgBench. State the dataset license before publication and cite the source paper above.
