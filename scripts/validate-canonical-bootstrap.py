#!/usr/bin/env python3
"""Validate the integrated canonical governance source and the legacy SI compatibility path."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAM_PATH = ROOT / "gobernanza" / "METAPROMPT-CANONICO-SAMANTHA.html"
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


sam_html = SAM_PATH.read_text(encoding="utf-8")
legacy_si = LEGACY_SI_PATH.read_text(encoding="utf-8")
archive_pointer = SI_ARCHIVE_POINTER_PATH.read_text(encoding="utf-8")
method = METHOD_PATH.read_text(encoding="utf-8")
bootstrap = BOOTSTRAP_PATH.read_text(encoding="utf-8")
entry = ENTRY_PATH.read_text(encoding="utf-8")
output = OUTPUT_PATH.read_text(encoding="utf-8")
schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))

gov_match = re.search(
    r'<script id="gov-data" type="application/json">([\s\S]*?)</script>',
    sam_html,
)
if not gov_match:
    ERRORS.append("Canonical HTML is missing its embedded machine representation.")
    gov_data: dict = {}
else:
    try:
        gov_data = json.loads(gov_match.group(1))
    except json.JSONDecodeError as error:
        ERRORS.append(f"Canonical HTML machine representation is invalid JSON: {error}")
        gov_data = {}

sam_document = gov_data.get("document", {})
sam_version = sam_document.get("version", "")
sam_signature = sam_document.get("signature", "")
principles = gov_data.get("principles", [])
sections = gov_data.get("sections", [])
section_ids = {
    section.get("id") for section in sections if isinstance(section, dict)
}
method_version = first_match(
    r"^- \*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", method, "Methodology version"
)
legacy_version = first_match(
    r"^\*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)", legacy_si, "legacy SI compatibility version"
)
legacy_name = first_match(
    r"^\*\*Nombre de versión:\*\*\s*(.+)$", legacy_si, "legacy SI compatibility name"
)

require(SAM_PATH.exists(), "The single canonical governance HTML is missing.")
require(sam_version == "v340", "Canonical Samantha version is not v340.")
require(sam_signature == "NX-340m", "Canonical Samantha signature is not NX-340m.")
require(
    "Principio de Cascada Starship" in sam_html
    and any(principle.get("id") == "P038" for principle in principles),
    "Canonical Sam is missing cascade/source-precedence anchors.",
)
require(
    {"samantha", "metacanon", "gow"}.issubset(section_ids),
    "The single canonical HTML must integrate human sections for Sam, Metacanon and GOW.",
)
require(bool(method_version), "The Methodology must expose its version.")

# The root SI remains a historical compatibility surface, never a parallel authority.
require(
    "GOBIERNO GENERAL SUPERSEDIDO" in legacy_si,
    "Root SI must preserve its explicit superseded-governance banner.",
)
require(legacy_version == "v1.6.21", "Unexpected legacy SI compatibility version.")
require(
    legacy_name == "Ordenamiento por Preponderancia y Categorías",
    "Unexpected legacy SI compatibility name.",
)
require(
    "### 5.0.1.1 Gate de identidad normativa del snapshot" in legacy_si
    and "Con F:! la ejecución es fail-closed." in legacy_si,
    "Legacy SI no longer contains its historical identity gate.",
)
require(
    "P033 · Precedencia del Estado Operativo Global" in legacy_si
    and "RDC-REINSTANTIAR" in legacy_si,
    "Legacy SI no longer contains the RDC invariants already consumed by its tests.",
)
require(
    "puntero histórico" in archive_pointer.lower()
    and "../../SI-METACOGNITIVO.md" in archive_pointer,
    "The archive route must be a pointer to the root compatibility source.",
)

require(
    "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html" in bootstrap
    and "#metacanon" in bootstrap
    and "#glosario" in bootstrap,
    "The bootstrap must point to integrated Sam, Metacanon and GOW sections in the single canonical HTML.",
)
require(
    "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html" in entry
    and "#metacanon" in entry
    and "Este único archivo integra" in entry,
    "INICIO.md must identify the integrated canonical HTML without requiring normative mirror files.",
)

require(
    "F:! es **fail-closed**" in output and "RA:" in output and "SI CARGADO" in output,
    "The cycle output contract is missing its visible fail-closed/re-anchor fields.",
)
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
print(
    f"- Integrated sections: Metacanon {sam_document.get('metacanon_version')}, "
    f"GOW {sam_document.get('gow_version')}"
)
print(f"- Methodology: {method_version}")
print(f"- Legacy SI {legacy_version}: superseded compatibility source retained for KHORA")
print("- Archive path: pointer only; no second normative source")
print("- Bootstrap: direct links into the integrated canonical HTML")
print("- Output contract: visible re-anchor and schema v1.7.7 present")
