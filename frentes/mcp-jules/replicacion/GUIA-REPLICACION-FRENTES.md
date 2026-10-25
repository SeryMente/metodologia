# Replicación del MCP Jules en otros frentes

**Versión:** 0.1.0 · **Evento de origen:** C-MCP-JULES-002 · **Folio de ciclo:** C-20261025-4A91D70C

## Regla de arquitectura

El servidor MCP Jules se implementa una sola vez dentro del servidor MCP existente de Khora. Los frentes de trabajo consumen ese servicio; no deben crear su propio servidor duplicado, sus propias API keys ni controles de acceso paralelos. Cada frente conserva exclusivamente su OCP, estado de desarrollo, autorización, conversaciones y evidencia local.

## Incorporación a un frente existente

1. Leer el OCP, su control de responsabilidad y el gobierno vigente de Metacanon. No copiar el estado, el folio, la titularidad ni los secretos de este OCP al frente destinatario.
2. Verificar que el servidor MCP de Khora esté desplegado y que el cliente ChatGPT pueda conectarse. Hasta comprobarlo, el acceso remoto es **NO VERIFICADO** y no se debe simular una llamada.
3. Conceder explícitamente el scope mínimo: `jules:read` para consultar fuentes/sesiones/actividades y/o `jules:write` para crear sesiones, enviar mensajes y aprobar planes. Las herramientas sustantivas además exigen el ciclo normativo `norm:turn`. No habilitar permisos de escritura solo por conveniencia.
4. Consultar `jules_list_sources`, elegir una fuente devuelta realmente por Jules, comprobar la rama y construir un prompt autosuficiente con el propósito/aceptación del OCP destinatario.
5. Invocar `jules_create_session`. La herramienta fuerza `requirePlanApproval=true`; recuperar el plan con `jules_list_activities` y `jules_get_session`. Revisar y aprobar explícitamente el plan antes de ejecución.
6. Revisar actividades y estado; ante `AWAITING_USER_FEEDBACK`, leer la pregunta real. Responder con `jules_send_message` usando el ID de la misma sesión, y volver a consultar actividades para confirmar qué contestó Jules.
7. Registrar en el OCP destinatario el ID/nombre de sesión, URL real si está presente, última actividad procesada, estado, prompt/respuesta pertinente, resultado verificable, pruebas y pendiente. Los originales de la conversación se conservan conforme a Metacanon §28.
8. Distinguir el resultado que Jules declara del resultado que el asistente verifica por herramientas. Una respuesta de envío aceptada no demuestra que Jules haya respondido; un plan, commit o PR declarado tampoco prueba merge, tests o despliegue.
9. En el cierre del ciclo, actualizar la cronología y el estado vivo del frente destinatario; leer de vuelta los archivos guardados y mantener una sola versión del estado vigente.

## Permisos y efectos

| Acción | Permiso de negocio | Efecto |
|---|---|---|
| Listar fuentes/sesiones, consultar sesión y actividades | `jules:read` | Lectura de datos de Jules |
| Crear sesión y mensaje | `jules:write` | Puede iniciar o continuar trabajo asíncrono en el repositorio conectado |
| Aprobar plan | `jules:write` | Habilita a Jules para comenzar la ejecución del plan; revisión explícita antes de aprobar |
| Sondeo continuo | Worker externo con credencial del servicio | Crea actividad de servicio persistente; requiere diseño, límites, deduplicación, observabilidad y mecanismo de parada |

Los scopes de negocio no eliminan el control normativo de Khora: una llamada sustantiva debe pasar por `norm:turn`. La credencial `JULES_API_KEY` vive solo en el entorno/bóveda autorizada del servidor; nunca se añade al OCP, a variables de cliente, prompts, commits o registros.

## Automatización fuera de ChatGPT

La capa de herramientas permite comunicación bajo demanda. Para mantener seguimiento cuando no hay un turno activo, instalar un trabajador programado después de aprobar y probar ese componente: consulta páginas de actividades de sesiones activas, guarda checkpoints, deduplica IDs de actividad, aplica backoff y detiene respuestas de riesgo. La API Jules consultada no documenta un webhook de actividad; no asumir notificación push oficial. Las respuestas automáticas solo deberían utilizarse para datos factuales explícitos de la fuente verificada y autorizaciones ya concedidas; no autoaprobar planes ni contestar preguntas de arquitectura, seguridad, permisos, operaciones destructivas, merge o despliegue.

## Prueba de adopción por frente

Antes de declarar un frente habilitado:

- [ ] El servidor y la conexión desde ChatGPT responden realmente.
- [ ] Un token sin `jules:read` no puede listar actividades, y uno sin `jules:write` no puede crear, enviar ni aprobar.
- [ ] Se consultó la fuente/repo y la rama correctos.
- [ ] La sesión nueva exige aprobación del plan.
- [ ] Se leyó una actividad `agentMessaged` o equivalente y se respondió en la misma sesión.
- [ ] Se consultaron de nuevo las actividades y se registró el resultado.
- [ ] El OCP y el control del frente destinatario conservan titularidad independiente y lectura de vuelta.
- [ ] No hay secretos en repositorio ni evidencia.

La replicación significa reutilizar una interfaz remota común y conservar estado por OCP, no copiar el servidor o las credenciales a todos los repositorios.
