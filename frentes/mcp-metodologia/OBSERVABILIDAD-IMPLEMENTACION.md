# MCP-OCP 1.0.0 · Implementación candidata del panel de observabilidad

**Estado:** código candidato publicado; no compilado ni probado. Esta ficha de implementación no modifica el contrato aprobado en `PANEL-OBSERVABILIDAD.md`.

## Componentes

- `src/OcpMcp.Monitoring/`: modelos versionados, lector defensivo read-only y escritor best-effort.
- `src/OcpMcp.Panel/`: aplicación Windows WPF/C# de una sola pantalla.
- `tests/OcpMcp.Monitoring.Tests/`: 23 escenarios sintéticos de reader/writer/evaluator.
- `src/OcpMcp/`: integración opcional del writer con eventos de proceso, protocolo y herramientas.
- `tests/OcpMcp.Pilot.Tests/`: 18 escenarios del piloto P004, incluyendo telemetría de éxito/fallo.

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

- P004: 18 casos escritos / 0 ejecutados.
- Monitor/readiness: 23 casos escritos / 0 ejecutados.
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


## Gate de readiness derivado de la atestación EP

El panel no calcula readiness solo con `state.json`. `MonitorReadinessEvaluator` combina `session.json` (EP) y el snapshot del servidor, más la verificación independiente del proceso:

1. Sesión `ACTIVE`, schema 1 y atestación con timestamps no futuros y `protectionCheckedAtUtc ≥ sessionStartedAtUtc`; snapshot del servidor sin fecha futura.
2. `protectionState` exactamente `Protection On` (comparación case-insensitive); `Protection Off`, `UNKNOWN` o cualquier valor ausente/no permitido bloquean.
3. Proceso MCP `RUNNING`, con PID y hora de inicio cotejados contra el proceso real.
4. Protocolo `INITIALIZED`.
5. Fuentes importadas, integridad `VERIFIED`, versión vigente.
6. Operador provisionado.
7. Root configurado y con read/write disponible.
8. Snapshot del servidor declara readiness true.

El evaluador no consulta BitLocker, ACL ni el host. Solo interpreta la atestación que EP publica y coteja. Si EP no puede probar `Protection On`, el panel permanece `BLOQUEADO`; no convierte ausencia de datos en PASS.

**Suite:** 23 escenarios sintéticos escritos / 0 ejecutados. Incluye sesión/proyección inválida, eventos corruptos/oversized, escritura del snapshot y pruebas del gate compuesto (Protection Off/UNKNOWN, Protection On, proceso, protocolo, fuentes, operador, root y timestamp futuro).


La suite incluye dos negativos temporales adicionales: verificación Protection On heredada de una sesión previa y snapshot del servidor futuro. Total monitor/readiness: 23 pruebas sintéticas escritas / 0 ejecutadas.


El piloto suma dos negativos de asociación humano/máquina: marcador P004 ausente o duplicado y divergencia entre `content_markdown` y el texto normativo, aun repinneando el blob. Total: 18 tests P004 + 23 tests monitor, todos escritos y no ejecutados.

## Bloqueos de integración hallados por revisión estática · 2026-11-10

La lectura de código (sin build ni ejecución) identifica dos bloqueos funcionales que deben cerrarse antes de aceptar MCP-OCP-13 como operativo:

1. **La ruta runtime no puede alcanzar READY.** `Program.MonitorRuntime` crea `Sources` como no importadas/UNKNOWN, `Operator` como UNKNOWN y `Readiness` como false. `OnEvent` solo actualiza protocolo y actividad; no existe en el ejecutable una ruta que actualice importación/integridad/vigencia de fuentes, aprovisionamiento del operador o readiness del servidor. Por ello, la ruta positiva del evaluador probada con `ReadySnapshot()` es sintética y no representa un estado que el runtime actual pueda emitir. Debe definirse un contrato explícito de procedencia/actualización entre EP y MCP para esos campos, respetando que EP es dueño de `session.json` y MCP del snapshot `state.json`.
2. **El watcher puede perder el arranque del servidor.** `MainWindow.StartWatching()` retorna definitivamente si `<dataRoot>/monitor` todavía no existe y no observa el directorio padre. El contrato aprobado exige que EP abra el panel tras `ACTIVE`, incluso antes de que el cliente lance el servidor. Si el panel abre primero, el servidor creará `monitor/` después, pero el panel no se suscribirá a sus archivos ni recibirá el cambio a “esperando servidor”/estado disponible. Debe observarse el root padre y conectarse al subdirectorio cuando aparezca, con prueba de integración de ese orden de arranque.

Estos son hallazgos de revisión estática, no defectos reproducidos por ejecución. No se modifica el contrato EP ni se permite que MCP escriba `session.json`. No se declara build, prueba ni aceptación.
