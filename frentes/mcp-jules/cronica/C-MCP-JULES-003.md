# C-MCP-JULES-003 · corrección causal y segunda ejecución de CI

**Fecha:** 2026-10-25. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261025-84D3B2F1`, generación 1. **Gobierno:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.

## Evidencia causal

En la primera ejecución de GitHub Actions para Khora PR #337, `npm run typecheck` falló con TypeScript TS6188/TS1109/TS1127 en `tests/unit/helpers/mcp-route-fixture.ts:58`. El fixture de prueba contenía escapes duplicados antes de las barras del regex para nombres de fuente Jules.

Se corrigió el regex en un commit dedicado:
- **Commit:** `c49e89f4a059248e54e8789004a04fd4c0627fa4`.
- **Archivo:** `khora-web/tests/unit/helpers/mcp-route-fixture.ts`.
- **Lectura de vuelta:** se confirmó el regex literal con un solo escape `\/` antes de cada barra.
- No se afirma que el typecheck global haya concluido aún en el segundo run.

La primera ejecución de UI E2E falló porque el `webServer` no pudo arrancar; el log confirma que el build/typecheck del mismo candidato abortó con esos errores TS. No se interpreta como una regresión UI independiente.

## Segunda ejecución observada

Para el nuevo head `c49e89f4a059248e54e8789004a04fd4c0627fa4`:
- `khora-ok / gate`: en ejecución; `npm run build` en progreso en la última lectura.
- `CI`: en ejecución; `khora-web-gate` estaba en `npm ci` y `api-tests` en `pytest api/tests/`.
- `UI Quality`: en ejecución; `UI Contract` ejecutando `npm run ui:contract`; `UI E2E` aún en instalación.
- El job `calidad` sigue reportando fallo de `ruff check .` en `tests/test_runtime_leiden_contract.py` y `kernel/tests/test_graph_cycle_regressions.py`. Esos archivos no forman parte del diff MCP Jules de este frente y no se modifican como cambio colateral.

La siguiente lectura de CI debe confirmar si pasan typecheck, contrato MCP de 24 herramientas, suites unitarias y build. Hasta que esas ejecuciones terminen con conclusión final, **tests aprobados = NO VERIFICADO**.

## Resultado y siguiente paso

La causa TS identificada fue corregida. No se ha probado una llamada real a Jules, no se ha configurado una clave real y no se ha conectado ChatGPT. Mantener PR #337 en borrador, leer el siguiente resultado de GitHub Actions, corregir fallos propios demostrados y conservar los fallos ajenos al diff documentados sin alterar módulos no relacionados.
