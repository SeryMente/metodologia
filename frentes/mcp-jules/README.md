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
11. [Khora PR #337](https://github.com/SeryMente/khora/pull/337) y [Metacanon PR #19](https://github.com/SeryMente/metodologia/pull/19), ambos en borrador.

## Relación entre documentación y código
El OCP vive en `SeryMente/metodologia/frentes/mcp-jules/`. El servidor MCP y el adaptador se integran en el único servidor existente de `SeryMente/khora`. Los repositorios se versionan por separado, y los cambios no se consideran publicados hasta leer de vuelta la rama/PR/merge correspondiente.

## Estado vivo
El núcleo, la investigación y los criterios están registrados. Los PR #337 y #19 están abiertos en borrador. El segundo conjunto de workflows de Khora sigue en ejecución; se corrigió el regex de la fixture que había detenido el primer typecheck. La comprobación ruff sigue fallando en archivos Python ajenos al diff. Las previsualizaciones Vercel alcanzan un límite de compilaciones del plan. Los dos workflows de gobernanza de Metacanon fallaron, pero los logs no fueron recuperables; causa exacta no verificada. Tests aprobados, API key real, conexión ChatGPT, merge y despliegue no se declaran.
