# GOV-TASK-011 — DTC · Dinámica Trilateral por Ciclo

**Estado:** en_curso · **Responsable de verificación:** Gobernanza, generación 11 (sesión `SES-20261101-GV8A19904`). **Ejecución/evidencia:** cada frente, bajo su propio control.


## 📍 REANUDACIÓN PRIORITARIA · DTC entre hilos · snapshot 2026-11-01

**Esta sección es la tarjeta operativa de recuperación.** Un hilo nuevo debe comenzar aquí y continuar sobre los mismos objetos y cursores; no debe reconstruir el sprint desde memoria conversacional ni crear buzones, tareas, OCP o dashboards paralelos.

### 1. Punto de entrada y orden de recuperación

1. Confirmar repositorio `SeryMente/metodologia`, rama `main` y HEAD actual. Leer `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; comprobar titularidad, sesión, generación, autorización y exclusividad. Si el control cambió, detener solo las escrituras afectadas y reconciliar.
2. Leer el DUG completo vigente: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`. En este snapshot: **Samantha v377 · NX-377m; Metacanon 1.28; GOW 2.17; blob `54064c8fe00f872023a455f06596061ed69062ae`**. Volver a resolver la revisión actual en cada hilo; este hash es un cursor, no una presunción de vigencia eterna.
3. Leer el índice `frentes/gobernanza/📁 🧭 - Tareas provisionales/README.md`; localizar esta tarea **GOV-TASK-011** y el recibo `frentes/gobernanza/evidencias/C-GOBERNANZA-DTC-01.json`. El índice de tareas es la vista integrada del OCP general del sprint; no crear un cuarto OCP.
4. Leer esta tarea completa y recuperar el último evento propio procesado del recibo DTC. Después, leer primero el objeto EP y luego el MCP-OCP (o el orden serial que indiquen sus respuestas pendientes); comparar sus entradas desde el cursor real anterior.
5. Para EP, leer `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, `frentes/ep/OEP.md`, el índice de tareas EP y la tarea original afectada. Para MCP-OCP, leer `frentes/mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md`, `MCP-METODOLOGIA.md` y su `CONTROL-RESPONSABILIDAD.json`.
6. Registrar la respuesta inicial de Gobernanza en el mismo objeto de comunicación que corresponda antes de otro trabajo sustantivo. Si no existe mensaje nuevo, dejar `SIN_NOVEDAD` y el cursor leído. No emitir una nueva solicitud mientras la anterior siga pendiente.

### 2. Secuencia obligatoria por ciclo

`PREFLIGHT → RECUPERAR_CURSOR → LEER_NOVEDADES → RESPUESTA_INICIAL / SIN_NOVEDAD → PROCESAR_TRABAJO_AUTORIZADO → DOCUMENTAR_CIERRE_EN_EL_MISMO_OBJETO → READBACK_EXACTO → INTEGRAR_EN_GOVERNANZA`.

La secuencia observable de comunicación es `PUBLICADO → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`. Si falta una fase, el ciclo es `CICLO_INCOMPLETO`. No se infiere lectura por publicación ni aceptación por read-back. Registrar lo reportado, observado, verificado y aceptado como estados separados. La falta de un ciclo observable es `SIN_CICLO_OBSERVADO`, no cumplimiento.

### 3. Estado de reanudación observado en este snapshot

| Frente | Cursor/estado persistido | Estado DTC actual |
|---|---|---|
| Gobernanza | Control blob `beecec6d4a3ca166019f3271bf2715a2c64bb6f1`; titular `SES-20261101-GV8A19904`, generación 11. Evento central `C-GOBERNANZA-DTC-MCP-20261101-02`, UUIDv7 local `01a19920-6700-7a89-9419-18026a9b0f27`. | El ciclo de Gobernanza solo se marca verificado tras el read-back del registro y la evidencia del evento actual. La sesión corresponsable es par independiente: no reasignar sus funciones ni tareas. |
| EP | Objeto de comunicación blob `7e3c55146647a83336612a1904c4c1f095015dd3`; ciclo EP abierto `C-EP-MOD-SCRIPTPWS-20261101-01`. OEP v0.3.23 / VCU-EP-v25 blob `3aebadf2f6e563128e69c3aed026fad01f86388f`; índice blob `3c1d1bb91bc4152dd783f7f3b12ba1f986c40018`; EP-TASK-002 blob `6d932628ac0afdf1039915bdd508f39f641a590c`. | `CUMPLE_PARCIAL`: apertura y respuesta inicial EP registradas; respuesta de Gobernanza publicada y ya leída/respondida por EP en la misma entrada. El procesamiento de MOD-SCRIPTPWS está documentado en OEP §94, pero falta completar el cierre DTC de esa entrada y el read-back final de la coordinación. Su control de responsabilidad no fue localizado en la fuente comprobada; titularidad/generación formal EP `NO_VERIFICABLE`. La actividad MOD-SCRIPTPWS pertenece a EP y no desplaza ni bloquea EP-TASK-002/MCP ciclo 06. |
| MCP-OCP | Objeto de coordinación blob `a5e848f14c36477f03fd5f015ce396e2d02180d2`; ciclo local 06 abierto en §29. Núcleo blob `e04e85fc8576244db3e4caefa0d05d2ed693fee7`; control blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, `owned`, generación 3, B `AUTHORIZED`. | `CUMPLE_PARCIAL`: Gobernanza respondió en §29.1 del mismo objeto; MCP-OCP aún debe leer/procesar la respuesta, completar §29, publicar evidencias/read-back y cerrar ciclo 06 antes de cualquier solicitud nueva. Build/test históricos no equivalen a pruebas frescas con main/DUG v377. |

**Rectificación histórica:** el bloque «Resultado de auditoría · 2026-10-31» y las menciones posteriores a EP fuera de `main`, OEP v0.3.20/21, DUG v373/v376 y MCP ciclos anteriores describen snapshots históricos. No describen este estado. La reconciliación de EP en `main` está asentada en OEP §92; el OEP actual visible es v0.3.23 / VCU-EP-v25. El ciclo MCP 05 cerró en §28.4; el ciclo vivo ahora es el 06 / §29. Se conserva el historial, pero esta tarjeta y el recibo DTC vigente lo rectifican para la reanudación.

### 4. Reglas que protegen la continuidad y el cierre del sprint

- Un objeto persistente por contraparte: EP usa su archivo de coordinación existente; MCP-OCP usa el suyo. Una sola entrada por ciclo, cursor verificable y respuestas append-only. Gobernanza integra en GOV-TASK-* y en el recibo de evidencia DTC.
- No crear una cuarta parte, OCP general adicional, buzón alternativo, tablero, dashboard o canal duplicado. No abrir otra solicitud a un frente con mensaje abierto.
- EP y MCP-OCP conservan sus controles, titulares, generación, autorizaciones, backlog y ejecución. Centralizar no significa suplantar. Las dos sesiones de Gobernanza registradas son corresponsables pares con mandatos independientes.
- La DTC es semiautomática por compuertas y cursores; no hay evidencia de disparador continuo autónomo. El procedimiento está persistido y se ha recuperado en este ciclo leyendo los objetos canónicos, pero una prueba de arranque en un hilo nuevo aún no se ha ejecutado: `COLD_START_TEST_PENDING`.
- El sprint solo puede declararse terminado cuando se verifique cada criterio rector y los estados terminales pertinentes. En MCP se distinguen `MVP_TECNICO_VERIFICADO`, `INTEGRADO_EN_MAIN` (autorización expresa del operador), `INSTALADO_EN_EP` (autoridad/autorización EP) y `ACEPTADO_POR_OPERADOR`. Ninguno se infiere de otro. Las tareas independientes de EP continúan en su OCP y solo entran en el sprint si la trazabilidad prueba dependencia con el criterio rector.
- FOL1 sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; los folios globales CV/CY/A/B siguen `PENDIENTE / NO ASIGNADO`. MCP-NORMATIVO permanece `DESACTIVADO`.

**Reanudación segura:** tras un reinicio, volver a leer las revisiones en `main`, identificar el último cursor *realmente procesado* por cada frente, leer cualquier mensaje posterior y continuar en la misma entrada abierta. No copiar sin verificación los blobs de este snapshot a modo de verdad actual; sirven para detectar cambios y evitar reiniciar la historia.

## Regla mínima — sin excepción

En cada ciclo real de Gobernanza, EP y MCP-OCP:

1. Tras el preflight, leer el registro provisional de tareas y el objeto de comunicación vigente.
2. Abrir una sola entrada en ese mismo objeto: identificador de ciclo, cursor real (rama/revisión/blob) y respuesta inicial; si no hay mensaje nuevo, registrar `SIN_NOVEDAD`.
3. Procesar solo trabajo autorizado y analizar la respuesta previa antes de abrir otra solicitud.
4. Al cierre, completar esa misma entrada con delta o `SIN_NOVEDAD`, tareas/estados, bloqueos, siguiente acción y evidencia.
5. Leer de vuelta el objeto y los documentos modificados.

Sin apertura, cierre o read-back, el ciclo queda incompleto. No sobrescribir entradas anteriores ni crear otro OCP, buzón, bitácora, control, sesión o folio.

## Verificación de Gobernanza

En cada ciclo propio, verificar los tres frentes y registrar uno de estos estados por frente: `CUMPLE_VERIFICADO`, `CUMPLE_PARCIAL`, `NO_CUMPLE`, `NO_VERIFICABLE` o `SIN_CICLO_OBSERVADO`. La falta de ciclo observable no equivale a cumplimiento. Gobernanza analiza la respuesta y formula como máximo una corrección material por frente. Esta verificación no transfiere ejecución, titularidad ni autorización.

## Objetos y registros

- **EP:** [comunicación provisional](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md), reconciliada por EP y visible en `main`; el cursor vigente se conserva en la tarjeta de reanudación de este documento. OEP e índice de tareas se consultan en `main`.
- **MCP-OCP:** [comunicación provisional](../../../mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md), en `main`; registro de tareas §8.1 y compuerta §10.1 de `MCP-METODOLOGIA.md`.
- **Gobernanza:** esta tarea, `GOBERNANZA.md`, `PENDIENTES.md` y la evidencia DTC.

## Resultado de auditoría · 2026-10-31

- **Gobernanza:** `CUMPLE_VERIFICADO` al cierre de este ciclo, sujeto al read-back final de los artefactos propios.
- **EP:** `CUMPLE_PARCIAL`. OEP v0.3.20 / VCU-EP-v22 e índice provisional en `main` ya contienen compuertas; el objeto de comunicación sigue únicamente en la rama documental y el addendum DTC no tiene respuesta específica. EP debe reconciliar el mismo objeto en `main`, preservando el historial.
- **MCP-OCP:** `CUMPLE_PARCIAL`. Control `owned`, generación 3; registro §8.1 y compuerta §10.1 presentes; respuesta inicial DTC registrada en §19. Falta el cierre/read-back de ese ciclo en el mismo objeto.

## Automatización y límites

La DTC es **semiautomática** mediante cursor, compuerta y registro obligatorio en cada ciclo. No se verificó un disparador autónomo que obligue a otros frentes a escribir ni monitoreo continuo; Gobernanza verifica en cada ciclo real. No declarar automatización plena.

## Procedencia

Instrucción directa del operador: mantener comunicación recurrente con EP y MCP-OCP mediante los objetos provisionales existentes, con lectura/respuesta al inicio y documentación/read-back al cierre. Se conserva la constitución y sus antecedentes en [crónica DTC](../../cronica/C-GOBERNANZA-DTC-01.md) y [evidencia DTC](../../evidencias/C-GOBERNANZA-DTC-01.json).

FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; los folios globales CV/CY/A/B continúan `PENDIENTE / NO ASIGNADO`.

## Continuidad DTC entre conversaciones

Reanudar en un hilo nuevo no reinicia el historial. Tras el preflight, recuperar desde `main` el DUG vigente, el núcleo/registro del frente y el último cursor del mismo objeto de comunicación; abrir una entrada de ciclo en ese objeto, procesar serialmente, completar el cierre y hacer read-back. Si no hay mensaje nuevo, escribir `SIN_NOVEDAD` con cursor. No crear otro canal ni declarar completo un ciclo sin apertura, cierre y read-back.

**Última revalidación:** Gobernanza `CUMPLE_VERIFICADO`; EP `CUMPLE_PARCIAL` (OEP §90 e índice de tareas con compuerta, pero objeto fuera de `main` y acuse específico al addendum pendiente); MCP-OCP `CUMPLE_VERIFICADO` para el ciclo local §19–20, aunque su núcleo conserva una referencia obsoleta que MCP-OCP debe corregir en su propio ciclo.

---

## Endurecimiento 02 · Gobernanza como frente centralizador del OCP general del sprint · 2026-10-31

### 1. Distribución de gobierno y responsabilidad

La DTC — Dinámica Trilateral por Ciclo — se amplía operativamente: **Gobernanza es el frente centralizador e integrador del sprint**, no solo su auditor. EP y MCP-OCP son los otros dos frentes ejecutores y deben comunicarse con Gobernanza desde sus propios OCP en cada ciclo real. No se crea un cuarto frente, OCP ni canal.

- **Operador + Gobernanza:** gestionan el sprint en este frente y esta conversación. Aquí se integran los avances, se contrastan con el criterio rector, se priorizan dependencias y se toman las decisiones que requieren al operador.
- **Gobernanza:** mantiene el conjunto de tareas integradoras y las tareas propias del frente; traduce reportes en decisiones, dependencias, criterios de aceptación y trabajo verificable. Puede desarrollar sus propios constructos y avanzar entregables independientes dentro de su ámbito autorizado, sin esperar a que los otros frentes terminen.
- **EP:** ejecuta lo que corresponde a su OCP, principalmente entorno, persistencia, alojamiento e instalación dentro de sus controles y autorizaciones; reporta en su objeto de comunicación existente.
- **MCP-OCP:** ejecuta diseño/implementación/pruebas del servidor y sus artefactos dentro de su OCP, control y autorización; reporta en su objeto de coordinación existente.

Ningún frente puede asumir, reasignar o ampliar por inferencia la titularidad, el alcance, los permisos o las decisiones de otro.

### 2. OCP general del sprint

El registro provisional de tareas de Gobernanza, ubicado en [frentes/gobernanza/📁 🧭 - Tareas provisionales/README.md](../README.md), representa operativamente **el OCP general del sprint**. El conjunto de tareas alojadas bajo el OCP Gobernanza constituye el backlog integrado del sprint.

Esta representación no crea un nuevo OCP ni desplaza la autoridad de los OCP ejecutores:

1. Las tareas GOV-TASK-* contienen los resultados propios de Gobernanza y los resultados integradores que requieren coordinación o decisión central.
2. Cuando una tarea dependa de trabajo EP o MCP-OCP, se registra el vínculo a la tarea original, su OCP, su estado reportado, evidencia y cursor. No se copia el backlog técnico del frente ni se convierte el resumen central en fuente técnica autoritativa.
3. El estado detallado del trabajo técnico permanece en el OCP del frente responsable. Gobernanza mantiene el estado integrado, las dependencias, las decisiones, los criterios de aceptación y la evidencia de verificación.
4. Toda tarea integrada debe tener resultado esperado, criterio de verdad/aceptación, fuente responsable, evidencia exigida, dependencias y siguiente acción. No se declara completada por un reporte, promesa o porcentaje subjetivo.
5. El trabajo propio de Gobernanza —análisis, especificación, diseño de contratos, normalización, pruebas de aceptación, reconciliación y documentación— también forma parte del mismo sprint cuando contribuye a sus resultados. No queda relegado a una función pasiva de auditoría.
6. No crear dashboards, índices paralelos, duplicados de tareas, canales auxiliares ni un objeto general separado: el registro existente es la única vista integrada de trabajo de Gobernanza.

### 3. Criterio rector y criterio de verdad

El DUG canónico vigente en SeryMente/metodologia/main es la fuente normativa preponderante para Gobernanza. En cada tarea se debe aplicar el principio pertinente del DUG completo y la autorización real que corresponda. La instrucción expresa del operador define el objetivo y las decisiones del sprint dentro de ese marco; no permite simular evidencia, saltar una autorización o contradecir una norma superior.

Separar siempre:

- **Objetivo/decisión:** qué resultado fue solicitado o decidido por el operador.
- **Criterio de verdad:** qué norma, condición o criterio observable determina que el resultado es correcto.
- **Estado reportado:** lo que el frente declara.
- **Estado observado:** lo que Gobernanza pudo leer directamente en una fuente identificada.
- **Estado verificado:** lo que quedó demostrado por artefactos, revisiones, commit/blob, hash, pruebas y lectura de vuelta aplicables.
- **Aceptación:** la decisión de aceptación que corresponde al operador o a la autoridad designada; no se presume por persistencia.

Usar la secuencia PROPUESTO → AUTORIZADO → PUBLICADO → LEÍDO → RESPONDIDO → PROCESADO → DOCUMENTADO → VERIFICADO_READBACK → ACEPTADO, pero solo marcar los estados efectivamente acreditados. Si el DUG no define un campo, contrato, ruta, permiso o criterio, se declara no definido/no verificado; no se completa por intuición. Si una condición obligatoria no está probada, mantener la compuerta cerrada.

### 4. Secuencia DTC reforzada por ciclo

Cada ciclo real de cualquiera de los tres frentes debe dejar una entrada de apertura y cierre en su objeto de comunicación ya existente:

1. Preflight de identidad, frente, control, titularidad, generación, autorización y exclusividad.
2. Recuperar desde la fuente canónica el último cursor efectivamente procesado del mismo objeto.
3. Leer los mensajes posteriores al cursor y responder al inicio del ciclo, antes del trabajo sustantivo. La respuesta inicial identifica el mensaje, interpreta el encargo, declara viabilidad/bloqueos y define qué se procesará ahora. Sin novedades, registrar SIN_NOVEDAD más el cursor realmente leído.
4. Procesar el trabajo autorizado y las tareas independientes del frente, respetando la serialidad de mensajes.
5. Al cierre, completar la misma entrada con cambios, tareas/estados, evidencia, commit/blob/SHA cuando existan, discrepancias entre reportado y observado, decisiones, bloqueos y siguiente acción.
6. Hacer read-back del objeto de comunicación y de todos los documentos modificados.
7. Si falta apertura, procesamiento, cierre o read-back, declarar CICLO_INCOMPLETO; no compensarlo con una nota en este frente.
8. Al recibir el reporte en un ciclo real de Gobernanza, leer la respuesta antes de formular una nueva solicitud a ese frente, actualizar el registro integrado y verificar su estado.

Al iniciar en una conversación nueva se recupera el último cursor del mismo OCP/objeto; no se reinicia la historia. No hay monitoreo continuo ni obligación de escritura autónoma entre ciclos mientras no exista un disparador técnico demostrado.

### 5. Autonomía de progreso de Gobernanza

Gobernanza debe mantener avance propio en cada ciclo: identificar la siguiente tarea integradora permitida, leer las fuentes canónicas, derivar dependencias, preparar constructos, producir especificaciones dentro de su ámbito, realizar auditorías y pruebas documentales, y dejar sus propios cambios persistidos y leídos de vuelta cuando estén autorizados.

La falta de reporte de otro frente no paraliza trabajo independiente. Sí bloquea el trabajo que dependa materialmente de ese reporte, una autorización, una credencial, una prueba del host o una decisión reservada al operador. No se suplanta al ejecutor ni se declara ejecutado un trabajo ajeno.

### 6. Estado observado al endurecer la DTC · 2026-10-31

- **EP — CUMPLE_PARCIAL:** el mismo objeto de comunicación fue reconciliado por EP en main, blob bbf13313218773fab4268d48626ff5eccdab1127, y contiene acuse específico del addendum DTC. El ciclo local C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01 tiene apertura y respuesta inicial; en la lectura actual todavía no se observan cierre ni read-back de ese ciclo. No se declara completo.
- **MCP-OCP — CUMPLE_VERIFICADO para sus ciclos locales 01 y 02:** su OCP de comunicación registra apertura/cierre/read-back en §§19–20 y §§21–22; núcleo v0.1.6, blob e6e96ee4edde7156ddc9f9a9e302faa9f8ed4ffa; control owned, generación 3, blob 3e6f96e919c33c3015478b7fd0f262b1bee47b0c.
- **Solicitud única de dependencias de MCP-OCP:** MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01, §20.3, fue leída y respondida por Gobernanza en §§23–24 del mismo objeto. La respuesta final está persistida y verificada por read-back; las dependencias no quedan resueltas: metadata DUG solicitada 0/43; Sink especificado pero aliases pendientes de despliegue/prueba; telemetría limitada a frecuencia sin extensión aprobada; FOL1 inactivo. Se mantiene fail-closed donde corresponda.
- **DUG:** v373 · NX-373m; blob cac4525de77d4f47a8a59c25201968ecf2056b90. **FOL1:** PREPARADO_PENDIENTE_ACTIVACION_IPZ; sin folios globales asignables.

---

## PROMPT ADICIONAL 02 — DTC COMO CENTRALIZACIÓN DEL OCP GENERAL DEL SPRINT

**Estado: PREPARADO_NO_PUBLICADO.** Complementa el prompt correctivo anterior; no lo sustituye. No se ha enviado a EP ni MCP-OCP.

### Instrucción común

Adopta y aplica la DTC — Dinámica Trilateral por Ciclo — bajo este modelo reforzado. Gobernanza es el frente centralizador e integrador del sprint. EP y MCP-OCP continúan siendo frentes distintos, cada uno con su OCP, núcleo, registro de tareas, control, titularidad, alcance y evidencia propios.

El operador y Gobernanza gestionan el sprint y toman las decisiones centrales en la conversación/OCP de Gobernanza. Los frentes informan, ejecutan lo autorizado en sus ámbitos, presentan evidencia y formulan propuestas. No deciden por inferencia sobre el alcance o las tareas de los otros frentes.

### Autoridad del OCP general del sprint

El registro provisional de tareas de Gobernanza es la representación operativa del OCP general del sprint. El conjunto de tareas GOV-TASK-* integra resultados de Gobernanza y dependencias cruzadas. No crear un cuarto OCP, un tablero, dashboard, backlog duplicado ni canal alternativo.

Cuando el resultado dependa de EP o MCP-OCP, enlaza la tarea original, el OCP responsable, su estado reportado y su evidencia; no dupliques ni suplantes su backlog técnico. El frente conserva la autoridad del detalle de su trabajo. Gobernanza mantiene el estado integrado, las dependencias, decisiones, criterios de aceptación y verificaciones.

### Criterio de verdad

La fuente normativa es el DUG vigente en SeryMente/metodologia/main, considerado en su totalidad y según precedencia, con los principios pertinentes y el CNP. El criterio de cada tarea debe derivarse de esa fuente, de la instrucción expresa del operador y de las condiciones reales de autorización.

Nunca equipares un reporte con un hecho probado. Distingue objetivo solicitado, criterio de verdad, estado reportado, estado observado, estado verificado y aceptación. Para afirmar ejecución, inspecciona el artefacto y su revisión canónica; usa commit/blob/SHA, pruebas y read-back según corresponda. Si falta evidencia o el DUG no define el campo/contrato, declara la brecha y falla de forma cerrada. No inventes metadatos, endpoints, enlaces, permisos, resultados ni folios.

### Obligaciones por ciclo de cada frente

En cada ciclo real, sin excepción:

1. Ejecuta preflight de identidad, control, titularidad, generación, autorización y exclusividad.
2. Recupera el último cursor realmente procesado del objeto de comunicación existente.
3. Lee el mensaje nuevo y registra una respuesta inicial al inicio del ciclo, antes de otro trabajo sustantivo; sin novedad, registra SIN_NOVEDAD y el cursor.
4. Procesa el trabajo autorizado dentro de tu OCP y respeta la serialidad: no abras una nueva solicitud mientras otra siga pendiente de respuesta o procesamiento.
5. Cierra la misma entrada con novedades, tareas/estados, evidencia, cambios, commits/blobs/SHA, bloqueos y siguiente acción.
6. Lee de vuelta el objeto y cada documento modificado.
7. Si falta apertura, respuesta inicial, procesamiento, cierre o read-back, declara CICLO_INCOMPLETO.
8. Al continuar en un hilo nuevo, recupera el mismo objeto y cursor. No reinicies ni dupliques el historial.

### Progreso propio de Gobernanza

Gobernanza no es un buzón pasivo. Puede y debe avanzar sus propias tareas: investigación documental, análisis, normalización, descomposición de trabajo, definición de criterios, arquitectura de información, contratos, propuestas, documentación, pruebas de aceptación y reconciliaciones dentro de su ámbito autorizado. Debe derivar la siguiente acción útil de cada ciclo y persistir sus propios resultados en sus objetos existentes.

El trabajo independiente puede continuar aunque un frente tenga un bloqueo. Solo se detiene lo que depende materialmente de la respuesta, credencial, decisión, permiso o prueba pendiente. Nunca ejecutar en nombre de otro frente ni modificar su control, núcleo, host o código fuera de autorización explícita.

### Instrucciones específicas a EP

Mantén tu OCP como autoridad del entorno, persistencia, alojamiento, instalación y operación bajo tu control. Comunícate en el mismo objeto DTC; cierra el ciclo local abierto con evidencia y read-back antes de recibir una nueva solicitud material de Gobernanza. Informa separadamente lo reportado y lo verificado. No modifiques DUG, MCP-OCP, su control ni el host/código del servidor MCP-OCP por inferencia. Toda acción sobre credenciales, B2, host, ACL o recursos persistentes requiere la autorización específica y el preflight aplicable.

### Instrucciones específicas a MCP-OCP

Mantén tu OCP como autoridad sobre el servidor MCP-OCP, sus fuentes, pruebas, empaquetado y documentación dentro del control vigente. Comunícate en el mismo objeto DTC y mantén tu backlog §8.1 actualizado. No modifiques EP, su host/control, DUG, IPZ ni actives MCP-NORMATIVO. Conserva el fail-closed: no completes por inferencia campos que no existan en el DUG. El mecanismo individual vigente en ART-027 se denomina **Sink** (p001…p043); sus aliases siguen pendientes de despliegue/prueba. No lo denomines Sync ni fabriques URLs operativas sin una decisión y evidencia nuevas. La telemetría autorizada en el DUG es frecuencia de acceso/consulta, no aplicación; no amplíes su semántica unilateralmente.

### Formato mínimo de reporte

En el objeto OCP existente registra: identificador local de ciclo o folio global válido; cursor; mensaje procesado; respuesta inicial; tareas de origen y estado; trabajo ejecutado; evidencia observada; commit/blob/SHA y read-back; diferencias entre reporte y observación; bloqueos; decisiones requeridas al operador; siguiente acción.

No inventes folio global. Mientras FOL1 permanezca inactivo, usa solo identificadores locales inequívocos y declara los folios globales PENDIENTE / NO ASIGNADO.

### Condición de aceptación

El contrato se considera incorporado al frente únicamente cuando el responsable lo haya leído, respondido, procesado dentro de su propio ciclo, documentado en su OCP existente y verificado mediante read-back. La publicación del prompt por Gobernanza solo prueba PUBLICADO; no prueba LEÍDO, ACEPTADO ni APLICADO.


---

## Revalidación posterior · cierre del ciclo local EP · 2026-10-31

Una lectura nueva del mismo objeto EP encontró una actualización posterior al snapshot anterior. EP completó el ciclo local DTC C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01 en la entrada final de ese objeto:

- **Secuencia registrada:** LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK.
- **Identificador auxiliar local:** UUIDv7 01a194ba-967a-7b0f-896f-599034966c37, no ID nativo ni folio global.
- **Objeto DTC en main:** blob 1131bb584268f393eb16c7a19120eb800d2043cd; commit de cierre f1d60570cd80c97d2c70c1fbb11f59ca7ba06c19.
- **Artefactos relacionados observados:** OEP v0.3.21 / VCU-EP-v23, blob c0c65c473711881a1d1692bec757b283eca3eb34; índice EP, blob f55b2db5f1ac9c44c17d1f83078e651ccdf868ed; revisión REVISION-OEP-v0.3.21.json, blob 87419509768c0c77a0e18af83e1f94603bdd4142; manifiesto de revisión, blob b3a6822de30eaf6df5dc17ba8bc4058bffa60c56. El manifiesto declara lectura exacta y huellas SHA-256/Git de los documentos afectados.
- **Estado:** CUMPLE_VERIFICADO para la compuerta documental de este ciclo local EP. La tarea EP-TASK-002 permanece en_curso: autenticación B2, bucket/clave, cargas, read-back remoto y restauración siguen no verificados/no ejecutados.

Esta observación supersede la fotografía inmediatamente anterior que dejaba el ciclo EP abierto. No cierra la tarea de persistencia ni la DTC recurrente: en cada ciclo futuro se repetirá la compuerta. La DTC global/GOV-TASK-011 permanece en_curso.



---

## Reanudación y auditoría DTC · C-GOBERNANZA-RETOMA-08 · 2026-11-01

**Ciclo local de Gobernanza:** `C-GOBERNANZA-RETOMA-08` (identificador de evento local; no folio global). FOL1 inactivo.

### Cursores adquiridos

| Fuente | Revisión leída en `main` | Estado observado |
|---|---|---|
| OEP EP | blob `deaceadfc1de4636e0f9114a47a3d5255c04e897`, v0.3.22 / VCU-EP-v24 | vigente en `main` |
| Índice tareas EP | blob `3c1d1bb91bc4152dd783f7f3b12ba1f986c40018` | EP-TASK-002 `en_curso` |
| Comunicación EP | blob `24939fbe18b250256116f8556d96ae3c33bde238` | ciclo local `C-EP-DTC-PROMPT02-20261031-02` cerrado/read-back por EP |
| Núcleo MCP-OCP | blob `15d6fe1a65d52c52215378fd12a49c3a651d6d73`, v0.1.9 | §8.1 aún conserva fotografía histórica ciclo 03/04 |
| Control MCP-OCP | blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, generación 3 | autoridad del frente sin cambios |
| Comunicación MCP-OCP | blob `4c6f9c12be9c227f66f71c149cef2d00db7dd17f` | ciclo local 05 abierto en §28; no se observó cierre/read-back del 05 |

### Verificación por frente

- **Gobernanza — `CUMPLE_VERIFICADO` para este evento:** transferencia primaria generación 11, persistencia documental, manifiesto, crónica/evidencia e índices propios actualizados y leídos de vuelta.
- **EP — `CUMPLE_VERIFICADO` limitado al ciclo documental local:** EP registró apertura, respuesta, procesamiento, documentación y read-back del Prompt Adicional 02. No confundir con cierre de EP-TASK-002: autenticación B2, bucket/clave, upload, SHA remoto, read-back y restauración no ejecutados/verificados.
- **MCP-OCP — `CUMPLE_PARCIAL`:** el objeto de coordinación abrió ciclo local 05 y registró respuesta inicial/SIN_NOVEDAD respecto de su cursor previo. No se observó cierre/read-back del ciclo 05. La discrepancia entre el estado de §8.1 del núcleo y §28 de la coordinación queda a cargo de MCP-OCP; Gobernanza no modifica su OCP/control ni abre una solicitud duplicada.
- **DTC global — `EN_CURSO_RECURRENT`:** no se cierra por el cumplimiento de un ciclo local de uno de los frentes.

### Cierre de Gobernanza

La entrada de este ciclo quedó integrada en el objeto GOV-TASK-011; el índice, núcleo, pendientes, manifiesto, crónica, evidencia, control y original se leyeron de vuelta en `main`. Los estados ajenos se conservan como observados en sus fuentes, no como ejecución propia ni aceptación del operador.

**Siguiente acción:** recibir y analizar el cierre/read-back de MCP-OCP ciclo local 05 en su objeto actual; mantener EP-TASK-002 y las dependencias de EP abiertas hasta evidencia material. No abrir nuevos turnos paralelos mientras exista procesamiento en curso.

**Folios:** CONV global, CICLO global, A/B y OCP globales: `PENDIENTE / NO ASIGNADO`. Sesión de esta titularidad: `SES-20261101-GV8A19904`.



---

## Revisión DTC permanente · C-GOBERNANZA-DTC-REVISION-01 · 2026-11-01

**Instrucción literal del operador:** «Ciclo a ciclo sin excepcion revisaras. Documetna la comunicacion, y sigue con lo otro por mientras».

**Respuesta inicial de Gobernanza:** se adopta la revisión DTC como compuerta recurrente obligatoria en cada ciclo, sin excepciones ni sustitución por fotografías históricas. Al iniciar cada ciclo de Gobernanza se releerán el control propio y los objetos de comunicación canónicos de EP y MCP-OCP, se recuperarán los cursores realmente procesados, se contrastarán los cambios posteriores y se clasificará cada frente por separado. La misma entrada se documentará con la respuesta inicial; al cierre se registrarán procesamiento, evidencia, commit/blob, read-back, bloqueos y siguiente acción. Si falta una fase, el ciclo correspondiente queda incompleto. La revisión no autoriza ejecutar en nombre de EP o MCP-OCP ni modifica sus controles o alcances.

### Revisión de fuentes y estado observado

| Frente / fuente | Cursor o revisión leída | Estado observado en este ciclo |
|---|---|---|
| Gobernanza · control | `CONTROL-RESPONSABILIDAD.json`, blob `beecec6d4a3ca166019f3271bf2715a2c64bb6f1` | Titular generación 11, sesión `SES-20261101-GV8A19904`; corresponsable conservado; dos responsables activos, dentro del máximo autorizado. |
| EP · comunicación | `COORDINACION-GOBERNANZA-EP-v0.1.md`, blob `24939fbe18b250256116f8556d96ae3c33bde238` | Último ciclo documental visible: `C-EP-DTC-PROMPT02-20261031-02`, cerrado y read-back declarado/verificado por EP. OEP v0.3.22 / VCU-EP-v24. EP-TASK-002 sigue `en_curso`; autenticación/cuenta/región/bucket/clave B2, carga, SHA remoto, read-back remoto y restauración siguen sin ejecutar o verificar. |
| MCP-OCP · comunicación | `COORDINACION-SPRINT-OCP-MCP-v0.1.md`, blob `e6c375a79ca0a431000aa607ff2dfe9252abafd9` | §28.4: ciclo local 05 cerrado como `CUMPLE_VERIFICADO`, con procesamiento técnico, evidencia y read-back. §29: ciclo local 06 abierto, con preflight y respuesta inicial registrados; todavía no se observa procesamiento/cierre/read-back del 06 en esta revisión. La integración a `main`, instalación en EP y aceptación siguen explícitamente pendientes. |
| DTC global | Este registro integrado y GOV-TASK-011 | `EN_CURSO_RECURRENT`; el cierre local 05 de MCP-OCP no cierra el ciclo 06 ni la DTC global. |

**Corrección de fotografía previa:** el registro anterior de Gobernanza clasificaba MCP-OCP como `CUMPLE_PARCIAL` por no observar el cierre del ciclo 05. La revisión actual encuentra §28.4 ya cerrado y read-back registrado; esa clasificación anterior queda supersedida para el ciclo 05. La novedad actual es el ciclo local 06 abierto en §29. No se envió una solicitud nueva a MCP-OCP porque su ciclo 06 ya está en curso.

### Regla obligatoria para todos los ciclos siguientes

1. **Preflight:** releer el control de Gobernanza y validar titular, generación, autorización y límites; consultar los objetos canónicos EP y MCP-OCP y sus controles cuando estén disponibles.
2. **Cursor:** recuperar el último cierre/read-back real de cada objeto de comunicación; no asumir que la última sección abierta fue procesada.
3. **Apertura y respuesta:** registrar la novedad o `SIN_NOVEDAD` y la respuesta inicial antes de trabajo sustantivo.
4. **Contraste:** actualizar por separado el estado reportado, observado, verificado y aceptado de cada frente; revisar cambios de sus OCP/evidencias referenciadas cuando la novedad lo requiera.
5. **Serialidad:** no duplicar solicitudes ni abrir trabajo externo paralelo mientras haya procesamiento pendiente en el mismo frente.
6. **Cierre:** documentar en el mismo objeto la acción autorizada de Gobernanza, resultados, evidencias, rutas, commit/blob/SHA, read-back, bloqueos y siguiente paso. Leer de vuelta todo lo modificado.
7. **Incumplimiento:** si cualquier fase no puede completarse, declarar `CICLO_INCOMPLETO` y el motivo preciso; nunca sustituir una revisión faltante por memoria o por un snapshot anterior.

**Alcance:** esta regla obliga a Gobernanza a revisar y documentar cada ciclo. No crea sincronización autónoma en segundo plano, no modifica los controles de EP/MCP-OCP, no activa FOL1 ni MCP-NORMATIVO y no convierte reportes en aceptación.

**Trabajo independiente autorizado:** mientras MCP-OCP procesa su ciclo 06, Gobernanza continúa la preparación estructural del DUG solicitada por el operador, sin modificar los OCP ejecutores ni esperar una respuesta que no sea dependencia material.

**Folios:** este es un identificador local de revisión; no asigna folio global. CV/CY/A/B y folios OCP: `PENDIENTE / NO ASIGNADO`. Sesión Gobernanza: `SES-20261101-GV8A19904`.



### Ejecución independiente autorizada · DUG v376 · C-GOBERNANZA-FT-MODULOS-01

**Instrucción del operador:** preparar el DUG estructurado y listo para el trabajo con MCP; definir un anexo de Módulo como subfrente funcional interno para frentes multifacéticos; formalizar la estructura y las características canónicas de un FT; no modificar por ahora otros objetos distintos del DUG.

**Resultado:** DUG actualizado en su única fuente canónica `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, Samantha v376 · NX-376m, commit `25bf9e6ed55eff010b0d8ddd53dd2cc7271b616d`, blob `657225b9c6c4d7bb46aad78fcd6c95de49ea1689`. Lectura posterior desde `main`: contenido exacto coincidente.

**Cambios incorporados:**
- ART-029, hijo documental de ART-021, define Módulo de FT como subfrente funcional interno que hereda autoridad, titularidad, sesión, generación, OCP, núcleo y control del FT padre; no crea FT/OCP/control independiente por defecto.
- ART-019 formaliza identidad, Propósito, responsabilidad, límites, autonomía de gobierno, estado y composición modular del FT.
- ART-021 desarrolla estructura canónica, ficha mínima, características constitutivas, materialización y criterios de aceptación.
- ART-015 y ART-020 distinguen módulos, ámbitos y subámbitos; Metacanon §§46/51 queda en 1.27; taxonomía estructurada 1.4.
- GOW 2.16 incorpora el término «Módulo de frente de trabajo (subfrente funcional)» y lo añade a §ARR.
- La estructura de máquina registra explícitamente que el módulo no es nivel taxonómico, no tiene OCP/núcleo/control independiente y hereda el gobierno del FT padre.

**Validaciones de read-back:** JSON embebido parseado; 22 anexos declarados y 22 artefactos presentes; ART-029 → ART-021; IDs de anexos únicos; referencias internas a anexos sin destinos rotos; términos GOW y modelo estructurado del módulo presentes; título/footer v376/NX-376m coincidentes.

**Límite:** las cuatro divisiones propuestas para EP (continuidad/persistencia remota; adaptación/materialización local; identidad/autenticación/sesiones; recuperación/verificación) se presentan solo como ejemplo. No se crearon ni modificaron módulos, carpetas, tareas, OCP o controles de EP. Tampoco se modificó el OCP/control/código de MCP-OCP. El JSON está estructurado y legible para consumo; no se afirma prueba de integración del DUG con el servidor MCP ni activación de MCP normativo.

### Revisión DTC al cierre de esta ejecución

- EP comunicación: blob `24939fbe18b250256116f8556d96ae3c33bde238`; último ciclo visible `C-EP-DTC-PROMPT02-20261031-02`, con cierre/read-back propio; EP-TASK-002 continúa `en_curso`.
- MCP-OCP comunicación: blob `e6c375a79ca0a431000aa607ff2dfe9252abafd9`; ciclo 05 cerrado `CUMPLE_VERIFICADO` en §28.4; ciclo 06 abierto en §29, sin secciones de procesamiento/cierre observadas en este corte.
- DTC global: `EN_CURSO_RECURRENT`; se conserva la obligación de revisar los tres frentes en cada ciclo sin excepción. No se abrió una solicitud nueva a MCP-OCP mientras el ciclo 06 sigue abierto.

**Siguiente acción de Gobernanza:** en el próximo ciclo, recuperar de nuevo ambos objetos y sus cursores; procesar el delta de MCP-OCP 06 cuando exista cierre y read-back, y continuar únicamente trabajo independiente autorizado mientras tanto.


## Ajuste DTC · conversaciones pares en Gobernanza y ruta terminal MCP-OCP · 2026-11-01

**Evento local:** `C-GOBERNANZA-DTC-MCP-20261101-01` (no es folio global).  
**UUIDv7 local:** `01a1991b-1591-7c08-b783-5975e26e4d31` (identificador auxiliar local; no ID nativo de plataforma).  
**Secuencia de este ciclo:** `PREFLIGHT → CURSORES_LEÍDOS → RESPUESTA_INICIAL → AJUSTE_DTC_PROCESADO → DOCUMENTADO → VERIFICADO_READBACK`.  
**Cursor base de Gobernanza:** GOV-TASK-011 blob `3aecf91e82c199e03eba703a6650250db65e3c14`; evidencia DTC blob `48fb2dcec0a1d9b90bd565069c5c36b7e0180eda`.  
**Decisión de apertura:** no enviar solicitud nueva a MCP-OCP mientras ciclo local 06 permanezca abierto; conservar la única entrada/canal vigente.  

### 1. Corrección de gobierno: conversaciones pares, no equipo subordinado

El frente Gobernanza mantiene dos sesiones responsables activas registradas en su control: titular y corresponsable. **Son conversaciones pares e independientes dentro del mismo frente**. El corresponsable conserva sus propias funciones, mandato, autonomía y obligaciones; no integra un equipo dirigido por el titular de esta conversación, no queda subordinado a él y este registro no le asigna tareas, rol de revisor ni funciones nuevas. Cada sesión actúa conforme a su responsabilidad y autorización propias. El límite vigente de dos responsables activos se conserva.

La DTC coordina la **interfaz entre resultados**, no dirige a las conversaciones ni redistribuye sus funciones. No crea un FT, OCP, control, sesión, canal, buzón, bitácora o backlog adicional. El registro GOV-TASK-011 sigue siendo la vista integrada de Gobernanza; cada OCP ejecutor conserva la autoridad de su detalle técnico.

**Límite de transporte y observabilidad:** esta conversación no puede enviar instrucciones, inspeccionar el contexto privado ni controlar directamente el modelo de la otra conversación. Una instrucción preparada aquí no equivale a entregada, recibida o aplicada allí. Un resultado de la otra sesión solo entra al estado integrado cuando queda disponible en el objeto persistente compartido o se aporta por un medio verificable. No se presupone sincronización entre conversaciones.

### 2. Contrato mínimo de interoperabilidad entre conversaciones

Cada conversación conserva su propio ciclo/cursor. Para integrar un resultado basta con registrar, sin duplicar el documento de origen:

- sesión responsable identificada por el alias/folio que ya conste en el control; no crear identificadores nativos ni folios globales;
- identificador local de ciclo y tarea de origen;
- fuente exacta leída: repositorio, rama, commit/revisión y blob;
- delta concreto y artefactos afectados, con hashes cuando existan;
- estado separado: reportado, observado, verificado y aceptado;
- dependencias, bloqueo, decisión requerida y siguiente acción.

La DTC no exige que una conversación espere a la otra para realizar trabajo independiente. Si ambas necesitan modificar el mismo archivo, las escrituras se serializan: releer el blob inmediatamente antes de escribir, actualizar condicionado a ese SHA y hacer read-back; ante SHA distinto, abortar esa escritura, releer y reconciliar. Pueden existir análisis o propuestas paralelas, pero no escrituras concurrentes sobre la misma revisión ni sobrescrituras de resultados ajenos.

### 3. Objetivo de cierre: separar ciclo DTC de terminación técnica MCP-OCP

El cumplimiento de un ciclo MCP-OCP acredita su disciplina de ciclo, **no la terminación ni aceptación del producto**. La DTC administrará dos estados distintos:

1. **Ciclo local MCP-OCP:** apertura, respuesta inicial, procesamiento, documentación y read-back en el mismo objeto de coordinación.
2. **Resultado técnico MCP-OCP:** implementación candidata reproducible, pruebas actuales, paquete/manifiestos verificados, documentación técnica y decisión explícita sobre integración/aceptación.

El DTC no cerrará GOV-TASK-011 por el mero cierre de un ciclo local. Tampoco afirmará que el OCP MCP está terminado mientras el producto siga sin integración canónica o falten criterios de aceptación materiales.

### 4. Ruta de menor número de ciclos para MCP-OCP

**Estado de entrada observado:** coordinación MCP-OCP en `main`, blob `e6c375a79ca0a431000aa607ff2dfe9252abafd9`; ciclo local 05 cerrado y read-back en §28.4; ciclo local 06 abierto en §29. El cursor de apertura del ciclo 06 cita el blob previo `5a52046e9390019adb110d96d500d2998b637bbc`. Núcleo MCP-OCP actual en `main`, blob `e04e85fc8576244db3e4caefa0d05d2ed693fee7`; control `owned`, generación 3, blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, autorización B `AUTHORIZED` sin ampliación.

La comparación recién observada entre `main` y `build/ocp-mcp-mvp-0.1.0` es `diverged`: 11 commits propios de build y 236 commits detrás; merge-base `e4243414b0099ede9b9556b3cfa0bb20bc706576`. La cabeza de `main` observada en la comparación es `02ddcc4159919f411ff53bf4bd22c96a18bd63d3`. El DUG vigente es v376 · NX-376m, commit `25bf9e6ed55eff010b0d8ddd53dd2cc7271b616d`, blob `657225b9c6c4d7bb46aad78fcd6c95de49ea1689`.

**Regla inmediata:** no abrir otra solicitud ni un ciclo duplicado a MCP-OCP mientras §29/ciclo local 06 siga abierto. Primero debe completar en esa misma entrada el procesamiento, cierre y read-back. La DTC actualizará el estado solo después de leerlo de vuelta desde la fuente canónica.

**Siguiente paquete único de ejecución, preparado para el ciclo posterior al 06; aún no enviado ni considerado recibido:**

1. Partir del `main` vigente en ese ciclo y reconciliar selectivamente solo código, pruebas y scripts técnicos propios del producto. No hacer merge global de la rama divergida y no sustituir README, núcleo, control, coordinación ni documentos canónicos de `main` con sus versiones antiguas de build.
2. Formar una candidata limpia basada en `main`; actualizar referencias/pins únicamente contra blobs actuales observados, incluido DUG v376 y el núcleo MCP-OCP vigente. Mantener gate fail-closed ante cualquier fuente desfasada.
3. Ejecutar sobre esa candidata, en un mismo ciclo, compilación, pruebas unitarias, integración, smoke/negativas, seguridad, backup/restauración y verificación de las herramientas/contratos realmente incluidos. Regenerar ZIP, manifiestos y SHA-256 desde esa revisión; no reutilizar los resultados históricos 31/31 y 29/29 como prueba de la candidata nueva.
4. Persistir en el OCP MCP la candidata, evidencia detallada, hashes, resultados, limitaciones y cambios de §8.1/README que sean propios del frente. Cerrar la misma entrada DTC con commit/blob y read-back exactos.
5. Presentar un único informe de decisión: `MVP_TÉCNICO_VERIFICADO`, `BLOQUEADO` con causa/evidencia, o `CANDIDATA_NO_VERIFICADA`. No abrir rondas generales. Solo una corrección focalizada adicional si una prueba o criterio material falla; toda repetición debe nombrar el fallo que resolverá.

### 5. Compuertas de alcance y decisión final

- **Dentro de B vigente:** implementación, correcciones, compilación, pruebas, manifiestos, paquete y documentación técnica dentro de `frentes/mcp-metodologia/`.
- **Integración/merge a `main`:** no está comprendida expresamente en B. Aunque la candidata pase, requiere decisión/autorización explícita del operador antes de integrar. No se presume a partir de esta DTC.
- **Instalación/operación en EP:** corresponde al control y autorización de EP; MCP-OCP y Gobernanza no pueden ejecutarla ni aprobarla por sustitución.
- **MCP-NORMATIVO:** permanece `DESACTIVADO`. La cobertura 0/43 de `applicability`, `activation_conditions`, `mandatory` y `dependencies` es una ausencia normativa observada, no permiso para inventar datos. El comportamiento fail-closed debe probarse y conservarse; no bloquear por sí solo el cierre del servidor MCP no normativo si el MVP satisface sus criterios sin aplicar normas.
- **Sink y telemetría:** aliases `p001`…`p043` sin despliegue/prueba; telemetría autorizada solo de frecuencia de acceso/consulta. No afirmar disponibilidad productiva ni ampliar semántica. Si estos elementos no son requisito del MVP aceptado, quedan como dependencias explícitas posteriores; si sí lo son, exigir nueva decisión/fuente antes de implementarlos.
- **FOL1:** preparado e inactivo. No bloquea compilación, pruebas ni paquete; todos los folios globales continúan `PENDIENTE / NO ASIGNADO`.
- **Aceptación:** separar `MVP_TÉCNICO_VERIFICADO`, `INTEGRADO_EN_MAIN`, `INSTALADO_EN_EP` y `ACEPTADO_POR_OPERADOR`. Ningún estado sustituye a otro.

La vía de eficiencia es: terminar ciclo 06 sin duplicación → una ejecución técnica consolidada y probada sobre base actual → una única decisión del operador sobre integración → trabajo de EP solo bajo su propia autorización. Si un bloqueo material impide esa secuencia, la DTC lo elevará con evidencia y una decisión concreta, no abrirá rondas exploratorias repetidas.

**Estado de este ajuste:** instrumento DTC actualizado en Gobernanza; no se ha enviado el paquete a MCP-OCP, no se ha modificado su control/núcleo/código y no se ha ejecutado ni integrado el producto. La automatización sigue semiautomática; sin monitoreo ni control directo de otras conversaciones.


## Medición del rendimiento dentro de DTC · DUG v377 / Metacanon §52

Desde el primer ciclo sustantivo de Gobernanza que pueda medirse íntegramente desde su apertura, incorporar el bloque `performance` definido por [GOV-TASK-013](../📁%20🧩%20-%20GOV-TASK-013%20-%20Medición%20y%20optimización%20de%20ciclos/README.md) a la evidencia ya existente del ciclo. No crear una bitácora o un OCP separado ni registrar cada llamada como ciclo. Medir inicio/fin de procesamiento; distinguir roundtrip observado de GitHub/RDC y esperas externas; declarar `NOT_MEASURED` cuando falten marcas. El ciclo que preparó esta instrumentación queda fuera de la línea base porque el registro no comenzó con él. La primera muestra se construye con ciclos completos y comparables; no se proclama mejora antes de contar con distribución suficiente (mediana, P90, rango y tamaño de muestra).

## Compuerta ejecutiva DTC sin excepciones · mandato del operador · 2026-11-01

**Regla:** en TODO ciclo real de Gobernanza, sin excepción, ejecutar y documentar la conciliación trilateral de los objetos canónicos de EP y MCP-OCP antes de cerrar el ciclo propio. No basta con revisar el estado integrado de una fotografía anterior.

### Checklist obligatorio por ciclo de Gobernanza

- [ ] Releer control propio, DUG vigente, índice ejecutivo del sprint y último cursor de EP y MCP-OCP.
- [ ] Leer ambos objetos DTC desde `main`; registrar blob/revisión, ciclo local abierto/cerrado y mensajes posteriores al cursor procesado.
- [ ] Atender primero cada mensaje nuevo: acuse, interpretación, viabilidad, bloqueos y acción inmediata en el mismo objeto del frente emisor.
- [ ] Procesar en este ciclo toda acción que pertenezca a Gobernanza: reconciliar alcance, estado de tareas, dependencia, criterio de aceptación, evidencia y decisión requerida.
- [ ] Para acciones técnicas de EP/MCP-OCP, mantener el ID y la fuente propietarios; no duplicar tareas, no asumir titularidad y no declarar ejecución/aceptación sin evidencia del frente responsable.
- [ ] Si el frente mantiene un ciclo o solicitud abierta, no emitir una solicitud duplicada; conservar el cursor pendiente y esperar su respuesta en el mismo objeto mientras se continúa el trabajo independiente autorizado.
- [ ] Si no hay delta, escribir `SIN_NOVEDAD` con el cursor real leído; el silencio no cuenta como cumplimiento.
- [ ] Actualizar este registro y el tablero ejecutivo cuando cambie el estado integrado; incluir commit/blob y hash/read-back de cada escritura.
- [ ] Verificar por lectura de vuelta el objeto DTC de cada respuesta y los artefactos de Gobernanza modificados.
- [ ] No cerrar el ciclo de Gobernanza si falta revisar alguno de los dos frentes, responder un delta nuevo, documentar el estado pendiente o verificar read-back. Declarar `CICLO_INCOMPLETO` y el bloqueo concreto.

### Aplicación en el corte vigente · 2026-11-01 19:18 America/Mexico_City

- **EP:** el ciclo `C-EP-MOD-SCRIPTPWS-20261101-03` sigue abierto. Gobernanza respondió en el mismo objeto a cinco incidencias (SHA-256 Sigma0, encabezado de arquitectura, aserción `git -C read-tree`, recurrencia de doble `.join()` y helper `insertAfterLine` inexistente). Commit `1f934f1254620cc6e60339afa812c53469241819`; blob/read-back `312c3e7a328e726c88b43c38e37e99d67125cef4`; coincidencia exacta verificada. EP conserva la corrección técnica y su cierre.
- **MCP-OCP:** ciclo local 06 cerrado `CUMPLE_VERIFICADO`; §30 del objeto `COORDINACION-SPRINT-OCP-MCP-v0.1.md`, blob `3ea63f4c18de6f185430617add5bd2df67f15258`, sigue pendiente de lectura/respuesta por MCP-OCP. No se abre una segunda solicitud mientras §30 siga pendiente.
- **DTC global:** `EN_CURSO_RECURRENT`. La respuesta de Gobernanza a EP no cierra EP-03 ni la solicitud §30; el cierre local de MCP-OCP 06 no cierra la dependencia de persistencia ni la aceptación del sprint.

**Criterio de cumplimiento de GOV-TASK-011:** cada ciclo de Gobernanza deja evidencia verificable de que los dos cursores fueron revisados, cada delta nuevo fue respondido/procesado o quedó explícitamente pendiente por autoridad/permiso/respuesta externa, y los cambios propios tuvieron read-back. Un ciclo que omita una de estas condiciones es `CICLO_INCOMPLETO`; no se registrará como cumplido.
