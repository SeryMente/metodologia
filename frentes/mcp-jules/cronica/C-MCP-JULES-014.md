# C-MCP-JULES-014 · sujeto JWT exacto, fixture de aprobación y redacción de rutas

**Fecha:** 2026-10-30. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Evento:** C-MCP-JULES-014. Continúa C013 dentro de la Fase 2 única; no modifica titularidad ni crea fases nuevas.

## 1. Reconciliación de heads

- PR [KHORA #344](https://github.com/SeryMente/khora/pull/344), rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `33aabd5fa5a6b3a34cbf45e9dda1228aee1644f6`.
- Head canónico previo en C013: `ad7826a186ff9f74b51874aa4bae04725a2e33c4`.
- Comparación GitHub: 3 commits adicionales, 0 detrás, 5 archivos modificados.
- Base de #344: `fix/custodia-recovery-verified-20261029`, head `e2ec67600885315fd4493911da89af1d4aafc297`; no se rebasea sobre `main` ni se fusiona Custodia antes de su propio cierre.
- PR #344 sigue OPEN/DRAFT, `mergeable=true`, sin merge ni despliegue.

## 2. Identidad de ACL

El actor de ACL proviene del contexto autenticado de KHORA: `payload.sub` para OAuth/JWT y `manualToken.usuario` para token manual. No existe un campo de argumento que permita al cliente elegir el sujeto. El fixture ahora registra el sujeto recibido por la capa ACL; una prueba confirma que tanto el listado de fuentes como la creación de sesión consultan el sujeto `fixture-actor` derivado del JWT sintético. Esta prueba cubre el cableado de identidad de la ruta, no la ejecución de la consulta en la base productiva.

## 3. Contrato de aprobación y llamadas del fixture

C013 dejó el preflight doble de plan. Esta revisión ajustó el input común del test MCP para que `jules_approve_plan` lleve el `plan_id` y el `plan_sha256` correctos del plan sintético. La huella comprobada es `7a898feea085c3699a9c15295c5c53d361f6f10bd2847d2bb54f12b863969346`, calculada sobre el objeto de plan del fixture con propiedades ordenadas y JSON compacto. El conteo de llamadas del test integral pasó de 27 a 30: se cuentan dos lecturas de sesión y dos lecturas de actividades para la aprobación protegida, además del POST final. Los asserts de invocaciones inválidas permanecen en cero cuando se valida input antes de llegar a los servicios.

El proveedor sigue sin ofrecer precondición atómica por `plan_id`/ETag/If-Match; T22 permanece PARCIAL/PENDIENTE como ya documentó C013. No se transforma el doble preflight en garantía de atomicidad.

## 4. Redacción de observabilidad

El sanitizador previo reemplazaba solo el primer segmento bajo `sources/`, lo que podía exponer owner/repository en telemetría. El cliente ahora exporta `sanitizeJulesRouteForLog(url)`, que oculta el recurso fuente completo `sources/**` como `/sources/:id`, el ID de sesión como `/sessions/:id`, conserva el sufijo `/activities` y devuelve `unknown` para URLs inválidas. Se añadieron aserciones de source privado, sesión y URL inválida. La ruta saneada se utiliza antes de emitir eventos HTTP del cliente Jules.

## 5. CI y validación

Para el head `33aabd5fa5a6b3a34cbf45e9dda1228aee1644f6`:

- UI Quality `41089805486`: UI Contract y UI E2E terminaron `failure`, ambos con `steps: null`.
- CI `41089805260`: `khora-web-gate`, `calidad` y `api-tests` terminaron `failure`, todos con `steps: null`.
- CI `41089793085`: ejecución adicional; los tres jobs terminaron `failure`, todos con `steps: null`.
- Los checks Vercel continúan fallando por la restricción de plan de la organización para previews de repositorios privados.

No hay logs de runner recuperables ni salida de typecheck/test. No se hizo otro rerun idéntico: las ejecuciones anteriores ya evidencian un bloqueo pre-run repetido. Estado: CI **BLOQUEADO / NO EJECUTADO**, no PASS ni FAIL de código.

## 6. Estado de aceptación

- Código de siete herramientas, scopes, ACL granular, validación source/branch y no-retry de POST: versionado.
- Pruebas de ACL caída, ausencia de grants, contexto inválido, sujeto autenticado, digest de plan y redacción de rutas: versionadas, no ejecutadas.
- Migración `033_jules_source_acl.sql`: versionada, no aplicada; rol DB read-only real y privilegios/read-back pendientes.
- T22: PARCIAL/PENDIENTE por la ausencia de aprobación condicional atómica del proveedor.
- API Jules real, OAuth/ACL productiva, plugin público, ChatGPT Free, E2E, merge, despliegue y smoke/rollback: pendientes.
- T01–T32 permanecen PENDIENTE.

## 7. Persistencia y control

El OCP se actualiza a v0.1.11 y el plan de aceptación a v1.8. README y PR descriptions reflejan el nuevo head. El `CONTROL-RESPONSABILIDAD.json` conserva SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`, generación 2 y folio `SES-20261029-6C2F9A17`; no se modifica. El control del frente padre Metacanon sigue independiente.

## 8. Cierre

El candidato tiene tres commits posteriores a C013 que cierran huecos de test/privacidad detectados en revisión estática. Sigue en Fase 2 EN CURSO, en draft, sin CI ejecutado ni gates externos acreditados; no es un sistema aceptado ni utilizable desde ChatGPT Free.