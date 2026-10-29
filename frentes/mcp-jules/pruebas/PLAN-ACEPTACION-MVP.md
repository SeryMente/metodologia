# Plan de aceptación · MVP MCP Jules v1.0

**Versión:** 1.0  
**Fase:** criterios de aceptación para las fases posteriores de implementación, validación integrada y release.  
**Plan rector:** [PLAN-INTEGRAL-MCP-JULES-v1.0.md](../PLAN-INTEGRAL-MCP-JULES-v1.0.md).  
**Estado de pruebas al corte:** PENDIENTE de ejecutar/actualizar contra los heads vigentes. La existencia de un test, PR o salida histórica no equivale a PASS actual.

La primera fase de planeación está completa. Este documento no describe funciones implementadas: fija resultados que deberán demostrarse con evidencia real.

## Matriz de aceptación

| ID | Prueba | Condición de aceptación | Fase | Estado |
|---|---|---|---|---|
| T01 | Contratos MCP | Las siete herramientas aparecen con schema JSON válido, descripciones, scopes y argumentos dentro de límites. | 2 | PENDIENTE |
| T02 | No regresión | Suites completas, typecheck, contratos y API tests existentes pasan en el head propuesto. | 2 | PENDIENTE |
| T03 | Scopes | Sin `jules:read`/`jules:write`, las herramientas correspondientes no llaman al cliente Jules. | 2 | PENDIENTE |
| T04 | Ciclo normativo | Cada herramienta sustantiva respeta el contrato real de token/turno normativo y su liberación. | 2 | PENDIENTE |
| T05 | IDs de recurso | Fuente/sesión inválida, URL arbitraria, path traversal, `?`, `#` y separadores prohibidos se rechazan antes de la API. | 2 | PENDIENTE |
| T06 | Payload de creación | El servidor envía `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`; el test verifica el payload porque ambos campos son input-only. | 2 | PENDIENTE |
| T07 | Aprobación por estado | `jules_approve_plan` rechaza todo estado distinto de `AWAITING_PLAN_APPROVAL`. | 2 | PENDIENTE |
| T08 | Feedback en la misma sesión | La respuesta se envía al mismo ID y las actividades posteriores se consultan para verificar respuesta. | 3 | PENDIENTE |
| T09 | Paginación | Sources, sessions y activities respetan `pageSize` 1–100, siguen `nextPageToken` y distinguen página vacía/final/error. | 2 | PENDIENTE |
| T10 | Escritura ambigua | POST de crear, enviar y aprobar no se reintentan automáticamente ante timeout/5xx; primero se reconcilia estado. | 2 | PENDIENTE |
| T11 | Errores | Clave ausente, 401/403, 429, 5xx, timeout, JSON inválido y estado incompatible producen diagnóstico seguro. | 2 | PENDIENTE |
| T12 | Secretos | Clave no aparece en resultado MCP, excepciones, logs, snapshots, prompts o Git. | 2 | PENDIENTE |
| T13 | Prompt injection | Mensajes/artefactos maliciosos de Jules no cambian scopes, fuente/branch, permisos ni autorización. | 2 | PENDIENTE |
| T14 | API real | `JULES_API_KEY` se acepta en una llamada autorizada, sin registrar su valor. | 3 | PENDIENTE |
| T15 | Cliente ChatGPT | La app se conecta y expone las siete herramientas desde el cliente/espacio real previsto. | 3 | PENDIENTE |
| T16 | E2E bidireccional | Fuente → sesión con plan requerido → revisión humana → aprobación → avance → feedback → respuesta misma sesión → cierre/outputs. | 3 | PENDIENTE |
| T17 | Persistencia/reinstanciación | IDs, fuente/branch, estado, cursor y evidencia se guardan y la siguiente sesión retoma sin inventar contexto. | 3 | PENDIENTE |
| T18 | Release | PR revisado; CI verde o excepción explícita aceptada; autorización de merge/despliegue; smoke test posterior. | 4 | PENDIENTE |
| T19 | Fuente/branch server-side | Servidor consulta Source antes de crear y confirma que `startingBranch` existe; fallo/branch inexistente bloquea `sessions.create`. | 2 | PENDIENTE |
| T20 | Auto PR controlado | Create usa `AUTO_CREATE_PR`; PR se verifica por URL/estado real; no ocurre auto-merge/deploy. | 2–3 | PENDIENTE |
| T21 | Retry diferenciado | GET permite reintentos acotados/backoff; POST no usa un retry común para resultados ambiguos. | 2 | PENDIENTE |
| T22 | Plan vigente | Si cambia plan/actividad tras revisión, se bloquea la aprobación y se solicita consentimiento sobre el plan actual. | 2–3 | PENDIENTE |
| T23 | Elegibilidad de escritura | Plan/espacio real tiene soporte MCP personalizado de escritura; si no, gate FAIL/BLOCKED, no lectura-only disfrazada de aceptación. | 3 | PENDIENTE |
| T24 | Uso conversacional normal | App puede usarse en chat normal y volver a mencionarse cuando otro mensaje requiere acción; Agent/Deep Research quedan fuera del camino de escritura. | 3 | PENDIENTE |
| T25 | Negativos de fuente | Fuente desconectada, respuesta Source malformada, error upstream y rama inexistente nunca alcanzan `sessions.create`. | 2 | PENDIENTE |

## Secuencia de aceptación integrada

1. Refrescar el head real del PR y verificar que suite de código y herramientas coincide con este contrato.
2. Configurar credencial en entorno autorizado; no leer ni copiar su valor.
3. Ejecutar tests unitarios de payload de creación, scopes, paginación, branch/source y reintentos.
4. Desde un entorno aprobado, listar fuentes y escoger fuente/branch de prueba real y no destructiva.
5. Crear sesión; verificar payload enviado y estado/plan devuelto. No exigir que la respuesta repita `requirePlanApproval` o `automationMode`, pues ambos son input-only.
6. Mostrar el plan al operador y esperar confirmación explícita sobre el plan actual.
7. Reconsultar estado/actividad y aprobar solo si aún espera aprobación y el plan no cambió; después reconsultar.
8. Esperar solicitud de feedback o generar una prueba controlada; responder mediante `jules_send_message` en la misma sesión y volver a leer activities.
9. Verificar outputs/PR reales; revisar diff y pruebas sin equiparar creación de PR con merge/aceptación.
10. Registrar datos no sensibles y outputs reales con lectura de vuelta del OCP.
11. Conectar el cliente ChatGPT real y probar el circuito desde un chat normal con escritura habilitada.
12. Revisar gates de release, autorización y rollback antes de integración y despliegue.

## Criterios globales de PASS

- **CÓDIGO:** existe en el head de rama identificado.
- **TESTS:** PASS solo si se ejecutaron en ese head y se conserva output/estado real.
- **CI:** se lee de GitHub; resultado histórico no prueba el head actual.
- **API KEY VALIDADA:** una llamada real fue aceptada; el valor jamás se expone.
- **CHATGPT CONECTADO:** el cliente real descubrió tools y realizó llamada autorizada.
- **E2E:** el circuito bidireccional completo se comprobó en una sesión real.
- **MVP UTILIZABLE:** todos los gates requeridos pasan; no hay excepción silenciosa.
- **BLOQUEADO:** la capacidad necesaria no está disponible en el plan/espacio o falta credencial/permisión; conservar como bloqueado, no como aprobado.

Los estados no se heredan de anteriores ramas, PRs ni crónicas. `AUTO_CREATE_PR` no autoriza merge y la aprobación de un plan no autoriza operaciones de producción no incluidas en él.