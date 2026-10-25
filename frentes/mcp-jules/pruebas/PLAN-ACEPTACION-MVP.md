# Plan de aceptación · MCP Jules

## A. Herramientas y contratos

El catálogo mínimo debe incluir exactamente estas herramientas nuevas:

| Herramienta | Scope | Criterio observable |
|---|---|---|
| `jules_list_sources` | `jules:read` | Enumera fuentes conectadas; admite los parámetros de paginación documentados. |
| `jules_list_sessions` | `jules:read` | Enumera sesiones con límite y token de página validados. |
| `jules_get_session` | `jules:read` | Devuelve el detalle de una sesión específica. |
| `jules_list_activities` | `jules:read` | Recupera actividades, incluidos mensajes del agente y el plan, con paginación/cursor. |
| `jules_create_session` | `jules:write` | Envía prompt, fuente, rama, modo de PR y fuerza `requirePlanApproval=true`. |
| `jules_send_message` | `jules:write` | Envía una respuesta a una sesión existente. No promete respuesta inmediata. |
| `jules_approve_plan` | `jules:write` | Aprueba el plan de la sesión especificada; requiere invocación explícita. |

Todas las herramientas sustantivas conservan el envoltorio/ciclo normativo de Khora y los diagnósticos existentes.

## B. Pruebas automáticas

1. Esquema correcto de cada herramienta y coincidencia entre contrato Zod, lista MCP y documento de catálogo.
2. Lecturas bloqueadas para token sin `jules:read`; escrituras bloqueadas para token sin `jules:write`.
3. `jules:read` no concede herramientas ajenas a Jules ni puede invocar métodos de escritura; `jules:write` no implica automáticamente otros scopes.
4. `jules_create_session` envía `requirePlanApproval: true` aunque el cliente no proporcione ese campo. La herramienta no debe permitir que el cliente lo desactive.
5. Validación de límite/paginación y normalización segura de IDs de sesión.
6. `jules_list_activities` reconoce `agentMessaged`, `userMessaged`, `planGenerated`, `planApproved`, `progressUpdated`, `sessionCompleted` y `sessionFailed`.
7. Error de API, respuesta no JSON, 401/403, 429 y 5xx no exponen API keys ni declaran éxito falso; aplicar los reintentos acotados existentes y respetar límites.
8. Rechazar entradas vacías/abusivamente largas en prompt/mensaje e ID de sesión.
9. Prueba del ciclo normativo: sin token de turno/ciclo válido las herramientas sustantivas no alcanzan el cliente Jules.
10. Pruebas de paginación/cursor no omiten ni duplican actividades al recorrer páginas y reanudar el sondeo.
11. Pruebas actuales del servidor, OAuth, metadatos de scopes y emisión de Bearer manual siguen pasando.
12. Comprobación estática del diff y del historial no detecta secreto ni contenido real de credenciales.

## C. Prueba integrada autorizada

Con `JULES_API_KEY` configurada en el entorno autorizado, realizar secuencia con un repositorio de prueba conectado a Jules:

1. Listar fuentes y elegir un repositorio autorizado.
2. Crear una sesión con prompt inocuo y plan approval requerido.
3. Leer la sesión hasta que aparezca el plan o una actividad de plan.
4. Confirmar el plan por la acción explícita del operador.
5. Leer actividades hasta obtener un mensaje de Jules o un estado terminal.
6. Si Jules solicita información, enviar una respuesta mediante `jules_send_message`.
7. Volver a consultar actividades y verificar la secuencia; guardar únicamente IDs, timestamps, estado y contenido de prueba no sensible.
8. Registrar resultado, entorno, errores, revisión de código y limitaciones. No inferir éxito de la respuesta vacía de `sendMessage`.

## D. Aceptación de sondeo persistente (fuera del MVP directo)

- Un trabajo programado recupera actividades nuevas de sesiones activas.
- Guarda cursor/checkpoint durable por sesión y la última actividad procesada.
- Idempotencia: repetir una ejecución no duplica alertas ni mensajes.
- Maneja paginación, 429, timeout, caída y reinicio.
- No envía respuesta automáticamente a planes, permisos, seguridad, arquitectura, destrucción, merges ni datos ambiguos.
- Tiene cadencia, tope de concurrencia, backoff, rotación y revocación de credencial, logs saneados y una forma de detenerlo.
- El despliegue real de la tarea queda verificado por evidencia del proveedor.

## E. Estados de aceptación

- **DISEÑO:** contrato y pruebas definidos.
- **CÓDIGO:** implementación en rama/PR.
- **PRUEBAS AUTOMÁTICAS:** únicamente tras output real.
- **MERGE:** únicamente tras lectura de estado real del PR.
- **DESPLEGADO:** requiere evidencia de despliegue.
- **CREDENCIAL VALIDADA:** una llamada real sin exponer la key.
- **CHATGPT CONECTADO:** llamada a herramientas desde el cliente real.
- **MVP UTILIZABLE:** todos los hitos anteriores que correspondan han quedado verificados; un PR abierto no alcanza este estado.

