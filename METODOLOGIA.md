# Metodología

## Estado canónico

- **Nombre de versión:** Gobernanza Versionada y Observabilidad de Servicios
- **Última actualización canónica:** 2026-10-06T16:42:13-06:00

- **Versión:** v0.4.0
- **Nombre de versión:** Sistema de Instrucciones Metacognitivas
- **Última actualización:** 2026-10-06
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** la metodología ya disponía de un SI canónico, foliación global, reglas de salida y trazabilidad normativa, pero la identidad de versión todavía reutilizaba el título general como nombre de versión y la observabilidad de Cora no tenía una frontera transversal uniforme para todos sus servicios HTTP y bridges.

**Cambio:** se formaliza el nombre específico de cada versión, su registro histórico y la marca de última actualización canónica; además, se establece observabilidad transversal para las fronteras de servicio de Cora y correlación uniforme para servicios internos y agentes externos.

**Motivo:** permitir que cualquier modelo, plataforma o auditor pueda identificar sin ambigüedad qué versión normativa estaba vigente y reconstruir la actividad de los servicios de Cora sin depender de logs aislados por subsistema.

**Resultado:** la metodología cuenta con una convención de versionado descriptiva y trazable, y Cora dispone de una capa común de observabilidad de servicios que complementa sus eventos de dominio y registros especializados.

### Registro de versiones

| Número | Valor cuantitativo | Abstracción | Narrativa |
|---:|---|---|---|
| 1 | v0.1.0 | Convenciones Canónicas Iniciales | Se establecieron foliación global de ciclos y las convenciones básicas de versión y salida transversal. |
| 2 | v0.2.0 | Suficiencia Progresiva | Se incorporaron la suficiencia progresiva, el estado visual del acumulador y criterios para evitar expansión innecesaria de la salida. |
| 3 | v0.3.0 | Canon Metacognitivo Fundamental | Se incorporó `SI-METACOGNITIVO.md` como núcleo canónico de gobierno metacognitivo, separado de mecanismos y procedimientos. |
| 4 | v0.4.0 | Gobernanza Versionada y Observabilidad de Servicios | Se normaliza la identidad de versión con nombre y vigencia temporal y se establece observabilidad transversal de las fronteras de servicio de Cora. |

La tabla es canónica: las versiones futuras deben añadir una fila sin borrar ni reciclar las anteriores. El nombre describe el avance de la versión y no sustituye el título general del sistema o documento.

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

`Versión: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

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
