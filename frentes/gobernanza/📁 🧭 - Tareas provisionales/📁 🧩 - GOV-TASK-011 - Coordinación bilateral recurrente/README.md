# GOV-TASK-011 — DTC · Dinámica Trilateral por Ciclo

**Estado:** en_curso · **Responsable de verificación:** Gobernanza, generación 9. **Ejecución/evidencia:** cada frente, bajo su propio control.

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

- **EP:** [comunicación provisional](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md), actualmente en `docs/metacanon-objetos-20261011`; pendiente de reconciliar por EP con `main`. OEP e índice de tareas se consultan en `main`.
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

