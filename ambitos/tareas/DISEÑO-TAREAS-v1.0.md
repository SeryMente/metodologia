# Tareas v1.0 · Diseño conceptual y operativo inicial

**Estado:** borrador inaugural en incubación; no es norma canónica.  
**Evento:** C-TAREAS-INICIO-01 · **Ciclo:** C-20261028-TA6F31C9 · **Fecha:** 2026-10-28.  
**Base normativa contrastada:** DUG v358 · NX-358m; Metacanon 1.23; GOW 2.7; taxonomía estructural 1.2. Fuente: gobernanza/METAPROMPT-CANONICO-SAMANTHA.html, blob 89a28e4d05f5baab9c4b86abdb9fbfc532690c75.

> **Regla de estado:** esta es una primera versión de diseño para iniciar la construcción progresiva. Sus definiciones son propuestas de trabajo. No modifica el DUG ni el GOW, y no debe usarse para afirmar que Tareas ya integra la taxonomía normativa vigente.

## 1. Propósito candidato

Proveer una capacidad transversal para **identificar, formular, relacionar, priorizar, asignar, ejecutar con seguimiento, verificar y cerrar tareas** dentro del entorno de trabajo Ser y Mente/Metodología, conservando la trazabilidad entre la petición que las origina, el resultado esperado, el estado observado, el siguiente paso y la evidencia de aceptación.

La hipótesis de valor es reducir pérdida de compromisos entre conversaciones y frentes, ambigüedad sobre qué acción sigue, duplicados y cierres declarados sin evidencia. El diseño todavía debe probar que este alcance es coherente, suficientemente acotado y distinto de los ámbitos funcionales existentes.

## 2. Identidad taxonómica propuesta

- **Nombre canónico candidato:** Tareas.
- **Clase:** ámbito funcional transversal, propuesto en el nivel funcional actual, como par de Persistencia documental y Gestión conversacional.
- **Estado normativo real:** no incorporado aún al DUG v358; la taxonomía normativa vigente sigue enumerando solo los otros dos ámbitos.
- **Relación con frentes/repositorios:** puede cruzarlos; no se clasifica automáticamente como hijo de un FT ni como un proyecto independiente.
- **OCP:** conforme a la regla general vigente, cada entidad taxonómica es el objeto canónico de persistencia de su nivel. La forma y ubicación físicas se deciden por separado.
- **Materialización operativa de incubación:** ambitos/tareas/, elegida expresamente para mantener el diseño, la responsabilidad, las decisiones y las pruebas de varios ciclos. Es una decisión operativa provisional, no un cambio de ART-019/ART-020 ni una convención normativa general de rutas.

## 3. Alcance incluido candidato

1. Capturar una tarea cuando exista una petición o decisión suficientemente clara, conservando la procedencia.
2. Formularla como una unidad accionable con resultado esperado y criterio observable de aceptación.
3. Asignar identidad estable y distinguir la tarea de su conversación fuente, documentos, proyecto, FT o subtareas.
4. Registrar estado, responsable cuando esté confirmado, prioridad cuando se haya decidido, siguiente acción, bloqueos, dependencias y fechas solo cuando sean explícitas o verificadas.
5. Relacionar tareas con conversaciones, decisiones, frentes, repositorios, documentos, artefactos y tareas dependientes sin duplicar innecesariamente sus fuentes.
6. Dar seguimiento, detectar vencimientos o bloqueos solo con datos verificables, revisar evidencia y registrar cierre, cancelación o aplazamiento.
7. Definir contratos para posibles vistas, interfaces e integraciones por plataforma, sin presumir conectividad, permisos ni sincronización.

## 4. Exclusiones candidatas

- No sustituir la gobernanza, los controles de titularidad ni los núcleos operativos de los frentes responsables de ejecutar el trabajo.
- No reemplazar a **Gestión conversacional** en la identificación y continuidad de conversaciones, ni a **Persistencia documental** en la preservación de originales y derivados.
- No afirmar que la tarea fue ejecutada, que algo está actualizado o que una integración sincronizó datos sin evidencia y lectura de vuelta.
- No inventar responsable, prioridad, fecha límite, dependencia, estimación o aceptación. Lo desconocido se marca como pendiente de aclaración, no se rellena por inferencia.
- No convertir automáticamente cada idea, mención, mensaje o documento en tarea; la captura debe responder a una instrucción, compromiso, decisión o regla aprobada.
- No abrir automáticamente issues, eventos, recordatorios ni tareas en servicios externos.
- No prometer sincronización omnicanal ni cobertura total del universo de tareas.
- No modificar el campo nativo de Instrucciones Personalizadas de ChatGPT sin que la capacidad esté disponible y la escritura pueda verificarse.

## 5. Modelo mínimo de una tarea (candidato)

| Campo | Función candidata | Regla de integridad |
|---|---|---|
| task_id | Identidad estable | No reutilizar; política de generación pendiente de ratificación. |
| title | Acción resumida | Verbo/resultado concreto; evitar título que sea solo un tema. |
| expected_outcome | Resultado esperado | Debe describir una condición observable. |
| status | Estado del ciclo de vida | Solo transiciones definidas; el estado debe reflejar evidencia disponible. |
| origin | Petición/decisión que la origina | Referencia y fecha solo cuando sean observables. |
| scope_ref | Ámbito, FT o contexto responsable | No inventar el responsable ni confundirlo con el ámbito Tareas. |
| owner | Responsable confirmado | Puede ser desconocido o pendiente; no inferir una asignación. |
| priority | Orden relativo de atención | Regla de priorización por definir; no asignar por defecto una prioridad artificial. |
| next_action | Siguiente paso ejecutable | Una tarea activa sin siguiente paso válido debe detectarse como problema de seguimiento. |
| due_date | Fecha límite | Solo si fue fijada o confirmada; conservar procedencia. |
| dependencies / blockers | Relaciones y bloqueos | Referencias explícitas, estado verificable y motivo. |
| acceptance | Criterio de terminación | Debe permitir revisar si el resultado está completo. |
| evidence_refs | Evidencias de ejecución/aceptación | Enlaces o rutas recuperables; no sustituir el original. |
| updated_at / verified_at | Vigencia del registro | Registrar solo fechas de operaciones efectivamente observadas. |

Este esquema es una hipótesis de trabajo; no existe aún un registro canónico vacío ni una integración implementada. La primera tarea real servirá para comprobar el mínimo necesario y podar los campos que no aporten valor.

## 6. Ciclo de vida candidato

Flujo inicial para contrastar: **CAPTURADA → POR DEFINIR → DEFINIDA → LISTA → EN CURSO → EN REVISIÓN → COMPLETADA**. Estados laterales posibles: **BLOQUEADA**, **APLAZADA** y **CANCELADA**.

- **CAPTURADA:** hay una petición/decisión de origen, pero todavía puede faltar estructura.
- **POR DEFINIR:** requiere aclarar resultado, alcance o condición de aceptación.
- **DEFINIDA:** acción y aceptación son suficientemente claras; aún puede requerir priorización o dependencia.
- **LISTA:** reúne las condiciones acordadas para comenzar.
- **EN CURSO:** la ejecución está realmente en marcha; no basta con haber hablado de ella.
- **BLOQUEADA:** existe un impedimento concreto registrado y un siguiente paso para resolverlo, si se conoce.
- **EN REVISIÓN:** el resultado candidato está disponible y se coteja contra la aceptación.
- **COMPLETADA:** la condición de aceptación está demostrada por evidencia accesible o verificación explícita válida.
- **APLAZADA/CANCELADA:** la decisión y su procedencia quedan registradas; no se confunden con una tarea terminada.

Las transiciones permitidas, excepciones, recurrencias y reaperturas son pendientes de ciclo. Este mapa no se debe convertir aún en una máquina de estados de producción.

## 7. Articulación operativa provisional

La cadena propuesta separa las funciones y la autoridad:

1. **Políticas de plataforma, permisos reales y autorización expresa.** No los reemplaza ninguna instrucción local.
2. **DUG — fuente normativa única.** Define precedencia, taxonomía, límites de persistencia y método. La inclusión de Tareas requerirá una propuesta normativa separada y autorización expresa del operador antes de editar.
3. **GOW — Glosario Operativo del Workspace.** Cuando se autorice el cambio, contendrá una definición breve de Tareas, sin duplicar todo el procedimiento ni declararlo vigente antes de escribirlo y verificarlo.
4. **IPZ — Instrucciones Personalizadas de ChatGPT.** Deben funcionar solo como punto de entrada breve hacia el DUG y el OCP. La existencia de un archivo candidato no equivale a escritura en el campo nativo; esa operación sigue pendiente de capacidad y lectura de vuelta.
5. **Instrucciones específicas del ámbito.** Este diseño establece el contrato operacional provisional. Tras su validación habrá que separarlo de las reglas largas y generar una versión estable dirigida al agente que trabaje dentro de Tareas.
6. **Registro y adaptadores por plataforma.** Elegir en ciclos posteriores la fuente de estado por clase de tarea. Evitar doble escritura silenciosa; si una plataforma existente es autoridad para una tarea, el índice Tareas podrá enlazarla en vez de competir con ella.
7. **Evidencia y recuperación.** Cada cambio de estado relevante debe permitir responder qué cambió, por qué, con qué fuente, quién lo autorizó, cuál es el siguiente paso y cómo se comprobó.

### Texto candidato para IPZ (no instalado)

> Para gestionar tareas de Ser y Mente/Metodología, consulta la fuente canónica y el diseño vigente del ámbito Tareas en el repositorio SeryMente/metodologia (ruta provisional ambitos/tareas/). Distingue tareas de conversaciones, documentos y frentes de trabajo. No inventes estado, responsable, prioridad, fechas, ejecución ni sincronización. Conserva origen, resultado esperado, siguiente acción y evidencia verificable; respeta los límites y permisos de cada fuente. El repositorio canónico prevalece sobre copias o espejos. Este texto es candidato para revisión y no demuestra que el campo nativo de Instrucciones Personalizadas haya sido actualizado.

## 8. Decisiones pendientes para alcanzar una v1.0 aceptada

1. Confirmar propósito, beneficiarios y límites del ámbito.
2. Ratificar su ubicación taxonómica y su relación horizontal con los dos ámbitos funcionales vigentes.
3. Validar el modelo mínimo de tarea e identidad estable, deduplicación, relaciones y procedencia.
4. Validar el ciclo de vida y los criterios de prioridad, fechas, bloqueos, reapertura y cierre.
5. Decidir el registro canónico y qué plataformas, si alguna, serán fuentes de estado para determinados tipos de tarea.
6. Aprobar las instrucciones específicas del ámbito y el texto de IPZ; verificar el campo nativo cuando la herramienta lo permita.
7. Probar con tareas reales autorizadas, cubrir estados problemáticos y verificar lectura de vuelta/recuperación.
8. Preparar una propuesta concreta de cambios en ART-015, ART-020, la taxonomía estructurada y el GOW, sin escribir norma hasta recibir autorización explícita.
9. Confirmar criterios de aceptación y ratificar o revisar formalmente esta versión.

## 9. Criterio de cierre de la incubación

La v1.0 se considerará **aceptada** solo cuando exista: definición de propósito y alcance; límites; lugar en la taxonomía; esquema y estados demostrados con casos; reglas de autoridad/persistencia; instrucciones del ámbito; texto IPZ verificado o limitación explícita; propuesta normativa revisada; y aprobación expresa del operador seguida por escritura y lectura de vuelta de cualquier enmienda autorizada.

Hasta ese cierre, el estado correcto es **Tareas v1.0 · diseño inicial en incubación** y el DUG vigente sigue siendo v358 · NX-358m.