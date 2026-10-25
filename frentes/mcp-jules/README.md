# Frente MCP Jules · índice

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
El núcleo, la investigación y los criterios están registrados. El PR #337 quedó cerrado sin merge; PR #338 y PR #19 siguen en borrador. En el SHA 4e5c299 de Khora, typecheck, ui-review, UI contract y API tests pasan; la suite unitaria termina con 547 PASS/1 FAIL porque falta GH_TOKEN para leer el esquema privado de Metacanon, y Ruff falla en dos archivos Python ajenos. Build y E2E fallan aguas abajo del unit gate. La variable sensible JULES_API_KEY está definida para producción en Vercel; se consultó con decrypt=false y su validez sigue sin probarse. Los workflows de gobernanza de Metacanon fallaron, pero sus logs no se pudieron recuperar; causa exacta NO VERIFICADA. No se declara merge, despliegue ni conexión real ChatGPT.
