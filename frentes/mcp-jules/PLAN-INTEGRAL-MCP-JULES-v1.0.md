# Plan integral del componente MCP Jules v1.0

**Versión del plan:** 1.0  
**Frente:** MCP Jules  
**Fase vigente:** Fase 1 — planeación integral; no implementación.  
**Fecha de corte documental:** 2026-10-29  
**OCP:** `frentes/mcp-jules/`  
**Control de responsabilidad:** `CONTROL-RESPONSABILIDAD.json`, generación 2, folio `SES-20261029-6C2F9A17`.  
**Gobierno consultado:** Documento Único de Gobernanza (DUG) Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9, leídos desde `SeryMente/metodologia/main`.  
**Estado:** línea base de diseño para revisión; no equivale a código aceptado, API validada, conexión de ChatGPT, despliegue ni release.

## 1. Decisión de fase

La primera fase del frente es la **planeación plena y completa del componente MCP Jules en su versión 1.0**. Esta fase define propósito, arquitectura, alcance funcional, contratos de herramientas, estados y ciclos, seguridad, operación, pruebas, aceptación, despliegue, recuperación, exclusiones y decisiones de viabilidad.

Durante esta fase no se añade ni modifica código de producto, no se despliega ni se fusiona por el solo hecho de que exista una rama candidata. Las PR existentes se usan como evidencia y material de comparación, no como prueba de que el diseño ya esté completo o funcione.

La fase 1 se considera cerrada cuando el plan tenga trazabilidad entre requisitos, arquitectura y aceptación, y cada bloqueo material figure como resuelto con evidencia o como decisión explícita pendiente del operador. La implementación y su validación pertenecen a fases posteriores.

## 2. Propósito del componente

MCP Jules debe funcionar como una integración de herramientas adicional, disponible para ChatGPT junto con otras integraciones como Remote Desktop Commander (RDC). Dentro del flujo activo de una conversación, ChatGPT podrá seleccionar e invocar las herramientas MCP para delegar trabajo de desarrollo a Jules, consultar lo que está ocurriendo, recuperar preguntas o solicitudes de retroalimentación y responderlas dentro de la misma sesión.

La función principal no es simplemente enviar un prompt. Es cerrar el ciclo:

**ChatGPT analiza y formula → Jules planea → el operador aprueba el plan → Jules ejecuta → ChatGPT recupera actividad y preguntas → ChatGPT responde con contexto verificado → Jules continúa → ChatGPT comprueba la entrega.**

La integración se invoca a través de la interfaz de herramientas disponible en la conversación. No se supone acceso a herramientas dentro de un proceso de razonamiento privado invisible, ejecución automática en todos los turnos ni trabajo de fondo cuando ChatGPT no está activo.

## 3. Resultado esperado de v1.0

La versión 1.0 debe permitir que un asistente autorizado:

1. Descubra las fuentes de Jules accesibles y seleccione un repositorio devuelto realmente por la API.
2. Compruebe la fuente y la rama antes de iniciar una sesión.
3. Formule una instrucción de desarrollo autosuficiente con objetivo, contexto canónico, alcance, exclusiones, criterios de aceptación, pruebas y formato de entrega.
4. Abra una sesión Jules en la fuente y rama seleccionadas, forzando en el servidor `requirePlanApproval=true`.
5. Consulte las sesiones, el estado actual, las actividades y la paginación.
6. Recupere el plan generado y espere una aprobación explícita antes de que Jules comience la ejecución.
7. Detecte solicitudes de información de Jules, conteste a la misma sesión y vuelva a consultar actividades; un POST aceptado no se trata como prueba de que Jules ya respondió.
8. Continúe el ciclo sin abrir una sesión sustituta por defecto y sin repetir preguntas ya resueltas.
9. Recupere la entrega final, PR/artefactos y estado terminal cuando la API los exponga; inspeccione y verifique lo que esté realmente disponible.
10. Persista un checkpoint de cada ciclo en la crónica del OCP y mantenga el estado vivo resumido en el núcleo único.
11. Devuelva errores seguros y accionables, sin divulgar credenciales ni cuerpos externos arbitrarios.
12. Reutilice el único servidor MCP existente de Khora para los frentes autorizados, sin desplegar un servidor por frente.

## 4. Límites y exclusiones

### Incluido en v1.0

- Siete herramientas MCP para lectura de fuentes/sesiones/actividades y para crear, responder y aprobar planes.
- Integración en la ruta MCP existente de Khora.
- Autenticación ChatGPT → Khora mediante el mecanismo OAuth/Bearer existente.
- Autenticación Khora → Jules mediante `JULES_API_KEY` guardada exclusivamente en el entorno seguro del servidor.
- Scopes diferenciados `jules:read` y `jules:write`, dentro del contrato de autorización que ya emplea Khora.
- Compatibilidad con el ciclo normativo existente de Khora, sus tokens/controles y diagnósticos.
- Paginación, validación de identificadores, errores estandarizados y pruebas positivas y negativas.
- Uso interactivo desde un cliente ChatGPT real que admita las capacidades de escritura necesarias.
- Registro de sesión, fuente, rama, eventos, checkpoints, resultados, fallos y siguiente paso en el OCP.

### Excluido de v1.0

- Un segundo servidor MCP o un servidor dedicado por proyecto.
- Un trabajador permanente que sondee Jules cuando ChatGPT está inactivo.
- Webhooks de actividad que no estén documentados y disponibles en la API usada.
- Autorespuesta ilimitada, aprobación automática del plan o delegación que amplíe permisos.
- Merge, despliegue a producción o cambios de arquitectura realizados solo porque Jules los proponga.
- Copiar la clave de Jules, tokens de ChatGPT, credenciales o secretos al prompt, cliente, Git, evidencia o logs.
- Garantizar disponibilidad permanente de ChatGPT, ejecución en segundo plano o invocación de herramientas en cada ciclo.
- Declarar que todos los repositorios de la organización están conectados a Jules sin comprobar la lista de fuentes.

El sondeo persistente, notificaciones, políticas de respuesta automática acotada y orquestación ampliada de PR/CI son posibles evoluciones posteriores, no condiciones implícitas de v1.0.

## 5. Arquitectura lógica

```text
ChatGPT — conversación activa / selector de herramientas
  │  MCP remoto HTTPS + autenticación de usuario
  ▼
Servidor MCP existente de KHORA
  ├─ autenticación OAuth/Bearer y validación del token
  ├─ autorización por scope de cada herramienta
  ├─ controles del ciclo normativo existente
  ├─ validación de argumentos y nombres de recursos
  ├─ diagnóstico saneado, límites y manejo de errores
  └─ cliente Jules (sin credenciales en el cliente)
        │  HTTPS + X-Goog-Api-Key
        ▼
Jules REST API v1alpha
  ├─ sources
  ├─ sessions
  └─ sessions/{session}/activities
        │
        ▼
Respuesta de herramienta a ChatGPT
  ├─ lectura y evaluación del estado
  ├─ aprobación humana cuando proceda
  ├─ respuesta de retroalimentación en la misma sesión
  └─ verificación y registro del ciclo en frentes/mcp-jules/
```

Se conserva una sola ruta MCP de Khora: `/api/mcp`. El componente Jules es una familia de herramientas y un cliente de proveedor integrado en el servidor existente, no un servidor separado. El estado del proyecto, el código del producto, el control de responsabilidad y las credenciales tienen autoridades y ubicaciones distintas.

### Separación de credenciales

- **ChatGPT → Khora:** OAuth/Bearer y scopes emitidos por el sistema de autenticación de Khora.
- **Khora → Jules:** `JULES_API_KEY`, solo en el servidor.
- Los scopes `jules:read` y `jules:write` habilitan conjuntos diferentes de herramientas. Ninguno debe añadirse implícitamente al conjunto predeterminado de tokens existentes.
- La integración mantiene los controles normativos que requiera la ruta MCP. La matriz exacta de scopes de negocio, control normativo y token de turno se fija contra el contrato real del servidor durante la revisión de diseño y pruebas.

## 6. Contrato funcional de las siete herramientas

| Herramienta | Scope de negocio | Responsabilidad | Reglas principales |
|---|---|---|---|
| `jules_list_sources` | `jules:read` | Enumerar las fuentes reales accesibles y sus páginas. | Limitar `page_size` a 1–100; preservar `nextPageToken`; no inventar fuentes. |
| `jules_list_sessions` | `jules:read` | Enumerar sesiones accesibles y su paginación. | Validar límites y tokens de página; no inferir sesiones ausentes. |
| `jules_get_session` | `jules:read` | Leer estado, tiempos, URL y outputs de una sesión. | Normalizar ID de sesión; no aceptar URL o ruta arbitraria. |
| `jules_list_activities` | `jules:read` | Leer mensajes, plan, progreso, errores, salida y eventos. | Paginación completa; distinguir respuesta parcial, página final y error. |
| `jules_create_session` | `jules:write` | Crear una sesión con fuente, rama y prompt. | Verificar fuente/branch; forzar `requirePlanApproval=true` en el servidor. |
| `jules_send_message` | `jules:write` | Enviar respuesta a una sesión existente. | Verificar ID/estado; proteger contra reenvío ciego tras timeout; luego releer actividades. |
| `jules_approve_plan` | `jules:write` | Aprobar el plan de una sesión. | Exigir estado `AWAITING_PLAN_APPROVAL`, plan leído y autorización explícita; rechazar otros estados. |

La API oficial de Jules enumera operaciones para listar fuentes, crear/listar/consultar sesiones, leer actividades, enviar mensajes y aprobar un plan. La sesión incluye estado y `requirePlanApproval`; si el campo no se establece, la documentación indica que el plan puede aprobarse automáticamente. La API consultada es `v1alpha`, por lo que su contrato debe revalidarse antes del desarrollo y release.

## 7. Ciclo operativo detallado

### 7.1 Preparación y delegación

1. Leer este plan, el núcleo del frente solicitante y su fuente canónica.
2. Confirmar autorización para actuar sobre el repositorio destino.
3. Llamar a `jules_list_sources`; elegir una fuente de la respuesta real y verificar la rama disponible.
4. Construir el prompt a partir de hechos comprobados, con propósito, estado, alcance, exclusiones, restricciones, pruebas y formato de entrega.
5. Llamar a `jules_create_session`; el servidor fuerza la aprobación del plan.
6. Guardar el identificador devuelto y leer el plan/estado hasta que pueda revisarse. No se interpreta la creación de una sesión como inicio autorizado de ejecución.

### 7.2 Aprobación del plan

1. Leer el estado real y la actividad que contiene el plan.
2. Comparar el plan con el objetivo, permisos, repositorio, rama, alcance, riesgos y criterios de aceptación.
3. Si el plan es seguro y corresponde a lo autorizado, presentar al operador la decisión necesaria y esperar confirmación explícita.
4. Ejecutar `jules_approve_plan` solo si la sesión sigue en `AWAITING_PLAN_APPROVAL`.
5. Volver a consultar estado/actividades. La respuesta vacía de la API de aprobación no sustituye la verificación posterior.

Un plan que expanda alcance, introduzca secreto, requiera permisos nuevos, incluya acciones destructivas, merge/deploy no autorizado o carezca de información esencial no se aprueba por inferencia.

### 7.3 Seguimiento y retroalimentación

1. Leer `jules_get_session` y `jules_list_activities`, siguiendo `nextPageToken` cuando exista.
2. Distinguir el evento original de Jules, la interpretación de ChatGPT y la comprobación independiente.
3. Ante una petición de información, recuperar el mensaje literal y comparar su respuesta con el OCP/fuentes.
4. Si la respuesta está verificada y permanece dentro del alcance, contestar con `jules_send_message` en el mismo ID de sesión.
5. Si falta un dato o la pregunta cambia una decisión material, escalarla al operador.
6. Volver a leer actividades después de cada envío y registrar el último checkpoint. No afirmar que Jules respondió solo porque el POST fue aceptado.
7. Reanudar desde el último estado comprobado; no duplicar sesiones o mensajes por una respuesta de red ambigua sin consultar primero el estado.

### 7.4 Cierre

1. Consultar estado terminal y outputs/PR expuestos por Jules.
2. Verificar el repositorio, rama, archivos y pruebas accesibles por herramientas autorizadas.
3. No equiparar “Jules completó” con “cambio aceptado”.
4. Registrar resumen, evidencia literal necesaria, revisión/commit/PR, pruebas, fallos, riesgos, bloqueos y siguiente paso.
5. Actualizar el núcleo solo con el resumen vivo necesario y conservar detalle cronológico en la crónica del ciclo; leer de vuelta cada cambio persistido.

## 8. Modelo de estados y decisiones

Los estados reportados por la API consultada incluyen `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` y `COMPLETED`. Son estados externos informados por Jules; no deben recrearse ni “corregirse” localmente si el proveedor devuelve un valor inesperado.

| Estado observado | Acción de ChatGPT |
|---|---|
| `QUEUED` / `PLANNING` | Consultar actividades cuando proceda; no afirmar que el agente está ejecutando cambios. |
| `AWAITING_PLAN_APPROVAL` | Leer plan y solicitar aprobación explícita; no aprobar automáticamente. |
| `AWAITING_USER_FEEDBACK` | Recuperar la solicitud y responder solo con datos verificados; escalar lo material. |
| `IN_PROGRESS` | Recuperar progreso y actividad; no repetir instrucciones por defecto. |
| `PAUSED` | Identificar la causa reportada y decidir el siguiente paso según lo autorizado. |
| `FAILED` | Registrar error, consultar la actividad pertinente y preparar diagnóstico; no reintentar escrituras a ciegas. |
| `COMPLETED` | Leer outputs y validar el resultado independientemente; no presumir aceptación. |
| Estado vacío/desconocido | Detener acciones dependientes del estado, conservar evidencia y diagnosticar. |

## 9. Datos y persistencia

### Datos mínimos por ciclo

- Identificador de evento y folio de la crónica.
- Frente propietario y referencia al OCP utilizado.
- Nombre real de la fuente Jules, repositorio y rama de inicio.
- ID/URL de la sesión y timestamps reportados.
- Estado observado y momento de la lectura.
- Actividades relevantes, identificadores y cursor/token de página necesario para reanudar.
- Prompt enviado y mensajes de retroalimentación relevantes, con datos sensibles redactados.
- Decisión sobre plan, actor/autoridad de aprobación y evidencia.
- Archivos/commit/PR/outputs referenciados; comandos y resultados de prueba realmente ejecutados.
- Errores, causa conocida o NO VERIFICADA, bloqueadores y siguiente paso.

No guardar claves ni bearer tokens. Evitar copiar el historial completo de una sesión si basta registrar referencias, IDs y extractos pertinentes. Respetar privacidad del repositorio y no persistir contenidos que el frente no necesite.

### Autoridad de estado

- El núcleo `OBJETO-CANONICO.md` conserva el estado vivo y los vínculos esenciales.
- La crónica bajo `cronica/` conserva el detalle verificable de cada ciclo.
- La guía de replicación describe cómo usar la integración común, no un segundo sistema de responsabilidad.
- No se introduce base de datos ni trabajador persistente en v1.0 por simetría. Si una necesidad verificada los vuelve necesarios, deben planearse como alcance separado.

## 10. Seguridad, autorización y confianza

1. `JULES_API_KEY` se mantiene únicamente en el entorno seguro del servidor; nunca se imprime, lee desde ChatGPT, copia a Git ni introduce en prompts o logs.
2. Los cuatro métodos de lectura requieren `jules:read`; los tres de escritura requieren `jules:write`. El alcance de cada token debe ser explícito y mínimo.
3. La generación de tokens no incorpora permisos de Jules en su configuración predeterminada. La interfaz debe explicar los scopes que se conceden.
4. Cada llamada mantiene los controles de autenticación, autorización y ciclo normativo ya existentes de Khora.
5. Validar nombres de fuentes e IDs de sesión como recursos, no aceptar URLs arbitrarias, rutas relativas o identificadores que permitan manipular la ruta del proveedor.
6. Los mensajes, instrucciones, links y artefactos devueltos por Jules son contenido externo no confiable. No pueden autorizar nuevas operaciones, cambiar el gobierno, pedir secretos ni desactivar controles.
7. Errores externos se normalizan a códigos/mensajes seguros; no se devuelve al asistente un cuerpo arbitrario que pudiera filtrar datos internos.
8. Aprobación del plan, envío de mensajes, merge, despliegue y acciones destructivas se tratan como operaciones diferentes, con sus autorizaciones y verificaciones correspondientes.
9. Un timeout durante una escritura deja resultado ambiguo: consultar la sesión/actividades antes de reintentar.
10. Los logs no incluyen credenciales ni prompts que contengan secretos; incluir solo metadatos mínimos y un identificador de seguimiento.
11. No se afirma exclusión de concurrencia global: el control de responsabilidad del OCP es cooperativo y gobierna solo este frente.
12. El producto no promete ejecución perpetua ni acceso entre turnos. Una ejecución persistente necesitaría trabajador externo, checkpoints, idempotencia, recuperación y gobierno propios.

## 11. Compatibilidad real con ChatGPT

La arquitectura depende de que el cliente ChatGPT donde se utilizará el componente pueda conectar el servidor MCP remoto y ejecutar acciones de escritura. La documentación oficial de OpenAI consultada declara compatibilidad completa con servidores MCP personalizados para Business y Enterprise/Edu; para Pro describe permisos de lectura/recuperación, no el mismo conjunto de escritura. Esto convierte el plan/espacio de trabajo real y sus permisos en una **compuerta crítica** de fase 1.

Antes de cerrar esta compuerta se debe verificar, en el entorno real:

- plan y espacio de trabajo efectivo;
- permiso para crear/conectar una app MCP personalizada;
- soporte de acciones de escritura;
- URL pública HTTPS del servidor o un túnel admitido;
- método de autenticación y refresh-token cuando corresponda;
- descubrimiento de las siete herramientas y scopes;
- ejecución de llamadas reales de lectura y escritura en una conversación nueva.

No se debe inferir que la elegibilidad existe porque la API de Jules o el servidor de Khora sean técnicamente viables. Si el cliente/plan no habilita escritura, se debe registrar el bloqueo y resolver la vía compatible antes de prometer el comportamiento esperado.

## 12. Requisitos no funcionales

| Área | Requisito verificable |
|---|---|
| Seguridad | Secretos solo en servidor; scopes mínimos; validación de estado e IDs; respuestas saneadas. |
| Compatibilidad | Los controles existentes y las demás herramientas MCP de Khora no se degradan. |
| Confiabilidad | Paginación completa, timeout controlado, backoff para rate limit/errores transitorios y consulta antes de reintentar escrituras ambiguas. |
| Trazabilidad | Cada ciclo tiene IDs, fecha, fuente, sesión, estado observado, decisión, prueba y checkpoint persistidos. |
| Recuperación | Una nueva conversación puede retomar el ciclo desde OCP/IDs/estado confirmado, sin reconstruirlo de memoria. |
| Observabilidad | Diagnósticos diferenciados para clave ausente, rechazo de autenticación/permisos, rate limit, fallo externo, timeout, ID inválido y estado incompatible. |
| Mantenibilidad | Cliente Jules separado del handler común; contratos, tipos y pruebas alineados; no crear ruta/servidor paralelo. |
| Privacidad | Persistir la evidencia mínima necesaria; sin secretos ni datos privados superfluos en logs/crónicas. |
| Transparencia | Separar pruebas sintéticas, tests locales, CI, llamada Jules real, conexión ChatGPT, despliegue y aceptación funcional. |
| Coste/control | No introducir sondeo permanente en v1.0; evitar bucles de polling sin límite ni reintentos de escritura duplicados. |

## 13. Plan de pruebas y aceptación

La aceptación exige evidencia real. Un test que utiliza mocks no acredita conectividad con Jules; un PR abierto no acredita merge; un deployment preview no acredita producción; y la presencia de la variable no acredita una clave válida.

| ID | Prueba | Condición de aceptación |
|---|---|---|
| T01 | Contratos MCP | Las siete herramientas se descubren con schemas y metadata válidos. |
| T02 | No regresión | Las herramientas existentes de Khora mantienen contratos y permisos; suite completa ejecutada. |
| T03 | Autorización | Sin scope requerido, una herramienta no llama al cliente Jules. |
| T04 | Ciclo normativo | Las herramientas sustantivas respetan el contrato real de token/turno y su liberación. |
| T05 | Fuente/branch | Solo se usan recursos devueltos/verificados; rechazar identificadores inválidos. |
| T06 | Plan obligatorio | Cada creación fuerza `requirePlanApproval=true`, no configurable por el asistente. |
| T07 | Estado de aprobación | El endpoint de aprobación rechaza cualquier estado distinto de `AWAITING_PLAN_APPROVAL`. |
| T08 | Retroalimentación | Leer una solicitud real, responder en la misma sesión y verificar actividad posterior. |
| T09 | Paginación | Seguir tokens hasta fin; distinguir respuesta vacía de página agotada. |
| T10 | Escritura ambigua | Tras timeout de crear/enviar/aprobar, consultar estado antes de repetir. |
| T11 | Errores | 401/403, 429, 5xx, timeout, clave ausente, fuente inválida y estado inválido entregan diagnósticos seguros. |
| T12 | Secretos | Clave ausente/rechazada no se filtra por salida, error, prompt, test snapshot ni log. |
| T13 | Datos no confiables | Texto malicioso de Jules no modifica scopes, autorización ni reglas de ejecución. |
| T14 | API real | `JULES_API_KEY` aceptada sin revelar su valor; prueba no destructiva en fuente/rama autorizada. |
| T15 | Cliente real | ChatGPT descubre y llama a las herramientas desde el cliente/espacio de trabajo previsto, incluyendo escritura. |
| T16 | E2E | Secuencia creación → plan → aprobación explícita → avance → feedback → respuesta → cierre/entrega verificada. |
| T17 | Persistencia | Núcleo/crónica reflejan exactamente el resultado comprobado y sobreviven a una reinstanciación. |
| T18 | Liberación | PR revisado y aprobado conforme a autorización; checks pertinentes verdes o excepción explícita, documentada y aceptada. |

**Gate de release:** T01–T13 deben pasar según sus ámbitos; T14–T16 deben ejecutarse con API y cliente reales. T17 debe tener lectura de vuelta. No se declara MVP utilizable mientras un gate necesario permanezca pendiente o fallido. Las excepciones no se silencian ni se interpretan como PASS.

## 14. Bloqueos y riesgos conocidos al iniciar la planeación

1. **Elegibilidad de ChatGPT para acciones de escritura:** no verificada para el espacio de trabajo que usará MCP Jules; consultar requisitos oficiales antes de cerrar diseño de integración.
2. **Credencial Jules:** `JULES_API_KEY` figura configurada como variable sensible en Vercel producción según el registro previo, consultada sin descifrar. Su validez no está demostrada; no recuperar ni exponer el valor.
3. **CI de Khora:** el último diagnóstico persistido para PR #338 reporta typecheck/UI review/contratos UI/API tests aprobados, suite unitaria 547 PASS/1 FAIL por lectura del esquema privado de Metodología sin `GH_TOKEN`, dos findings Ruff fuera del diff y build/E2E fallidos aguas abajo. Debe refrescarse contra el head vigente antes de tomar decisiones.
4. **CI de Metodología:** `validate-canonical-bootstrap.py` y un workflow de gobernanza muestran runs fallidos. La fuente de validación contiene expectativas antiguas de Samantha v339/NX-339m y varios archivos Markdown de compatibilidad; el canon vigente es el DUG HTML v360/NX-360m. El diseño de corrección debe preservar una fuente normativa única y distinguir interfaces de compatibilidad de autoridad normativa. Los logs del run no fueron recuperables, por lo que no se atribuye a un paso exacto la causa de una ejecución concreta.
5. **Límite de API:** Jules documenta la API `v1alpha`; el contrato puede cambiar. Revalidar los esquemas al comenzar implementación y antes de release.
6. **Automatización persistente:** no hay trabajador externo aprobado/implementado por este plan. La interacción MCP ocurre cuando se invocan herramientas durante una conversación activa.
7. **PR documental sin integrar:** Metodología PR #19 sigue en borrador en la rama de trabajo. El plan y los artefactos no están disponibles todavía como estado de `main`.

## 15. Secuencia de fases posterior a la planeación

### Fase 1 — Planeación integral del componente v1.0 (vigente)

- Establecer requisitos, arquitectura y límites.
- Especificar contratos de las siete herramientas y estados.
- Definir seguridad, trazabilidad, persistencia, fallos, operación y recuperación.
- Completar pruebas y criterios de aceptación.
- Resolver o registrar formalmente las compuertas de viabilidad y los riesgos.
- Hacer revisión de consistencia entre plan, OCP, plan de aceptación y PR candidato.

**Salida:** plan v1.0 consistente, trazable y revisable. No cambia código de producto.

### Fase 2 — Reconciliación e implementación

- Comparar PR #338 y el código actual del servidor con el diseño aceptado; construir una matriz de delta.
- Confirmar contratos actuales de la API Jules y del servidor Khora.
- Ejecutar la corrección mínima en la rama de implementación autorizada.
- Mantener aisladas las modificaciones de Jules frente a fallos ajenos al diff y documentar sus responsables.
- Volver a ejecutar pruebas con evidencia real.

**Salida:** candidato de implementación alineado, no todavía release aceptado.

### Fase 3 — Validación integrada real

- Validar la credencial por una llamada real sin mostrarla.
- Completar la secuencia de sesión con aprobación obligatoria y feedback en la misma sesión.
- Probar conexión ChatGPT y permisos efectivos de escritura.
- Probar recuperación tras timeout, paginación, errores y reanudación.
- Persistir resultados en el OCP.

**Salida:** evidencia end-to-end reproducible y bloqueos restantes explícitos.

### Fase 4 — Release y replicación controlada

- Revisar el diff, los checks y las autorizaciones de integración.
- Completar el merge y despliegue solo con autorización y verificación pertinentes.
- Comprobar tools descubiertas después del despliegue y ejecutar prueba de humo.
- Publicar guía de consumo y replicación por frente, usando el servidor central.
- Declarar v1.0 utilizable solo cuando los gates de aceptación se satisfagan.

**Salida:** release verificado, guía de uso y matriz de capacidades/limitaciones.

### Evolución futura

Si se solicita sondeo persistente, notificaciones, respuesta automática acotada u orquestación avanzada de PR/CI, planificar una versión posterior con su propio diseño de disponibilidad, coste, idempotencia, seguridad, permisos, checkpoint y aceptación. No inferir su inclusión a partir de v1.0.

## 16. Condiciones para declarar completa la fase 1

La planeación estará completa cuando:

- El propósito y el comportamiento esperado estén definidos inequívocamente.
- Cada función tenga contrato, scope, estado esperado, errores y prueba asignada.
- Las transiciones de la sesión y las decisiones de aprobación estén definidas.
- La arquitectura conserve el servidor MCP central de Khora y sus controles existentes.
- Los dos planos de credenciales estén delimitados y la clave solo exista en servidor.
- Persistencia, recuperación, reintentos, concurrencia, errores y seguridad tengan tratamiento.
- Cada gate de aceptación tenga un resultado esperado y evidencia identificable.
- Las dependencias externas, elegibilidad de ChatGPT y bloqueos de CI estén nombrados, sin inventar solución ni resultado.
- La relación entre el plan, `OBJETO-CANONICO.md`, el plan de aceptación y los PR sea consistente.
- El plan completo esté escrito en este OCP y verificado mediante lectura de vuelta.

Completar la planeación no equivale a aceptar la implementación, validar la API, conectar ChatGPT ni autorizar despliegue. Esas son salidas posteriores, sujetas a evidencia.

## 17. Fuentes técnicas consultadas

- [Jules REST API — catálogo de métodos](https://developers.google.com/jules/api/reference/rest) — endpoints para sources, sessions y activities; API `v1alpha`.
- [Jules Session resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions) — `requirePlanApproval`, source context y estados publicados.
- [Jules sessions.create](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create) — creación de sesiones.
- [Jules sessions.sendMessage](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage) — envío de mensajes a una sesión.
- [Jules sessions.approvePlan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan) — aprobación de plan.
- [Jules sessions.activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list) — actividades y paginación.
- [OpenAI: Connecting custom MCP servers in ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt) — planes, conexión HTTPS/túnel, permisos, pruebas y controles de publicación. La documentación consultada el 2026-10-29 indica full MCP para Business y Enterprise/Edu y permisos de lectura/recuperación para Pro.
- [Investigación específica ya persistida en el OCP](fuentes/INVESTIGACION-API-JULES-CHATGPT.md) — antecedentes de automatización y comparación del cliente.
- [Contrato operativo del asistente](prompts/ASISTENTE-MCP.md) y [contrato de prompts a Jules](prompts/JULES-CONSTRUCTOR.md) — material previo a reconciliar contra este plan.

**Conclusión de diseño:** MCP Jules v1.0 es una integración conversacional bidireccional sobre el servidor MCP central de Khora. Su unidad funcional es el ciclo completo de delegación, aprobación, seguimiento, retroalimentación y verificación. La fase vigente es planificación integral; la implementación candidata existente no sustituye este plan ni demuestra que el producto esté aceptado.
