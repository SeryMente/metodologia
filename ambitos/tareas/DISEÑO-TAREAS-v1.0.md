# Tareas v1.0 · Diseño conceptual y operativo inicial

**Estado:** borrador inaugural en incubación; no es norma canónica.  
**Evento:** C-TAREAS-INICIO-01 · **Ciclo:** C-20261028-TA6F31C9 · **Fecha:** 2026-10-28.  
**Base normativa observada al inaugurar el ámbito:** DUG v358 · NX-358m; Metacanon 1.23; GOW 2.7; taxonomía estructural 1.2. **Revisión canónica posterior:** DUG v359 · NX-359m; Metacanon 1.24; GOW 2.8; taxonomía 1.3, blob `b2ff2845a5a99dc4ce3cafafc4f8e43607d48145`.  
**Último recorte de diseño:** C-TAREAS-ESTANDAR-MINIMO-02 · C-20261029-4F7A2C91; estándar común vigente como candidato v0.2 mínimo.

> **Regla de estado:** esta es una primera versión de diseño para iniciar la construcción progresiva. Sus definiciones son propuestas de trabajo. No modifica el DUG ni el GOW, y no debe usarse para afirmar que Tareas ya integra la taxonomía normativa vigente.

## 1. Propósito candidato

Proponer una capacidad transversal mínima para **identificar tareas originadas por instrucciones o decisiones explícitas, conservar la referencia a su fuente y registrar su estado**. El alcance concreto del ámbito sigue siendo candidato y debe limitarse a lo que el operador ratifique.

La hipótesis de valor —todavía por validar— es evitar que una tarea explícita se pierda o se confunda con la conversación, documento o frente que la originó. No se añaden de partida priorización, asignación, recordatorios, dependencias ni automatización. Antes de adoptar Tareas como ámbito estable, debe demostrarse que esa capacidad no queda cubierta de forma más simple por los mecanismos existentes; si no añade una necesidad real, no se debe conservar ni canonizar por defecto.

## 2. Identidad taxonómica propuesta

- **Nombre canónico candidato:** Tareas.
- **Clase:** ámbito funcional transversal, propuesto en el nivel funcional actual, como par de Persistencia documental y Gestión conversacional.
- **Estado normativo real:** no incorporado al DUG vigente v359; Tareas sigue en incubación. La taxonomía conserva dos ámbitos funcionales transversales canónicos y separa de ellos el elemento conceptual canónico Propósito.
- **Relación con frentes/repositorios:** puede cruzarlos; no se clasifica automáticamente como hijo de un FT ni como un proyecto independiente.
- **OCP:** conforme a la regla general vigente, cada entidad taxonómica es el objeto canónico de persistencia de su nivel. La forma y ubicación físicas se deciden por separado.
- **Materialización operativa de incubación:** ambitos/tareas/, elegida expresamente para mantener el diseño, la responsabilidad, las decisiones y las pruebas de varios ciclos. Es una decisión operativa provisional, no un cambio de ART-019/ART-020 ni una convención normativa general de rutas.

## 3. Alcance mínimo candidato

1. Identificar una tarea solo cuando exista una acción o compromiso reconocible en una instrucción o decisión explícita.
2. Registrar un enunciado fiel y una referencia recuperable a su fuente original.
3. Distinguir la tarea de la conversación, documento o frente que le da contexto.
4. Registrar uno de cuatro estados sencillos: pendiente, en curso, completada o cancelada.
5. Añadir una referencia de ámbito solo cuando el OCP, el origen o el contexto no lo hagan inequívoco.

No se presupone prioridad, asignación, fecha límite, siguiente acción, grafo de dependencias, recordatorios, automatización ni integración externa.

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

El [Estándar común de tarea v0.2](ESTANDAR-COMUN-DE-TAREA-v0.2.md) y el [esquema JSON v0.2](ESQUEMA-TAREA-COMUN-v0.2.json) sustituyen como propuesta vigente al primer borrador v0.1. El núcleo contiene solo:

| Campo | Regla |
|---|---|
| `task_id` | Identidad estable, necesaria al persistir la tarea; el mecanismo generador queda pendiente. |
| `statement` | Enunciado fiel y breve de la tarea, sin requisitos añadidos por inferencia. |
| `origin_ref` | Referencia recuperable al original que la origina. |
| `status` | `pendiente`, `en_curso`, `completada` o `cancelada`. |
| `scope_ref` | Condicional: solo si el contexto de origen no delimita el ámbito con claridad. |

No son campos del núcleo: título separado, resultado esperado separado, criterios de aceptación separados, siguiente acción, responsable, prioridad, fecha límite, relaciones, bloqueos, evidencia por campo ni marcas temporales. No se eliminan del método para todos los casos: se dejan fuera del estándar común hasta que una necesidad real o una instrucción expresa justifique alguno.

## 6. Ciclo de vida mínimo candidato

- **PENDIENTE:** tarea identificada que no consta en curso ni completada.
- **EN CURSO:** existe evidencia de que el trabajo comenzó.
- **COMPLETADA:** la solicitud expresada fue atendida según la fuente y la verificación que correspondan.
- **CANCELADA:** existe una decisión identificable de no continuar.

“Bloqueada”, “aplazada”, “por definir” y “en revisión” no se incorporan al conjunto común inicial. Si algún caso real necesita una distinción adicional, se documentará como propuesta específica y no se ampliará el estándar por anticipación.


## 7. Articulación operativa provisional

La cadena propuesta separa las funciones y la autoridad:

1. **Políticas de plataforma, permisos reales y autorización expresa.** No los reemplaza ninguna instrucción local.
2. **DUG — fuente normativa única.** Define precedencia, taxonomía, límites de persistencia y método. La inclusión de Tareas requerirá una propuesta normativa separada y autorización expresa del operador antes de editar.
3. **GOW — Glosario Operativo del Workspace.** Cuando se autorice el cambio, contendrá una definición breve de Tareas, sin duplicar todo el procedimiento ni declararlo vigente antes de escribirlo y verificarlo.
4. **IPZ — Instrucciones Personalizadas de ChatGPT.** Deben funcionar solo como punto de entrada breve hacia el DUG y el OCP. La existencia de un archivo candidato no equivale a escritura en el campo nativo; esa operación sigue pendiente de capacidad y lectura de vuelta.
5. **Instrucciones específicas del ámbito.** Este diseño establece el contrato operacional provisional. Tras su validación habrá que separarlo de las reglas largas y generar una versión estable dirigida al agente que trabaje dentro de Tareas.
6. **Registro y adaptadores por plataforma.** Elegir en ciclos posteriores la fuente de estado por clase de tarea. Evitar doble escritura silenciosa; si una plataforma existente es autoridad para una tarea, el índice Tareas podrá enlazarla en vez de competir con ella.
7. **Procedencia y estado.** Cada cambio de estado debe mantenerse coherente con la fuente disponible y la regla que autorice la operación. Los registros de auditoría/evidencia se conservan donde la metodología los exija, no como campos adicionales obligatorios de toda tarea.

### Texto candidato para IPZ (no instalado)

> Para tareas de Ser y Mente/Metodología, consulta la fuente canónica y el diseño vigente de Tareas en SeryMente/metodologia, ruta provisional ambitos/tareas/. Conserva un enunciado fiel, referencia al origen y estado observado; añade referencia de ámbito solo si no está clara por el contexto. No inventes requisitos ni amplíes la instrucción original. El repositorio canónico prevalece sobre copias. Este texto es candidato y no demuestra que el campo nativo de Instrucciones Personalizadas se haya actualizado.

## 8. Decisiones pendientes para alcanzar una v1.0 aceptada

1. Confirmar propósito, beneficiarios y límites del ámbito.
2. Ratificar su ubicación taxonómica y su relación horizontal con los dos ámbitos funcionales vigentes.
3. Validar el modelo mínimo de cuatro campos y la referencia de ámbito condicional; no añadir relaciones, prioridad, fechas o seguimiento adicional sin justificación.
4. Validar si basta el ciclo de cuatro estados; cualquier campo/estado adicional debe demostrar necesidad en un caso real.
5. Decidir el registro canónico y qué plataformas, si alguna, serán fuentes de estado para determinados tipos de tarea.
6. Aprobar las instrucciones específicas del ámbito y el texto de IPZ; verificar el campo nativo cuando la herramienta lo permita.
7. Comprobar con casos autorizados si el núcleo mínimo representa fielmente el trabajo. No fijar por anticipado un número de casos ni una cobertura hipotética; añadirlos según las diferencias observadas.
8. Preparar una propuesta concreta de cambios en ART-015, ART-020, la taxonomía estructurada y el GOW, sin escribir norma hasta recibir autorización explícita.
9. Ratificar o revisar la versión tras la comprobación; no convertir los criterios de aceptación del propio estándar en campos obligatorios de cada tarea.

## 9. Criterio de cierre de la incubación

La v1.0 se considerará **aceptada** solo cuando exista: definición de propósito y alcance; límites; lugar en la taxonomía; esquema y estados demostrados con casos; reglas de autoridad/persistencia; instrucciones del ámbito; texto IPZ verificado o limitación explícita; propuesta normativa revisada; y aprobación expresa del operador seguida por escritura y lectura de vuelta de cualquier enmienda autorizada.

Hasta ese cierre, el estado correcto es **Tareas v1.0 · diseño inicial en incubación**; el DUG vigente es v359 · NX-359m. Propósito es canónico como elemento conceptual, pero Tareas no se ha incorporado a la taxonomía normativa.