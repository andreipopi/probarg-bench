"""Dataset information and CLI around unchanged original generator functions."""

import argparse
import contextlib
import csv
import hashlib
import io
import json
import os
from pathlib import Path
import sys
import tempfile


SOURCES = {
    "PW24": dict(formalism="PAF", generator="PW24-original-dense-v1", family="grid_075",
                 file="praaf_grid_generator_dense.py", native_folder="additional_simple",
                 asp_folder="additional_simple_asp", probability_scale=1,
                 commit="df7961a39dc666610298d7d2539ee2a8da315508",
                 sha256="54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38",
                 repository="https://gitlab.tugraz.at/krr/paf-td",
                 doi="10.24963/kr.2024/55", venue="KR 2024",
                 title="Advancing Algorithmic Approaches to Probabilistic Argumentation under the Constellation Approach"),
    "PW25": dict(formalism="PBAF", generator="PW25-original-v1", family="pbaf_grid_075",
                 file="pbaf_grid_generator.py", native_folder="instance_set", asp_folder=None,
                 probability_scale=10, commit="4526927ed60bad79087a883e6c73dd62efdadd57",
                 sha256="202b4017aded0a0ecb03208d6f0bf68758d1b783d86e500a53904a7a42b3500f",
                 repository="https://github.com/andreipopi/pbaf-td",
                 doi="10.1145/3672608.3707819", venue="SAC 2025",
                 title="Dynamic Programming Algorithms for Probabilistic Bipolar Argumentation Frameworks"),
}


def seed_for(paper, master_seed, k, n, replicate):
    value = f"{SOURCES[paper]['generator']}:{master_seed}:{k}:{n}:{replicate}"
    return int.from_bytes(hashlib.sha256(value.encode()).digest()[:8], "big")


def generate_instance(engine, paper, k, n, replicate, seed):
    """Call the original functions in their original order, with a given seed.

    The original writers run in a private temporary directory, so their fixed
    folder names need no changes. Generation is sequential because those
    functions use module globals and a working directory.
    """
    spec = SOURCES[paper]
    for name in ("arguments", "attacks", "supports", "prob_args", "prob_attacks", "grid", "framework"):
        if hasattr(engine, name):
            setattr(engine, name, [])
    engine.k, engine.n, engine.id_instance = k, n, replicate
    engine.n_sentences = k * n
    with tempfile.TemporaryDirectory(prefix="probarg-instance-") as temporary:
        previous = Path.cwd()
        try:
            os.chdir(temporary)
            with contextlib.redirect_stdout(io.StringIO()):
                engine.random.seed(seed)
                engine.arguments = engine.initialise(engine.n_sentences)
                engine.create_grid(k, n)
                engine.print_grid(engine.grid)
                values = engine.create_framework(n, k)
                query, candidate = values[-2:]
                filename = f"k{k}_n{n}_q{query}_{replicate}.lp"
                if paper == "PW24":
                    p1, p1_asp, p2, p2_asp, attacks, query, candidate = values
                    engine.create_instance_file(sorted(engine.arguments), p1, p1_asp, attacks,
                                                p2, p2_asp, query, sorted(candidate), filename)
                else:
                    p1, p2, attacks, supports, query, candidate = values
                    engine.create_instance_file(sorted(engine.arguments), p1, attacks, supports,
                                                p2, query, sorted(candidate), filename)
            native = (Path(spec["native_folder"]) / filename).read_bytes()
            asp = (Path(spec["asp_folder"]) / filename).read_bytes() if spec["asp_folder"] else None
        finally:
            os.chdir(previous)
    return filename, native, asp


def with_metadata(body, metadata):
    header = "".join(f"% probarg {key}={value}\n" for key, value in sorted(metadata.items()))
    return header.encode("utf-8") + body


def dataset_readme(output, spec, family, count, k_values, n_values, replicates, master_seed):
    columns = ["Family", "Grid-edge probability", "k", "n", "Replicates", "Instances", "Master seed"]
    values = [family, "75%", ", ".join(map(str, k_values)), ", ".join(map(str, n_values)),
              replicates, count, master_seed]
    table = "| " + " | ".join(columns) + " |\n| " + " | ".join(["---"] * len(columns)) + " |\n"
    table += "| " + " | ".join(map(str, values)) + " |\n"
    if spec["formalism"] == "PAF":
        format_note = ("`extension(...)` specifies the candidate set and `query(...)` the separate query argument.\n"
                       "`instances_asp/` contains the same instances with probabilities scaled to integers out of 10000.\n"
                       "These are alternate solver inputs, not additional benchmark examples.")
        coverage = ("Run `scripts/paf_stats.py`, then `scripts/paf_report.py --plot --update-readme`\n"
                    "to add graph statistics, width measurements and the coverage figure.")
    else:
        format_note = ("`support(...)` specifies supports and `in(...)` the candidate set. Probabilities use\n"
                       "integers 1–10, representing 0.1–1.0. The `qa...` filename part is the original\n"
                       "generator's unused query choice; it is not a separate task query.")
        coverage = ("The current measurement and report scripts support PAFs. PBAF support relations\n"
                    "and probability scaling still need to be added before measuring this dataset.")
    return f"""# {output.name}

{count} {spec['formalism']} instances generated by the original {spec['venue']} generator.
All original functions are unchanged. The dataset runner sets a seed before
calling them, saves the outputs, and adds the information in this README.

## Source paper and code

Andrei Popescu and Johannes P. Wallner. *{spec['title']}*. {spec['venue']}.
[Published paper](https://doi.org/{spec['doi']}).

Source: `{spec['repository']}`, commit `{spec['commit']}`,
`InstanceGenerator/{spec['file']}`. Its SHA-256 is `{spec['sha256']}`.

## Files

`instances/` contains the original native files with generation settings
prepended as `%` comments. Their names, facts and ordering are preserved.
{format_note}

`generation_settings.json` saves the settings; `families_parameters.tsv` lists the family parameters.
No solver labels have been computed yet.

<!-- probarg-report:start -->
## Families and generator parameters

{table}

## Structural coverage

{coverage}
<!-- probarg-report:end -->

## License and citation

The original code's MIT notice is retained in `generators/LICENSE-{spec['generator'].split('-')[0]}-source`
in ProbArgBench. State the dataset license before publication and cite the source paper above.
"""


def run_cli(engine, paper):
    spec = SOURCES[paper]
    parser = argparse.ArgumentParser(description=f"Original {paper} {spec['formalism']} generator with dataset output.")
    parser.add_argument("--output", type=Path, required=True, help="new dataset directory")
    parser.add_argument("--k", type=int, nargs="+", required=True)
    parser.add_argument("--n", type=int, nargs="+", required=True)
    parser.add_argument("--replicates", type=int, default=4)
    parser.add_argument("--seed", type=int, required=True, help="master seed; actual per-instance seeds are saved")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    if min(args.k + args.n + [args.replicates]) < 1:
        parser.error("k, n and replicates must be positive")
    k_values, n_values = sorted(set(args.k)), sorted(set(args.n))
    count = len(k_values) * len(n_values) * args.replicates
    print(f"{count} {spec['formalism']}s; original {paper} settings; master seed {args.seed}")
    if args.dry_run:
        return
    if args.output.exists():
        parser.error("output already exists; choose a new dataset directory")
    output = args.output.resolve()
    script_hash = hashlib.sha256(Path(engine.__file__).read_bytes()).hexdigest()
    runner_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    family = spec["family"]
    native_folder = output / "instances" / family
    native_folder.mkdir(parents=True)
    manifest = []
    for k in k_values:
        for n in n_values:
            for replicate in range(1, args.replicates + 1):
                seed = seed_for(paper, args.seed, k, n, replicate)
                filename, native, asp = generate_instance(engine, paper, k, n, replicate, seed)
                metadata = dict(generator=spec["generator"], formalism=spec["formalism"],
                                master_seed=args.seed, seed=seed, k=k, n=n, replicate=replicate,
                                edge_probability="0.75", candidate_probability="0.04", certainty_weight="0.1",
                                probability_scale=spec["probability_scale"], source_commit=spec["commit"],
                                source_sha256=spec["sha256"], generator_sha256=script_hash, runner_sha256=runner_hash)
                if paper == "PW25":
                    metadata["support_probability"] = "0.1"
                path = native_folder / filename
                path.write_bytes(with_metadata(native, metadata))
                if asp is not None:
                    asp_folder = output / "instances_asp" / family
                    asp_folder.mkdir(parents=True, exist_ok=True)
                    (asp_folder / filename).write_bytes(with_metadata(asp, dict(metadata, probability_scale=10000)))
                manifest.append(dict(instance_path=path.relative_to(output).as_posix(), seed=seed,
                                     instance_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                     native_body_sha256=hashlib.sha256(native).hexdigest()))
    record = dict(generator=spec["generator"], formalism=spec["formalism"], source_doi=spec["doi"],
                  source_repository=spec["repository"], source_file=f"InstanceGenerator/{spec['file']}",
                  source_commit=spec["commit"], source_sha256=spec["sha256"],
                  generator_sha256=script_hash, runner_sha256=runner_hash, python_version=sys.version,
                  master_seed=args.seed, k=k_values, n=n_values, replicates=args.replicates,
                  edge_probability="0.75", candidate_probability="0.04", certainty_weight="0.1",
                  probability_scale=spec["probability_scale"], command=sys.argv)
    family_row = dict(family=family, edge_probability="0.75", k_values=", ".join(map(str, k_values)),
                      n_values=", ".join(map(str, n_values)), replicates=args.replicates,
                      instance_count=count, master_seed=args.seed, candidate_probability="0.04",
                      certainty_weight="0.1", generator=spec["generator"])
    if paper == "PW25":
        record["support_probability"] = family_row["support_probability"] = "0.1"
    (output / "generation_settings.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    for filename, rows in (("families_parameters.tsv", [family_row]), ("generation_instances.tsv", manifest)):
        with (output / filename).open("w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, list(rows[0]), delimiter="\t", lineterminator="\n")
            writer.writeheader()
            writer.writerows(rows)
    (output / "README.md").write_text(dataset_readme(output, spec, family, count, k_values,
                                                    n_values, args.replicates, args.seed), encoding="utf-8")
