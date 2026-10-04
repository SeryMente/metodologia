# Metodología

## Estado canónico

- **Versión:** v0.2.0
- **Nombre de versión:** Suficiencia Progresiva
- **Última actualización:** 2026-10-03
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** la metodología definía convenciones de trazabilidad, versionado y presentación, pero no un régimen explícito para la densidad de la salida ni para el estado visual del acumulador de notas.

**Cambio:** se incorpora el estado visual 🟢 **SIN NOTAS** / 🟡 **NOTAS PENDIENTES**, y se establece el **Principio de Suficiencia Progresiva** como primera solución al problema de la deriva de verbosidad por defecto. Se incorpora además el **Principio de No Dualidad Operativa** como criterio de formulación del comportamiento.

**Motivo:** sustituir respuestas extensas por defecto por una salida sobria y pragmática cuya profundidad corresponda a la necesidad real de la tarea, sin convertir la evitación de conductas en trabajo adicional del modelo.

**Resultado:** la metodología dispone ahora de un régimen experimental explícito de salida: **suficiencia → relevancia → directo → detenerse**, con expansión progresiva sólo cuando sea necesaria o solicitada.

## 1. Convención obligatoria de foliación de ciclos

La unidad metodológica de secuencia y trazabilidad es el **ciclo de conversación**, no la conversación completa.

Cada ciclo debe recibir un **folio global único, secuencial y permanente**, independientemente de la conversación en la que ocurra. La numeración no se reinicia al cambiar de conversación y puede intercalarse entre múltiples conversaciones abiertas dentro del mismo proyecto.

La conversación funciona como contenedor/contexto; el ciclo constituye la unidad de secuencia global.

### Formato canónico

`PROYECTO / CONV-XX / CXXX`

Donde:

- `PROYECTO` identifica el proyecto.
- `CONV-XX` identifica la conversación contenedora.
- `CXXX` identifica el **folio global del ciclo**.

El `CXXX` es el identificador secuencial principal del ciclo y no depende del orden relativo de las conversaciones.

### Regla de salida

La foliación es **obligatoria y ubicua**: debe aparecer en el formato de salida de **cada ciclo, sin excepción**, en todos los proyectos sujetos a esta metodología.

Ejemplo:

`METODOLOGÍA / CONV-05 / C020`

## 2. Identificación de versión en conversaciones

En todo momento y en cualquier lugar donde se genere una conversación al interior de un proyecto sujeto a esta metodología, el modelo debe identificar la **versión de la última actualización y el nombre de esa versión**.

Esta identificación aplica a conversaciones nuevas, continuaciones, cambios de ámbito y cualquier otro contexto conversacional dentro de los proyectos bajo la metodología.

Formato mínimo:

`Versión: vX.Y.Z — Nombre de versión`

## 3. Diagrama de árbol

El diagrama de árbol forma parte de la metodología y debe aparecer **de manera oportuna**, cuando el estado, estructura o naturaleza del trabajo haga pertinente su presentación. No constituye un elemento obligatorio de todas las respuestas.

## 4. Combinación de convenciones en la salida

Además de las convenciones de trazabilidad y versión, el formato de salida debe mostrar el estado visual del acumulador global de notas:

`🟢 SIN NOTAS`  /  `🟡 NOTAS PENDIENTES`

El indicador es parte de la máquina de estados del acumulador y no es un adorno de presentación.

Cuando corresponda, el encabezado metodológico de un ciclo debe permitir identificar conjuntamente:

1. Proyecto.
2. Conversación.
3. Folio global del ciclo.
4. Versión de la última actualización.
5. Nombre de la versión.

Referencia:

`PROYECTO / CONV-XX / CXXX`

`Versión: vX.Y.Z — Nombre de versión`

Estas convenciones son transversales y aplican a cualquier proyecto que adopte la metodología; no están restringidas al repositorio de Metodología.
