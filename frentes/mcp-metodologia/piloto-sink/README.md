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
| HEAD de main al crear la rama | 17a4da1d3906e2397ab4682ff46cc9a9f116f34d |
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
- initialize, ping, tools/list, tools/call, shutdown y exit se procesan mediante JSON-RPC 2.0 newline-delimited.
- tools/list expone sink_principle(principle_id) y limita el argumento a P004.
- La lectura valida Git blob SHA-1, UTF-8 estricto, versión/firma/evento, identidad de fuente, versiones Metacanon/GOW, inventario de 43 principios, P004 único y §ARR único.
- Respuesta incluye texto íntegro, ID, título, MDP, ancla, pin de commit/blob, SHA-256 de fuente y texto, y procedencia de §ARR.
- Solo después de una lectura verificada se emite SINK_READ_SUCCESS saneado a stderr. No se escriben eventos/logs persistentes ni datos operativos en el checkout.
- Cualquier ausencia, pin, metadata, JSON, versión o contrato inconsistente falla cerradamente; no hay fallback a memoria ni a ramas históricas.

## Construcción y pruebas

Requiere .NET SDK 10.0.100 o superior. Desde la raíz del repositorio:

    dotnet build frentes/mcp-metodologia/src/OcpMcp/OcpMcp.csproj -c Release
    dotnet run --project frentes/mcp-metodologia/tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj -c Release

Para arrancar contra un clon que contenga el pin DUG fijado:

    dotnet run --project frentes/mcp-metodologia/src/OcpMcp/OcpMcp.csproj -c Release -- serve --repo-root .

stdout queda reservado a JSON-RPC. Los eventos de lectura satisfactoria se emiten a stderr; no se persisten.

## Matriz de aceptación del candidato

- [x] Contrato de P004 y §ARR inspeccionados en el DUG de main.
- [x] Autorización de Sink local STDIO vigente, verificada en control generación 5.
- [x] Rama de trabajo limpia desde el HEAD de main comprobada por compare.
- [ ] Build ejecutado.
- [ ] Pruebas automatizadas ejecutadas.
- [ ] Protocolo STDIO probado con el ejecutable compilado.
- [ ] Candidato reproducible con hashes de artefactos.
- [ ] Aceptación E2E IPZ → RDC → STDIO: requiere contexto IPZ real y no se infiere de pruebas locales.

## Limitaciones explícitas

El entorno de ejecución disponible en este ciclo no incluye .NET SDK; por ello el código y las pruebas pueden persistirse, pero no declarar compilación ni ejecución hasta usar un runner autorizado con .NET 10. El dispositivo RDC en línea no se identifica como Fila 4; no se utilizará para instalar ni ejecutar este piloto.
