from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import unittest
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

TOOLS_DIR = Path(__file__).resolve().parents[1]
MODULE_DIR = TOOLS_DIR.parent
SYNTHETIC_ROOT = Path(tempfile.gettempdir()).resolve() / "_ep_product_design_synthetic"
ENGINE = TOOLS_DIR / "product_design_store.py"
WRAPPER = TOOLS_DIR / "Invoke-ProductDesignStore.ps1"
sys.path.insert(0, str(TOOLS_DIR))

import product_design_store as store_module
from product_design_store import ProductDesignStore, StoreError, process_start_token


class ProductDesignStoreTests(unittest.TestCase):
    def setUp(self):
        SYNTHETIC_ROOT.mkdir(parents=True, exist_ok=True)
        self.workspace = SYNTHETIC_ROOT / self._testMethodName
        if self.workspace.exists():
            shutil.rmtree(self.workspace)
        self.workspace.mkdir(parents=True)
        self.store = ProductDesignStore(self.workspace, "SYNTHETIC-TERMINAL", test_mode=True)
        self.initialized = self.store.initialize({
            "topic": "Retoma de frente Product Design sin burocracia",
            "goal": "Reducir demoras conservando trazabilidad y control",
            "agent": "Carson",
            "engine": "bmad-brainstorming",
            "mode": "creative_partner",
            "tags": ["testmode", "retoma"],
        })
        self.project_id = self.initialized["project_id"]
        self.session_id = self.initialized["session_id"]

    def tearDown(self):
        if self.workspace.exists():
            shutil.rmtree(self.workspace)

    def cycle(self, number=1, text="Conservar un único punto de retoma verificable", **overrides):
        payload = {
            "project_id": self.project_id,
            "session_id": self.session_id,
            "cycle_number": number,
            "stage": "synthesis",
            "mode": "creative_partner",
            "techniques": ["How Might We"],
            "items": [{
                "type": "idea",
                "full_text": text,
                "author": "Carson",
                "maturity": "developing",
                "reusable": True,
                "provenance": {
                    "source": "ChatGPT conversation",
                    "technique": "How Might We",
                    "notes": "E2E TestMode; contenido sintético",
                },
            }],
            "open_questions": ["¿Qué evidencia mínima evita una falsa retoma?"],
            "decisions": ["No promover sin SHA y read-back"],
            "links_to_previous": [],
            "tags": ["testmode", "retoma"],
            "maturity": "developing",
            "session_status": "active",
        }
        payload.update(overrides)
        return payload

    def cli(self, operation, payload=None, env=None, timeout=30):
        command = [
            sys.executable, "-B", str(ENGINE),
            "--operation", operation,
            "--workspace-root", str(self.workspace),
            "--terminal-id", "SYNTHETIC-TERMINAL",
            "--test-mode",
        ]
        merged = os.environ.copy()
        if env:
            merged.update(env)
        return subprocess.run(
            command, input=json.dumps(payload or {}, ensure_ascii=False),
            capture_output=True, text=True, timeout=timeout, env=merged,
        )

    def ps(self):
        return shutil.which("powershell.exe") or shutil.which("powershell")

    def invoke_wrapper(self, operation, payload=None, timeout_seconds=30, env=None, timeout=40):
        powershell = self.ps()
        if not powershell:
            self.skipTest("Windows PowerShell is unavailable")
        command = [
            powershell, "-NoProfile", "-ExecutionPolicy", "Bypass",
            "-File", str(WRAPPER),
            "-Operation", operation,
            "-WorkspaceRoot", str(self.workspace),
            "-TerminalId", "SYNTHETIC-TERMINAL",
            "-TimeoutSeconds", str(timeout_seconds),
            "-TestMode",
            "-PayloadJson", json.dumps(payload or {}, ensure_ascii=False),
        ]
        merged = os.environ.copy()
        if env:
            merged.update(env)
        return subprocess.run(command, capture_output=True, text=True, timeout=timeout, env=merged)

    def test_initialize_and_savecycle_contract(self):
        self.assertEqual(self.initialized["title_origin"], "automatic")
        saved = self.store.save_cycle(self.cycle())
        self.assertTrue(saved["ok"])
        self.assertTrue(saved["index_updated"])
        self.assertTrue((self.workspace / saved["file"]).is_file())
        self.assertTrue(self.store.verify()["ok"])

    def test_idempotency_and_immutable_revision(self):
        first = self.store.save_cycle(self.cycle())
        repeated = self.store.save_cycle(self.cycle())
        self.assertTrue(repeated["idempotent"])
        self.assertEqual(first["version_id"], repeated["version_id"])
        revision = self.store.save_cycle(self.cycle(text="Ajustar el protocolo de evidencia y retoma"))
        self.assertEqual(revision["revision"], 2)
        self.assertTrue(self.store.verify()["ok"])
        self.assertEqual(len(self.store.show_session(self.session_id)["cycles"]), 2)

    def test_search_filters_project_tag_maturity_agent(self):
        self.store.save_cycle(self.cycle())
        results = self.store.search({
            "query": "retoma evidencia",
            "project_id": self.project_id,
            "tag": "retoma",
            "maturity": "developing",
            "agent": "Carson",
        })
        self.assertEqual(results["count"], 1)
        self.assertEqual(results["results"][0]["agent"], "Carson")

    def test_restoreversion_preserves_source(self):
        first = self.store.save_cycle(self.cycle())
        restored = self.store.restore_version(first["version_id"])
        self.assertEqual(restored["cycle_number"], 2)
        self.assertEqual(restored["restored_from_version_id"], first["version_id"])
        self.assertEqual(len(self.store.show_session(self.session_id)["cycles"]), 2)
        self.assertTrue(self.store.verify()["ok"])

    def test_strict_schema_rejects_unknown_fields_and_noncanonical_maturity(self):
        bad = self.cycle()
        bad["unapproved"] = True
        with self.assertRaisesRegex(StoreError, "UNKNOWN_FIELDS"):
            self.store.save_cycle(bad)
        bad = self.cycle()
        bad["maturity"] = "mature-draft"
        with self.assertRaisesRegex(StoreError, "MATURITY_INVALID"):
            self.store.save_cycle(bad)

    def test_verify_detects_fts_row_divergence_and_sqlite_integrity(self):
        self.store.save_cycle(self.cycle())
        with self.store.connection() as connection:
            connection.execute("DELETE FROM library_fts")
        result = self.store.verify()
        self.assertFalse(result["ok"])
        self.assertIn("SOURCE_INDEX_CONTENT_MISMATCH", result["issues"])
        self.store.rebuild_index()
        self.assertTrue(self.store.verify()["ok"])

    def test_fault_after_cycle_write_never_returns_false_success_and_recovers(self):
        result = self.cli("SaveCycle", self.cycle(), {"PRODUCT_DESIGN_FAULT_AT": "after_cycle_write"})
        self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
        error = json.loads(result.stdout.strip())
        self.assertFalse(error["ok"])
        self.assertIn("INJECTED_FAILURE_AFTER_CYCLE_WRITE", error["error"])
        self.assertTrue((self.workspace / ".product-design-journal.json").is_file())
        before = self.store.verify()
        self.assertFalse(before["ok"])
        self.assertTrue(before["pending_recovery"])
        self.store.rebuild_index()
        after = self.store.verify()
        self.assertTrue(after["ok"], after["issues"])
        self.assertFalse(after["pending_recovery"])
        self.assertEqual(len(self.store.show_session(self.session_id)["cycles"]), 1)

    def test_concurrent_writers_serialize_revision_numbers(self):
        barrier = threading.Barrier(4)
        def write(index):
            payload = self.cycle(number=1, text=f"Alternativa concurrente {index}")
            barrier.wait(timeout=5)
            result = self.cli("SaveCycle", payload, timeout=40)
            return result
        with ThreadPoolExecutor(max_workers=4) as pool:
            results = list(pool.map(write, range(4)))
        self.assertTrue(all(result.returncode == 0 for result in results),
                        "\n".join(r.stdout + r.stderr for r in results))
        parsed = [json.loads(result.stdout.strip()) for result in results]
        self.assertTrue(all(item["ok"] for item in parsed))
        revisions = sorted(item["revision"] for item in parsed)
        self.assertEqual(revisions, [1, 2, 3, 4])
        self.assertTrue(self.store.verify()["ok"])

    def test_lock_does_not_reclaim_live_process(self):
        alive, token = process_start_token(os.getpid())
        self.assertTrue(alive)
        self.store.lock_path.write_text(json.dumps({
            "pid": os.getpid(), "terminal_id": self.store.terminal_id,
            "created_unix": time.time() - 700, "process_start": token,
        }), encoding="utf-8")
        previous_wait = store_module.LOCK_WAIT_SECONDS
        store_module.LOCK_WAIT_SECONDS = 0.1
        try:
            with self.assertRaisesRegex(StoreError, "STORE_WRITER_LOCKED"):
                with self.store.writer_lock():
                    pass
        finally:
            store_module.LOCK_WAIT_SECONDS = previous_wait
            self.store.lock_path.unlink(missing_ok=True)

    def test_stale_lock_reclaimed_only_after_dead_owner_and_ttl(self):
        self.store.lock_path.write_text(json.dumps({
            "pid": 2147483000, "terminal_id": self.store.terminal_id,
            "created_unix": time.time() - 700, "process_start": "unknown",
        }), encoding="utf-8")
        with self.store.writer_lock():
            self.assertTrue(self.store.lock_path.is_file())
        self.assertFalse(self.store.lock_path.exists())

    def test_testmode_rejects_workspace_outside_synthetic_root(self):
        outside = Path(tempfile.gettempdir()) / "ep-product-design-not-synthetic"
        outside.mkdir(exist_ok=True)
        try:
            with self.assertRaisesRegex(StoreError, "TEST_MODE_WORKSPACE_OUTSIDE_TESTS"):
                ProductDesignStore(outside, "SYNTHETIC", test_mode=True)
        finally:
            outside.rmdir()

    def test_wrapper_executes_full_cli_flow_with_timeout_and_dual_pipe_drain(self):
        initialized = self.initialized
        payload = self.cycle(text="Ruta crítica → retoma íntegra; verificar SHA, lectura y versión en una única secuencia.")
        first = self.invoke_wrapper("SaveCycle", payload)
        self.assertEqual(first.returncode, 0, first.stdout + first.stderr)
        saved = json.loads(first.stdout.strip().splitlines()[-1])
        self.assertTrue(saved["index_updated"])
        shown = self.invoke_wrapper("ShowSession", {"session_id": initialized["session_id"]})
        self.assertEqual(shown.returncode, 0, shown.stdout + shown.stderr)
        self.assertEqual(len(json.loads(shown.stdout)["cycles"]), 1)
        verified = self.invoke_wrapper("Verify")
        self.assertEqual(verified.returncode, 0, verified.stdout + verified.stderr)
        self.assertTrue(json.loads(verified.stdout)["ok"])

    def test_wrapper_timeout_terminates_python_child(self):
        result = self.invoke_wrapper(
            "Verify", timeout_seconds=1,
            env={"PRODUCT_DESIGN_TEST_DELAY_SECONDS": "5"},
            timeout=15,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("PRODUCT_DESIGN_STORE_TIMEOUT", result.stdout + result.stderr)

    def test_production_mode_fails_closed_without_ep_verifier(self):
        powershell = self.ps()
        if not powershell:
            self.skipTest("Windows PowerShell is unavailable")
        command = [
            powershell, "-NoProfile", "-ExecutionPolicy", "Bypass",
            "-File", str(WRAPPER), "-Operation", "Verify",
            "-WorkspaceRoot", str(self.workspace), "-TerminalId", "SYNTHETIC",
        ]
        result = subprocess.run(command, capture_output=True, text=True, timeout=15)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("EP_PROTECTED_WORKSPACE_VERIFIER_NOT_INTEGRATED_TP_02B_PENDING",
                      result.stdout + result.stderr)


if __name__ == "__main__":
    unittest.main(verbosity=2)
