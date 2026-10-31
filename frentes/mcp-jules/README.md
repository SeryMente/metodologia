# Frente MCP Jules · índice

**Ciclo vigente:** [C-MCP-JULES-015 · retoma RDC, persistencia del original y transferencia](cronica/C-MCP-JULES-015.md). Núcleo `OBJETO-CANONICO.md` v0.1.12; titularidad en generación 3, folio pendiente por FOL1 inactivo.

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
25. [Crónica de retoma RDC y transferencia C-MCP-JULES-015](cronica/C-MCP-JULES-015.md).
26. [Original ChatGPT-JULES-20261030-1858.md](documentos/originales/ChatGPT-JULES-20261030-1858.md) y [manifiesto](documentos/MANIFIESTO-DOCUMENTAL.json).
27. [Evidencia de persistencia y transferencia](evidencias/C-MCP-JULES-015.json).
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
22. [Revisión de seguridad y fixture C-MCP-JULES-014](cronica/C-MCP-JULES-014.md) — identidad exacta, digest de prueba, recuento corregido y redacción de rutas.
22. [Khora PR #344](https://github.com/SeryMente/khora/pull/344), candidato vigente en borrador, apilado sobre Custodia.
23. [Khora PR #340](https://github.com/SeryMente/khora/pull/340), PR base de Custodia, aún en borrador.
24. [Khora PR #338](https://github.com/SeryMente/khora/pull/338), candidato anterior obsoleto, sin merge; [Metodología PR #19](https://github.com/SeryMente/metodologia/pull/19) sigue en borrador.

## Relación entre documentación y código
El OCP vive en `SeryMente/metodologia/frentes/mcp-jules/`. El servidor MCP y el adaptador se integran en el único servidor existente de `SeryMente/khora`. Los repositorios se versionan por separado, y los cambios no se consideran publicados hasta leer de vuelta la rama/PR/merge correspondiente.

## Estado vivo

**Titularidad actual:** generación 3, propietario operativo `chatgpt-C-MCP-JULES-015-01a18f95-61cf-70ce-9321-c56fbd3cc99d`, instancia `chatgpt-mcp-jules-2026-10-30-01a18f95`. No se expuso un ID nativo de ChatGPT. Folio PENDIENTE / NO ASIGNADO porque FOL1 permanece inactivo. La transferencia desde generación 2 se verificó mediante lectura de vuelta del control. El frente padre Metacanon no fue modificado.

**Modelo de proyecto: EXACTAMENTE DOS FASES.** Fase 1 — planeación integral: COMPLETA. Fase 2 — implementación E2E, validación, release, despliegue y puesta en servicio: EN CURSO y única fase restante. ChatGPT Free continúa como cliente final; Codex permanece excluido.

**Ruta vigente para ChatGPT Free:** cliente MCP local stdio operado por RDC, autenticado mediante Khora OAuth 2.1 Authorization Code + PKCE. No requiere generar, copiar, pegar ni gestionar manualmente Bearers ni ejecutar comandos manuales. El propietario autenticado mediante `MCP_ALLOWED_EMAIL` recibe `jules:read` y `jules:write` sin grants por repositorio; los demás sujetos conservan ACL exacta y fail-closed. El propietario confirma una vez el consentimiento OAuth en el navegador de Khora. `JULES_API_KEY` permanece exclusivamente en Khora Production.

**Candidato de implementación vigente:** [Khora PR #347](https://github.com/SeryMente/khora/pull/347), abierta y no fusionada, rama `feat/jules-rdc-local-bridge-20261030`, head `cda38145fd74b109703be24b6e3eda4c0998b15a`. El cliente valida las siete herramientas antes de declarar ready; el access token se mantiene en memoria y el refresh token se cifra con DPAPI CurrentUser. El Preview Vercel `dpl_GdwKnsFJCo289dsCEfhyQaWPUJ2g` quedó READY para ese commit; la URL está protegida por SSO y Production no fue modificada.

**Validación local PC-14:** npm ci 576 paquetes PASS; TypeScript PASS; Node/PowerShell parse PASS; UI Review PASS; contrato de navegación PASS; DCR loopback y rechazos PASS; DPAPI sintético Store/Load/Status y read-back PASS; unitarias 572/572 PASS; build Next.js 16.4.0 PASS con 78/78 páginas. AUTH_SECRET de prueba fue aleatoria, efímera y eliminada; no se descargaron secretos de Production.

**Original documental:** `ChatGPT-JULES-20261030-1858.md` está guardado sin transformación en `documentos/originales/`, 241.772 bytes, SHA-256 cotejado. El manifiesto y la evidencia C015 tienen lectura de vuelta correcta. La persistencia y el control de titularidad están en la rama de este PR #19, OPEN/DRAFT/NOT MERGED; no se afirma todavía integración canónica en `main`.

**Pendiente de Fase 2:** consentimiento OAuth real del propietario; conexión MCP autenticada y `tools/list`; lectura real de fuentes/sesiones Jules; ciclo E2E (crear sesión, recibir actividad, responder, revisar entrega); gates de aceptación, release y smoke/rollback. T22 sigue parcial por la ausencia de aprobación condicional atómica en la API de Jules. El primer smoke test autenticado será de solo lectura; no creará tareas Jules.

**PR anteriores:** Khora #344 y #338 quedan como candidatos históricos/obsoletos; #340 corresponde a Custodia y no se modifica. Metodología PR #19 conserva este OCP y sus anexos hasta merge explícito.
