# Frente MCP Jules · índice

**Ciclo vigente:** [C-MCP-JULES-005 · transferencia de responsabilidad](cronica/C-MCP-JULES-005.md). Núcleo `OBJETO-CANONICO.md`, titularidad en generación 2.

Este es el índice de navegación del frente MCP Jules. El único estado vivo está en [OBJETO-CANONICO.md](OBJETO-CANONICO.md); la titularidad y la generación solo proceden de [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No crear un segundo estado.

## Entrada operativa
1. [Objeto canónico](OBJETO-CANONICO.md) — propósito, alcance, aceptación y estado vivo.
2. [Control de responsabilidad](CONTROL-RESPONSABILIDAD.json) — titularidad de este frente independiente.
3. [Instrucción original](originales/C-MCP-JULES-001-operador.txt).
4. [Investigación técnica](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
5. [Plan de aceptación](pruebas/PLAN-ACEPTACION-MVP.md).
6. [Contrato del asistente MCP](prompts/ASISTENTE-MCP.md).
7. [Contrato de prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
8. [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
9. [Crónica inicial](cronica/C-MCP-JULES-001.md).
10. [Implementación candidata y estado de CI](cronica/C-MCP-JULES-002.md).
12. [C-MCP-JULES-004](cronica/C-MCP-JULES-004.md) — diagnóstico canónico y PR vigente.
11. [Khora PR #338](https://github.com/SeryMente/khora/pull/338), candidato vigente, y [Metacanon PR #19](https://github.com/SeryMente/metodologia/pull/19), ambos en borrador. [PR #337](https://github.com/SeryMente/khora/pull/337) quedó cerrado sin merge por desfase del SHA.

## Relación entre documentación y código
El OCP vive en `SeryMente/metodologia/frentes/mcp-jules/`. El servidor MCP y el adaptador se integran en el único servidor existente de `SeryMente/khora`. Los repositorios se versionan por separado, y los cambios no se consideran publicados hasta leer de vuelta la rama/PR/merge correspondiente.

## Estado vivo
**Titularidad actual:** generación 2, folio `SES-20261029-6C2F9A17`, evento `C-MCP-JULES-005`; transferencia explícita y lectura de vuelta registradas en [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json) y [crónica](cronica/C-MCP-JULES-005.md). El control del frente padre Metacanon permanece independiente e intacto.

El PR documental #19 y el PR de implementación Khora #338 siguen en borrador. El último diagnóstico persistido reporta typecheck, ui-review, UI contract y API tests aprobados; 547 PASS/1 FAIL en la suite unitaria por falta de GH_TOKEN para leer el esquema privado de Metacanon; Ruff falla en dos archivos Python ajenos; build/E2E fallan aguas abajo. Los workflows de gobernanza de Metacanon fallaron, pero los logs no se recuperaron y la causa exacta quedó NO VERIFICADA. La variable sensible `JULES_API_KEY` está definida en producción Vercel, consultada con `decrypt=false`; su validez sigue sin probarse. Estos resultados deben refrescarse contra los heads vigentes. No se declara merge, despliegue ni conexión real de ChatGPT.
