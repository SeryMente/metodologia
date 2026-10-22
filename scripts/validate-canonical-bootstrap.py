#!/usr/bin/env python3
"""Validate current Sam governance and the legacy SI compatibility path consumed by KHORA."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAM_PATH = ROOT / "gobernanza" / "METAPROMPT-CANONICO-SAMANTHA.md"
LEGACY_SI_PATH = ROOT / "SI-METACOGNITIVO.md"
SI_ARCHIVE_POINTER_PATH = ROOT / "gobernanza" / "antecedentes" / "SI-METACOGNITIVO-v1.6.21-historico.md"
METHOD_PATH = ROOT / "METODOLOGIA.md"
BOOTSTRAP_PATH = ROOT / "BOOTSTRAP-CONTEXTO-GLOBAL.md"
ENTRY_PATH = ROOT / "INICIO.md"
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
legacy_si = LEGACY_SI_PATH.read_text(encoding="utf-8")
archive_pointer = SI_ARCHIVE_POINTER_PATH.read_text(encoding="utf-8")
method = METHOD_PATH.read_text(encoding="utf-8")
bootstrap = BOOTSTRAP_PATH.read_text(encoding="utf-8")
entry = ENTRY_PATH.read_text(encoding="utf-8")
output = OUTPUT_PATH.read_text(encoding="utf-8")
schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))

sam_version = first_match(r"Versión actual\s*·\s*(v\d+)", sam, "current Sam version")
sam_signature = first_match(r"Firma de Carga:\s*<b>(NX-[^<]+)</b>", sam, "current Sam signature")
method_version = first_match(r"^- \*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", method, "Methodology version")
legacy_version = first_match(r"^\*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)", legacy_si, "legacy SI compatibility version")
legacy_name = first_match(r"^\*\*Nombre de versión:\*\*\s*(.+)$", legacy_si, "legacy SI compatibility name")

require(sam_version == "v339", "Sam is not the expected current v339 source.")
require(sam_signature == "NX-339m", "Sam does not expose the expected current signature NX-339m.")
require("Principio de Cascada Starship" in sam and "P038" in sam,
        "Sam is missing the expected cascade/source-precedence anchors.")
require(bool(method_version), "The Methodology must expose its version.")

# Keep the root path readable by KHORA, whose current parser extracts the version/name.
# The explicit banner means the legacy SI is retained only for compatibility, not as the
# current general-governance authority for Metodología.
require("GOBIERNO GENERAL SUPERSEDIDO" in legacy_si,
        "Root SI must preserve its explicit superseded-governance banner.")
require(legacy_version == "v1.6.21", "Unexpected legacy SI compatibility version.")
require(legacy_name == "Ordenamiento por Preponderancia y Categorías",
        "Unexpected legacy SI compatibility name.")
require("### 5.0.1.1 Gate de identidad normativa del snapshot" in legacy_si
        and "Con F:! la ejecución es fail-closed." in legacy_si,
        "Legacy SI no longer contains its historical identity gate.")
require("P033 · Precedencia del Estado Operativo Global" in legacy_si
        and "RDC-REINSTANTIAR" in legacy_si,
        "Legacy SI no longer contains the RDC invariants already consumed by its tests.")
require("puntero histórico" in archive_pointer.lower()
        and "../../SI-METACOGNITIVO.md" in archive_pointer,
        "The archive route must be a pointer to the root compatibility source.")

require("gobernanza/METAPROMPT-CANONICO-SAMANTHA.md" in bootstrap
        and "Metacanon §4, formato obligatorio en cada ciclo" in bootstrap
        and "gobernanza/GLOSARIO-WORKSPACE.md" in bootstrap,
        "The bootstrap must point directly to current Sam, Metacanon §4, and the GOW.")
require("gobernanza/METAPROMPT-CANONICO-SAMANTHA.md" in entry
        and "METACANON-OBJETOS-CANONICOS.md" in entry
        and "GLOSARIO-WORKSPACE.md" in entry,
        "INICIO.md is missing one of the current canonical entrypoints.")

require("F:! es **fail-closed**" in output and "RA:" in output and "SI CARGADO" in output,
        "The cycle output contract is missing its visible fail-closed/re-anchor fields.")
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
print(f"- Legacy SI {legacy_version}: superseded compatibility source retained for KHORA")
print("- Archive path: pointer only; no second normative source")
print("- Bootstrap: direct links to Sam, Metacanon §4, and GOW")
print("- Output contract: visible re-anchor and schema v1.7.7 present")
