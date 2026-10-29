# C-MCP-JULES-006 · definición de fase 1 y plan integral v1.0

**Fecha:** 2026-10-29. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Gobierno:** DUG Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9. **Evento:** `C-MCP-JULES-006`.

## Decisión del operador

El operador estableció: «La primera fase es la planeacion plean, y completa, del componente en su verison 1.0.»

Interpretación literal normalizada de propósito, sin ampliar su alcance: la fase vigente es la planeación integral del componente MCP Jules v1.0; la implementación no es el objetivo de esta primera fase.

## Artefacto producido

Se crea [PLAN-INTEGRAL-MCP-JULES-v1.0.md](../PLAN-INTEGRAL-MCP-JULES-v1.0.md) como línea base de diseño. Define propósito, resultado funcional, arquitectura en el MCP central de Khora, siete herramientas, ciclo delegación/plan/aprobación/actividad/feedback/validación, modelo de estados, persistencia, seguridad, requisitos no funcionales, aceptación, despliegue, rollback, fases posteriores y decisiones críticas de viabilidad.

Fuentes oficiales comprobadas durante el ciclo:
- [Referencia REST de Jules](https://developers.google.com/jules/api/reference/rest): incluye métodos de sources, sessions y activities.
- [Recurso Session](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions): documenta estados y `requirePlanApproval`.
- [OpenAI — conexión de servidores MCP personalizados en ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt): la compatibilidad completa de escritura depende del plan/espacio de trabajo real; queda como gate de viabilidad por verificar.

## Límites de este ciclo

- No se modificó código del producto ni se declaró una llamada real a Jules.
- No se validó `JULES_API_KEY` ni se conectó un cliente ChatGPT real.
- No se inició un trabajador persistente ni se amplió el alcance al funcionamiento en segundo plano.
- No se modificó el DUG normativo ni el control del frente padre Metacanon.
- Los PR existentes son candidatos previos a reconciliar contra el plan v1.0; no son evidencia de aceptación.

## Siguiente paso

Completar la revisión de consistencia del plan integral contra el OCP, el plan de aceptación, los prompts y los PR de Metodología/Khora. Después, resolver la compuerta real de compatibilidad ChatGPT con escritura y cerrar cualquier contradicción de diseño. La implementación pertenece a la fase posterior y debe seguir la línea base aceptada y su matriz de aceptación.

## Persistencia

En este ciclo se actualizan el núcleo y el README para apuntar al plan y reflejar la fase actual. Se leyeron de vuelta el plan integral, el núcleo, el README, el plan de aceptación y esta crónica; los contenidos coinciden con las escrituras reportadas. El inventario ya contiene la entrada MCP Jules en esta rama; no se crea una segunda entrada ni un nuevo control.
