# <Dataset name>

<One paragraph stating formalism, generator family, intended tasks and status.>

## Where the data comes from

<Publication citation/DOI, source repository and commit, generator version,
and whether these are original or newly generated instances.>

## Generation

<Command and parameter grid: k, n, edge selection, replicates, seeds,
probability distribution, candidate/query construction. Link generation_settings.json.>

## Instances and format

<Native .lp predicates; family names and their differences; instance counts.
Explain that extension(...) is the candidate and in(...)/query(...) is the
acceptance query. State the independent constellation model.>

<!-- probarg-report:start -->
## Families and generator parameters

<Generated from families_parameters.tsv by scripts/paf_report.py.>

## Structural coverage

<Link the chosen analysis run's analysis_summary.md and analysis_instances.tsv. State its graph
definition, width method, tool/build/seed, measurement limit, success/failure
counts and whether widths are upper bounds or certified exact values.>

![Dataset coverage](analysis/<measurement-run>/analysis_coverage.png)
<!-- probarg-report:end -->

## Labels

<Tasks/semantics, exact solvers and revisions, arithmetic, limits, result
counts, links to label tables, and any missing labels. Initially say pending.>

## Limitations

<Known sampling biases, uncovered size/width ranges, missing labels or
uncertainty about exact numeric representations.>

## License and citation

<Dataset license and citation for this dataset and its source publication.>
