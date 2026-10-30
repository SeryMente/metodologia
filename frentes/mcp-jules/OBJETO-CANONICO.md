# Objeto Canónico de Persistencia (OCP) · Frente MCP Jules

## 1. Control e identidad

- **Nombre canónico:** Frente MCP Jules.
- **Versión del artefacto:** v0.1.7 · estado de implementación Fase 2, candidato #344.
- **Evento de creación:** C-MCP-JULES-001.
- **Folio de sesión vigente:** SES-20261029-6C2F9A17; generación del control: 2. El folio anterior queda preservado en el historial de transferencia.
- **OCP:** `SeryMente/metodologia/frentes/mcp-jules/`.
- **Repositorio de implementación:** `SeryMente/khora`, `khora-web`, servidor MCP existente.
- **Rama de documentación:** `feat/metacanon-mcp-jules-20261025-c32f81`.
- **Rama de implementación:** `feat/mcp-jules-f2-20261029-6c2f9a17`.
- **Estado:** la titularidad permanece en generación 2 y folio `SES-20261029-6C2F9A17`, conforme al control vigente que no se modifica. Fase 1 continúa COMPLETA como diseño integral. Fase 2 ya tiene un candidato de implementación versionado en KHORA, rama `feat/mcp-jules-f2-20261029-6c2f9a17`, presentado como [PR #344](https://github.com/SeryMente/khora/pull/344), en borrador y apilado sobre la rama de Custodia `fix/custodia-recovery-verified-20261029` (head base `e2ec67600885315fd4493911da89af1d4aafc297`). El PR anterior #338 permanece como antecedente obsoleto y no se fusiona. El candidato contiene siete herramientas MCP, scopes separados, ACL privada por sujeto/fuente/rama, validación de fuente y rama, y protección contra reintentos ambiguos de escritura. La migración 033 está en Git, no aplicada; las pruebas nuevas están escritas, pero el CI de este head finalizó sin ejecutar steps (`steps: null`) y sin logs recuperables. Los checks Vercel también fallan por la restricción del plan para repositorios privados de organización; no son una validación de compilación. API Jules real, OAuth, base ACL operativa, publicación del plugin, ChatGPT Free, E2E, merge y despliegue siguen pendientes de evidencia. La última crónica es [C-MCP-JULES-010](cronica/C-MCP-JULES-010.md).
- **Fuente de titularidad:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No modifica ni sustituye el control del frente padre Metacanon.

## 2. LEER PRIMERO

Este frente construye un puente para que ChatGPT delegue desarrollo en Jules, agente asíncrono de programación, pueda leer la retroalimentación y contestarla dentro de la misma sesión. El estado único de este trabajo está aquí; el código se integra en el servidor MCP ya existente de Khora.

Orden de uso: leer la fuente canónica Samantha/Metacanon/GOW; leer este OCP y su control; comprobar folio y titularidad; comprobar la revisión real del código en Khora; validar credenciales y permisos; ejecutar pruebas; actualizar crónica y aceptación; releer lo guardado. No afirmar ejecución, pruebas, merge, despliegue ni conexión a ChatGPT que no estén demostrados.

**MCP-NORMATIVO: DESACTIVADO** conforme al estado observado del frente Metacanon; se mantiene revisión manual de la cascada. La grafía «MSP» en el dictado se interpreta como «MCP» a partir del contexto explícito de este encargo y no se convierte en un sistema alternativo.

## 3. Referencia metodológica

- Fuente normativa única consultada en este ciclo: [Documento Único de Gobernanza (DUG) · Samantha v360 · NX-360m](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), rama `main`, leído el 2026-10-29.
- Marco de objetos canónicos: Metacanon **1.24**, sección integrada en el mismo documento normativo; §§4, 29–51 aplicables según el ciclo.
- Glosario Operativo del Workspace (GOW): **2.9**, integrado en el documento canónico.
- Control vigente del frente padre leído desde `main`: `frentes/metacanon/CONTROL-RESPONSABILIDAD.json`, blob `0eaf612b01de0ae630b7a4775849be455ebda6c8`, generación 5, folio `SES-20261028-8D7A31C2`. No fue modificado por la transferencia de MCP Jules.
- API de Jules: [referencia REST oficial](https://developers.google.com/jules/api/reference/rest), versión `v1alpha`.
- Conexión MCP en ChatGPT: [documentación oficial de OpenAI](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt).
- Investigación específica: [INVESTIGACION-API-JULES-CHATGPT.md](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
- La revisión de gobierno fue manual; no se declara verificación normativa automática.

## 4. Propósito y alcance

**Propósito dictado por el operador:** construir un frente de trabajo independiente dentro de Metacanon que defina e implemente la comunicación con Jules para entregar prompts de desarrollo, recuperar sus preguntas y solicitudes de retroalimentación, responderlas dentro de la misma sesión, investigar hasta qué punto puede automatizarse el proceso MCP y llegar a un producto mínimo viable replicable en los frentes sujetos a esta metodología. El original completo se conserva en [C-MCP-JULES-001-operador.txt](originales/C-MCP-JULES-001-operador.txt).

**Secuencia ratificada en este ciclo:** la primera fase es la planeación plena y completa del componente MCP Jules v1.0 para uso desde una cuenta ChatGPT Free, sin Codex. El plan define el comportamiento conversacional, el MCP central de Khora, los siete contratos, el ciclo Jules bidireccional, la distribución mediante plugin MCP público, OAuth 2.1, aislamiento por usuario/repositorio, seguridad y aceptación. La disponibilidad y escritura reales de ese plugin en Free siguen como gates de fases posteriores. La implementación posterior deberá reconciliarse contra [el plan integral v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md).

### Arquitectura aprobada

El operador autorizó ampliar el servidor MCP existente de `SeryMente/khora`, sin crear un segundo servidor; añadir permisos separados `jules:read` y `jules:write`; conservar autenticación/ciclo normativo; mantener `JULES_API_KEY` solo en servidor; y exigir aprobación explícita del plan. En R2, el cliente requerido es ChatGPT Free y la distribución objetivo es un plugin MCP público conectado al mismo endpoint. Codex no se utilizará. La aprobación de arquitectura no equivale a autorización para publicar credenciales, desplegar sin prueba o fusionar sin revisión.

### Resultado esperado

Un asistente puede localizar fuentes de Jules, crear una sesión con prompt completo, consultar estado, leer actividades y mensajes de Jules, responder a una solicitud del agente sin reiniciar el trabajo, y aprobar un plan solo cuando la sesión espera aprobación. El sistema conserva IDs/cursor, estado, fuente, rama y último punto de comprobación.

### Incluido en el producto mínimo viable (MVP)

- Siete herramientas MCP en el servidor Khora existente.
- Plugin MCP público aprobado/publicado en el directorio de ChatGPT como superficie de instalación para ChatGPT Free; sujeto a prueba de capacidad real.
- Lectura de fuentes, sesiones individuales y actividades con paginación.
- Crear sesión forzando `requirePlanApproval=true`.
- Enviar respuesta a la misma sesión y recuperar después las actividades.
- Aprobar un plan únicamente cuando el estado real sea `AWAITING_PLAN_APPROVAL`.
- Scopes diferenciados de lectura/escritura y OAuth 2.1 del plugin; autorización por sujeto, fuente Jules, repositorio y rama.
- Pruebas positivas/negativas, seguridad de usuario/recurso, revisión/publicación del plugin, uso real en Free, límites de cuota, manejo seguro, guía y aceptación.
- Guía replicable que referencia un único servidor; sin copiar claves, servidor ni controles de responsabilidad.

### Fuera del MVP directo

- Codex, en cualquiera de sus superficies, como herramienta, cliente o fallback.
- GPT Actions o GPT personalizado como dependencia.
- Conexión MCP privada desde un plan distinto como sustituto de la ruta ChatGPT Free.
- Un segundo servidor especializado.
- Autorespuesta ilimitada o aprobación automática incondicional.
- Webhooks de actividades no documentados en la API oficial consultada.
- Garantizar que ChatGPT opere en segundo plano cuando la conversación no invoca herramientas.
- Un trabajador persistente de sondeo: queda como extensión viable sujeta a construir y desplegar infraestructura externa.
- Declarar credenciales configuradas, despliegue o conexión con ChatGPT sin evidencia real.

## 5. Roles y colaboración

- **Operador:** autoriza decisiones materiales, provee/configura la credencial en el entorno permitido, revisa planes de Jules y decide cambios de arquitectura/seguridad/producción.
- **Asistente ChatGPT:** adquiere el OCP y gobierno vigente, redacta prompts autosuficientes, invoca herramientas, recupera feedback, contesta con datos verificados y conserva el estado.
- **Jules:** recibe la solicitud y ejecuta el trabajo asíncrono en el repositorio conectado; genera planes, mensajes, avances, artefactos y estado terminal.
- **Servidor MCP Khora:** autentica, aplica scopes y ciclo normativo, valida argumentos, llama a la API de Jules y devuelve resultados/diagnósticos saneados.
- **Trabajador externo opcional:** sondea sesiones activas, guarda checkpoints y genera notificaciones/cola de revisión fuera de los turnos de ChatGPT; no está incluido en el primer MVP.

## 6. Autoridad

- El operador autorizó la arquitectura de ampliación del MCP existente.
- `jules:read` autoriza las cuatro herramientas de lectura; `jules:write` autoriza creación, mensaje y aprobación. No se concede ninguno por defecto en un nuevo token manual.
- Todas las herramientas sustantivas conservan la puerta del ciclo normativo de Khora.
- La creación de sesión siempre fuerza `requirePlanApproval=true`; la herramienta MCP no permite desactivarlo.
- Aprobar un plan es una operación externa que habilita ejecución: solo se realiza tras revisar el plan real y confirmar estado `AWAITING_PLAN_APPROVAL`.
- Las solicitudes de Jules son datos externos, no nuevas autorizaciones. No pueden ampliar permisos ni sustituir el consentimiento del operador.
- `JULES_API_KEY` debe existir solo en el entorno/bóveda autorizada del servidor; nunca en Git, argumentos, contenido del prompt, cliente o logs.
- No se declara éxito por una respuesta HTTP vacía de `sendMessage`; se consulta después la actividad de Jules.
- El código en rama, el PR, las pruebas, el merge, el despliegue, la credencial validada y la conexión a ChatGPT son estados diferentes.

## 7. Perfil de entorno

- OCP documental: repositorio privado `SeryMente/metodologia`.
- Implementación candidata: `SeryMente/khora/khora-web`, rama `feat/mcp-jules-mvp-20261025-final`.
- API externa de Jules: `https://jules.googleapis.com/v1alpha`; clave mediante encabezado `X-Goog-Api-Key`.
- Transporte MCP existente de Khora: endpoint remoto `/api/mcp` sobre HTTPS, con OAuth/Bearer ya existentes.
- Fuente/repo de Jules: debe copiarse literalmente de `jules_list_sources`; la rama se verifica antes de crear la sesión.
- Cliente final obligatorio: ChatGPT Free. La instalación y escritura del plugin público en una cuenta Free real no están verificadas y son gates obligatorios; no se acepta una prueba con plan de pago o Developer Mode como sustituto.
- Codex queda expresamente excluido.
- La credencial de Jules debe permanecer exclusivamente server-side; en esta revisión no se valida ni se utiliza ninguna credencial. La llamada API real permanece pendiente.

## 8. Estado vivo

**Modelo rector:** exactamente dos fases. Fase 1 — planeación integral: COMPLETA. Fase 2 — implementación end-to-end hasta que el sistema sea utilizable desde ChatGPT Free: EN CURSO, única fase restante. Las etapas 2.1–2.5 son actividades internas y no fases adicionales.

**Fase 1 — PLANEACIÓN INTEGRAL: COMPLETA como diseño R3.** La línea base [PLAN-INTEGRAL-MCP-JULES-v1.0.md](PLAN-INTEGRAL-MCP-JULES-v1.0.md) conserva 24 secciones y 32 pruebas/gates. Cierre de diseño en [C-MCP-JULES-009](cronica/C-MCP-JULES-009.md); el ciclo de implementación actual queda en [C-MCP-JULES-010](cronica/C-MCP-JULES-010.md).

**Fase 2 — CANDIDATO DE IMPLEMENTACIÓN:** [Khora PR #344](https://github.com/SeryMente/khora/pull/344), rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `c4ca7615a481de1cd2b447f31bd9a7fb569cf9b5`. Se encuentra en borrador y usa como base `fix/custodia-recovery-verified-20261029`, head `e2ec67600885315fd4493911da89af1d4aafc297`, para mantener el trabajo de Custodia separado del cambio Jules. El PR #340 de Custodia sigue en borrador; no cambiar la base a `main` ni fusionar prematuramente. El antiguo PR #338 queda como antecedente obsoleto, sin merge.

**Implementación contenida en #344:** las siete herramientas Jules están integradas en el endpoint MCP existente `/api/mcp`; OAuth y tokens manuales reconocen `jules:read`/`jules:write` sin añadirlos al conjunto predeterminado; la capa `jules-access.ts` aplica denegación por defecto y coincidencia exacta de sujeto, source y branch; se filtran fuentes, ramas y sesiones; `sources.get` valida la rama antes de crear; el adaptador usa paginación oficial `pageToken` y reintenta solo GET/HEAD; los POST ambiguos se devuelven como `JULES_WRITE_RESULT_AMBIGUOUS` sin repetición automática. Se añadieron la migración `033_jules_source_acl.sql`, documentación específica y fixtures/tests sintéticos.

**Validación actual:** los tests y los contratos están escritos, pero no existe resultado PASS de CI para el head final. Los workflows CI y UI Quality terminaron con jobs `steps: null`; los logs devuelven `BlobNotFound`, incluso después de repetir los jobs. No se ejecutaron comandos de test en runner. Los checks Vercel fallan por la restricción de despliegue de repositorios privados de organización en el plan Hobby. Esto es un bloqueo de infraestructura/servicio de CI o deploy, no una conclusión sobre compilación. T01–T32 permanecen PENDIENTE.

**ACL y base de datos:** `033_jules_source_acl.sql` está versionada pero NO aplicada. El rol real usado por `KHORA_READONLY_DATABASE_URL` debe identificarse y verificarse antes de recibir únicamente `USAGE` en `khora_private` y `SELECT` en `khora_private.jules_source_acl`. No se emitieron concesiones productivas ni se realizó read-back de ACL.

**Cliente y distribución:** ChatGPT Free en chat normal sigue siendo obligatorio; el producto objetivo es un plugin MCP público aprobado que apunte al mismo endpoint `/api/mcp`. No se ha publicado, instalado ni demostrado escritura desde una cuenta Free real. No se acepta sustitución por plan pagado, Developer Mode, GPT Actions, Codex, un servidor MCP paralelo o relevo manual.

**Pendientes que bloquean el cierre de Fase 2:** ejecución real de typecheck/contract/unit/API/E2E en CI; revisión del diff y corrección de errores que aparezcan; migración y lectura de vuelta de ACL en entorno autorizado; llamada real de lectura/escritura Jules; OAuth/aislamiento real; publicación y aprobación del plugin; prueba de instalación y escritura en ChatGPT Free; ciclo E2E completo; merge/release/despliegue autorizado y smoke/rollback. No se marca un gate PASS por el mero hecho de que el código o un test exista.

**Siguiente y única fase restante:** Fase 2 — implementación end-to-end, validación, release y puesta en servicio. Su alcance permanece dentro de una sola fase y no se crean fases nuevas.

## 9. Aceptación y viabilidad

| Requisito | Criterio verificable | Estado inicial |
|---|---|---|
| Listar fuentes Jules | Devuelve fuentes reales y paginación correcta | Código en rama; API real no probada |
| Listar/consultar sesiones | ID validado, estado y token de página correctos | Código en rama; API real no probada |
| Leer retroalimentación | Recupera `agentMessaged`, `userMessaged`, `planGenerated`, progreso, fallo/completado y paginación | Código en rama; contrato probado; llamada real pendiente |
| Crear sesión | Fuente y rama verificadas; prompt completo; fuerza `requirePlanApproval=true` | Código en rama; API real no probada |
| Responder | Mismo ID de sesión; envía solo en estado permitido; luego vuelve a consultar actividades | Código en rama; API real no probada |
| Aprobar plan | Rechaza salvo `AWAITING_PLAN_APPROVAL` y usa scope de escritura | Código en rama; prueba pendiente |
| Aislar permisos | Lectura no permite escribir; escritura no da acceso a lectura/otras funciones | Test de scopes/OAuth PASS; suite completa bloqueada por GH_TOKEN ajeno al diff |
| Preservar gobierno | Las siete herramientas pasan por la validación del ciclo normativo | Código y fixture añadidos; ejecución pendiente |
| Proteger secretos | El secreto del proveedor permanece server-side y no aparece en respuestas, prompts ni repositorio | Regla de implementación presente; pruebas ejecutadas y llamada real pendientes |
| Uso real en ChatGPT Free | Plugin público instalado en cuenta Free, siete tools descubiertas y ciclo de escritura E2E probado | No verificado; gates T23/T26 |
| Automatización persistente | Proceso programado con checkpoint, idempotencia y recuperación tras reinicio | Fuera de alcance hasta aprobar implementación del trabajador |

**MVP realmente utilizable:** exige suite aprobada, API Jules real, plugin aprobado/publicado, instalación en cuenta ChatGPT Free real, OAuth/aislamiento por sujeto, escritura no destructiva, E2E bidireccional y release autorizado. Sin ello es candidato, no producción aceptada.

## 10. Formato de ciclo

Aplicar Metacanon §4 en cada ciclo sustantivo: identidad/gobierno; dónde estamos; delta; avance y evidencia; pendientes; viabilidad; siguiente hito; siguiente acción; continuación/prompt; persistencia y lectura de vuelta. Cada cambio se registra en `cronica/`; originales del operador y salidas visibles disponibles se conservan en `originales/` con procedencia. Diferenciar tests sintéticos, pruebas locales, llamadas reales a Jules, CI, merge y despliegue.

## 11. Crónica y fuentes

- [Ciclo de creación C-MCP-JULES-001](cronica/C-MCP-JULES-001.md).
- [Ciclo de transferencia y estado C-MCP-JULES-005](cronica/C-MCP-JULES-005.md).
- [Ciclo histórico C-MCP-JULES-006](cronica/C-MCP-JULES-006.md) — apertura de la fase de planeación.
- [Ciclo histórico C-MCP-JULES-007](cronica/C-MCP-JULES-007.md) — cierre R1.
- [Ciclo histórico C-MCP-JULES-008](cronica/C-MCP-JULES-008.md) — cierre R2, requisito Free y no Codex.
- [Ciclo de implementación C-MCP-JULES-010](cronica/C-MCP-JULES-010.md) — PR #344, ACL y estado de validación.
- [Plan integral del componente MCP Jules v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md) — línea base de diseño completa; la implementación y validación siguen pendientes.
- [Texto original del operador](originales/C-MCP-JULES-001-operador.txt).
- [Investigación de API, ChatGPT y automatización](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
- [Plan de aceptación](pruebas/PLAN-ACEPTACION-MVP.md).
- [Contrato de uso por el asistente](prompts/ASISTENTE-MCP.md).
- [Contrato para prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
- [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
- [Implementación candidata actual en Khora · PR #344](https://github.com/SeryMente/khora/pull/344) y [rama](https://github.com/SeryMente/khora/tree/feat/mcp-jules-f2-20261029-6c2f9a17).

## 12. Reinstanciación

En una sesión nueva, leer este núcleo y [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json), cotejar folio/generación y revisar [C-MCP-JULES-010](cronica/C-MCP-JULES-010.md) como última crónica, sin saltarse el control y la matriz de aceptación. Leer la investigación y el plan de aceptación antes de ejecutar acciones externas. Después, obtener el árbol de Khora en la rama/PR real y comprobar estados actuales. La salida anterior solo se reproduce literalmente si está conservada; en caso contrario declarar `NO DISPONIBLE / NO VERIFICADA`.

No adquirir, transferir ni modificar el control de `frentes/metacanon/`; el frente MCP Jules es independiente. No copiar a otros OCP el control, la credencial, la titularidad ni un estado vivo alternativo.

## 13. Persistencia y revisión

Guardar cambios en las ramas correspondientes, cotejar cada escritura por lectura de vuelta y registrar revisiones. Este OCP no es el documento normativo de Metacanon y no altera el canon de gobernanza. La replicación consiste en referenciar el servidor MCP común y aplicar el patrón a cada frente, no en desplegar una copia de servidor por proyecto.

Al cierre de un ciclo:
1. cotejar aceptación contra outputs reales;
2. actualizar estado vivo, crónica y pendientes;
3. leer de vuelta el contenido y las rutas;
4. actualizar [INVENTARIO-REPOSITORIOS-Y-FRENTES.md](../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md);
5. separar en la salida lo probado, lo reportado y lo no verificado.
