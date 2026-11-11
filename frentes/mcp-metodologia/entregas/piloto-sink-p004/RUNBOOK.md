# MCP-OCP SINK:P004 · paquete piloto candidato

**Estado:** CANDIDATE / NOT ACCEPTED / NOT INSTALLED
**Fuente:** SeryMente/metodologia, rama feat/mcp-ocp-p004-reconciled-20261111-7ab0c555, commit f8973a1958fb1e6d259786c2828a19dae05aeee6.
**Base main en la validación de código:** cb9b6a704bb18ccd219d847a48e810f22b4e2c3e.
**Último main sincronizado:** 446e69251335a51fe8d4c01495c3738b11d5808c, merge 8d22bff7fae4a23ac224b984576205841abeda9c.
**Revisión:** PR #28, OPEN / DRAFT / NOT MERGED.
**DUG:** Samantha v388 / NX-388m; commit 3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c; blob 4db0ebadfd1e48b2bdec9236ba7f344921e4a865.

## Runtime

- Windows x64; Microsoft.NETCore.App 10.0.x x64 en el destino.
- Checkout completo de Metodología que contenga el DUG fijado por commit/blob.
- Cliente MCP: server/OcpMcp.exe serve --repo-root <ruta-absoluta-del-checkout> por STDIO.
- STDOUT exclusivamente JSON-RPC; eventos/diagnósticos por STDERR.
- No se crea listener de red; la única herramienta es sink_principle, solo admite P004.

## Validación local ligada al commit

- Windows 10.0.26200 x64; PowerShell 7.4.22; .NET SDK 10.0.403.
- Restore de ambas suites: PASS.
- Build servidor/monitor y proyectos de prueba: PASS, cero warnings/errores.
- Contratos P004 18/18 PASS; monitor/readiness 23/23 PASS.
- Smoke STDIO/EOF: initialize, tools/list, tools/call(P004), tres respuestas JSON-RPC y SINK_READ_SUCCESS en STDERR: PASS.
- SDK aislado en directorio temporal; sin instalación global ni PATH persistente.

## Gates

MCP-OCP no instala ni configura un root persistente. EP-TASK-003 debe superar los gates de host/workspace/almacenamiento protegido; EP-TASK-005 controla recepción, extracción, read-back e instalación. REGISTER <SID> es interactivo y corresponde al operador; no automatizarlo ni enviar SID por chat.

Gobernanza conserva la aceptación IPZ → RDC → STDIO → respuesta visible. Este smoke local no constituye aceptación E2E.

MCP-NORMATIVO=DESACTIVADO. FOL1 permanece preparado/inactivo.