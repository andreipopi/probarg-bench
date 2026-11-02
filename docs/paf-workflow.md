# Generating and publishing a PAF collection

The workflow has four steps: generate native PAFs, inventory their structure,
measure decomposition widths, then compute solver labels. A collection can be
published with structural information while labels are still being computed.

## A small folder structure

```text
datasets/<collection>/
├── README.md                         # Methods, parameters, source paper, coverage plot
├── generation.json                   # Command, parameters, Python version, generator hash
├── families.tsv                      # Generator parameters and seed per family
├── instances/
│   ├── grid_p0p5/*.lp                 # Families; no README needed for every k or n
│   ├── grid_p0p75/*.lp
│   └── grid_p1/*.lp
├── analysis/<measurement-run>/
│   ├── run.json                      # Width tool, binary hash, command, time limit
│   ├── index.tsv                     # One row per PAF, including structural measurements
│   ├── summary.tsv                   # Counts and ranges grouped by family, k and n
│   ├── summary.md                    # Human-readable statistics
│   ├── report.md                     # Generated family and structural coverage tables
│   ├── coverage.tsv                  # Structural coverage table as data
│   ├── coverage.png                  # Size versus measured width and attack count
│   └── decompositions/<family>/*.td   # Certificates for successful width measurements
└── labels/<solver-run>/               # Added when the probability solver is run
    ├── run.json
    └── results.tsv
```

Use one README per collection. Explain its families together there. Add a
family README only when that family has a different generation method,
format, provenance or task that needs its own explanation. There is no need
for a README in every size or width directory. Link the collection's
statistics and embed its coverage plot in its README; keep the repository's
top-level README as the catalog of collections.

The native files contain the graph, candidate extension and query argument.
Newly generated files also record generation parameters and seeds in `%`
comments, which the existing native format permits. Derived structural
measurements belong to the corresponding index row. This associates a width
with every instance while allowing a better decomposition to be measured
without rewriting that instance or invalidating its label hash.

The existing imported `paf-grid-grounded-pext/index.tsv` remains a legacy
import index. New analysis runs use the layout above and do not replace it.

## 1. Choose the generation grid

`k * n` is the number of arguments. The parameter `k` influences graph
structure but does not prescribe the resulting measured width, especially
when grid edges are omitted. Set an explicit parameter grid and inspect the
measured coverage before deciding whether more instances are needed.

Preview the count:

```bash
python3 generators/paf_grid.py --output datasets/paf-grid-v1 \
  --k 2 3 4 5 6 7 --n 5 10 20 30 40 50 60 70 80 90 100 \
  --edge-probabilities 0.5 0.75 1 --replicates 4 --seed 20261103 --dry-run
```

This specifies 792 PAFs. Remove `--dry-run` when the chosen grid is ready.
Start with a smaller pilot to check widths and solver compatibility before
generating the complete collection. The generator refuses an existing output
directory, so a new run gets its own collection name.

The implementation follows the journal grid-construction distribution:

- shuffle argument names onto an `n`-by-`k` grid;
- independently retain each undirected grid-neighbor pair with the selected
  edge probability;
- for a retained pair, choose either orientation or both with equal probability;
- draw each argument and directed-attack probability from `{0.1, ..., 1.0}`
  with weight 10 for each uncertain value and weight 0.1 for probability one;
- include each argument in the candidate set independently with probability
  0.04; and
- choose one acceptance-query argument uniformly from the arguments.

The candidate probability and the weight of probability one are explicit CLI
options. This is a new generator version: it produces new seeded instances
and does not recreate historical files. The sparse long-range generator from
PAF-TD is a different method and needs a separate version when added.

The master seed deterministically produces a seed for each parameter tuple
and replicate. Adding more parameter combinations does not change an existing
combination. Retain `generation.json`, the generator source revision and the
Python version to support reproduction.

The generator also writes `families.tsv` and an initial family/parameter
table in the collection README. The master seed is mandatory; each native
file records both that master seed and its derived instance seed. The table
includes the actual k/n choices, grid-edge selection probability, replicate
count and expected instance count per family.

## 2. Inventory and measure structure

Basic statistics require only Python's standard library:

```bash
python3 scripts/paf_stats.py datasets/paf-grid-v1 \
  --output datasets/paf-grid-v1/analysis/structure-v1
```

This parses the native facts and records argument count, directed attack
count, undirected edge count, self-attacks, unattacked arguments, isolated
vertices, weakly connected components, candidate size and uncertainty counts.
For width, the structural graph contains all declared arguments and an
undirected edge whenever either attack direction is declared. Reciprocal
attacks are collapsed; self-attacks do not add structural edges. This graph
definition is recorded in the run metadata.

Use your modified research HTD binary:

```bash
python3 scripts/paf_stats.py datasets/paf-grid-v1 \
  --output datasets/paf-grid-v1/analysis/htd-v1 \
  --htd /absolute/path/to/htd_main --timeout 60
```

For stock HTD, pass its options explicitly:

```bash
python3 scripts/paf_stats.py datasets/paf-grid-v1 \
  --output datasets/paf-grid-v1/analysis/htd-minfill-seed1 \
  --htd /absolute/path/to/stock/htd_main \
  --htd-args '--seed 1 --strategy min-fill --output td' --timeout 60
```

`--limit 12` is useful for a pilot. Omit it for the full inventory. The
research binary tested during development fixes its seed internally to zero;
it does not expose the stock CLI's seed options. The run records the binary
hash and complete arguments. Retain the corresponding build/source version
when publishing your measurement environment.

The script accepts standard PACE `.td` output and the modified research
binary's `Traversal` output. It checks that bags form a tree, every graph
vertex and edge is covered, and the bags containing each vertex form a
connected subtree. It saves each valid decomposition as a standard `.td`
certificate, including the map from numeric vertices to argument names.

`decomposition_width = largest_bag_size - 1`. A validated HTD decomposition
provides an **upper bound** on treewidth. Exact treewidth requires a proof of
optimality or matching certified bounds. A generator parameter, a successful
probability computation, or a decomposition validity check does not establish
optimality. See the [HTD documentation](https://github.com/mabseher/htd) and
[PACE's decomposition definition and formats](https://pacechallenge.org/2017/treewidth/).

Timeouts, invalid decompositions and tool errors remain explicit rows with no
reported width. Remeasure them in a new analysis run; keep the earlier run if
it is part of a published result. Width measurement can be repeated separately
from probability labeling, and a labeling solver may use a different
decomposition. Record that distinction in the solver-run metadata.

## 3. Rebuild both tables and the coverage plot

`paf_report.py` reads `families.tsv` and the selected analysis index. It checks
family counts against the native files and verifies that the analyzed PAF
hashes still match. It produces a family/parameter table and a structural
coverage table, including explicit width failures and unmeasured instances.
The report can be refreshed without rerunning HTD.

Plotting uses Matplotlib. Install it in a project environment:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install matplotlib
.venv/bin/python scripts/paf_report.py datasets/paf-grid-v1 \
  --analysis analysis/htd-v1 --plot --update-readme
```

This writes `report.md`, `coverage.tsv`, `report.json` and `coverage.png` in
the analysis directory and refreshes the marked generated section of the
collection README. You can rerun it after another analysis; authored methods,
citations and other text outside the markers are preserved.

For tables only, use standard Python and omit `--plot`. Omit
`--update-readme` to produce the report without changing the collection README:

```bash
python3 scripts/paf_report.py datasets/paf-grid-v1 --analysis analysis/htd-v1
```

`scripts/plot_paf_stats.py` remains available for standalone plotting. Its
`--overwrite` option explicitly permits regenerating an existing figure.

For imported collections, curate `families.tsv` from the documented historical
generator settings. Missing historical seeds remain blank and appear as
`unrecorded` in the table. They cannot be reconstructed from filenames.

The useful overview is argument count versus measured decomposition width,
colored by family, alongside argument count versus attack count. It shows
what instances the collection covers. A drawing of one PAF can additionally
explain the format, but does not replace the coverage statistics.

## 4. Add labels from the exact algorithms

Run your probability solvers on the same `.lp` files. Keep the labeling
experiment independent of generation and structural inventory. For each
label run, record solver repository/commit, command, arithmetic mode, task,
semantics, time and memory limits, and any decomposition configuration in
`labels/<solver-run>/run.json`.

Use a plain `results.tsv` with these columns:

```text
instance_id  instance_sha256  task  semantics  status  probability_numerator  probability_denominator  probability_decimal  runtime_seconds
```

The separators are tabs. `instance_id` and `instance_sha256` must match the
structural index. Suggested statuses are `ok`, `timeout`, `memoryout`,
`invalid_td` and `error`. A failed computation has blank probability fields;
it is never interpreted as zero. Preserve the exact numerator and denominator
when the solver uses rational arithmetic; a convenient decimal can be added
alongside them. Keep decimal-only historical results identified as such.

Extension verification uses `extension(...)`; acceptance uses the query
argument. State the task and semantics explicitly and publish their results
as separate solver runs. The graph corpus can support both tasks.

No generic solver launcher has been added yet: the exact solver commands and
rational-output export need to be chosen for each labeling task. Existing
probability-solver code stays in its research repository.

## Existing code to reuse

| Source | Useful part | Treatment here |
| --- | --- | --- |
| Journal `instance-generator/paf_grid_generator_stats.py` | Grid edges, orientations, probability distribution, candidate sampling | New seeded `generators/paf_grid.py` follows this construction |
| Desktop `InstanceGenerator/praaf_grid_generator_dense.py` | Related dense/connected grid construction | Consulted to distinguish generator variants |
| Desktop `InstanceGenerator/call_generator.py` | Historical k/n/replicate ranges | Replaced by explicit CLI parameters and a count preview |
| Desktop `count_unattacked.py` and `check_connectedness.py` | Unattacked-argument counts | Incorporated in `paf_stats.py`; actual weak connectivity is also computed |
| Journal `check-tree-decomposition/check_htd_td.py` | Bag-tree and running-intersection checks | Extended to check vertex coverage, edge coverage and actual bag sizes |
| Modified HTD used by PAF-TD/journal solvers | Decomposition computation | Used as an external executable; its binary hash is recorded |
| Desktop `Experiments/Run/read_logs.py`, `compute_stats.py` | Historical results/status/runtime parsing | Reference for later label export; hard-coded paths and log assumptions need adapting |

The Desktop source is the supplied `instance-gen-results` archive. It contains
several generations of experiments, so directory names alone should not be
used as a publication citation. Record the specific source files and their
hashes when adopting an additional generator or result set.

Before a versioned release, complete the collection README, confirm its source
publication and license, inspect coverage and failure counts, and retain the
native-file hashes with the labels. The scripts do not publish or upload data.
