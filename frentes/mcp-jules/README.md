# Frente MCP Jules · índice

**Ciclo vigente:** [C-MCP-JULES-016 · reconfiguración de tareas, ruta RDC y separación MCP-OCP/Khora](cronica/C-MCP-JULES-016.md). Núcleo `OBJETO-CANONICO.md` v0.1.13; titularidad en generación 3, folio pendiente por FOL1 inactivo.

Este es el índice de navegación del frente MCP Jules. El único estado vivo está en [OBJETO-CANONICO.md](OBJETO-CANONICO.md); la titularidad y la generación solo proceden de [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No crear un segundo estado.

## Entrada operativa
1. [Objeto canónico](OBJETO-CANONICO.md) — estado vivo, propósito, alcance y decisiones vigentes.
2. [Lista provisional de tareas](LISTA-TAREAS-PROVISIONAL.md) — backlog temporal MCP-JULES-01–10 y gates antes de usar Jules.
3. [Plan integral MCP Jules](PLAN-INTEGRAL-MCP-JULES-v1.0.md) — v1.1.0, decisión RDC/stdio vigente; plugin público queda supersedido.
4. [Plan de aceptación MVP](pruebas/PLAN-ACEPTACION-MVP.md) — v1.9.0, criterios T01–T38.
5. [Control de responsabilidad](CONTROL-RESPONSABILIDAD.json) — titularidad única, generación 3.
6. [Investigación técnica](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
7. [Contrato del asistente MCP](prompts/ASISTENTE-MCP.md).
8. [Contrato de prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
9. [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
10. [Crónica C-MCP-JULES-016](cronica/C-MCP-JULES-016.md).
11. [Evidencia C-MCP-JULES-016](evidencias/C-MCP-JULES-016.json).
11. [Crónica C-MCP-JULES-015](cronica/C-MCP-JULES-015.md) — retoma RDC, original y transferencia.
12. [Original documental ChatGPT-JULES-20261030-1858.md](documentos/originales/ChatGPT-JULES-20261030-1858.md) y [manifiesto](documentos/MANIFIESTO-DOCUMENTAL.json).
13. [Evidencia C-MCP-JULES-015](evidencias/C-MCP-JULES-015.json).

## Relación entre documentación y código
El OCP y su backlog provisional viven en `SeryMente/metodologia/frentes/mcp-jules/`. Las siete herramientas y el puente local se integran en el único servidor existente de `SeryMente/khora`; el cliente bridge corre local por RDC/stdio. MCP-OCP es un producto independiente de Metodología y no pertenece a Khora. Los repositorios se versionan por separado; cada cambio se acredita leyendo de vuelta el ref/commit/PR correspondiente.

## Estado vivo

**Titularidad actual:** generación 3, propietario operativo chatgpt-C-MCP-JULES-015-01a18f95-61cf-70ce-9321-c56fbd3cc99d, instancia chatgpt-mcp-jules-2026-10-30-01a18f95. No se expuso un ID nativo de ChatGPT. Folio PENDIENTE / NO ASIGNADO porque FOL1 permanece inactivo. El control no fue modificado por el ciclo 016.

**Modelo de proyecto: EXACTAMENTE DOS FASES.** Fase 1 — planeación integral: COMPLETA como línea base. Fase 2 — implementación E2E, validación, release y puesta en servicio: EN CURSO. El plan operativo vigente es v1.1.0; la matriz de aceptación v1.9.0 tiene T01–T38; el backlog auxiliar v0.1 contiene MCP-JULES-01–10.

**Ruta operativa actual:** ChatGPT Free a través del cliente MCP local stdio operado por RDC y OAuth 2.1 Authorization Code + PKCE contra Khora. No requiere plugin público ni Bearer manual. No levanta un servidor local adicional ni listener permanente. El propietario confirma consentimiento OAuth en navegador. JULES_API_KEY permanece exclusivamente en Khora Production.

**Código integrado:** siete herramientas Jules en Khora main por PR #345, merge 953e69484eabb4e8dc8221d1d8fc188373531bfa. Bridge local RDC/OAuth PKCE por PR #347, merge 4530e03a33c5e1743ab9646eb6c862b3c458c605. Los PR están fusionados; no se reportan como abiertos.

**Evidencia histórica:** suites 568/568 y 572/572, TypeScript, UI Review, DPAPI sintético, DCR y build Next.js 78/78 en PC-14. Estas pruebas corresponden a cortes anteriores y no acreditan el perfil RDC activo ni el OAuth real actual.

**Estado pendiente:** el dispositivo RDC visible PC10RCIF4EI4 está online, pero aún falta preparar el bridge en su clon local, completar consentimiento OAuth real del propietario, comprobar tools/list, lectura real de fuentes/sesiones/activities y ejecutar E2E en sandbox. El smoke inicial será solo de lectura. No se ha creado una sesión Jules ni ejecutado escritura en este ciclo.

**Pausa operativa:** el operador ha indicado que no utilizará el frente ni las herramientas Jules hasta que quede configurado el backlog. Esta lista, el plan, la matriz, el OCP y el README quedan reconfigurados en esta rama; la continuación operativa queda pendiente de que el operador retome el frente y ordene el smoke OAuth.

**Separación de producto:** el servidor local MCP-OCP pertenece exclusivamente a SeryMente/metodologia y a su OCP. Khora conserva solo su propio servidor MCP /api/mcp y el bridge Jules como cliente. No comparten titularidad, controles, claves ni estado. La integración de MCP-OCP con ambos procesos locales se debe probar en conjunto.

**T22:** Jules no ofrece aprobación condicional atómica por plan digest. La relectura/doble preflight reduce la carrera pero no la elimina; conservar como limitación residual.

**PR documental #19:** sigue OPEN/DRAFT/NOT MERGED. La lista y cambios del plan/aceptación quedan guardados en su rama. No se integra a main por esta autorización puntual; merge requiere revisión y autorización separada.

**PR obsoletas/antecedentes:** #344 y #338 fueron candidatas supersedidas; #340 pertenece a Custodia. No se modificaron.
