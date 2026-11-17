"""Exact solver-log import and provenance checks."""

import csv
from fractions import Fraction
import hashlib
import importlib.util
from pathlib import Path
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
spec = importlib.util.spec_from_file_location("import_solver_logs", ROOT / "scripts/import_solver_logs.py")
importer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(importer)


def read_table(path):
    with path.open() as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


class SolverLogImportTests(unittest.TestCase):
    def make_dataset(self, root):
        dataset = root / "dataset"
        instances = dataset / "instances" / "grid_100"
        instances.mkdir(parents=True)
        bodies = {
            "first.lp": ("arg(a).\narg(b).\np(a,0.5).\np(b,0.5).\n"
                         "att(a,b).\np(0,a,b,0.5).\nextension(a).\nquery(b).\n"),
            "second.lp": "arg(a).\np(a,1).\nquery(a).\n",
        }
        rows = []
        for number, (name, body) in enumerate(bodies.items(), 1):
            path = instances / name
            path.write_text(body)
            rows.append(dict(instance_path=f"instances/grid_100/{name}", seed=str(number),
                             instance_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                             native_body_sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
        with (dataset / "generation_instances.tsv").open("w", newline="") as handle:
            writer = csv.DictWriter(handle, list(rows[0]), delimiter="\t", lineterminator="\n")
            writer.writeheader()
            writer.writerows(rows)
        return dataset

    def test_imports_exact_result_and_marks_missing_log_not_run(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            dataset = self.make_dataset(root)
            logs = root / "results" / "ver-td-COM"
            logs.mkdir(parents=True)
            (logs / "first.lp.ver-td-COM.log").write_text(
                "# command: python3 ../ver-td-COM/post_order.py /tmp/first.lp\n"
                "1 [[1, 2], 'leaf', 'children', []]\n"
                "RESULT 3/8\nLargest bag size: 2\n"
                "#   total CPU time (s): 1.250000\n"
                "#   real time (s): 1.500000\n"
                "#   peak process-group RSS (KiB): 2048\n"
                "#   child status: 0\n")
            labels = dataset / "labels" / "complete-extension-td-v1"
            analysis = dataset / "analysis" / "solver-td-v1"
            importer.import_logs(dataset, logs, labels, analysis, "https://example.test/repo",
                                 "abc123", 600, 8192)
            results = read_table(labels / "labels_results.tsv")
            self.assertEqual([row["status"] for row in results], ["ok", "not_run"])
            self.assertEqual(results[0]["probability_numerator"], "3")
            self.assertEqual(results[0]["probability_denominator"], "8")
            self.assertEqual(results[0]["probability_decimal"], "0.375")
            measurements = read_table(analysis / "analysis_instances.tsv")
            self.assertEqual(measurements[0]["argument_count"], "2")
            self.assertEqual(measurements[0]["decomposition_width"], "1")
            self.assertEqual(measurements[1]["width_status"], "not_run")

    def test_rejects_changed_instance(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            dataset = self.make_dataset(root)
            (dataset / "instances/grid_100/first.lp").write_text("arg(x).\np(x,1).\n")
            logs = root / "logs"
            logs.mkdir()
            (logs / "first.lp.ver-td-COM.log").write_text("unused\n")
            with self.assertRaisesRegex(ValueError, "hash mismatch"):
                importer.import_logs(dataset, logs, dataset / "labels/run", None,
                                     "https://example.test/repo", "abc123", 600, 8192)

    def test_exact_decimal_requires_terminating_fraction(self):
        self.assertEqual(importer.exact_decimal(Fraction(1, 20)), "0.05")
        with self.assertRaisesRegex(ValueError, "terminating"):
            importer.exact_decimal(Fraction(1, 3))


if __name__ == "__main__":
    unittest.main()
