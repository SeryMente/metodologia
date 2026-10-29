# Pendientes · Ámbito Tareas v1.0

**Estado:** INCUBACIÓN ABIERTA. Ninguna propuesta de este archivo modifica la norma canónica.  
**Fuente normativa vigente:** DUG v359 · NX-359m; Metacanon 1.24; GOW 2.8; taxonomía 1.3.  
**Ciclo vigente:** C-TAREAS-ESTANDAR-MINIMO-02 · C-20261029-4F7A2C91.

## Secuencia mínima propuesta

1. **TAR-01 · propósito y fronteras.** Determinar qué problema debe resolver Tareas y qué queda fuera, sin suponer que el ámbito tenga que existir por simetría.
2. **TAR-02 · posición conceptual.** Evaluar si Tareas debe incorporarse a la taxonomía canónica. No modificar DUG/GOW sin propuesta concreta y autorización expresa.
3. **TAR-03 · contrato mínimo de tarea.** Revisar [estándar común v0.2](ESTANDAR-COMUN-DE-TAREA-v0.2.md): identidad, enunciado, referencia al origen y estado; referencia de ámbito solo si el contexto no basta.
4. **TAR-04 · estados mínimos.** Comprobar si pendiente, en curso, completada y cancelada bastan. No añadir estados extra por anticipación.
5. **TAR-05 · persistencia.** No elegir fuente de estado ni crear registro hasta que casos autorizados demuestren la necesidad.
6. **TAR-06 · instrucciones.** Mantener las instrucciones de ámbito e IPZ candidatas alineadas con el núcleo mínimo; no presumir que el campo nativo IPZ esté instalado.
7. **TAR-07 · prueba acotada.** Validar el modelo con dos o tres casos autorizados de distinta naturaleza y registrar qué hizo falta realmente.
8. **TAR-08 · ratificación.** Solo después de las pruebas, preparar una versión aceptable y, si corresponde, una propuesta normativa separada.

## Ciclo actual · C-TAREAS-ESTANDAR-MINIMO-02

Se preparó el [estándar mínimo v0.2](ESTANDAR-COMUN-DE-TAREA-v0.2.md) y el [esquema JSON mínimo v0.2](ESQUEMA-TAREA-COMUN-v0.2.json). La revisión retira de la propuesta vigente campos y estados incorporados por previsión en v0.1: resultado esperado y aceptación como campos separados, siguiente acción, responsable, prioridad, fecha límite, relaciones, bloqueos, evidencia por tarea y marcas temporales.

La versión v0.1 se conserva como antecedente histórico; v0.2 es la propuesta actual. El JSON v0.2 pasó `JSON.parse`; no se ejecutó un validador completo de JSON Schema 2020-12. No se ha hecho una prueba end-to-end ni se ha elegido una plataforma o registro canónico.

## Estado vigente

- Tareas sigue sin canonizar en el DUG/GOW.
- El núcleo de tarea propuesto es `task_id`, `statement`, `origin_ref` y `status`; `scope_ref` es condicional.
- No hay registro de tareas en producción ni integración externa implementada.
- El archivo candidato IPZ del repositorio puede leerse, pero el campo nativo de Instrucciones Personalizadas no se ha escrito ni verificado.
- El diseño debe permanecer subordinado a la instrucción literal y a la necesidad demostrada. Los campos omitidos se pueden reconsiderar únicamente si un caso real o una instrucción expresa lo justifica.

## Criterio de registro por ciclo

Registrar instrucción literal, decisión tomada, cambios efectuados, referencias verificadas, límites de prueba y siguiente decisión abierta. La interpretación y la síntesis deben permanecer diferenciadas de la instrucción verbatim.
