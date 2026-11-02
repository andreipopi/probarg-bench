# Instance generators

Generators are organized by formalism and generator family. Each generator must
document its parameters, dependencies, output format, provenance, and random
seed behavior.

The [`paf-grid-legacy`](paf-grid-legacy/) directory preserves the source
snapshots associated with the first provisional PAF collection. These scripts
use unseeded randomness and hard-coded output directories, so they are retained
for provenance and are not yet the canonical reproducible generator interface.

The KR 2024 PAF-TD generators will be curated separately rather than merged
with the later journal generator snapshots.

Generated datasets are versioned releases. Re-running a generator does not
silently replace an existing collection.
