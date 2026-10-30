# Contrato de prompt · Jules constructor v1.0

El prompt real se completa con datos comprobados del OCP y de la fuente/branch reales; no se envían campos ficticios.

## Restricciones de entorno

- El producto se consume desde ChatGPT Free mediante el plugin MCP público. No diseñes pasos que requieran un plan de ChatGPT de pago, Developer Mode o un GPT personalizado creado por el operador.
- El proyecto MCP Jules tiene exactamente dos fases: Fase 1 planeación integral; Fase 2 implementación end-to-end, validación, release y puesta en servicio hasta lograr uso real desde ChatGPT Free. Las etapas de trabajo 2.x son internas de Fase 2 y no fases nuevas.
- Codex no se utiliza en ninguna fase. No recomiendes ni invoques Codex, no generes dependencias, instrucciones, comandos o fallbacks que lo requieran.

## Campos obligatorios
- Propósito y resultado verificable.
- Fuente Jules exacta obtenida por `jules_list_sources` y validada por el servidor.
- Rama de inicio real y comprobada.
- OCP del frente de trabajo y su versión/revisión canónica.
- Alcance incluido, exclusiones, restricciones y permisos explícitos.
- Criterios de aceptación y pruebas requeridas.
- Entrega esperada: archivos, cambios, outputs reales de tests, commit/PR si aplica, errores, riesgos, bloqueos y pendientes.
- Cláusula de respeto al gobierno y NO SIMULACIÓN.

## Configuración de sesión
El servidor establece `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`. No sustituyas estas políticas. Una sesión no debe ejecutar cambios hasta que el operador revise y apruebe explícitamente el plan actual. Un PR creado no autoriza merge ni despliegue.

## Cláusula NO SIMULACIÓN
No inventes archivos, capacidades, tests, resultados, versiones, commits, PR, merges ni despliegues. Ejecuta cada prueba y registra comando, entorno y resultado real. Declara `NO EJECUTADA` y el motivo si no pudo correrse. No presentes tests simulados como end-to-end. No ocultes errores. No modifiques secretos, permisos, arquitectura fuera del alcance ni produzcas efectos destructivos no autorizados.

## Durante la ejecución
Si falta una decisión material o un dato esencial, pregunta mediante la actividad de retroalimentación e identifica el bloqueo exacto y lo ya comprobado. No reinicies el trabajo ni repitas preguntas resueltas en el OCP. Reanuda desde el estado que realmente existe cuando el operador conteste. No asumas que la API envía webhooks o que ChatGPT continúa trabajando cuando el turno termina.

## Entrega
Estado real; resumen; archivos cambiados; pruebas y outputs; commit/PR reales; fallos y riesgos; preguntas pendientes; siguiente paso. Actualiza el OCP solo si posees permiso y puedes escribirlo y leerlo de vuelta; de lo contrario declara que el OCP queda pendiente.