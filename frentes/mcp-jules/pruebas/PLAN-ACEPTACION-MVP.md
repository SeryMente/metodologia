# Plan de aceptación · MVP MCP Jules v1.0

**Versión:** 1.9.0  
**Fase:** todos los criterios se ejecutan dentro de la Fase 2 única: implementación end-to-end, validación, release y puesta en servicio.  
**Plan rector:** [PLAN-INTEGRAL-MCP-JULES-v1.0.md](../PLAN-INTEGRAL-MCP-JULES-v1.0.md), con decisión operativa vigente v1.1.0.  
**Lista auxiliar de tareas:** [LISTA-TAREAS-PROVISIONAL.md](../LISTA-TAREAS-PROVISIONAL.md), v0.1, provisional.  
**Estado de pruebas al corte 2026-11-06:** T01–T38 PENDIENTE salvo los artefactos de código integrados enumerados abajo; los resultados históricos no equivalen a pruebas frescas del head actual.

**Corte de implementación:** las siete herramientas y ACL de Jules llegaron a Khora main mediante PR #345 (merge `953e69484eabb4e8dc8221d1d8fc188373531bfa`). El cliente puente local RDC/stdio con OAuth 2.1/PKCE llegó a Khora main mediante PR #347 (merge `4530e03a33c5e1743ab9646eb6c862b3c458c605`). PR #344/#338 son antecedentes supersedidos; PR #340 corresponde a Custodia. Las pruebas PC-14 572/572, typecheck, UI Review y 78/78 páginas son evidencia histórica de esos commits, no una ejecución nueva en el perfil/dispositivo activo. Consentimiento OAuth real, tools/list autenticado, lectura Jules real y E2E siguen sin verificarse. No se inicia ninguna sesión Jules hasta concluir la configuración de tareas y recibir la indicación del operador.

**Ruta vigente:** ChatGPT Free mediante cliente MCP local stdio operado por RDC, con OAuth 2.1 Authorization Code + PKCE contra Khora Production. No requiere plugin público, conexión MCP personalizada con escritura desde ChatGPT Free ni Bearer manual. No levanta un segundo servidor ni un listener público; el callback local se limita a 127.0.0.1. JULES_API_KEY permanece exclusivamente en Khora Production.

La Fase 1 continúa COMPLETA como planeación histórica y el proyecto conserva EXACTAMENTE dos fases. Esta matriz contiene criterios de salida de Fase 2; las etapas son agrupaciones operativas y no crean fases nuevas. Codex permanece excluido.

## Matriz de aceptación

| ID | Prueba | Condición de aceptación | Fase de proyecto | Estado |
|---|---|---|---|---|
| T01 | Contratos MCP | Las siete herramientas aparecen con schema JSON válido, descripciones, scopes y argumentos dentro de límites. | 2 | PENDIENTE |
| T02 | No regresión | Suites completas, typecheck, contratos y API tests existentes pasan en el head propuesto. | 2 | PENDIENTE |
| T03 | Scopes | Sin `jules:read`/`jules:write`, las herramientas correspondientes no llaman al cliente Jules. | 2 | PENDIENTE |
| T04 | Ciclo normativo | Cada herramienta sustantiva respeta el contrato real de token/turno normativo y su liberación. | 2 | PENDIENTE |
| T05 | IDs de recurso | Fuente/sesión inválida, URL arbitraria, path traversal, `?`, `#` y separadores prohibidos se rechazan antes de la API. | 2 | PENDIENTE |
| T06 | Payload de creación | El servidor envía `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`; el test verifica el payload porque ambos campos son input-only. | 2 | PENDIENTE |
| T07 | Aprobación por estado | `jules_approve_plan` rechaza todo estado distinto de `AWAITING_PLAN_APPROVAL`. | 2 | PENDIENTE |
| T08 | Feedback en la misma sesión | La respuesta se envía al mismo ID y las actividades posteriores se consultan para verificar respuesta. | 2 | PENDIENTE |
| T09 | Paginación | Sources, sessions y activities respetan `pageSize` 1–100, siguen `nextPageToken` y distinguen página vacía/final/error. | 2 | PENDIENTE |
| T10 | Escritura ambigua | POST de crear, enviar y aprobar no se reintentan automáticamente ante timeout/5xx; primero se reconcilia estado. | 2 | PENDIENTE |
| T11 | Errores | Clave ausente, 401/403, 429, 5xx, timeout, JSON inválido y estado incompatible producen diagnóstico seguro. | 2 | PENDIENTE |
| T12 | Secretos | Clave no aparece en resultado MCP, excepciones, logs, snapshots, prompts o Git. | 2 | PENDIENTE |
| T13 | Prompt injection | Mensajes/artefactos maliciosos de Jules no cambian scopes, fuente/branch, permisos ni autorización. | 2 | PENDIENTE |
| T14 | API real | `JULES_API_KEY` se acepta en una llamada autorizada, sin registrar su valor. | 2 | PENDIENTE |
| T15 | Bridge local RDC | El cliente stdio se inicia mediante RDC, completa OAuth 2.1/PKCE tras consentimiento explícito y descubre las siete herramientas por Khora /api/mcp; sin listener público ni plugin. | 2 | PENDIENTE |
| T16 | E2E bidireccional | Fuente → sesión con plan requerido → revisión humana → aprobación → avance → feedback → respuesta misma sesión → cierre/outputs. | 2 | PENDIENTE |
| T17 | Persistencia/reinstanciación | IDs, fuente/branch, estado, cursor y evidencia se guardan y la siguiente sesión retoma sin inventar contexto. | 2 | PENDIENTE |
| T18 | Release y smoke | Código de herramientas y bridge está integrado en Khora main vía #345/#347; ejecutar pruebas frescas, verificar versión desplegada y smoke local OAuth/rollback. | 2 | PENDIENTE |
| T19 | Fuente/branch server-side | Servidor consulta Source antes de crear y confirma que `startingBranch` existe; fallo/branch inexistente bloquea `sessions.create`. | 2 | PENDIENTE |
| T20 | Auto PR controlado | Create usa `AUTO_CREATE_PR`; PR se verifica por URL/estado real; no ocurre auto-merge/deploy. | 2 | PENDIENTE |
| T21 | Retry diferenciado | GET permite reintentos acotados/backoff; POST no usa un retry común para resultados ambiguos. | 2 | PENDIENTE |
| T22 | Plan vigente | Si cambia plan/actividad tras revisión, se bloquea la aprobación y se solicita consentimiento sobre el plan actual. | 2 | PENDIENTE |
| T23 | Elegibilidad ChatGPT Free por RDC | Una cuenta personal Free real utiliza el bridge local autorizado mediante RDC, completa OAuth y ejecuta una escritura no destructiva en sandbox tras aprobar plan; no requiere Developer Mode, plugin público ni plan pagado. | 2 | PENDIENTE |
| T24 | Uso conversacional + RDC | Chat normal y RDC permiten invocar el cliente local en turnos sucesivos, mantener checkpoint y recuperar feedback; no se afirma integración nativa del cliente stdio con ChatGPT. | 2 | PENDIENTE |
| T25 | Negativos de fuente | Fuente desconectada, respuesta Source malformada, error upstream y rama inexistente nunca alcanzan `sessions.create`. | 2 | PENDIENTE |
| T26 | Distribución local del bridge | Scripts, dependencias, launcher y guía local se pueden preparar/instalar en el perfil autorizado; DPAPI CurrentUser y callback loopback exacto; no se somete plugin público ni se abre endpoint externo. | 2 | PENDIENTE |
| T27 | OAuth y aislamiento | OAuth 2.1/PKCE identifica sujeto; servidor valida issuer/audience/expiry/scopes y filtra fuentes/repos/ramas. Usuario no autorizado no lista ni muta recursos ajenos. | 2 | PENDIENTE |
| T28 | Límites Free/RDC y reanudación | Ante límites de ChatGPT, pérdida de RDC/OAuth o expiración, se detiene sin duplicar POST y retoma desde checkpoint verificado. | 2 | PENDIENTE |
| T29 | No dependencia de GPT Actions | Instalación y escritura funcionan sin crear/editar GPT personalizado ni configurar GPT Actions. | 2 | PENDIENTE |
| T30 | Exclusión de Codex | Desarrollo, pruebas, publicación, instalación y operación no invocan ni requieren Codex. | 2 | PENDIENTE |
| T31 | Sincronía de versión del bridge/tools | El bridge valida que las siete herramientas y sus schemas corresponden al contrato en Khora main; una versión distinta/incompleta falla cerrado y se documenta. | 2 | PENDIENTE |
| T32 | Sin plugin ni extensión nativa | El flujo funciona por ChatGPT Free + RDC + cliente stdio; no depende de plugin, Developer Mode, sidebar/composer/file-viewer ni conexión MCP personalizada con escritura. | 2 | PENDIENTE |

| T33 | Separación MCP-OCP/Khora | El servidor de Metodología reside solo en SeryMente/metodologia; Jules sigue en Khora; no hay servidor, endpoint, secreto o control duplicado. | 2 | PENDIENTE |
| T34 | Seguridad del puente local | Callback exclusivo 127.0.0.1, refresh token DPAPI CurrentUser, access token en memoria, JULES_API_KEY solo en Khora y sin secretos en logs/Git. | 2 | PENDIENTE |
| T35 | Coexistencia de dos clientes locales | MCP-OCP stdio y Jules bridge stdio funcionan bajo RDC sin mezclar procesos, permisos, endpoints ni credenciales. | 2 | PENDIENTE |
| T36 | Smoke de solo lectura | tools/list devuelve exactamente siete herramientas; listar fuentes, sesiones y actividades reales con paginación sin crear sesiones ni efectuar POST de escritura. | 2 | PENDIENTE |
| T37 | Consentimiento OAuth real | Propietario autoriza jules:read y jules:write en Khora; token renovable DPAPI se conserva y puede revocarse; evidencia sin valores secretos. | 2 | PENDIENTE |
| T38 | E2E sandbox aprobado | Sesión Jules en sandbox, plan mostrado y confirmado, aprobación explícita, feedback misma sesión, PR/tests verificados y no auto-merge/deploy. | 2 | PENDIENTE |

## Etapas de aceptación dentro de la Fase 2

Los criterios T01–T38 pertenecen a la Fase 2. Su agrupación operativa es: etapa 2.1 preflight/reconciliación; etapa 2.2 implementación; etapa 2.3 pruebas y E2E; etapa 2.4 release/despliegue; etapa 2.5 aceptación y puesta en servicio. Ninguna agrupación crea una fase adicional.

## Secuencia de aceptación end-to-end

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
11. Preparar el cliente bridge local en el perfil autorizado; comprobar versión de Node/dependencias y ejecutar Status sin revelar credenciales.
12. Con el operador listo, completar OAuth/PKCE en el navegador de Khora y verificar tools/list. Después ejecutar lecturas reales de fuentes/sesiones/activities; no crear sesiones en este smoke.
13. Solo después del cierre de configuración y una instrucción posterior del operador, ejecutar E2E en sandbox: crear sesión, presentar plan, esperar confirmación explícita, aprobar, responder feedback y revisar PR.
14. Revisar límites Free/RDC, autorización por recurso, rotación/revocación, checkpoints y rollback.

## Criterios globales de PASS

- **CÓDIGO:** existe en el head de rama identificado.
- **TESTS:** PASS solo si se ejecutaron en ese head y se conserva output/estado real.
- **CI:** se lee de GitHub; resultado histórico no prueba el head actual.
- **API KEY VALIDADA:** una llamada real fue aceptada; el valor jamás se expone.
- **BRIDGE LOCAL DISPONIBLE:** scripts y dependencias funcionan en el perfil RDC autorizado; se ha comprobado el estado sin extraer credenciales.
- **CHATGPT FREE + RDC CONECTADO:** cuenta personal Free opera el cliente stdio mediante RDC, completa OAuth, descubre las herramientas y ejecuta una escritura autorizada en sandbox.
- **SIN CODEX:** ninguna etapa ni alternativa invocó Codex.
- **E2E:** el circuito bidireccional completo se comprobó en una sesión real.
- **MVP UTILIZABLE:** todos los gates de la Fase 2 pasan; no hay excepción silenciosa.
- **BLOQUEADO:** el bridge local, OAuth, RDC, aislamiento, credencial o permiso necesario no está disponible; conservar como bloqueado, no aprobado. No sustituir por plan pagado, GPT Actions, plugin público, Codex ni relevo manual.

Los estados no se heredan de anteriores ramas, PRs ni crónicas. `AUTO_CREATE_PR` no autoriza merge y la aprobación de un plan no autoriza operaciones de producción no incluidas en él.