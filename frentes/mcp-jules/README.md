# Frente MCP Jules · índice

Este es el índice del frente **MCP Jules**. El único estado vivo del frente está en [OBJETO-CANONICO.md](OBJETO-CANONICO.md); la titularidad, folio y generación proceden exclusivamente de [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No crear estados paralelos.

## Entrada operativa

1. [Objeto canónico](OBJETO-CANONICO.md) — propósito, alcance, estado, aceptación y siguientes pasos.
2. [Control de responsabilidad](CONTROL-RESPONSABILIDAD.json) — titularidad de este frente.
3. [Investigación Jules API / ChatGPT / automatización](fuentes/INVESTIGACION-API-JULES-CHATGPT.md) — capacidades verificadas y límites.
4. [Plan de aceptación del producto mínimo viable (MVP)](pruebas/PLAN-ACEPTACION-MVP.md) — pruebas falsables.
5. [Prompt del asistente MCP](prompts/ASISTENTE-MCP.md) — contrato operativo de uso desde ChatGPT.
6. [Prompt para Jules constructor](prompts/JULES-CONSTRUCTOR.md) — plantilla reutilizable con cláusula explícita de no simulación.
7. [Guía de replicación en otros frentes](replicacion/GUIA-REPLICACION-FRENTES.md) — conexión al servidor común, permisos mínimos y prueba de adopción.
8. [Crónica del ciclo inicial](cronica/C-MCP-JULES-001.md).
9. [Estado y aceptación de la implementación candidata](cronica/C-MCP-JULES-002.md).
10. [Evidencia inicial de CI](cronica/C-MCP-JULES-003.md).
11. [Endurecimiento de pruebas y estado de entrega](cronica/C-MCP-JULES-004.md).
12. [Restauración del OCP y estado de la punta](cronica/C-MCP-JULES-005.md).
13. [Diagnóstico y corrección del entorno E2E](cronica/C-MCP-JULES-006.md).
14. [Estado consolidado de aceptación](cronica/C-MCP-JULES-007.md).

## Frontera entre documentación e implementación

El objeto de persistencia de este frente vive en `SeryMente/metodologia/frentes/mcp-jules/`. La implementación del servidor MCP se integra en el servidor existente de `SeryMente/khora`, no como un segundo servicio independiente. La ubicación y el versionado del código se verificarán contra la rama canónica de Khora en cada corte.

## Estado inicial

- Frente separado del OCP Metacanon existente: sí.
- Contrato de alcance y criterios de aceptación: registrados.
- Código MCP Jules: candidato implementado en [PR Khora #336](https://github.com/SeryMente/khora/pull/336), rama `feat/mcp-jules-tools-20261025`; la CI de la punta actual sigue en verificación. Vercel bloquea builds con `build-rate-limit`; no se declara despliegue ni conexión real.
- Credencial `JULES_API_KEY`: nunca se guarda en Git; debe configurarse en el entorno de servidor autorizado.
- Automatización continua: investigación y arquitectura registradas; un sondeo persistente requiere infraestructura externa activa.
