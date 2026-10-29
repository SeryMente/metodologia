# Salida final · Estándar común de tarea reutilizable v0.1

## Recomendación

Sí: conviene adoptar un **molde común de tarea** desde esta fase, con un contrato mínimo y extensiones por ámbito. No conviene imponer a cada ámbito el mismo formulario, máquina de estados o herramienta de persistencia.

## Artefactos del diseño

- [Estándar común de tarea v0.1](../../ESTANDAR-COMUN-DE-TAREA-v0.1.md)
- [Esquema JSON candidato](../../ESQUEMA-TAREA-COMUN-v0.1.json)
- [Diseño del ámbito Tareas v1.0](../../DISEÑO-TAREAS-v1.0.md)
- [Instrucciones operativas Tareas v1.0](../../INSTRUCCIONES-TAREAS-v1.0.md)
- [Pendientes del ámbito](../../PENDIENTES.md)
- [Crónica del ciclo](../../cronica/C-TAREAS-ESTANDAR-REUTILIZABLE-01.md)
- [Evidencia](../../evidencias/C-TAREAS-ESTANDAR-REUTILIZABLE-01.json)
- [Diálogo registrado](../../conversaciones/C-TAREAS-ESTANDAR-REUTILIZABLE-01-dialogo.jsonl)

## Núcleo semántico común propuesto

Una tarea debe tener identidad estable, procedencia, título accionable, alcance/contexto, estado, resultado esperado, criterios de aceptación, siguiente acción y referencias recuperables. Puede además asociar responsable, prioridad, fechas explícitas, dependencias, bloqueos, subtareas y evidencia. Lo desconocido se marca; no se inventa. Las extensiones del dominio llevan espacio de nombres y versión, y no cambian el significado de los campos comunes.

El contrato común es distinto del subsistema Tareas: el primero define el objeto reutilizable; el segundo coordinará su ciclo de vida y seguimiento. La persistencia física y los adaptadores de plataforma se decidirán por separado, según las fuentes de estado y permisos realmente disponibles.

## Estado y límite

**CANDIDATO v0.1; no canonizado ni probado en producción.** El JSON se leyó de vuelta y parsea, pero no se ha validado con un ejecutor completo de JSON Schema, ni se probó con tareas reales end-to-end. No se ha elegido la plataforma canónica de registro.

El siguiente ciclo debe probar el estándar con dos o tres casos de naturalezas distintas; después se decidirá qué campos permanecen en el núcleo y qué elementos pertenecen a perfiles de ámbito.
