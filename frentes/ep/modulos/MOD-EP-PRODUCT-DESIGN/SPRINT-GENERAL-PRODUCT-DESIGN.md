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
| PD-D-004 | CIS aporta seis agentes que deben contemplarse, uno por uno, en Product Design V1.0. | CONFIRMADA |
| PD-D-005 | Superpowers se utiliza exclusivamente como referencia para identificar capacidades que desarrollaremos por nuestra cuenta. No se instala, integra, ejecuta ni adopta como herramienta operativa de este diseño. | CONFIRMADA |
| PD-D-006 | Brain Selector no es requisito de la experiencia inicial. Puede conservarse como recurso oficial disponible, pero la ruta preferente será seleccionar en el chat. | CONFIRMADA |
| PD-D-007 | Brainstorm HTML Keepsake solo tiene sentido si se genera automáticamente a partir de la sesión; el operador no diseña ni compone ese HTML. | CONFIRMADA |
| PD-D-008 | La implementación debe tener autoguardado y versiones recuperables, con una experiencia comparable a Office. | CONFIRMADA |
| PD-D-009 | La implementación debe incluir una biblioteca indexada y reutilizable, inicialmente básica. | CONFIRMADA |
| PD-D-010 | La integridad del diseño completo se revisará antes de ejecutar la implementación. | CONFIRMADA |
| PD-D-011 | La categoría futura se denomina Cognición visoespacial y proyección visual; por ahora solo se conservan su categoría y sus documentos de referencia. | CONFIRMADA · DIFERIDA |
| PD-D-012 | Las tareas provisionales se construirán después del vaciado completo del diseño, replicando la estructura y rigurosidad observadas en el frente Harmonia y asociando cada tarea a los dictados verbatim que la sustentan. | CONFIRMADA · FASE POSTERIOR |

### 2.1 Corrección explícita sobre Superpowers

Superpowers queda fuera de la arquitectura operativa objetivo. Su única función en este sprint es servir como corpus de referencia para reconocer habilidades o capacidades que el equipo pueda diseñar e implementar por cuenta propia. No es una dependencia, motor de ejecución, plugin, conjunto de skills instaladas para el producto ni método de trabajo de los agentes Product Design. La configuración histórica existente en OpenCode no se elimina ni se modifica por esta decisión; su retirada sería una actuación separada y no está incluida aquí.

### 2.2 Decisiones que no deben reabrirse por error de documentación

No volver a proponer Superpowers como instrumento de ejecución. No volver a presentar el portal auxiliar como la interfaz solicitada. No exigir Brain Selector para iniciar una sesión de brainstorming. No pedir al operador que diseñe el Keepsake. No trasladar la categoría visoespacial a la primera etapa. No convertir la lista de capacidades en una secuencia rígida si el problema concreto requiere otra ruta.

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

- **Agente:** quién conduce la capacidad (por ejemplo, Carson para brainstorming).
- **Modo/stance:** cómo participa el agente y cómo se distribuye la generación de ideas (Facilitator, Creative Partner o Ideate for me).
- **Técnica:** el procedimiento concreto de ideación utilizado en una etapa o lote.

No se debe construir un único menú que mezcle agentes, modos, técnicas, fases, visualizaciones y configuraciones colaborativas como si fueran opciones del mismo nivel.

### 3.3 Papel de RDC y del entorno persistente

Remote Desktop Commander (RDC) es el puente del asistente hacia los archivos, scripts y recursos del entorno local autorizado. La conversación dirige; el entorno persistente conserva los artefactos. No se presupone que ChatGPT cloud pueda acceder directamente a 127.0.0.1, al disco local o al portapapeles.

Las operaciones de persistencia deben realizarse mediante una conexión RDC vigente, seleccionada conforme al procedimiento de EP. No inferir que dos conexiones con el mismo hostname representan la misma sesión, cuenta o perfil.

### 3.4 Chrome y perfil de usuario

No abrir un perfil aislado ni una instancia paralela que no corresponda a la sesión principal del operador. Cuando la presentación de un artefacto requiera navegador, se utilizará la instancia de Chrome existente bajo la sesión principal de Víctor Hugo y su correo principal. No usar el perfil dedicado MOD-EP-CHROME/data/Fila4/user-data como sustituto de esa sesión. No se realizará ninguna apertura durante esta fase de diseño.

### 3.5 Interfaz visual: decisión mínima

La interfaz inicial es el chat. No se construirá un portal, dashboard o selector general de agentes.

El Brain Selector original de BMAD puede seguir disponible como recurso opcional, pero no se debe abrir automáticamente ni convertir en requisito. Si en una fase futura se demuestra que una interfaz mínima aporta valor, el alcance tendría que limitarse a una elección clara de agente, modo y técnicas pertinentes, con carga cognitiva baja. Esa adaptación no está aprobada ni se necesita para comenzar.

---

## 4. Catálogo CIS que debe soportar Product Design V1.0

Los seis agentes que integran el alcance exploratorio de CIS son:

| Agente | Capacidad asociada | Función dentro de Product Design | Observación |
|---|---|---|---|
| Carson | Brainstorming Coach → bmad-brainstorming | Ideación divergente, facilitación, asociación y síntesis. | Utiliza el motor de brainstorming de BMAD Core. |
| Maya | Design Thinking Coach → bmad-cis-design-thinking | Comprender necesidades, formular problemas, idear, prototipar y probar. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Dr. Quinn | Creative Problem Solver → bmad-cis-problem-solving | Diagnosticar y resolver problemas creativos o complejos. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Victor | Innovation Strategist → bmad-cis-innovation-strategy | Explorar oportunidades, innovación y opciones estratégicas. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Sophia | Storyteller → bmad-cis-storytelling | Construir narrativas y comunicar una idea o propuesta. | Confirmar sus archivos y flujo oficial al integrar CIS. |
| Caravaggio | Presentation Master → bmad-cis-agent-presentation-master | Planificar y revisar presentaciones, guiones y recursos visuales. | El agente está documentado; la disponibilidad de workflows empaquetados requiere verificación. |

Caravaggio tiene referencias de menú PL (plan de presentación/pitch), CR (crítica de deck o visual), EX (guion explicativo) y VM (selección de recurso visual). No se declara que esos workflows estén instalados o aceptados localmente solo por existir el agente.

CIS también ofrece configuraciones colaborativas Creative Squad y Design Pair. Sus integrantes, reglas y comportamiento deben leerse directamente de la configuración oficial; no se infieren por los nombres.

**Regla de cobertura:** Product Design V1.0 no se limita a Carson. La integración y evaluación debe abarcar los seis agentes y las configuraciones colaborativas que la fuente oficial confirme, distinguiendo siempre entre documentación upstream, instalación local, invocación observable y aceptación.

---

## 5. Brainstorming: funcionamiento objetivo

### 5.1 Tres modos oficiales

La referencia BMAD V6.12 define tres modalidades:

- **Facilitator:** el agente facilita, pregunta y provoca; no aporta ideas durante la generación divergente. Su contribución creativa se reserva para la síntesis final.
- **Creative Partner:** el agente y el operador generan ideas conjuntamente. La autoría de cada aportación del agente y del usuario se conserva.
- **Ideate for me:** el agente realiza la exploración de manera autónoma y presenta el resultado.

La modalidad se conserva durante toda la sesión. No se debe cambiar de modo silenciosamente a mitad de una lluvia de ideas.

### 5.2 Técnicas

BMAD Core dispone de un catálogo consultable por categorías y técnicas. La referencia oficial V6.12 describe 108 técnicas en 13 categorías en el selector original observado en el entorno. La existencia del catálogo no significa que el operador deba leerlo completo ni seleccionar entre 108 tarjetas.

El asistente debe elegir pocas técnicas adecuadas al objetivo, explicar brevemente su enfoque y permitir que el operador las cambie. Para una sesión interactiva, la guía V6.12 recomienda normalmente un lote pequeño de tres o cuatro técnicas cuando la selección se hace conversacionalmente. La generación divergente no debe truncarse prematuramente: primero se exploran posibilidades; la convergencia se realiza en una etapa separada.

Los mecanismos de convergencia posibles incluyen agrupación por afinidad, impacto/esfuerzo, NUF, forced ranking, PMI y MoSCoW. Se seleccionan según la clase de decisión que se necesita, no por aplicar siempre una lista fija.

### 5.3 Uso conversacional

La sesión puede iniciarse de forma natural, por ejemplo: «Quiero idear alternativas para X con Carson». El asistente identifica el objetivo y, si el modo no está implícito, hace una sola pregunta para definir la participación. Después propone el lote de técnicas adecuado. No debe desplegar un formulario, una cuadrícula de técnicas ni una lista extensa de opciones.

El Brain Selector puede ser un recurso alternativo de composición y copia de prompt, pero no es el mecanismo principal. Tampoco es un selector de agentes CIS: el HTML oficial elige modo y técnicas de brainstorming.

---

## 6. Brainstorm HTML Keepsake: resultado automático, no trabajo del operador

### 6.1 Qué es

El Keepsake no es un selector, un portal ni una aplicación que el operador deba diseñar. Es un archivo HTML autocontenido llamado brainstorm.html, generado después de finalizar una sesión. BMAD lo define como un artefacto creativo visual cuya composición se adapta al contenido, la energía y las técnicas utilizadas en esa sesión. No parte de una plantilla visual obligatoria.

La especificación indica que cada técnica puede recibir un tratamiento visual propio, que las ideas deben representarse de una manera apropiada a su contenido y que la síntesis debe funcionar como punto culminante del artefacto. El HTML lleva CSS y JavaScript incorporados y no depende de recursos externos. **El agente genera el artefacto; el operador no diseña, maqueta ni compone el HTML.**

### 6.2 Condición de generación según BMAD V6.12

| Modalidad | Comportamiento indicado por BMAD | Adaptación objetivo |
|---|---|---|
| Facilitator | Artefactos optativos; al cerrar, el agente ofrece el Keepsake y lo recomienda como opción predeterminada. | Preguntar una sola vez al cierre. Si se acepta, generarlo desde el registro persistido. |
| Creative Partner | Artefactos optativos; el agente ofrece el Keepsake y pide elección. | Igual que Facilitator. |
| Ideate for me | Keepsake automático. | Generarlo al completar la síntesis, sin exigir diseño ni composición al operador. |

La generación del Keepsake es una operación de síntesis visual de cierta carga, no una exportación trivial. Si el entorno no puede producirlo de manera fiable, debe informar del fallo y conservar la sesión; no debe simular que el HTML existe.

### 6.3 Fuente y estructura del artefacto

Fuente canónica: el registro de sesión completo. El Keepsake no puede inventar ideas ni sustituir las formulaciones del operador. Debe separar claramente:

- ideas originadas por el operador;
- aportaciones del agente;
- técnicas aplicadas y su secuencia;
- agrupaciones, hallazgos y síntesis;
- decisiones y asuntos aún abiertos.

El documento final es independiente de la aplicación que lo generó, puede abrirse localmente y conserva los recursos necesarios dentro del mismo archivo. La presentación debe privilegiar legibilidad y jerarquía; no se requiere repetir la interfaz recargada del portal anterior.

### 6.4 Restricción de integración descubierta

La especificación upstream V6.12 prescribe delegar la generación a un subagente y hacer que este lea el memlog como fuente única. En el entorno de ChatGPT/RDC aún no se ha verificado un mecanismo de subagentes compatible que cumpla esa prescripción. No se debe fingir que existe.

**Propuesta de adaptación para revisar:** generar el Keepsake desde el propio asistente con el registro persistido como única fuente de datos, aplicando una validación de integridad de contenido y HTML antes de presentarlo. La alternativa de usar otro runtime no se incorpora por defecto, y OpenCode/Superpowers no son dependencias del diseño.

---

## 7. Persistencia de sesiones y autoguardado tipo Office

### 7.1 Objetivo de experiencia

El operador no debe preocuparse por guardar manualmente cada avance. Cada intercambio relevante debe quedar conservado automáticamente, con historial recuperable, y una interrupción no debe convertir en pérdida todo lo ocurrido desde el último guardado.

El sistema tiene que diferenciar:
- una sesión en curso o interrumpida;
- un proyecto con nombre que reúne sesiones y resultados relacionados;
- un elemento de biblioteca reutilizable que puede ser citado o incorporado a otros proyectos.

No se debe confundir la persistencia de Product Design con la arquitectura completa de IAR de Khora.

### 7.2 Modelo lógico propuesto

| Entidad | Propósito | Datos mínimos |
|---|---|---|
| Project | Agrupa trabajo de producto relacionado. | id local, nombre, descripción breve, fechas, estado y referencias a sesiones. |
| Session | Unidad de trabajo conversacional recuperable. | id local, tema, objetivo, proyecto opcional, agente CIS, modo BMAD, técnicas, estado, fechas y versión vigente. |
| Turn | Conserva cada intercambio completo. | secuencia, A literal del operador, B visible del asistente, fecha, hash de cada lado y referencias de evidencia. |
| SessionEvent | Conserva hechos internos de la lluvia de ideas. | secuencia, tipo, texto, autoría y referencias al turno de origen. |
| Snapshot | Versión recuperable de un estado de sesión. | versión, fecha, hash, versión padre y referencias al contenido preservado. |
| Artifact | Resultado derivado de una sesión. | tipo, ruta, versión, hash, estado y fuentes. |
| LibraryItem | Unidad reusable indexada. | id local, tipo, título, resumen, contenido, etiquetas y procedencia. |
| LibraryLink | Relación entre un elemento reusable y uno o más proyectos. | id de elemento, id de proyecto, tipo de relación y fecha. |

Todos los identificadores de persistencia son locales al sistema. No se presentan como identificadores nativos de ChatGPT ni como folios FOL1. La asignación concreta de UUIDv7 local se verificará durante implementación.

### 7.3 Distribución física candidata

La estructura es una propuesta sujeta a la revisión de integridad y a las rutas autorizadas del OCP EP; todavía no se crean carpetas:

    MOD-EP-PRODUCT-DESIGN/
    ├── SPRINT-GENERAL-PRODUCT-DESIGN.md
    ├── sesiones/
    │   └── <session-id>/
    │       ├── session.json
    │       ├── turns/
    │       │   ├── 000001.json
    │       │   └── 000002.json
    │       ├── .memlog.md
    │       ├── snapshots/
    │       │   ├── v000001/
    │       │   └── v000002/
    │       └── artifacts/
    │           └── brainstorm.html
    ├── proyectos/
    │   └── <project-id>/
    │       └── project.json
    └── biblioteca/
        ├── catalog.sqlite
        └── items/
            └── <item-id>/
                ├── item.json
                └── versions/
                    └── v000001/
                        └── content.md

Las carpetas y nombres son un esquema de diseño, no rutas ya implementadas. La materialización definitiva respetará el OCP EP, la privacidad y el confinamiento del entorno.

### 7.4 Contrato de autoguardado propuesto

1. Al iniciar una sesión, crear su manifiesto y una primera versión de estado.
2. Al completar cada intercambio, guardar A y B de forma íntegra y cronológica. La captura de A no debe normalizar ni corregir el texto original; cualquier lectura corregida se conserva separada.
3. Registrar en el memlog las ideas, preguntas, insights, decisiones, direcciones y técnicas relevantes, conservando autoría en Creative Partner.
4. Cada escritura se hace mediante archivo temporal, flush/fsync y reemplazo atómico o transacción equivalente.
5. Después de guardar, comprobar tamaño/hash/read-back antes de marcar el intercambio como persistido.
6. Actualizar el manifiesto/versionado sin destruir snapshots anteriores.
7. Si falla el guardado, informar el fallo concreto, conservar el estado visible en la conversación y marcar el tramo como pendiente de persistir; nunca declarar autoguardado exitoso.
8. Al reanudar, leer el manifiesto, validar la última versión y reconstruir el estado desde los turnos/eventos conservados.
9. Al cerrar, registrar el evento de cierre y congelar el estado de sesión, sin eliminar la posibilidad de lectura ni de exportación.

Los turnos son registros inmutables. El manifiesto puede cambiar mediante escritura atómica y mantener un historial de versiones. El índice de biblioteca es derivado y reconstruible; nunca debe ser la única copia de los contenidos canónicos.

### 7.5 Versiones y recuperación

La experiencia tipo Office debe proporcionar:

- guardado automático tras cada intercambio finalizado;
- versiones históricas identificables y ordenadas;
- recuperación de una versión anterior sin borrar la versión actual;
- recuperación de sesiones activas o incompletas;
- indicación explícita de cuándo se produjo el último guardado verificado;
- lectura de vuelta y comprobación SHA-256 de los artefactos persistidos;
- restauración mediante una nueva versión, no sobrescritura irreversible.

No se fija todavía un intervalo periódico arbitrario. La granularidad primaria es el intercambio completo y los puntos de control que representen cambios materiales.

### 7.6 Compatibilidad BMAD memlog: conflicto a resolver

La fuente oficial V6.12 contiene una inconsistencia interna: memlog.py se describe como append-only y declara que no existe un estado de ciclo de vida complete; sin embargo, SKILL.md consulta status para reanudar y references/finalize.md ordena usar memlog.py set --key status --value complete.

No se trasladará esa contradicción a la implementación sin resolverla. **Propuesta:** mantener el memlog como cronología append-only y gestionar el estado de sesión (active, paused, completed) en session.json o en el manifiesto de sesión. El cierre se agrega también como evento cronológico. Así no se reescribe la memoria semántica ni se pierde el estado operativo de la sesión.

---

## 8. Biblioteca indexada y reutilizable

### 8.1 Objetivo funcional mínimo

La biblioteca debe permitir localizar y reutilizar resultados previos sin tener que recordar en qué conversación o archivo se produjeron. Debe indexar, como mínimo, sesiones concluidas, Keepsakes, síntesis, descubrimientos, decisiones, briefs y otros artefactos que efectivamente se generen.

La biblioteca no sustituye los originales. Guarda referencias a la fuente y conserva versiones de los contenidos que se conviertan en elementos reutilizables.

### 8.2 Modelo lógico

| Campo | Función |
|---|---|
| item_id | Identidad local estable. |
| title | Nombre legible. |
| item_type | Sesión, idea, insight, decisión, brief, Keepsake u otro artefacto. |
| summary | Síntesis breve para resultados de búsqueda. |
| content_ref | Ruta del contenido conservado. |
| tags | Etiquetas temáticas y funcionales sugeridas. |
| project_refs | Proyectos asociados. |
| source_session | Sesión de origen. |
| source_turn_refs | Turnos A/B que sustentan el contenido. |
| source_artifact_ref | Artefacto del que deriva, si aplica. |
| version y sha256 | Integridad e historial. |
| created_at / updated_at | Trazabilidad temporal. |
| status | Estado de uso: candidato, reutilizable o sustituido. |

### 8.3 Indexación mínima propuesta

Se propone un índice local SQLite con búsqueda de texto completo (FTS5) si la compilación local disponible lo soporta. El índice debe poder reconstruirse desde los archivos de origen. Si FTS5 no está disponible, se elegirá un mecanismo alternativo sencillo después de probarlo en el entorno real.

La primera versión no necesita vectores, embeddings, GraphRAG, base de datos servidor ni otra interfaz web. La búsqueda básica debe cubrir texto, título, resumen, etiquetas, tipo y proyecto. El asistente puede ejecutar la consulta y mostrar resultados en el propio chat.

### 8.4 Reutilización entre proyectos

Un elemento de biblioteca puede referenciarse desde más de un proyecto. **Propuesta para revisión:** mantener una única copia canónica del elemento y crear relaciones de referencia hacia cada proyecto, en lugar de duplicar el contenido. La procedencia original permanece inmutable; adaptar un contenido para otro proyecto genera una versión o un derivado con vínculo explícito a su fuente.

### 8.5 Ingesta y mantenimiento

- Las sesiones y artefactos terminados se incorporan automáticamente al índice básico.
- Los elementos con valor potencial de reutilización reciben título, resumen y etiquetas sugeridas por el agente.
- La búsqueda no convierte por sí sola un elemento en requisito vigente ni en decisión ratificada.
- Los elementos sustituidos siguen localizables con su estado histórico.
- Cada resultado muestra de qué sesión, turnos y artefacto proviene.
- Si el índice se corrompe o queda desactualizado, se reconstruye desde las fuentes; no se pierde el contenido canónico.

---

## 9. Proceso de Product Design y ruta de trabajo

El catálogo funcional contempla las siguientes capacidades, sin imponer una secuencia rígida:

1. Brainstorming / ideación divergente y convergente.
2. Product Discovery / comprensión del problema y contexto.
3. Product Brief / definición inicial del producto.
4. Requirements / PRD / requisitos, historias y criterios de aceptación.
5. UX & Interface Design / arquitectura de información, flujos, estados y especificaciones.
6. Prototyping / artefactos conceptuales, visuales, navegables o funcionales con su fidelidad identificada.
7. Evaluation & Validation / contraste con requisitos, evaluación y pruebas.
8. Planning & Execution / transferencia a implementación y seguimiento de resultados.

La elección de capacidad deriva de la necesidad real. No todo problema empieza con brainstorming ni todo producto debe recorrer todas las capacidades en un orden lineal.

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

**Compatibilidad pendiente:** CIS recomendó en la documentación previamente inspeccionada una versión posterior del core brainstorming que la instalación BMAD local. No se actualizará BMAD automáticamente. La alineación de versiones y el conjunto CIS deben probarse por separado antes de aceptar el runtime.

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

## 13. Integridad de diseño extremo a extremo: propuesta de compuertas

Antes de ejecutar cualquier implementación, el operador revisará el diseño completo. La revisión debe poder seguir el recorrido de la información desde la instrucción original hasta su recuperación y reutilización:

    Instrucción / dictado del operador
             ↓
    ChatGPT: interpretación y agente CIS seleccionado
             ↓
    BMAD: modo, técnicas y actividad de diseño
             ↓
    Registro de sesión: A/B + eventos/memlog + procedencia
             ↓
    Autoguardado y snapshots verificables
             ↓
    Síntesis y decisiones
             ↓
    Keepsake HTML / otros artefactos acordados
             ↓
    Biblioteca indexada y referencias a proyectos
             ↓
    Búsqueda, recuperación, reutilización y nueva versión

### Criterios de revisión

| Compuerta | Pregunta de integridad | Evidencia que habrá que exigir |
|---|---|---|
| G1 · Entrada | ¿La instrucción original se conserva sin alteraciones y se separa de la interpretación? | A literal, metadatos de origen y hash. |
| G2 · Selección | ¿La selección de agente, modo y técnicas es coherente y comprensible, sin sobrecargar al operador? | Agente/modo/técnicas de cada sesión y explicación breve. |
| G3 · Ejecución | ¿Se respeta el modo de facilitación y la secuencia divergencia→convergencia? | Registro cronológico de técnicas, ideas y autoría. |
| G4 · Persistencia | ¿Cada intercambio queda guardado y recuperable? | Turnos A/B, hash y read-back. |
| G5 · Versiones | ¿Puede recuperarse cualquier versión relevante sin sobrescribir la actual? | Snapshots inmutables y prueba de restauración. |
| G6 · Reanudación | ¿Una sesión interrumpida se puede continuar desde el último estado válido? | Prueba de reanudación con integridad de eventos. |
| G7 · Keepsake | ¿El HTML se genera automáticamente sin trabajo de diseño del operador y refleja fielmente la sesión? | Archivo autónomo, validación HTML, fuentes y contraste contra el registro. |
| G8 · Biblioteca | ¿Los resultados se pueden buscar y reutilizar sin perder procedencia? | Índice reconstruible, consultas, referencias cruzadas y hashes. |
| G9 · Proyecto | ¿Se distingue sesión, proyecto y elemento reusable? | Esquemas, enlaces y pruebas de asociación. |
| G10 · Seguridad | ¿Los datos permanecen en las rutas y perfiles autorizados? | Preflight, identidad, rutas, permisos y controles EP. |
| G11 · Interfaz | ¿El flujo puede completarse desde el chat, sin portal o perfil de navegador adicional? | Prueba de usuario de punta a punta en la sesión principal. |
| G12 · Aceptación | ¿El diseño se ha probado en un flujo completo antes de declararlo implementado? | Protocolo de pruebas, resultados, fallos y aceptación expresa. |

Ninguna compuerta queda aceptada por la mera existencia de un archivo, una maqueta o una descripción. La prueba debe demostrar el comportamiento real.

---

## 14. Preparación de tareas provisionales — fase posterior

No se crean tareas en este documento. Cuando se termine el vaciado del diseño y el operador revise su integridad:

1. Inspeccionar el OCP del frente Harmonia en SeryMente/khora/docs/frentes/harmonia/.
2. Revisar su índice de tareas, núcleos/README y la relación entre cada instrucción fuente verbatim y sus tareas derivadas.
3. Identificar su estructura real, campos, jerarquía, granularidad, matriz de trazabilidad, criterios de aceptación, dependencias y crónicas.
4. Replicar ese arreglo en Product Design con el mismo rigor, no una versión aproximada ni una reinterpretación simplificada.
5. Asociar cada tarea a las instrucciones originales que la sustentan: dictado verbatim → requisito → tarea → entregable → criterio de aceptación → evidencia.
6. Separar los requisitos confirmados de las propuestas y preguntas técnicas abiertas.
7. Crear el mínimo conjunto de tareas que permita ejecutar y aceptar los resultados independientemente, sin fraccionamiento artificial ni omisiones.

La inspección de Harmonia está pendiente y se hará en esa fase, una vez concluido el documento de vaciado. La existencia del presente borrador no autoriza empezar a crear tareas.

---

## 15. Riesgos, decisiones técnicas todavía abiertas y verificaciones

| Ref. | Tema | Estado | Resolución prevista antes de implementación |
|---|---|---|---|
| R-01 | Capacidad real de ChatGPT para escribir en el host local al finalizar cada turno. | PENDIENTE | Prueba con RDC autorizado, identidad correcta, escritura/read-back y fallo controlado. |
| R-02 | Selección correcta de sesión RDC cuando hay conexiones múltiples. | PENDIENTE | Descubrimiento en vivo y preflight de identidad; no inferir por hostname. |
| R-03 | Integración de CIS y versiones compatibles con BMAD Core 6.12.4. | PENDIENTE | Revisar manifests oficiales y ejecutar pruebas por cada agente. |
| R-04 | Generación del Keepsake bajo ChatGPT sin subagentes. | PROPUESTA | Prototipo controlado desde la fuente persistida y prueba de fidelidad. |
| R-05 | Conflicto de lifecycle del memlog V6.12. | CONFIRMADO EN FUENTE UPSTREAM | Separar estado en manifiesto y mantener memlog append-only. |
| R-06 | Disponibilidad de SQLite FTS5 en el entorno local. | PENDIENTE | Prueba de capacidad; índice reconstruible con alternativa si falla. |
| R-07 | Ubicación y confinamiento de datos Product Design conforme al OEP vigente. | PENDIENTE | Revisar OEP, perfil EP y rutas permitidas antes de materializar. |
| R-08 | Reanudación cuando el archivo de turno exista pero el manifiesto no se haya actualizado. | PENDIENTE DE DISEÑO DETALLADO | Protocolo de reconciliación desde registros inmutables. |
| R-09 | Retención y restauración de versiones de artefactos de biblioteca. | PENDIENTE DE DISEÑO DETALLADO | Política de versionado, referencias, sustitución y exportación. |
| R-10 | Presentación del Keepsake en el Chrome principal sin cambiar de perfil. | PENDIENTE | Prueba solo cuando sea necesaria y con la sesión principal ya abierta. |
| R-11 | Contradicción entre el diseño actual y OEP §§142.19–142.20. | DETECTADA | Reconciliar el registro del OEP y la documentación heredada después de la revisión del operador, conservando los antecedentes. |
| R-12 | Alcance de los agentes CIS y de Creative Squad/Design Pair. | PARCIALMENTE DOCUMENTADO | Verificar configuración oficial completa y runtime instalado antes de aceptar. |

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

Este documento distingue la documentación upstream, los artefactos locales registrados en ciclos anteriores y el estado técnico que aún no se ha vuelto a probar. No declara que la integración CIS, el autoguardado, la biblioteca o el generador de Keepsake estén implementados. La existencia de un recurso upstream no acredita que esté instalado ni que funcione en el entorno EP actual.

---

## 17. Estado del documento y siguiente paso

**Estado actual:** diseño integrado en borrador para revisión. La arquitectura propuesta es ChatGPT-first; Brain Selector es opcional/no requerido; Keepsake es un artefacto generado por el agente; autoguardado/versionado y biblioteca tienen esquema inicial; Cognición visoespacial y proyección visual está diferida.

**No ejecutado:** instalación/actualización de software, modificación del portal, uso de Chrome, creación de estructura de datos, autoguardado, biblioteca, generación local de Keepsake, modificación de OEP, cierre o alteración de EP-TASK-008 y creación de tareas provisionales.

**Siguiente acción documental:** cotejar este borrador contra todo el acumulado fuente y corregir las discrepancias que aún falten; después, preparar la revisión integral de diseño. Tras esa revisión, inspeccionar Harmonia y construir las tareas provisionales con la matriz verbatim que allí se utiliza.

**Criterio de avance:** no pasar a ejecución hasta que el diseño extremo a extremo haya sido revisado y aceptado por el operador.


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
