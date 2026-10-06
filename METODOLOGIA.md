# Metodología

## Estado canónico

- **Versión:** v0.3.0
- **Nombre de versión:** Sistema de Instrucciones Metacognitivas
- **Última actualización:** 2026-10-06
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** la metodología disponía de versionado, foliación global, reglas de presentación, Suficiencia Progresiva y No Dualidad Operativa, pero no tenía un sistema canónico y compacto de instrucciones destinado a gobernar metacognitivamente al modelo.

**Cambio:** se incorpora `SI-METACOGNITIVO.md` como sistema canónico de instrucciones fundamentales. El SI establece la estructura de los principios, su folio estable, propósito, enunciado, contexto, índice de preponderancia y estado, y canoniza los principios P019–P027.

**Motivo:** disponer primero de un régimen metacognitivo pequeño y estable que pueda gobernar al modelo y servir después como base para derivar las capas metodológicas inferiores.

**Resultado:** existe un núcleo metacognitivo canónico, separado de procedimientos, mecanismos y detalles operativos.

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

## 5. Sistema de Instrucciones Metacognitivas

El sistema canónico de instrucciones que gobierna la interpretación, decisión y ejecución metacognitiva del modelo se encuentra en:

`SI-METACOGNITIVO.md`

Este sistema constituye la capa fundamental de gobierno del modelo. Sus principios son canónicos cuando su estado así lo indique; sus detalles de aplicación pueden desarrollarse en capas metodológicas inferiores sin modificar el significado de los principios.

La versión inicial canoniza los principios **P019–P027** y establece para cada uno su **índice de preponderancia** dentro de la escala `0–1`.
