"""Original-generator fidelity, dataset reports and decomposition validation."""

import ast
import contextlib
import csv
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]


def load(name, relative):
    spec = importlib.util.spec_from_file_location(name, ROOT / relative)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


ENGINES = {paper: load(paper, f"generators/{paper}-generator.py") for paper in ("PW24", "PW25")}
driver = load("dataset_support", "generators/dataset_support.py")
stats = load("paf_stats", "scripts/paf_stats.py")
report = load("paf_report", "scripts/paf_report.py")
plot = load("plot_paf_stats", "scripts/plot_paf_stats.py")


class GeneratorFidelityTests(unittest.TestCase):
    def test_sources_and_every_original_function_are_unchanged(self):
        for paper, spec in driver.SOURCES.items():
            with self.subTest(paper=paper):
                source = ROOT / "generators/originals" / spec["file"]
                self.assertEqual(hashlib.sha256(source.read_bytes()).hexdigest(), spec["sha256"])
                original, updated = source.read_text(), Path(ENGINES[paper].__file__).read_text()
                original_prefix = original.split("# main()", 1)[0]
                if paper == "PW25":
                    # The sole permitted cleanup is the original inactive string block.
                    inactive = [node for node in ast.parse(original_prefix).body
                                if isinstance(node, ast.Expr) and isinstance(node.value, ast.Constant)
                                and isinstance(node.value.value, str)
                                and node.value.value.startswith(" not currently used\n")]
                    self.assertEqual(len(inactive), 1)
                    block = ast.get_source_segment(original_prefix, inactive[0])
                    original_prefix = original_prefix.replace(block + "\n\n", "", 1)
                self.assertEqual(original_prefix,
                                 updated[updated.index("import sys\n"):].split("# Added:", 1)[0])
                functions = lambda text: {node.name: ast.get_source_segment(text, node)
                                          for node in ast.parse(text).body if isinstance(node, ast.FunctionDef)}
                self.assertEqual(functions(original), functions(updated))

    def test_native_outputs_and_random_states_match_seeded_originals(self):
        harness = """import random, runpy, sys
from pathlib import Path
seed, script, *arguments = sys.argv[1:]
sys.argv = [script, *arguments]
random.seed(int(seed))
runpy.run_path(script, run_name='__main__')
Path('random-state.txt').write_text(repr(random.getstate()))
"""
        for paper, spec in driver.SOURCES.items():
            source = ROOT / "generators/originals" / spec["file"]
            for seed in (0, 1, 42, 20261103):
                for k, n, replicate in ((2, 3, 1), (3, 5, 2), (4, 4, 3)):
                    with self.subTest(paper=paper, seed=seed, k=k, n=n), tempfile.TemporaryDirectory() as directory:
                        subprocess.run([sys.executable, "-c", harness, str(seed), str(source),
                                        str(k), str(n), str(replicate)], cwd=directory,
                                       capture_output=True, text=True, check=True)
                        filename, native, asp = driver.generate_instance(ENGINES[paper], paper, k, n, replicate, seed)
                        folder = Path(directory) / spec["native_folder"]
                        self.assertEqual([p.name for p in folder.glob("*.lp")], [filename])
                        self.assertEqual(native, (folder / filename).read_bytes())
                        self.assertEqual(repr(ENGINES[paper].random.getstate()),
                                         (Path(directory) / "random-state.txt").read_text())
                        if spec["asp_folder"]:
                            self.assertEqual(asp, (Path(directory) / spec["asp_folder"] / filename).read_bytes())
                        else:
                            self.assertIsNone(asp)

    def test_dataset_metadata_does_not_change_original_bodies(self):
        for paper, engine in ENGINES.items():
            with self.subTest(paper=paper), tempfile.TemporaryDirectory() as directory:
                output = Path(directory) / "dataset"
                arguments = [f"{paper}-generator.py", "--output", str(output), "--k", "2", "3",
                             "--n", "4", "--replicates", "2", "--seed", "123"]
                with patch.object(sys, "argv", arguments), contextlib.redirect_stdout(io.StringIO()):
                    driver.run_cli(engine, paper)
                record = json.loads((output / "generation_settings.json").read_text())
                manifest = report.read_table(output / "generation_instances.tsv")
                self.assertEqual(len(manifest), 4)
                self.assertEqual(record["source_sha256"], driver.SOURCES[paper]["sha256"])
                self.assertEqual(record["master_seed"], 123)
                for row in manifest:
                    raw = (output / row["instance_path"]).read_bytes()
                    body = b"".join(line for line in raw.splitlines(keepends=True) if not line.startswith(b"% probarg "))
                    self.assertEqual(hashlib.sha256(raw).hexdigest(), row["instance_sha256"])
                    self.assertEqual(hashlib.sha256(body).hexdigest(), row["native_body_sha256"])
                if paper == "PW24":
                    self.assertEqual(len(list((output / "instances_asp").rglob("*.lp"))), 4)
                    for path in (output / "instances").rglob("*.lp"):
                        stats.read_paf(path)

    def test_seed_stable_when_parameter_grid_is_extended(self):
        for paper in ENGINES:
            seed = driver.seed_for(paper, 123, 3, 5, 1)
            self.assertEqual(seed, driver.seed_for(paper, 123, 3, 5, 1))
            self.assertNotEqual(seed, driver.seed_for(paper, 124, 3, 5, 1))
            self.assertNotEqual(seed, driver.seed_for(paper, 123, 3, 5, 2))
            first = driver.generate_instance(ENGINES[paper], paper, 3, 5, 1, seed)
            driver.generate_instance(ENGINES[paper], paper, 2, 3, 1, 999)
            self.assertEqual(first, driver.generate_instance(ENGINES[paper], paper, 3, 5, 1, seed))


class WorkflowTests(unittest.TestCase):
    def test_generated_dataset_measurements_and_report_use_descriptive_names(self):
        with tempfile.TemporaryDirectory() as directory:
            dataset = Path(directory) / "dataset"
            analysis = dataset / "analysis" / "counts-v1"
            commands = (
                (driver.run_cli,
                 ["PW24-generator.py", "--output", str(dataset), "--k", "2", "--n", "3",
                  "--replicates", "1", "--seed", "123"]),
                (stats.main, ["paf_stats.py", str(dataset), "--output", str(analysis)]),
                (report.main, ["paf_report.py", str(dataset), "--analysis", "analysis/counts-v1",
                               "--update-readme"]),
            )
            for action, arguments in commands:
                with patch.object(sys, "argv", arguments), contextlib.redirect_stdout(io.StringIO()):
                    if action is driver.run_cli:
                        action(ENGINES["PW24"], "PW24")
                    else:
                        action()
            measurements = report.read_table(analysis / "analysis_instances.tsv")
            self.assertEqual(len(measurements), 1)
            self.assertEqual(measurements[0]["width_status"], "not_run")
            readme = (dataset / "README.md").read_text()
            self.assertIn("analysis/counts-v1/analysis_instances.tsv", readme)
            self.assertIn("families_parameters.tsv", readme)
            self.assertIn("analysis/counts-v1/analysis_settings.json", readme)
            settings = json.loads((analysis / "analysis_report_settings.json").read_text())
            self.assertEqual(settings["index_sha256"],
                             hashlib.sha256((analysis / "analysis_instances.tsv").read_bytes()).hexdigest())
            for path in (dataset / "families_parameters.tsv", dataset / "generation_settings.json",
                         dataset / "generation_instances.tsv", analysis / "analysis_summary.tsv",
                         analysis / "analysis_summary.md", analysis / "analysis_report.md",
                         analysis / "analysis_coverage.tsv"):
                self.assertTrue(path.is_file(), path)

    def test_valid_path_decomposition(self):
        bags, edges, header = stats.parse_decomposition("s td 2 2 3\nb 1 1 2\nb 2 2 3\n1 2\n")
        self.assertEqual(stats.validate_decomposition(bags, edges, [(1, 2), (2, 3)], 3, header), 2)

    def test_custom_htd_traversal(self):
        text = "Human Tree Decomposition\n...\nTraversal\n1 [1,2] leaf edges [[1,2]] 2\n2 [2,3] rem [1] edges [[2,3]] 0\n"
        bags, edges, header = stats.parse_decomposition(text)
        self.assertEqual(stats.validate_decomposition(bags, edges, [(1, 2), (2, 3)], 3, header), 2)

    def test_invalid_decompositions(self):
        with self.assertRaisesRegex(ValueError, "connected subtree"):
            stats.validate_decomposition({1: {1, 2}, 2: {2, 3}, 3: {1, 3}}, {(1, 2), (2, 3)}, [(1, 2), (2, 3)], 3)
        with self.assertRaisesRegex(ValueError, "vertices"):
            stats.validate_decomposition({1: {1, 2}}, set(), [(1, 2)], 3)
        with self.assertRaisesRegex(ValueError, "uncovered"):
            stats.validate_decomposition({1: {1, 2}, 2: {2, 3}}, {(1, 2)}, [(1, 3)], 3)
        with self.assertRaisesRegex(ValueError, "tree"):
            stats.validate_decomposition({1: {1}, 2: {2}}, set(), [], 2)
        with self.assertRaisesRegex(ValueError, "header"):
            stats.validate_decomposition({1: {1, 2}}, set(), [(1, 2)], 2, (1, 3, 2))

    def test_scaled_asp_probabilities_rejected(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "instance.lp"
            path.write_text("arg(a).\np(a,10000).\n")
            with self.assertRaisesRegex(ValueError, "probability"):
                stats.read_paf(path)

    def test_report_distinguishes_partial_analysis_and_failed_widths(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            families = [dict(family=name, instance_count=count, k_values="1", n_values="1",
                             replicates="1", edge_probability="0.75", master_seed="123")
                        for name, count in (("first", "2"), ("second", "1"))]
            rows = []
            for i, family in enumerate(("first", "first", "second")):
                path = root / "instances" / family / f"example{i}.lp"
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text("arg(a).\np(a,1).\n")
                if i < 2:
                    rows.append(dict(family=family, instance_path=path.relative_to(root).as_posix(),
                                     instance_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                     argument_count="1", attack_count="0", weak_component_count="1", candidate_size="0",
                                     width_status="ok" if i == 0 else "timeout",
                                     decomposition_width="0" if i == 0 else ""))
            table = report.coverage(root, families, rows)
            self.assertEqual(table[0]["valid_widths"], 1)
            self.assertEqual(table[0]["other_width_statuses"], "timeout=1")
            self.assertEqual(table[1]["analyzed"], 0)
            self.assertEqual(table[1]["decomposition_width"], "pending")
            text = report.report_text(families, table, "analysis/test", False)
            self.assertIn("Analysed 2/3 instances; valid widths: 1/2.", text)
            self.assertIn("first: timeout=1", text)
            self.assertIn("second: 1 not analysed", text)
            self.assertNotIn("analysed successfully", text)
            (root / rows[0]["instance_path"]).write_text("arg(b).\np(b,1).\n")
            with self.assertRaisesRegex(ValueError, "hash changed"):
                report.coverage(root, families, rows)

    def test_complete_report_is_compact_and_keeps_candidate_coverage(self):
        families = [dict(family="grid_075", k_values="2", n_values="2, 3", replicates="1",
                         edge_probability="0.75", master_seed="123", generator="internal-generator-id")]
        structural = [dict(family="grid_075", instances=3, analyzed=3, arguments="4–6",
                           directed_attacks="2–8", candidate_size="0–2", empty_candidates=1,
                           decomposition_width="1–2", valid_widths=3, other_width_statuses="none")]
        text = report.report_text(families, structural, "analysis/test", True)
        self.assertIn("| Instances | Arguments | Attacks | Candidate size | Width upper bound |", text)
        self.assertIn("All 3 instances analysed successfully.", text)
        self.assertIn("Empty candidate sets: 1/3 (33.3%).", text)
        self.assertIn("k × n", text)
        self.assertIn("at least one attack between neighbouring vertices", text)
        self.assertIn("Circle area represents", text)
        self.assertNotIn("internal-generator-id", text)
        self.assertNotIn("Other statuses", text)

    def test_plot_counts_overlapping_instances_and_excludes_failed_widths(self):
        rows = [dict(argument_count="4", decomposition_width="2", width_status="ok"),
                dict(argument_count="4", decomposition_width="2", width_status="ok"),
                dict(argument_count="6", decomposition_width="2", width_status="ok"),
                dict(argument_count="6", decomposition_width="", width_status="timeout"),
                dict(argument_count="6", decomposition_width="9", width_status="invalid_td")]
        self.assertEqual(plot.count_width_positions(rows), {(4, 2): 2, (6, 2): 1})

    def test_readme_report_replacement_preserves_authored_text(self):
        source = f"# Dataset\n\nMethods.\n{report.START}\nOld report\n{report.END}\n\nCitation.\n"
        updated = report.replace_report(source, "New tables\n")
        self.assertEqual(report.replace_report(updated, "New tables\n"), updated)
        self.assertIn("Methods.", updated)
        self.assertIn("Citation.", updated)
        self.assertNotIn("Old report", updated)
        with self.assertRaisesRegex(ValueError, "malformed"):
            report.replace_report(source + report.START, "New tables\n")


if __name__ == "__main__":
    unittest.main()
