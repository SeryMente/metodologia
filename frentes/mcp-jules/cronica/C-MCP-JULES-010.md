# C-MCP-JULES-010 · implementación candidata de Fase 2, ACL por recurso y CI sin ejecución

**Fecha:** 2026-10-30. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Evento:** C-MCP-JULES-010. **Gobierno:** se conserva la referencia vigente DUG Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9, consultada en C009. Esta crónica no modifica el control de responsabilidad ni el control del frente padre.

## 1. Resultado del ciclo

La Fase 2 deja de ser únicamente diseño y pasa a tener un candidato de implementación versionado, abierto como borrador en Khora PR #344. El sistema todavía NO está aceptado ni utilizable desde ChatGPT Free. El proyecto conserva exactamente dos fases: Fase 1 completa; Fase 2 en curso.

- PR vigente: [SeryMente/khora #344](https://github.com/SeryMente/khora/pull/344).
- Rama: `feat/mcp-jules-f2-20261029-6c2f9a17`.
- Head observado: `c4ca7615a481de1cd2b447f31bd9a7fb569cf9b5`.
- Base del PR: `fix/custodia-recovery-verified-20261029`, head `e2ec67600885315fd4493911da89af1d4aafc297`.
- PR base de Custodia: #340; sigue en borrador. No se rebasó ni fusionó a main.
- PR #338 permanece como candidato histórico obsoleto, sin merge.

## 2. Cambios versionados en KHORA

### Herramientas y permisos

Se portaron las siete herramientas Jules al único endpoint MCP de KHORA `/api/mcp`: listar fuentes, listar sesiones, consultar sesión, listar actividades, crear sesión, enviar mensaje y aprobar plan. Se registraron `jules:read` y `jules:write` en metadatos OAuth, allowlists, tokens manuales y UI, sin agregarlos a los scopes predeterminados. El gate normativo existente continúa siendo obligatorio.

### ACL fail-closed

Se incorporó `khora-web/lib/server/jules-access.ts` y la migración `khora-web/db/migrations/033_jules_source_acl.sql`. La tabla `khora_private.jules_source_acl` define permisos independientes de lectura/escritura por coincidencia exacta `subject + source + branch`, con registro de concesión y revocación. Las listas de fuentes, ramas y sesiones se filtran server-side; consulta de sesión y actividades exigen grant exacto; creación, mensaje y aprobación exigen write grant exacto. La creación consulta `sources.get` y comprueba que la rama exista antes de `sessions.create`. Fallo de ACL, contexto inválido o ausencia de grant deniegan.

La migración solo está versionada. NO se aplicó a ninguna base. No se inventó el rol de `KHORA_READONLY_DATABASE_URL` ni se concedieron permisos. Antes de una operación autorizada, el administrador de datos debe identificar el rol real y limitarlo a `USAGE` en `khora_private` y `SELECT` en `khora_private.jules_source_acl`; después deberá leer de vuelta permisos y datos de prueba sin exponer secretos.

### Reintentos y diagnóstico

El adaptador Jules conserva paginación oficial `pageSize`/`pageToken`, retira el cursor heredado `createTime` no documentado y añade `sources.get`. Los reintentos automáticos quedan limitados a GET/HEAD. Los POST de creación, mensaje y aprobación no se repiten cuando el transporte o un 5xx dejan el resultado ambiguo; el diagnóstico `JULES_WRITE_RESULT_AMBIGUOUS` exige reconciliar estado/actividad antes de cualquier nueva escritura. Los errores públicos usan códigos saneados.

### Tests y documentación

Se extendieron los fixtures y pruebas de contrato MCP para scopes, ACL, filtrado de fuentes/sesiones, branch preflight y payload `requirePlanApproval=true` / `AUTO_CREATE_PR`. Se añadió `khora-web/tests/unit/jules_client_retry.test.ts` con tres pruebas sintéticas para retry GET 429, POST con fallo de red y POST 5xx sin replay. Se actualizaron `khora-web/docs/normative-check.md` y `khora-web/docs/JULES-ACCESS-CONTROL.md`.

Estos tests están escritos y versionados, pero no existe salida de ejecución válida para el head. No deben contabilizarse como PASS.

## 3. Integración y seguridad

El PR #344 se creó en borrador y apilado sobre la rama actualizada de Custodia para aislar deltas y evitar que una integración prematura de Jules arrastre o modifique la base de Custodia. La rama se dejó sin merge y no se desplegó.

No se crearon herramientas administrativas para alterar ACL, grants globales, wildcard de fuentes/ramas, worker persistente, aprobación automática, auto-merge ni auto-deploy. La clave de proveedor no se consultó ni se utilizó en este ciclo. No se incluyó ningún secreto en Git.

## 4. Validación observada

GitHub Actions registró CI y UI Quality para el head `c4ca7615a481de1cd2b447f31bd9a7fb569cf9b5`. Los jobs `calidad`, `api-tests`, `khora-web-gate`, `UI Contract` y `UI E2E` finalizaron como `failure` con `steps: null`. Se solicitó un rerun de jobs fallidos; el segundo intento volvió a finalizar sin steps (`steps: null`). Los logs de jobs devolvieron `BlobNotFound`. La evidencia disponible indica que los runners no iniciaron los pasos de trabajo; no es posible concluir que el código compile o falle.

Los checks Vercel asociados fallan por la limitación del plan de la organización para desplegar desde repositorios privados. Este fallo de deploy preview no es una prueba de compilación de la rama.

**Estado técnico:** CI = BLOQUEADO / NO EJECUTADO; tests = PENDIENTE; Vercel preview = BLOQUEADO por plan. No se etiqueta el código como PASS ni FAIL de suite.

## 5. Gates que permanecen pendientes

- Ejecución de typecheck, UI contract, UI review, suite unitaria y API tests en un runner funcional sobre el head actual; atender errores reales si aparecen.
- Revisión estática/integral del diff, incluyendo compatibilidad de las 24 herramientas, OAuth/manual tokens, rutas y fixtures.
- Aplicar migración ACL solo tras preflight y autorización de entorno; verificar el rol DB real y el read-back mínimo de privilegios.
- Concesiones exactas administradas por el propietario para sujeto/source/branch autorizados.
- Llamada real no destructiva a Jules y validación de la credencial en entorno permitido.
- OAuth real y aislamiento por sujeto; prueba de no exposición de fuentes/ramas/sesiones ajenas.
- Publicación, escaneo y aprobación del plugin MCP público.
- Instalación y escritura real desde una cuenta personal ChatGPT Free en chat normal.
- Ciclo E2E bidireccional desde ChatGPT Free, aprobación humana del plan, feedback en misma sesión y PR/output inspeccionables.
- Merge, release, despliegue, smoke y rollback únicamente después de pasar los gates y las autorizaciones aplicables.

El plan T01–T32 v1.4 conserva todos los criterios en PENDIENTE; la presencia de tests en Git no reemplaza la evidencia de ejecución.

## 6. Cierre del ciclo

**Resultado:** candidato de implementación Fase 2 creado y versionado; no aceptado, no desplegado, no fusionado y no utilizable todavía desde ChatGPT Free. La Fase 2 permanece EN CURSO. C009 mantiene la especificación rectora de exactamente dos fases; esta crónica registra el estado de implementación sin crear fases adicionales.

El `CONTROL-RESPONSABILIDAD.json` conserva su SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`, generación 2 y titularidad vigente. No se modificó el control del frente Metacanon.

## 7. Referencias

- [PR #344 — Jules tools with source/branch ACL](https://github.com/SeryMente/khora/pull/344).
- [PR #340 — Custodia base](https://github.com/SeryMente/khora/pull/340).
- [PR #338 — candidato histórico](https://github.com/SeryMente/khora/pull/338).
- [Plan integral v1.0](../PLAN-INTEGRAL-MCP-JULES-v1.0.md).
- [Plan de aceptación v1.4](../pruebas/PLAN-ACEPTACION-MVP.md).
- [Objeto canónico v0.1.7](../OBJETO-CANONICO.md).