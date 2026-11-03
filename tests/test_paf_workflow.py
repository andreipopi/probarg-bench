"""Tests for seed reproducibility and rejection of invalid width certificates."""

import importlib.util
import contextlib
import csv
import hashlib
import io
import json
from pathlib import Path
import re
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


grid = load("pw24_generator", "generators/PW24-generator.py")
pbaf = load("pw25_generator", "generators/PW25-generator.py")
stats = load("paf_stats", "scripts/paf_stats.py")
report = load("paf_report", "scripts/paf_report.py")


class WorkflowTests(unittest.TestCase):
    def test_pw25_seeds_and_native_format(self):
        config = dict(master_seed=123, candidate_probability="1", certainty_weight=0.1,
                      support_probability="0.5")
        text = pbaf.render(5, 5, "1", 1, config, "source-hash")
        self.assertEqual(text, pbaf.render(5, 5, "1", 1, config, "source-hash"))
        self.assertNotEqual(text, pbaf.render(5, 5, "1", 2, config, "source-hash"))
        arguments, candidate, relations, pargs, prelations, ids = set(), set(), {}, {}, {}, set()
        for line in text.splitlines():
            if line.startswith("%"):
                continue
            predicate, body = re.fullmatch(r"(arg|p|att|support|in)\(([^()]*)\)\.", line).groups()
            values = body.split(",")
            if predicate == "arg":
                arguments.add(values[0])
            elif predicate == "in":
                candidate.add(values[0])
            elif predicate in ("att", "support"):
                pair = tuple(values)
                self.assertNotIn(pair, relations)
                relations[pair] = predicate
            elif len(values) == 2:
                pargs[values[0]] = int(values[1])
            else:
                self.assertNotIn(values[0], ids)
                ids.add(values[0])
                prelations[tuple(values[1:3])] = int(values[3])
        self.assertEqual(len(arguments), 25)
        self.assertEqual(candidate, arguments)
        self.assertEqual(set(pargs), arguments)
        self.assertEqual(set(prelations), set(relations))
        self.assertTrue(all(1 <= p <= 10 for p in [*pargs.values(), *prelations.values()]))
        self.assertEqual(set(relations.values()), {"att", "support"})
        kinds = {}
        for (a, b), kind in relations.items():
            key = tuple(sorted((a, b)))
            self.assertEqual(kinds.setdefault(key, kind), kind)
        self.assertEqual(len(kinds), 40)  # Every neighboring pair of a 5-by-5 grid.
        self.assertIn("% probarg formalism=PBAF", text)
        self.assertIn("% probarg probability_scale=10", text)
        self.assertNotIn("extension(", text)

    def test_pw25_support_probability_boundaries(self):
        for support, present, absent in (("0", "att(", "support("), ("1", "support(", "att(")):
            config = dict(master_seed=123, candidate_probability="0", certainty_weight=0.1,
                          support_probability=support)
            text = pbaf.render(3, 3, "1", 1, config, "source-hash")
            self.assertIn(present, text)
            self.assertNotIn(absent, text)

    def test_pw25_generation_records_source_and_parameters(self):
        with tempfile.TemporaryDirectory() as folder:
            output = Path(folder) / "pbaf"
            command = ["PW25-generator.py", "--output", str(output), "--k", "2", "--n", "3",
                       "--replicates", "2", "--seed", "123"]
            with patch.object(sys, "argv", command), contextlib.redirect_stdout(io.StringIO()):
                pbaf.main()
            record = json.loads((output / "generation.json").read_text())
            self.assertEqual(record["source_doi"], "10.1145/3672608.3707819")
            self.assertEqual(record["formalism"], "PBAF")
            self.assertEqual(record["probability_scale"], 10)
            self.assertEqual(len(list((output / "instances").rglob("*.lp"))), 2)
            families = report.read_table(output / "families.tsv")
            self.assertEqual(families[0]["master_seed"], "123")
            self.assertEqual(families[0]["support_probability"], "0.1")
            self.assertIn("SAC 2025", (output / "README.md").read_text())

    def test_seed_reproduces_native_files(self):
        config = dict(master_seed=123, candidate_probability="0.04", certainty_weight=0.1)
        a = grid.render(3, 4, "0.75", 1, config, "source-hash")
        self.assertEqual(a, grid.render(3, 4, "0.75", 1, config, "source-hash"))
        self.assertNotEqual(a, grid.render(3, 4, "0.75", 2, config, "source-hash"))
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "instance.lp"
            path.write_text(a)
            arguments, attacks, *_ = stats.read_paf(path)
        self.assertEqual(len(arguments), 12)
        self.assertLessEqual(len(attacks), 2 * (3 * 3 + 4 * 2))

    def test_zero_density_and_empty_candidate(self):
        config = dict(master_seed=123, candidate_probability="0", certainty_weight=0.1)
        text = grid.render(2, 3, "0", 1, config, "source-hash")
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "instance.lp"
            path.write_text(text)
            arguments, attacks, candidate, *_ = stats.read_paf(path)
        self.assertEqual(len(arguments), 6)
        self.assertFalse(attacks)
        self.assertFalse(candidate)

    def test_valid_path_decomposition(self):
        text = "s td 2 2 3\nb 1 1 2\nb 2 2 3\n1 2\n"
        bags, edges, header = stats.parse_decomposition(text)
        self.assertEqual(stats.validate_decomposition(bags, edges, [(1, 2), (2, 3)], 3, header), 2)

    def test_custom_htd_traversal(self):
        text = "Human Tree Decomposition\n...\nTraversal\n1 [1,2] leaf edges [[1,2]] 2\n2 [2,3] rem [1] edges [[2,3]] 0\n"
        bags, edges, header = stats.parse_decomposition(text)
        self.assertEqual(stats.validate_decomposition(bags, edges, [(1, 2), (2, 3)], 3, header), 2)

    def test_running_intersection_violation(self):
        with self.assertRaisesRegex(ValueError, "connected subtree"):
            stats.validate_decomposition({1: {1, 2}, 2: {2, 3}, 3: {1, 3}}, {(1, 2), (2, 3)}, [(1, 2), (2, 3)], 3)

    def test_missing_vertex_or_edge(self):
        with self.assertRaisesRegex(ValueError, "vertices"):
            stats.validate_decomposition({1: {1, 2}}, set(), [(1, 2)], 3)
        with self.assertRaisesRegex(ValueError, "uncovered"):
            stats.validate_decomposition({1: {1, 2}, 2: {2, 3}}, {(1, 2)}, [(1, 3)], 3)

    def test_tree_and_header_checks(self):
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

    def test_generation_records_parameter_table_and_seeds(self):
        with tempfile.TemporaryDirectory() as folder:
            output = Path(folder) / "collection"
            command = ["PW24-generator.py", "--output", str(output), "--k", "2", "3", "--n", "4",
                       "--edge-probabilities", "0.5", "1", "--replicates", "2", "--seed", "123"]
            with patch.object(sys, "argv", command), contextlib.redirect_stdout(io.StringIO()):
                grid.main()
            with (output / "families.tsv").open() as handle:
                families = list(csv.DictReader(handle, delimiter="\t"))
            self.assertEqual([r["instance_count"] for r in families], ["4", "4"])
            self.assertTrue(all(r["master_seed"] == "123" for r in families))
            self.assertEqual(len(list((output / "instances").rglob("*.lp"))), 8)
            self.assertIn(report.START, (output / "README.md").read_text())
            for path in (output / "instances").rglob("*.lp"):
                self.assertIn("% probarg master_seed=123", path.read_text())
                self.assertIn("% probarg seed=", path.read_text())

    def test_report_distinguishes_partial_analysis_and_failed_widths(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            families = [dict(family="first", instance_count="2"), dict(family="second", instance_count="1")]
            rows = []
            for i, family in enumerate(("first", "first", "second")):
                path = root / "instances" / family / f"example{i}.lp"
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text("arg(a).\np(a,1).\n")
                if i < 2:
                    rows.append(dict(family=family, instance_path=path.relative_to(root).as_posix(),
                                     instance_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                     argument_count="1", attack_count="0", weak_component_count="1",
                                     width_status="ok" if i == 0 else "timeout",
                                     decomposition_width="0" if i == 0 else ""))
            table = report.coverage(root, families, rows)
            self.assertEqual(table[0]["valid_widths"], 1)
            self.assertEqual(table[0]["other_width_statuses"], "timeout=1")
            self.assertEqual(table[1]["instances"], 1)
            self.assertEqual(table[1]["analyzed"], 0)
            self.assertEqual(table[1]["decomposition_width"], "pending")
            (root / rows[0]["instance_path"]).write_text("arg(b).\np(b,1).\n")
            with self.assertRaisesRegex(ValueError, "hash changed"):
                report.coverage(root, families, rows)

    def test_readme_report_replacement_preserves_authored_text(self):
        source = f"# My dataset\n\nMethods stay here.\n{report.START}\nOld report\n{report.END}\n\nCitation stays here.\n"
        updated = report.replace_report(source, "New tables\n")
        self.assertEqual(report.replace_report(updated, "New tables\n"), updated)
        self.assertIn("Methods stay here.", updated)
        self.assertIn("Citation stays here.", updated)
        self.assertNotIn("Old report", updated)
        with self.assertRaisesRegex(ValueError, "malformed"):
            report.replace_report(source + report.START, "New tables\n")


if __name__ == "__main__":
    unittest.main()
