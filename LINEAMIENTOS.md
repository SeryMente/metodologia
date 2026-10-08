# Lineamientos transversales

## 1. Aplicación

Estos lineamientos son la referencia mínima para cualquier conversación secundaria o posterior que desarrolle o actualice un ámbito de la metodología, independientemente de su naturaleza.

## 2. Documentación de una actualización

Toda actualización debe dejar identificables, como mínimo:

- **Ámbito:** qué parte de la metodología se está trabajando.
- **Estado anterior:** qué existía antes del cambio.
- **Cambio:** qué se modifica, incorpora o elimina.
- **Motivo:** por qué se realiza el cambio.
- **Resultado:** cuál es el nuevo estado establecido.
- **Versión:** número de versión correspondiente cuando el cambio afecte al sistema versionado.

La documentación debe ser suficientemente clara para reconstruir la evolución del ámbito sin depender de la conversación en la que se originó.

## 3. Separación entre propuesta y decisión

Una idea discutida en una conversación no se considera automáticamente parte de la metodología. Solo las decisiones confirmadas pasan a formar parte del registro canónico.

## 4. Formato de salida de la sombrilla metodológica

Cuando corresponda mostrar la visión general, se utilizará este árbol como formato base:

```text
Metodología
│
├── Conversación general
│   └── Sombrilla metodológica
│       ├── principios generales
│       ├── relaciones entre sistemas
│       └── integración de lo desarrollado
│
└── Conversaciones especializadas
    ├── [ámbito especializado]
    │   └── desarrollo y actualización de ese ámbito
    │
    ├── [otro ámbito]
    │   └── desarrollo y actualización de ese ámbito
    │
    └── ...
```

Los nombres de los ámbitos se sustituyen por los ámbitos reales conforme se incorporen.

## 5. Actualización importante

Se considera **actualización importante** aquella que cambia de forma relevante la estructura, alcance, relación, regla general o estado consolidado de un ámbito, o que introduce un ámbito nuevo con impacto sobre la metodología común.

Una actualización importante es el desencadenante para mostrar oportunamente el árbol de la metodología general. Los cambios menores o puramente locales no lo requieren.

## 6. Sistema de versionado común

Todos los repositorios que operen bajo la metodología general utilizarán, como base, una nomenclatura numérica **MAJOR.MINOR.PATCH**.

La versión identifica un **estado reconocible del sistema** y no necesariamente una única sesión o ciclo de trabajo. Un mismo número de versión puede abarcar múltiples ciclos operativos. La jerarquía del desarrollo se expresa narrativamente y no necesita codificarse rígidamente dentro del número de versión.

Los criterios detallados para determinar cuándo corresponde incrementar **MAJOR**, **MINOR** o **PATCH** quedan pendientes de formalización posterior.

### 6.1 Identidad de la versión

Cada versión estará compuesta conceptualmente por tres elementos:

**valor cuantitativo + nombre + narrativa**

El **nombre** será una denominación breve, memorable y suficientemente distinta de las anteriores. Se decidirá mediante un criterio replicable y simple: identificar el cambio o estado más representativo de la versión y reducirlo a una denominación concreta, normalmente de una o dos palabras. No existirá por ahora una lista cerrada de nombres.

El nombre proporciona identidad verbal a la versión; no codifica su valor numérico ni sustituye su narrativa.

### 6.2 Narrativa de la versión

Cada número de versión deberá tener asociada una narrativa rica pero concisa. La narrativa seguirá un patrón semántico simple y universal:

**Antes → Cambio → Motivo → Resultado**

Debe contener información suficiente para que, leyendo las versiones sucesivamente, pueda reconstruirse cómo y por qué el sistema pasó de un estado al siguiente.

No se imponen por ahora vocabulario obligatorio, longitud, número de párrafos ni estructuras literarias adicionales. La finalidad es conservar una historia comprensible y reconstruible de la evolución del sistema sin introducir complejidad innecesaria.

## 7. Foliacion global de ciclos de conversacion

Todo ciclo de conversacion dentro de un proyecto sujeto a esta metodologia tendra un **folio global unico y secuencial**, independiente de la conversacion en la que ocurra. La conversacion es el contenedor/contexto; el ciclo es la unidad de secuencia y trazabilidad. La numeracion no se reinicia al cambiar de conversacion y puede intercalarse entre multiples conversaciones.

El formato canonico es:

`PROYECTO / CONV-XX / CXXX`

Donde `PROYECTO` identifica el proyecto, `CONV-XX` la conversacion y `CXXX` el folio global del ciclo. El folio `CXXX` es obligatorio en el formato de salida de **cada ciclo, sin excepcion**, para todos los proyectos bajo la metodologia.

## 8. Identificacion ubicua de la ultima version

En todo momento y en cualquier lugar donde se genere una conversacion al interior de un proyecto sujeto a esta metodologia, el modelo debe identificar la **version de la ultima actualizacion y el nombre de esa version**. Esta regla aplica a conversaciones nuevas, continuaciones y conversaciones especializadas de cualquier ambito.

El formato minimo es:

`Version: vX.Y.Z - Nombre de version`

## 9. Diagrama de arbol oportuno

El diagrama de arbol se mostrara **de manera oportuna** cuando el estado, estructura o naturaleza del trabajo haga pertinente presentar la vision jerarquica. No constituye un elemento obligatorio de todas las respuestas. Una actualizacion importante continua siendo el desencadenante establecido para mostrar oportunamente el arbol general de la metodologia.
## 10. HUD compacto por turno

La salida visible conserva todos los campos ya canonizados, pero se presenta como un bloque compacto de baja intrusión. Se permite enriquecer la presentación mediante **negritas**, `código` y etiquetas cortas sin introducir campos ni decisiones nuevas. El contrato vigente de formato es `v1.7.6`.

## 11. Principio de suficiencia progresiva

Para resolver la **deriva de verbosidad por defecto**, la salida debe operar inicialmente con la cantidad minima de informacion suficiente para resolver la intencion actual. La profundidad, contexto o elaboracion se incrementan unicamente cuando la naturaleza de la tarea o una señal posterior del usuario lo justifique.

El principio sustituye el esquema de respuesta extensa por defecto por un regimen de **suficiencia → relevancia → directo → detenerse**. No prescribe respuestas artificialmente cortas: la complejidad de la salida debe corresponder a la complejidad requerida por la tarea.

## 12. Principio de no dualidad operativa

El comportamiento deseado debe especificarse mediante el estado operativo que se pretende producir, no mediante una enumeracion de comportamientos que deben evitarse. La ausencia de una conducta no constituye una tarea adicional del modelo: resulta de operar bajo el regimen definido.

La formulacion operativa debe privilegiar instrucciones positivas de comportamiento y evitar convertir la supresion de conductas en una carga adicional de control.
\n\n## 13. Contexto de ejecución y salida por ciclo\n\nTodo ciclo sujeto a la metodologia debe incorporar el contexto operativo definido en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`. El bloque es obligatorio e incluye plataforma, ubicacion persistente, estado de sesion RDC, cuenta RDC, uso mensual disponible y usuario Windows operativo. Cuando exista una identidad administrativa relevante, debe mostrarse por separado. Los datos no verificables deben identificarse como tales; no deben completarse por inferencia.

La ubicacion actual permanece vigente entre ciclos y conversaciones hasta una declaracion explicita de cambio. Para CECEQ, el perfil canónico de referencia establece `fila4` como identidad operativa y `central\\mantenimientorci` como identidad efectiva de la sesión RDC. La diferencia no bloquea el trabajo por sí misma; `central\\mantenimientorci` puede ejecutar cualquier operación técnicamente válida. La única restricción específica es no clonar ni materializar repositorios nuevos dentro de su perfil o ruta.


## 14. Persistencia de la sesion RDC activa

La sesion RDC activa es estado operativo transversal y no pertenece a una conversacion particular. Debe conservarse en ESTADO-RDC-ACTIVO.md y propagarse entre conversaciones.

Al inicio de cada ciclo, si existe una sesion registrada como activa, se verifica por ping sobre el dispositivo conocido. Solo ante fallo, ausencia o discrepancia se realiza descubrimiento adicional de dispositivos o cuenta.

La identidad RDC, el usuario Windows operativo y la identidad administrativa se registran como campos independientes.


## 15. Glosario operativo

Toda salida y todo documento sujeto a la metodología debe respetar el glosario canónico. Las variantes de reconocimiento de voz se tratan como entradas de normalización y no como nuevas nomenclaturas.

La fuente metodológica transversal es `GLOSARIO-OPERATIVO.md`. El glosario no absorbe vocabulario específico de cada proyecto salvo que ese término haya sido canonizado como transversal.

Antes de repetir un nombre propio, acrónimo, identificador de proyecto o producto, debe preferirse la forma registrada en el glosario.


## 16. Gate de contexto operativo fail-closed

Cada ciclo sujeto a la metodología debe resolver el contexto operativo antes de ejecutar trabajo sustantivo dependiente del entorno. La verificación automática debe intentarse en primer lugar; no se debe asumir que una sesión RDC sigue activa solo porque existió en un ciclo anterior.

La secuencia es: `LEER ESTADO GLOBAL → DETECCIÓN AUTOMÁTICA → VERIFICACIÓN → PERFIL DE UBICACIÓN → CONTINUAR/BLOQUEAR`.

Una detección fallida, una fuente indisponible o una discrepancia no significan `INACTIVA`. Significan estado indeterminado y abren una única decisión al usuario: si la conversación requiere que exista una sesión RDC activa. Si la respuesta es sí, se solicita la información mínima para establecer y verificar la sesión y se bloquea la ejecución sustantiva hasta entonces, manteniendo abierta la conversación. Si la respuesta es no, se registra `RDC-REQUERIDA: NO` y el ciclo puede continuar sin dependencia de RDC.

La sesión RDC global se propaga entre conversaciones mediante el estado operativo compartido. La ubicación activa y su perfil se consumen del mismo contexto global; una ubicación sin perfil suficiente no puede producir reglas operativas por inferencia.

La separación de contexto de CECEQ es informativa: `fila4` identifica la identidad operativa de referencia y `central\\mantenimientorci` la identidad efectiva de la sesión RDC. No constituye una prohibición de uso de `central\\mantenimientorci`. La restricción operativa específica se limita a no clonar ni materializar repositorios nuevos dentro de su perfil o ruta.

El detalle técnico del gate y de la restricción de materialización se encuentra en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`.

## 17. Verificación normativa adaptativa por turno

Cuando la plataforma sea ChatGPT, Thinking es la ventana preferente para resolver la cascada normativa durante el razonamiento antes de la salida. `reasoning_mode` es metadato operativo: `THINKING`, `INSTANT`, `UNKNOWN` o `UNAVAILABLE`; no constituye una prueba del razonamiento interno y ninguno de esos estados bloquea por sí mismo la salida.

Cuando KHORA esté disponible, debe intentarse `HEALTH → OPEN → CASCADA → VERIFY → RELEASE`. Cuando KHORA no esté disponible, la salida continúa bajo el contrato vigente y el HUD declara `K: OFF`, sin atribuir verificación externa. El contrato vigente de salida es `v1.7.6`.

## 18. Formato de salida obligatorio por turno

El formato definido en `FORMATO-REGISTRO-VERIFICACION-CICLO.md` es obligatorio en **cada turno/ciclo, sin excepción**. Esto incluye aclaraciones, bloqueos, resoluciones conversacionales y respuestas sin cambios de repositorio.

La ausencia o alteración material del formato impide declarar `E: COMPLETADO`. La foliación global `CXXX` y la identificación del SI son parte inseparable del contrato.
