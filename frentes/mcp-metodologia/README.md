# OCP MCP — servidor local de Metodología

**Identidad:** MCP-METODOLOGIA
**Versión inicial:** 0.1.0
**Plataforma:** Windows x64 · .NET 10 autocontenido · MCP stdio
**Estado:** MVP en construcción/verificación; la instalación en EP corresponde exclusivamente a EP.

## Alcance operativo

Servidor local para tareas de desarrollo y gobernanza bajo Metodología. El servidor ofrece lectura de fuentes canónicas verificadas, ciclos, operaciones, eventos, telemetría local y recibos. Las escrituras requieren autorización expresa desde una consola Windows interactiva independiente.

- SQLite WAL con cifrado AES-256-GCM de fuentes y snapshots; DEK protegidas por DPAPI CurrentUser.
- Importación de fuentes desde objetos Git locales, sin fetch desde el proceso servidor.
- Eventos append-only con cadena SHA-256 y recibos Ed25519.
- Grants HMAC-SHA256 de un solo uso, vinculados al SID del operador, solicitud, operación, ciclo, intento, payload, nonce y vencimiento.
- Backups cifrados diarios/semanales y previos a actualización.
- MCP-NORMATIVO permanece DESACTIVADO.
- Sink no se implementa y no forma parte de este MVP.

## Compilar y empaquetar

Requisitos del equipo de construcción: Git y SDK .NET 10 para Windows.

Desde la raíz del repositorio:

```powershell
$env:OCPMCP_DOTNET_ROOT = "C:\ruta\al\sdk-dotnet-10"
.rentes\mcp-metodologia\scripts\Build.ps1
```

El script:
1. Verifica cada commit y Git blob SHA del manifiesto de fuentes contra el almacén Git local.
2. Obtiene los bytes de los objetos Git y calcula SHA-256.
3. Publica `win-x64`, autocontenido, Release.
4. Genera `build-manifest.json` con el entrypoint y argumentos exactos.
5. Calcula SHA-256 de cada componente y del ZIP.
6. Escribe evidencia en `artifacts/build-evidence.json`.

Artefactos esperados:

- `artifacts/publish/0.1.0/OcpMcp.exe`
- `artifacts/publish/0.1.0/build-manifest.json`
- `artifacts/publish/0.1.0/initial-sources.manifest.json`
- `artifacts/packages/ocp-mcp-0.1.0-win-x64.zip`
- `artifacts/build-evidence.json`

El manifiesto es la autoridad para `entrypoint` y `args`; no fijar esos valores por inferencia. El manifiesto de fuentes conserva commits y refs individuales. `NOT_CHECKED_AGAINST_MAIN` significa que se verificó integridad de la captura, pero no actualidad frente a main.

## Pruebas de humo

```powershell
.rentes\mcp-metodologia\tests\Smoke.ps1
```

Las pruebas usan un directorio temporal aislado mediante `OCPMCP_TEST_DATA_ROOT`, sin modificar el perfil real del usuario ni EP. Comprueban importación, cifrado en reposo, MCP stdio, fuentes, health, solicitud pendiente, bloqueo de escritura sin grant, cadena de eventos, telemetría y cierre EOF.

## Integración por EP

EP administra el preflight, materialización, archivo portable de Copilot y ciclo de vida del proceso. No debe ejecutar el servidor como servicio ni proceso independiente.

1. Resolver `FOLDERID_Desktop` y extraer el ZIP en:
   `<FOLDERID_Desktop>\SeryMente\OCP\OCP MCP\app\versions\0.1.0\`
2. Resolver `FOLDERID_LocalAppData`; la raíz de datos es exactamente:
   `<FOLDERID_LocalAppData>\SeryMente\OCP MCP\`
3. Disponer de un checkout local de `SeryMente/metodologia` que contenga los commits y blobs declarados en `initial-sources.manifest.json`. No se incorporan credenciales al producto.
4. Antes del primer inicio, importar las fuentes bajo la misma identidad Windows que ejecutará OCP MCP:

   ```powershell
   & "<ruta-absoluta>\OcpMcp.exe" import-sources --repo-root "<checkout-local-SeryMente-metodologia>"
   ```

   El importador no hace fetch; si falta un commit/blob o un hash no coincide, revierte la importación completa.
5. Configurar el servidor portable en el archivo efectivo de Copilot, conservando el resto de entradas:
   - `mcpServers.ocp-mcp.command`: ruta absoluta derivada de `entrypoint` en `build-manifest.json`.
   - `mcpServers.ocp-mcp.args`: arreglo exacto de `args` del manifiesto.
6. Reiniciar Copilot normalmente. El harness crea y administra el proceso `stdio`; EP no lo supervisa como daemon.
7. Ejecutar `diagnose --json` para diagnóstico. Después del primer arranque, el servidor crea el backup inicial diario/semanal y `get_health` informa su estado.

### Aprovisionamiento del operador

Debe realizarlo el operador desde la consola Windows interactiva del usuario autorizado; no desde una llamada MCP ni una entrada redirigida:

```powershell
& "<ruta-absoluta>\OcpMcp.exe" provision-operator
```

El operador debe confirmar escribiendo el SID completo. Esta operación genera las claves HMAC y Ed25519 y las protege con DPAPI CurrentUser. Si no existe esta raíz de confianza, las escrituras protegidas permanecen bloqueadas.

Para autorizar una solicitud creada mediante `prepare_operation`, el operador ejecuta desde esa misma consola:

```powershell
& "<ruta-absoluta>\OcpMcp.exe" authorize --request-id "<request_id>"
```

La consola muestra operación, destino, ciclo, parámetros, huella y vencimiento; exige confirmación humana explícita. Después, el cliente puede invocar `execute_operation`. La clave HMAC nunca se entrega al modelo ni se incluye en mensajes MCP.

## Diagnóstico y mantenimiento local

```powershell
& "<ruta-absoluta>\OcpMcp.exe" diagnose --json
& "<ruta-absoluta>\OcpMcp.exe" backup --reason pre-update
& "<ruta-absoluta>\OcpMcp.exe" restore --backup-id "<backup_id>"
& "<ruta-absoluta>\OcpMcp.exe" revoke --request-id "<request_id>"
& "<ruta-absoluta>\OcpMcp.exe" rotate-hmac-key
```

Readiness:
- `READY`: exit 0.
- `DEGRADED`: exit 1; diagnóstico/lectura permitidos, escrituras protegidas bloqueadas.
- `NOT_READY`: exit 2.

Backup diario al inicio cuando han pasado 24 horas desde el último exitoso; semanal cuando la semana ISO actual no tiene punto de recuperación; siempre previo a una actualización. La retención mantiene siete puntos diarios y cuatro semanales, reutilizando una copia si satisface ambas categorías.

## Herramientas MCP

Lectura: `get_health`, `list_canonical_sources`, `read_canonical_source`, `get_cycle`, `get_operation_status`, `get_receipt`, `list_cycle_events`, `list_telemetry_events`.

Preparación y ejecución: `prepare_operation`, `execute_operation`. La preparación crea una solicitud pendiente; la ejecución exige un grant local aprobado, no consumido y vigente.

Las respuestas y recibos acreditan efectos persistidos del servidor, no comprensión consciente del modelo. La firma se verifica contra la clave pública registrada durante el aprovisionamiento local.
