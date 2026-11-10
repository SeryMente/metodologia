# Decisiones de portabilidad · MCP-OCP Hito A

**Corte:** 2026-11-10. **Rama candidata:** feat/mcp-ocp-p004-pilot-20261110-cycle05.
**Base limpia:** main HEAD 0f933b9e3efae20131da37f99f50f4bc4a4eaf74.
**Fuente DUG:** Samantha v388/NX-388m; commit 3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c; blob 4db0ebadfd1e48b2bdec9236ba7f344921e4a865.

## Ramas históricas inspeccionadas

| Rama | Relación actual con main | Decisión |
|---|---:|---|
| integration/ocp-mcp-0.1.0-selective-20261101 | 3 ahead / 592 behind; diverged | Solo lectura; no merge completo |
| build/ocp-mcp-mvp-0.1.0 | 11 ahead / 911 behind; diverged | Inspección selectiva; no merge completo |
| feat/mcp-ocp-sink-p004-pilot-20261110 | 0 ahead / 6 behind; sin commits | No reutilizada; rama vacía histórica |

Las cifras corresponden a compare contra main HEAD 73a42bc… al corte. Ninguna rama histórica se utilizó como base.

## Componentes consultados y clasificación

La rama integration se inspeccionó en csproj, Program, McpServer, PrincipleCatalog, SourceImporter, pruebas, Build.ps1, plantilla de fuentes y .gitignore. La rama build se inspeccionó en csproj, Program, McpServer, PrincipleCatalog, SourceImporter, pruebas, Build.ps1 y plantilla de fuentes. Las clases de seguridad y almacenamiento se clasifican por ruta/propósito y no se portaron; no se afirma auditoría línea por línea de todas ellas.

| Componente histórico | Clasificación | Motivo |
|---|---|---|
| OcpMcp.csproj | REWRITE | Se conserva únicamente .NET 10 como baseline; se eliminan paquetes DB/crypto ajenos al piloto. |
| Program.cs | REWRITE | El host anterior inicializaba SQLite, vault, backups y comandos de provisión; el piloto solo inicia STDIO y resuelve raíz del repo. |
| Protocol/McpServer.cs | REWRITE | El servidor histórico exponía herramientas de operaciones protegidas y no resolvía SINK:P004; se implementa handshake y una herramienta acotada. |
| Services/PrincipleCatalog.cs | DROP para Hito A | Catálogo de 43 MDP no necesario para el corte individual P004. |
| Services/SourceImporter.cs | DROP para Hito A | Importación persistente/cifrada fuera del piloto; la lectura se hace directamente desde el DUG pinneado. |
| Security/CryptoBox.cs, KeyVault.cs, ReceiptSigner.cs, EventChain.cs | DROP | Secretos, claves, vault y cadenas persistentes fuera del alcance; ningún dato operativo persistente. |
| Services/OperationService.cs, BackupService.cs y Storage/SqliteStore.cs | DROP | Operaciones, backups y SQLite no requeridos para lectura de P004. |
| UnitTests/Program.cs | REWRITE | Suite histórica probaba operaciones protegidas/DB, no el contrato Sink actual. |
| Smoke.ps1 y Build.ps1 | NO PORTADOS | Dependen del ejecutable compilado y del flujo de paquete anterior; requieren reescritura tras disponer de runner .NET. |
| initial-sources.template.json | DROP | Contiene pins DUG/core obsoletos y un flujo de importación persistente que no aplica. |

## Implementación actual

- **REUSE:** target framework net10.0 como referencia tecnológica del código histórico; SDK fijado en global.json a 10.0.403, sin afirmar que esté instalado en este entorno.
- **REWRITE:** servidor STDIO, lector DUG, pins, herramienta SINK:P004 y suite del piloto.
- **ADAPT:** ninguna pieza funcional se ha copiado literalmente; el contrato se reimplementa contra DUG v388.
- **DROP:** DB, vault, credenciales, B2, backups, claves, importador persistente, operaciones de escritura, herramientas generales y paquete histórico.
- **RID:** no aplica al piloto framework-dependent; win-x64 se difiere al paquete. **Pendiente:** ejecutar build, 13 pruebas y smoke ya escritos con SDK 10.0.403 en runner autorizado; no hay PASS actual.

La clasificación de seguridad/crypto/DB se basa en el inventario de rutas y la inspección de nombres/propósitos; no se afirma auditoría exhaustiva de cada implementación histórica. No se portó código de esas rutas.


## Base anterior cycle04 (referencia)

La rama cycle04 se crea directamente desde main HEAD 0f933b9e3efae20131da37f99f50f4bc4a4eaf74, con 0 commits por detrás al crearla. Los ocho commits incorporados después del DUG v388 actualizan los objetos de coordinación de Gobernanza; el blob DUG continúa 4db0ebadfd1e48b2bdec9236ba7f344921e4a865. No se arrastran las dos escrituras parciales de cycle03 ni la divergencia de cycle02.


## Reconciliación actual · cycle05 · 2026-11-10

La rama cycle05 se creó directamente desde main HEAD 0f933b9e3efae20131da37f99f50f4bc4a4eaf74 y la comparación inicial devolvió 0 ahead/0 behind. Cycle04 quedó 22 ahead/6 behind cuando main cambió core y backlog; no se usa como base. La portabilidad de sus componentes sirve como lectura selectiva, no como merge. DUG v388 permanece commit 3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c/blob 4db0ebadfd1e48b2bdec9236ba7f344921e4a865.


## Estado de CI cycle05

PR #24 está abierto en draft y mergeable=true; PR #23 fue cerrado supersedido. Los runs MCP-OCP 24/25 terminaron FAILURE sin steps/logs/artifacts; en run25 otros dos workflows del repositorio fallaron igual. No se confirma ejecución de build/tests ni causa raíz. Se requiere runner Actions operativo o runner .NET autorizado para obtener evidencia. Código/test escritos no equivalen a aceptación.
