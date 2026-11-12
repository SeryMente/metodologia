# GOV-TASK-016 · Revisar AT para IPZ y cambios del marco

**Naturaleza:** tarea provisional del OCP Gobernanza; no es un frente independiente ni canoniza el ámbito Tareas.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control único del OCP padre; sin control, sesión ni folios propios.  
**Origen:** C-GOBERNANZA-IPZ-AT-ADECUACION-01 · instrucciones del operador conservadas literalmente en el diálogo A/B vinculado.  
**Fuentes:** AT v1.2, DUG vigente, ART-025, ART-027, GOV-TASK-007 y baseline IPZ preservado.

## Enunciado

Revisar y endurecer AT para que toda operación sobre IPZ preserve primero la versión vigente exacta, consulte el DUG y los anexos pertinentes —obligatoriamente ART-025 y ART-027—, verifique la conformidad de la candidata con ART-025 y coteje por lectura de vuelta cada resultado. Determinar y preparar, sin canonizar por esta ficha, un principio del DUG que establezca AT como vía exclusiva para actualizar el marco metodológico.

## Trabajo pendiente

1. **Baseline obligatorio IPZ:** antes de editar, adquirir la versión actual desde la fuente disponible y guardarla íntegra en el OCP autorizado; registrar procedencia (lectura nativa de vuelta o texto suministrado por el operador), Git Blob SHA y, cuando proceda, SHA-256; releer y cotejar. Nunca presentar texto suministrado como lectura nativa.
2. **Lectura normativa por cada actualización IPZ:** adquirir DUG vigente desde main y consultar ART-025, ART-027 y los principios/anexos pertinentes. No sustituir el texto completo por memoria o MDP.
3. **Matriz de conformidad ART-025:** comprobar §ARR/GOW:ARR; ART-031 y el OCP aplicable; consulta y consideración del texto íntegro de P001/P004/P005/P038/P043 en cada turno. ART-027 fija Sink preferente y extracción exacta desde DUG main como respaldo.
4. **Cotejo de candidata:** relacionar cada requisito de la IPZ anterior con la nueva; señalar preservado, modificado o retirado con justificación; verificar límite UTF-16/puntos de código según el campo, SHA y lectura de vuelta.
5. **Autorización:** AT articula el cambio, pero no sustituye P005, P024 ni las compuertas del destino. Ninguna escritura normativa en DUG sin la autorización explícita exigida por P005.
6. **Aceptación nativa separada:** preparar texto no equivale a instalarlo. Solo declarar instalación tras acceso, autorización, escritura y lectura de vuelta del campo nativo.

## Propuesta no canonizada de principio

**Nombre propuesto:** Principio de Actualización Exclusiva mediante Articulación Trazable.

**Enunciado propuesto:**

Toda creación, modificación, supresión o reorganización del marco metodológico se tramita exclusivamente mediante AT. AT conserva la intención de origen, clasifica el cambio, determina sus dependencias, aplica las autorizaciones y compuertas correspondientes y verifica cada destino por lectura de vuelta. Queda prohibida cualquier modificación directa o lateral fuera de AT; si AT o una autorización requerida no pueden verificarse, no se escribe ni se declara ejecutado el cambio.

**Estado:** propuesta de redacción; sin ID ni preponderancia asignados; no incorporada al DUG. Su incorporación requiere aprobación normativa explícita conforme a P005.

## Criterios de aceptación

- Baseline IPZ exacto, con procedencia explícita, hash y read-back.
- AT revisada/versionada, conservando v1.2 como antecedente.
- Controles ART-025/ART-027 específicos de IPZ, con matriz de conformidad.
- Pruebas falsables para baseline ausente, SHA discrepante, anexo no leído y candidata que omite un requisito.
- Distinguir candidata documental, escritura intentada, campo nativo leído de vuelta y aceptación.
- Principio de exclusividad AT aprobado e incorporado al DUG, o formalmente mantenido como propuesta pendiente.
- Informe de cierre con archivos, blobs, commit, medidas, pruebas, read-back y límites.

## Límites

No cambiar DUG, asignar folio al principio propuesto ni modificar campo nativo desde esta tarea sin autorización/capacidad específicas. No activar FOL1. MCP-NORMATIVO permanece DESACTIVADO.

## Procedencia y continuidad

A1 (solicitud anterior) y A2 (instrucción actual) se conservan literalmente en el diálogo C-GOBERNANZA-IPZ-AT-ADECUACION-01. La adecuación documental IPZ v0.10 se registra en GOV-TASK-007; esta tarea queda abierta para revisar AT y tramitar el principio propuesto.

[Diálogo](../../../conversaciones/C-GOBERNANZA-IPZ-AT-ADECUACION-01-dialogo.jsonl) · [Crónica](../../../cronica/C-GOBERNANZA-IPZ-AT-ADECUACION-01.md) · [Evidencia](../../../evidencias/C-GOBERNANZA-IPZ-AT-ADECUACION-01.json)
