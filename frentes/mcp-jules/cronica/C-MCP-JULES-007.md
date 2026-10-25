# C-MCP-JULES-007 · estado consolidado de aceptación del MCP Jules

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-2D7A8C41.  
**Sesión del frente:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** `frentes/mcp-jules/`.  
**PR de implementación:** [SeryMente/khora #336](https://github.com/SeryMente/khora/pull/336).  
**PR documental:** [SeryMente/metodologia #18](https://github.com/SeryMente/metodologia/pull/18).

## Estado funcional de la implementación

El código candidato expone siete herramientas nuevas en el MCP de Khora existente, con scopes separados `jules:read` y `jules:write`, conserva la puerta normativa y fuerza aprobación de plan en creación de sesión. El contrato y las pruebas correspondientes están incluidos en el PR #336. No se creó un segundo servidor.

## Evidencia de aceptación

### Revisión anterior verificada: `8a8d8404aaaee39898665530f711d3ca927e6ea8`

- CI: **PASS**.
- G-4 Fronteras del Kernel: **PASS**.
- UI Contract: **PASS**.
- UI Quality: **FAIL**. El log registra 17 pruebas E2E aprobadas y 3 fallidas. Las fallidas son:
  - navegación del shell a `/grafo` que esperaba el texto `Error: Error fetching graph data` cuando el título del grafo no se renderizaba;
  - accesibilidad por teclado del grafo en desktop y mobile, donde no apareció el botón de inspección del nodo sintético.
- `khora-web/e2e/ui-quality.spec.ts` es idéntico al archivo de `main`; el test `e2e/shell-v2.spec.ts` tampoco fue modificado por este PR. Estos fallos no apuntan a las nuevas herramientas de Jules, pero el gate global de interfaz permanece rojo y no se deben ignorar al fusionar.
- `khora-ok` quedó `IN_PROGRESS` en la última lectura; no se declara PASS.
- Los cambios posteriores en `khora-web/docs/normative-check.md` dispararon una nueva ronda para la punta de rama `2c2c31037999339708dac4a1684d127f76a38f87`; en el momento de esta crónica sus workflows estaban `IN_PROGRESS` o `QUEUED`. Por ello la aceptación de esa punta exacta queda **NO VERIFICADA**.

### Metacanon

El PR #18 incluye el OCP independiente, la investigación, el plan de aceptación, prompts de uso y la guía de replicación. Los workflows `validate-canonical-bootstrap` y `Validate RDC Governance` siguen fallando inmediatamente sin pasos/runner ni logs recuperables en la integración GitHub consultada. No hay base para atribuirlos a una aserción concreta; la causa del bloqueo sigue **NO VERIFICADA**. La fuente canónica HTML no se modificó y no se crearon fuentes normativas espejo.

## Despliegue y uso real

- Los checks de Vercel devuelven `build-rate-limit`; la rama no tiene despliegue productivo probado. Un preview Netlify anterior no acredita producción.
- Se observó una variable sensible `JULES_API_KEY` en el entorno production de Vercel con descifrado desactivado. Su valor no se leyó ni se registró; la validez de la credencial no está probada.
- No se ha realizado una llamada autenticada real a la API de Jules desde este MCP.
- No se ha probado la conexión del MCP actualizado desde ChatGPT ni el circuito real `crear sesión → leer plan → aprobar → recibir pregunta → responder → releer actividad`.
- La automatización persistente por sondeo requiere un trabajador externo; el worker no se implementó dentro del MVP interactivo.

## Dictamen

**Código candidato construido, MVP remoto todavía no utilizable/verificado.** No fusionar ni declarar terminado hasta verificar los gates materiales sobre la punta actual, resolver el acceso de despliegue y probar el circuito real desde ChatGPT. Los fallos E2E observados están en tests existentes sin cambios del PR, pero deben quedar visibles y no se deben maquillar cambiando la expectativa sin demostrar el comportamiento correcto.
