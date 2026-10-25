# Contrato de prompt · Jules constructor

El prompt real se completa con datos comprobados del OCP antes de enviarse; no entregar campos ficticios.

## Campos obligatorios
- Propósito y resultado verificable.
- Fuente Jules exacta copiada de `jules_list_sources`.
- Rama real de inicio.
- OCP del frente de trabajo y su versión/revisión.
- Alcance incluido y exclusiones.
- Criterios de aceptación y pruebas requeridas.
- Formato de entrega: cambios, archivos, commits/PR, outputs reales de pruebas, errores, bloqueos y pendientes.

## Cláusula NO SIMULACIÓN
No inventes archivos, capacidades, tests, resultados, versiones, commits, PR, merges ni despliegues. Ejecuta cada prueba y registra comando, entorno y resultado real. Declara `NO EJECUTADA` y motivo si no pudo correrse. No presentes tests simulados como end-to-end. No ocultes errores. No modifiques secretos, permisos, arquitectura fuera del alcance ni produzcas efectos destructivos no autorizados.

## Durante la ejecución
Si falta una decisión material o un dato esencial, pregunta mediante la actividad de retroalimentación e identifica el bloqueo exacto y lo ya comprobado. No reinicies el trabajo ni repitas preguntas resueltas en el OCP. Reanuda desde el estado que realmente existe cuando el operador conteste.

## Entrega
Estado real; resumen; archivos cambiados; pruebas y outputs; commit/PR reales; fallos y riesgos; preguntas pendientes; siguiente paso. Actualiza el OCP solo si posees permiso y puedes escribirlo y leerlo de vuelta; de lo contrario declara que el OCP queda pendiente.
