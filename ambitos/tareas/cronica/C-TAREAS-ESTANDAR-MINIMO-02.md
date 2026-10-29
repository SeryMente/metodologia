# Crónica · C-TAREAS-ESTANDAR-MINIMO-02

**Fecha:** 2026-10-29  
**Ciclo:** C-20261029-4F7A2C91  
**Sesión activa de Tareas:** SES-20261028-TA6F31C9 · generación 1  
**Estado:** CANDIDATO MÍNIMO v0.2 PERSISTIDO Y RELEÍDO; NO CANONIZADO.

## 1. Instrucción literal y alcance

El operador instruyó reducir los diseños de carácter arbitrario a su mínima expresión, identificar y retirar elementos prescindibles del diseño inicial, y asegurar que la descripción semántica de lo realizado corresponda a las instrucciones verbatim: “No más, pero tampoco menos”.

La instrucción se conserva completa en el [diálogo JSONL](conversaciones/C-TAREAS-ESTANDAR-MINIMO-02-dialogo.jsonl). Este ciclo modifica propuestas del ámbito Tareas; no modifica el DUG/GOW y no canoniza ni la existencia de Tareas ni el estándar común.

## 2. Base metodológica

Se releyó el DUG canónico desde `main`: v359 · NX-359m, Metacanon 1.24, GOW 2.8, taxonomía 1.3; blob `b2ff2845a5a99dc4ce3cafafc4f8e43607d48145`. Metacanon exige cero bloating, conservación literal de instrucciones con procedencia y separación entre el original y su interpretación normalizada.

## 3. Cambios realizados

Se creó [Estándar común de tarea v0.2](ESTANDAR-COMUN-DE-TAREA-v0.2.md) y [esquema JSON v0.2](ESQUEMA-TAREA-COMUN-v0.2.json). El núcleo candidato se reduce a:
- `task_id`: identidad estable cuando la tarea se persiste.
- `statement`: enunciado breve y fiel.
- `origin_ref`: referencia recuperable a la fuente original.
- `status`: pendiente, en curso, completada o cancelada.
- `scope_ref`: solo cuando el contexto no delimita claramente el ámbito.

Se sacan del núcleo separado el resultado esperado, los criterios de aceptación, la siguiente acción, responsable, prioridad, fecha límite, relaciones, bloqueos, evidencia por tarea y marcas temporales. No se prohíben para todos los casos; quedan fuera de la propuesta común hasta que una instrucción expresa o un caso real justifique incorporarlos.

La versión v0.1 se conserva intacta como antecedente histórico y queda supersedida como propuesta vigente por v0.2. Se actualizan el diseño de Tareas, las instrucciones operativas, el candidato de IPZ, el README y los pendientes para reflejar el recorte.

## 4. Verificación y límites

- Los artefactos de texto y JSON se leyeron de vuelta.
- El JSON v0.2 pasó `JSON.parse`; no se ejecutó un validador completo de JSON Schema.
- No se creó un registro de tareas, no se eligió una plataforma de persistencia y no se ejecutó una prueba end-to-end.
- El campo nativo IPZ no se modificó ni verificó; solo se actualizó el archivo candidato del repositorio.
- DUG v359/GOW 2.8 permanecen sin modificación en este ciclo. Tareas sigue en incubación y no se ha canonizado.

## 5. Criterio de continuación

Primero decidir si Tareas aporta una capacidad necesaria frente a los ámbitos y mecanismos ya existentes. Si la respuesta es afirmativa, contrastar el núcleo mínimo con casos de trabajo autorizados; no imponer de antemano un número de casos, campos o estados. Añadir una distinción solo cuando una instrucción o un caso observado demuestre que es necesaria.
