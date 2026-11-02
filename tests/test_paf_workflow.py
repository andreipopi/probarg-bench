"""Tests for seed reproducibility and rejection of invalid width certificates."""

import importlib.util
from pathlib import Path
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


def load(name, relative):
    spec = importlib.util.spec_from_file_location(name, ROOT / relative)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


grid = load("paf_grid", "generators/paf_grid.py")
stats = load("paf_stats", "scripts/paf_stats.py")


class WorkflowTests(unittest.TestCase):
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


if __name__ == "__main__":
    unittest.main()
