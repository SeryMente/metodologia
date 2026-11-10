# Decisiones de portabilidad · MCP-OCP Hito A

**Corte:** 2026-11-10. **Rama candidata:** feat/mcp-ocp-p004-pilot-20261110-cycle02.
**Base limpia:** main HEAD 73a42bc687f1fa3dd60b44af9cd93f797eba3920.
**Fuente DUG:** Samantha v387/NX-387m; commit 17a4da1d3906e2397ab4682ff46cc9a9f116f34d; blob c8d37d92aed7ff9d4fe94e7a9541e76ba5c88a2c.

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
- **ADAPT:** ninguna pieza funcional se ha copiado literalmente; el contrato se reimplementa contra DUG v387.
- **DROP:** DB, vault, credenciales, B2, backups, claves, importador persistente, operaciones de escritura, herramientas generales y paquete histórico.
- **RID:** no aplica al piloto framework-dependent; win-x64 se difiere al paquete. **Pendiente:** ejecutar build/tests con SDK 10.0.403 en runner autorizado; después escribir el smoke del ejecutable compilado.

La clasificación de seguridad/crypto/DB se basa en el inventario de rutas y la inspección de nombres/propósitos; no se afirma auditoría exhaustiva de cada implementación histórica. No se portó código de esas rutas.
