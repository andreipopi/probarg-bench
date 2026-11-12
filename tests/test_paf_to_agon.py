"""Check that visualization export preserves the PAF and rejects changed probabilities."""

from decimal import Decimal
import json
from pathlib import Path
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
from paf_to_agon import to_agon
from paf_stats import read_paf


class AgonExportTests(unittest.TestCase):
    def test_names_edges_and_probabilities_survive_json_round_trip(self):
        facts = """% a self-attack, reciprocal attacks, and an isolated argument
arg(a0).
arg(a2).
arg(a10).
p(a0,1).
p(a2,0.4).
p(a10,0.7).
att(a0,a0).
att(a0,a2).
att(a2,a0).
p(0,a0,a0,0.1).
p(1,a0,a2,0.6).
p(2,a2,a0,1).
extension(a2).
query(a0).
"""
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "example.lp"
            path.write_text(facts)
            arguments, attacks, _, _, pargs, patts, _ = read_paf(path)
            result = json.loads(json.dumps(to_agon(path)))
        nodes = result["arguments"]
        self.assertEqual([node["name"] for node in nodes.values()], ["a0", "a2", "a10"])
        self.assertEqual({node["name"] for node in nodes.values()}, arguments)
        self.assertEqual({node["name"]: Decimal(str(node["probability"]))
                          for node in nodes.values()}, pargs)
        restored = {(nodes[str(a)]["name"], nodes[str(b)]["name"]): Decimal(str(p))
                    for a, b, p in result["attacks"]}
        self.assertEqual(set(restored), attacks)
        self.assertEqual(restored, patts)
        self.assertIn("Candidate extension: {a2}", result["description"])
        self.assertIn("Query arguments: {a0}", result["description"])

    def test_rejects_probabilities_that_the_viewer_would_clamp(self):
        for value in ("0", "0.001"):
            with self.subTest(value=value), tempfile.TemporaryDirectory() as folder:
                path = Path(folder) / "example.lp"
                path.write_text(f"arg(a).\np(a,{value}).\n")
                with self.assertRaisesRegex(ValueError, "clamps probabilities"):
                    to_agon(path)


if __name__ == "__main__":
    unittest.main()
