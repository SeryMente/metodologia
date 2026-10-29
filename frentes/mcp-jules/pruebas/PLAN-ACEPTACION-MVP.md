# Plan de aceptación · MVP MCP Jules

> Este documento define pruebas de aceptación para la fase de implementación y release. La fase vigente es Fase 1 — planeación integral del componente v1.0, definida en [PLAN-INTEGRAL-MCP-JULES-v1.0.md](../PLAN-INTEGRAL-MCP-JULES-v1.0.md). Las etiquetas heredadas de código/tests reflejan el candidato previo y no constituyen evidencia de que un gate esté actualmente aprobado; refrescar contra los heads vigentes.

| Capacidad | Resultado exigido | Estado |
|---|---|---|
| Fuentes | `jules_list_sources` devuelve fuentes reales y token de paginación | Código candidato; API real pendiente |
| Sesiones | Listar y consultar sesiones mediante IDs validados | Código candidato; API real pendiente |
| Actividades | Leer mensajes, planes, progreso, fallo/completado y token de página | Código candidato; tests pendientes |
| Crear | `jules_create_session` recibe fuente, rama, prompt y fuerza `requirePlanApproval=true` | Código candidato; API real pendiente |
| Responder | Mensaje a la misma sesión, en estado permitido, con indicación de reconsulta | Código candidato; API real pendiente |
| Aprobar | Rechaza estado distinto a `AWAITING_PLAN_APPROVAL`; aprobar explícitamente | Test añadido; ejecución pendiente |
| Scopes | Lectura y escritura separadas; sin scope no hay llamada al cliente Jules | Test añadido; ejecución pendiente |
| Ciclo normativo | Cada herramienta sustantiva conserva `_norm_turn_token`, modo y versión | Contrato test actualizado; ejecución pendiente |
| Errores | Sin API key, 401/403, 429, 5xx, timeout y entrada inválida no revelan claves/cuerpos arbitrarios | Revisión/test pendiente |
| ChatGPT | Conexión real y llamadas permitidas bajo el plan de la cuenta | No verificado |
| Automatización continua | Trabajador externo con checkpoint, deduplicación, reinicio, backoff y apagado | Fuera del MVP directo |

## Secuencia integrada de aceptación
1. Configurar `JULES_API_KEY` en el entorno autorizado del servidor, sin copiar su valor a Git.
2. Listar fuentes reales; elegir una fuente y rama de prueba autorizada.
3. Crear sesión con prompt no destructivo; confirmar que la respuesta registra `requirePlanApproval=true`.
4. Consultar estado/actividades hasta que el plan aparezca.
5. Revisar el plan y aprobarlo mediante acción explícita del operador.
6. Consultar actividades después de la aprobación.
7. Cuando Jules solicite información, contestar mediante `jules_send_message` y reconsultar actividades.
8. Guardar IDs, tiempos, estados y resultados de prueba no sensibles; no incluir credenciales ni datos privados del repositorio en evidencias.

## Estados
- **CÓDIGO:** está en rama.
- **TESTS:** solo aprobado tras output real del test runner.
- **PR/CI:** estado extraído del PR y de los checks, no inferido.
- **MERGE:** requiere comprobación de estado de PR y autorización aplicable.
- **DESPLIEGUE:** requiere evidencia del proveedor.
- **API KEY VALIDADA:** requiere una llamada real aceptada, sin exponer el valor.
- **CHATGPT CONECTADO:** requiere una llamada desde el cliente final.
- **MVP UTILIZABLE:** todos los criterios requeridos anteriormente están verificablemente satisfechos.
