#!/usr/bin/env python3
"""Validate current Sam governance and the compatibility bridge for archived SI references."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAM_PATH = ROOT / "gobernanza" / "METAPROMPT-CANONICO-SAMANTHA.md"
SI_POINTER_PATH = ROOT / "SI-METACOGNITIVO.md"
LEGACY_SI_PATH = ROOT / "gobernanza" / "antecedentes" / "SI-METACOGNITIVO-v1.6.21-historico.md"
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


sam = SAM_PATH.read_text(encoding="utf-8")
si_pointer = SI_POINTER_PATH.read_text(encoding="utf-8")
legacy_si = LEGACY_SI_PATH.read_text(encoding="utf-8")
method = METHOD_PATH.read_text(encoding="utf-8")
bootstrap = BOOTSTRAP_PATH.read_text(encoding="utf-8")
output = OUTPUT_PATH.read_text(encoding="utf-8")
schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))

sam_version = first_match(r"Versión actual\s*·\s*(v\d+)", sam, "current Sam version")
sam_signature = first_match(r"Firma de Carga:\s*<b>(NX-[^<]+)</b>", sam, "current Sam signature")
method_version = first_match(r"^- \*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", method, "Methodology version")

require(sam_version == "v339", "Sam is not the expected current v339 source.")
require(sam_signature == "NX-339m", "Sam does not expose the expected current signature NX-339m.")
require("Principio de Cascada Starship" in sam and "P038" in sam,
        "Sam is missing the expected cascade/source-precedence anchors.")
require(method_version, "The Methodology must expose its version.")

require("puntero histórico" in si_pointer.lower()
        and "gobernanza/antecedentes/SI-METACOGNITIVO-v1.6.21-historico.md" in si_pointer,
        "The root SI path must remain a compatibility pointer to the archived historical SI.")
require("GOBIERNO GENERAL SUPERSEDIDO" in legacy_si,
        "The archived SI must explicitly remain superseded historical material.")
require("### 5.0.1.1 Gate de identidad normativa del snapshot" in legacy_si
        and "Con F:! la ejecución es fail-closed." in legacy_si,
        "The archived historical SI no longer contains its documented historical identity gate.")
require("P033 · Precedencia del Estado Operativo Global" in legacy_si
        and "RDC-REINSTANTIAR" in legacy_si,
        "The archived historical SI no longer contains the legacy RDC invariants this repo retains.")

require("### Gate de arranque fail-closed" in bootstrap
        and "H1 → SI@H1 → H2 → CABECERA ACTIVA → CONSISTENCIA DE ESPEJOS → F:✓ → REANCLAJE INICIAL" in bootstrap,
        "BOOTSTRAP-CONTEXTO-GLOBAL.md is missing the fail-closed startup gate.")
require("F:! es **fail-closed**" in output and "RA:" in output and "SI CARGADO" in output,
        "FORMATO-REGISTRO-VERIFICACION-CICLO.md is missing the visible fail-closed contract.")
require(schema.get("version") == "v1.7.7", "Output schema version is not v1.7.7.")
schema_text = json.dumps(schema, ensure_ascii=False)
require('"name": "RA"' in schema_text, "Output schema is missing RA.")
require('"name": "F"' in schema_text, "Output schema is missing F.")

if ERRORS:
    print("CANONICAL GOVERNANCE VALIDATION: FAIL")
    for error in ERRORS:
        print(f"- {error}")
    sys.exit(1)

print("CANONICAL GOVERNANCE VALIDATION: PASS")
print(f"- Current governance: Sam {sam_version} / {sam_signature}")
print(f"- Methodology: {method_version}")
print("- Legacy SI: preserved in archive; root path is a compatibility pointer")
print("- Bootstrap: fail-closed freshness gate present")
print("- Output contract: visible re-anchor and schema v1.7.7 present")
