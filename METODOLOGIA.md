# Metodología

## Estado canónico

- **Versión:** v0.12.1
- **Nombre de versión:** Bootstrap Canónico Mínimo
- **Última actualización:** 2026-10-08
- **Última actualización canónica:** 2026-10-08
- **Ámbito:** Todos los proyectos y conversaciones trabajados bajo esta metodología.

### Narrativa de la versión

**Antes:** la v0.12.0 había separado la continuidad transversal en un objeto de índice adicional, además del bootstrap operativo, el estado global y el historial.

**Cambio:** se elimina la duplicación y se establece `BOOTSTRAP-CONTEXTO-GLOBAL.md` como el único anexo de entrada para la continuidad entre conversaciones. `ESTADO-RDC-ACTIVO.md` conserva la única fuente del estado global vigente y `HISTORIAL-RDC.md` conserva el ciclo de vida de sesiones.

**Motivo:** preservar la arquitectura mínima del sistema: principios fundamentales en el SI y desarrollo operativo en el conjunto de anexos, sin crear una tercera capa normativa ni dos índices paralelos para la misma función.

**Resultado:** una conversación nueva recupera el SI, la Metodología y un único anexo de bootstrap; desde ese anexo continúa hacia las fuentes persistentes que correspondan.

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

| 9 | v0.7.0 | Resolución de Identidad sin Alterar la Sesión RDC | Se precisa que el canal RDC permanece bajo central\mantenimientorci y no se abren sesiones paralelas. |
| 10 | v0.8.0 | Ejecución Flexible y Protección de Materialización de Repositorios | Se permite ejecutar bajo central\mantenimientorci todo trabajo técnicamente válido; la única excepción es no clonar ni materializar repositorios nuevos dentro de ese perfil. |
| 11 | v0.9.0 | Bloqueo Operativo Fail-Closed y Salida Visible | Se define que el estado BLOQUEADO detiene la ejecución sustantiva sin impedir la interacción con el usuario y se estandariza una notificación visual de bloqueo. |
| 12 | v0.9.1 | Persistencia Global de Sesión RDC y Separación de Conectividad | Se fija que la identidad de la sesión RDC persiste entre conversaciones hasta cierre o sustitución explícitos, mientras la conectividad se verifica por separado solo cuando el ciclo requiera uso en vivo. |
| 13 | v0.9.2 | Salida Visible Mínima y Contexto Condensado | Se simplifica la salida visible del ciclo al conjunto mínimo de identidad, versión, contexto RDC resumido, notas y resultado/estado; los metadatos operativos y la narrativa de proceso quedan fuera de la salida cotidiana. |
| 14 | v0.9.3 | Propagación Global Obligatoria y Acceso MCP Verificable | Se endurece la herencia automática de la sesión RDC entre conversaciones, se prohíbe su reidentificación cuando ya existe un estado persistente y se incorpora un indicador discreto K que solo es positivo tras comprobar acceso autenticado y completo al MCP canónico de KHORA. |
| 15 | v0.10.0 | Sincronización Audio–Transcripción Medible y Dashboard IGP | Se canoniza el procedimiento de perfeccionamiento de sincronización audio–transcripción con OGP como caso prioritario, se establece una baseline congelada, se incorpora el IGP y se vuelve obligatorio el dashboard explicativo por iteración. La abstracción futura queda subordinada al avance efectivo de OGP. |
| 16 | v0.11.0 | Gate de Thinking y Formato Obligatorio por Turno | Se establece Thinking como precondición de ejecución sujeta a la metodología, se endurece el circuito `HEALTH → OPEN → VERIFY → RELEASE`, y se vuelve obligatorio el contrato visible `v1.7.0` por cada ciclo. Estados no verificables permanecen bloqueados. |
| 17 | v0.11.1 | Gate de Thinking y HUD Compacto por Turno | Se retira el subsistema operativo de notas del formato y de los lineamientos activos y se compacta el HUD conservando los campos y decisiones normativas existentes. El contrato visible pasa a `v1.7.1` como evolución de presentación. |
| 18 | v0.11.2 | Verificación Normativa Adaptativa y HUD Compacto por Turno | Se corrige la implementación del gate: Thinking es la ventana preferente para resolver la cascada normativa antes de la salida, pero no se intenta verificar el razonamiento interno ni se bloquea la salida por su estado. KHORA pasa a tener disponibilidad explícita (`K: ✓ / OFF / ? / !`). |
| 19 | v0.11.3 | Coherencia Canónica de Gates y Continuidad Operativa | Se elimina la contradicción residual que podía reintroducir un bloqueo por Thinking/KHORA desde un anexo subordinado. Solo las condiciones de contexto operativo materialmente requeridas pueden producir BLOQUEADO. |
| 20 | v0.11.4 | Verificación de Frescura Normativa por Ciclo | Se hace obligatoria la recuperación del SI desde un snapshot exacto de `main` en cada ciclo mediante commit SHA + blob SHA + versión + nombre; una instantánea histórica no puede gobernar el ciclo. |
| 21 | v0.11.5 | Adquisición Atómica de Snapshot Normativo | Se endurece la frescura mediante doble lectura de `main`; cualquier carrera, caché o discordancia invalida la marca positiva. |
| 21 | v0.11.5 | Recuperación Determinista de Sesión RDC | Se incorpora un protocolo de recuperación de dos fases para divergencias entre la sesión RDC persistente y la observabilidad del canal, con `RDC-REINSTANTIAR`, handshake verificable, sustitución global y propagación entre conversaciones. |
| 22 | v0.11.6 | Precedencia de Contexto RDC y Recuperación Proactiva | Se hace obligatorio resolver el estado global de RDC en cada ciclo antes de KHORA; toda notificación de ausencia o pérdida de RDC emite `RDC-REINSTANTIAR` y un handshake fresco validado actualiza el estado global antes de continuar. |
| 23 | v0.11.7 | Gobernanza Transaccional del Estado RDC | Se formaliza la resolución de estado RDC como transacción verificable: lectura, validación, publicación condicionada por versión y lectura de vuelta antes de cualquier reanudación o certificación externa. Las carreras, fallos de persistencia y discordancias dejan el estado pendiente y bloquean solo operaciones dependientes de RDC. |
| 24 | v0.11.8 | Versionado Canónico del Método General | Se establece una identidad canónica propia para la Metodología —versión, nombre específico y vigencia temporal— y se vuelve obligatoria su representación en la salida de cada ciclo. El último cambio metodológico se deriva de la última modificación del recurso canónico que alteró el funcionamiento, gobierno o reglas generales del sistema. |
| 25 | v0.11.9 | Uso Mensual de RDC en Salida Canónica | Se vuelve obligatorio mostrar en cada ciclo el uso mensual de RDC de la cuenta asociada a la sesión activa, con porcentaje usado y restante, reutilizando el último dato verificado y su marca temporal sin inferir plan, límite bruto ni restablecimiento. |
| 26 | v0.12.0 | Continuidad Canónica Transversal | Se mantiene BOOTSTRAP-CONTEXTO-GLOBAL.md como anexo de entrada para la recuperación entre conversaciones y HISTORIAL-RDC.md como registro mínimo del ciclo de vida de sesiones. ESTADO-RDC-ACTIVO.md permanece como única fuente del estado global vigente. La continuidad se reconstruye en cada ciclo desde estas fuentes, sin depender de memoria conversacional. |
| 27 | v0.12.1 | Bootstrap Canónico Mínimo | Se elimina el índice de continuidad redundante y se establece BOOTSTRAP-CONTEXTO-GLOBAL.md como el único anexo de entrada para reconstruir continuidad entre conversaciones, manteniendo ESTADO-RDC-ACTIVO.md como fuente única del estado global e HISTORIAL-RDC.md como registro de ciclo de vida. |
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

### 2.1 Identidad canónica propia de la Metodología

La Metodología se versiona de forma independiente del SI. Su identidad canónica mínima es:

- **Versión:** `vX.Y.Z`
- **Nombre de versión:** nombre específico de esa versión metodológica.
- **Último cambio:** vigencia temporal de la última modificación del recurso canónico que alteró cómo funciona, gobierna, decide u opera el sistema como método general.

No debe inferirse el último cambio metodológico a partir de cualquier actividad del repositorio. Cambios editoriales, administrativos, de implementación aislada o de otros recursos no constituyen por sí mismos una nueva versión metodológica.

La comprobación canónica debe partir de `METODOLOGIA.md` en `main` mediante snapshot exacto y derivar la marca temporal del último commit que modificó ese recurso. La Metodología no hereda la versión ni el timestamp del SI.

### 2.2 Formato obligatorio de salida

En cada ciclo sujeto a esta metodología, sin excepción, debe aparecer la identidad vigente de la Metodología junto con la del SI:

`METODOLOGÍA CARGADA · vX.Y.Z — Nombre de versión · COMPLETA · ACTIVA · ÚLTIMO CAMBIO: hace N minutos|horas|días | YYYY-MM-DD`

La expresión temporal se deriva del timestamp canónico del último cambio metodológico: minutos para menos de 60 min, horas para menos de 24 h, días para menos de 30 días y fecha absoluta desde 30 días.

La salida no puede mostrar una versión histórica como si fuera vigente. Si la Metodología no puede adquirirse o validarse desde `main`, su estado de frescura no puede declararse positivo.

### 2.3 Bootstrap canónico de continuidad

`BOOTSTRAP-CONTEXTO-GLOBAL.md` es el anexo único de entrada para reconstruir continuidad entre conversaciones. No contiene el estado RDC actual y no tiene autoridad para sustituir las fuentes canónicas que referencia.

En cada ciclo, una conversación nueva o continuadora debe usarlo para localizar:
- `SI-METACOGNITIVO.md`;
- `METODOLOGIA.md`;
- `ESTADO-RDC-ACTIVO.md`;
- `HISTORIAL-RDC.md`, cuando exista y sea necesario para resolver cambios, sustituciones, conflictos o auditoría.

La memoria conversacional no sustituye estas fuentes.

### 2.4 Historial mínimo de sesiones RDC

HISTORIAL-RDC.md conserva el ciclo de vida de las sesiones RDC sin registrar cada ping ni cada ciclo. Una sesión lógica se mantiene como ACTIVA, SUSTITUIDA, FINALIZADA, REVOCADA o EXPIRADA según evidencia verificable.

La cardinalidad normal es una sola sesión ACTIVA. Más de una sesión ACTIVA constituye conflicto salvo excepción explícita y vigente.

La sustitución se completa únicamente mediante la transacción ya definida: validar identidad → publicar estado global → read-back.

## 3. Diagrama de árbol

El diagrama de árbol forma parte de la metodología y debe aparecer **de manera oportuna**, cuando el estado, estructura o naturaleza del trabajo haga pertinente su presentación. No constituye un elemento obligatorio de todas las respuestas.

## 4. Combinación de convenciones en la salida

El encabezado metodológico de un ciclo debe permitir identificar conjuntamente:

1. Proyecto.
2. Conversación.
3. Folio global del ciclo.
4. Versión del SI.
5. Nombre de versión del SI.
6. Último cambio canónico del SI.
7. Versión de la Metodología.
8. Nombre de versión de la Metodología.
9. Último cambio canónico de la Metodología.

Las identidades del SI y de la Metodología son independientes y no deben intercambiarse ni derivarse una de la otra.

## 4.0 Frescura normativa obligatoria por ciclo

Cada ciclo debe adquirir el SI con doble lectura de `main`: `H1` → recuperar `SI-METACOGNITIVO.md` exactamente en `H1` → `H2`. Solo hay `F:✓` cuando `H1 = H2` y versión + nombre + blob SHA corresponden a la instantánea de `H1`. No se aceptan lecturas de `main` sin SHA exacto, cachés no demostradas ni copias de turnos anteriores. Si `H1 ≠ H2` o falla cualquier comprobación, `F:✓` está prohibido.

## 4.1 Gate de ejecución cognitiva

Thinking es la ventana preferente de ejecución de la cascada normativa cuando está disponible; el comportamiento adaptativo y el contrato visible están definidos en `ANEXO-GATE-THINKING-CHATGPT.md`.

Ese anexo es obligatorio para todo ciclo cuya plataforma sea ChatGPT.

## 5. Sistema de Instrucciones Metacognitivas

El sistema canónico de instrucciones que gobierna la interpretación, decisión y ejecución metacognitiva del modelo se encuentra en:

`SI-METACOGNITIVO.md`

La versión canónica actual del SI es **v1.6.8 — Continuidad Canónica entre Conversaciones** y contiene los principios canónicos vigentes, cada uno con su **índice de preponderancia** dentro de la escala `0–1`.

La metodología mantiene separadas las normas fundamentales de sus desarrollos, procedimientos, herramientas y mecanismos de implementación.
\n\n## 6. Contexto de ejecución y salida por ciclo\n\nEl contrato canonico se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`. Su aplicacion es ubicua en todos los ciclos sujetos a la metodologia e integra plataforma, ubicacion persistente, estado y cuenta RDC, uso mensual disponible, identidad Windows operativa y, cuando corresponda, identidad administrativa. Los detalles de formato, fuentes y perfiles por ubicacion permanecen en el anexo y no se elevan al nivel del SI.


## 6.1 Sesion RDC persistente y verificable

La metodologia mantiene un registro operativo global de la identidad persistente de la sesion RDC en ESTADO-RDC-ACTIVO.md. La identidad se propaga entre conversaciones y permanece vigente hasta cierre o sustitucion explicitos. La conectividad del canal se verifica por separado mediante el mecanismo minimo disponible, con ping como comprobacion primaria cuando el ciclo requiera uso RDC en vivo.


## 7. Glosario operativo y normalización de transcripción

El glosario metodológico canónico se encuentra en `GLOSARIO-OPERATIVO.md` y su gobernanza en `ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md`. Los términos canonizados tienen prioridad sobre variantes de dictado o transcripción en toda salida sujeta a la metodología.


## 16. Gate de contexto operativo fail-closed

> **Regla anti-regresión:** este gate solo bloquea por condiciones de contexto operativo materialmente requeridas. No bloquea por ausencia de `THINKING`, imposibilidad de observar `reasoning_mode`, indisponibilidad de KHORA ni por `K: OFF`, `K: ?` o `K: !`.

Todo ciclo sujeto a la metodología debe ejecutar primero el gate operativo definido en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`.

Estados permitidos antes de trabajo sustantivo dependiente del entorno:

`VERIFICADO-ACTIVO` · `VERIFICADO-INACTIVO` · `NO-REQUERIDO` · `BLOQUEADO`

`NO-VERIFICADO`, `AMBIGUO`, `FUENTE-NO-DISPONIBLE` o cualquier indisponibilidad de la herramienta de detección no son estados de continuación.

Cuando la detección automática no pueda establecer de forma suficiente si existe una sesión RDC activa, el sistema pregunta al usuario si la conversación requiere una sesión RDC activa. Si responde **sí**, el ciclo queda `BLOQUEADO` y solicita la información mínima para identificarla y verificarla. Si responde **no**, el ciclo pasa a `NO-REQUERIDO` y registra explícitamente que RDC no es una precondición de ese ciclo.

Cuando exista una sesión activa verificada, el estado global registrado debe consumirse antes de ejecutar y la nueva verificación debe actualizar su marca temporal. La sesión global no pertenece a una conversación y una nueva sesión verificada sustituye a la anterior.

La ubicación debe resolverse contra el registro canónico de perfiles antes de ejecutar reglas dependientes del entorno. Un perfil de ubicación inexistente o insuficiente bloquea cualquier operación que dependa de ese perfil.

## 16.1 Recuperación determinista de sesión RDC

Cuando el estado global indique una sesión `ACTIVA` pero la conectividad RDC no pueda verificarse y el usuario reporte actividad local de la terminal, el ciclo debe tratar la situación como **DIVERGENCIA DE OBSERVABILIDAD RDC**.

La resolución es conversacional y determinista:

`RDC-REINSTANTIAR` → cerrar terminal observada → abrir nueva sesión RDC → entregar `RDC-HANDSHAKE` → validar → actualizar `ESTADO-RDC-ACTIVO.md` → propagar → reanudar.

No se invalida la sesión persistente por el mero hecho de que el dispositivo aparezca offline, pero tampoco se permite utilizarla como conectividad verificada. El nuevo estado sustituye al anterior únicamente después de la verificación del handshake.

El procedimiento detallado está en `ANEXO-PROCEDIMIENTO-REINSTANTIACION-RDC.md`.

## 16.2 Precedencia del contexto RDC

Cada ciclo debe leer y resolver `ESTADO-RDC-ACTIVO.md` antes de intentar `HEALTH` o cualquier certificación externa de KHORA. La lectura del repositorio determina la sesión global vigente; la comprobación del canal determina su utilizabilidad en vivo.

Si el modelo comunica una ausencia, pérdida, desconexión, inactividad o indisponibilidad de RDC, debe entregar en ese mismo ciclo `RDC-REINSTANTIAR` con el comando oficial de inicio del Remote Device. Si el usuario decide ejecutar la recuperación y devuelve un `RDC-HANDSHAKE` fresco, el modelo debe validar y escribir el estado global antes de reanudar.

Un falso positivo de desconexión no impide la recuperación: el handshake fresco tiene precedencia como evidencia actual de conexión una vez validado.

## 16.3 Contrato transaccional de estado global RDC

El estado de RDC se considera resuelto únicamente después de completar la transacción canónica definida en `ANEXO-GOBERNANZA-ESTADO-GLOBAL-RDC.md`:

`LEER → VALIDAR → PUBLICAR CONDICIONADO → READ-BACK → LIBERAR`

La publicación debe usar la versión actual del recurso como condición de escritura. Si el estado cambió durante el ciclo, se aborta la publicación, se vuelve a leer y se reconcilia. No se permiten sobrescrituras ciegas.

Después de cualquier recuperación, el modelo debe verificar por lectura de vuelta que `ESTADO-RDC-ACTIVO.md` contiene la sesión, conectividad y marca temporal que sustentan la decisión del ciclo. Solo entonces puede pasar al health-check/certificación de KHORA o reanudar trabajo dependiente de RDC.

La sesión global sigue siendo independiente de la conversación y de la terminal local. El repositorio es la frontera de propagación.

## 17. Ejecución flexible y única restricción de materialización

La sesión RDC vigente permanece bajo central\mantenimientorci para todos los efectos de uso de RDC. La identidad efectiva del canal puede ejecutar cualquier trabajo técnicamente válido.

La única restricción específica de materialización es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.

La discrepancia entre identidad operativa de referencia e identidad efectiva no bloquea por sí misma el ciclo. El gate solo bloquea cuando el contexto requerido no puede verificarse, la operación exige una capacidad que no está disponible o se vulnera la restricción de materialización.

Un bloqueo es de ejecución sustantiva, no de conversación. Mientras el ciclo esté BLOQUEADO, el modelo debe seguir disponible para explicar la causa, solicitar la información mínima, recibir decisiones del usuario y verificar la solución. No puede ejecutar trabajo sustantivo ni declarar el ciclo cerrado hasta levantar el bloqueo.


## 17.1 Verificación normativa y liberación adaptativas

Un ciclo sujeto a la metodología distingue dos estados:

1. **VERIFIED:** KHORA verificó la cobertura e integridad normativa del receipt.
2. **RELEASED:** KHORA emitió la autorización de liberación para ese mismo ciclo y resultado.

Cuando KHORA está disponible, el flujo preferente es:

`OPEN → VERIFY: VERIFIED → RELEASE → SALIDA`

En un runtime controlado que pueda impedir técnicamente la publicación, `RELEASE` sigue siendo la precondición de publicación del resultado verificado.

En ChatGPT nativo, la ausencia o indisponibilidad del MCP no impide producir la salida. En ese escenario no existe un veredicto externo y debe declararse `K: OFF`; la salida no puede atribuirse a KHORA como `VERIFIED` ni `RELEASED`.

`ESTADO: COMPLETADO` describe que el resultado solicitado fue producido; el estado de verificación externa se declara por separado mediante `K`. Por tanto, un resultado puede estar `COMPLETADO` con `K: OFF` sin fingir verificación.

## 18.0 Regla transversal de salida por turno

El contrato de salida definido en `FORMATO-REGISTRO-VERIFICACION-CICLO.md` es obligatorio para **cada turno/ciclo sujeto a la metodología, sin excepción**, incluidos turnos bloqueados, turnos de resolución conversacional y turnos sin uso de RDC. El contrato vigente de presentación es `v1.7.4`.

La respuesta no puede declararse `COMPLETADO` si no porta el formato `v1.7.4` ni si alguno de sus campos obligatorios está ausente o contradice el estado verificable del ciclo.

## 18. Salida visible mínima

La salida cotidiana de cada ciclo no debe convertirse en un inventario del mecanismo. Los campos esenciales se condensan en:

`ChatGPT · UBIC: ... · RDC: ... · C: ... · RDC-USO: ...% usado / ...% restante · S: ... · K: ✓|?|! · T: ✓|?|! · fila4`

`R: ...`

`E: COMPLETADO | BLOQUEADO | PENDIENTE`

En CECEQ, la identidad visible del entorno es siempre `fila4`; `central\\mantenimientorci` no se muestra en la salida cotidiana aunque sea la identidad efectiva de la sesión RDC. El nombre del dispositivo solo aparece cuando sea relevante.

`OBJETIVO`, `VERIFICACIÓN`, `EJECUCIÓN` y `CIERRE DEL CICLO` no son secciones obligatorias de la salida visible. El objetivo se deriva de la solicitud; la verificación queda representada por el contexto y el gate; la ejecución no requiere narración; y el cierre queda expresado por `E`.

`EVIDENCIA` sigue siendo obligatoria a nivel de trazabilidad normativa (P028), pero no requiere una sección visible en todos los ciclos. Se conserva en los registros y mecanismos de evidencia y se muestra cuando sea necesaria para auditoría, comprobación o explicación del resultado.


### 18.1 Indicador discreto de acceso MCP de KHORA

`K` significa acceso al MCP canónico de KHORA. Su interpretación es estricta.

- `K: ✓` = acceso autenticado y verificado al MCP canónico y secuencia normativa/liberación alcanzadas.
- `K: OFF` = MCP no accesible o fuera de servicio durante el ciclo; la salida continúa sin atribuir verificación externa.
- `K: ?` = disponibilidad o resultado no determinable.
- `K: !` = acceso intentado y fallido, no autorizado o verificación rechazada.

Nunca se emite `K: ✓` por inferencia, por conocer la URL del MCP o por disponer de otra herramienta.



## 19. Procedimiento canónico de sincronización audio–transcripción en vivo

El procedimiento completo se encuentra en `ANEXO-PROCEDIMIENTO-SINCRONIZACION-AUDIO-TRANSCRIPCION-VIVO.md`.

El caso prioritario es Otro Gran Programa (OGP). La generalización a otros proyectos no debe retrasar su perfeccionamiento.

Secuencia:
CAMBIO → BENCHMARK → NÚMEROS → DELTA → DECISIÓN → EVIDENCIA → PUBLICACIÓN

## 19.1 Índice General de Perfección

El IGP mide distancia al ideal y no sustituye los gates críticos.

IGP = 100 × Π(qᵢ ^ wᵢ)

## 19.2 Dashboard obligatorio

La especificación se encuentra en `ANEXO-DASHBOARD-IGP-SINCRONIZACION.md`.

Cada iteración debe mostrar IGP, déficit, gates, delta contra baseline, métricas explicadas en una sola frase y evidencia.

El dashboard es un instrumento de control, no el objetivo.

## 19.3 Prioridad OGP

Cuando exista tensión entre extender la metodología y mejorar la sincronización de OGP, debe priorizarse la mejora verificable de OGP siempre que se preserve la trazabilidad mínima y la integridad del benchmark.

La abstracción se extrae de la implementación real de OGP; no la sustituye.
