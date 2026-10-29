# Objeto Canónico de Persistencia (OCP) · Frente MCP Jules

## 1. Control e identidad

- **Nombre canónico:** Frente MCP Jules.
- **Versión del artefacto:** v0.1.3 · consolidación del plan integral MCP Jules v1.0.
- **Evento de creación:** C-MCP-JULES-001.
- **Folio de sesión vigente:** SES-20261029-6C2F9A17; generación del control: 2. El folio anterior queda preservado en el historial de transferencia.
- **OCP:** `SeryMente/metodologia/frentes/mcp-jules/`.
- **Repositorio de implementación:** `SeryMente/khora`, `khora-web`, servidor MCP existente.
- **Rama de documentación:** `feat/metacanon-mcp-jules-20261025-c32f81`.
- **Rama de implementación:** `feat/mcp-jules-mvp-20261025-final`.
- **Estado:** la titularidad se transfirió y verificó el 2026-10-29. La fase 1 vigente es la planeación plena y completa del componente MCP Jules v1.0; no debe confundirse con la implementación candidata de [Khora PR #338](https://github.com/SeryMente/khora/pull/338). La línea base de diseño queda en [PLAN-INTEGRAL-MCP-JULES-v1.0.md](PLAN-INTEGRAL-MCP-JULES-v1.0.md). La documentación continúa en [Metodología PR #19](https://github.com/SeryMente/metodologia/pull/19), abierta en borrador y todavía no integrada a `main`. El último diagnóstico persistido reporta typecheck/UI contract/API tests aprobados en el candidato, una falla unitaria por acceso al esquema privado, findings Ruff ajenos y fallos de build/E2E aguas abajo; todo resultado técnico debe refrescarse contra los heads vigentes. API Jules real, elegibilidad de ChatGPT para escritura, conexión desde el cliente final, aceptación funcional, merge y despliegue siguen pendientes.
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

**Secuencia ratificada en este ciclo:** la primera fase es la planeación plena y completa del componente MCP Jules v1.0. El plan especifica el comportamiento conversacional tipo complemento, la arquitectura del MCP central de Khora, los siete contratos de herramientas, el ciclo bidireccional con Jules, la seguridad, los criterios de aceptación y los gates de viabilidad. La implementación posterior deberá reconciliarse contra [el plan integral v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md).

### Arquitectura aprobada

El operador autorizó ampliar el servidor MCP existente de `SeryMente/khora`, sin crear un segundo servidor; añadir permisos separados `jules:read` y `jules:write`; conservar autenticación y ciclo normativo; mantener `JULES_API_KEY` solo en el servidor; y exigir aprobación explícita del plan de Jules antes de que comience la ejecución. La aprobación de arquitectura no equivale a autorización para publicar credenciales, desplegar sin prueba o fusionar sin revisión.

### Resultado esperado

Un asistente puede localizar fuentes de Jules, crear una sesión con prompt completo, consultar estado, leer actividades y mensajes de Jules, responder a una solicitud del agente sin reiniciar el trabajo, y aprobar un plan solo cuando la sesión espera aprobación. El sistema conserva IDs/cursor, estado, fuente, rama y último punto de comprobación.

### Incluido en el producto mínimo viable (MVP)

- Siete herramientas MCP en el servidor Khora existente.
- Lectura de fuentes, sesiones individuales y actividades con paginación.
- Crear sesión forzando `requirePlanApproval=true`.
- Enviar respuesta a la misma sesión y recuperar después las actividades.
- Aprobar un plan únicamente cuando el estado real sea `AWAITING_PLAN_APPROVAL`.
- Scopes diferenciados para lectura y escritura, incluidos consentimiento OAuth, tokens manuales y metadatos.
- Pruebas positivas y negativas, manejo de errores seguro, guía de uso y criterios de aceptación.
- Guía replicable que referencia un único servidor; sin copiar claves, servidor ni controles de responsabilidad.

### Fuera del MVP directo

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
- Implementación candidata: `SeryMente/khora/khora-web`, rama `feat/mcp-jules-mvp-20261025-a71c9e2`.
- API externa de Jules: `https://jules.googleapis.com/v1alpha`; clave mediante encabezado `X-Goog-Api-Key`.
- Transporte MCP existente de Khora: endpoint remoto `/api/mcp` sobre HTTPS, con OAuth/Bearer ya existentes.
- Fuente/repo de Jules: debe copiarse literalmente de `jules_list_sources`; la rama se verifica antes de crear la sesión.
- Cuenta y plan de ChatGPT no se declaran verificados. La compatibilidad con escritura depende del plan y permisos reales del espacio de trabajo.
- La lista de variables de Vercel para `khora-web` confirma que `JULES_API_KEY` está definida como variable sensible de producción. Se consultó con `decrypt=false`; su valor nunca se recuperó ni expuso. La validez de la clave y una llamada API aceptada siguen NO VERIFICADAS.

## 8. Estado vivo

**Acción actual:** continuar el frente bajo la titularidad verificada de `C-MCP-JULES-005`. El PR documental #19 sigue abierto en borrador. Actualizar la crónica y refrescar los checks del head vigente antes de decidir cómo resolver los bloqueos. PR #337 de Khora se cerró sin merge por desfase de SHA; PR #338 es el candidato de implementación conocido.

**Siguiente acción:** provisionar acceso de lectura interrepositorio autorizado en CI para el esquema privado de Metacanon; tratar los dos findings Ruff con el frente responsable; volver a ejecutar CI. Después probar la API de Jules con la variable ya configurada (sin leer su valor), conectar un cliente ChatGPT con escritura y solo entonces decidir merge/despliegue. No hacerlo por inferencia.

**Pendientes ordenados:**
1. Repetir la suite completa tras resolver el acceso de lectura interrepositorio; conservar como evidencia que el typecheck, `ui-review:check`, `ui:contract`, API tests y los tests específicos Jules pasan en el último CI observado.
2. Abrir PR del delta limpio de Khora y leer estados de CI reales.
3. Revisar el diff y aprobar por separado merge/producción; no declarar aceptación por PR abierto.
4. Verificar una llamada API de Jules desde el entorno autorizado usando `JULES_API_KEY`, definida pero no validada todavía; no recuperar ni registrar su valor.
5. Hacer prueba autenticada: listar fuentes → crear sesión con aprobación de plan obligatoria → recuperar plan/actividad → aprobar explícitamente → esperar actividad → responder cuando Jules solicite información.
6. Conectar desde un cliente ChatGPT real que admita herramientas MCP con escritura; confirmar plan y permisos.
7. Si se necesita vigilancia cuando ChatGPT está inactivo, diseñar/implantar trabajador externo persistente con checkpoint, deduplicación, backoff, logs saneados, apagado y revisión humana.
8. Actualizar versión, crónica, evidencias e inventario después de cada resultado verificado.

**Recordatorio latente:** la API de Jules es `v1alpha`; contratos y parámetros requieren revalidación si el proveedor los modifica.

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
| Proteger la clave | `JULES_API_KEY` no aparece en respuestas, prompts ni repositorio | Variable sensible definida en Vercel producción; no se desencriptó; llamadas y revisión final pendientes |
| Uso real en ChatGPT | Herramientas descubiertas y secuencia bidireccional probada desde el cliente final | No verificado |
| Automatización persistente | Proceso programado con checkpoint, idempotencia y recuperación tras reinicio | Fuera de alcance hasta aprobar implementación del trabajador |

**MVP realmente utilizable:** requiere tests automáticos ejecutados y aprobados, una prueba autenticada real con fuente de prueba, y conexión de ChatGPT que admita escritura. Sin esos tres elementos, el estado es candidato de código, no producción aceptada.

## 10. Formato de ciclo

Aplicar Metacanon §4 en cada ciclo sustantivo: identidad/gobierno; dónde estamos; delta; avance y evidencia; pendientes; viabilidad; siguiente hito; siguiente acción; continuación/prompt; persistencia y lectura de vuelta. Cada cambio se registra en `cronica/`; originales del operador y salidas visibles disponibles se conservan en `originales/` con procedencia. Diferenciar tests sintéticos, pruebas locales, llamadas reales a Jules, CI, merge y despliegue.

## 11. Crónica y fuentes

- [Ciclo de creación C-MCP-JULES-001](cronica/C-MCP-JULES-001.md).
- [Ciclo de transferencia y estado C-MCP-JULES-005](cronica/C-MCP-JULES-005.md).
- [Ciclo vigente C-MCP-JULES-006](cronica/C-MCP-JULES-006.md) — definición de la fase 1.
- [Plan integral del componente MCP Jules v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md) — línea base de diseño; Fase 1, sin implementación.
- [Texto original del operador](originales/C-MCP-JULES-001-operador.txt).
- [Investigación de API, ChatGPT y automatización](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
- [Plan de aceptación](pruebas/PLAN-ACEPTACION-MVP.md).
- [Contrato de uso por el asistente](prompts/ASISTENTE-MCP.md).
- [Contrato para prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
- [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
- [Implementación candidata en Khora](https://github.com/SeryMente/khora/tree/feat/mcp-jules-mvp-20261025-final).

## 12. Reinstanciación

En una sesión nueva, leer este núcleo y [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json), cotejar folio/generación y revisar la crónica más reciente. Leer la investigación y el plan de aceptación antes de ejecutar acciones externas. Después, obtener el árbol de Khora en la rama/PR real y comprobar estados actuales. La salida anterior solo se reproduce literalmente si está conservada; en caso contrario declarar `NO DISPONIBLE / NO VERIFICADA`.

No adquirir, transferir ni modificar el control de `frentes/metacanon/`; el frente MCP Jules es independiente. No copiar a otros OCP el control, la credencial, la titularidad ni un estado vivo alternativo.

## 13. Persistencia y revisión

Guardar cambios en las ramas correspondientes, cotejar cada escritura por lectura de vuelta y registrar revisiones. Este OCP no es el documento normativo de Metacanon y no altera el canon de gobernanza. La replicación consiste en referenciar el servidor MCP común y aplicar el patrón a cada frente, no en desplegar una copia de servidor por proyecto.

Al cierre de un ciclo:
1. cotejar aceptación contra outputs reales;
2. actualizar estado vivo, crónica y pendientes;
3. leer de vuelta el contenido y las rutas;
4. actualizar [INVENTARIO-REPOSITORIOS-Y-FRENTES.md](../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md);
5. separar en la salida lo probado, lo reportado y lo no verificado.
