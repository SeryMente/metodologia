# Rebaseline de MCP-OCP · piloto SINK:P004

**Estado:** rama creada desde `main`; código portado selectivamente, todavía no compilado ni probado.
**Repositorio:** `SeryMente/metodologia`
**Base exacta:** `06467fb32f344e5ff7e4006479a4f614ecd21164`
**Rama nueva:** `feat/mcp-ocp-p004-rebaseline-20261110`
**DUG:** Samantha v388 / NX-388m · commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c` · blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
**Núcleo/backlog leídos:** MCP-OCP v0.1.28 · LIST_VERSION 0.9.
**Autorización:** CONTROL-RESPONSABILIDAD.json generación 5; extensión directa del operador AUTHORIZED para Sink STDIO, pruebas, build, paquete y documentación. Panel WPF AUTHORIZED_FOR_PRODUCT_SCOPE_AND_IMPLEMENTATION.

## 1. Inventario y decisión de portabilidad

| Componente | Decisión | Evidencia/razón |
|---|---|---|
| `src/OcpMcp/OcpMcp.csproj` histórico | REWRITE | Solo se conserva .NET 10 como base; sin SQLite, vault ni dependencias ajenas al corte. |
| `Program.cs` histórico | REWRITE | Arranque mínimo STDIO; no inicializa DB, credenciales ni servicios persistentes. |
| `McpServer.cs` histórico | REWRITE | Contrato JSON-RPC STDIO, initialize/initialized, tools/list/call; único Sink P004. |
| `DugSourceReader.cs` | REWRITE | Resolver fail-closed contra DUG v388 y blob exacto. |
| `SourcePin.cs` | REWRITE | Pines actuales DUG v388, no hereda v377/v386. |
| `PrincipleCatalog`, `SourceImporter` históricos | DROP en Hito A | Catálogo/importador persistente no son necesarios para el primer P004. |
| SQLite, CryptoBox, KeyVault, EventChain, ReceiptSigner, BackupService, OperationService | DROP | DB, secretos, custodia, escritura y backup quedan fuera del corte P004. |
| Pruebas históricas | REWRITE | No cubrían este contrato; se agregan fixtures sintéticos específicos. |
| Scripts/builds/paquetes históricos | DROP como artefactos | No se reutilizan binarios, manifiestos ni PASS antiguos. Se reconstruyen bajo pins vigentes. |
| Panel WPF | PENDIENTE | Contrato aprobado en `PANEL-OBSERVABILIDAD.md`; es obligatorio en 1.0.0, no bloquea P004. |

### Ramas históricas consultadas (solo lectura)

- `integration/ocp-mcp-0.1.0-selective-20261101`: 3 commits ahead / 620 behind; divergente.
- `build/ocp-mcp-mvp-0.1.0`: 11 ahead / 939 behind; divergente.
- `feat/mcp-ocp-p004-pilot-20261110-cycle05`: 26 ahead / 11 behind; divergente; PR #24 draft. No se usa como base ni se fusiona completa.
- El código P004 se porta por archivo desde la rama candidate como insumo, con revisión de pins y contrato; no se portan estados documentales históricos de core/backlog.

## 2. Versiones y publicación fijadas

- .NET SDK: **10.0.403**, fijado en `global.json`.
- Target framework del piloto: `net10.0`.
- Dependencias NuGet externas del piloto: **ninguna**.
- Piloto CI: framework-dependent y sin RID para ejecutar fixtures en runner Linux.
- Publicación del producto Windows 1.0.0: **win-x64**, self-contained; perfil de publicación separado.
- WPF usa `net10.0-windows` en el proyecto separado cuando se implemente MCP-OCP-13.

## 3. Contrato P004

El único tool del piloto es `sink_principle` con ID permitido `P004`. La respuesta devuelve texto íntegro, ID, título, ancla, MDP, preponderancia, versiones, firma, evento, commit, blob Git y SHA-256. La lectura valida el hash del blob antes de parsear el JSON embebido y rechaza de forma cerrada fuente ausente/alterada, metadatos no coincidentes, IDs duplicados/no completos, P004 distinto y MCP-NORMATIVO diferente de DESACTIVADO.

No hay HTTP/TCP, sockets, túneles, DB, secretos, proceso persistente ni instalación de host. stdout queda reservado para JSON-RPC; diagnóstico/eventos van por stderr.

## 4. Comandos de validación

Desde `frentes/mcp-metodologia/` con SDK 10.0.403:

```powershell
dotnet build .\src\OcpMcp\OcpMcp.csproj -c Release
dotnet build .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
dotnet run --project .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
pwsh .\piloto-sink\ci\Invoke-PilotValidation.ps1
```

Los comandos están documentados; aún no constituyen ejecución ni PASS. CI se ejecutará desde PR borrador tras subir el código.

## 5. Gates externos

- EP-TASK-003: Fila 4; preflight vivo, ubicación física, checkout/root protegido, XTS-AES256, Protection On, 100 %, protector recuperable/read-back; dead-man solo fuera de CECEQ. **Pendiente**, no bloquea desarrollo/fixtures.
- EP-TASK-005: instalación/importación de fuentes privadas y runtime local. **Pendiente**, depende de EP-TASK-003 PASS y paquete piloto verificado.
- GOV-TASK-007/003: preparación de IPZ y aceptación E2E. **Pendiente**, exige respuesta visible al modelo desde contexto IPZ por RDC/STDIO; consola JSON-RPC no basta.
- MCP-OCP-13: panel WPF para release 1.0.0; implementar contra contrato aprobado.

## 6. Exclusiones

No instalar en Fila 4; no importar fuentes privadas ni crear DB; no provisionar operador ni ejecutar `REGISTER <SID>`; no editar DUG/ART-025/ART-027/IPZ; no activar MCP-NORMATIVO ni FOL1; no mergear main; no abrir endpoints; no usar Khora, Jules, MOD-SYNC, Cloudflare ni B2.
