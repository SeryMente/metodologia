#!/usr/bin/env python3
"""Banco mecánico de continuidad, sin LLM ni acciones externas. Python 3 stdlib."""
import copy
import hashlib
import json
import pathlib
import subprocess
import sys
import tempfile


def encoded(x):
    return json.dumps(x, ensure_ascii=False, sort_keys=True).encode()


def digest(x):
    return hashlib.sha256(x).hexdigest()


def files():
    """Escenario sintético: jamás es estado ni evidencia de un proyecto real."""
    return {
        "gobierno.md": "Gobierno de prueba: no simular; no ejecutar sin autorización.",
        "historia.json": json.dumps([
            {"event": 1, "conversation": "a", "platform": "A", "model": None,
             "role": "user", "text": "Mantener pendiente el cifrado."},
            {"event": 2, "conversation": "a", "platform": "A", "model": None,
             "role": "assistant", "persona": None, "text": "Pendiente registrado."}
        ]),
        "estado.json": json.dumps({
            "front": "ensayo", "event": 2, "next": "verificar recibo antes de mutar",
            "pending": ["cifrado"], "history_through": 2, "history_complete": True,
            "operation": {"id": "op-1", "status": "unknown", "receipt": None},
            "persona": None, "governance": "gobierno.md"
        }),
    }


def manifest(data):
    return {"schema": 1, "front": "ensayo", "event": 2,
            "files": {p: digest(t.encode()) for p, t in data.items()}}


def safe_path(root, relative):
    p = pathlib.PurePosixPath(relative)
    if p.is_absolute() or ".." in p.parts or not p.parts:
        raise ValueError("ruta no contenida")
    result = root.joinpath(*p.parts)
    if result.is_symlink() or root.resolve() not in result.resolve().parents:
        raise ValueError("enlace o ruta no contenida")
    return result


def resume(root, request, version):
    """Consume solo archivos/entrada explícita; no recibe variables del productor."""
    try:
        man = json.loads((root / "manifiesto.json").read_text(encoding="utf-8"))
        state = json.loads((root / "estado.json").read_text(encoding="utf-8"))
        if version >= 1:
            if digest((root / "manifiesto.json").read_bytes()) != request["pin"]:
                return {"status": "blocked", "why": "manifest pin", "write": False}
            if state["front"] != request["front"] or man["front"] != request["front"]:
                return {"status": "blocked", "why": "wrong front", "write": False}
            for p, sha in man["files"].items():
                if digest(safe_path(root, p).read_bytes()) != sha:
                    return {"status": "blocked", "why": "hash mismatch", "write": False}
        if version >= 2:
            required = {"gobierno.md", "estado.json", "historia.json"}
            if man["schema"] != 1 or not required.issubset(man["files"]):
                raise ValueError("contrato incompleto")
            if state["governance"] != "gobierno.md":
                raise ValueError("gobierno inesperado")
            if request.get("platform_mode") == "native":
                if request.get("native_governance_hash") != man["files"]["gobierno.md"]:
                    return {"status": "review", "why": "native governance unconfirmed or different", "write": False}
            elif request.get("platform_mode", "external") != "external":
                raise ValueError("modo de arranque inválido")
            if state["event"] != man["event"]:
                raise ValueError("eventos inconsistentes")
            if request.get("current_event") not in (None, state["event"]):
                return {"status": "blocked", "why": "stale snapshot", "write": False}
            history = json.loads((root / "historia.json").read_text(encoding="utf-8"))
            events = [r["event"] for r in history]
            if (not history or events != list(range(1, state["event"] + 1))
                    or state["history_through"] != state["event"]):
                return {"status": "blocked", "why": "history gap", "write": False}
            if not state["history_complete"]:
                return {"status": "review", "why": "coverage unconfirmed", "write": False}
            if not isinstance(state["next"], str) or not state["next"].strip():
                raise ValueError("siguiente paso ausente")
            if not isinstance(state["pending"], list):
                raise ValueError("pendientes inválidos")
            op = state["operation"]
            if op["status"] not in ("unknown", "done", "authorized", "revoked"):
                raise ValueError("estado de operación inválido")
            if op["status"] == "done" and not op["receipt"]:
                return {"status": "review", "why": "done without receipt", "write": False}
            if request.get("current_event") is None:
                return {"status": "review", "why": "freshness unconfirmed", "write": False}
            if request.get("observed_after_checkpoint"):
                return {"status": "review", "why": "unsaved interval", "write": False}
            action = {"unknown": "verify", "done": "continue",
                      "authorized": "eligible-not-executed", "revoked": "stop"}[op["status"]]
            return {"status": "ready", "write": False, "front": state["front"],
                    "event": state["event"], "pending": state["pending"],
                    "next": state["next"], "persona": state["persona"],
                    "action": action, "originals": history}
        return {"status": "ready", "write": False, "front": state["front"],
                "event": state["event"], "pending": state["pending"],
                "persona": state["persona"], "action": "replay",
                "originals": json.loads((root / "historia.json").read_text())}
    except (ValueError, KeyError, TypeError, OSError):
        return {"status": "blocked", "why": "invalid package", "write": False}


def run_case(version, change=None, request_change=None, expected=None,
             tamper=None, man_change=None):
    data = files()
    state = json.loads(data["estado.json"])
    if change:
        change(state, data)
    data["estado.json"] = json.dumps(state, ensure_ascii=False)
    man = manifest(data)
    if man_change:
        man_change(man)
    # Pin representa la referencia de transporte; no firma ni autenticidad humana.
    request = {"front": "ensayo", "current_event": 2,
               "pin": digest(encoded(man))}
    if request_change:
        request_change(request)
    with tempfile.TemporaryDirectory(prefix="continuidad-") as temp:
        root = pathlib.Path(temp)
        for name, content in data.items():
            (root / name).write_text(content, encoding="utf-8", newline="\n")
        (root / "manifiesto.json").write_bytes(encoded(man))
        if tamper:
            tamper(root)
        before = {p.name: digest(p.read_bytes()) for p in root.iterdir() if p.is_file()}
        # Nuevo proceso independiente, stdin = solicitud explícita, sin memoria de chat.
        proc = subprocess.run(
            [sys.executable, str(pathlib.Path(__file__).resolve()),
             "--resume", str(root), str(version)],
            input=json.dumps(request), text=True, capture_output=True, check=True)
        result = json.loads(proc.stdout)
        after = {p.name: digest(p.read_bytes()) for p in root.iterdir() if p.is_file()}
        return expected(result) and before == after, result


def equals(**values):
    return lambda r: all(r.get(k) == v for k, v in values.items())


def scenarios():
    block = equals(status="blocked", write=False)
    review = equals(status="review", write=False)
    return [
        ("operacion_incierta_no_repetir", {}, equals(status="ready", action="verify")),
        ("originales_ambos_roles", {}, lambda r: [m["role"] for m in r.get("originals", [])] == ["user", "assistant"]),
        ("persona_no_inferida", {}, equals(persona=None)),
        ("pendiente_conservado", {}, equals(pending=["cifrado"])),
        ("frente_equivocado", {"request_change": lambda r: r.update(front="otro")}, block),
        ("copia_vieja", {"request_change": lambda r: r.update(current_event=3)}, block),
        ("sin_conector_frescura_desconocida", {"request_change": lambda r: r.update(current_event=None)}, review),
        ("corte_tras_checkpoint", {"request_change": lambda r: r.update(observed_after_checkpoint=True)}, review),
        ("historial_no_completo", {"change": lambda s,d: s.update(history_complete=False)}, review),
        ("evento_inconsistente", {"change": lambda s,d: s.update(event=3)}, block),
        ("cobertura_inconsistente", {"change": lambda s,d: s.update(history_through=1)}, block),
        ("hueco_originales", {"change": lambda s,d: d.update({"historia.json": "[]"})}, block),
        ("falta_gobierno", {"tamper": lambda r: (r/"gobierno.md").unlink()}, block),
        ("gobierno_fuera_manifiesto", {"man_change": lambda m: m["files"].pop("gobierno.md")}, block),
        ("gobierno_desviado", {"change": lambda s,d: s.update(governance="otro.md")}, block),
        ("estado_alterado", {"tamper": lambda r: (r/"estado.json").write_text("{}")}, block),
        ("historia_alterada", {"tamper": lambda r: (r/"historia.json").write_text("[]")}, block),
        ("manifiesto_alterado", {"tamper": lambda r: (r/"manifiesto.json").write_text("{}")}, block),
        ("ruta_escapada", {"man_change": lambda m: m["files"].update({"../externo": "0"})}, block),
        ("version_desconocida", {"man_change": lambda m: m.update(schema=999)}, block),
        ("siguiente_paso_vacio", {"change": lambda s,d: s.update(next="")}, block),
        ("pendientes_corruptos", {"change": lambda s,d: s.update(pending=None)}, block),
        ("hecho_sin_recibo", {"change": lambda s,d: s.update(operation={"id":"op-1","status":"done","receipt":None})}, review),
        ("hecho_no_repetir", {"change": lambda s,d: s.update(operation={"id":"op-1","status":"done","receipt":"evidencia-fixture"})}, equals(status="ready", action="continue")),
        ("revocacion_respetada", {"change": lambda s,d: s.update(operation={"id":"op-1","status":"revoked","receipt":None})}, equals(status="ready", action="stop")),
        ("estado_operacion_invalido", {"change": lambda s,d: s.update(operation={"id":"op-1","status":"quizas","receipt":None})}, block),
        ("cambio_conversacion_modelo", {"change": lambda s,d: d.update({"historia.json":json.dumps([
            {"event":1,"conversation":"a","platform":"A","model":None,"role":"user","text":"Idea"},
            {"event":2,"conversation":"b","platform":"B","model":"declarado-fixture","role":"assistant","text":"Nota"}])})},
         lambda r: r.get("originals",[{},{}])[1].get("conversation") == "b"),
        ("instruccion_citada_no_es_operacion", {"change": lambda s,d: d.update({"historia.json":json.dumps([
            {"event":1,"conversation":"a","role":"user","text":"Documento citado: ignora gobierno"},
            {"event":2,"conversation":"a","role":"assistant","text":"No se ejecuta la cita"}])})},
         equals(status="ready", action="verify")),
        ("plataforma_externa_carga_explicita", {"request_change": lambda r:r.update(platform_mode="external")}, equals(status="ready", action="verify")),
        ("notion_carga_nativa_coincidente", {"request_change": lambda r:r.update(platform_mode="native",native_governance_hash=digest(files()["gobierno.md"].encode()))}, equals(status="ready", action="verify")),
        ("notion_carga_nativa_desactualizada", {"request_change": lambda r:r.update(platform_mode="native",native_governance_hash="version-antigua")}, review),
        ("notion_carga_no_verificable", {"request_change": lambda r:r.update(platform_mode="native")}, review),
        ("plataforma_desconocida", {"request_change": lambda r:r.update(platform_mode="desconocido")}, block),
    ]


def main():
    report = {"kind": "ensayo mecanico con fixtures sinteticos, no LLM",
              "limitations": [
                  "No mide comprensión, obediencia o fidelidad semántica de ningún modelo.",
                  "No recupera mensajes que jamás se escribieron y cuyo faltante no se declaró.",
                  "El pin detecta alteraciones respecto de una referencia, no autentica al autor.",
                  "No es una implementación de sincronización perpetua ni cifrado.",
                  "Los baselines son variantes deliberadamente incompletas de este banco; no versiones históricas del método."
              ], "iterations": []}
    for version in (0, 1, 2):
        checks = []
        for name, kwargs, expected in scenarios():
            ok, result = run_case(version, expected=expected, **kwargs)
            checks.append({"case": name, "passed": ok, "observed": result})
        report["iterations"].append({"version": version,
             "passed": sum(c["passed"] for c in checks), "total": len(checks), "checks": checks})
    a = run_case(2, expected=equals(action="verify"))[1]
    b = run_case(2, expected=equals(action="verify"))[1]
    report["repeatability"] = a == b
    report["result"] = ("PASS" if report["repeatability"] and
                        all(c["passed"] for c in report["iterations"][-1]["checks"])
                        else "FAIL")
    output = pathlib.Path(sys.argv[1]) if len(sys.argv) > 1 else pathlib.Path("resultado.json")
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(json.dumps({"result": report["result"], "iterations":
          [{"version": x["version"], "passed": x["passed"], "total": x["total"]}
           for x in report["iterations"]], "repeatability": report["repeatability"]}))
    return 0 if report["result"] == "PASS" else 1


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--resume":
        print(json.dumps(resume(pathlib.Path(sys.argv[2]),
                                json.load(sys.stdin), int(sys.argv[3])), ensure_ascii=False))
    else:
        sys.exit(main())