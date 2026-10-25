# C-MCP-JULES-004 · diagnóstico canónico y CI sobre head vigente

**Fecha:** 2026-10-25. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261025-84D3B2F1`, generación 1. **Gobierno:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2. **Evidencia:** lecturas del estado real de ramas, PR y workflows de GitHub; no se ejecutó test runner local ni llamada autenticada a Jules.

## Corrección del contrato de errores

El test de aprobación fuera de estado no podía observar `JULES_PLAN_NOT_AWAITING_APPROVAL`: la ruta de Jules devolvía `isError:true` sin `_meta["khora/diagnostic"]`, por lo que la envoltura canónica de Khora lo normalizaba a `MCP_INTERNAL_ERROR`. Se corrigió `khora-web/app/api/mcp/route.ts` para crear errores con `McpDiagnosticError` y pasar por `diagnosticFailure`; se añadieron códigos con mensajes seguros al catálogo común `khora-web/lib/server/mcp-diagnostics.ts` para API key ausente, rechazo de autenticación, rate limit, fallo externo, fuente/sesión inválida, plan no aprobable y sesión no preparada. Los cuerpos arbitrarios de respuesta de Jules no se exponen. La importación y el uso de `McpDiagnosticError` se leyeron de vuelta en el commit `4e5c2990bf40c2ec558850ca561b1d695dc98db1`.

## PR vigente

- El PR original [Khora #337](https://github.com/SeryMente/khora/pull/337) se cerró sin merge: su head SHA no reflejaba el último commit escrito en la rama.
- Se creó una rama nueva `feat/mcp-jules-mvp-20261025-final` exactamente desde el commit `4e5c2990bf40c2ec558850ca561b1d695dc98db1`, y el PR borrador [Khora #338](https://github.com/SeryMente/khora/pull/338). La lectura de vuelta verificó que el head de #338 coincidía con ese SHA.
- El PR de documentación [Metacanon #19](https://github.com/SeryMente/metodologia/pull/19) sigue abierto en borrador; sus workflows de validación fallan y la causa exacta permanece NO VERIFICADA porque no se pudieron recuperar sus logs.

## CI del head vigente de Khora #338

**Resultado observado para SHA `4e5c2990bf40c2ec558850ca561b1d695dc98db1`:**
- `npm ci`: **PASS**.
- `npm run typecheck`: **PASS**.
- `npm run ui-review:check`: **PASS**.
- `npm run ui:contract`: **PASS**.
- `npm run test:unit`: **547 PASS / 1 FAIL**. Los tests nuevos de aprobación de plan y propagación de scopes Jules pasan; queda un fallo preexistente de `methodology_contract_sync.test.ts`.
- `api-tests`: **PASS**.
- `ruff check .`: **FAIL** por I001 en `tests/test_runtime_leiden_contract.py` y `tests/test_graph_cycle_regressions.py`, archivos fuera del diff de Jules.
- `npm run build` y el job de E2E: **FAIL** porque el build/prebuild vuelve a ejecutar la suite unitaria y aborta por el único fallo restante; E2E no consiguió arrancar el servidor de prueba.
- Las previsualizaciones Vercel consultadas devolvieron `build-rate-limit`, un límite de plan del proveedor; no es una conclusión de tests.

## Bloqueos y límites

La prueba `methodology_contract_sync.test.ts` compara el contrato local con un esquema del repositorio privado `SeryMente/metodologia`. La descarga anónima no tiene acceso y el runner no dispone de `GH_TOKEN`; `gh api` termina con el mensaje explícito de configurar dicha variable. No se debilita ni se omite esta comparación canónica, ni se incorpora un secreto al repositorio. Hace falta provisionar una credencial de lectura interrepositorio aprobada en el entorno de CI.

Los dos findings de Ruff están fuera del diff de este PR; no se corrigen como cambios colaterales. Por ello los checks del repositorio no están verdes aunque los tests específicos de scopes, rechazo de aprobación, validación de fuente y la suite de API sí hayan pasado.

## Custodia documental

El primer archivo de esta crónica se creó por error en `main` al omitir el argumento de rama en la llamada de creación. Se está reconciliando su contenido exacto con la rama documental del OCP para que el enlace y la copia de la crónica sean consistentes. No se modificó el HTML normativo único, ni el control del frente padre Metacanon.

## Estado y siguiente paso

El código candidato tiene typecheck y contratos correctos, pero la compilación integral sigue bloqueada por una prueba de sincronización que necesita acceso privado al contrato de Metacanon y por Ruff en archivos ajenos al diff. Mantener Khora #338 y Metacanon #19 en borrador hasta resolver o aceptar explícitamente esos bloqueos. Sigue pendiente una llamada autenticada real a Jules, la secuencia listar → crear con plan aprobado → leer feedback → responder, la conexión real desde ChatGPT, la configuración segura de `JULES_API_KEY` y el despliegue.
