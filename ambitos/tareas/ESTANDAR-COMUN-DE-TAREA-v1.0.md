# Estándar común de tarea · v1.0

**Estado:** estándar operativo inicial candidato; no canonizado.  
**Ciclo:** C-TAREAS-USO-OPERATIVO-01 · C-20261029-9D3B7A61.  
**Sustituye como propuesta vigente a:** [v0.2 mínimo](ESTANDAR-COMUN-DE-TAREA-v0.2.md), que se conserva como antecedente histórico.

## 1. Regla

Una tarea representa una unidad concreta de trabajo identificada en el contexto de una conversación asociada a un frente de trabajo. Su enunciado debe describir solo el trabajo sustentado por la instrucción o decisión de origen. La fuente original se conserva y puede recuperarse mediante `origin_ref`.

## 2. Campos

| Campo | Obligatorio | Significado |
|---|---:|---|
| `task_id` | Sí | Identidad estable al persistir la tarea. No se fija aquí un algoritmo universal de generación. |
| `statement` | Sí | Enunciado fiel y breve del trabajo. |
| `origin_ref` | Sí | Referencia recuperable al original. |
| `status` | Sí | Estado observado: `pendiente`, `en_curso`, `completada` o `cancelada`. |
| `scope_ref` | No | Se incluye solo si el frente/ámbito no queda claro por el contexto disponible. |
| `priority` | No | Orden relativo de ejecución en la sesión actual. Usar un entero positivo, donde `1` es la primera tarea, solo cuando varias tareas compitan por la atención. |

## 3. Reglas de fidelidad y prioridad

- El original verbatim y el enunciado normalizado son cosas distintas; el segundo no reemplaza al primero.
- La prioridad depende del contexto de la sesión y puede cambiar entre sesiones. No representa una importancia absoluta ni exige un campo separado de urgencia.
- Para ordenar, respetar la instrucción explícita del operador; después considerar urgencia temporal demostrable, desbloqueo de trabajo autorizado, contribución al propósito inmediato y viabilidad de avance.
- No inferir plazos ni consecuencias. Si la información faltante cambia materialmente la secuencia, dejar la prioridad indeterminada o pedir aclaración.
- No crear campos adicionales por simetría o anticipación. Un caso real o una instrucción expresa debe justificar su incorporación.

## 4. Estados

- `pendiente`: identificada, aún no en curso ni completada.
- `en_curso`: hay evidencia de inicio.
- `completada`: atendida conforme a la solicitud y a la verificación aplicable.
- `cancelada`: existe una decisión identificable de no continuar.

Este estándar describe una primera versión utilizable; no acredita por sí mismo pruebas comparativas de prioridad ni convierte Tareas en ámbito canónico.