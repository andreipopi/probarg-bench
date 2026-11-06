# Original generator files

These are unchanged copies, including their original top-level commands and
fixed output folders. They are kept so changes can be reviewed and tested.

| File | Repository and source path | Source commit | SHA-256 |
| --- | --- | --- | --- |
| `praaf_grid_generator_dense.py` | `paf-td/InstanceGenerator/praaf_grid_generator_dense.py` | `df7961a39dc666610298d7d2539ee2a8da315508` | `54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38` |
| `pbaf_grid_generator.py` | `pbaf-td/InstanceGenerator/pbaf_grid_generator.py` | `4526927ed60bad79087a883e6c73dd62efdadd57` | `202b4017aded0a0ecb03208d6f0bf68758d1b783d86e500a53904a7a42b3500f` |

`PW25-generator.py` retains every function from its source without changes.
`PW24-generator.py` adds a parameter to `create_framework` and a conditional
direction choice: the default retains the original four choices; the full-grid
variant excludes no attack. All other functions and the writers are unchanged.
The old top-level execution block is replaced by
the seeded dataset runner in `dataset_support.py`; a source note is added at
the top. The original writers run in temporary folders, and their files are
copied to the chosen dataset directory with settings prepended as comments.

The inactive triple-quoted `neighbourhood` example has been removed from the
active PW25 script. It remains in the archived original here. The fidelity
check permits this specific cleanup.

The tests check that the only executable PW24 edits are the two changes above,
then run the originals with an
injected seed and compare all native output bytes, filenames and final random
states. For PW24 this includes the decimal and integer-scaled ASP files.
Separate tests check the full-grid variant's edges, seeds and metadata.

The source MIT notices are retained in `../LICENSE-PW24-source` and
`../LICENSE-PW25-source`.
