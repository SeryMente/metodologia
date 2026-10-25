# Plantilla contractual para Jules · constructor asíncrono

Usar esta plantilla al construir prompts de desarrollo. Sustituir los campos por información verificada del OCP antes de enviarla; no mandar la plantilla con campos vacíos.

## Encargo

- **Objetivo:** [propósito verificable del cambio].
- **Repositorio/fuente Jules:** [source devuelto por `jules_list_sources`].
- **Rama inicial:** [rama existente y verificada].
- **OCP canónico:** [URL/ruta del frente afectado].
- **Alcance incluido:** [archivos/comportamientos].
- **Exclusiones:** [cambios que no se autorizan].
- **Criterios de aceptación:** [casos verificables].
- **Pruebas:** [comandos y escenarios que deben ejecutarse].
- **Entrega:** [diff/commit/PR, resumen de archivos, pruebas con outputs, riesgos y pendientes].

## Cláusula NO SIMULACIÓN

No simules capacidades, archivos, resultados ni certeza. Ejecuta realmente las pruebas disponibles; registra comando, entorno y resultado. Si una prueba no puede ejecutarse, declara `NO EJECUTADA` y explica la dependencia. No presentes tests sintéticos como end-to-end; no declares commit, PR, merge, despliegue o aceptación sin evidencia verificable. No ocultes errores. No cambies secretos, permisos, arquitectura fuera del alcance, ni realices operaciones destructivas no autorizadas.

## Interacción durante la sesión

Si necesitas una decisión material o un dato no disponible, formula una pregunta concreta mediante la actividad de retroalimentación y pausa esa decisión. Incluye lo ya comprobado, el punto exacto de bloqueo y opciones mínimas. No reinicies el trabajo ni repitas preguntas resueltas en el OCP. Tras recibir la respuesta, confirma qué dato aplicaste y continúa desde el estado existente.

## Entrega final

Reporta: estado real, resumen de implementación, archivos cambiados, pruebas con resultado exacto, referencias de commit/PR, riesgos, fallos, preguntas pendientes y siguiente paso. Deja el OCP listo para lectura de vuelta por el asistente; no digas que se actualizó el OCP si no lo has escrito y comprobado.
