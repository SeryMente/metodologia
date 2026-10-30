# C-MCP-JULES-013 · huella del plan y preflight doble de aprobación

**Fecha:** 2026-10-30. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Evento:** C-MCP-JULES-013. Continúa C012 sin cambiar titularidad ni crear fases nuevas.

## 1. Head vigente

- KHORA [PR #344](https://github.com/SeryMente/khora/pull/344), rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `ad7826a186ff9f74b51874aa4bae04725a2e33c4`.
- Draft abierto, sin merge ni despliegue; apilado sobre Custodia PR #340 y base `fix/custodia-recovery-verified-20261029`.

## 2. Plan fingerprint y comprobación

`jules_list_activities` ahora agrega `plan_sha256` a los eventos `planGenerated`, calculado mediante serialización JSON canónica de las propiedades del plan y SHA-256. `jules_approve_plan` exige `session_id`, `plan_id` y `plan_sha256` que el cliente obtuvo al revisar las actividades.

Antes de ejecutar el POST, el servidor:

1. Comprueba ACL de escritura exacta y estado `AWAITING_PLAN_APPROVAL`.
2. Descarga todas las páginas de actividades con `pageSize=100`, detecta loops o paginación incompleta y obtiene el `Plan` generado más reciente por timestamp.
3. Compara `plan_id` y hash con los argumentos que corresponden al plan revisado.
4. Relee sesión y ACL, vuelve a descargar actividades y vuelve a comparar ID/huella.
5. Solo si ambas lecturas coinciden envía `approvePlan`; la salida devuelve el plan_id/hash y declara expresamente el límite de atomicidad.

## 3. Tests añadidos

- Aprobación permitida cuando ID/hash permanecen estables, incluyendo paginación completa en ambas lecturas previas.
- Bloqueo si el ID cambió después de que el operador vio el plan.
- Bloqueo si el contenido cambia conservando el mismo ID (SHA-256 distinto).
- Bloqueo si el plan cambia entre las dos lecturas inmediatas previas al POST.
- Los tests son sintéticos y están versionados, no ejecutados por runner.

## 4. Límite de la API y estado T22

Las referencias oficiales de Jules describen `Plan.id`, `Plan.steps`, `Plan.createTime`, `PlanApproved.planId` y `sessions.approvePlan`. La operación de aprobación es un POST a `sessions/{session}:approvePlan` con cuerpo vacío; no documenta `plan_id`, ETag ni `If-Match` como precondición. Por ello no es posible eliminar desde KHORA la ventana de carrera que queda entre la segunda lectura y el POST. El doble preflight evita aprobar un plan que ya estaba cambiado cuando se consultó, pero no garantiza atomicidad frente a un cambio concurrente posterior.

**T22: PARCIAL / PENDIENTE.** No marcar PASS ni afirmar consentimiento ligado de forma atómica. Para cerrar T22 se requiere que el proveedor exponga aprobación condicional por `plan_id`/versión o que se mantenga el flujo de aprobación bloqueado/limitado hasta obtener esa garantía.

## 5. CI y estado global

- Head `ad7826a186ff9f74b51874aa4bae04725a2e33c4`.
- UI Quality `41088064191`, CI `41088064148`, CI duplicado `41088053076`: todos los jobs terminaron `failure` con `steps: null`; no se ejecutaron steps de build/test. Logs `BlobNotFound`.
- Los checks de Vercel permanecen bloqueados por el plan para repositorios privados de organización.
- Migración ACL 033 no aplicada; roles/privilegios/read-back no verificados.
- API real, OAuth/aislamiento real, plugin público, ChatGPT Free, E2E, merge, despliegue y smoke/rollback siguen PENDIENTES.
- T01–T32 siguen PENDIENTE; T22 expresamente parcial.

## 6. Control y cierre

El OCP pasa a v0.1.10; README, investigación y aceptación se actualizan a corte actual. El plan de aceptación pasa a v1.7 sin cambiar el modelo de dos fases.

`CONTROL-RESPONSABILIDAD.json` conserva SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`, generación 2 y folio `SES-20261029-6C2F9A17`. No se modificó.