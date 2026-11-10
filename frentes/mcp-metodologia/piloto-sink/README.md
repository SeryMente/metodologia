# Piloto MCP-OCP · SINK:P004

**Estado:** candidato de implementación en rama de trabajo; no instalado ni aceptado E2E IPZ.
**Producto:** corte vertical 0.0.1, servidor MCP STDIO local.
**Alcance:** GOW:ARR → DUG → MDP → SINK:P004.
**Exclusiones:** sin listener HTTP/TCP, túnel, endpoint público, Khora, Jules, B2, Cloudflare, instalación EP, datos persistentes, registro de operador o activación de MCP-NORMATIVO.

## Pines de fuente verificados al abrir el ciclo

| Elemento | Valor |
|---|---|
| Repositorio | SeryMente/metodologia |
| Rama canónica | main |
| HEAD de main al crear la rama | 73a42bc687f1fa3dd60b44af9cd93f797eba3920 |
| DUG | Samantha v387 · NX-387m |
| DUG commit | 17a4da1d3906e2397ab4682ff46cc9a9f116f34d |
| DUG blob | c8d37d92aed7ff9d4fe94e7a9541e76ba5c88a2c |
| Evento DUG | C-GOBERNANZA-IPZ-DIRECTORIO-CNP-20261110-01 |
| Metacanon / GOW | 1.29 / 2.18 |
| GOW §ARR | glossary.sections[id=gow-sec-14], ancla #gow-arranque-chatgpt |
| MDP P004 | Exigir hechos verificables; activarlo ante afirmaciones sobre capacidades, datos, acciones o certezas. |
| P004 | Principio de No-Simulación, ancla #P004 |

**Discrepancia reconciliada:** el núcleo y backlog todavía fijan Samantha v386/NX-386m y blob 22dca684…; la lectura actual de main ya entrega v387/NX-387m y blob c8d37d92…. El piloto fija la fuente actual leída de main, no reutiliza el pin histórico. No se modifica el DUG.

## Diseño

- OcpMcp.exe serve [--repo-root path] inicia únicamente el proceso STDIO.
- Handshake clásico MCP STDIO `2025-11-25`: el cliente envía `initialize` con `protocolVersion`, `capabilities` y `clientInfo`; el servidor negocia la versión y devuelve la capability `tools`. Después el cliente envía `notifications/initialized` y puede usar `tools/list` y `tools/call`.
- Se aceptan también las versiones de handshake `2025-06-18`, `2025-03-26` y `2024-11-05`. El protocolo stateless `2026-07-28` no está implementado en este piloto porque el contrato del hito exige `initialize`.
- MCP `2025-11-25` no define mensajes `shutdown` ni `exit`. En STDIO el cliente cierra `stdin`; el servidor termina limpiamente al recibir EOF.
- tools/list expone sink_principle(principle_id) y limita el argumento a P004.
- La lectura valida Git blob SHA-1, UTF-8 estricto, versión/firma/evento, identidad de fuente, versiones Metacanon/GOW, inventario de 43 principios, P004 único y §ARR único.
- Respuesta incluye texto íntegro, ID, título, MDP, ancla, pin de commit/blob, SHA-256 de fuente y texto, y procedencia de §ARR.
- Solo después de una lectura verificada se emite SINK_READ_SUCCESS saneado a stderr. No se escriben eventos/logs persistentes ni datos operativos en el checkout.
- Cualquier ausencia, pin, metadata, JSON, versión o contrato inconsistente falla cerradamente; no hay fallback a memoria ni a ramas históricas.

## Construcción y pruebas

Requiere .NET SDK 10.0.403, fijado en ../global.json. RID: no aplica al piloto framework-dependent; win-x64 se fijará al preparar el paquete de release. Ejecuta desde frentes/mcp-metodologia:

    dotnet build src/OcpMcp/OcpMcp.csproj -c Release
    dotnet run --project tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj -c Release

Para arrancar contra un clon que contenga el pin DUG fijado:

    dotnet run --project src/OcpMcp/OcpMcp.csproj -c Release -- serve --repo-root ../..

stdout queda reservado a JSON-RPC. Los eventos de lectura satisfactoria se emiten a stderr; no se persisten.

## Matriz de aceptación del candidato

- [x] Contrato de P004 y §ARR inspeccionados en el DUG de main.
- [x] Autorización de Sink local STDIO vigente, verificada en control generación 5.
- [x] Rama de trabajo limpia desde el HEAD de main comprobada por compare.
- [x] 13 pruebas automatizadas escritas, incluyendo negociación, notificación `initialized`, rechazo pre-inicialización, P004 exacto desde fixture y DUG real pinneado, pins/alteración, eventos condicionados al éxito, rechazo de `shutdown` no definido y cierre por EOF.
- [ ] Build ejecutado.
- [ ] Las 13 pruebas automatizadas ejecutadas.
- [ ] Protocolo STDIO probado con el ejecutable compilado.
- [ ] Candidato reproducible con hashes de artefactos.
- [ ] Aceptación E2E IPZ → RDC → STDIO: requiere contexto IPZ real y no se infiere de pruebas locales.

## Limitaciones explícitas

Verificación de runner RDC disponible: Windows PowerShell y Git 2.45.2 presentes; `dotnet` no se encuentra en PATH (`DOTNET=NOT_FOUND`). El contenedor de trabajo tampoco tiene `dotnet`. No se ejecutó build ni ninguna de las 13 pruebas. El equipo remoto está en el contexto de proceso `MantenimientoRCI`, no es Fila 4; no se escribieron archivos allí. El candidato no está instalado.
