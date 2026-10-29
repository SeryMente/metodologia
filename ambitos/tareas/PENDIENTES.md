# Pendientes · Ámbito Tareas v1.0

**Estado:** INCUBACIÓN ABIERTA. Ninguna propuesta de este archivo modifica la norma canónica.  
**Evento inicial:** C-TAREAS-INICIO-01 · **Ciclo:** C-20261028-TA6F31C9.  
**Corte normativo actual:** DUG v359 · NX-359m; Metacanon 1.24; GOW 2.8; taxonomía 1.3. Tareas sigue en incubación y no se ha canonizado.

## Secuencia de trabajo propuesta

1. **TAR-01 · propósito y usuario del ámbito.** Precisar qué problema resuelve y qué resultados verificables entrega.
2. **TAR-02 · alcance y fronteras.** Aclarar su límite respecto de Gestión conversacional, Persistencia documental, los FT responsables y los sistemas de ejecución.
3. **TAR-03 · lugar taxonómico.** Proponer si Tareas será un tercer ámbito funcional transversal del nivel actual, diferenciándolo de Propósito como elemento conceptual asociado a cada FT. No insertarlo todavía en el DUG. Identificar referencias afectadas en ART-015/020, taxonomía estructurada y GOW.
4. **TAR-04 · estándar común de tarea.** Revisar [Estándar común de tarea v0.1](ESTANDAR-COMUN-DE-TAREA-v0.1.md) y su [esquema JSON](ESQUEMA-TAREA-COMUN-v0.1.json); validar qué campos son invariantes para todos los ámbitos y qué datos deben quedar como extensiones específicas.
5. **TAR-05 · identidad/modelo de tarea.** Evaluar campos mínimos, identidad estable, origen, deduplicación, sub-tareas, relaciones, propietario y evidencia.
6. **TAR-06 · ciclo de vida.** Validar estados/transiciones, prioridad, fechas explícitas, dependencias, bloqueos, reapertura y aceptación.
7. **TAR-07 · fuente de estado y materialización.** Comparar registro canónico, issues, bases de datos y otros mecanismos con base en capacidades reales. No crear registro vacío ni integrar servicios por simetría.
8. **TAR-08 · instrucciones y capas.** Elaborar instrucciones específicas y propuesta breve para IPZ; verificar límites del campo y lectura de vuelta solo si la herramienta lo permite.
9. **TAR-09 · prueba con tareas reales.** Utilizar casos autorizados y no fabricar evidencia; comprobar duplicados, cambios, bloqueos, cierre y recuperación.
10. **TAR-10 · enmienda normativa.** Presentar diff explícito para DUG/GOW y taxonomía. Requiere autorización expresa anterior a cualquier escritura normativa.
11. **TAR-11 · aceptación v1.0.** Read-back de artefactos, pruebas completadas, pendientes residuales y ratificación del operador.

## Ciclo de estándar común · C-TAREAS-ESTANDAR-REUTILIZABLE-01

Se produjo el contrato candidato [ESTANDAR-COMUN-DE-TAREA-v0.1.md](ESTANDAR-COMUN-DE-TAREA-v0.1.md) y su proyección [ESQUEMA-TAREA-COMUN-v0.1.json](ESQUEMA-TAREA-COMUN-v0.1.json). El JSON se leyó de vuelta y parsea; aún no se ejecutó un validador completo de JSON Schema, ni casos end-to-end. El estándar sigue en estado CANDIDATO v0.1, no canonizado.

## Estado inicial

- TAR-01 a TAR-11: ABIERTOS; el diseño v1.0 y el estándar común v0.1 sirven como hipótesis iniciales.
- La creación de ambitos/tareas/ es una materialización operativa provisional de un OCP de ámbito para sostener ciclos de definición, no un cambio de la taxonomía normativa.
- No hay aún registro canónico de tareas ni integración funcional verificados. El esquema JSON común v0.1 es un borrador sintácticamente válido, no un esquema de producción validado.
- La autorización normativa del ciclo asociado a Gobernanza se limitó a la taxonomía conceptual de Propósito y a la separación entre concepto e infraestructura. No autorizó a canonizar Tareas: toda enmienda que añada Tareas al DUG/GOW requiere una decisión explícita distinta.
- El campo nativo IPZ no se ha escrito ni leído de vuelta.
- No se ejecutó una prueba end-to-end con tarea real.

## Criterio para actualizar este archivo

Al cierre de cada ciclo, registrar estado, decisión, fuente revisada, commit/blob, evidencia, limitaciones y el siguiente paso. Separar los casos probados de las hipótesis.