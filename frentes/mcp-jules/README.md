# Frente MCP Jules · índice

**Ciclo vigente:** [C-MCP-JULES-009 · modelo de exactamente dos fases](cronica/C-MCP-JULES-009.md). Núcleo `OBJETO-CANONICO.md`, titularidad en generación 2.

Este es el índice de navegación del frente MCP Jules. El único estado vivo está en [OBJETO-CANONICO.md](OBJETO-CANONICO.md); la titularidad y la generación solo proceden de [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No crear un segundo estado.

## Entrada operativa
1. [Objeto canónico](OBJETO-CANONICO.md) — propósito, alcance y estado vivo.
2. [Plan integral MCP Jules v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md) — línea base de diseño.
3. [Control de responsabilidad](CONTROL-RESPONSABILIDAD.json) — titularidad del frente independiente.
4. [Instrucción original](originales/C-MCP-JULES-001-operador.txt).
5. [Investigación técnica](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
6. [Plan de aceptación MVP](pruebas/PLAN-ACEPTACION-MVP.md).
7. [Contrato del asistente MCP](prompts/ASISTENTE-MCP.md).
8. [Contrato de prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
9. [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
10. [Crónica de creación C-MCP-JULES-001](cronica/C-MCP-JULES-001.md).
11. [Crónica de implementación candidata C-MCP-JULES-002](cronica/C-MCP-JULES-002.md).
12. [Diagnóstico de CI C-MCP-JULES-004](cronica/C-MCP-JULES-004.md).
13. [Transferencia de titularidad C-MCP-JULES-005](cronica/C-MCP-JULES-005.md).
14. [Decisión de fase y plan v1.0 C-MCP-JULES-006](cronica/C-MCP-JULES-006.md) — antecedente de planeación.
15. [Cierre R1 de Fase 1 C-MCP-JULES-007](cronica/C-MCP-JULES-007.md) — antecedente.
16. [Cierre R2 de Fase 1 C-MCP-JULES-008](cronica/C-MCP-JULES-008.md) — antecedente técnico.
17. [Modelo de dos fases C-MCP-JULES-009](cronica/C-MCP-JULES-009.md) — Fase 1 planeación completa; Fase 2 implementación E2E hasta sistema utilizable.
18. [Implementación candidata C-MCP-JULES-010](cronica/C-MCP-JULES-010.md) — PR #344 apilada sobre Custodia; ACL por sujeto/fuente/rama y primer estado de validación.
19. [Auditoría estática C-MCP-JULES-011](cronica/C-MCP-JULES-011.md) — corrección de rama default/fixture y CI sin ejecución.
20. [Hardening ACL C-MCP-JULES-012](cronica/C-MCP-JULES-012.md) — preflight antes del proveedor, negativos exactos y POST no-retry.
21. [Aprobación verificable C-MCP-JULES-013](cronica/C-MCP-JULES-013.md) — ID/SHA-256 del plan y doble preflight; proveedor sin aprobación condicional atómica.
22. [Khora PR #344](https://github.com/SeryMente/khora/pull/344), candidato vigente en borrador, apilado sobre Custodia.
23. [Khora PR #340](https://github.com/SeryMente/khora/pull/340), PR base de Custodia, aún en borrador.
24. [Khora PR #338](https://github.com/SeryMente/khora/pull/338), candidato anterior obsoleto, sin merge; [Metodología PR #19](https://github.com/SeryMente/metodologia/pull/19) sigue en borrador.

## Relación entre documentación y código
El OCP vive en `SeryMente/metodologia/frentes/mcp-jules/`. El servidor MCP y el adaptador se integran en el único servidor existente de `SeryMente/khora`. Los repositorios se versionan por separado, y los cambios no se consideran publicados hasta leer de vuelta la rama/PR/merge correspondiente.

## Estado vivo

**Titularidad actual:** generación 2, folio `SES-20261029-6C2F9A17`, evento de transferencia `C-MCP-JULES-005`. El [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json) y el control independiente del frente padre Metacanon no se modificaron.

**Modelo de proyecto: EXACTAMENTE DOS FASES.** Fase 1 — planeación integral: COMPLETA como diseño R3. Fase 2 — implementación E2E, validación, release, despliegue y puesta en servicio hasta sistema utilizable desde ChatGPT Free: EN CURSO y única fase restante. Las etapas 2.1–2.5 no son fases nuevas. Plan rector de 24 secciones y 32 gates: [PLAN-INTEGRAL-MCP-JULES-v1.0.md](PLAN-INTEGRAL-MCP-JULES-v1.0.md). ChatGPT Free es obligatorio; Codex está excluido.

**Candidato vigente:** [Khora PR #344](https://github.com/SeryMente/khora/pull/344), draft, rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `ad7826a186ff9f74b51874aa4bae04725a2e33c4`, apilada sobre `fix/custodia-recovery-verified-20261029` / PR #340 para preservar la integración pendiente de Custodia. PR #338 es antecedente obsoleto y no se fusiona.

**Código incluido:** siete herramientas MCP Jules, scopes separados sin ampliar defaults, ACL exacta por sujeto/fuente/rama, filtrado de fuentes/sesiones, comprobación de `sources.get` y rama antes de crear, paginación oficial y protección contra reintentos de escrituras ambiguas. La migración `033_jules_source_acl.sql` está versionada y no aplicada; el rol read-only real y sus permisos deben verificarse antes de provisionar ACL.

**Validación:** los tests sintéticos de ruta y del cliente están añadidos, pero todos los gates T01–T32 siguen PENDIENTE. Los workflows UI Quality `41086322565` y CI `41086322753` del head actual, además del CI duplicado `41086312312`, terminaron antes de ejecutar pasos (`steps: null`); los logs no están disponibles. Vercel denegó deploy previews por la limitación del plan para repositorios privados de organización. No hay evidencia de una compilación o suite PASS en este head. No se declara merge, despliegue, API Jules real, plugin publicado, conexión ChatGPT Free ni E2E.

**Pendientes externos y de aceptación:** ejecución de CI; verificación del rol DB y migración/read-back ACL; llamada real Jules; OAuth y aislamiento reales; revisión/publicación del plugin; instalación y escritura en cuenta Free; ciclo E2E; release autorizado y smoke/rollback. T22 sigue pendiente porque la aprobación aún no está vinculada por huella al plan exacto revisado. T22 está parcialmente mitigado: se comprueba dos veces la huella del plan, pero Jules no ofrece un endpoint condicional que elimine la carrera entre lectura y aprobación. Ver [C-MCP-JULES-013](cronica/C-MCP-JULES-013.md).

