# paf-pw24-main-large-unlabelled-v1

4,859 PAFs moved out of
[`paf-pw24-main-large-v1`](../paf-pw24-main-large-v1/) because they have no
exact complete-extension label: 534 memory-outs, 8 timeouts and 4,317 skipped
solver runs.

Sizes `(6,25)`, `(5,75)` and `(10,100)` reached 10 consecutive timeout or
memory-out results. Larger `k` values at `n=25` and `n=75` were skipped too.
Successful runs from those sizes remain in the labelled-candidate dataset.

`instances/` and `instances_asp/` contain the two encodings.
`generation_instances.tsv` preserves each instance's seed and hashes;
`generation_settings.json` preserves the original generation provenance.
