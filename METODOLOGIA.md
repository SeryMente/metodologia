# Metodología

## Estado canónico

- **Versión:** v0.5.0
- **Nombre de versión:** Contexto de Ejecución y Trazabilidad Operativa
- **Última actualización:** 2026-10-07
- **Última actualización canónica:** 2026-10-07T09:09:00-06:00
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** la metodología ya disponía de SI canónico, foliación global, reglas de salida, estado del acumulador y trazabilidad normativa, pero no existía un contrato transversal para registrar el lugar físico, la identidad RDC, el porcentaje de uso del canal RDC y la separación entre usuario Windows operativo y usuario elevado en cada ciclo.

**Cambio:** se canoniza el Anexo de Contexto de Ejecución y Formato de Salida por Ciclo, se fijan tres ubicaciones iniciales, se define la procedencia y frescura de los datos RDC y se hace obligatoria la separación entre identidad administrativa y operativa.

**Motivo:** evitar ambigüedad sobre dónde se trabaja, con qué canal se trabaja y bajo qué identidad Windows deben ejecutarse las operaciones, manteniendo trazabilidad suficiente sin elevar detalles de implementación al nivel de principio fundamental.

**Resultado:** cada ciclo sujeto a la metodología dispone de un contrato uniforme de contexto operativo y salida, y CSEC queda perfilado con fila4 como usuario operativo y mantenimientorci como identidad administrativa de puente.

### Registro de versiones

| Número | Valor cuantitativo | Abstracción | Narrativa |
|---:|---|---|---|
| 1 | v0.1.0 | Convenciones Canónicas Iniciales | Se establecieron foliación global de ciclos y las convenciones básicas de versión y salida transversal. |
| 2 | v0.2.0 | Suficiencia Progresiva | Se incorporaron la suficiencia progresiva, el estado visual del acumulador y criterios para evitar expansión innecesaria de la salida. |
| 3 | v0.3.0 | Canon Metacognitivo Fundamental | Se incorporó `SI-METACOGNITIVO.md` como núcleo canónico de gobierno metacognitivo, separado de mecanismos y procedimientos. |
| 4 | v0.4.0 | Gobernanza Versionada y Observabilidad de Servicios | Se normaliza la identidad de versión con nombre y vigencia temporal y se establece observabilidad transversal de las fronteras de servicio de Cora. |
| 5 | v0.5.0 | Contexto de Ejecución y Trazabilidad Operativa | Se canoniza el contexto de ejecución por ciclo, el perfil inicial de CSEC, la identificación de la cuenta y consumo disponible de RDC y la separación entre identidad Windows operativa y administrativa. |

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

## 2. Identificación de versión en conversaciones

En todo momento y en cualquier lugar donde se genere una conversación al interior de un proyecto sujeto a esta metodología, el modelo debe identificar la **versión de la última actualización, el nombre de esa versión y la vigencia temporal de la última modificación canónica**.

Esta identificación aplica a conversaciones nuevas, continuaciones, cambios de ámbito y cualquier otro contexto conversacional dentro de los proyectos bajo la metodología.

Formato mínimo:

`Versión: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

El nombre es el correspondiente a la versión específica y no el título general del sistema. La expresión temporal se deriva de la marca `Última actualización canónica` del recurso normativo; se usan minutos para menos de 60 min, horas para menos de 24 h, días para menos de 30 días y fecha absoluta desde 30 días.

## 3. Diagrama de árbol

El diagrama de árbol forma parte de la metodología y debe aparecer **de manera oportuna**, cuando el estado, estructura o naturaleza del trabajo haga pertinente su presentación. No constituye un elemento obligatorio de todas las respuestas.

## 4. Combinación de convenciones en la salida

Además de las convenciones de trazabilidad y versión, el formato de salida debe mostrar el estado visual del acumulador global de notas:

`🟢 SIN NOTAS` / `🟡 NOTAS PENDIENTES`

El indicador es parte de la máquina de estados del acumulador y no es un adorno de presentación.

Cuando corresponda, el encabezado metodológico de un ciclo debe permitir identificar conjuntamente:

1. Proyecto.
2. Conversación.
3. Folio global del ciclo.
4. Versión de la última actualización.
5. Nombre de la versión.
6. Último cambio canónico.

## 5. Sistema de Instrucciones Metacognitivas

El sistema canónico de instrucciones que gobierna la interpretación, decisión y ejecución metacognitiva del modelo se encuentra en:

`SI-METACOGNITIVO.md`

La versión canónica actual del SI es **v1.2.0 — Identidad Versionada y Vigencia Canónica** y contiene los principios **P019–P029**, cada uno con su **índice de preponderancia** dentro de la escala `0–1`.

La metodología mantiene separadas las normas fundamentales de sus desarrollos, procedimientos, herramientas y mecanismos de implementación.
\n\n## 6. Contexto de ejecución y salida por ciclo\n\nEl contrato canónico se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`. Su aplicación es ubicua en todos los ciclos sujetos a la metodología e integra ubicación, estado y cuenta RDC, uso mensual disponible, identidad Windows operativa y, cuando corresponda, identidad administrativa. Los detalles de formato, fuentes y perfiles por ubicación permanecen en el anexo y no se elevan al nivel del SI.\n