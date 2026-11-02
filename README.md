# ProbArgBench

ProbArgBench is an open benchmark collection for probabilistic argumentation.
It publishes graph instances in their native formats, the generators that
produce them, and reference labels produced by exact solvers.

The first publication-linked collection planned for full curation is based on
the probabilistic argumentation frameworks (PAFs) used in:

> Andrei Popescu and Johannes P. Wallner. *Advancing Algorithmic Approaches to
> Probabilistic Argumentation under the Constellation Approach*. KR 2024.
> [https://doi.org/10.24963/kr.2024/55](https://doi.org/10.24963/kr.2024/55)

## Scope

ProbArgBench is intended to contain:

- native benchmark instances, initially PAF graphs serialized as `.lp` files;
- reference labels and structural metadata for each instance, preserving exact
  rationals whenever the source solver exposed them;
- generator source, with reproducible interfaces and documented parameter
  spaces added as collections are curated;
- provenance linking each collection to its source publication and software;
- optional evaluation utilities, kept separate from the datasets themselves.

The benchmark does not prescribe machine-learning train, validation, or test
splits. Researchers may construct splits appropriate to their experiments.
Standardized evaluation protocols may be published separately when needed for
directly comparable results.

## Repository layout

```text
datasets/     Published benchmark collections and their documentation
generators/   Reproducible instance generators
evaluation/   Optional, model-agnostic evaluation protocols and utilities
```

## Available collections

| Collection | Task | Instances | Usable labels | Status |
| --- | --- | ---: | ---: | --- |
| [`paf-grid-grounded-pext`](datasets/paf-grid-grounded-pext/) | PAF extension verification under grounded semantics | 528 | 448 | Provisional, audited import |

The provisional collection reuses native instances and exact-solver outputs
from a later PAF journal experiment repository. It is separate from the KR
2024 collection so their provenance and tasks are not conflated.

Complete versioned dataset releases will also be published on the Hugging Face
Hub. GitHub remains the main location for source code, documentation, issues,
and release history.

## Status

ProbArgBench is under initial development. A first grounded-semantics PAF
collection has been staged from existing research artifacts after a small
integrity and provenance audit. The next milestone is to curate the KR 2024
PAF instances and generators as a separate collection, recover their reference
labels from the rational solvers, and document every released collection.

The maintained solver and experiment implementation is available in
[PAF-TD](https://github.com/andreipopi/paf-td).

## License and citation

Code and dataset licensing will be stated explicitly before the first release.
Citation metadata will be added with the first versioned collection.
