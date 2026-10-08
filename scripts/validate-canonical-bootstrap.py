#!/usr/bin/env python3
"""Validate the canonical bridge from a fresh SI snapshot to the cycle bootstrap."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SI_PATH = ROOT / "SI-METACOGNITIVO.md"
METHOD_PATH = ROOT / "METODOLOGIA.md"
BOOTSTRAP_PATH = ROOT / "BOOTSTRAP-CONTEXTO-GLOBAL.md"
OUTPUT_PATH = ROOT / "FORMATO-REGISTRO-VERIFICACION-CICLO.md"
SCHEMA_PATH = ROOT / "FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json"

ERRORS: list[str] = []

def require(condition: bool, message: str) -> None:
    if not condition:
        ERRORS.append(message)

def first_match(pattern: str, text: str, label: str) -> str:
    match = re.search(pattern, text, re.MULTILINE)
    if not match:
        ERRORS.append(f"Missing {label}: {pattern}")
        return ""
    return match.group(1).strip()

si = SI_PATH.read_text(encoding="utf-8")
method = METHOD_PATH.read_text(encoding="utf-8")
bootstrap = BOOTSTRAP_PATH.read_text(encoding="utf-8")
output = OUTPUT_PATH.read_text(encoding="utf-8")
schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))

si_version = first_match(r"^\*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", si, "SI version")
si_name = first_match(r"^\*\*Nombre de versión:\*\*\s*(.+?)\s*$", si, "SI version name")
method_version = first_match(r"^- \*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", method, "Methodology version")

require(si_version, "The SI must expose an active version in its header.")
require(si_name, "The SI must expose an active version name in its header.")
require(method_version, "The Methodology must expose its version.")

if si_version and si_name:
    current_identity = f"{si_version} — {si_name}"
    require(current_identity in method, "METODOLOGIA.md does not mirror the active SI identity exactly.")
    history_rows = re.findall(r"^\| \d+ \| (v\d+\.\d+\.\d+) \| ([^|]+) \|", si, re.MULTILINE)
    prior_identities = [(version, name.strip()) for version, name in history_rows if version != si_version]
    if prior_identities:
        prior_version, prior_name = prior_identities[-1]
        require(f"{prior_version} — {prior_name}" not in method,
                f"Previous SI identity {prior_version} — {prior_name} has reappeared in METODOLOGIA.md.")

require("### Gate de arranque fail-closed" in bootstrap
        and "H1 → SI@H1 → H2 → CABECERA ACTIVA → CONSISTENCIA DE ESPEJOS → F:✓ → REANCLAJE INICIAL" in bootstrap,
        "BOOTSTRAP-CONTEXTO-GLOBAL.md is missing the fail-closed startup gate.")
require("### 5.0.1.1 Gate de identidad normativa del snapshot" in si
        and "Con F:! la ejecución es fail-closed." in si,
        "SI-METACOGNITIVO.md is missing the normative identity gate.")
require("F:! es **fail-closed**" in output and "RA:" in output and "SI CARGADO" in output,
        "FORMATO-REGISTRO-VERIFICACION-CICLO.md is missing the visible fail-closed contract.")
require(schema.get("version") == "v1.7.7", "Output schema version is not v1.7.7.")
hud_text = json.dumps(schema, ensure_ascii=False)
require('"name": "RA"' in hud_text, "Output schema is missing RA.")
require('"name": "F"' in hud_text, "Output schema is missing F.")

if ERRORS:
    print("CANONICAL BOOTSTRAP VALIDATION: FAIL")
    for error in ERRORS:
        print(f"- {error}")
    sys.exit(1)

print("CANONICAL BOOTSTRAP VALIDATION: PASS")
print(f"- SI: {si_version} — {si_name}")
print(f"- Metodología: {method_version}")
print("- Freshness bridge: H1 → SI@H1 → H2")
print("- Identity gate: active SI header only")
print("- Fail-closed: F:! blocks CI/RA/substantive work")
print("- Visible re-anchor: RA present")
