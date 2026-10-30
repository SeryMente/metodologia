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
18. [Khora PR #338](https://github.com/SeryMente/khora/pull/338), candidato de implementación, y [Metodología PR #19](https://github.com/SeryMente/metodologia/pull/19), documentación; ambos siguen en borrador. [Khora PR #337](https://github.com/SeryMente/khora/pull/337) quedó cerrado sin merge por desfase del SHA.

## Relación entre documentación y código
El OCP vive en `SeryMente/metodologia/frentes/mcp-jules/`. El servidor MCP y el adaptador se integran en el único servidor existente de `SeryMente/khora`. Los repositorios se versionan por separado, y los cambios no se consideran publicados hasta leer de vuelta la rama/PR/merge correspondiente.

## Estado vivo
**Titularidad actual:** generación 2, folio `SES-20261029-6C2F9A17`, evento `C-MCP-JULES-005`; transferencia explícita y lectura de vuelta registradas en [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json) y [crónica](cronica/C-MCP-JULES-005.md). El control del frente padre Metacanon permanece independiente e intacto.

**Modelo de proyecto: EXACTAMENTE DOS FASES.** Fase 1 — planeación integral: COMPLETA como diseño R3. Fase 2 — implementación E2E, validación, release, despliegue y puesta en servicio hasta sistema utilizable desde ChatGPT Free: PENDIENTE y única fase restante. Las etapas internas 2.1–2.5 no son fases nuevas. Plan rector de 24 secciones y 32 pruebas/gates: [PLAN-INTEGRAL-MCP-JULES-v1.0.md](PLAN-INTEGRAL-MCP-JULES-v1.0.md). ChatGPT Free es obligatorio; Codex está excluido.

El PR documental #19 y el PR de implementación Khora #338 siguen en borrador. El último diagnóstico persistido reporta typecheck, ui-review, UI contract y API tests aprobados; 547 PASS/1 FAIL en la suite unitaria por falta de GH_TOKEN para leer el esquema privado de Metacanon; Ruff falla en dos archivos Python ajenos; build/E2E fallan aguas abajo. Los workflows de gobernanza de Metacanon fallaron, pero los logs no se recuperaron y la causa exacta quedó NO VERIFICADA. La variable sensible `JULES_API_KEY` está definida en producción Vercel, consultada con `decrypt=false`; su validez sigue sin probarse. Estos resultados deben refrescarse contra los heads vigentes. No se declara merge, despliegue ni conexión real de ChatGPT Free.
