# Piloto local SINK:P004 · MCP-OCP

**Producto:** MCP-OCP 0.1.0 candidato (no aceptado)  
**Sprint:** SINK-P004  
**DUG:** Samantha v388 / NX-388m  
**Base:** `a34c1c5b43edbcbaf015056f4dc892f5def29eea`  
**Rama:** `feat/mcp-ocp-sink-p004-main-a34c1c5b`

## Objetivo

Construir una recuperación trazable de `SINK:P004` mediante un servidor MCP local sobre STDIO. La fuente se fija por commit y Git blob; el piloto no activa MCP-NORMATIVO ni evalúa aplicabilidad.

## Fuente

- Archivo: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`
- Commit: `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`
- Git blob: `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`
- DUG v388/NX-388m; Metacanon 1.29; GOW 2.18.
- GOW:ARR = `gow-sec-14`; principio = `P004`.

El lector valida el hash Git del archivo, UTF-8, versiones y fuente canónica, GOW:ARR, autoridad, catálogo único de 43 IDs, marcador humano `[[P:P004]]`, título, ancla, texto normativo exacto, MDP y preponderancia. Nunca sustituye una fuente inválida con memoria ni con el MDP.

## Transporte

- JSON-RPC 2.0 por STDIO.
- Métodos: `initialize`, `notifications/initialized`, `ping`, `tools/list`, `tools/call`.
- Única herramienta: `sink_principle`, restringida a `principle_id=P004`.
- EOF cierra el proceso; no se inventan métodos `shutdown` ni `exit`.
- STDOUT queda reservado al protocolo; eventos y diagnósticos saneados van a STDERR.
- No se levanta listener ni endpoint público.

## Pruebas y validación

Desde `frentes/mcp-metodologia/`:

```powershell
dotnet build src/OcpMcp/OcpMcp.csproj --configuration Release
dotnet run --project tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj --configuration Release
dotnet run --project tests/OcpMcp.Monitoring.Tests/OcpMcp.Monitoring.Tests.csproj --configuration Release
./piloto-sink/ci/Invoke-PilotValidation.ps1
```

- 18 casos de contrato P004.
- 23 casos de monitor/readiness.
- En esta rama: 0 ejecutados; build y smoke pendientes.
- CI captura logs, stdout/stderr y diagnóstico del runner incluso ante fallo.

## Límites

No importa fuentes privadas, crea DB real, provisiona operador, instala en Fila 4, escribe IPZ nativa ni acredita el E2E desde contexto IPZ. EP conserva sus gates y ciclo de vida. La generalización a P001–P043 y el panel WPF son fases posteriores. FOL1 permanece preparado/inactivo y MCP-NORMATIVO DESACTIVADO.


## Revisión de tarjeta humana y rebaseline actual

El DUG renderiza la tarjeta `P004` con `card(p) → render(p.content_markdown)`. El lector valida que ese campo coincida exactamente con `> normative_text`; la suite incluye un negativo que altera ese Markdown incluso tras repinnear el blob. La comprobación estática no reproduce una divergencia entre tarjeta humana y respuesta Sink.

La rama se reconcilió con main `646608896a499f78640d6f17ec1e87876089e16f` mediante el commit `dfae6b0fe60438753fa7abe0b9febd6f9088783c`. Estado actual de la rama: 9 ahead / 0 behind; PR #27 DRAFT / NOT MERGED. El build, los 41 tests y el smoke aún no están ejecutados con evidencia: el job CI terminó sin runner asignado, pasos, logs ni artefactos.


## Segunda sincronización con main vigente

La rama fue sincronizada también con main `8f999198f1d8cde71361c884c9a13b745f442b49` mediante merge `ea32a78e87bd659307fc81ff3f80b3743bae9d0a`, conservando las rutas del candidato y el asiento GOV-TASK-015. Compare posterior: 18 ahead / 0 behind. PR #27 sigue OPEN/DRAFT/NOT MERGED.

La propuesta MCP-OCP-14 v0.1 y sus cuatro schemas se encuentran bajo `persistencia/`; son diseño documental, no runtime. El último CI P004 sigue sin runner asignado, sin pasos/logs/artefactos; build, tests y smoke no están acreditados.
