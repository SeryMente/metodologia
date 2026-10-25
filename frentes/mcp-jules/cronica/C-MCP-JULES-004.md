# C-MCP-JULES-004 · diagnóstico canónico y CI sobre head vigente

**Fecha:** 2026-10-25. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261025-84D3B2F1`, generación 1. **Gobierno:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2. **Evidencia:** lecturas del estado real de ramas, PR y workflows de GitHub; no se ejecutó test runner local ni llamada autenticada a Jules.

## Corrección del contrato de errores

El test de aprobación fuera de estado no podía observar `JULES_PLAN_NOT_AWAITING_APPROVAL`: la ruta de Jules devolvía `isError:true` sin `_meta["khora/diagnostic"]`, por lo que la envoltura canónica de Khora lo normalizaba a `MCP_INTERNAL_ERROR`. Se corrigió `khora-web/app/api/mcp/route.ts` para crear errores con `McpDiagnosticError` y pasar por `diagnosticFailure`; se añadieron códigos con mensajes seguros al catálogo común `khora-web/lib/server/mcp-diagnostics.ts` para API key ausente, rechazo de autenticación, rate limit, fallo externo, fuente/sesión inválida, plan no aprobable y sesión no preparada. Los cuerpos arbitrarios de respuesta de Jules no se exponen. Lectura de vuelta de la importación de `McpDiagnosticError` confirmada en el commit `4e5c2990bf40c2ec558850ca561b1d695dc98db1`.

## PR vigente

- El PR original [Khora #337](https://github.com/SeryMente/khora/pull/337) se cerró sin merge: su head SHA no reflejaba el último commit escrito en la rama.
- Se creó una rama nueva `feat/mcp-jules-mvp-20261025-final` exactamente desde el commit `4e5c2990bf40c2ec558850ca561b1d695dc98db1`, y un PR borrador [Khora #338](https://github.com/SeryMente/khora/pull/338). La última lectura verificó que el head de #338 coincidía con ese SHA.
- PR de documentación [Metacanon #19](https://github.com/SeryMente/metodologia/pull/19) sigue abierto en borrador.

## CI del head vigente

Al abrir PR #338, los tres grupos `khora-ok / gate`, `CI` y `UI Quality` iniciaron ejecuciones nuevas. En la última lectura seguían en cola/en ejecución, por lo que el resultado de typecheck, build, contrato de las herramientas y tests no tiene aún un veredicto final para el SHA exacto del candidato vigente. No declarar tests aprobados a partir de la ejecución anterior.

Fallos preexistentes/de entorno observados en la ejecución previa:
- La prueba `methodology_contract_sync.test.ts` consulta un esquema privado de `SeryMente/metodologia`; el runner no tiene `GH_TOKEN` configurado y `gh api` falla por esa falta de credencial. No se modifica la prueba para omitir la comparación ni se incrusta un secreto.
- `ruff check .` falla en archivos del kernel fuera del diff de Jules (`tests/test_runtime_leiden_contract.py` y `kernel/tests/test_graph_cycle_regressions.py`). No se modifican como cambios colaterales.
- Las previsualizaciones Vercel devuelven `build-rate-limit`, un límite de plan del proveedor, no un resultado de test.

## Estado y siguiente paso

El arreglo de diagnóstico está presente en el head vigente y CI se ha reabierto sobre ese SHA. Esperar su conclusión final y separar los tests relevantes del bloqueo por credencial interrepositorio y Ruff. Mantener PR #338 en borrador hasta tener un reporte de aceptación verificable. Siguen pendientes la API key real, la secuencia autenticada de Jules y la conexión real desde ChatGPT.
