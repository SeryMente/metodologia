# MCP-OCP 1.0.0 · Implementación candidata del panel de observabilidad

**Estado:** código candidato publicado; no compilado ni probado. Esta ficha de implementación no modifica el contrato aprobado en `PANEL-OBSERVABILIDAD.md`.

## Componentes

- `src/OcpMcp.Monitoring/`: modelos versionados, lector defensivo read-only y escritor best-effort.
- `src/OcpMcp.Panel/`: aplicación Windows WPF/C# de una sola pantalla.
- `tests/OcpMcp.Monitoring.Tests/`: 11 escenarios sintéticos de lector/escritor.
- `src/OcpMcp/`: integración opcional del writer con eventos de proceso, protocolo y herramientas.
- `tests/OcpMcp.Pilot.Tests/`: 16 escenarios del piloto P004, incluyendo telemetría de éxito/fallo.

## Propiedad de los datos y límites

- EP conserva la propiedad de `monitor/session.json`, de las ACL, del root protegido, BitLocker y del ciclo de vida de la ventana.
- MCP-OCP solo lee `session.json` y escribe `state.json` / `events.jsonl` cuando EP suministra explícitamente `--monitor-root <ruta>`.
- No hay root predeterminado. Sin `--monitor-root`, el servidor no crea archivos de monitorización ni elige una ruta persistente.
- El root indicado debe existir antes del arranque. El writer crea únicamente su subdirectorio `monitor/`; no crea el root, configura ACL ni comprueba/activa cifrado.
- El panel solo lee archivos; no accede a stdin/stdout, no controla el servidor, no reinicia procesos y no tiene botones de escritura.
- Sin HTTP/TCP/localhost, named pipes, sockets, túneles ni endpoints de red.
- Sin argumentos, payloads, contenido de documentos/principios, hashes de payload, SID, secretos, tokens ni credenciales en eventos.

## Readiness y eventos

El snapshot inicial publica proceso RUNNING pero protocolo NOT_INITIALIZED; fuentes NOT_IMPORTED/UNKNOWN; operador UNKNOWN; readiness false con razón `SOURCES_NOT_IMPORTED`. Nunca presume datos importados, operador provisionado, BitLocker, root protegido ni READY.

La telemetría de Sink cuenta solo `SINK_READ_SUCCESS` después de que el lector complete validación de blob, metadatos y P004. Los fallos se registran como `TOOL_FAILED` con reasonCode sanitizado y no incrementan éxitos. El evento de éxito contiene solo ID de herramienta/outcome/duración en la proyección del panel.

## Actualización y terminación

El panel coalesce eventos del FileSystemWatcher mediante Dispatcher; no ejecuta heartbeat ni sondeo periódico. Mantiene una referencia al proceso y coteja PID + timestamp de inicio para evitar reutilización del PID. Si el proceso termina y EP sigue activa, muestra desconectado. Si EP pasa a inactiva, el panel permite cerrarse; mientras EP sigue ACTIVE, X/Alt+F4 minimiza.

## Pruebas y build

- P004: 15 casos escritos / 0 ejecutados.
- Monitor: 11 casos escritos / 0 ejecutados.
- WPF: build configurado con .NET SDK 10.0.403 y `EnableWindowsTargeting`; sin build observado.
- Smoke STDIO: script actualizado para validar el ejecutable P004 después de build/tests; no ejecutado de manera verificable.
- Publicación WPF prevista: `win-x64`, self-contained, perfil `src/OcpMcp.Panel/Properties/PublishProfiles/win-x64.pubxml`.

Comandos desde `frentes/mcp-metodologia/`:

```powershell
dotnet build .\src\OcpMcp\OcpMcp.csproj -c Release
dotnet run --project .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
dotnet run --project .\tests\OcpMcp.Monitoring.Tests\OcpMcp.Monitoring.Tests.csproj -c Release
dotnet build .\src\OcpMcp.Panel\OcpMcp.Panel.csproj -c Release -p:EnableWindowsTargeting=true
```

El script CI ejecuta además smoke real STDIO y guarda diagnóstico. Un job de GitHub Actions sin pasos/logs/artefactos no demuestra build, tests ni fallo del código.

## Dependencias y no aceptación

- EP-TASK-003 sigue siendo dueño del preflight Fila 4 y el root protegido.
- EP-TASK-005 sigue siendo dueño de la apertura/cierre del panel y la instalación/handoff local.
- No se ha integrado el ciclo de sesión EP, no se ha creado ni importado una DB, no se ha instalado en Fila 4 y no se ha ejecutado `REGISTER <SID>`.
- No hay paquete 1.0.0, manifest final de artefacto, revisión visual Windows ni E2E IPZ.
