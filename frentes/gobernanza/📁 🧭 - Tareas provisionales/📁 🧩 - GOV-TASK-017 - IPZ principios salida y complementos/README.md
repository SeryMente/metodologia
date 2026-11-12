# GOV-TASK-017 · Reestructurar IPZ, principios, salida y complementos

**Naturaleza:** tarea provisional del OCP Gobernanza; no es un frente independiente ni canoniza el ámbito Tareas.
**Estado:** `pendiente`
**Responsabilidad:** heredada del control único de `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control, sesión ni folios propios.
**task_id:** `GOV-TASK-017`
**scope_ref:** `frentes/gobernanza/`
**Origen:** instrucciones del operador en la conversación de Gobernanza del 2026-11-12; continuidad del trabajo documentado en GOV-TASK-007 y GOV-TASK-016.

## Enunciado

Revisar secuencialmente la candidata documental de Instrucciones Personalizadas de ChatGPT (IPZ), recoger las decisiones expresas del operador y preparar una candidata nueva que refleje la estructura de seis partes y el anexo Formato de salida vigente. Preservar continuidad y procedencia con sustento explícito en los principios, y reducir fricción sin debilitar controles de integridad necesarios. La reconciliación normativa de ART-032 mediante Articulación Trazable (AT) queda aplazada para una etapa posterior: no iniciar AT ni modificar ART-032 durante la revisión actual de la candidata. La instalación en el campo nativo queda fuera de esta tarea y requiere autorización y verificación independientes.

## Decisiones expresas del operador que esta tarea debe conservar

1. **Parte 1:** vocabulario — GOW §ARR.
2. **Parte 2:** taxonomía — ART-031.
3. **Parte 3:** principios universales — conjunto general de los 43 principios, con ART-027/MDP para reconocer pertinencia y lectura íntegra de cada norma pertinente antes de aplicarla; no recorrer los 43 por rutina.
4. **Parte 4:** CNP — lectura íntegra de P001/P004/P005/P038/P043; no sustituye ni excluye otros principios pertinentes.
5. **Parte 5:** salida — exclusivamente el anexo Formato de salida (`#meta-4`).
6. **Parte 6:** complementos — exclusivamente ART-032. No incluir aquí formatos, campos, cabeceras, contadores, contrato ni instrucciones de salida.
7. **Continuidad y procedencia:** conservar como requisito dentro de los complementos, sin reducirlo a metadatos decorativos. Fundamento: P017/P039 para continuidad; P037 para procedencia técnica; P038 para fuente canónica.
8. **Complementos ART-032 §5 (parte 6 de IPZ):**
   - **Conservar sin ampliar** el complemento de no burocracia adicional.
   - **Conservar continuidad y procedencia** como un único complemento breve. No copiar los enunciados de los principios ni duplicar sus procedimientos.
   - **Retirar el antiguo punto 3 (contrato de salida del operador)** del conjunto de complementos. No trasladarlo ni resumirlo en la parte 6; la salida corresponde solo a la parte 5/Formato de salida (`#meta-4`).
   - **Reformular el antiguo punto 4 (integridad)** como una regla mínima activada por evento: P005 ante modificación normativa; P037 ante concurrencia o cambio del asiento de responsabilidad; P004 al afirmar hechos/resultados que requieran verificación; P038 para identificar la fuente canónica. La lectura de vuelta se aplica a una persistencia efectuada que deba comprobarse, no como ceremonia en cada turno.
   - **Eliminar el antiguo punto 5 (foliación).**
   - **Eliminar el antiguo punto 6 (estado MCP-NORMATIVO).**
9. No instalar ni modificar el campo nativo IPZ en esta tarea. No activar FOL1 ni MCP-NORMATIVO.
## Fundamento en principios vigentes

Fuente de referencia: DUG Samantha v393 · NX-393m, Metacanon 1.31, archivo `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `844fc507a2a9a0bfc8f4e68884cca9f6d2912c96`.

- **P017 — Handoff Seamless (flush):** sustenta preservar el contexto activo y el delta al cerrar o transferir un trabajo sustantivo. Es el fundamento directo de continuidad entre ciclos/sesiones; no exige duplicar todo el historial en cada respuesta.
- **P039 — Reinstanciación y Adjudicación Exclusiva del Frente:** exige recuperar la última salida visible cuando exista y sea accesible, y registrar cambios sustantivos conforme a Metacanon §28 con una salida visible proporcional. Sustenta continuidad recuperable y proporcionalidad.
- **P037 — Resolución Explícita de Colisión de Responsabilidad:** reconoce identificadores y generaciones como metadatos de procedencia/auditoría, limita el registro a datos técnicos verificables y necesarios y prescribe comparación SHA ante escrituras concurrentes. Sustenta procedencia técnica sin convertirla en permiso o bloqueo.
- **P038 — Preponderancia Canónica del Repositorio Metodología:** establece `SeryMente/metodologia/main` como fuente canónica y exige registrar deltas/reconciliar espejos sin fusionar fuentes en silencio. Sustenta la procedencia normativa y la referencia a fuentes verificadas.
- **P004 — No-Simulación:** impide afirmar persistencia, lectura de vuelta, capacidad o certeza sin verificación. Sustenta declarar límites y estados reales.
- **P005 — Autorización Explícita del MP:** exige autorización activa y explícita antes de modificar normas del DUG y verificación literal posterior. Sustenta la compuerta para cambios normativos, no una ceremonia adicional para cada operación no normativa.
- **P001 — Cascada Starship:** resuelve conflictos por precedencia y evita que una regla complementaria local desplace un principio superior.

### Diagnóstico del antiguo complemento 4 · decisión de no redundancia

El complemento no debe volver a explicar las normas ni crear un flujo de comprobación paralelo. Debe ser una remisión breve a los principios existentes, con activadores concretos: P005 ante una modificación normativa; P037 ante concurrencia o cambio del asiento de responsabilidad; P004 antes de afirmar un resultado que requiera verificación; P038 al determinar la fuente canónica. El read-back corresponde a una persistencia real que deba comprobarse. No se vuelve a consultar control, calcular hashes ni repetir preflight por rutina cuando no existe el evento que activa esa salvaguarda. La continuidad/procedencia se mantiene como complemento independiente y compacto, no se sustituye ni se duplica con un nuevo registro en cada respuesta.

## Checkpoint histórico previo a v0.13 · 2026-11-12

- **Candidata actual mostrada al operador:** IPZ v0.12, `frentes/gobernanza/entregas/CHATGPT-v0.12/IPZ-CAMPO-CHATGPT-v0.12-PROPUESTA.txt`, blob SHA `46bd200c449a9fbc241567ded745d1fed55f3b8b`. El contenido permanece sin modificar y todavía no implementa la estructura acordada de cinco partes: su posición 3 apunta al CNP y su posición 4 dirige a Metacanon §4 con la antigua formulación de salida.
- **Decisión expresa más reciente:** AT se deja para después. No iniciar AT, no ejecutar el procedimiento y no modificar ART-032 durante la revisión actual de la candidata. Esta pausa no cancela ni elimina el trabajo de AT; solo lo difiere.
- **Modo de trabajo acordado:** avanzar por decisiones discretas sobre la candidata. Después de cada decisión expresa del operador, actualizar esta ficha antes de ejecutar el siguiente cambio, preservando la decisión literal o su síntesis fiel, el fundamento, el impacto exacto en la candidata, las cuestiones aún abiertas, el estado de ejecución y el siguiente paso. No atribuir al operador decisiones que no haya tomado; no marcar como ejecutado lo meramente propuesto.
- **Estado al registrar este checkpoint:** candidata v0.12 recuperada y mostrada; candidata todavía no editada; AT aplazada; ART-032 sin modificación en este ciclo; campo nativo IPZ sin modificación.

## Decisión y revisión de contenido · 2026-11-12

El operador instruye modificar la candidata actual conforme a todas las decisiones nuevas registradas en esta conversación, no limitarse a mostrarla. Se revisaron la candidata v0.12 y el DUG vigente v393/NX-393m, blob `844fc507a2a9a0bfc8f4e68884cca9f6d2912c96`, en particular ART-025, ART-027, ART-032, el bloque de Principios universales y el CNP.

**Estructura acordada para la nueva candidata (seis partes fijas):**
1. Vocabulario — GOW §ARR.
2. Taxonomía — ART-031.
3. Principios universales — bloque general de los 43 principios + ART-027. Los MDP sirven para reconocer pertinencia; se lee el texto normativo íntegro de cada principio pertinente antes de aplicarlo. No se recorren los 43 por rutina.
4. CNP — lectura íntegra de P001/P004/P005/P038/P043. El CNP no sustituye ni excluye los demás principios pertinentes; rige la precedencia.
5. Salida — exclusivamente Formato de salida (`#meta-4`) y su contrato visible.
6. Complementos — exclusivamente ART-032: no burocracia, continuidad/procedencia e integridad proporcional activada por evento. Excluir de esta parte cualquier contenido relativo a salida.

**Decisiones que deben reflejarse sin reintroducir contenido retirado:** parte 5 solo salida conforme al anexo Formato de salida (`#meta-4`); parte 6 solo complementos ART-032, sin formatos, campos, contrato ni instrucciones de salida. En los complementos retirar el antiguo contrato de salida, la foliación y el estado MCP-NORMATIVO; conservar no burocracia, continuidad/procedencia e integridad con activadores proporcionales (P005 ante cambio normativo, P037 ante concurrencia/cambio de responsabilidad, P004 al afirmar resultados verificables, P038 para fuente canónica); no repetir controles por rutina. No iniciar AT ni editar ART-032 en esta etapa.

**Nueva candidata en preparación:** v0.13, ruta prevista `frentes/gobernanza/entregas/CHATGPT-v0.13/IPZ-CAMPO-CHATGPT-v0.13-PROPUESTA.txt`. v0.12 y baseline histórica se preservan sin sobrescritura. La candidata v0.13 no se considerará persistida hasta creación y lectura de vuelta; tampoco equivale a instalación en el campo nativo.

**Procedencia de anclas revisadas:** `#gow-arranque-chatgpt`, `#ART-031`, `#principios-universales`, `#ART-027`, `#cnp-conjunto-nuclear-de-principios`, `#meta-4` y `#ART-032` corresponden a destinos presentes en el DUG vigente. Los enlaces de la candidata se resolverán desde su ruta relativa en el repositorio.

## Última decisión del operador · separación de salida y complementos · 2026-11-12

- **Instrucción expresa:** la IPZ tendrá seis partes, no cinco. La posición 5 es «Salida» y la posición 6 es «Complementos».
- **Parte 5:** destino exclusivo Formato de salida (`#meta-4`). Contiene la remisión al contrato de salida, sin mezclar ART-032.
- **Parte 6:** destino exclusivo ART-032. Retirar de esta posición cualquier contenido relacionado con salida: formato, campos, cabeceras, contadores, contrato, instrucciones de presentación o duplicación de §4.
- **Complementos que permanecen en parte 6:** no burocracia adicional; continuidad/procedencia; integridad mínima activada por evento. Permanecen retirados el antiguo contrato de salida, foliación y estado MCP-NORMATIVO.
- **Alcance de la acción actual:** actualizar solo la candidata IPZ v0.13 y esta ficha de continuidad. AT sigue aplazada; ART-032 y el campo nativo no se modifican.
- **Orden de ejecución:** esta decisión se registra antes de editar la candidata. Tras persistirla, releer candidata y ficha y registrar sus nuevos hashes y conteo antes de continuar.

## Evidencia de persistencia · candidata v0.13

- **Ruta:** `frentes/gobernanza/entregas/CHATGPT-v0.13/IPZ-CAMPO-CHATGPT-v0.13-PROPUESTA.txt`
- **Enlace:** https://github.com/SeryMente/metodologia/blob/main/frentes/gobernanza/entregas/CHATGPT-v0.13/IPZ-CAMPO-CHATGPT-v0.13-PROPUESTA.txt
- **Versión/contador:** `IPZ v0.13 · 1353/1500`.
- **Conteo verificado:** UTF-16 LF 1.346; UTF-16 CRLF 1.353; puntos de código 1.346. El encabezado refleja el máximo CRLF.
- **Blob SHA actual:** `5a30a2e305cd0547b7c4f087a0f8848e3e7241e2`.
- **Commit de creación:** `1dec260be2edf5e4b507f34b56abd448d3f3ef40`; commit de última optimización y corrección del contador: `2817dda3ae5783adba052771dfd1ac651e5e5536`.
- **Read-back:** contenido recuperado desde `main`; versión, contador, texto y blob cotejados. Los siete destinos/anclas se verificaron contra el DUG vigente.
- **Preservación:** v0.12 continúa en su ruta histórica y no fue sobrescrita; baseline v0.7 no fue modificada ni declarada instalada.
- **Límites:** campo nativo IPZ sin modificar; ART-032 sin modificar; AT aplazada; FOL1 y MCP-NORMATIVO no activados.
- **Verificación de estructura:** parte 5 contiene solo el anexo Formato de salida (`#meta-4`) y la instrucción de salida; parte 6 contiene solo ART-032 y los complementos no burocracia, continuidad/procedencia e integridad por evento. La parte 6 no contiene formato, campos ni contrato de salida.
- **Última actualización:** commit `2817dda3ae5783adba052771dfd1ac651e5e5536`; blob `5a30a2e305cd0547b7c4f087a0f8848e3e7241e2`.

## Nueva decisión · nombre funcional de salida y economía de IPZ · 2026-11-12

- **Nombre de la parte 5:** usar «Formato de salida» en lugar de «Metacanon §4». El anexo canónico ya se titula «4. Formato de salida» y su ancla estable sigue siendo `#meta-4`; se cambia la etiqueta en IPZ, no el identificador ni el contenido del DUG.
- **Contenido fuente revisado:** `meta-4`, con salida humana de diez campos lógicos agrupables, telemetría técnica estructurada, reglas específicas Sink/IPZ/MCP-OCP/Harmonia y límite temporal de §52. Se mantiene la distinción entre salida humana y telemetría; no copiar el contrato dentro de la parte 6.
- **Optimización autorizada:** reducir caracteres mediante redacción compacta, eliminación de duplicaciones y referencias directas más breves, sin quitar ninguna de las seis funciones, la secuencia de lectura, el reconocimiento por MDP, la lectura íntegra de principios pertinentes, la composición CNP, la salida proporcional, los tres complementos, ni las referencias canónicas. No añadir consultas, herramientas, telemetría o pasos que degraden el rendimiento.
- **Alcance:** actualizar solo la candidata documental v0.13 y esta ficha. No renombrar ni reescribir el DUG; el nombre canónico de `meta-4` ya es Formato de salida. AT continúa aplazada; ART-032 y el campo nativo IPZ permanecen intactos.

## Ejecución · nombre Formato de salida y optimización IPZ · 2026-11-12

- **Parte 5 actualizada:** etiqueta visible `FORMATO DE SALIDA — Formato de salida`; destino canónico `#meta-4`. La candidata usa el nombre funcional del anexo, no «Metacanon §4». El título real del destino en el DUG ya era «4. Formato de salida», por lo que no se cambió el DUG ni su ancla estable.
- **Separación conservada:** parte 5 contiene exclusivamente el acceso a salida; parte 6 conserva solo ART-032 y los complementos no burocracia, continuidad/procedencia e integridad proporcional por evento. No hay instrucciones de salida en parte 6.
- **Optimización aplicada:** se compactó redacción y se eliminaron repeticiones sin quitar las seis posiciones, verificación de vigencia, lectura íntegra y seguimiento de referencias, reconocimiento MDP, lectura íntegra de cada principio pertinente, lectura del CNP, distinción salida humana/telemetría ni los tres complementos.
- **Ahorro medido:** candidata anterior 1.462 UTF-16 CRLF; actual 1.353 UTF-16 CRLF; reducción neta de 109 unidades (7,46%). Actual: LF 1.346; CRLF 1.353; puntos de código 1.346. No se añadieron consultas ni pasos de ejecución.
- **Candidata actual:** blob `5a30a2e305cd0547b7c4f087a0f8848e3e7241e2`; commit `2817dda3ae5783adba052771dfd1ac651e5e5536`. **Read-back completado:** recuperada desde `main`; encabezado, seis posiciones, etiquetas y separación de las partes 5/6 cotejadas. Conteos LF/CRLF coinciden con 1.346/1.353.
- **Límites sin cambio:** no se renombró contenido del DUG; no se modificó ART-032; AT continúa aplazada; campo nativo IPZ no modificado.

## Trabajo pendiente

1. **Pendiente:** releer la IPZ baseline v0.7 y documentar su procedencia/hash; no presentar la baseline declarada por el operador como lectura nativa. La candidata histórica v0.12 ya fue recuperada y permanece preservada.
2. **Realizado para esta revisión:** adquirir DUG vigente desde `main` (v393/NX-393m; blob `844fc507a2a9a0bfc8f4e68884cca9f6d2912c96`) y revisar ART-025, ART-027, ART-032, el bloque de Principios universales y el CNP. La revisión no constituye modificación normativa.
3. **Actualizado tras la última decisión:** estructura de seis partes: GOW §ARR; ART-031; Principios universales + ART-027/MDP; CNP; salida exclusiva por Formato de salida (`#meta-4`); complementos exclusivos por ART-032.
4. **Realizado:** verificar los siete destinos/anclas usados por v0.13: `#gow-arranque-chatgpt`, `#ART-031`, `#principios-universales`, `#ART-027`, `#cnp-conjunto-nuclear-de-principios`, `#meta-4` y `#ART-032`. Los enlaces relativos se resuelven desde la ruta de la candidata en el repositorio.
5. **APLAZADO:** en una etapa posterior y cuando el operador indique retomarlo, abordar mediante AT la reconciliación de ART-032: orden y función de las seis partes; separación de salida en la parte 5 y complementos en la parte 6; continuidad/procedencia y su fundamento; controles de integridad proporcionales; eliminación de foliación y del punto MCP-NORMATIVO de los complementos. Hasta entonces, no iniciar AT ni modificar ART-032.
6. **Realizado:** crear candidata documental v0.13 sin sobrescribir v0.7 ni v0.12; verificar las seis partes, enlaces y conteo UTF-16 LF/CRLF. La candidata queda como propuesta pendiente de revisión, no instalada.
7. Mantener GOV-TASK-007 como antecedente/seguimiento de IPZ nativa y FOL1, y GOV-TASK-016 como revisión de AT y de la propuesta general de exclusividad. Coordinar sin duplicar ni cerrar esas tareas por inferencia.
8. Registrar el resultado y sus límites en el OCP. La instalación nativa solo podrá abordarse en su propio alcance autorizado, con escritura y lectura de vuelta observables.

## Criterios de aceptación

- Estructura de seis partes: salida en parte 5 exclusivamente por Formato de salida (`#meta-4`) y complementos en parte 6 exclusivamente por ART-032, sin contenido de salida en los complementos. La reconciliación de ART-032 no es requisito de esta etapa y permanece aplazada hasta que el operador indique retomarla.
- Parte 3 enlaza a Principios universales y ART-027; parte 4 enlaza al CNP; parte 5 enlaza únicamente a Formato de salida (`#meta-4`); parte 6 enlaza únicamente a ART-032 y no contiene elementos de salida.
- Continuidad/procedencia conservadas y justificadas mediante P017, P039, P037 y P038.
- Complementos 3, 5 y 6 anteriores retirados; complemento 4 reformulado de forma proporcional y sin controles redundantes; complemento 1 conservado.
- Baseline y candidatas históricas preservadas con procedencia/hash; candidata nueva con conteo UTF-16 verificado y dentro de 1.500.
- La candidata revisada y sus decisiones documentadas; la revisión de ART-032 mediante AT queda como aceptación de una etapa posterior, cuando el operador la retome expresamente; cualquier cambio normativo sujeto a P005.
- Ninguna afirmación de instalación nativa, FOL1 activado o MCP-NORMATIVO activado sin evidencia independiente.

## Dependencias y límites

- [GOV-TASK-007](../📁%20🧩%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md): candidata e instalación IPZ/FOL1.
- [GOV-TASK-016](../📁%20🧩%20-%20GOV-TASK-016%20-%20Revisar%20AT%20para%20IPZ%20y%20cambios%20del%20marco/README.md): AT, baseline IPZ y principio general propuesto.
- [ART-032](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-032), [ART-025](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-025), [ART-027](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027), [Formato de salida](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4).

Esta ficha es una tarea provisional de planificación y persistencia. No canoniza por sí misma cambios en DUG/ART-032 ni modifica el campo nativo IPZ.


## Decisión del operador · destino operativo exclusivo para la salida IPZ · 2026-11-12

**Aclaración vinculante de propósito:** IPZ es una instrucción operativa-funcional para el modelo, no un reporte humano ni un esquema de telemetría. El enlace de su parte 5 no debe apuntar al contrato mixto de Metacanon §4 (`#meta-4`) porque ese destino contiene síntesis humana y telemetría técnica, ajenas al propósito específico de imprimir la salida requerida.

**Decisión:** preparar un anexo separado, exclusivo para el modelo, denominado provisionalmente **Formato de salida operativo para IPZ**. Debe ser un contrato ejecutable de presentación: campos obligatorios, orden fijo, sintaxis, condiciones para datos ausentes/no disponibles/no asignados, estados admitidos y reglas para no omitir ni inventar contenido. El modelo debe imprimir el esquema en todos los ciclos; cuando un valor no exista, debe conservar el campo con el marcador definido, no eliminarlo ni usar la ausencia como excusa para omitir la salida.

**Separación de responsabilidades:**
- Metacanon §4 permanece como formato humano y contrato de telemetría técnica para gobernanza/observabilidad; puede conservarse íntegro.
- El nuevo anexo operativo es el único destino de la parte 5 de IPZ. No incorpora telemetría, eventos, instrumentación, informes de auditoría ni explicaciones dirigidas a responsables humanos.
- La parte 6 continúa enlazando exclusivamente ART-032 y sus complementos; no absorbe contenido de salida.
- No enlazar IPZ a `#meta-4` ni a apartados humanos/técnicos de §4.

**Contrato de impresión a especificar:** cabecera fija IPZ, DUG, CONV, CICLO, A y B, en ese orden; cuerpo con Resultado/estado, Evidencia/límites, Bloqueos reales y Siguiente acción, más Continuidad cuando corresponda. Todos los campos aplicables deben imprimirse. Para datos no disponibles, no expuestos, no asignados o no aplicables se usarán marcadores distintos y explícitos; nunca se inventarán IDs, folios, versiones, hashes, capturas, lecturas de vuelta ni resultados. El formato respetará FOL1 y las restricciones temporales vigentes: no asignar folios si FOL1 no está ACTIVO; no agregar d.h.m., duración ni latencia mientras §52 mantenga desactivadas las métricas temporales.

**Alcance de esta etapa:** crear una propuesta autónoma del anexo y una nueva candidata IPZ que enlace directamente a ella, preservando v0.13. El destino aún será documental/propuesto, no anexo canónico hasta su incorporación formal al DUG. El IPZ candidato tampoco se instalará en el campo nativo. AT permanece aplazada por instrucción expresa; no modificar ART-032 ni el DUG durante esta etapa.

**Condición posterior:** cuando el operador retome AT, promover el contrato a un anexo DUG independiente (propuesta de ID ART-033, sujeto a validación del catálogo), actualizar el catálogo/versionado y sustituir en IPZ la ruta provisional por el ancla canónica estable. La integración debe mantener §4 humano/telemetría sin convertirlo en destino de IPZ.
