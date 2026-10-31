# Protocolo provisional de coordinación y continuidad del sprint OCP MCP

**Versión del objeto:** v0.1  
**Fecha de creación:** 2026-10-31  
**Estado:** PROVISIONAL · NO CANÓNICO · PERSISTENCIA DE CONTINUIDAD  
**Repositorio:** `SeryMente/metodologia` · rama `main`  
**Ubicación:** `frentes/mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md`  
**Producto objetivo:** MCP de Metodología · identidad documental `MCP-METODOLOGIA`  
**Finalidad:** permitir que una conversación nueva recupere la organización del equipo, el orden de turnos, las decisiones, los límites de iteración, las autorizaciones y el estado de trabajo sin reconstruirlo desde cero.

> Este objeto fue creado por instrucción expresa del operador para conservar la dinámica de este sprint. No es un nuevo OCP, no modifica el DUG, no crea una norma general ni sustituye los núcleos canónicos de EP, Gobernanza o MCP de Metodología. No crea control, titularidad, sesión, permisos ni folios propios. Hereda la responsabilidad documental del OCP donde se aloja y mantiene explícitos los límites de los demás frentes.

---

## 1. Modelo de equipo y coordinación

El sprint se organiza alrededor de **tres frentes funcionales coordinados por un modelo central**:

1. **Gobernanza:** mantiene el alcance, la jerarquía normativa, las autorizaciones y los controles de integridad. Evita que el sprint derive en cambios normativos o revisiones generales innecesarias.
2. **Entorno Persistente (EP):** resuelve el alojamiento y la integración con el entorno Windows: preflight, Known Folders, identidad, localidad, permisos efectivos, bootstrap, configuración portable de Copilot, diagnóstico del entorno y aceptación de la instalación.
3. **MCP de Metodología / OCP MCP:** define y construye el producto: contrato, servidor .NET, herramientas MCP, persistencia SQLite, telemetría, recibos, compilación, publicación, integración con el cliente y pruebas.

**Modelo central:** la conversación que coordina este sprint ocupa la posición de integración entre los tres frentes. Recibe las entregas, conserva su procedencia, coteja contra las decisiones y la evidencia, identifica contradicciones, determina el siguiente turno, prepara instrucciones focalizadas y conduce el trabajo hacia la aceptación del MVP. No debe comportarse como un cuarto frente ni asumir automáticamente la titularidad de los otros OCP.

El operador conserva la autoridad sobre prioridades, decisiones de producto, autorizaciones materiales A y B y aceptación final. Los modelos/frentes auxiliares no se comunican entre sí por inferencia: el modelo central media el intercambio y conserva la secuencia.

## 2. Principios operativos del sprint

- **MVP primero:** el objetivo es construir, integrar y probar el producto funcional mínimo. El contrato y la documentación deben ser suficientes para construirlo con seguridad; no deben convertirse en un fin autónomo.
- **Iteración solo con causa:** repetir una revisión únicamente cuando pueda resolver una contradicción material, un bloqueo técnico, una condición de seguridad/autorización, un riesgo de integridad de datos o una prueba imprescindible de aceptación.
- **No perfeccionismo documental:** las mejoras no esenciales, optimizaciones, abstracciones futuras y cambios cosméticos se registran para después del MVP. No bloquean el producto.
- **No reabrir decisiones cerradas:** toda decisión aceptada se conserva en un registro de decisiones. Solo se reabre ante evidencia nueva que demuestre conflicto, inviabilidad o riesgo material.
- **Trabajo dirigido por entregables:** cada turno solicita un resultado concreto, acotado y verificable; no una nueva evaluación general del proyecto.
- **Una pregunta esencial:** si falta un dato realmente imprescindible, el coordinador formula una sola pregunta concreta. No solicita al operador que repita información ya disponible.
- **Transparencia de estados:** distinguir siempre propuesto, preparado, autorizado, enviado/reenviado, recibido, analizado, ejecutado, verificado y aceptado. No afirmar que un prompt fue reenviado a otro modelo, que un cambio se ejecutó o que una prueba pasó sin evidencia.
- **Ciclos cortos:** cada intervención debe cerrar una decisión, entregar un artefacto, resolver un bloqueo o habilitar el paso siguiente.

## 3. Protocolo de turnos bilaterales y secuencia entre frentes

### 3.1 Regla de espera por respuesta

**No se prepara un nuevo prompt para un frente si todavía no se ha recibido la respuesta al último prompt preparado para ese mismo frente.**

La respuesta debe llegar primero al modelo central. Este la lee, la coteja, actualiza el estado y decide si hace falta una corrección focalizada o si el frente puede cerrarse y ceder el turno.

No se emiten prompts repetidos, paralelos o acumulativos al mismo frente mientras exista una solicitud anterior sin respuesta. Una nueva solicitud solo se prepara después de haber recibido y analizado la respuesta previa.

Los prompts redactados en esta conversación son instrucciones preparadas para que el operador las reenvíe a la sesión correspondiente. **La preparación no prueba el reenvío.** El coordinador registra el reenvío como confirmado únicamente cuando el operador lo indique o exista evidencia verificable.

### 3.2 Orden de turnos

La secuencia es serial y está administrada por el modelo central:

1. El modelo central identifica el frente responsable del siguiente resultado.
2. Prepara una única solicitud concreta y define su criterio de respuesta.
3. El operador la reenvía al frente correspondiente.
4. El frente responde en su sesión.
5. El operador aporta la respuesta al modelo central.
6. El modelo central coteja la respuesta con el contrato, las fuentes vigentes y las decisiones anteriores.
7. El modelo central resuelve, o prepara una sola solicitud correctiva si es estrictamente necesaria.
8. Resuelto el punto, el turno pasa al siguiente frente que dependa de ese resultado.

Se prefiere que exista **un solo turno activo de coordinación cada vez**. Si al reinstanciar ya existen solicitudes independientes pendientes de respuesta en dos frentes, no se añaden otras: se reciben y procesan esas respuestas antes de abrir nuevos turnos.

### 3.3 Estados del intercambio

Cada solicitud por frente debe registrarse con uno de estos estados:

- `NO_SOLICITADO`
- `PROMPT_PREPARADO`
- `REENVÍO_NO_VERIFICADO`
- `REENVÍO_CONFIRMADO`
- `RESPUESTA_PENDIENTE`
- `RESPUESTA_RECIBIDA`
- `EN_ANÁLISIS`
- `CORRECCIÓN_FOCALIZADA_PENDIENTE`
- `CERRADO`
- `BLOQUEADO_P0`

Una respuesta recibida no equivale automáticamente a aceptación. El modelo central documenta qué puntos quedaron aceptados, corregidos, pendientes o bloqueados.

### 3.4 Aplicación del límite de recursividad

El límite de iteración es una **regla de eficiencia, no una prohibición de iterar**.

Se termina la ronda ordinaria cuando el frente ha respondido, los puntos materiales están resueltos y no quedan bloqueos P0. Se permite una corrección focalizada adicional cuando sea necesaria para cerrar un requisito imprescindible. Se permiten iteraciones posteriores si nueva evidencia revela un riesgo material que no podía resolverse antes.

No existe un máximo rígido que obligue a aceptar un producto defectuoso ni a paralizar un diseño técnicamente necesario. Sí existe prohibición de continuar rondas generales que no cambien la decisión, la solución o el cumplimiento de un control esencial.

**Criterio de salida de deliberación:** cuando no queden bloqueos P0, las decisiones esenciales estén suficientemente especificadas y el MVP sea construible, se congela la deliberación general y se pasa a implementación y pruebas. Los asuntos secundarios pasan a una lista posterior al MVP.

## 4. Funciones y límites por participante

### 4.1 Operador

- Define el objetivo y las prioridades del sprint.
- Aporta las respuestas recibidas de los modelos/frentes auxiliares.
- Decide los cambios materiales de alcance.
- Emite por separado la autorización A de transferencia de titularidad y la autorización B de implementación.
- Acepta o rechaza el producto después de revisar la evidencia.
- No necesita arbitrar detalles técnicos ya delegados cuando estén dentro del alcance acordado.

### 4.2 Modelo central

- Es el punto único de integración y memoria operativa del sprint.
- Consulta primero el DUG vigente, los controles aplicables y los núcleos de los frentes.
- Mantiene el registro de decisiones, solicitudes abiertas, respuestas y bloqueos.
- Decide qué frente debe intervenir y evita solicitar trabajo redundante.
- Revisa técnicamente cada entrega sin reiniciar el diseño.
- Concilia las respuestas de EP, Gobernanza y OCP MCP.
- Prepara prompts únicamente cuando corresponde por la regla de espera.
- Mantiene visible el estado real de las autorizaciones y la evidencia.
- Conduce a la construcción del MVP tan pronto como sea viable.

El modelo central no debe afirmar que envió mensajes a sesiones externas ni que ejecutó operaciones en sus entornos cuando solo preparó una instrucción o recibió un informe.

### 4.3 Gobernanza

- Verifica jerarquía, alcance, autorizaciones y coherencia con el DUG.
- Distingue decisiones canónicas de propuestas y materializaciones provisionales.
- Interviene ante contradicciones normativas, permisos, integridad, seguridad o ampliación de alcance.
- Evita reabrir una revisión general ya cerrada.
- No modifica DUG, IPZ, ART-025, ART-027, controles ni el OCP de otro frente sin titularidad y autorización aplicables.
- No convierte la necesidad de gobernanza en una dependencia artificial para comenzar la construcción cuando los controles esenciales ya están satisfechos.

### 4.4 Entorno Persistente (EP)

- Resuelve el alojamiento local y el preflight del host autorizado.
- Valida las Known Folders, identidad/SID, sesión interactiva, localidad, sincronización, reparse points y ACL efectivas.
- Prepara el bootstrap y la configuración portable de Copilot.
- Preserva las entradas MCP existentes y verifica la escritura atómica y su lectura de vuelta.
- Verifica la integración del servidor con el harness y el entorno real.
- Participa en instalación, secuencia terminal y recuperación únicamente después de la autorización correspondiente.

EP no debe convertirse en supervisor residente del proceso MCP. El harness Copilot es propietario del ciclo de vida del proceso `stdio`. EP prepara y comprueba el entorno, configura la integración y realiza diagnósticos; no crea un servicio paralelo ni una tarea programada.

EP no modifica ACL, propietario ni herencia para superar un bloqueo; no eleva privilegios ni introduce exposición de red no autorizada.

### 4.5 OCP MCP

- Cierra el contrato técnico mínimo sin abrir de nuevo decisiones aceptadas.
- Implementa el servidor .NET y la superficie funcional MCP.
- Construye el almacenamiento SQLite, controles de autorización, telemetría y recibos verificables incluidos en el MVP.
- Genera el manifiesto y el artefacto inmutable por versión.
- Compila, ejecuta pruebas y aporta resultados reproducibles.
- Integra el único cliente seleccionado: VS Code Copilot portable mediante `stdio`.
- Corrige defectos materiales encontrados en pruebas sin ampliar el alcance por conveniencia.

OCP MCP no instala ni ejecuta en un host real antes de las autorizaciones A/B aplicables y el preflight de EP.

## 5. Alcance del MVP y decisiones de referencia

El objetivo acordado es una instancia local inicial de OCP MCP que funcione bajo el usuario Windows interactivo autorizado y se conecte al primer cliente Copilot portable mediante MCP `stdio`.

### 5.1 Base técnica

- Windows x64.
- .NET 10 LTS, publicación `win-x64`, autocontenida, configuración `Release`.
- `PublishSingleFile=false`; `PublishAot=false`.
- Versión inicial `0.1.0`, inmutable y con manifiesto verificable.
- Ejecutable de entrada y argumentos tomados del manifiesto, sin inventar nombre ni parámetros.
- Copilot portable como único cliente de aceptación inicial.
- Transporte `stdio`; `stdout` reservado al protocolo MCP y diagnósticos en `stderr` o logs protegidos.
- Sin puertos TCP/HTTP/SSE, exposición LAN/pública, servicios Windows permanentes ni tareas programadas.
- Aplicación bajo `FOLDERID_Desktop\SeryMente\OCP\OCP MCP\app\versions\0.1.0\`.
- Datos bajo `FOLDERID_LocalAppData\SeryMente\OCP MCP\`.
- SQLite con WAL.
- DPAPI CurrentUser para proteger material de clave; AES-256-GCM para el contenido de backups.
- Retención de siete puntos diarios y cuatro semanales, reutilizando un mismo paquete cuando cubra ambos puntos.
- Backup obligatorio antes de actualización/migración.
- Diagnóstico `diagnose --json`, readiness MCP `get_health`, inicialización máxima de 15 segundos y estados `READY`, `DEGRADED`, `NOT_READY` con códigos semánticos 0, 1 y 2.

La versión exacta de SDK/runtime y las huellas se fijan en el manifiesto de cada publicación; no deben quedar congeladas como supuesto permanente cuando se genere un artefacto posterior.

### 5.2 Contenido funcional que debe materializarse

El producto no se considera MVP solo por instalar correctamente el servidor. Debe proporcionar:

- Operaciones MCP agrupadas y utilizables para el ámbito de desarrollo/gobernanza.
- Separación demostrable entre lectura y escrituras protegidas.
- Persistencia SQLite comprobable entre reinicios.
- Telemetría mínima integrada a las operaciones pertinentes.
- Recibo verificable de cada operación que requiera evidencia, con vínculo a la operación, resultado, identidad/versión pertinente e integridad comprobable.
- Un mecanismo de autorización de escritura cuya raíz de confianza y emisor estén definidos; nonce/HMAC sin un emisor confiable no constituye autorización.
- Pruebas funcionales, negativas, de persistencia y de recuperación que demuestren el comportamiento a través del cliente elegido.

La lista exacta de herramientas MCP, sus schemas, el modelo SQLite y el recibo verificable deben quedar concretados en el contrato de implementación de OCP. No se deben inventar ni declarar ya implementados si no existe evidencia.

### 5.3 Fuera del MVP

- Alta disponibilidad, clústeres y despliegues redundantes.
- Servicio Windows permanente, daemon o tareas programadas.
- Varios clientes MCP o adaptadores alternativos.
- Docker/WSL como dependencia de la primera entrega.
- Puertos o exposición de red.
- Sink productivo y activación de `MCP-NORMATIVO`.
- Cambios al DUG/IPZ o despliegue de alias de principios no verificados.
- Integraciones con Khora MCP, sus secretos, infraestructura Vercel o controles.
- Funciones avanzadas que no sean necesarias para demostrar el primer flujo funcional.

Estas exclusiones no impiden reconsiderar una capacidad futura después de aceptar el MVP mediante una decisión separada.

## 6. Autorizaciones, titularidad y controles

Las autorizaciones no se infieren de la existencia del sprint ni de la aceptación del diseño.

### A — transferencia de titularidad

- Es una autorización independiente.
- Debe identificar la transferencia del control OCP MCP al titular receptor y la generación correspondiente.
- Antes de escribir, releer el control y confirmar el SHA exacto.
- Aplicar comparación y sustitución condicionada al SHA observado (CAS).
- Si el SHA cambió, abortar y reconciliar.
- Después de escribir, leer de vuelta y comprobar titular, generación, alcance y nuevo SHA.

### B — implementación

- Solo se solicita/ejecuta después de verificar A.
- Autoriza específicamente la implementación, compilación, pruebas e instalación local dentro del alcance acordado.
- No implica cambios de ACL, firewall, servicios, tareas programadas, puertos, secretos externos ni recursos de Khora salvo que exista autorización específica adicional.
- Si el alcance de B es insuficiente o ambiguo, se pide únicamente la precisión necesaria antes de la operación afectada.

### Controles invariables

- No fingir titularidad, identidad nativa, permisos, mensajes enviados, despliegues, instalaciones ni pruebas.
- No ejecutar operaciones protegidas sin autorización explícita y preflight.
- No mutar los núcleos ni controles de EP o Gobernanza por el solo hecho de coordinar sus entregas.
- No cambiar la fuente normativa única DUG por un documento provisional.
- `MCP-NORMATIVO: DESACTIVADO`; los alias Sink no se presumen desplegados.
- Sin FOL1 ACTIVO y verificado, no se asignan folios globales de conversación, ciclo, A o B.

## 7. Bloqueos P0 y regla de decisión

Un bloqueo P0 es una condición que impide construir o aceptar el MVP sin comprometer autorización, seguridad, integridad de datos, identidad, persistencia, transporte o una función esencial.

Ejemplos de P0:

- No se puede verificar el titular/control o la autorización material requerida.
- El host no satisface localidad, identidad o permisos y no existe una alternativa autorizada.
- El artefacto no coincide con el manifiesto o no puede ejecutarse por el harness seleccionado.
- El protocolo `stdio` no funciona correctamente.
- Existe riesgo de pérdida/corrupción de SQLite o los backups no son recuperables.
- Las escrituras protegidas no tienen raíz de confianza verificable, pero el MVP pretende habilitarlas.
- No puede demostrarse persistencia, diagnóstico/readiness o el recibo verificable exigido.

No son P0 por sí solos:

- Mejoras de interfaz o documentación cosmética.
- Soporte para un segundo cliente.
- Automatización avanzada no necesaria para el primer arranque.
- Telemetría de análisis ampliado.
- Optimización prematura.
- Capacidades normativas automáticas mientras `MCP-NORMATIVO` permanezca desactivado y no sean requisito del MVP.

Ante un P0 se corrige el asunto concreto. Cuando no haya P0, se deja de deliberar y se avanza al siguiente hito.

## 8. Secuencia de resolución del sprint

1. Recibir las respuestas a las últimas solicitudes abiertas de OCP y EP.
2. Cotejar cada respuesta solo contra sus requisitos y decisiones aplicables.
3. Resolver contradicciones materiales mediante corrección focalizada; no abrir una revisión general.
4. Obtener una conciliación final de Gobernanza sobre autorización, alcance y ausencia de P0.
5. Presentar al operador el estado consolidado y solicitar, cuando corresponda, autorización A.
6. Verificar la transferencia A con CAS y lectura de vuelta.
7. Solicitar autorización B, separada y específica.
8. Con B verificada, OCP construye, compila y prueba el servidor/artefacto funcional.
9. EP ejecuta el preflight y prepara la materialización/configuración del host autorizado.
10. Integrar mediante el harness Copilot portable y MCP `stdio`.
11. Ejecutar aceptación: preflight → materialización → configuración → inicio por Copilot → conexión MCP → health → operación → persistencia → backup → detención → reinicio.
12. Corregir únicamente fallos demostrados, repetir las pruebas afectadas y conservar la evidencia.
13. El operador acepta el MVP o identifica el criterio concreto que sigue incumplido.
14. Cerrar el sprint y registrar las mejoras no esenciales como backlog posterior.

## 9. Estado de intercambio al crear este objeto

Este estado es una fotografía del hilo al momento de materializar el protocolo; no sustituye una nueva lectura de los frentes al reinstanciar.

### OCP MCP

- Se recibió la entrega **“Contrato técnico mínimo consolidado”, revisión 1.1**.
- El modelo central emitió después una solicitud focalizada de conciliación relativa a: ruta de datos, límites EP/Copilot, estado de MCP-NORMATIVO/Sink, raíz de confianza de la autorización de escrituras y superficie funcional mínima.
- **Respuesta a esa última solicitud: PENDIENTE.**
- La solicitud fue preparada en esta conversación; su reenvío a la sesión OCP no está verificado en este registro.
- No debe prepararse otro prompt para OCP hasta recibir y analizar la respuesta a esa solicitud.

### Entorno Persistente (EP)

- Se recibió una propuesta de alojamiento/bootstrap y se preparó una solicitud focalizada de cotejo final: Known Folders, localidad, sincronización, ACL sin modificación, prueba temporal, COPILOT_HOME/HOME, preservación y escritura atómica de configuración y diagnóstico.
- **Respuesta a esa última solicitud: PENDIENTE.**
- La solicitud fue preparada en esta conversación; su reenvío a la sesión EP no está verificado en este registro.
- No debe prepararse otro prompt para EP hasta recibir y analizar la respuesta a esa solicitud.

### Gobernanza

- Este modelo central mantiene la función de integración y revisión de gobernanza del sprint.
- El control independiente del frente Gobernanza observado en `main` pertenece a una titularidad activa distinta; este objeto no transfiere esa titularidad.
- No se ha emitido una nueva solicitud a ese frente en esta última secuencia. La revisión de gobernanza se realiza desde la conversación central dentro del alcance autorizado, sin mutar su núcleo o control.
- Si se requiere que otra sesión titular de Gobernanza ejecute una acción, se aplican sus controles y se espera su respuesta antes de solicitarle otro trabajo.

### Estado de autorización y ejecución

- A: PENDIENTE; no se ha ejecutado ni verificado una transferencia.
- B: PENDIENTE; no se ha autorizado ni iniciado implementación.
- Compilación, instalación y ejecución local: NO REALIZADAS en el estado de este objeto.
- Pruebas de aceptación del producto: PENDIENTES.
- Folios globales: PENDIENTES/NO ASIGNADOS mientras FOL1 no esté activo.

## 10. Reinstanciación en un hilo fresco

La nueva conversación debe actuar como coordinadora del sprint, no asumir que la memoria del hilo anterior está disponible.

En su primer ciclo:

1. Leer el DUG completo y vigente desde `SeryMente/metodologia/main`; comprobar versión, firma, SHA y precedencia.
2. Leer este objeto provisional y tomar su registro de estado como punto de partida, no como prueba de que el estado remoto siga igual.
3. Releer `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json`, `MCP-METODOLOGIA.md` y los entregables vigentes. Comprobar titularidad, generación y SHA antes de mutar.
4. Releer el estado actual de EP desde su fuente canónica y rama vigente, junto con sus controles de responsabilidad aplicables. No asumir que la ausencia de un control en `main` demuestra que no exista fuera de esa rama.
5. Releer el control y núcleo de Gobernanza; no asumir que este hilo adquirió su titularidad.
6. Comparar la cabeza actual de `main` con los SHA registrados aquí. Los SHA de este documento son referencias históricas de creación, no garantía de frescura.
7. Recuperar las respuestas nuevas del operador. Procesar primero las respuestas a solicitudes pendientes. No preparar prompts nuevos para un frente hasta que haya respondido a su última solicitud.
8. Mantener la secuencia serial, el registro de decisiones, el alcance MVP, las autorizaciones A/B y los bloqueos P0 descritos.
9. Si un dato esencial de titularidad o autorización no puede reconciliarse, aplicar el control correspondiente y preguntar al operador solo lo estrictamente necesario.
10. Continuar desde el siguiente paso pendiente; no reiniciar el descubrimiento, el diseño ni las revisiones ya concluidas.

## 11. Fuentes y referencias observadas al crear el objeto

Repositorio: [SeryMente/metodologia](https://github.com/SeryMente/metodologia), rama `main`.

| Recurso | Ruta | SHA/blob observado |
|---|---|---|
| DUG único | `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html` | `cac4525de77d4f47a8a59c25201968ecf2056b90` |
| Núcleo MCP OCP | `frentes/mcp-metodologia/MCP-METODOLOGIA.md` | `0dd9c4a7594833f99cb658e6108c8439464babd8` |
| Control MCP OCP | `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json` | `ffa27d9c62c557aa4894eebfd8c4cbf44ed09335` |
| Núcleo EP leído | `frentes/ep/OEP.md` | `e1e045cdc9b1a286047c6d47c47a5111a0b52bce` |
| README EP leído | `frentes/ep/README.md` | `fd3515eed66ce9f3206e71aa4c341b1a8136089e` |
| Control Gobernanza | `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json` | `22ee60d4cc74a75816beaf03d8b927b8e8a22e70` |

Estado observado de controles:

- MCP OCP: `status=owned`, generación 1, titular operativo `chatgpt-C-MCP-METODOLOGIA-001-01a192b3-1063-7916-be41-ebfa974ede73`. No se cambió el control.
- Gobernanza: `status=active`, generación 8, titular operativo `chatgpt-C-GOBERNANZA-OCPMSP-01-SES-20261031-GV7EEE951A77`. No se cambió el control.
- EP: no se encontró `CONTROL-RESPONSABILIDAD.json` en el listado de `frentes/ep/` consultado en `main`. Su control vigente deberá adquirirse desde la fuente/rama que EP identifique; no inferir ausencia de titularidad.

Cabeza de `main` observada al crear el objeto: `84515d3fbff6ff160f7166dc0cadfd665e46fdd4` (commit que registra EP-TASK-001). No implica que el repositorio permanezca en esa revisión después de la creación de este archivo.

## 12. Condición de cierre y mantenimiento

Este objeto permanece provisional mientras dure el sprint. Se actualiza únicamente cuando un cambio de estado afecte la continuidad: respuesta recibida, prompt final preparado/reenviado, decisión cerrada, autorización A/B, bloqueo P0, evidencia de implementación o aceptación.

Cada actualización debe preservar la secuencia y distinguir lo observado de lo informado. No se reescriben antecedentes como si hubieran sido hechos en el momento actual.

Al aceptar el MVP, registrar cierre, versión final, artefactos, SHAs, pruebas y backlog diferido. Después, el operador decidirá si el objeto se archiva, se conserva como antecedente o se propone formalizar alguna práctica en la metodología. No se canoniza automáticamente.


## 13. Actualización de continuidad — 2026-10-31 · 12:24 · America/Mexico_City

Esta actualización prevalece sobre los estados pendientes de la fotografía inicial de la sección 9, sin borrar su procedencia histórica.

### OCP MCP

- **Respuesta recibida:** `OCP MCP — Contrato técnico consolidado 1.2`.
- Se analizaron sus respuestas a la conciliación focalizada anterior. La revisión 1.2 resolvió los puntos relativos a la ruta de datos, los límites EP/Copilot, el estado desactivado de MCP-NORMATIVO/Sink, la raíz local de confianza para autorización y la superficie funcional inicial (herramientas de lectura, operaciones protegidas, SQLite, eventos, telemetría, recibos y pruebas).
- **Puntos técnicos que requieren una última corrección acotada antes de congelar el contrato:**
  1. El contenido de fuentes canónicas y snapshots debe cifrarse también en reposo en la base local, con AES-256-GCM y clave protegida mediante DPAPI CurrentUser; no basta con cifrar los backups.
  2. Debe definirse la carga inicial verificable de un conjunto mínimo de fuentes canónicas: bundle o procedimiento local con commit, ruta, Git blob SHA y SHA-256 de contenido, sin fingir frescura ni requerir Sink.
  3. `BUILD_SNAPSHOT` debe definir consistencia entre artefacto local, transacción SQLite, evento y recibo; no se presupone atomicidad común entre filesystem y SQLite. Elegir BLOB transaccional o staging/rename con recuperación idempotente.
- Los schemas JSON exactos de herramientas, salidas y errores se exigirán como artefactos de implementación y pruebas, no como una nueva ronda general de arquitectura.
- `prepare_operation` debe quedar etiquetado con precisión como registro preparatorio sin efecto gobernado y sin grant de operador; `execute_operation` conserva la autorización expresa.
- El modelo central preparó una última solicitud focalizada para OCP. Su reenvío a la sesión OCP **NO VERIFICADO**; su respuesta queda **PENDIENTE**. No preparar otra solicitud a OCP antes de recibirla y analizarla.
- La revisión 1.2 no equivale a autorización de implementación ni aceptación del producto.

### Entorno Persistente (EP)

- La última solicitud de cotejo de alojamiento permanece **RESPUESTA PENDIENTE**.
- No se prepara una nueva solicitud para EP antes de recibir y analizar esa respuesta.
- El estado de EP debe actualizarse desde la fuente y rama que el propio frente identifique; no inferir titularidad ni permisos a partir de la ausencia de un control en `main`.

### Gobernanza, autorizaciones y ejecución

- Gobernanza continúa siendo un frente independiente. La titularidad observada en su control no se transfiere por este objeto.
- A: **PENDIENTE**; transferencia no ejecutada ni verificada.
- B: **PENDIENTE**; implementación no autorizada ni iniciada.
- Código, compilación, instalación y ejecución local: **NO INICIADOS** en este estado.
- Pruebas de aceptación: **PENDIENTES**.
- FOL1: no declarado activo; folios globales continúan **PENDIENTES/NO ASIGNADOS**.

### Regla de continuación

El siguiente evento esperado es la respuesta de OCP a la última solicitud focalizada o la respuesta pendiente de EP, según cuál aporte primero el operador. Se analiza cada respuesta antes de abrir otro turno a ese mismo frente. No se reinicia la arquitectura; se cierra el delta material y se avanza a A/B y construcción del MVP cuando proceda.

---

**Regla de oro de continuidad:** el modelo central administra una sola secuencia de trabajo entre Gobernanza, EP y OCP MCP; espera cada respuesta antes de abrir una nueva solicitud al mismo frente; interviene solo cuando su análisis añade valor material; y conduce el sprint desde la deliberación hacia la construcción y aceptación del MVP sin sacrificar autorización, seguridad ni integridad.


## 14. Actualización de continuidad — respuesta OCP 1.2 y última corrección

**Evento conversacional:** 2026-10-31 · recepción y análisis de OCP Contrato técnico consolidado 1.2.

- La respuesta OCP 1.2 fue recibida y analizada. Resolvió la conciliación previa sobre rutas, límites de responsabilidad EP/Copilot, MCP-NORMATIVO/Sink, emisor/raíz local de autorización y superficie funcional inicial.
- Se preparó una última instrucción focalizada para OCP sobre tres puntos materiales:
  1. cifrado AES-256-GCM del contenido canónico y snapshots en reposo dentro del almacenamiento local, con clave protegida por DPAPI CurrentUser;
  2. bundle inicial verificable de fuentes canónicas con commit, ruta, Git blob SHA, SHA-256 de contenido y fecha de captura;
  3. consistencia y recuperación de `BUILD_SNAPSHOT` respecto de su artefacto, transacción SQLite, evento y recibo; sin presumir atomicidad entre filesystem y SQLite.
- La instrucción pide además precisar que `prepare_operation` es una solicitud preparatoria sin efecto gobernado ni grant de operador; los schemas JSON exactos se aportan como artefactos de implementación y pruebas, sin nueva ronda de arquitectura.
- **Estado de la nueva instrucción:** PROMPT PREPARADO; reenvío a OCP NO VERIFICADO; respuesta PENDIENTE. No preparar otro prompt para OCP antes de recibir y analizar esa respuesta.
- EP: su respuesta a la solicitud anterior sigue PENDIENTE. No se generó un nuevo prompt para EP.
- Gobernanza: sin nuevo turno solicitado; el modelo central conserva la coordinación y no asume titularidad del frente.
- A/B siguen PENDIENTES. No hay implementación, compilación, instalación ni pruebas de aceptación iniciadas.

Esta actualización prevalece sobre el estado anterior de la sección 13 únicamente en lo relativo al nuevo intercambio OCP y mantiene intactos los antecedentes.

 
## 15. Resolución de Gobernanza — cierre de diseño y habilitación de aceptación

**Evento de coordinación:** resolución recibida del operador · 2026-10-31.

### Decisión

**DECISIÓN A: DISEÑO CERRADO Y ACEPTACIÓN HABILITADA SUJETA A AUTORIZACIONES OPERATIVAS.**

La conciliación EP se toma como compatible con el procedimiento de alojamiento/bootstrap v1.0 y las decisiones previas aceptadas. El procedimiento v1.0 queda congelado como base de implementación y aceptación; no se reabre arquitectura por ausencia de pruebas locales. Se conservan las precisiones aceptadas: manifiesto como autoridad de entrypoint/args; readiness máximo 15 s y estados/códigos; backup 7 diarios + 4 semanales; HOME del entorno efectivo con fail-closed; prueba temporal controlada de escritura/lectura/eliminación; control de concurrencia y read-back de configuración; preservación de servidores Copilot ajenos; proceso stdio propiedad del harness.

Rutas congeladas:
- Aplicación: <FOLDERID_Desktop>\SeryMente\OCP\OCP MCP\app\versions\0.1.0\.
- Datos: <FOLDERID_LocalAppData>\SeryMente\OCP MCP\.
- Copilot: COPILOT_HOME\mcp-config.json si está definido y es válido; si no está definido, $HOME\.copilot\mcp-config.json desde el entorno efectivo del host. Un valor definido inválido bloquea, sin fallback.

### Bloqueos

**Bloqueos de diseño P0:** ninguno identificado para el MVP de alojamiento/bootstrap.

**Compuertas operativas P0, pendientes de evidencia:**

1. **Autorización y titularidad OCP:** el control observado continúa owned, generación 1, con alcance documental. A — transferencia de titularidad — no está ejecutada/verificada; B — implementación — no está autorizada. Levantamiento: autorización expresa A, CAS sobre SHA actual, read-back de titular/generación/alcance; después autorización B dentro de su alcance expreso.
2. **Autorización de actos sobre el equipo:** no hay evidencia en esta resolución de autorización local para inspección, prueba temporal, materialización, cambio de configuración Copilot ni ciclo de proceso. Levantamiento: instrucciones explícitas del operador que enumeren cada acción, host/usuario, rutas y límites. Una sola instrucción puede cubrir varios actos únicamente si los enumera expresamente.
3. **EP: autoridad operativa actual:** el listado de frentes/ep en main no muestra CONTROL-RESPONSABILIDAD.json; esto no demuestra que no exista en la fuente/rama operativa que EP utiliza. Antes de cualquier mutación, EP identifica fuente/rama/control vigente, titular y alcance, o presenta autorización directa del operador suficiente para esa acción.
4. **Manifiesto y artefacto 0.1.0:** OCP 1.2 declaró que el manifiesto publicado y el ejecutable real todavía no habían sido recibidos/cotejados. Levantamiento: publicación preparada por OCP tras B; manifiesto íntegro, entrypoint/args exactos y SHA-256 por componente, cotejados con archivos materiales. Hasta entonces no se modifica Copilot ni se inicia servidor.
5. **Preflight local:** no hay evidencia aquí de SID, sesión, Known Folders, volumen, sincronización, reparse points, ACL efectivas ni pruebas temporales en el equipo objetivo. Levantamiento: evidencia EP obtenida después de las autorizaciones de inspección y prueba temporal.

Estos bloqueos impiden solo las acciones dependientes. No reabren el diseño ni impiden preparar documentación. No se afirma que ninguna prueba esté realizada.

### Matriz de autorización por acto

Todas las autorizaciones operativas las concede el **operador**. EP ejecuta acciones de entorno después de verificar su autoridad vigente; OCP construye y entrega el artefacto dentro de A/B; el harness Copilot inicia, detiene y reinicia el proceso stdio.

| Acto | Autorización necesaria | Ejecutor y evidencia |
|---|---|---|
| Inspección read-only de identidad, rutas, volumen, sincronización, reparse points y ACL | Autorización explícita del operador limitada a inspección; no habilita cambios | EP; reporte de SID/sesión, rutas reales, volumen, flags de sincronización y ACL efectivas |
| Prueba temporal de escritura/lectura/eliminación | Autorización separada y explícita del operador, especificando destinos y limpieza | EP; archivo temporal único, bytes conocidos, flush, read-back exacto, SHA-256, eliminación y ausencia confirmada |
| Implementación/compilación del servidor y manifiesto | A verificada y B explícita | OCP; commit, configuración de build, SDK/runtime, artefacto y manifiesto |
| Materialización/instalación de versión inmutable y directorios de datos | Autorización explícita del operador dentro de B o mandato operativo específico; solo tras preflight y hash válido | EP; inventario, rutas, SHA-256 antes/después y no sobrescritura de versión existente |
| Modificación de mcp-config.json | Autorización explícita específica; no se infiere de inspeccionar ni instalar | EP; copia recuperable, fingerprint original, JSON temporal validado, control de concurrencia, reemplazo atómico, read-back y comparación semántica de todas las demás propiedades y entradas mcpServers |
| Inicio del servidor | Autorización explícita de inicio tras instalación/configuración verificadas | Copilot harness inicia; EP observa PID, ruta, SID, stdio y logs redactados |
| Detención normal | Autorización explícita de detención | Copilot harness realiza cierre; EP verifica PID ausente y cierre SQLite sin residuo |
| Reinicio | Autorización explícita de reinicio | Copilot harness reinicia; EP verifica nueva instancia, conexión, health y persistencia |

A y B no son permisos tácitos para todos los cambios locales. Ningún permiso de esta matriz autoriza modificar ACL, propietario/herencia, firewall, registro, servicios o tareas programadas.

### Secuencia de aceptación

1. **Preflight e identidad:** SID/token y sesión interactiva; Known Folders; ruta absoluta; volumen fijo local; ausencia de UNC/red/extraíble/sincronización incompatible; reparse points clasificados; ACL efectivas suficientes sin modificación. Después, prueba temporal autorizada: write → flush → read-back → SHA-256 → delete → confirmar ausencia. Evidencia: reporte identificado por ejecución, rutas y resultados.
2. **Manifiesto y ejecutable:** OCP entrega publicación 0.1.0 inmutable y manifiesto verificable. EP comprueba entrypoint relativo, vector exacto de args, arquitectura, runtime, commit y SHA-256 de los componentes. No se inventa nombre ni argumentos; si manifiesto y prueba de lanzamiento difieren, detener.
3. **Configuración portable:** resolver COPILOT_HOME fail-closed o HOME del host real. Leer y validar JSON; conservar copia recuperable; cambiar solo mcpServers.ocp-mcp; temporal en el mismo directorio; comprobar fingerprint para detectar concurrencia; reemplazo atómico; read-back. Demostrar que todas las demás propiedades superiores y entradas mcpServers permanecen semánticamente idénticas. Registrar SHA-256 del antes y después.
4. **Inicio y conexión:** autorizado expresamente; Copilot harness crea el proceso con command/args del manifiesto y conecta stdio. stdout solo MCP; diagnóstico por stderr/logs redactados. Evidencia del intercambio MCP inicial, PID, ruta ejecutable, SID y proceso padre como dato diagnóstico, no autenticación criptográfica.
5. **Diagnóstico/readiness:** diagnose --json y get_health; inicialización ≤15 s; estado/código coherentes: READY 0, DEGRADED 1, NOT_READY 2. Evidencia: JSON, hora UTC, versión, comprobaciones, exit code y respuesta MCP.
6. **Persistencia:** con operación de prueba expresamente autorizada, crear dato sintético no sensible, verificar read-back SQLite, WAL/integridad y backup cuando corresponda. No usar datos reales ni activar funciones ajenas al alcance. Las escrituras protegidas continúan bloqueadas si la raíz de confianza no ha superado sus pruebas; la prueba de bootstrap no autoriza por sí misma todo el flujo funcional OCP 1.2.
7. **Detención y reinicio:** autorización explícita; cierre normal por harness; verificar PID ausente, SQLite cerrado y ausencia de proceso residual. Reiniciar por Copilot; verificar nueva conexión, get_health, diagnóstico y lectura del dato persistido.
8. **Cierre:** cotejar la evidencia completa, reportar desviaciones y conservar archivos, hashes, resultados y read-back. El operador acepta o rechaza el MVP.

### Estados de aceptación

- **ACCEPTED / READY:** todas las etapas aplicables pasan; manifiesto/hashes coinciden; configuración preserva todo salvo la entrada objetivo; stdio y health funcionan dentro del límite; persistencia, backup y reinicio requeridos quedan verificados; no hay residuos.
- **DEGRADED:** conexión y lectura/diagnóstico funcionan, pero falla el backup diario obligatorio u otra condición expresamente degradable. Escrituras protegidas bloqueadas. No se acepta el MVP como plenamente operativo mientras persista una degradación que afecte la aceptación.
- **NOT_READY / STOP:** SID/sesión incorrectos; ubicación remota/sincronizada/no verificable; ACL insuficientes; artefacto/hash/manifest discrepante; JSON inválido o concurrencia; fallo MCP/stdio; inicialización >15 s sin estado admisible; corrupción/descifrado fallido; pérdida de datos; proceso no cerrable o residuos. Detener sin nuevos cambios, conservar evidencia y no reparar permisos ni saltar gates.

### Siguiente acción

**Primera acción autorizable:** el operador debe emitir autorización de solo lectura a EP para inspeccionar el host objetivo y resolver el preflight de identidad, rutas, localidad, sincronización, reparse points y ACL. Esta autorización no incluye la prueba temporal ni cambios.

**Ejecutor:** EP, una vez identificado su control/titular operativo vigente.  
**Evidencia de salida:** informe read-only con SID/sesión, Known Folders absolutas, volumen y flags de localidad/sincronización, reparse points clasificados y ACL efectivas. Si el preflight es compatible, EP informa y espera autorización separada para prueba temporal write/read/delete. Si falla, detiene únicamente la acción afectada y no intenta corregirla.

Esta resolución no ejecuta acciones en el equipo, no transfiere titularidad, no concede B y no modifica OEP, README, ACL, propietario, herencia, firewall, registro ni entorno.
