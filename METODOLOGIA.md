# Metodología

## Estado canónico

- **Versión:** v0.6.0
- **Nombre de versión:** Gate de Contexto Operativo Fail-Closed
- **Última actualización:** 2026-10-07
- **Última actualización canónica:** 2026-10-07T10:26:01-06:00
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** el ciclo ya registraba ubicación, cuenta RDC, consumo disponible y separación entre usuario Windows operativo y administrativo, pero la sesión RDC activa no se trataba todavía como estado global persistente entre conversaciones.

**Cambio:** se establece un registro global de sesión RDC activa, se define su propagación entre conversaciones y se fija ping como verificación primaria de bajo costo por ciclo, con escalamiento solo cuando exista fallo o cambio.

**Motivo:** mantener trazabilidad de la sesión que realmente soporta el trabajo sin multiplicar llamadas de descubrimiento y autenticación en cada ciclo.

**Resultado:** la metodología puede identificar y seguir una sesión RDC activa de forma transversal y verificable, y el perfil CECEQ conserva fila4 como usuario operativo y mantenimientorci como identidad administrativa.

### Registro de versiones

| Número | Valor cuantitativo | Abstracción | Narrativa |
|---:|---|---|---|
| 1 | v0.1.0 | Convenciones Canónicas Iniciales | Se establecieron foliación global de ciclos y las convenciones básicas de versión y salida transversal. |
| 2 | v0.2.0 | Suficiencia Progresiva | Se incorporaron la suficiencia progresiva, el estado visual del acumulador y criterios para evitar expansión innecesaria de la salida. |
| 3 | v0.3.0 | Canon Metacognitivo Fundamental | Se incorporó `SI-METACOGNITIVO.md` como núcleo canónico de gobierno metacognitivo, separado de mecanismos y procedimientos. |
| 4 | v0.4.0 | Gobernanza Versionada y Observabilidad de Servicios | Se normaliza la identidad de versión con nombre y vigencia temporal y se establece observabilidad transversal de las fronteras de servicio de Cora. |
| 5 | v0.5.0 | Contexto de Ejecución y Trazabilidad Operativa | Se canoniza el contexto de ejecución por ciclo, el perfil inicial de CECEQ, la identificación de la cuenta y consumo disponible de RDC y la separación entre identidad Windows operativa y administrativa. |
| 6 | v0.5.1 | Sesión RDC Persistente y Verificable | Se establece un registro global de la sesión RDC activa, su propagación entre conversaciones y una verificación mínima por ciclo mediante ping, con escalamiento solo ante fallo o cambio. |
| 7 | v0.5.2 | Glosario Operativo y Normalización de Transcripción | Se incorpora un glosario metodológico transversal y reglas para normalizar términos dictados o transcritos a su forma canónica, reduciendo deriva de nombres como CECEQ y KHORA. |
| 8 | v0.6.0 | Gate de Contexto Operativo Fail-Closed | Se convierte la verificación del contexto operativo en una precondición de cada ciclo: detección automática de RDC, resolución del perfil de ubicación y bloqueo ante indeterminación material, con intervención del usuario solo para decidir si RDC es requisito cuando la detección automática falla. |

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

La versión canónica actual del SI es **v1.3.0 — Terminología Canónica y Normalización de Transcripción** y contiene los principios **P019–P031**, cada uno con su **índice de preponderancia** dentro de la escala `0–1`.

La metodología mantiene separadas las normas fundamentales de sus desarrollos, procedimientos, herramientas y mecanismos de implementación.
\n\n## 6. Contexto de ejecución y salida por ciclo\n\nEl contrato canonico se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`. Su aplicacion es ubicua en todos los ciclos sujetos a la metodologia e integra plataforma, ubicacion persistente, estado y cuenta RDC, uso mensual disponible, identidad Windows operativa y, cuando corresponda, identidad administrativa. Los detalles de formato, fuentes y perfiles por ubicacion permanecen en el anexo y no se elevan al nivel del SI.


## 6.1 Sesion RDC persistente y verificable

La metodologia mantiene un registro operativo global de la sesion RDC activa en ESTADO-RDC-ACTIVO.md. El registro se propaga entre conversaciones y se verifica al inicio de cada ciclo mediante el mecanismo minimo disponible, con ping como comprobacion primaria.


## 7. Glosario operativo y normalización de transcripción

El glosario metodológico canónico se encuentra en `GLOSARIO-OPERATIVO.md` y su gobernanza en `ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md`. Los términos canonizados tienen prioridad sobre variantes de dictado o transcripción en toda salida sujeta a la metodología.


## 16. Gate de contexto operativo fail-closed

Todo ciclo sujeto a la metodología debe ejecutar primero el gate operativo definido en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`.

Estados permitidos antes de trabajo sustantivo dependiente del entorno:

`VERIFICADO-ACTIVO` · `VERIFICADO-INACTIVO` · `NO-REQUERIDO` · `BLOQUEADO`

`NO-VERIFICADO`, `AMBIGUO`, `FUENTE-NO-DISPONIBLE` o cualquier indisponibilidad de la herramienta de detección no son estados de continuación.

Cuando la detección automática no pueda establecer de forma suficiente si existe una sesión RDC activa, el sistema pregunta al usuario si la conversación requiere una sesión RDC activa. Si responde **sí**, el ciclo queda `BLOQUEADO` y solicita la información mínima para identificarla y verificarla. Si responde **no**, el ciclo pasa a `NO-REQUERIDO` y registra explícitamente que RDC no es una precondición de ese ciclo.

Cuando exista una sesión activa verificada, el estado global registrado debe consumirse antes de ejecutar y la nueva verificación debe actualizar su marca temporal. La sesión global no pertenece a una conversación y una nueva sesión verificada sustituye a la anterior.

La ubicación debe resolverse contra el registro canónico de perfiles antes de ejecutar reglas dependientes del entorno. Un perfil de ubicación inexistente o insuficiente bloquea cualquier operación que dependa de ese perfil.

## 17. Puente de identidad operativa

Para CECEQ, la separación `central\\mantenimientorci` → `fila4` se resuelve mediante un puente de token de la sesión interactiva existente, evitando `runas` con contraseña, cerrar sesión, volver a autenticarse o ejecutar el trabajo ordinario bajo la identidad administrativa.

El mecanismo recomendado es: localizar y verificar el token de la sesión interactiva de `fila4`; duplicar ese token desde el contexto administrativo autorizado; crear el proceso operativo con ese token; verificar con `whoami` y la ruta de perfil del usuario antes de operaciones sustantivas. La identidad administrativa queda reservada a elevación o establecimiento del puente.

Este mecanismo es un detalle de implementación y permanece fuera del nivel de principio.
