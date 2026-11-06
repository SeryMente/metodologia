<!-- LIST_VERSION=0.1; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · Frente MCP Jules

> **ESTADO: PROVISIONAL · AUXILIAR DEL ÚNICO OCP MCP-JULES.** No crea un OCP, control, titularidad ni servidor adicional. El estado vivo permanece en OBJETO-CANONICO.md y el único control de responsabilidad permanece sin cambios en CONTROL-RESPONSABILIDAD.json. Se materializa en la rama documental de PR #19 para corregir el desfase de tareas respecto del código ya integrado en Khora main.

- **Frente:** MCP Jules.
- **Repositorio documental:** SeryMente/metodologia.
- **Rama:** feat/metacanon-mcp-jules-20261025-c32f81 (PR #19, abierta; documentación aún no integrada en main).
- **OCP:** OBJETO-CANONICO.md, revisión de partida v0.1.12.
- **Control:** generación 3, propietario existente; no modificado por esta lista.
- **Versión de la lista:** 0.1 provisional.
- **Fecha de actualización:** 2026-11-06.
- **Gobierno leído:** Samantha v377 · NX-377m; Metacanon 1.28; GOW 2.17; DUG blob 54064c8fe00f872023a455f06596061ed69062ae. §ARR consultado, cascada manual y CNP P001/P004/P005/P038/P043 considerados.
- **Alcance de autorización:** autorización puntual del operador recibida en esta conversación para revisar y modificar tareas/plan/aceptación provisional de MCP-Jules para alinearlos con MCP-OCP. No transfiere titularidad ni autoriza modificar el control, código Khora, credenciales, Production, PR fusionadas ni despliegue.

## Decisión operativa vigente

MCP-Jules no construye ni opera el servidor local de Metodología. Su responsabilidad es proporcionar el flujo seguro de desarrollo asíncrono con Jules a través del servidor MCP existente de Khora y su cliente puente local RDC/stdio.

- Las siete herramientas Jules están integradas en el servidor Khora /api/mcp mediante PR #345 (merge commit 953e69484eabb4e8dc8221d1d8fc188373531bfa).
- El puente local RDC/stdio OAuth 2.1 + PKCE está integrado mediante PR #347 (merge commit 4530e03a33c5e1743ab9646eb6c862b3c458c605).
- Esos merges acreditan que el código llegó a Khora main, no que el consentimiento OAuth actual, la autenticación real, tools/list, lectura de recursos o E2E estén verificados en el dispositivo activo.
- ChatGPT Free se opera por el cliente local controlado mediante RDC. No depende de un plugin MCP público ni de conexión nativa de escritura a un servidor MCP privado desde ChatGPT Free.
- No se crea otro servidor Jules ni un segundo endpoint. El bridge local es un cliente stdio; su upstream es Khora Production /api/mcp.
- El propietario confirma consentimiento OAuth en el navegador de Khora. No se solicita copiar/pegar Bearers, extraer cookies, leer secretos ni manipular manualmente credenciales. JULES_API_KEY permanece exclusivamente en Khora Production.
- El refresh token se cifra con DPAPI CurrentUser; access token solo en memoria. Callback DCR permitido exclusivamente en 127.0.0.1.
- El primer smoke autenticado es estrictamente de solo lectura. No crea sesiones ni inicia escrituras.
- MCP-OCP construye su servidor local independiente en SeryMente/metodologia. No se incorpora a Khora ni se duplica aquí.

## Orden de ejecución

| Orden | ID | Prioridad | Tarea | Estado | Condición de salida |
|---:|---|---|---|---|---|
| 1 | MCP-JULES-01 | P0 | Reconciliar arquitectura, estado real y frontera MCP-OCP/Khora/Jules | EN CURSO | Plan, OCP, aceptación y lista coinciden; se distinguen dos productos/clients locales y un único MCP Khora. |
| 2 | MCP-JULES-02 | P0 | Preparar bridge en dispositivo RDC activo | PENDIENTE | Ruta del clon, Node, dependencias, scripts y perfil DPAPI verificados sin iniciar OAuth ni revelar secretos. |
| 3 | MCP-JULES-03 | P0 | Consentimiento OAuth explícito y autenticación real | BLOQUEADO_HASTA_CONSENTIMIENTO_OPERADOR | Propietario concede scopes; OAuth/PKCE finaliza; tokens quedan protegidos; no se registran valores. |
| 4 | MCP-JULES-04 | P0 | Smoke autenticado de solo lectura | BLOQUEADO_HASTA_03 | tools/list expone exactamente las siete herramientas; listar fuentes/sesiones/actividades reales con paginación. No crea sesiones. |
| 5 | MCP-JULES-05 | P0 | Verificar aislamiento, scopes y límites reales | PENDIENTE | Lecturas permitidas y negativas fail-closed; owner/source/branch/capability y separación jules:read/write verificadas. |
| 6 | MCP-JULES-06 | P0 | Ejecutar ciclo E2E en sandbox OCP | BLOQUEADO_HASTA_04_Y_CONFIRMACION_PLAN | Sesión de sandbox; plan revisado y confirmado; aprobación explícita; feedback; PR verificable y tests. |
| 7 | MCP-JULES-07 | P1 | Validar reanudación, ambigüedad y límites T22 | PENDIENTE | Sin reintentos ciegos; reconciliación de POST; plan digest/doble preflight y carrera residual documentada. |
| 8 | MCP-JULES-08 | P1 | Verificar coexistencia con MCP-OCP local | BLOQUEADO_DEPENDENCIA_MCP_OCP_04_06 | Ambos clientes locales coexisten por RDC sin mezclar endpoints, credenciales, ACL ni controles. |
| 9 | MCP-JULES-09 | P1 | Actualizar release/operación/rollback y aceptación | PENDIENTE | Código y pruebas del head actual, bridge local, OAuth real, lectura y E2E acreditados por evidencia. |
| 10 | MCP-JULES-10 | P1 | Reconciliar documentación y promover PR #19 | PENDIENTE | OCP/plan/aceptación/lista consistentes y leídos de vuelta; revisión de PR y autorización de integración separadas. |

## Fichas de tareas

### MCP-JULES-01 — Reconciliación de arquitectura y estado real
**Prioridad:** P0 · **Estado:** EN CURSO.

Actualizar la planeación histórica de plugin público y MCP nativo privado para que la ruta vigente sea ChatGPT Free mediante RDC + cliente MCP local stdio + Khora OAuth 2.1/PKCE. Preservar la regla de exactamente dos fases de proyecto; las etapas son solo grupos operativos de Fase 2.

**Evidencia de código integrado:** PR #345 / merge 953e69484eabb4e8dc8221d1d8fc188373531bfa (siete herramientas y ACL resource-scoped); PR #347 / merge 4530e03a33c5e1743ab9646eb6c862b3c458c605 (bridge local OAuth/PKCE). PR #344 y #338 son antecedentes supersedidos. PR #340 pertenece a Custodia y no se altera.

**Cierre:** OCP, plan integral, matriz T01–T32 y esta lista no dicen que #345/#347 siguen abiertas ni requieren publicar un plugin.

### MCP-JULES-02 — Preparación local del bridge
**Prioridad:** P0 · **Estado:** PENDIENTE.

En el dispositivo RDC activo, localizar el clon Khora autorizado; verificar Node, paquete MCP SDK, archivos bridge.mjs/credential.ps1/jules.ps1 y sus dependencias. Revisar scripts y rutas antes de ejecutarlos. No iniciar OAuth, leer DPAPI en claro, revelar tokens, abrir puertos adicionales ni iniciar sesión Jules en este paso.

### MCP-JULES-03 — Consentimiento OAuth real
**Prioridad:** P0 · **Estado:** BLOQUEADO_HASTA_CONSENTIMIENTO_OPERADOR.

Ejecutar el bridge Start solo cuando el operador indique que está listo para completar el consentimiento que abrirá Khora. El operador aprueba scopes jules:read y jules:write en navegador. No se simula consentimiento. Verificar únicamente los códigos de estado; nunca imprimir refresh/access tokens ni copiar secretos.

### MCP-JULES-04 — Smoke de solo lectura
**Prioridad:** P0 · **Estado:** BLOQUEADO_HASTA_03.

Confirmar OAuth activo, herramientas completas y ejecutar únicamente jules_list_sources, jules_list_sessions, jules_get_session y jules_list_activities contra recursos que devuelva la API. Seguir paginación. No usar jules_create_session, jules_send_message ni jules_approve_plan en este smoke.

### MCP-JULES-05 — Seguridad y scopes
**Prioridad:** P0 · **Estado:** PENDIENTE.

Revalidar el head actual con tests recientes. Owner resuelto por MCP_ALLOWED_EMAIL; terceros por ACL exacta subject+source+branch+capability fail-closed. jules:read separado de jules:write; fuente/branch validada server-side; claves no aparecen en logs, errores o Git. La API Jules no ofrece aprobación condicional atómica por plan digest: doble preflight reduce pero no elimina la carrera T22.

### MCP-JULES-06 — Ciclo de desarrollo sandbox
**Prioridad:** P0 · **Estado:** BLOQUEADO_HASTA_04_Y_CONFIRMACION_PLAN.

Solo después del smoke y de que el operador ordene usar Jules, preparar una sesión contra sandbox no protegido de SeryMente/metodologia para construir MCP-OCP. Prompt con objetivo, base, alcance, exclusiones, criterios de aceptación y pruebas. Jules debe crear plan con requirePlanApproval=true. Presentar el plan al operador y esperar confirmación activa del plan específico. No aprobar por silencio, por el mandato de crear la sesión ni por una aprobación anterior. Después seguir actividades, contestar feedback en la misma sesión y revisar la PR, sin merge automático.

### MCP-JULES-07 — Reanudación, retries y T22
**Prioridad:** P1 · **Estado:** PENDIENTE.

Ante POST ambiguo, consultar sesión/activities antes de repetir. Sin clave de idempotencia documentada, no reintentar create/send/approve automáticamente. Registrar el límite de race de aprobación: el API no recibe plan_id/hash de forma condicional atómica; doble preflight no es garantía transaccional.

### MCP-JULES-08 — Coexistencia OCP/Jules
**Prioridad:** P1 · **Estado:** BLOQUEADO_DEPENDENCIA_MCP_OCP_04_06.

El producto MCP-OCP es un proceso local distinto y pertenece a SeryMente/metodologia. El bridge de Jules es cliente local hacia Khora. Verificar que ambos procesos stdio se pueden gestionar/usar mediante RDC, que no abren listeners innecesarios y que no comparten secretos, ACL ni estado. No mover código del servidor Khora al repositorio de Metodología ni el servidor MCP-OCP al repositorio Khora.

### MCP-JULES-09 — Aceptación operativa
**Prioridad:** P1 · **Estado:** PENDIENTE.

PASS requiere tests actuales, OAuth real, tools/list, lectura de fuente Jules, una escritura no destructiva en sandbox con plan confirmado, feedback misma sesión, PR/artefactos inspeccionados y rollback/reanudación documentados. No se acredita por pruebas históricas PC-14, una PR fusionada o build local anterior.

### MCP-JULES-10 — Documentación y promoción
**Prioridad:** P1 · **Estado:** PENDIENTE.

Actualizar OCP, plan integral, plan de aceptación y README dentro de la rama PR #19. Releer cada artefacto y registrar commit/blob. La integración de PR #19 a Metodología main requiere revisión y autorización de merge; la autorización puntual de modificar tareas no equivale a autorización de merge. No tocar CONTROL-RESPONSABILIDAD.json.

## Estados y prohibiciones

- `PENDIENTE`: sin evidencia suficiente de ejecución.
- `BLOQUEADO_HASTA_...`: requiere un gate específico.
- `EN CURSO`: trabajo documental actual.
- `PASS`: solo con prueba fresca contra el head/entorno exacto y read-back.
- No se usa Jules hasta cerrar la configuración documental de tareas y hasta que el operador decida iniciar el smoke OAuth.
- No se crea sesión real de Jules en este ciclo.
- No se modifican PRs/commits de Khora #345/#347 ni sus despliegues; se referencian como dependencias integradas.
- No se modifica el control de titularidad de MCP-Jules ni el control del frente padre Metacanon.
- No se fusiona la PR #19 por el hecho de que la lista quede configurada.
