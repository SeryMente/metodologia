# C-MCP-JULES-007 · cierre de la planeación integral MCP Jules v1.0

**Fecha:** 2026-10-29. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Gobierno:** DUG Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9. **Evento:** `C-MCP-JULES-007`.

## Decisión y resultado

Se cierra la Fase 1 como **planeación integral completa del componente MCP Jules v1.0**, en cumplimiento del propósito delimitado por el operador. La fase produce una especificación de diseño lista para reconciliación e implementación; no afirma que el código exista en estado aceptado ni que la integración haya sido validada de extremo a extremo.

Línea base: [PLAN-INTEGRAL-MCP-JULES-v1.0.md](../PLAN-INTEGRAL-MCP-JULES-v1.0.md), actualizado con contrato oficial de API, arquitectura, siete herramientas, ciclo conversacional, estados, aprobación, paginación, política de errores/reintentos, seguridad, decisiones ADR, trazabilidad de requisitos, 25 pruebas/gates, operación, release, rollback y límites explícitos.

## Decisiones cerradas

- El complemento MCP se utiliza durante el ciclo activo de resolución en el chat normal. La invocación depende de que la app esté habilitada/seleccionada; no se promete ejecución oculta o de fondo.
- Se conserva el único servidor MCP de Khora y el endpoint `/api/mcp`; siete herramientas públicas.
- La creación fija `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`; un PR no autoriza merge ni despliegue.
- El servidor debe validar source/branch contra Jules antes de crear sesión.
- Los estados y las actividades se leen mediante la API documentada, con paginación `pageToken`.
- POST de creación/mensaje/aprobación no se reintentan ciegamente cuando el resultado es ambiguo.
- Se mantienen scopes separados, ciclo normativo, clave solo en servidor, errores saneados y outputs de Jules tratados como datos externos no confiables.
- No se incluyen trabajador persistente, autorespuesta ilimitada, auto-merge o auto-deploy en v1.0.

## Evidencia documental

El plan, el núcleo, el README, el plan de aceptación, los contratos de prompts, la guía de replicación y esta crónica se actualizan en la rama documental `feat/metacanon-mcp-jules-20261025-c32f81` y se verifican por lectura de vuelta. El inventario ya incluye la ruta del frente en esta rama.

Fuentes oficiales consultadas:
- [Jules REST API](https://developers.google.com/jules/api/reference/rest)
- [Jules Session resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions)
- [Jules sources.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sources/list)
- [Jules activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list)
- [OpenAI — conexión de servidores MCP personalizados](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt)

## Gates que pasan a fases posteriores

1. La elegibilidad real de la cuenta/espacio ChatGPT para escritura MCP no está verificada. La documentación consultada lista Business y Enterprise/Edu con escritura; Pro figura con lectura/recuperación. Plus no figura expresamente como compatible con escritura en la fuente consultada.
2. La validez de `JULES_API_KEY` no está verificada por llamada real; su valor no se recuperó.
3. El código candidato carece de verificación server-side source/branch y tiene retry HTTP común que puede reintentar POST no idempotentes. La fase 2 debe corregir estos deltas.
4. Los resultados de CI anteriores son históricos; deben refrescarse contra los heads vigentes. El PR #19 sigue abierto en borrador y sus workflows de gobernanza han reportado fallos ligados a validadores heredados; los logs no aportaron una causa por paso verificable.
5. No se ejecutó E2E real ni se conectó ChatGPT. No se declara MVP utilizable, merge o despliegue.

## Salida

**Fase 1: COMPLETA como especificación.** Siguiente fase: reconciliación del candidato de Khora y del PR documental contra la línea base, y luego implementación/verificación, sin iniciar dichas mutaciones en este ciclo.