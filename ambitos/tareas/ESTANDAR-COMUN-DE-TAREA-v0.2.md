# Estándar común de tarea · v0.2 (candidato mínimo)

**Estado:** candidato de diseño; no canonizado ni probado en producción.  
**Sustituye como propuesta vigente a:** [v0.1](ESTANDAR-COMUN-DE-TAREA-v0.1.md), que se conserva como antecedente histórico.  
**Ciclo:** C-TAREAS-ESTANDAR-MINIMO-02 · C-20261029-4F7A2C91.

## 1. Regla de diseño

El estándar debe describir solo lo que se necesita para reconocer una tarea y distinguir su estado. Cada campo adicional necesita una necesidad observada o una instrucción expresa; la comodidad hipotética no basta.

El estándar común describe la **tarea**. El subsistema Tareas, si finalmente se ratifica, es quien la gestiona. Un perfil específico de ámbito solo podrá añadir datos cuando el caso lo requiera y sin convertirlos retroactivamente en requisitos universales.

## 2. Núcleo mínimo

Una tarea es una unidad de trabajo enunciada con fidelidad a la solicitud que la origina y cuyo estado puede registrarse.

| Campo | Requisito | Regla |
|---|---|---|
| `task_id` | Obligatorio cuando la tarea se registra como objeto persistente | Identidad estable; esta versión no define el generador ni garantiza unicidad global. |
| `statement` | Obligatorio | Enunciado breve y fiel de la tarea. No añadir objetivos, condiciones ni trabajo que la instrucción no implique. |
| `origin_ref` | Obligatorio | Referencia recuperable a la instrucción, decisión o fuente original. Conservar el original verbatim en su fuente canónica; la reformulación, si es necesaria, no lo sustituye. |
| `status` | Obligatorio | Estado observado: `pendiente`, `en_curso`, `completada` o `cancelada`. No asignar un estado sin sustento. |
| `scope_ref` | Condicional | Añadir solo cuando el ámbito responsable no resulte claro por el OCP, la fuente o el contexto de origen. No repetir una referencia ya inequívoca. |

No se añaden por defecto campos separados de título, resultado esperado, criterios de aceptación, siguiente acción, responsable, prioridad, fecha límite, dependencia, bloqueo, evidencia, fechas de auditoría o contadores de actividad. Cuando la instrucción original necesite precisar un criterio de terminación, este puede expresarse en el propio enunciado; si no puede determinarse sin inventar, se solicita aclaración antes de completar la definición.

## 3. Verbatim y descripción operativa

La procedencia debe apuntar a la fuente original recuperable. Si se presenta una reformulación operativa, debe permanecer reconocible como interpretación y no puede atribuir a la instrucción un alcance mayor o menor. No reconstruir texto verbatim desde memoria o resumen. No declarar persistencia, ejecución ni cierre sin la evidencia exigida por la metodología aplicable.

El estándar no impone duplicar el texto original dentro de cada tarea cuando una referencia basta para recuperarlo. Si la fuente no puede referenciarse de forma fiable, ese límite debe declararse; no se inventará una referencia.

## 4. Estados mínimos

- **pendiente:** identificada, pero no marcada en curso ni completada.
- **en_curso:** existe evidencia de que el trabajo comenzó.
- **completada:** se comprobó que la solicitud expresada quedó atendida, conforme a la fuente disponible y los criterios que realmente formen parte de ella.
- **cancelada:** existe una decisión identificable de no continuar.

“Bloqueada”, “aplazada”, “en revisión”, prioridad, recurrencia, dependencias y demás distinciones no forman parte del núcleo v0.2. Solo podrán añadirse a un perfil o revisión posterior si un caso real demuestra la necesidad.

## 5. Extensiones y persistencia

La extensión por ámbito es una posibilidad, no una capa que deba implementarse desde ahora. Antes de añadir un campo, estado, relación, automatización o adaptación de plataforma, debe identificarse el caso que no pueda representarse adecuadamente con el núcleo mínimo y documentarse la razón.

Este contrato no prescribe un directorio por tarea, un registro global, una plataforma determinada ni sincronización entre superficies. La fuente de estado y la persistencia se decidirán aparte, una vez demostrado que hacen falta. No crear archivos, registros, directorios o integraciones por simetría.

## 6. Condición para ampliar o ratificar

Antes de promover el estándar a v1.0, contrastarlo con casos autorizados de distinta naturaleza. Para cada elemento propuesto, preguntar:

1. ¿Lo exige una instrucción literal o una regla canónica vigente?
2. ¿Es necesario para identificar la tarea o conocer su estado?
3. ¿Ya está representado en la fuente de origen o en el contexto donde se registra?
4. ¿Puede omitirse sin perder un significado necesario?

Si puede omitirse sin pérdida, no pertenece al núcleo común. El paso de candidato a norma requiere pruebas pertinentes, lectura de vuelta y la autorización expresa que corresponda.

## 7. Estado

**CANDIDATO MÍNIMO v0.2.** Esta revisión retira del núcleo los campos y estados que la primera propuesta añadió por previsión, sin evidencia suficiente de que sean universales. No canoniza Tareas, no decide su plataforma y no afirma que haya sido probada con tareas reales.
