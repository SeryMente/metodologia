# GOV-TASK-017 · Reestructurar IPZ, principios, salida y complementos

**Naturaleza:** tarea provisional del OCP Gobernanza; no es un frente independiente ni canoniza el ámbito Tareas.
**Estado:** `pendiente`
**Responsabilidad:** heredada del control único de `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control, sesión ni folios propios.
**task_id:** `GOV-TASK-017`
**scope_ref:** `frentes/gobernanza/`
**Origen:** instrucciones del operador en la conversación de Gobernanza del 2026-11-12; continuidad del trabajo documentado en GOV-TASK-007 y GOV-TASK-016.

## Enunciado

Revisar secuencialmente la candidata documental de Instrucciones Personalizadas de ChatGPT (IPZ), recoger las decisiones expresas del operador y preparar una candidata nueva que refleje la estructura de cinco partes y el Metacanon §4 vigente. Preservar continuidad y procedencia con sustento explícito en los principios, y reducir fricción sin debilitar controles de integridad necesarios. La reconciliación normativa de ART-032 mediante Articulación Trazable (AT) queda aplazada para una etapa posterior: no iniciar AT ni modificar ART-032 durante la revisión actual de la candidata. La instalación en el campo nativo queda fuera de esta tarea y requiere autorización y verificación independientes.

## Decisiones expresas del operador que esta tarea debe conservar

1. **Parte 3:** conjunto general de principios, anclado en «Principios universales»; no es el CNP.
2. **Parte 4:** Conjunto Nuclear de Principios (CNP), con sus cinco principios nucleares.
3. **Parte 5:** salida y complementos. Debe dirigir a Metacanon §4 para el formato de salida y a ART-032 para los complementos y el procedimiento IPZ, distinguiendo ambos destinos.
4. **Continuidad y procedencia:** conservar como requisito. No se elimina ni se reduce a metadatos decorativos.
5. **Complementos ART-032 §5:**
   - **Conservar sin ampliar** el complemento de no burocracia adicional.
   - **Conservar continuidad y procedencia** como un único complemento breve. Su fundamento se remite a P017/P039 (continuidad), P037 (procedencia técnica) y P038 (fuente canónica); no copiar sus enunciados ni volver a imponer sus procedimientos dentro de ART-032.
   - **Eliminar el antiguo punto 3 (contrato de salida del operador).** Metacanon §4 será la única fuente del formato visible, sus campos y su proporcionalidad. ART-032 no repetirá cabeceras, contadores, campos A/B, folios ni formatos que ya estén definidos allí.
   - **Reformular el antiguo punto 4 (integridad) como una regla mínima, activada por evento y sin checklist repetitivo.** Debe remitir a los principios que ya gobiernan cada salvaguarda: P005 antes de modificar normas del DUG; P037 para CAS/SHA cuando exista escritura concurrente o cambio del asiento de responsabilidad; P004 al declarar hechos/resultados que requieran verificación; P038 para resolver la fuente canónica. La lectura de vuelta se aplica después de una persistencia efectuada cuando haga falta comprobarla, no como ceremonia en cada turno. No duplicar el procedimiento de AT ni el contrato de salida de §4.
   - **Eliminar el antiguo punto 5 (foliación).**
   - **Eliminar el antiguo punto 6 (estado MCP-NORMATIVO).**
6. No instalar ni modificar el campo nativo IPZ en esta tarea. No activar FOL1 ni MCP-NORMATIVO.

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

## Estado operativo y continuidad de decisiones · 2026-11-12

- **Candidata actual mostrada al operador:** IPZ v0.12, `frentes/gobernanza/entregas/CHATGPT-v0.12/IPZ-CAMPO-CHATGPT-v0.12-PROPUESTA.txt`, blob SHA `46bd200c449a9fbc241567ded745d1fed55f3b8b`. El contenido permanece sin modificar y todavía no implementa la estructura acordada de cinco partes: su posición 3 apunta al CNP y su posición 4 dirige a Metacanon §4 con la antigua formulación de salida.
- **Decisión expresa más reciente:** AT se deja para después. No iniciar AT, no ejecutar el procedimiento y no modificar ART-032 durante la revisión actual de la candidata. Esta pausa no cancela ni elimina el trabajo de AT; solo lo difiere.
- **Modo de trabajo acordado:** avanzar por decisiones discretas sobre la candidata. Después de cada decisión expresa del operador, actualizar esta ficha antes de ejecutar el siguiente cambio, preservando la decisión literal o su síntesis fiel, el fundamento, el impacto exacto en la candidata, las cuestiones aún abiertas, el estado de ejecución y el siguiente paso. No atribuir al operador decisiones que no haya tomado; no marcar como ejecutado lo meramente propuesto.
- **Estado al registrar este checkpoint:** candidata v0.12 recuperada y mostrada; candidata todavía no editada; AT aplazada; ART-032 sin modificación en este ciclo; campo nativo IPZ sin modificación.

## Trabajo pendiente

1. Releer la IPZ baseline v0.7 y la candidata v0.12 preservadas; identificar su procedencia y hashes sin presentar la baseline declarada por el operador como lectura nativa.
2. Adquirir DUG vigente desde `main`; revisar ART-025, ART-027, ART-032, P001/P004/P005/P017/P037/P038/P039 y los cinco destinos IPZ previstos.
3. Contrastar la estructura de cinco partes con ART-032: 1 Vocabulario/GOW §ARR; 2 Taxonomía/ART-031; 3 Principios generales/Principios universales; 4 CNP; 5 Metacanon §4 + complementos ART-032.
4. Corregir enlaces y anclas verificando su destino real. No asumir que una etiqueta Markdown acredita que el ancla existe.
5. **APLAZADO:** en una etapa posterior y cuando el operador indique retomarlo, abordar mediante AT la reconciliación de ART-032: orden y función de las cinco partes; complementos conservados/eliminados; continuidad/procedencia y su fundamento; controles de integridad proporcionales; eliminación de foliación y del punto MCP-NORMATIVO de los complementos. Hasta entonces, no iniciar AT ni modificar ART-032.
6. Preparar una nueva candidata documental IPZ sin sobrescribir baseline ni candidata histórica. Verificar las cinco partes, los enlaces, la secuencia y el límite máximo de 1.500 unidades UTF-16, incluyendo LF y CRLF; conservar hashes y lectura de vuelta.
7. Mantener GOV-TASK-007 como antecedente/seguimiento de IPZ nativa y FOL1, y GOV-TASK-016 como revisión de AT y de la propuesta general de exclusividad. Coordinar sin duplicar ni cerrar esas tareas por inferencia.
8. Registrar el resultado y sus límites en el OCP. La instalación nativa solo podrá abordarse en su propio alcance autorizado, con escritura y lectura de vuelta observables.

## Criterios de aceptación

- Estructura de cinco partes coherente con las decisiones expresas del operador y con ART-032 reconciliado.
- Parte 3 enlaza al conjunto general de principios; parte 4 enlaza al CNP; parte 5 distingue Metacanon §4 de ART-032.
- Continuidad/procedencia conservadas y justificadas mediante P017, P039, P037 y P038.
- Complementos 3, 5 y 6 anteriores retirados; complemento 4 reformulado de forma proporcional y sin controles redundantes; complemento 1 conservado.
- Baseline y candidatas históricas preservadas con procedencia/hash; candidata nueva con conteo UTF-16 verificado y dentro de 1.500.
- La candidata revisada y sus decisiones documentadas; la revisión de ART-032 mediante AT queda como aceptación de una etapa posterior, cuando el operador la retome expresamente; cualquier cambio normativo sujeto a P005.
- Ninguna afirmación de instalación nativa, FOL1 activado o MCP-NORMATIVO activado sin evidencia independiente.

## Dependencias y límites

- [GOV-TASK-007](../📁%20🧩%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md): candidata e instalación IPZ/FOL1.
- [GOV-TASK-016](../📁%20🧩%20-%20GOV-TASK-016%20-%20Revisar%20AT%20para%20IPZ%20y%20cambios%20del%20marco/README.md): AT, baseline IPZ y principio general propuesto.
- [ART-032](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-032), [ART-025](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-025), [ART-027](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027), [Metacanon §4](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4).

Esta ficha es una tarea provisional de planificación y persistencia. No canoniza por sí misma cambios en DUG/ART-032 ni modifica el campo nativo IPZ.
