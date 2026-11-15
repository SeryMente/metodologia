#!/usr/bin/env python3
"""Product Design store: canonical JSON records with a recoverable SQLite/FTS5 index."""
from __future__ import annotations

import argparse
import ctypes
import hashlib
import json
import os
import re
import secrets
import sqlite3
import stat
import sys
import tempfile
import time
import uuid
from collections import Counter
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterator

MODES = {"facilitator", "creative_partner", "ideate_for_me"}
MATURITIES = {"draft", "developing", "mature"}
STAGES = {"divergence", "convergence", "synthesis", "pause", "completed", "restore"}
AGENTS = {
    "Carson": "bmad-brainstorming",
    "Maya": "bmad-cis-design-thinking",
    "Dr. Quinn": "bmad-cis-problem-solving",
    "Victor": "bmad-cis-innovation-strategy",
    "Sophia": "bmad-cis-storytelling",
    "Caravaggio": "bmad-cis-agent-presentation-master",
}
ITEM_TYPES = {"idea", "insight", "question", "decision", "direction", "technique"}
TERMINAL_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$")
ID_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,79}$")
LOCK_TTL_SECONDS = 600
LOCK_WAIT_SECONDS = 30
JOURNAL_NAME = ".product-design-journal.json"


class StoreError(RuntimeError):
    pass


def now_iso() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds").replace("+00:00", "Z")


def uuid7() -> str:
    """Generate a sortable RFC 9562 UUIDv7 using Python 3.11 stdlib."""
    timestamp_ms = int(time.time() * 1000) & ((1 << 48) - 1)
    value = (timestamp_ms << 80) | secrets.randbits(76)
    value = (value & ~(0xF << 76)) | (7 << 76)
    value = (value & ~(0x3 << 62)) | (0x2 << 62)
    return str(uuid.UUID(int=value))


def canonical_json(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True,
                      separators=(",", ":"), allow_nan=False)


def sha256_json(value: Any) -> str:
    return hashlib.sha256(canonical_json(value).encode("utf-8")).hexdigest()


def slugify(value: str) -> str:
    text = re.sub(r"[^\w\s-]", "", value.casefold().strip(), flags=re.UNICODE)
    text = re.sub(r"[\s_]+", "-", text)
    return re.sub(r"-{2,}", "-", text).strip("-")[:72] or "ideacion"


def is_within(path: Path, root: Path) -> bool:
    try:
        return os.path.normcase(os.path.commonpath([str(path), str(root)])) == os.path.normcase(str(root))
    except ValueError:
        return False


def _is_reparse_point(path: Path) -> bool:
    try:
        info = path.lstat()
    except FileNotFoundError:
        return False
    if stat.S_ISLNK(info.st_mode):
        return True
    flags = getattr(info, "st_file_attributes", 0)
    return bool(flags & getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0x400))


def process_start_token(pid: int) -> tuple[bool | None, str | None]:
    """Return (alive, creation token); None means the OS could not verify."""
    if pid <= 0:
        return False, None
    if os.name == "nt":
        PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
        SYNCHRONIZE = 0x00100000
        STILL_ACTIVE = 259

        class FILETIME(ctypes.Structure):
            _fields_ = [("low", ctypes.c_uint32), ("high", ctypes.c_uint32)]

        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        kernel32.OpenProcess.restype = ctypes.c_void_p
        kernel32.OpenProcess.argtypes = [ctypes.c_uint32, ctypes.c_bool, ctypes.c_uint32]
        kernel32.CloseHandle.argtypes = [ctypes.c_void_p]
        handle = kernel32.OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION | SYNCHRONIZE, False, pid)
        if not handle:
            error = ctypes.get_last_error()
            if error == 87:
                return False, None
            if error == 5:
                return None, None
            return False, None
        try:
            exit_code = ctypes.c_uint32()
            if not kernel32.GetExitCodeProcess(handle, ctypes.byref(exit_code)):
                return None, None
            if exit_code.value != STILL_ACTIVE:
                return False, None
            created, exited, kernel, user = FILETIME(), FILETIME(), FILETIME(), FILETIME()
            if not kernel32.GetProcessTimes(
                handle, ctypes.byref(created), ctypes.byref(exited),
                ctypes.byref(kernel), ctypes.byref(user)
            ):
                return None, None
            token = (created.high << 32) | created.low
            return True, str(token)
        finally:
            kernel32.CloseHandle(handle)

    try:
        os.kill(pid, 0)
    except ProcessLookupError:
        return False, None
    except PermissionError:
        return None, None
    proc_stat = Path(f"/proc/{pid}/stat")
    if proc_stat.is_file():
        try:
            fields = proc_stat.read_text(encoding="ascii").split()
            return True, fields[21]
        except (OSError, IndexError):
            return None, None
    return True, None


def normalize_tags(values: Any) -> list[str]:
    if values is None:
        return []
    if not isinstance(values, list):
        raise StoreError("TAGS_MUST_BE_A_LIST")
    result: list[str] = []
    for value in values:
        if not isinstance(value, str) or not value.strip():
            raise StoreError("TAG_MUST_BE_NONEMPTY_STRING")
        tag = value.strip().casefold()
        if len(tag) > 80:
            raise StoreError("TAG_TOO_LONG")
        if tag not in result:
            result.append(tag)
    return result


def require_object(value: Any, label: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise StoreError(f"{label}_MUST_BE_OBJECT")
    return value


def strict_keys(payload: dict[str, Any], required: set[str], optional: set[str], label: str) -> None:
    missing = required - set(payload)
    extra = set(payload) - required - optional
    if missing:
        raise StoreError(f"{label}_MISSING_FIELDS:{','.join(sorted(missing))}")
    if extra:
        raise StoreError(f"{label}_UNKNOWN_FIELDS:{','.join(sorted(extra))}")


class ProductDesignStore:
    def __init__(self, workspace_root: str | Path, terminal_id: str,
                 test_mode: bool = False,
                 protected_workspace_verified: bool = False) -> None:
        if not TERMINAL_RE.fullmatch(terminal_id or ""):
            raise StoreError("INVALID_TERMINAL_ID")
        raw_root = Path(workspace_root).expanduser().absolute()
        if not raw_root.exists() or not raw_root.is_dir():
            raise StoreError("WORKSPACE_ROOT_MUST_ALREADY_EXIST")
        if _is_reparse_point(raw_root):
            raise StoreError("WORKSPACE_ROOT_REPARSE_POINT_REJECTED")
        self.root = raw_root.resolve(strict=True)
        self.terminal_id = terminal_id
        self.test_mode = test_mode
        if test_mode:
            allowed_tests = (Path(__file__).resolve().parent / "tests").resolve()
            allowed_temp = (Path(tempfile.gettempdir()).resolve() / "_ep_product_design_synthetic")
            if not (is_within(self.root, allowed_tests) or is_within(self.root, allowed_temp)):
                raise StoreError("TEST_MODE_WORKSPACE_OUTSIDE_TESTS")
        else:
            if not protected_workspace_verified:
                raise StoreError("PROTECTED_WORKSPACE_GATE_CLOSED")
            parts = [part.casefold() for part in self.root.parts]
            required = ["serymente", "metodologia", "frentes", "ep", "modulos",
                        "mod-ep-product-design", "data", terminal_id.casefold(), "brainstorming"]
            if not any(parts[i:i + len(required)] == required
                       for i in range(len(parts) - len(required) + 1)):
                raise StoreError("WORKSPACE_PATH_DOES_NOT_MATCH_EP_PRODUCT_DESIGN_LAYOUT")

        self.projects_root = self._safe("projects")
        self.library_root = self._safe("library")
        self.database_path = self._safe("library/library.sqlite")
        self.lock_path = self._safe(".product-design-writer.lock")
        self.journal_path = self._safe(JOURNAL_NAME)

    def _safe(self, relative: str | Path) -> Path:
        lexical = Path(os.path.abspath(self.root / relative))
        if not is_within(lexical, self.root):
            raise StoreError(f"PATH_ESCAPES_WORKSPACE:{relative}")
        probe = self.root
        for part in lexical.relative_to(self.root).parts:
            probe = probe / part
            if _is_reparse_point(probe):
                raise StoreError(f"REPARSE_POINT_REJECTED:{probe}")
        resolved = lexical.resolve(strict=False)
        if not is_within(resolved, self.root):
            raise StoreError(f"PATH_ESCAPES_WORKSPACE:{relative}")
        return resolved

    def _ensure_parent(self, path: Path) -> None:
        safe = self._safe(path.relative_to(self.root))
        safe.parent.mkdir(parents=True, exist_ok=True)
        self._safe(safe.relative_to(self.root))

    @contextmanager
    def writer_lock(self) -> Iterator[None]:
        self._safe(self.lock_path.relative_to(self.root))
        deadline = time.monotonic() + LOCK_WAIT_SECONDS
        while True:
            try:
                fd = os.open(str(self.lock_path), os.O_CREAT | os.O_EXCL | os.O_WRONLY)
                break
            except FileExistsError as exc:
                try:
                    record = self._read_json(self.lock_path)
                    age = time.time() - float(record.get("created_unix", 0))
                    pid = int(record.get("pid", 0))
                    alive, token = process_start_token(pid)
                    original_token = record.get("process_start")
                    owner_confirmed_dead = alive is False or (
                        alive is True and original_token is not None and token is not None
                        and token != original_token
                    )
                    if age > LOCK_TTL_SECONDS and owner_confirmed_dead:
                        self.lock_path.unlink(missing_ok=True)
                        continue
                except (OSError, ValueError, StoreError, json.JSONDecodeError):
                    # Unknown lock state is deliberately not reclaimed.
                    pass
                if time.monotonic() >= deadline:
                    raise StoreError("STORE_WRITER_LOCKED_OR_OWNER_UNVERIFIABLE") from exc
                time.sleep(0.05)

        metadata = {
            "pid": os.getpid(), "terminal_id": self.terminal_id,
            "created_at": now_iso(), "created_unix": time.time(),
            "process_start": process_start_token(os.getpid())[1],
        }
        try:
            with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as stream:
                stream.write(canonical_json(metadata) + "\n")
                stream.flush()
                os.fsync(stream.fileno())
            yield
        finally:
            try:
                self.lock_path.unlink()
            except FileNotFoundError:
                pass

    def _write_json_atomic(self, path: Path, value: Any) -> None:
        path = self._safe(path.relative_to(self.root))
        self._ensure_parent(path)
        payload = (canonical_json(value) + "\n").encode("utf-8")
        fd, temp_name = tempfile.mkstemp(prefix=".pending-", suffix=".json", dir=str(path.parent))
        temp_path = Path(temp_name)
        try:
            with os.fdopen(fd, "wb") as stream:
                stream.write(payload)
                stream.flush()
                os.fsync(stream.fileno())
            self._safe(temp_path.relative_to(self.root))
            os.replace(str(temp_path), str(path))
            try:
                dir_fd = os.open(str(path.parent), os.O_RDONLY)
                try:
                    os.fsync(dir_fd)
                finally:
                    os.close(dir_fd)
            except OSError:
                pass
        finally:
            if temp_path.exists():
                temp_path.unlink()

    @staticmethod
    def _read_json(path: Path) -> dict[str, Any]:
        try:
            value = json.loads(path.read_text(encoding="utf-8"))
        except FileNotFoundError as exc:
            raise StoreError(f"FILE_NOT_FOUND:{path.name}") from exc
        except (OSError, json.JSONDecodeError) as exc:
            raise StoreError(f"INVALID_JSON:{path.name}:{exc}") from exc
        return require_object(value, "JSON_ROOT")

    def _connect(self, create: bool = True) -> sqlite3.Connection:
        self._safe(self.database_path.relative_to(self.root))
        if not create and not self.database_path.is_file():
            raise StoreError("LIBRARY_DATABASE_NOT_FOUND")
        self._ensure_parent(self.database_path)
        connection = sqlite3.connect(str(self.database_path), timeout=15)
        connection.row_factory = sqlite3.Row
        connection.execute("PRAGMA foreign_keys=ON")
        connection.execute("PRAGMA synchronous=FULL")
        connection.execute("PRAGMA journal_mode=DELETE")
        existing = connection.execute(
            "SELECT sql FROM sqlite_master WHERE type='table' AND name='library_fts'"
        ).fetchone()
        if existing:
            columns = {row[1] for row in connection.execute("PRAGMA table_info(library_fts)")}
            required = {"project_id", "session_id", "cycle_id", "version_id",
                        "project_title", "topic", "goal", "content", "tags", "maturity", "agent"}
            if columns != required:
                connection.execute("DROP TABLE library_fts")
        try:
            connection.execute("""
                CREATE VIRTUAL TABLE IF NOT EXISTS library_fts USING fts5(
                    project_id UNINDEXED, session_id UNINDEXED,
                    cycle_id UNINDEXED, version_id UNINDEXED,
                    project_title, topic, goal, content, tags,
                    maturity UNINDEXED, agent UNINDEXED,
                    tokenize='unicode61'
                )
            """)
        except sqlite3.OperationalError as exc:
            connection.close()
            raise StoreError(f"SQLITE_FTS5_UNAVAILABLE:{exc}") from exc
        return connection

    @contextmanager
    def connection(self, create: bool = True) -> Iterator[sqlite3.Connection]:
        connection = self._connect(create=create)
        try:
            yield connection
            connection.commit()
        except Exception:
            connection.rollback()
            raise
        finally:
            connection.close()

    @staticmethod
    def _validate_id(value: Any, label: str) -> None:
        if not isinstance(value, str) or not ID_RE.fullmatch(value):
            raise StoreError(f"INVALID_{label}")

    def _project_file(self, project_id: str) -> Path:
        self._validate_id(project_id, "PROJECT_ID")
        return self._safe(Path("projects") / project_id / "project.json")

    def _session_file(self, project_id: str, session_id: str) -> Path:
        self._validate_id(project_id, "PROJECT_ID")
        self._validate_id(session_id, "SESSION_ID")
        return self._safe(Path("projects") / project_id / "sessions" / session_id / "session.json")

    def _cycle_files(self, session_file: Path) -> list[Path]:
        cycles_dir = self._safe(session_file.parent / "cycles")
        if not cycles_dir.exists():
            return []
        files = []
        for candidate in sorted(cycles_dir.glob("*.json")):
            safe = self._safe(candidate.relative_to(self.root))
            files.append(safe)
        return files

    @staticmethod
    def _default_tags(topic: str, maturity: str, extra: Any) -> list[str]:
        tags = ["lluvia-de-ideas", f"tema:{slugify(topic)}", f"madurez:{maturity}"]
        for tag in normalize_tags(extra):
            if tag not in tags:
                tags.append(tag)
        return tags

    def _record_paths(self, project_id: str, session_id: str) -> tuple[Path, Path]:
        return self._project_file(project_id), self._session_file(project_id, session_id)

    def _journal(self, writes: list[dict[str, Any]]) -> None:
        self._write_json_atomic(self.journal_path, {
            "journal_id": uuid7(), "created_at": now_iso(), "writes": writes,
        })

    def _commit_records(self, writes: list[dict[str, Any]], cycle_context: dict[str, Any] | None = None) -> None:
        self._journal(writes)
        cycle_written = False
        for record in writes:
            target = self._safe(record["path"])
            self._write_json_atomic(target, record["value"])
            if target.name.endswith(".json") and "cycles" in target.parts:
                cycle_written = True
            fault = os.environ.get("PRODUCT_DESIGN_FAULT_AT", "")
            if fault == "after_first_write" and record is writes[0]:
                raise StoreError("INJECTED_FAILURE_AFTER_FIRST_WRITE")
            if fault == "after_cycle_write" and cycle_written:
                raise StoreError("INJECTED_FAILURE_AFTER_CYCLE_WRITE")
        if cycle_context:
            project, session, cycle = cycle_context["project"], cycle_context["session"], cycle_context["cycle"]
            with self.connection() as connection:
                self._index_cycle(connection, project, session, cycle)
                self._assert_version_index(connection, cycle["version_id"])
        else:
            with self.connection() as connection:
                connection.execute("SELECT count(*) FROM library_fts").fetchone()
        # Verify the committed state before removing the recovery journal.
        result = self._verify_core(ignore_journal=True)
        if result["issues"]:
            raise StoreError("POST_COMMIT_VERIFY_FAILED:" + "|".join(result["issues"]))
        self.journal_path.unlink(missing_ok=True)

    def _recover_pending_locked(self) -> None:
        if not self.journal_path.is_file():
            return
        journal = self._read_json(self.journal_path)
        writes = journal.get("writes")
        if not isinstance(writes, list) or not writes:
            raise StoreError("RECOVERY_JOURNAL_INVALID")
        for record in writes:
            if not isinstance(record, dict) or set(record) != {"path", "value"}:
                raise StoreError("RECOVERY_JOURNAL_RECORD_INVALID")
            self._write_json_atomic(self._safe(record["path"]), record["value"])
        self._rebuild_index_locked()
        result = self._verify_core(ignore_journal=True)
        if result["issues"]:
            raise StoreError("RECOVERY_VERIFY_FAILED:" + "|".join(result["issues"]))
        self.journal_path.unlink(missing_ok=True)

    def initialize(self, payload: dict[str, Any]) -> dict[str, Any]:
        payload = require_object(payload, "INITIALIZE")
        strict_keys(payload, {"topic", "agent", "engine", "mode"},
                    {"goal", "project_title", "maturity", "tags"}, "INITIALIZE")
        topic = payload["topic"]
        if not isinstance(topic, str) or not topic.strip():
            raise StoreError("TOPIC_REQUIRED")
        agent, engine = payload["agent"], payload["engine"]
        if agent not in AGENTS or AGENTS[agent] != engine:
            raise StoreError("AGENT_ENGINE_MISMATCH")
        mode = payload["mode"]
        if mode not in MODES:
            raise StoreError("INVALID_MODE")
        maturity = payload.get("maturity", "draft")
        if maturity not in MATURITIES:
            raise StoreError("INVALID_MATURITY")
        goal = payload.get("goal", "")
        if not isinstance(goal, str):
            raise StoreError("GOAL_MUST_BE_STRING")
        project_id, session_id = uuid7(), uuid7()
        project_file, session_file = self._record_paths(project_id, session_id)
        title = payload.get("project_title") or f"{topic.strip()[:72]} — {datetime.now():%Y-%m-%d}"
        if not isinstance(title, str) or not title.strip():
            raise StoreError("PROJECT_TITLE_INVALID")
        tags = self._default_tags(topic.strip(), maturity, payload.get("tags"))
        created = now_iso()
        project = {
            "project_id": project_id, "title": title.strip(),
            "title_origin": "operator" if payload.get("project_title") else "automatic",
            "created_at": created, "updated_at": created, "tags": tags,
            "status": "active", "latest_version": None,
        }
        session = {
            "session_id": session_id, "project_id": project_id,
            "topic": topic.strip(), "goal": goal, "agent": agent, "engine": engine,
            "mode": mode, "status": "active", "created_at": created, "updated_at": created,
            "last_saved_cycle": 0, "last_saved_version": None, "tags": tags,
        }
        with self.writer_lock():
            self._recover_pending_locked()
            self._commit_records([
                {"path": str(project_file.relative_to(self.root)), "value": project},
                {"path": str(session_file.relative_to(self.root)), "value": session},
            ])
        return {
            "ok": True, "project_id": project_id, "session_id": session_id,
            "project_title": project["title"], "title_origin": project["title_origin"],
            "tags": tags, "workspace_root": str(self.root),
        }

    @staticmethod
    def _fts_text(cycle: dict[str, Any]) -> str:
        fragments = [str(item.get("full_text", "")) for item in cycle.get("items", [])]
        fragments.extend(str(x) for x in cycle.get("open_questions", []))
        fragments.extend(str(x) for x in cycle.get("decisions", []))
        fragments.extend(str(x) for x in cycle.get("techniques", []))
        return "\n".join(fragment for fragment in fragments if fragment)

    def _fts_row(self, project: dict[str, Any], session: dict[str, Any],
                 cycle: dict[str, Any]) -> tuple[str, ...]:
        return (
            cycle["project_id"], cycle["session_id"], cycle["cycle_id"], cycle["version_id"],
            project["title"], session["topic"], session.get("goal", ""), self._fts_text(cycle),
            " ".join(cycle.get("tags", [])), cycle["maturity"], session["agent"],
        )

    def _index_cycle(self, connection: sqlite3.Connection, project: dict[str, Any],
                     session: dict[str, Any], cycle: dict[str, Any]) -> None:
        connection.execute("DELETE FROM library_fts WHERE version_id=?", (cycle["version_id"],))
        connection.execute("""
            INSERT INTO library_fts
            (project_id, session_id, cycle_id, version_id, project_title, topic,
             goal, content, tags, maturity, agent)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, self._fts_row(project, session, cycle))

    @staticmethod
    def _validate_cycle_payload(payload: dict[str, Any]) -> None:
        required = {"project_id", "session_id", "cycle_number", "stage", "mode",
                    "techniques", "items", "open_questions", "decisions",
                    "links_to_previous", "tags", "maturity", "session_status"}
        strict_keys(payload, required, {"restored_from_version_id"}, "SAVE_CYCLE")
        if isinstance(payload["cycle_number"], bool) or not isinstance(payload["cycle_number"], int) or payload["cycle_number"] < 1:
            raise StoreError("CYCLE_NUMBER_INVALID")
        if payload["stage"] not in STAGES or payload["mode"] not in MODES:
            raise StoreError("STAGE_OR_MODE_INVALID")
        if payload["maturity"] not in MATURITIES:
            raise StoreError("MATURITY_INVALID")
        if payload["session_status"] not in {"active", "paused", "completed"}:
            raise StoreError("SESSION_STATUS_INVALID")
        for field in ("techniques", "items", "open_questions", "decisions", "links_to_previous", "tags"):
            if not isinstance(payload[field], list):
                raise StoreError(f"{field.upper()}_MUST_BE_LIST")
        for item in payload["items"]:
            require_object(item, "ITEM")
            strict_keys(item, {"type", "full_text", "author", "maturity", "reusable", "provenance"},
                        {"item_id"}, "ITEM")
            if item["type"] not in ITEM_TYPES:
                raise StoreError("ITEM_TYPE_INVALID")
            if not isinstance(item["full_text"], str) or not item["full_text"].strip():
                raise StoreError("ITEM_FULL_TEXT_REQUIRED")
            if item["maturity"] not in MATURITIES:
                raise StoreError("ITEM_MATURITY_INVALID")
            if not isinstance(item["author"], str) or not item["author"].strip():
                raise StoreError("ITEM_AUTHOR_REQUIRED")
            if not isinstance(item["reusable"], bool):
                raise StoreError("ITEM_REUSABLE_MUST_BE_BOOLEAN")
            provenance = require_object(item["provenance"], "PROVENANCE")
            strict_keys(provenance, {"source", "technique", "notes"}, set(), "PROVENANCE")
            if not all(isinstance(provenance[k], str) for k in ("source", "technique", "notes")):
                raise StoreError("PROVENANCE_FIELDS_MUST_BE_STRINGS")

    def save_cycle(self, payload: dict[str, Any]) -> dict[str, Any]:
        payload = require_object(payload, "SAVE_CYCLE")
        self._validate_cycle_payload(payload)
        project_id, session_id = payload["project_id"], payload["session_id"]
        self._validate_id(project_id, "PROJECT_ID")
        self._validate_id(session_id, "SESSION_ID")
        with self.writer_lock():
            self._recover_pending_locked()
            return self._save_cycle_locked(payload)

    def _save_cycle_locked(self, payload: dict[str, Any]) -> dict[str, Any]:
        project_id, session_id = payload["project_id"], payload["session_id"]
        project_file, session_file = self._record_paths(project_id, session_id)
        project, session = self._read_json(project_file), self._read_json(session_file)
        if session.get("project_id") != project_id or session.get("agent") not in AGENTS:
            raise StoreError("SESSION_PROJECT_OR_AGENT_MISMATCH")
        if payload["mode"] != session["mode"]:
            raise StoreError("SESSION_MODE_MISMATCH")
        if payload["session_status"] not in {"active", "paused", "completed"}:
            raise StoreError("SESSION_STATUS_INVALID")
        for item in payload["items"]:
            if item["author"] not in {"operator", session["agent"]}:
                raise StoreError("ITEM_AUTHOR_NOT_IN_SESSION")
        cycle_number = payload["cycle_number"]
        normalized_items = []
        for item in payload["items"]:
            normalized_items.append({
                "item_id": item.get("item_id") or "item-" + sha256_json(item)[:24],
                "type": item["type"], "full_text": item["full_text"],
                "author": item["author"], "maturity": item["maturity"],
                "reusable": item["reusable"], "provenance": item["provenance"],
            })
        tags = self._default_tags(session["topic"], payload["maturity"], payload["tags"])
        material = {
            "project_id": project_id, "session_id": session_id,
            "cycle_number": cycle_number, "stage": payload["stage"], "mode": payload["mode"],
            "techniques": payload["techniques"], "items": normalized_items,
            "open_questions": payload["open_questions"], "decisions": payload["decisions"],
            "links_to_previous": payload["links_to_previous"], "tags": tags,
            "maturity": payload["maturity"],
            "restored_from_version_id": payload.get("restored_from_version_id"),
        }
        payload_hash = sha256_json(material)
        same_number = []
        for cycle_file in self._cycle_files(session_file):
            old = self._read_json(cycle_file)
            if int(old.get("cycle_number", -1)) == cycle_number:
                same_number.append(old)
                if old.get("idempotency_sha256") == payload_hash:
                    return {
                        "ok": True, "idempotent": True, "cycle_id": old["cycle_id"],
                        "version_id": old["version_id"], "cycle_number": cycle_number,
                        "revision": old["revision"], "sha256": old["integrity"]["sha256"],
                        "file": str(cycle_file.relative_to(self.root)), "index_updated": True,
                    }
        revision = max([int(c.get("revision", 0)) for c in same_number] + [0]) + 1
        saved_at = now_iso()
        cycle = {
            "record_type": "product-design-cycle", "cycle_id": uuid7(), "version_id": uuid7(),
            **material, "agent": session["agent"], "engine": session["engine"],
            "revision": revision, "saved_at": saved_at, "idempotency_sha256": payload_hash,
        }
        content_hash = sha256_json(cycle)
        cycle["integrity"] = {"algorithm": "sha256", "sha256": content_hash}
        cycle_file = self._safe(
            Path("projects") / project_id / "sessions" / session_id / "cycles" /
            f"{cycle_number:06d}-r{revision:03d}.json"
        )
        session_new = dict(session)
        session_new.update({
            "updated_at": saved_at,
            "last_saved_cycle": max(int(session.get("last_saved_cycle", 0)), cycle_number),
            "last_saved_version": cycle["version_id"],
            "status": payload["session_status"], "tags": tags,
        })
        project_new = dict(project)
        project_new.update({
            "updated_at": saved_at, "latest_version": cycle["version_id"],
            "tags": list(dict.fromkeys(project.get("tags", []) + tags)),
        })
        writes = [
            {"path": str(cycle_file.relative_to(self.root)), "value": cycle},
            {"path": str(session_file.relative_to(self.root)), "value": session_new},
            {"path": str(project_file.relative_to(self.root)), "value": project_new},
        ]
        self._commit_records(writes, {"project": project_new, "session": session_new, "cycle": cycle})
        return {
            "ok": True, "idempotent": False, "cycle_id": cycle["cycle_id"],
            "version_id": cycle["version_id"], "cycle_number": cycle_number,
            "revision": revision, "sha256": content_hash,
            "file": str(cycle_file.relative_to(self.root)), "index_updated": True,
        }

    def _iter_cycles(self) -> Iterator[tuple[Path, dict[str, Any], dict[str, Any], dict[str, Any]]]:
        if not self.projects_root.exists():
            return
        for project_file in sorted(self.projects_root.glob("*/project.json")):
            self._safe(project_file.relative_to(self.root))
            project = self._read_json(project_file)
            sessions_dir = self._safe(project_file.parent / "sessions")
            if not sessions_dir.exists():
                continue
            for session_file in sorted(sessions_dir.glob("*/session.json")):
                self._safe(session_file.relative_to(self.root))
                session = self._read_json(session_file)
                for cycle_file in self._cycle_files(session_file):
                    cycle = self._read_json(cycle_file)
                    yield cycle_file, project, session, cycle

    def _assert_version_index(self, connection: sqlite3.Connection, version_id: str) -> None:
        count = connection.execute(
            "SELECT count(*) FROM library_fts WHERE version_id=?", (version_id,)
        ).fetchone()[0]
        if count != 1:
            raise StoreError(f"INDEX_VERSION_NOT_UNIQUE:{version_id}")

    def _rebuild_index_locked(self) -> dict[str, Any]:
        count = 0
        with self.connection() as connection:
            connection.execute("DELETE FROM library_fts")
            for cycle_file, project, session, cycle in self._iter_cycles():
                body = dict(cycle)
                integrity = body.pop("integrity", {})
                if sha256_json(body) != integrity.get("sha256"):
                    raise StoreError(f"CYCLE_HASH_MISMATCH:{cycle_file.name}")
                self._index_cycle(connection, project, session, cycle)
                count += 1
            result = connection.execute("PRAGMA integrity_check").fetchone()[0]
            if result != "ok":
                raise StoreError(f"SQLITE_INTEGRITY_CHECK_FAILED:{result}")
        return {"ok": True, "indexed_cycles": count,
                "database": str(self.database_path.relative_to(self.root))}

    def rebuild_index(self) -> dict[str, Any]:
        with self.writer_lock():
            self._recover_pending_locked()
            return self._rebuild_index_locked()

    def _verify_core(self, ignore_journal: bool = False) -> dict[str, Any]:
        issues: list[str] = []
        expected: list[tuple[str, ...]] = []
        source_cycles = 0
        try:
            for cycle_file, project, session, cycle in self._iter_cycles():
                source_cycles += 1
                body = dict(cycle)
                integrity = body.pop("integrity", {})
                if integrity.get("algorithm") != "sha256" or sha256_json(body) != integrity.get("sha256"):
                    issues.append(f"HASH_MISMATCH:{cycle_file.name}")
                if cycle.get("project_id") != project.get("project_id"):
                    issues.append(f"PROJECT_MISMATCH:{cycle_file.name}")
                if cycle.get("session_id") != session.get("session_id"):
                    issues.append(f"SESSION_MISMATCH:{cycle_file.name}")
                if cycle.get("agent") != session.get("agent") or cycle.get("engine") != session.get("engine"):
                    issues.append(f"AGENT_ENGINE_MISMATCH:{cycle_file.name}")
                expected.append(self._fts_row(project, session, cycle))
        except (OSError, StoreError, ValueError, TypeError) as exc:
            issues.append(f"SOURCE_READ_ERROR:{exc}")
        if not self.database_path.is_file():
            issues.append("LIBRARY_DATABASE_NOT_FOUND")
            index_count = 0
            sqlite_integrity = "missing"
        else:
            try:
                with self.connection(create=False) as connection:
                    rows = connection.execute("""
                        SELECT project_id, session_id, cycle_id, version_id, project_title,
                               topic, goal, content, tags, maturity, agent FROM library_fts
                    """).fetchall()
                    actual = [tuple(row) for row in rows]
                    index_count = len(actual)
                    if Counter(actual) != Counter(expected):
                        issues.append("SOURCE_INDEX_CONTENT_MISMATCH")
                    sqlite_integrity = connection.execute("PRAGMA integrity_check").fetchone()[0]
                    if sqlite_integrity != "ok":
                        issues.append(f"SQLITE_INTEGRITY_CHECK:{sqlite_integrity}")
                    try:
                        connection.execute("INSERT INTO library_fts(library_fts) VALUES('integrity-check')")
                    except sqlite3.Error as exc:
                        issues.append(f"FTS5_INTEGRITY_CHECK:{exc}")
            except sqlite3.Error as exc:
                index_count = 0
                sqlite_integrity = "error"
                issues.append(f"SQLITE_READ_ERROR:{exc}")
        if self.journal_path.exists() and not ignore_journal:
            issues.append("PENDING_RECOVERY_JOURNAL")
        return {
            "ok": not issues, "source_cycles": source_cycles, "index_entries": index_count,
            "issues": issues, "sqlite_integrity": sqlite_integrity,
            "source_index_consistent": "SOURCE_INDEX_CONTENT_MISMATCH" not in issues,
            "pending_recovery": self.journal_path.exists(),
            "database": str(self.database_path.relative_to(self.root)),
        }

    def verify(self) -> dict[str, Any]:
        with self.writer_lock():
            return self._verify_core()

    def search(self, payload: dict[str, Any]) -> dict[str, Any]:
        payload = require_object(payload, "SEARCH")
        strict_keys(payload, {"query"}, {"limit", "project_id", "tag", "maturity", "agent"}, "SEARCH")
        query = payload["query"]
        if not isinstance(query, str) or not query.strip():
            raise StoreError("SEARCH_QUERY_REQUIRED")
        if payload.get("maturity") is not None and payload["maturity"] not in MATURITIES:
            raise StoreError("SEARCH_MATURITY_INVALID")
        if payload.get("agent") is not None and payload["agent"] not in AGENTS:
            raise StoreError("SEARCH_AGENT_INVALID")
        limit = payload.get("limit", 20)
        if isinstance(limit, bool) or not isinstance(limit, int):
            raise StoreError("SEARCH_LIMIT_INVALID")
        limit = max(1, min(limit, 100))
        tokens = re.findall(r"[\w-]+", query, flags=re.UNICODE)
        if not tokens:
            raise StoreError("SEARCH_QUERY_HAS_NO_TERMS")
        expression = " OR ".join('"' + token.replace('"', '""') + '"' for token in tokens)
        clauses = ["library_fts MATCH ?"]
        params: list[Any] = [expression]
        for field in ("project_id", "tag", "maturity", "agent"):
            if payload.get(field) is not None:
                if not isinstance(payload[field], str) or not payload[field].strip():
                    raise StoreError(f"SEARCH_{field.upper()}_INVALID")
                if field == "tag":
                    clauses.append("instr(' ' || tags || ' ', ' ' || ? || ' ') > 0")
                elif field == "agent":
                    clauses.append("lower(agent) = ?")
                else:
                    clauses.append(f"{field} = ?")
                params.append(payload[field].casefold() if field in {"tag", "maturity", "agent"} else payload[field])
        params.append(limit)
        sql = f"""SELECT project_id, session_id, cycle_id, version_id, project_title,
                         topic, goal, maturity, agent,
                         snippet(library_fts, 7, '[', ']', ' … ', 18) AS excerpt
                  FROM library_fts WHERE {' AND '.join(clauses)}
                  ORDER BY bm25(library_fts) LIMIT ?"""
        with self.connection(create=False) as connection:
            rows = connection.execute(sql, params).fetchall()
        return {"ok": True, "query": query, "count": len(rows),
                "results": [dict(row) for row in rows]}

    def restore_version(self, version_id: str) -> dict[str, Any]:
        if not isinstance(version_id, str) or not version_id:
            raise StoreError("VERSION_ID_REQUIRED")
        with self.writer_lock():
            self._recover_pending_locked()
            target = None
            for _, project, session, cycle in self._iter_cycles():
                if cycle.get("version_id") == version_id:
                    target = (project, session, cycle)
                    break
            if not target:
                raise StoreError("VERSION_NOT_FOUND")
            project, session, cycle = target
            session_file = self._session_file(project["project_id"], session["session_id"])
            next_number = max(
                [int(self._read_json(p).get("cycle_number", 0)) for p in self._cycle_files(session_file)] + [0]
            ) + 1
            payload = {
                "project_id": project["project_id"], "session_id": session["session_id"],
                "cycle_number": next_number, "stage": "restore", "mode": cycle["mode"],
                "techniques": cycle["techniques"], "items": cycle["items"],
                "open_questions": cycle["open_questions"], "decisions": cycle["decisions"],
                "links_to_previous": list(cycle["links_to_previous"]) + [cycle["cycle_id"]],
                "tags": cycle["tags"], "maturity": cycle["maturity"],
                "session_status": session["status"], "restored_from_version_id": version_id,
            }
            result = self._save_cycle_locked(payload)
        result["restored_from_version_id"] = version_id
        return result

    def list_projects(self) -> dict[str, Any]:
        projects = []
        if self.projects_root.exists():
            for project_file in sorted(self.projects_root.glob("*/project.json")):
                self._safe(project_file.relative_to(self.root))
                projects.append(self._read_json(project_file))
        return {"ok": True, "count": len(projects), "projects": projects}

    def show_session(self, session_id: str) -> dict[str, Any]:
        self._validate_id(session_id, "SESSION_ID")
        with self.writer_lock():
            project_file = None
            for candidate in sorted(self.projects_root.glob("*/project.json")):
                self._safe(candidate.relative_to(self.root))
                project = self._read_json(candidate)
                session_file = self._session_file(project["project_id"], session_id)
                if session_file.is_file():
                    project_file = candidate
                    break
            if project_file is None:
                raise StoreError("SESSION_NOT_FOUND")
            project = self._read_json(project_file)
            session_file = self._session_file(project["project_id"], session_id)
            cycles = []
            for cycle_file in self._cycle_files(session_file):
                cycle = self._read_json(cycle_file)
                body = dict(cycle)
                integrity = body.pop("integrity", {})
                if sha256_json(body) != integrity.get("sha256"):
                    raise StoreError(f"SHOW_SESSION_HASH_MISMATCH:{cycle_file.name}")
                cycles.append(cycle)
            cycles.sort(key=lambda value: (value["cycle_number"], value["revision"]))
            return {"ok": True, "project": project, "session": self._read_json(session_file), "cycles": cycles}


def run_cli() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--operation", required=True, choices=[
        "Initialize", "SaveCycle", "Search", "RebuildIndex", "Verify",
        "RestoreVersion", "ListProjects", "ShowSession",
    ])
    parser.add_argument("--workspace-root", required=True)
    parser.add_argument("--terminal-id", required=True)
    parser.add_argument("--payload-file", help="Read UTF-8 JSON from a file instead of redirected stdin")
    parser.add_argument("--test-mode", action="store_true")
    parser.add_argument("--protected-workspace-verified", action="store_true",
                        help=argparse.SUPPRESS)
    args = parser.parse_args()
    # This CLI is normally consumed by PowerShell through redirected pipes on Windows.
    # Force UTF-8 so valid Spanish/Unicode JSON never depends on the active OEM code page.
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="backslashreplace")
    if hasattr(sys.stderr, "reconfigure"):
        sys.stderr.reconfigure(encoding="utf-8", errors="backslashreplace")
    try:
        if args.test_mode and os.environ.get("PRODUCT_DESIGN_TEST_DELAY_SECONDS"):
            time.sleep(float(os.environ["PRODUCT_DESIGN_TEST_DELAY_SECONDS"]))
        raw = (Path(args.payload_file).read_text(encoding="utf-8")
               if args.payload_file else sys.stdin.read())
        payload = json.loads(raw) if raw.strip() else {}
        payload = require_object(payload, "PAYLOAD_ROOT")
        store = ProductDesignStore(
            args.workspace_root, args.terminal_id, test_mode=args.test_mode,
            protected_workspace_verified=args.protected_workspace_verified,
        )
        operations = {
            "Initialize": lambda: store.initialize(payload),
            "SaveCycle": lambda: store.save_cycle(payload),
            "Search": lambda: store.search(payload),
            "RebuildIndex": store.rebuild_index,
            "Verify": store.verify,
            "RestoreVersion": lambda: store.restore_version(str(payload.get("version_id", ""))),
            "ListProjects": store.list_projects,
            "ShowSession": lambda: store.show_session(str(payload.get("session_id", ""))),
        }
        print(canonical_json(operations[args.operation]()))
        return 0
    except (StoreError, sqlite3.Error, OSError, ValueError, TypeError) as exc:
        print(canonical_json({"ok": False, "error": str(exc)}))
        return 2
    except json.JSONDecodeError as exc:
        print(canonical_json({"ok": False, "error": f"INVALID_JSON:{exc}"}))
        return 2


if __name__ == "__main__":
    raise SystemExit(run_cli())
