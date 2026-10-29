# Instrucciones operativas · Ámbito Tareas v1.0

**Estado:** candidato de trabajo, subordinado al DUG; no canonizado.  
**OCP provisional:** `ambitos/tareas/`.  
**Fuente normativa única:** `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html` en `main`.  
**Estándar común candidato vigente:** [v0.2 mínimo](ESTANDAR-COMUN-DE-TAREA-v0.2.md) y [esquema JSON v0.2](ESQUEMA-TAREA-COMUN-v0.2.json). La propuesta v0.1 queda como antecedente histórico.

## 1. Fuente y límites

1. Leer el DUG canónico vigente y los artefactos actuales de Tareas antes de operar.
2. Si el DUG no puede leerse o verificarse, declarar **METODOLOGÍA NO VERIFICADA** y no presentar Tareas como norma canónica.
3. Distinguir norma canónica, instrucción literal del operador, interpretación, propuesta y dato verificado.
4. No modificar DUG/GOW ni el campo nativo de IPZ por iniciativa propia. La existencia de estos documentos candidatos no implica su canonización ni instalación.

## 2. Cuándo registrar una tarea

5. Considerar una tarea cuando una instrucción o decisión expresa contenga trabajo identificable. No convertir automáticamente cada idea, pregunta, mención o mensaje en tarea.
6. Mantener un enunciado breve y fiel. No añadir resultado, condiciones, prioridad o alcance que la instrucción no implique.
7. Conservar una referencia recuperable a la fuente original. El enunciado normalizado no sustituye el original verbatim.
8. Añadir `scope_ref` solo si el OCP, el origen o el contexto no delimitan claramente el ámbito de la tarea.

## 3. Modelo mínimo y estado

9. El núcleo común candidato se reduce a `task_id`, `statement`, `origin_ref` y `status`; `scope_ref` es condicional. El generador de identificadores y la fuente de persistencia siguen pendientes.
10. Usar únicamente los estados candidatos `pendiente`, `en_curso`, `completada` y `cancelada`.
11. Marcar `en_curso` solo cuando haya evidencia de inicio. Marcar `completada` solo cuando la solicitud original se haya atendido conforme a la fuente y a la verificación que realmente corresponda. `cancelada` exige una decisión identificable de no continuar.
12. No crear campos o estados extra —por ejemplo, siguiente acción, responsable, prioridad, fechas, dependencias, bloqueos o criterios de aceptación separados— salvo que un caso real o una instrucción expresa demuestre su necesidad y se apruebe su incorporación.

## 4. Persistencia y operaciones externas

13. La fuente de estado todavía no está decidida. No crear un registro, directorio, issue, recordatorio, base o integración por simetría.
14. No asumir sincronización entre plataformas ni duplicar una fuente que ya sea autoritativa. Cualquier integración requiere necesidad, permisos e instrucciones suficientes.
15. Mantener diferenciados tarea, conversación, documento y frente de trabajo; relacionarlos solo si el contexto o la operación realmente lo requieren.

## 5. Salida proporcional

Cuando resulte necesario presentar una tarea, basta con mostrar su enunciado, estado y referencia al origen. Añadir la referencia de ámbito únicamente cuando el contexto no lo deje claro. Otras propiedades se presentan solo cuando una instrucción o un caso concreto las haga necesarias.

**Estado de estas instrucciones:** borrador operativo. El estándar común v0.2 también es candidato; no se ha validado con un motor completo de JSON Schema ni probado de extremo a extremo con tareas reales.
