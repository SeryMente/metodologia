# C-MCP-JULES-012 · ACL preflight, negativos de autorización y POST sin replay

**Fecha:** 2026-10-30. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Evento:** C-MCP-JULES-012. Continúa C011; no cambia titularidad, no crea otra fase y no modifica el control padre.

## 1. Head y PR

- KHORA [PR #344](https://github.com/SeryMente/khora/pull/344), rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `0ef171cbff42b77eb89593b70d573026145b28ac`.
- Estado: OPEN / DRAFT / sin merge ni despliegue.
- Base: `fix/custodia-recovery-verified-20261029`, head `e2ec67600885315fd4493911da89af1d4aafc297`, que preserva PR #340 de Custodia como trabajo independiente pendiente.
- Diff relativo a la base: 11 commits ahead, 0 behind, 20 archivos modificados. No hay diff heredado de Custodia dentro de este PR.

## 2. Hardening de autorización

### Preflight antes de consultar el proveedor

`requireSessionAccess` consulta primero las concesiones de ACL del sujeto para la capacidad pedida. Si la consulta ACL falla o no hay grants, deniega antes de llamar `jules_get_session`. Solo después lee la sesión y compara source/branch exactamente contra la lista permitida. Las herramientas list/get/activity/message/approve fallan cerradas.

### Pruebas negativas añadidas

- ACL no disponible: prueba que las siete herramientas reportan `JULES_ACL_UNAVAILABLE` y ninguna llama al proveedor Jules.
- Sin grant `read`: get-session y list-activities se bloquean antes de `jules_get_session`.
- Sin grant `write`: send-message y approve-plan se bloquean antes de cualquier lectura de sesión o escritura.
- Contexto de sesión con source distinto, branch distinto o contexto ausente se deniega.
- Crear sesión hacia una rama distinta del grant se bloquea antes de `sources.get`/`sessions.create`.
- Listing de fuentes cubre la rama default autorizada cuando no viene repetida en `branches[]`; la default no autorizada no se expone.

## 3. Reintentos de POST

Los tests de `jules_client_retry.test.ts` cubren los tres métodos de escritura `createSession`, `sendMessage` y `approvePlan` ante 429; cada uno debe producir una sola petición, sin replay. Se mantienen además casos para fallo de red y 5xx ambiguo en creación. GET 429 conserva retry limitado. Los tests están escritos, no ejecutados por runner.

## 4. Gate T22: plan revisado

La ruta relee la sesión y exige `AWAITING_PLAN_APPROVAL`, pero aún no liga criptográficamente ni mediante una huella persistida la aprobación al contenido/versionado exacto del plan revisado por el operador. El estado por sí solo no prueba que el plan no haya cambiado. T22 permanece PENDIENTE y la herramienta de aprobación no debe declararse aceptada en producción hasta diseñar, implementar y probar la vinculación del plan vigente con el consentimiento explícito. No simular esa garantía.

## 5. CI y validación

Head observado: `0ef171cbff42b77eb89593b70d573026145b28ac`.

- UI Quality `41086322565`: UI Contract y UI E2E terminaron `failure`, ambos `steps: null`.
- CI `41086322753`: `api-tests`, `khora-web-gate` y `calidad` terminaron `failure`, todos `steps: null`.
- CI `41086312312`: intento duplicado, mismos jobs fallidos con `steps: null`.
- Logs de runner no recuperables (`BlobNotFound`); ningún paso de build/typecheck/test llegó a ejecutarse.
- Vercel deploy checks bloqueados por plan de organización/repositorio privado.

Conclusión: CI = BLOQUEADO / PRE-RUN NO EJECUTADO; código y pruebas existen en Git, pero no hay PASS/FAIL de suite para este head. No hacer rerun idéntico: la misma infraestructura ya se ha intentado varias veces sin ejecución.

## 6. Estado global

- Las siete herramientas, scopes, ACL granular, source/branch validation, paginación y política de retry están versionados.
- La migración 033 sigue sin aplicar. El rol de `KHORA_READONLY_DATABASE_URL`, permisos mínimos y read-back no se han comprobado.
- No hay llamada real a Jules, OAuth/aislamiento real, plugin público, ChatGPT Free, E2E, merge, despliegue ni smoke/rollback verificados.
- T01–T32 permanecen PENDIENTE. En particular T22 está abierto por el vínculo entre plan revisado y aprobación.

## 7. Persistencia y control

Este ciclo se incorpora al OCP como v0.1.9, README y plan de aceptación v1.6. La investigación API se actualiza con la limitación de T22 y los nuevos tests.

`CONTROL-RESPONSABILIDAD.json` permanece exactamente en SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`, generación 2 y folio `SES-20261029-6C2F9A17`. No fue modificado. El control padre Metacanon también permanece independiente.

## 8. Cierre

El hardening de ACL y pruebas negativas está versionado, pero la Fase 2 sigue EN CURSO. El sistema aún no está aceptado ni utilizable desde ChatGPT Free. El cierre depende de un runner funcional, T22, ACL productiva autorizada, API/OAuth real, publicación/Free y E2E/release.