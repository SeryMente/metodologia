# C-MCP-JULES-005 · restauración del núcleo OCP y verificación de la punta actual

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-7B3D1A96.  
**Sesión del frente:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** `frentes/mcp-jules/`.  
**PR documental:** [SeryMente/metodologia #18](https://github.com/SeryMente/metodologia/pull/18).  
**PR de implementación:** [SeryMente/khora #336](https://github.com/SeryMente/khora/pull/336).

## Evento y reparación documental

Durante una actualización se detectó que `OBJETO-CANONICO.md` había quedado reducido a una sola línea; la lectura de vuelta impidió tratar el OCP como íntegro. Se recuperó el contenido completo desde el commit inicial `d0cfc390bd8487605934b635776b2e42c9fa67c2`, donde se verificó el blob histórico `7a651857127c061f659f8976ae4cd0042c787d6a` y una longitud de 14 906 caracteres. Se restauró sobre la punta de la rama, se incorporaron el estado vivo y enlaces de crónica actuales, y la lectura posterior confirmó un núcleo de 17 062 caracteres / 165 líneas, versión documental v0.4.0. La recuperación fue posible mediante el historial de Git; no se recreó desde memoria.

Se actualizó `README.md` para enlazar C-MCP-JULES-003 y C-MCP-JULES-004 y mostrar explícitamente que el despliegue/conexión no están verificados.

## Estado de código y CI

- Rama actual de Khora al iniciar esta comprobación: `feat/mcp-jules-tools-20261025`, SHA `e57118003921a5dfca76ee8fe4e39ea13daec73b`.
- La ejecución de CI del commit anterior `6b59c33198397c89739dd358c6faa659d1e2ff9c` terminó en PASS tras corregir las expectativas de dos pruebas: el número esperado de llamadas pasó de 23 a 25 por dos lecturas de estado de sesión, y el test de aprobación verifica la denegación y ausencia de llamada de escritura sin fijar un mensaje interno demasiado específico.
- G-4 del commit anterior también pasó. UI Quality, `khora-ok` y CI se iniciaron nuevamente para el commit `e57118003921a5dfca76ee8fe4e39ea13daec73b` después de hacer visible la salida de arranque del servidor Playwright; en el momento de guardar esta crónica siguen en ejecución o pendientes. No atribuir el PASS de la revisión anterior a la punta nueva.
- En la ejecución UI anterior, Playwright descargó los navegadores y luego informó que el proceso `webServer` terminó con código 1. Su salida de compilación no estaba visible; se configuró `stdout: "pipe"` y `stderr: "pipe"` para que el siguiente intento permita diagnosticar el error real. La prueba de UI sigue NO VERIFICADA.
- Los validadores del PR Metacanon siguen concluyendo FAIL de forma inmediata, sin steps/runner/logs recuperables; no hay evidencia suficiente para atribuir ese resultado a una aserción concreta. La causa permanece NO VERIFICADA.

## Estado operativo

- Las siete herramientas Jules y los dos scopes específicos están en la rama del PR #336.
- No se ha fusionado ninguno de los PR.
- Vercel informa `build-rate-limit`; la URL productiva no acredita que esta versión esté desplegada.
- Se observó que la variable sensible `JULES_API_KEY` está configurada para production con descifrado desactivado; su valor no se leyó, y su presencia no demuestra que sea válida.
- No se ha ejecutado una llamada real autenticada a Jules ni un intercambio desde ChatGPT.
- El trabajador persistente de sondeo no forma parte de la implementación candidata; está documentado como la siguiente extensión.

## Siguiente paso

Consultar resultados del commit `e57118003921a5dfca76ee8fe4e39ea13daec73b`. Si UI Quality falla, utilizar los nuevos logs de arranque para corregir la causa demostrada, no adivinarla. Mantener abiertos ambos PR hasta verificar los gates de aceptación. No declarar el MVP remoto utilizable antes de que una conexión real complete listar fuente, crear sesión con plan pendiente, leer plan/actividades, aprobar explícitamente, recibir feedback, responder en la misma sesión y volver a consultar actividades.
