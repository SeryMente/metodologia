# Sprint general · Product Design con BMAD y CIS

**Corte documental:** 2026-11-13  
**Estado:** BORRADOR INTEGRAL PARA REVISIÓN DE DISEÑO EXTREMO A EXTREMO  
**Módulo:** MOD-EP-PRODUCT-DESIGN · subordinado al frente EP  
**Objeto rector y control:** frentes/ep/OEP.md y frentes/ep/CONTROL-RESPONSABILIDAD.json  
**Carácter:** diseño acumulativo. No es plan de ejecución aprobado, no crea tareas provisionales y no acredita aceptación técnica.

> Este documento consolida el diseño objetivo de Product Design y corrige las líneas antiguas que confundían el producto con vMAT, con un portal auxiliar o con la integración operativa de Superpowers. Las decisiones expresas del operador prevalecen sobre esas representaciones históricas. Las propuestas de implementación aún no ratificadas se etiquetan como propuestas.

---

## 1. Propósito del sprint

Construir una capacidad de diseño de producto asistida por BMAD y CIS, conducida principalmente desde la conversación ordinaria de ChatGPT. La conversación debe permitir escoger o confirmar el agente y el enfoque de trabajo adecuados, desarrollar la actividad de diseño, conservar automáticamente sus resultados, recuperar sesiones interrumpidas y reutilizar conocimiento de trabajos anteriores.

El sprint no tiene como objetivo construir un dashboard, un portal de agentes, un GPT personalizado, un plugin de ChatGPT ni una aplicación adicional que obligue al operador a navegar por múltiples controles. La interfaz de trabajo preferente es el propio chat.

El primer dominio funcional que debe quedar bien resuelto es Brainstorming. El resto de agentes y capacidades CIS se incorporan a la misma experiencia conversacional, sin convertir Product Design en un menú permanente ni en un proceso rígido.

## 2. Decisiones rectoras confirmadas por el operador

| ID documental | Decisión | Estatuto |
|---|---|---|
| PD-D-001 | ChatGPT, en conversación ordinaria, es la interfaz principal de Product Design. | CONFIRMADA |
| PD-D-002 | No se requiere un portal visual propio ni una interfaz cargada de controles para seleccionar agentes y técnicas. La selección puede realizarse por conversación. | CONFIRMADA |
| PD-D-003 | BMAD es el método/framework de Product Design. | CONFIRMADA |
| PD-D-004 | Carson es el primer agente conversacional operativo para la versión inicial; los demás agentes CIS quedan para una secuencia posterior. | CONFIRMADA · ORDEN DE IMPLEMENTACIÓN |
| PD-D-005 | Superpowers se utiliza exclusivamente como referencia para identificar capacidades que desarrollaremos por nuestra cuenta. No se instala, integra, ejecuta ni adopta como herramienta operativa de este diseño. | CONFIRMADA |
| PD-D-006 | Brain Selector queda fuera del recorrido inicial y se registra como mejora opcional de baja prioridad, posterior al núcleo. | CONFIRMADA · DIFERIDA |
| PD-D-007 | Brainstorm HTML Keepsake queda fuera del recorrido inicial y se registra como mejora opcional de baja prioridad; solo se abordará si se genera automáticamente sin trabajo de diseño del operador. | CONFIRMADA · DIFERIDA |
| PD-D-008 | El autoguardado se ejecuta al terminar cada ciclo de ideación, no carácter por carácter ni por cada turno trivial; debe preservar borradores y resultados maduros con versiones recuperables. | CONFIRMADA |
| PD-D-009 | La biblioteca inicial indexa proyectos, sesiones y piezas reutilizables; conserva fuente y procedencia y permite referenciar el mismo resultado desde distintos proyectos. | CONFIRMADA |
| PD-D-010 | La integridad del diseño completo se revisará antes de ejecutar la implementación. | CONFIRMADA |
| PD-D-011 | La categoría futura se denomina Cognición visoespacial y proyección visual; por ahora solo se conservan su categoría y sus documentos de referencia. | CONFIRMADA · DIFERIDA |
| PD-D-012 | Las tareas provisionales se construyen tras inspeccionar el método de trazabilidad de Harmonia: fuente literal, requisito, tarea, entregable, aceptación, evidencia y crónica; se materializan en el índice y los núcleos README que ya utiliza EP. | CONFIRMADA |
| PD-D-013 | OpenCode no es necesario para el flujo objetivo de esta etapa: ChatGPT + RDC es la ruta principal. La existencia de OpenCode/configuración anterior no autoriza eliminarla ni la convierte en dependencia. | CONFIRMADA |
| PD-D-014 | El módulo deberá conectarse posteriormente con la Prótesis Cognitiva; esa integración se conserva como dependencia futura, sin implementarla ni desglosarla ahora. | CONFIRMADA · DIFERIDA POR EL OPERADOR |
| PD-D-015 | Si el operador no nombra el proyecto, Product Design lo crea con un nombre descriptivo automático y etiquetas esenciales. | CONFIRMADA |
| PD-D-016 | Una ideación incompleta o madura conserva íntegramente su contenido significativo en un registro durable por ciclo. La síntesis no reemplaza ni elimina las ideas fuente. | CONFIRMADA |
| PD-D-017 | A/B es notación de evidencia del marco de trabajo, no una función, pantalla ni objeto del producto de lluvia de ideas. | ACLARADA POR EL OPERADOR |
| PD-D-018 | Brain Selector y Keepsake quedan documentados en tareas provisionales posteriores y de prioridad baja; no son dependencias del primer hito. | CONFIRMADA |

### 2.1 Corrección explícita sobre Superpowers

Superpowers queda fuera de la arquitectura operativa objetivo. Su única función en este sprint es servir como corpus de referencia para reconocer habilidades o capacidades que el equipo pueda diseñar e implementar por cuenta propia. No es una dependencia, motor de ejecución, plugin, conjunto de skills instaladas para el producto ni método de trabajo de los agentes Product Design. La configuración histórica existente en OpenCode no se elimina ni se modifica por esta decisión; su retirada sería una actuación separada y no está incluida aquí.

### 2.2 Alcance de Superpowers como referencia

El inventario upstream que se conserva únicamente como referencia comprende estas 15 habilidades: brainstorming, using-git-worktrees, writing-plans, subagent-driven-development, executing-plans, test-driven-development, requesting-code-review, receiving-code-review, dispatching-parallel-agents, finishing-a-development-branch, systematic-debugging, verification-before-completion, diagnosing-superpowers, writing-skills y using-superpowers.

Este inventario no se instala, ejecuta ni adopta. Su único uso permitido dentro del proyecto es reconocer qué capacidades podrían diseñarse e implementarse independientemente. No se heredan automáticamente sus instrucciones, herramientas, plugins, workflows o procesos. El Visual Companion de Superpowers es una interfaz opcional, no una habilidad del catálogo; queda fuera del diseño actual porque no se ha solicitado una interfaz de brainstorming y la interacción será conversacional.

### 2.3 Matriz breve de procedencia de decisiones

- PD-D-001, PD-D-002 y PD-D-006: instrucción A SRC-PD-20261113-ALCANCE-02; antecedente de selección visual en ChatGPT-Product Design-20261113-1212.md.
- PD-D-003: instrucciones del operador sobre BMAD. PD-D-004: la instrucción anterior de explorar seis agentes se conserva como intención de catálogo, pero el orden vigente SRC-PD-20261113-IDEACION-03 establece Carson primero y los demás posteriormente.
- PD-D-005 y PD-D-013: corrección del operador en SRC-PD-20261113-CORRECCION-01 y decisión previa de mantener ChatGPT + RDC sin OpenCode como requisito.
- PD-D-007: instrucción A SRC-PD-20261113-ALCANCE-02 y especificación oficial BMAD V6.12.
- PD-D-008 y PD-D-009: instrucción A SRC-PD-20261113-CORRECCION-01.
- PD-D-010, PD-D-011 y PD-D-012: instrucción A SRC-PD-20261113-CORRECCION-01.

### 2.4 Decisiones que no deben reabrirse por error de documentación

No volver a proponer Superpowers como instrumento de ejecución. No volver a presentar el portal auxiliar como la interfaz solicitada. No exigir Brain Selector ni Keepsake para iniciar o finalizar una sesión inicial. No pedir al operador que diseñe el Keepsake. No trasladar la categoría visoespacial ni la Prótesis Cognitiva a la primera etapa. No convertir la lista de capacidades en una secuencia rígida si el problema concreto requiere otra ruta.

---

## 3. Arquitectura de interacción objetivo

### 3.1 Chat-first

La conversación de ChatGPT es el espacio de interacción principal. El agente debe:

1. Interpretar la necesidad expresada, los documentos disponibles y el objetivo del operador.
2. Identificar si corresponde Brainstorming u otra capacidad de Product Design.
3. Seleccionar o recomendar el agente CIS pertinente.
4. Cuando se trate de brainstorming, determinar con el operador el modo de facilitación y el enfoque/técnicas adecuados, sin presentar un catálogo exhaustivo ni una pantalla saturada.
5. Formular como máximo una pregunta conversacional por turno cuando una decisión material siga abierta; no convertir la elección en un cuestionario.
6. Conducir el trabajo, registrar ideas y decisiones y conservar la procedencia.
7. Cerrar la sesión con síntesis y, cuando corresponda, generar el artefacto visual automáticamente.

La selección no exige una pantalla independiente. El operador puede invocar un agente por su nombre o describir el objetivo y aceptar/corregir la recomendación del asistente. El asistente debe explicar brevemente qué agente y qué modo propone antes de iniciar una actividad cuyo enfoque cambie materialmente el resultado.

### 3.2 No confundir agente con modo ni con técnica

Son tres dimensiones distintas:

- **Agente:** quién conduce la capacidad. En el primer release el agente activo es Carson; los demás perfiles CIS quedan para fases posteriores.
- **Modo/stance:** cómo participa el agente y cómo se distribuye la generación de ideas (Facilitator, Creative Partner o Ideate for me).
- **Técnica:** el procedimiento concreto de ideación utilizado en una etapa o lote.

No se debe construir un único menú que mezcle agentes, modos, técnicas, fases, visualizaciones y configuraciones colaborativas como si fueran opciones del mismo nivel.

### 3.3 Papel de RDC y del entorno persistente

Remote Desktop Commander (RDC) es el puente del asistente hacia los archivos, scripts y recursos del entorno local autorizado. La conversación dirige; el entorno persistente conserva los artefactos. No se presupone que ChatGPT cloud pueda acceder directamente a 127.0.0.1, al disco local o al portapapeles.

Las operaciones de persistencia deben realizarse mediante una conexión RDC vigente, seleccionada conforme al procedimiento de EP. No inferir que dos conexiones con el mismo hostname representan la misma sesión, cuenta o perfil.

### 3.4 Chrome y perfil de usuario

No abrir un perfil aislado ni una instancia paralela que no corresponda a la sesión principal del operador. Cuando la presentación de un artefacto requiera navegador, se utilizará la instancia de Chrome existente bajo la sesión principal de Víctor Hugo y su correo principal. No usar el perfil dedicado MOD-EP-CHROME/data/Fila4/user-data como sustituto de esa sesión. No se realizará ninguna apertura durante esta fase de diseño.

### 3.5 Interfaz visual: decisión mínima

La interfaz inicial es el chat. No se construirá un portal, dashboard o selector general de agentes. Brain Selector queda diferido como mejora opcional y de baja prioridad.

### 3.6 Primer recorrido funcional: Carson

La primera versión operativa se limita a Carson conversando en ChatGPT sobre el motor BMAD bmad-brainstorming. El usuario puede invocarlo por su nombre o iniciar una lluvia de ideas directamente; no se le pide abrir un portal ni un archivo HTML. Carson identifica el tema y el objetivo, adopta el modo que la petición implique y propone pocas técnicas apropiadas. Si la modalidad cambia materialmente la colaboración y no puede inferirse, hace una única pregunta breve.

La versión inicial admite Facilitator, Creative Partner e Ideate for me. Si no hay indicación y no es material preguntar, se usa Creative Partner como opción equilibrada. La voz de Carson se mantiene como coach creativo, pero su comunicación se adapta al estilo sobrio del operador: nada de menús extensos, cuestionarios, ruido visual ni entusiasmo artificial.

No se implementan todavía los otros cinco agentes CIS, Brain Selector ni Keepsake. Se conservan como fases posteriores sin bloquear el primer uso.

---

## 4. Catálogo CIS de referencia y secuencia de integración

CIS mantiene un catálogo de seis agentes como referencia de capacidades. La primera versión operativa desarrolla Carson; los otros cinco se mantienen en el catálogo y no bloquean el primer release:

| Agente | Capacidad asociada | Función dentro de Product Design | Observación |
|---|---|---|---|
| Carson | Brainstorming Coach → bmad-brainstorming | Ideación divergente, facilitación, asociación y síntesis. | Utiliza el motor de brainstorming de BMAD Core. |
| Maya | Design Thinking Coach → bmad-cis-design-thinking | Comprender necesidades, formular problemas, idear, prototipar y probar. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Dr. Quinn | Creative Problem Solver → bmad-cis-problem-solving | Diagnosticar y resolver problemas creativos o complejos. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Victor | Innovation Strategist → bmad-cis-innovation-strategy | Explorar oportunidades, innovación y opciones estratégicas. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Sophia | Storyteller → bmad-cis-storytelling | Construir narrativas y comunicar una idea o propuesta. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Caravaggio | Presentation Master → bmad-cis-agent-presentation-master | Planificar y revisar presentaciones, guiones y recursos visuales. | El agente está documentado; la disponibilidad de workflows empaquetados requiere verificación. |

Caravaggio tiene referencias de menú PL (plan de presentación/pitch), CR (crítica de deck o visual), EX (guion explicativo) y VM (selección de recurso visual). No se declara que esos workflows estén instalados o aceptados localmente solo por existir el agente.

CIS también ofrece configuraciones colaborativas Creative Squad y Design Pair. Sus integrantes, reglas y comportamiento deben leerse directamente de la configuración oficial; no se infieren por los nombres. El repositorio upstream describe CIS como un módulo demostrativo de agentes/workflows al que se incorporan capacidades progresivamente. No debe tratarse como producto completo ni asumir que todos sus flujos están listos, instalados o probados.

**Regla de cobertura:** Product Design V1.0 no se limita a Carson. La integración y evaluación debe abarcar los seis agentes y las configuraciones colaborativas que la fuente oficial confirme, distinguiendo siempre entre documentación upstream, instalación local, invocación observable y aceptación. En la arquitectura ChatGPT + RDC, los agentes CIS se adaptan como perfiles y procedimientos conversacionales propios, apoyados en las fuentes oficiales locales. No se afirmará que se está ejecutando un runtime CIS nativo ni subagentes independientes cuando solo se haya leído o aplicado su documentación.

---

## 5. Brainstorming: funcionamiento objetivo

### 5.1 Tres modos oficiales

La referencia BMAD V6.12 define tres modalidades:

- **Facilitator:** el agente facilita, pregunta y provoca; no aporta ideas durante la generación divergente. Su contribución creativa se reserva para la síntesis final.
- **Creative Partner:** el agente y el operador generan ideas conjuntamente. La autoría de cada aportación del agente y del usuario se conserva.
- **Ideate for me:** el agente realiza la exploración de manera autónoma y presenta el resultado.

La modalidad se conserva durante toda la sesión. No se debe cambiar de modo silenciosamente a mitad de una lluvia de ideas.

### 5.2.1 Carson: identidad, menú y motor real

Carson no es un modelo de inteligencia artificial separado ni un motor de ideación independiente. En la suite Creative Intelligence Suite (CIS), Carson aporta identidad, personalidad, reglas de facilitación y configuración; su entrada de menú es **BS — Guided Brainstorming Session**, que delega en la habilidad central de BMAD **bmad-brainstorming**.

La activación funcional documentada es:

1. Cargar las instrucciones y la configuración del agente Carson.
2. Incorporar el contexto persistente del proyecto y las reglas de Product Design.
3. Resolver la configuración de BMAD Core.
4. Adoptar la identidad del coach Carson, adaptando su estilo de comunicación a la experiencia de trabajo acordada.
5. Entrar en la sesión guiada y cargar el procedimiento central de brainstorming.
6. Consultar el catálogo de técnicas únicamente según la necesidad de la sesión.

La implementación objetivo no necesita un segundo modelo local. ChatGPT conduce la conversación y ejecuta intelectualmente el rol; RDC consulta los archivos locales, recupera instrucciones, registra resultados y materializa los artefactos.

### 5.2.2 Diferencia entre los catálogos de técnicas

Las fuentes históricas de CIS describen 36 técnicas en 7 categorías. La instalación local de BMAD Core 6.12.4, en cambio, fue reportada con 108 técnicas en 13 categorías; la consulta de categorías mediante brain.py se había ejecutado y observado en el ciclo anterior.

Para el diseño se establece como **fuente operativa prevista** el catálogo del Core local de 108 técnicas, sujeto a una nueva comprobación de versión y contenido antes de implementar. La cifra antigua de CIS se conserva como procedencia histórica, no se suma al catálogo actual ni se presenta como si fuera la misma revisión. El agente no debe enumerar las 108 técnicas al operador: debe consultar solo las categorías y métodos que correspondan al objetivo y recomendar un conjunto pequeño y justificable.

### 5.2.3 Selección y progresión de la sesión

La secuencia de trabajo documentada para una sesión es:

1. Delimitar tema, objetivo, contexto y restricciones.
2. Proponer una primera ronda pequeña, normalmente de tres o cuatro técnicas adecuadas.
3. Aplicar cada técnica sin mezclar generación y evaluación de forma prematura.
4. Registrar ideas, preguntas, direcciones, supuestos y decisiones, identificando autoría cuando el modo lo requiera.
5. Cuando una línea se agote, cambiar de técnica o de dominio creativo.
6. Cerrar la divergencia antes de iniciar la convergencia.
7. Seleccionar el método de convergencia apropiado y producir la síntesis.

La síntesis posterior puede añadir conexiones no obvias, pero debe distinguirlas de las ideas que el operador produjo.

### 5.2 Técnicas

BMAD Core dispone de un catálogo consultable por categorías y técnicas. La referencia oficial V6.12 describe 108 técnicas en 13 categorías en el selector original observado en el entorno. La existencia del catálogo no significa que el operador deba leerlo completo ni seleccionar entre 108 tarjetas.

El asistente debe elegir pocas técnicas adecuadas al objetivo, explicar brevemente su enfoque y permitir que el operador las cambie. Para una sesión interactiva, la guía V6.12 recomienda normalmente un lote pequeño de tres o cuatro técnicas cuando la selección se hace conversacionalmente. La generación divergente no debe truncarse prematuramente: primero se exploran posibilidades; la convergencia se realiza en una etapa separada.

Los mecanismos de convergencia posibles incluyen agrupación por afinidad, impacto/esfuerzo, NUF, forced ranking, PMI y MoSCoW. Se seleccionan según la clase de decisión que se necesita, no por aplicar siempre una lista fija.

### 5.3 Uso conversacional

La sesión puede iniciarse de forma natural, por ejemplo: «Quiero idear alternativas para X con Carson». El asistente identifica el objetivo y, si el modo no está implícito, hace una sola pregunta para definir la participación. Después propone el lote de técnicas adecuado. No debe desplegar un formulario, una cuadrícula de técnicas ni una lista extensa de opciones.

El Brain Selector puede ser un recurso alternativo de composición y copia de prompt, pero no es el mecanismo principal. Tampoco es un selector de agentes CIS: el HTML oficial elige modo y técnicas de brainstorming.

### 5.4 Verificación local Carson/BMAD · 2026-11-13

- Se leyó el archivo local MOD-EP-BMAD/app/node_modules/bmad-method/src/core-skills/bmad-brainstorming/SKILL.md; el motor instalado está presente en el entorno de Fila4.
- Se leyó el archivo local scripts/brain.py y se ejecutó el subcomando categories. Resultado observado: 13 categorías y 108 técnicas.
- Se leyó el perfil upstream de Carson y su customize.toml. La opción BS — Guided Brainstorming Session delega en bmad-brainstorming.
- El perfil operativo de chat está materializado en [prompts/CARSON-CHAT.md](prompts/CARSON-CHAT.md), blob de read-back ef334c36d002e11c22b2de156fbff4775a3b56f3.
- La adaptación conserva la identidad/función de Carson y reduce el estilo de comunicación al patrón conversacional acordado. No se afirma que el runtime CIS esté instalado en ChatGPT.

---

## 6. Brainstorm HTML Keepsake — tarea posterior de baja prioridad

La investigación de BMAD V6.12 queda acotada a la ficha provisional EP-TASK-012. BMAD define un archivo brainstorm.html autocontenido, visual, específico de cada sesión, con CSS y JavaScript embebidos y derivado del registro completo; no es un producto que el operador deba diseñar.

La regla upstream distingue modalidades: en Ideate for me se genera automáticamente; en Facilitator y Creative Partner se ofrece como artefacto opcional. La generación no está probada end-to-end en este entorno ChatGPT + RDC. Antes de abordarla se requiere que EP-TASK-009 y EP-TASK-010 estén aceptadas, una prueba de fidelidad contra el registro persistido y una forma segura de guardar el HTML en el proyecto.

**Decisión actual:** no generar ni abrir Keepsake en la primera versión. No es condición para utilizar Carson ni para guardar las ideaciones. Su única ubicación en el plan actual es EP-TASK-012, de baja prioridad y secuencia posterior.

---

## 7. Autoguardado de ideaciones por ciclo y proyectos

### 7.1 Objetivo

Conservar tanto borradores incompletos como ideaciones maduras sin exigir al operador guardar manualmente ni crear nombres antes de empezar. El autoguardado trabaja por ciclo de lluvia de ideas, no por carácter ni por cada turno trivial. El asistente no afirmará que un ciclo está guardado hasta tener confirmación y lectura de vuelta del almacenamiento.

### 7.2 Unidad mínima del modelo

| Objeto | Función | Campos esenciales |
|---|---|---|
| Proyecto | Agrupa sesiones de un mismo esfuerzo de ideación. | id local, nombre, origen del nombre (operador/automático), fechas, etiquetas, estado y puntero a última versión. |
| Sesión | Una conversación de ideación de Carson. | id local, proyecto, tema, objetivo, modo, agente/motor, técnicas, estado y fechas. |
| Ciclo | Unidad inmutable de guardado y recuperación. | id/orden, fecha, fase (divergencia/convergencia/síntesis), técnicas, nuevas ideas, preguntas, hallazgos, decisiones, autoría, madurez y referencias a ciclos anteriores. |

No se modelan turnos completos A/B como una característica de producto. Se conserva el contenido de las ideas y aportaciones significativas, con su autoría y secuencia; el original del operador puede quedar enlazado cuando sea relevante para comprender la instrucción.

### 7.3 Cuándo se guarda un ciclo

Un ciclo termina al completar una tanda de técnica(s), antes de pasar de divergencia a convergencia, al hacer una pausa/interrupción solicitada o al cerrar la sesión. El asistente consolida todo el material generado desde el último ciclo y realiza un único guardado transaccional. No reduce ideas tentativas a un resumen: conserva su formulación íntegra y puede añadir aparte una síntesis.

### 7.4 Proyecto automático y etiquetas esenciales

- Si el operador nombra un proyecto, se usa ese nombre.
- Si no lo nombra, se crea automáticamente un título descriptivo derivado del tema y la fecha; si aún no hay tema, se usa «Ideación sin título — fecha» y se puede renombrar después.
- Etiquetas mínimas: `lluvia-de-ideas`, tema/área, estado de madurez (`borrador`, `en-desarrollo`, `madura`) y estado del proyecto. `reutilizable` solo se añade a las piezas seleccionadas; no se asigna por defecto a todo.
- No se bloquea una sesión por falta de nombre, descripción o etiquetas aportadas por el operador.

### 7.5 Versiones, reanudación y «Guardar como»

Cada ciclo genera un registro inmutable con orden, fecha y SHA-256. El manifiesto de proyecto/sesión se actualiza atómicamente y conserva versiones previas. Una corrección posterior se agrega como nueva revisión o evento; no se reescribe un ciclo aceptado. La reanudación carga el último ciclo verificado y todos los ciclos previos necesarios.

«Guardar» mantiene la sesión en el proyecto activo. «Guardar como» crea un proyecto derivado que referencia el original; no duplica ni altera el registro canónico. Si el usuario desea continuar desde ese punto, se abre una sesión nueva enlazada al mismo origen.

### 7.6 Archivos y ruta lógica

Esquema lógico mínimo dentro del workspace protegido EP:

    SeryMente/Metodologia/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/data/<terminal>/brainstorming/
      projects/<project-id>/project.json
      projects/<project-id>/sessions/<session-id>/session.json
      projects/<project-id>/sessions/<session-id>/cycles/000001.json
      projects/<project-id>/sessions/<session-id>/cycles/000002.json
      library/library.sqlite

Las rutas anteriores son esquema, no existen todavía. No se materializarán bajo Desktop, Downloads, AppData, Temp ni fuera del punto de montaje de Cryptomator. La escritura real depende de disponer de la bóveda EP desbloqueada.

### 7.7 Integridad, recuperación y duración

La escritura de ciclo será atómica, con flush/fsync, hash, lectura de vuelta y actualización del manifiesto. Los ciclos son la fuente canónica; el índice es derivado y reconstruible. La persistencia local protegida será la copia de trabajo. El respaldo remoto seguirá el mecanismo EP vigente, exclusivamente como ciphertext cifrado del lado cliente y con lectura de vuelta y prueba de restauración; no se construirá un backup paralelo dentro del módulo.

El producto se diseña para conservación a largo plazo, pero no se promete permanencia literal «hasta el fin de los tiempos». La garantía verificable depende de redundancia, integridad periódica, custodia de claves y pruebas de restauración. El bloqueo de la bóveda o la falta de backup aceptado se mostrará como riesgo de persistencia, no como guardado completo.

### 7.8 Adaptación de BMAD memlog

La skill de BMAD describe memlog como cronológico y append-only, pero la documentación de SKILL.md/finalize.md también recomienda mutar un campo status mediante el subcomando set. El script local efectivamente implementa ese subcomando genérico, aunque el propio encabezado de memlog.py niega que el log tenga estado de ciclo de vida. Para evitar inconsistencia, Product Design mantendrá el estado (`active`, `paused`, `completed`) en session.json y registrará el evento de cierre en el ciclo; no usará `set status` sobre el memlog como fuente canónica de estado.

---

section library

---

## 9. Proceso de Product Design y ruta de trabajo

El catálogo funcional documentado en las instrucciones previas contempla estas capacidades, sin imponer una secuencia rígida y distinguiendo diseño de producto de entrega de ingeniería:

| Capacidad | Alcance |
|---|---|
| Product Discovery y análisis | Comprender contexto, necesidades, problema, usuarios, evidencia, supuestos y restricciones. |
| Brainstorming | Ideación divergente, técnicas creativas, exploración y convergencia. |
| Definición de producto / Product Brief | Objetivo, propuesta de valor, usuarios, alcance, objetivos y métricas. |
| Requirements / PRD | Requisitos funcionales y no funcionales, historias, reglas y criterios de aceptación. |
| UX / UI | Arquitectura de información, flujos, estados, contenido, interacción y especificaciones visuales. |
| Arquitectura | Estructura funcional y técnica del producto, límites, interfaces y decisiones. |
| Prototipado | Artefactos conceptuales, visuales, navegables o funcionales con su fidelidad identificada. |
| Planificación y descomposición | Plan de trabajo y tareas trazables a fuentes, asignadas a los frentes responsables. |
| Implementación | Construcción del producto en el frente técnico responsable; no se presume que el módulo Product Design sea dueño del código de todos los proyectos. |
| Pruebas / QA | Diseño y ejecución de pruebas pertinentes, criterios y evidencia. |
| Revisión | Revisión de requisitos, diseño, cambios y resultados contra criterios acordados. |
| Retrospectiva | Captura de hallazgos y mejoras del proceso tras un ciclo o entrega. |

La primera línea —descubrimiento, análisis, brainstorming, definición, requisitos, UX y arquitectura— pertenece al núcleo de diseño. Planificación, tareas, implementación, QA, revisión y retrospectiva son capacidades de continuidad y entrega que pueden activarse cuando la instrucción las requiera y deben asignarse al FT que realmente tenga la responsabilidad. La selección deriva de la necesidad real; no todo problema empieza con brainstorming ni todo producto debe recorrer las capacidades en orden lineal.

### Primer hito funcional

Dejar listo el circuito Brainstorming desde ChatGPT: selección conversacional del agente/modo/técnicas, facilitación correcta, registro persistente, reanudación, síntesis y Keepsake generado conforme al modo y a la autorización aplicable.

---

## 10. Versiones y fuentes de BMAD

La instalación registrada en EP informa BMAD Core **6.12.4**. La investigación de la rama estable V6.12 del repositorio oficial confirmó el diseño del selector, las tres modalidades, el contrato de memlog y el flujo Keepsake. La documentación actual de BMAD muestra diferencias evolutivas con V7; V7 se trata como línea distinta y no se importa automáticamente.

| Fuente | Versión/revisión adquirida | Uso |
|---|---|---|
| BMAD src/core-skills/bmad-brainstorming/SKILL.md | rama V6.12 · blob a4141454a3b29bf40c89fda4394f1ef80cf9cab5 | activación, modos, selección conversacional y flujo de sesión. |
| BMAD references/finalize.md | rama V6.12 · blob 2a4b6d25f2e6c572ebbd5454037ccadfc5d9c69b | síntesis y especificación del Keepsake. |
| BMAD src/scripts/memlog.py | rama V6.12 · blob 65c06e0bd62719c745a59ceed03e8fc1fb472422 | contrato append-only y conflicto de estado. |
| BMAD scripts/brain.py | rama V6.12 · blob 1ffb7684c970dbe0ba270f27f3906fa5bcf9cc2f | catálogo consultable y selector HTML. |
| BMAD assets/brain-selector.html | rama V6.12 · blob ac649b24fffa6b29a7c032cea2502207c8f39a92 | composer oficial de modo y técnicas; no es selector CIS. |
| CIS | commit anteriormente adquirido 658e71030be808181c1031f5461ee3613e7ff530 | nombres de agentes y configuraciones colaborativas; confirmar revisión viva antes de integrar. |

**Compatibilidad pendiente:** CIS recomendó en la documentación previamente inspeccionada una versión posterior del core brainstorming que la instalación BMAD local. La referencia histórica precisa el desfase: el manifest de Carson/CIS declara BMAD 6.13.0, mientras EP registra BMAD Core 6.12.4. No se actualizará BMAD automáticamente. La alineación de versiones y el conjunto CIS deben probarse por separado antes de aceptar el runtime. El diseño parte de conservar 6.12.4 hasta que una prueba de regresión demuestre compatibilidad; no se eleva la versión ni se instala CIS por inferencia.

---

## 11. Estado real de implementación y discrepancias

### 11.1 Elementos observados en el acumulado anterior

| Elemento | Evidencia previa | Estado que debe conservarse |
|---|---|---|
| Instalación BMAD Core 6.12.4 | OEP §142.15 y archivos locales reportados en el módulo EP-BMAD. | INSTALACIÓN REPORTADA/VERIFICADA EN CICLO ANTERIOR; frescura actual pendiente. |
| Catálogo de 108 técnicas y 13 categorías | Ejecución local anterior de brain.py categories y selector original. | OBSERVADO EN CICLO ANTERIOR. |
| Brain Selector HTML original | Archivo upstream y copia local identificados. | EXISTE; no es la interfaz primaria del diseño. |
| Portal auxiliar app/index.html | Archivo local creado por el asistente; catálogo CIS y pantallas. | ARTEFACTO AUXILIAR NO ACEPTADO COMO UI OBJETIVO. No abrir ni ampliar. |
| Launcher Start-BMAD-BrainSelector-EP.ps1 | Ejecución anterior y logs descritos en el acumulado. | UTILIDAD EXISTENTE; perfil/flujo de apertura no cumple el requerimiento de Chrome principal y no debe usarse como ruta objetivo. |
| Paquete CIS local | El acumulado anterior indica que no se había instalado. | NO INSTALADO/NO VERIFICADO; no reclamar runtime. |
| Seis agentes CIS en el portal | Catálogo visual creado; algunos botones copian prompts. | PRESENTACIÓN DE NOMBRES, NO EJECUCIÓN REAL DE LOS AGENTES. |
| Memlog de BMAD | Fuente oficial disponible; el runtime local no se revalidó en este ciclo. | DISEÑO DOCUMENTADO; integración local y consistencia de lifecycle pendientes. |
| Keepsake generado de extremo a extremo | Referencia V6.12 revisada; no se presentó una prueba local completa. | ESPECIFICACIÓN EXISTENTE; GENERACIÓN INTEGRADA NO DEMOSTRADA. |
| Autoguardado y versiones Office-like | No existe evidencia suficiente de una solución completa en Product Design. | DISEÑO PENDIENTE DE IMPLEMENTACIÓN. |
| Biblioteca indexada reusable | No existe evidencia suficiente de implementación en Product Design. | DISEÑO PENDIENTE DE IMPLEMENTACIÓN. |

### 11.2 Artefactos históricos que contienen el diseño equivocado

Los siguientes artefactos conservan información histórica y no deben borrarse por este cambio. No obstante, sus descripciones de arquitectura deben reconciliarse con este documento antes de cualquier implementación:

- ESPECIFICACION-OPERATIVA-VMAT.md.
- EP-TASK-008 y su estado histórico en_curso.
- frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/README.md, en sus apartados heredados de vMAT/Superpowers/portal.
- OEP §§142.19–142.20.
- La interfaz auxiliar app/index.html, su launcher y el perfil de Chrome EP.

Las expresiones vMAT proceden de una transcripción errónea de BMAD. La integración operativa de Superpowers y la utilización de OpenCode como constructor de Product Design no pertenecen a la arquitectura objetivo actual. Esta constatación documental no autoriza desinstalar software, borrar configuraciones, destruir la interfaz auxiliar ni cerrar tareas históricas sin un procedimiento de reconciliación.

### 11.3 Trabajo que no se debe iniciar aún

- No instalar ni actualizar BMAD/CIS.
- No modificar el Brain Selector oficial.
- No ampliar el portal auxiliar ni diseñar otro portal.
- No abrir Chrome en un perfil diferente del principal del operador.
- No generar carpetas/índices/sesiones vacías para aparentar implementación.
- No activar OpenCode ni Superpowers como runtime de Product Design.
- No crear tareas provisionales hasta completar el diseño y revisar Harmonia.
- No iniciar la categoría Cognición visoespacial y proyección visual.

---

## 12. Categoría futura diferida

**Nombre:** Cognición visoespacial y proyección visual.

Por instrucción del operador, esta categoría queda fuera del trabajo inmediato. Se conservan como antecedentes los documentos identificados en FUENTES-CAPACIDADES-VISOESPACIALES.md y sus referencias asociadas. No se reabre su análisis, no se amplía su catálogo, no se implementa ni se desglosa en tareas durante este sprint inicial de Product Design.

Su posición futura es posterior a los componentes esenciales de Product Design. No se asignan aquí número de fase, prioridad cuantificada, ID de tarea, OCP separado ni folio.

---

## 13. Integridad de extremo a extremo y gates de aceptación

El flujo mínimo debe conservar continuidad desde la ideación hasta su recuperación:

    Usuario → chat Carson → motor BMAD Brainstorming
       → ciclos de ideación → proyecto nombrado/auto-nombrado
       → persistencia por ciclo y versiones
       → índice FTS5 derivado → búsqueda y referencias reutilizables
       → respaldo cifrado EP → restauración comprobada

A/B no es un módulo ni un formato de dato que la lluvia de ideas deba manejar. Las sesiones conservan autoría, contenido, orden, técnicas y referencias de origen; el control documental A/B permanece fuera del producto.

| Gate | Criterio | Evidencia requerida |
|---|---|---|
| G1 · Activación | Carson puede invocarse desde chat normal sin portal ni selector. | Prueba conversacional en ChatGPT. |
| G2 · Motor | Los tres modos se aplican correctamente y las técnicas provienen del catálogo BMAD local fijado. | Prueba por modo y trazas de técnica. |
| G3 · Ideación | Ideas incompletas y maduras se conservan sin filtrado ni pérdida; autoría y secuencia quedan claras. | Comparación con el contenido de sesión. |
| G4 · Ciclo | Al terminar una tanda, pausa, transición o cierre se genera un único registro durable. | Registro, SHA-256, read-back y contador del último ciclo. |
| G5 · Reanudación | Una sesión interrumpida se reabre desde su último ciclo íntegro. | Prueba de reanudación natural. |
| G6 · Proyectos | El proyecto se crea con el nombre indicado o uno automático y etiquetas esenciales. | Manifiesto y prueba de proyecto sin nombre. |
| G7 · Versiones | Los ciclos anteriores se conservan y se puede volver a una versión sin destruir la actual. | Restauración y cotejo de hashes. |
| G8 · Biblioteca | FTS5 permite localizar contenido, proyectos y etiquetas; el índice se reconstruye desde los originales. | Búsquedas reales, rebuild y comparación. |
| G9 · Reutilización | Una idea puede vincularse a más de un proyecto sin perder ni duplicar el origen canónico. | Referencias cruzadas verificadas. |
| G10 · Seguridad | Contenido solo en workspace EP protegido y respaldo cliente-cifrado. | Preflight de rutas, permisos, backup y restore. |
| G11 · Durabilidad | Hay al menos copia de trabajo protegida y respaldo independiente aceptado. | Lectura de vuelta y restore test completo. |
| G12 · Alcance | Brain Selector/Keepsake no bloquean el primer release y no se activan por omisión. | Aceptación del recorrido chat-only. |

Un diseño o documento no acredita el funcionamiento. Los gates se aceptan con pruebas reales; ningún índice sustituye a las fuentes originales. La duración indefinida se trata como objetivo de conservación con controles verificables, nunca como garantía absoluta.

---

## 14. Desglose y secuencia de tareas provisionales

La inspección del frente Harmonia ya se realizó sobre su OCP v0.46, README y controles. No se encontró un índice independiente de tareas provisionales bajo la raíz de Harmonia; su rigor aparece en el OCP mediante instrucciones literales, matrices requisito/estado/evidencia, criterios de aceptación, crónicas y límites de verificación. Para materializar Product Design se conserva la estructura vigente de EP: índice único de tareas y un README núcleo/crónica por tarea.

El conjunto mínimo derivado de la instrucción de implementación es:

| ID | Prioridad/secuencia | Resultado independiente | Fuente principal |
|---|---|---|---|
| EP-TASK-009 | Alta · primer hito | Carson conversacional en ChatGPT, integrado con BMAD Brainstorming y los tres modos. | SRC-PD-20261113-IDEACION-03 |
| EP-TASK-010 | Alta · núcleo persistente | Guardado por ciclo, proyectos con nombre automático/etiquetas, versiones recuperables y biblioteca indexada/reutilizable. | SRC-PD-20261113-IDEACION-03 |
| EP-TASK-011 | Baja · posterior a 009 | Evaluar/adaptar Brain Selector oficial como comodidad opcional; no como puerta de entrada. | SRC-PD-20261113-IDEACION-03 y SRC-PD-20261113-ALCANCE-02 |
| EP-TASK-012 | Baja · posterior a 009/010 | Generación automática del HTML Keepsake desde el registro persistido, sin diseño del operador. | SRC-PD-20261113-IDEACION-03 y SRC-PD-20261113-ALCANCE-02 |

Las dos tareas núcleo son independientes para aceptación técnica, pero el módulo solo satisface la experiencia completa cuando ambas están aceptadas. Las tareas 011 y 012 no son dependencias ni bloquean el primer uso. La Prótesis Cognitiva se registra como integración futura expresamente diferida, sin crear tarea ahora.

Cada núcleo de tarea conserva: solicitud original verbatim, lectura normalizada separada, matriz fuente → requisito → tarea → entregable → criterio de aceptación → evidencia, dependencias, limitaciones y crónica por ciclo. El ID de tarea no crea OCP, frente, titularidad ni autorización independiente.

---

## 15. Riesgos, decisiones técnicas todavía abiertas y verificaciones

| Ref. | Tema | Estado | Resolución prevista antes de implementación |
|---|---|---|---|
| Ref. | Tema | Estado actual | Siguiente acción de resolución |
|---|---|---|---|
| R-01 | Escritura local en workspace EP protegido. | BLOQUEADA · bóveda aún bloqueada en la observación de este ciclo. | Desbloqueo local del EP Vault por el operador; después prueba de escritura atómica y read-back bajo la identidad Fila4. |
| R-02 | Respaldo remoto a largo plazo. | DEPENDENCIA EP-TASK-002 en curso; aceptación del backup para este módulo NO VERIFICADA. | Reutilizar únicamente el mecanismo EP cliente-cifrado una vez aceptado; exigir prueba de restore. |
| R-03 | Flujo conversacional Carson. | FUENTE INSTALADA Y PERFIL DE CHAT DEFINIDO; prueba funcional end-to-end pendiente. | Ensayar los tres modos, el cambio de técnicas y una reanudación. |
| R-04 | SQLite FTS5. | PASS EN MEMORIA en Python sqlite 3.45.1 bajo CENTRAL\\fila4. | Repetir dentro del workspace protegido al construir el índice real. |
| R-05 | Memlog BMAD: instrucciones de lifecycle no coinciden. | DISCREPANCIA CONFIRMADA. memlog.py tiene set genérico pero documenta que no hay status de ciclo de vida. | Mantener estado en session.json; el registro de ciclos queda append-only. |
| R-06 | Durabilidad «para siempre». | OBJETIVO DE CONSERVACIÓN; no existe garantía absoluta de permanencia. | Dos copias protegidas independientes, hashes, custodia de claves, monitoreo y restores periódicos. |
| R-07 | Conexiones RDC con hostname común. | DOS CONTEXTOS WINDOWS DIFERENTES, mismo host aparente. | Fijar device UUID e identidad; no intercambiar perfiles ni raíces. |
| R-08 | Integración Prótesis Cognitiva. | DIFERIDA POR EL OPERADOR. | Mantener punto de integración documentado; no iniciar ni crear tarea en esta secuencia. |

---

## 16. Fuentes y procedencia documental

### Fuentes internas del módulo EP/Product Design

- DISENO-ACUMULADO-BMAD-PRODUCT-DESIGN.md: acumulado anterior, que se conserva como antecedente.
- FUENTES-CAPACIDADES-VISOESPACIALES.md: registro de documentos de la categoría futura diferida.
- fuentes/ChatGPT-PRODUCT-20261113-0951.md: export conversacional anterior de Product Design.
- fuentes/ChatGPT-Product Design-20261113-1212.md: export conversacional anterior.
- fuentes/ULTIMA-SALIDA-CICLO-20261113-1201.md: última salida preservada de ese ciclo.
- README.md del módulo: puerta de entrada que requiere reconciliar sus apartados históricos.
- OEP EP §§142.18–142.20 y §145: estado heredado del módulo y antecedentes de la integración.

### Registro de decisiones históricas y rectificaciones

Estos anclajes permiten recuperar las instrucciones anteriores sin reconstruirlas de memoria. Las referencias de línea corresponden a los archivos de exportación conservados en el OCP del módulo.

| Ancla de fuente | Ubicación | Contenido relevante | Estado actual |
|---|---|---|---|
| SRC-PD-20261112-TASK-01 | fuentes/ChatGPT-PRODUCT-20261113-0951.md, línea 1025 | El objetivo de usar ChatGPT para poblar tareas provisionales trazables a los dictados verbatim y crear el mínimo trabajo que agote la instrucción. | VIGENTE en cuanto a captura y trazabilidad; la referencia a Superpowers como complemento operativo queda rectificada. |
| SRC-PD-20261113-OPENCODE-01 | fuentes/ChatGPT-Product Design-20261113-1212.md, líneas 700–729 | El operador aclara que no eligió OpenCode y pregunta si basta ChatGPT + RDC; la recomendación registrada es mantener OpenCode fuera del flujo necesario. | BASE DE LA DECISIÓN CHATGPT + RDC; OpenCode no es dependencia objetivo. |
| SRC-PD-20261113-CHAT-RDC-01 | mismo archivo, líneas 1407–1413 | Adaptar CIS al flujo ChatGPT + RDC, conservar el método local y desarrollar una capacidad propia; en ese momento se consideraba Carson como primer foco. | VIGENTE en arquitectura; el alcance de agentes fue ampliado posteriormente a los seis para V1.0. |
| SRC-PD-20261113-CIS-V1-01 | mismo archivo, líneas 2073–2075 | Explorar los seis agentes CIS y una interfaz local. | ANTECEDENTE DE CATÁLOGO; el orden vigente comienza con Carson por SRC-PD-20261113-IDEACION-03, sin UI de selección en el primer release. |
| SRC-PD-20261113-CORRECCION-01 | sección 18 de este documento | Superpowers solo como referencia de habilidades a desarrollar por cuenta propia; autoguardado tipo Office; biblioteca indexada; esquema visoespacial diferido; tareas según Harmonia. | VIGENTE. |
| SRC-PD-20261113-ALCANCE-02 | sección 18 de este documento | Chat como interfaz suficiente; no crear interfaz si no aporta; Keepsake debe ser generado por el agente sin diseño del operador; investigar e integrar el autoguardado y la biblioteca. | VIGENTE; Brain Selector y Keepsake diferidos. |
| SRC-PD-20261113-IDEACION-03 | mensaje del operador del 2026-11-13, reproducido literalmente en §18 | Carson chat-first; extras Brain Selector/Keepsake en tareas de baja prioridad; autoguardado por ciclo; proyecto con nombre automático/etiquetas esenciales; conservación de ideaciones parciales y maduras; biblioteca; integración futura con Prótesis Cognitiva; A/B fuera de la función de producto. | VIGENTE PARA LA PRIMERA VERSIÓN Y SU SECUENCIA. |

**Regla de precedencia temporal:** los dictados anteriores se conservan íntegros. Cuando una decisión anterior y una rectificación posterior difieren, se mantiene la primera como historia y la última como objetivo vigente únicamente en el punto que modifica. La corrección de interfaz no elimina el requisito de explorar los seis agentes; la corrección sobre Superpowers no elimina el requisito de desarrollar capacidades propias a partir de referencias.

### Fuentes oficiales BMAD examinadas

- Repositorio: bmad-code-org/BMAD-METHOD.
- Rama estable examinada: V6.12, no el estado preview de V7.
- Archivos y blobs citados en §10.
- La especificación de Keepsake procede principalmente de references/finalize.md; los modos, interacción y ruta conversacional proceden de SKILL.md.
- El selector HTML oficial solo configura el modo y las técnicas de brainstorming; no selecciona agentes CIS.

### Fuentes CIS

- Repositorio oficial previamente examinado: bmad-code-org/bmad-module-creative-intelligence-suite.
- Commit de referencia adquirido: 658e71030be808181c1031f5461ee3613e7ff530.
- Las configuraciones colaborativas y los seis agentes deben volverse a comprobar en la revisión viva antes de integrarlos.

### Límites de evidencia

Este documento distingue la documentación upstream, los artefactos locales registrados y el estado técnico comprobado en el ciclo 2026-11-13. El perfil conversacional Carson está preparado como documento y el motor BMAD local está presente; la prueba de una sesión Carson completa sigue pendiente. Autoguardado y biblioteca no están implementados. Keepsake no se ha generado ni validado. La existencia de un recurso upstream no acredita un runtime CIS nativo.

---

## 17. Estado del diseño y arranque de implementación

**Diseño base de la primera versión:** CERRADO DOCUMENTALMENTE para Carson conversacional + persistencia por ciclo + biblioteca básica. La cadena de integridad, el alcance mínimo y las condiciones de aceptación están definidos en §§3, 5, 7, 8 y 13. La revisión de Harmonia y el patrón de EP para las tareas ya fueron inspeccionados.

**Implementación material:** Carson-CHAT.md se entrega como perfil operativo reutilizable en el chat. El motor BMAD Brainstorming local y el perfil CIS Carson han sido inspeccionados. La persistencia y biblioteca aún no están activas: el EP Vault estaba bloqueado durante este ciclo y no se escribió fuera del perímetro cifrado. El primer hito conversacional no necesita Brain Selector, Keepsake, portal ni OpenCode.

**Secuencia:** EP-TASK-009 Carson; EP-TASK-010 persistencia por ciclo y biblioteca; después, sin bloquear el primer release, EP-TASK-011 Brain Selector y EP-TASK-012 Keepsake. La integración con Prótesis Cognitiva queda diferida.

**Límites de aceptación:** diseño documental = verificado; perfil de conversación = preparado; uso funcional real = pendiente de sesión de prueba; guardado local/remoto = pendiente de desbloqueo EP Vault y backup EP aceptado; integración total = NO ACEPTADA.

**Siguiente paso:** probar Carson por chat con un tema real. En paralelo, la parte de almacenamiento solo continuará cuando la bóveda EP esté desbloqueada bajo el perfil autorizado; entonces se materializarán los archivos y el índice y se validará la restauración.


---

## 18. Instrucciones originales verbatim de la conversación de consolidación

Este apartado conserva las instrucciones A del operador literalmente para su posterior trazabilidad. No normaliza la transcripción ni convierte las correcciones de voz en una versión sustitutiva. Las decisiones normalizadas constan separadamente en §§2–3 y las futuras tareas deberán enlazar estos originales.

### SRC-PD-20261113-CORRECCION-01 · instrucción A · 13-11-2026

~~~text
Cuando abras esas pestañas, hazlo en el navegador Chrome que está bajo mi sesión con mi correo principal de Víctor Hugo, porque las estás abriendo en un navegador aparte y así no es

Superpowers es para uso solamente de referencia para que esas habildiades seanlas que desarrollemos por neustra cuenta.Esto lo he dicho varias vees y ya no lo quiero repetir. No lo quiero par otra cosa. Y esolo en esqa medida lo usaremos. Pwero si lo usaremos par aeso.

Me parece extraño que hayas encontrado omisiones y contradicciones, porque no ha habido falta de claridad en las instrucciones que he venido dictando a lo largo de las últimas conversaciones que tienen que ver con esta acumulación. Sin embargo, aclaro. El autoguardado de versiones tipo Office hay que resolverlo. También la biblioteca indexada reutilizable para esta implementación, aunque sea de manera básica. No creo que sea muy difícil Luego, nada más quiero dos elementos. Y eso porque me los ofreciste y pensé que eran fáciles de obtener. Brain Selector en los términos de lo dicho en la conversación anterior. Porque ya dicté lo que tenía que dictar al respecto, ¿me explico? Pero bueno, eres una computadora y si algo tonto estarme frustrando contra ti. Cuando construyas las tareas bueno observa cómo está construido el frente de trabajo Armonía. Ahí construí tareas cuidadosamente asociándolas a las instrucciones verbatim que iba dictando. Quiero que cuando termines el documento del vaciado del diseño, observes ese arreglo y lo repliques con el mismo nivel de, con la misma estructura y la misma rigurosidad que se está haciendo en ese frente. Quiero decir con la misma estructura y la misma rigurosidad que se está haciendo en ese frente. Quiero que esa instrucción es suficiente para dejar claro cuál es el requerimiento Sí, la sombrilla va a ser cognición visoespacial y proyección visual. Por ahora nada más registra los documentos y la categoría y déjalo para después. No quiero invertirle más energía por ahora. Una sola, un solo archivo HTML en el host local para contener Brain Selector y Brainstorm HTML Keep Safe. Algo que tenga tabulaciones o algo, pero que queden en el mismo, o bueno, corrijo, está bien, dos elementos, uno para cada uno. Tenía la idea de que eran soluciones que ya se podían tener sacadas de la caja completas. Explícame cómo es porque lo que yo vi en el navegador que abriste parecía como que lo hiciste tú, al vapor
~~~

### SRC-PD-20261113-ALCANCE-02 · instrucción A · 13-11-2026

~~~text
Bueno, yo pensé que Brain Selector iba a poder ser utilizado para de alguna manera adecuarlo a la implementación para que cuando la empieces a usar se abra el selector y yo pueda seleccionar entre los recursos para la lluvia de ideas nada más los diferentes agentes y los tipos de técnica utilizada. La verdad es que vi lo que me mostraste y se me pareció muy desagradable porque estaba lleno de elementos por todos lados y fue como que un ataque radiactivo para mí, para mi atención. Entonces nada más necesito tener una interfaz, bueno, no la necesito. Se puede utilizar la plataforma de chat. Si es mucho problema, mejor lo hacemos únicamente por el chat. Y luego el otro elemento HTML, keep safe, pensé que era como una forma de obtener un resultado gráfico después de la lluvia de ideas, pero que no me tenga que poner a mí a diseñar ese elemento porque si lo tengo que diseñar, pues entonces no lo quiero tener. Y por lo que veo no lo conoces como para saber en qué medida va a ser trabajo adicional. Hay que investigar bien esa sugerencia que tú me hiciste Sigue avanzando construyendo un documento general del sprint, preparándote para crear las tareas provisionales conforme lo dicho. Y teniendo en cuenta que existen diseños pendientes como el autoguardado y la biblioteca indexada, que tampoco es mucho trabajo, pero sí tienes que crear un esquema porque antes de ejecutar vamos a revisar la integridad del diseño de extremo a extremo
~~~

**Regla de uso posterior:** cada requisito extraído de estas fuentes debe conservar vínculo al pasaje literal que lo origina. Las transcripciones erróneas se mantienen aquí intactas; cualquier normalización semántica se registra en campo separado y nunca se presenta como literal.


### SRC-PD-20261113-IDEACION-03 · instrucción A · 13-11-2026

~~~text
Bueno, vamos a empezar con una implementación que me permita acceder a una herramienta para lluvia de ideas madura, apoyada en las habilidades, el motor de Carson para la primera versión vía chat prescindiendo de los elementos extras que son Brain Selector, Rush HTML Keep Safe. Nada más acota los resultados de tu investigación en cuanto a estos dos elementos en las tareas provisionales de baja prioridad, las que van a estar más adelante en la secuencia en el frente

El autoguardado tipo Office y la biblioteca indexada no tiene que ser al carácter, sino por ciclo. Hacer un guardado básico del proyecto en curso autonombrándolo si el usuario no aporta alguna denominación y etiquetándolo de manera esencial. Es decir como es un módulo de lluvia de ideas, lo que yo estoy tratando de hacer es disponer de una persistencia de los borradores de las ideas que trabaje a veces de manera incompleta o poco finalizada, así como de las más maduras que también podré trabajar de manera profunda con la ayuda de la herramienta. Y disponer de estos diseños hasta el fin de los tiempos sin tener miedo a que se pierdan esas ideaciones. Por cierto, qué bueno que me acuerdo. Este módulo tiene que conectarse con la prótesis cognitiva. Pero bueno, de eso me encargo después porque sería demasiado para mantener el hilo con tanta divergencia. Ahora, ¿por qué le pones continuidad AB? ¿Eso qué tiene que ver? Resuelve el autoguardado, por así decirlo, y la biblioteca de manera que tengamos un marco esencial apegado única y estrictamente a lo necesario. Creo que con estas instrucciones tienes lo necesario para completar el diseño y verificar y garantizar la integridad del mismo antes de la ejecución
~~~

**Regla de trazabilidad:** el bloque A se conserva literalmente; el diseño derivado no redefine su texto. A/B pertenece al control documental del ciclo, no al modelo de datos ni a la interfaz de Product Design.