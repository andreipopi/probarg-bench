# Instance generators

Generators are organized by formalism and generator family. Each generator must
document its parameters, dependencies, output format, provenance, and random
seed behavior.

[`paf_grid.py`](paf_grid.py) is the first seeded generator. It exposes `k`,
`n`, grid-edge probability, replicate count, master seed, candidate inclusion
probability and the sampling weight of probability one. It writes native
`.lp` files plus a generation record, and supports `--dry-run` to preview the
collection size. See the [workflow](../docs/paf-workflow.md) for commands.

A seed is required. Every `.lp` records the master and derived instance seeds.
The generator also writes `families.tsv` and the README's family/parameter
table. `scripts/paf_report.py` combines those parameters with measured
statistics to refresh both README tables and the coverage plot.

This new version follows the adjacent-grid construction in the journal
experiment repository at commit `699275f093cc4c68c688d93c8f3ac10635be3a30`,
specifically `instance-generator/paf_grid_generator_stats.py`. It also reflects
the related dense/connected construction inspected in the supplied
`instance-gen-results` archive. It makes density and seeding explicit and uses
new random draws; it is not a byte-for-byte reconstruction of the historical
generator execution. Source sampling weights and candidate selection are
documented in the workflow.

The [`paf-grid-legacy`](paf-grid-legacy/) directory preserves the source
snapshots associated with the first provisional PAF collection. These scripts
use unseeded randomness and hard-coded output directories, so they are retained
for provenance and are not yet the canonical reproducible generator interface.

The KR 2024 PAF-TD generators will be curated separately rather than merged
with the later journal generator snapshots.

Generated datasets are versioned releases. Re-running a generator does not
silently replace an existing collection.
