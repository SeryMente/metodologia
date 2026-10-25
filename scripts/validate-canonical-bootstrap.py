#!/usr/bin/env python3
"""Validate the single integrated governance source and the legacy SI compatibility path consumed by Khora."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAM_HTML_PATH = ROOT / "gobernanza" / "METAPROMPT-CANONICO-SAMANTHA.html"
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


def read_required(path: Path, label: str) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as error:
        ERRORS.append(f"Cannot read {label} at {path.relative_to(ROOT)}: {error}")
        return ""


def first_match(pattern: str, text: str, label: str) -> str:
    match = re.search(pattern, text, re.MULTILINE)
    if not match:
        ERRORS.append(f"Missing {label}: {pattern}")
        return ""
    return match.group(1).strip()


sam_html = read_required(SAM_HTML_PATH, "single canonical governance HTML")
legacy_si = read_required(LEGACY_SI_PATH, "legacy SI compatibility file")
archive_pointer = read_required(SI_ARCHIVE_POINTER_PATH, "legacy SI archive pointer")
method = read_required(METHOD_PATH, "methodology version manifest")
bootstrap = read_required(BOOTSTRAP_PATH, "conversation bootstrap")
entry = read_required(ENTRY_PATH, "repository entrypoint")
output = read_required(OUTPUT_PATH, "cycle output contract")
schema_text = read_required(SCHEMA_PATH, "cycle output JSON schema")

governance_data: dict = {}
match = re.search(
    r'<script\s+id="gov-data"\s+type="application/json">([\s\S]*?)</script>',
    sam_html,
)
if not match:
    ERRORS.append("The single governance HTML is missing its embedded gov-data JSON representation.")
else:
    try:
        governance_data = json.loads(match.group(1))
    except json.JSONDecodeError as error:
        ERRORS.append(f"The embedded gov-data JSON is invalid: {error}")

document = governance_data.get("document", {})
sections = governance_data.get("sections", [])
section_ids = {item.get("id") for item in sections if isinstance(item, dict)}
principles = governance_data.get("principles", [])
artifacts = governance_data.get("artifacts", [])

sam_version = str(document.get("version", ""))
sam_signature = str(document.get("signature", ""))
sam_event = str(document.get("event", ""))
method_version = first_match(r"^- \*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)\s*$", method, "Methodology version")
method_name = first_match(r"^- \*\*Nombre de versión:\*\*\s*(.+)$", method, "Methodology version name")
legacy_version = first_match(r"^\*\*Versión:\*\*\s*(v\d+\.\d+\.\d+)", legacy_si, "legacy SI compatibility version")
legacy_name = first_match(r"^\*\*Nombre de versión:\*\*\s*(.+)$", legacy_si, "legacy SI compatibility name")

require(document.get("name") == "Gobernanza única de Ser y Mente / Samantha",
        "The canonical HTML does not identify the integrated governance document.")
require(document.get("canonical_source") == "SeryMente/metodologia/main:gobernanza/METAPROMPT-CANONICO-SAMANTHA.html",
        "The embedded canonical_source does not point to this single source in main.")
require(bool(re.fullmatch(r"v\d+", sam_version)), "The canonical HTML must declare a version such as v344.")
require(bool(re.fullmatch(r"NX-\d+m", sam_signature)), "The canonical HTML must declare its current NX signature.")
require(bool(sam_event), "The canonical HTML must declare its current governance event.")
require({"samantha", "metacanon", "gow"}.issubset(section_ids),
        "The embedded representation must include Samantha, Metacanon and GOW sections.")
require(document.get("principles") == 40 and len(principles) == 40,
        "The embedded canonical representation must declare and contain all 40 principles.")
principle_ids = [item.get("id") for item in principles if isinstance(item, dict)]
require(len(set(principle_ids)) == 40 and set(principle_ids) == {f"P{i:03d}" for i in range(1, 41)},
        "The embedded canonical representation must contain unique principle IDs P001-P040.")
require(document.get("annexes") == len(artifacts) and len(artifacts) >= 1,
        "The human annex count and embedded artifact count must agree.")
require(bool(document.get("metacanon_version")) and bool(document.get("gow_version")),
        "The canonical HTML must declare Metacanon and GOW versions.")

# Reconcile the human-visible header/footer and the machine representation in the same HTML.
human_footer = first_match(r"<footer[^>]*>([\s\S]*?)</footer>", sam_html, "human-visible canonical footer")
require(sam_version in human_footer and sam_signature in human_footer and sam_event in human_footer,
        "The human-visible footer and embedded machine representation have diverged.")
require(f"Versión actual · {sam_version}" in sam_html,
        "The human-readable Samantha section does not expose the embedded current version.")
require(f"Versión vigente: {sam_version}" in sam_html,
        "The human-readable Samantha section does not declare the current version.")
require(f"Firma {sam_signature}" in sam_html,
        "The human-readable Samantha section does not declare the current signature.")
require('id="gobierno-general"' in sam_html and 'id="metacanon"' in sam_html and 'id="glosario"' in sam_html,
        "The integrated HTML is missing a human-readable anchor for Samantha, Metacanon or GOW.")

# Preserve the legacy SI bridge consumed by KHORA; it is not the current general-governance source.
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
require("puntero de archivo" in archive_pointer.lower()
        and "../../SI-METACOGNITIVO.md" in archive_pointer
        and "no es el gobierno general vigente" in archive_pointer,
        "The legacy SI archive route must remain an explicit pointer, not a duplicate copy.")

canonical_html_path = "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html"
require(canonical_html_path in bootstrap
        and f"{canonical_html_path}#metacanon" in bootstrap
        and f"{canonical_html_path}#glosario" in bootstrap,
        "The bootstrap must link to the integrated canonical HTML and its Metacanon/GOW sections.")
require("gobernanza/METAPROMPT-CANONICO-SAMANTHA.md" not in bootstrap
        and "METACANON-OBJETOS-CANONICOS.md" not in bootstrap
        and "gobernanza/GLOSARIO-WORKSPACE.md" not in bootstrap,
        "The bootstrap must not point to removed Markdown mirrors of the single canonical HTML.")
require(canonical_html_path in entry
        and f"{canonical_html_path}#metacanon" in entry
        and f"{canonical_html_path}#glosario" in entry,
        "INICIO.md must route Samantha, Metacanon and GOW to the integrated canonical HTML.")
require("gobernanza/METAPROMPT-CANONICO-SAMANTHA.md" not in entry
        and "METACANON-OBJETOS-CANONICOS.md" not in entry
        and "gobernanza/GLOSARIO-WORKSPACE.md" not in entry,
        "INICIO.md must not identify removed Markdown mirrors as canonical sources.")
require(bool(method_version) and bool(method_name), "The Methodology manifest must expose version and name.")

require("F:! es **fail-closed**" in output and "RA:" in output and "SI CARGADO" in output,
        "The cycle output contract is missing its visible fail-closed/re-anchor fields.")
try:
    schema = json.loads(schema_text)
except json.JSONDecodeError as error:
    schema = {}
    ERRORS.append(f"The cycle output JSON schema is invalid: {error}")
require(schema.get("version") == "v1.7.7", "Output schema version is not v1.7.7.")
schema_json = json.dumps(schema, ensure_ascii=False)
require('"name": "RA"' in schema_json or '"name":"RA"' in schema_json,
        "Output schema is missing RA.")
require('"name": "F"' in schema_json or '"name":"F"' in schema_json,
        "Output schema is missing F.")

if ERRORS:
    print("CANONICAL GOVERNANCE VALIDATION: FAIL")
    for error in ERRORS:
        print(f"- {error}")
    sys.exit(1)

print("CANONICAL GOVERNANCE VALIDATION: PASS")
print(f"- Single canonical source: Sam {sam_version} / {sam_signature} / {sam_event}")
print(f"- Metacanon: {document.get('metacanon_version')}; GOW: {document.get('gow_version')}")
print(f"- Human/machine principle count: {len(principles)}; artifacts: {len(artifacts)}")
print(f"- Methodology: {method_version} — {method_name}")
print(f"- Legacy SI {legacy_version}: superseded compatibility bridge preserved for Khora")
print("- Bootstrap and INICIO: direct links to the integrated canonical HTML")
print("- Output contract: visible re-anchor and schema v1.7.7 present")
