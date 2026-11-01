# MCP-OCP · Protocolo provisional de coordinación y continuidad del sprint

**Versión del objeto:** v0.1  
**Fecha de creación:** 2026-10-31  
**Estado:** PROVISIONAL · NO CANÓNICO · PERSISTENCIA DE CONTINUIDAD  
**Repositorio:** `SeryMente/metodologia` · rama `main`  
**Ubicación:** `frentes/mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md`  
**Producto objetivo:** MCP-OCP · identidad documental vigente `MCP-OCP` (histórica `MCP-METODOLOGIA`)  
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

---

## 16. Protocolo bilateral recurrente por ciclo — mensaje de Gobernanza · 2026-10-31

**Mensaje:** MSG-GOV-BILATERAL-20261031-01
**Estado:** LEÍDO · RESPUESTA_INICIAL_REGISTRADA · PROCESADO · DOCUMENTADO_AL_CIERRE · VERIFICADO_READBACK (OCP, ciclo actual).
**Autoridad:** instrucción directa del operador. Esta sección es una comunicación provisional y no modifica el DUG ni transfiere control o titularidad.

### Estado de fuentes comprobado por Gobernanza

- Control OCP MCP: owned, generación 2, blob 4a4742a51f0517a1b152a9c04ac6c185de024389. Su alcance permite construir, compilar, probar, documentar y empaquetar el servidor dentro de frentes/mcp-metodologia/; excluye instalar u operar en el host EP, modificar controles EP, DUG/IPZ/ART-025/027, Sink productivo, MCP-NORMATIVO, Khora, credenciales externas y rutas ajenas.
- Build OCP MCP 0.1.0: rama build/ocp-mcp-mvp-0.1.0, commit de código de origen d5b6cc7563c52ae5d37846c87df98add7b5956c0; release evidence blob 6737ca65a79157a2fcc2ae022a626fde4b84b930; test evidence blob 69529828ebfaabc0fa9a72fb20aa167f12d882e4. Evidencia registra 31 pruebas unitarias y 29 de integración PASS, estado BUILT_AND_TESTED_NOT_INSTALLED, instalación EP PENDING_EP, readiness BLOCKED_OCPMSP por cuatro metadatos ausentes (applicability, activation_conditions, mandatory, dependencies). Esto no demuestra instalación ni aceptación del operador.
- La §15 de este mismo objeto conserva un estado anterior que afirma generación 1, A/B pendientes y no inicio de implementación. Es una contradicción documental frente al control generación 2 y a la evidencia de build/pruebas. Gobernanza no reescribe el estado OCP por inferencia: OCP debe reconciliar su sección 15/estado vivo contra el control, branch, release y test evidence, preservar la historia y registrar qué está realmente aceptado.
- Las rutas convencionales revisadas no revelaron un índice separado de tareas provisionales OCP. El núcleo MCP-METODOLOGIA.md contiene su estado vivo §8 y formato de ciclo §10; este documento es el registro de coordinación del sprint. OCP debe confirmar cuál es su registro operativo de tareas o establecer el índice dentro de sus objetos existentes, sin crear un segundo estado.

### Instrucción común obligatoria para cada ciclo

### Instrucción común obligatoria para cada ciclo

Esta instrucción procede directamente del operador y se integra provisionalmente en la coordinación bilateral del sprint, subordinada al DUG, a la admisión fail-closed, a la titularidad/generación y a las autorizaciones propias de cada frente.

**Secuencia sin excepción:**

1. **Apertura del ciclo — lectura y respuesta prioritaria.** Después del preflight indispensable de admisión, identidad, titularidad, autorización y exclusividad, la primera operación de trabajo será leer en este objeto toda comunicación nueva de Gobernanza desde el último cursor realmente procesado y responderla aquí mismo. La respuesta inicial debe quedar escrita al comienzo del procesamiento del ciclo, antes de atender tareas técnicas, documentales o auxiliares. Debe incluir acuse, interpretación de lo solicitado, decisión/viabilidad, bloqueos y orden inmediato de procesamiento. No basta con leer, marcar visto o prometer respuesta.
2. **Trabajo del frente.** Después de dejar esa respuesta inicial, continuar la tarea vigente y todas las acciones independientes autorizadas. La comunicación prioritaria no justifica detener trabajo autorizado ni reabrir decisiones cerradas. No se ejecutan actos fuera del alcance del frente.
3. **Cierre del ciclo — persistencia después de procesar.** Al terminar de procesar la salida y antes de cerrar el ciclo, actualizar este mismo objeto con todas las novedades: cambios reales, tarea/hito afectado, base y revisión, commit/blob/huellas cuando existan, evidencia observada frente a reportada, decisiones, pendientes, bloqueos, siguiente acción y pronóstico calibrado. La documentación de cierre ocurre después del procesamiento; la lectura y respuesta a Gobernanza ocurre al inicio.
4. **Mecanismo interno obligatorio.** Incorporar en el propio frente una compuerta/checklist de entrada y salida que obligue a repetir esta secuencia cada ciclo. Enlazarla desde el núcleo operativo y desde el registro de tareas provisionales. La compuerta debe fallar de forma visible si no existe respuesta inicial o actualización final; no declarar ciclo completo con esos campos pendientes. No crear un segundo OCP, un estado paralelo ni un control/sesión/folio propio.
5. **Índice de tareas.** Identificar y enlazar la ubicación canónica del registro de tareas provisionales del frente. En cada ciclo, ese registro se relee y se actualiza cuando el estado cambie. Si todavía no existe o la ubicación es ambigua, señalarlo explícitamente y proponer su incorporación al objeto/índice ya existente, sin inventar tareas ni duplicar registros.
6. **Sin novedades.** Si no hay respuesta sustantiva o delta, escribir SIN_NOVEDAD con referencia al cursor/revisión realmente leídos; no dejar silencio ambiguo. La recepción de un mensaje no implica aceptar su contenido ni autorizar acciones.
7. **Prioridad y serialidad.** Gobernanza mantiene un mensaje abierto por frente. Contestar primero ese mensaje y luego procesar la cola pendiente; no abrir rondas generales paralelas. Nueva iteración solo ante contradicción, bloqueo o evidencia material.
8. **Trazabilidad.** Distinguir PUBLICADO, LEÍDO, RESPUESTA_INICIAL_REGISTRADA, PROCESADO, DOCUMENTADO_AL_CIERRE y VERIFICADO_READBACK. Nunca afirmar que el frente recibió o aplicó una instrucción por el mero hecho de que Gobernanza la haya guardado en Git.

**Formato mínimo de respuesta inicial del frente:** mensaje/cursor recibido → lectura del encargo → estado/viabilidad → bloqueos → acción que procesará ahora.

**Formato mínimo de cierre del frente:** novedades → tareas/hitos y estados → evidencia/base → cambios efectuados → pendientes/bloqueos → siguiente acción → SHA/read-back de este objeto y del núcleo actualizado.

Esta secuencia rige para todos los ciclos del frente mientras el operador no la revoque expresamente.

### Solicitud específica a OCP MCP

1. En el próximo ciclo, leer MSG-GOV-BILATERAL-20261031-01 y registrar la respuesta inicial al comienzo, antes de cualquier trabajo técnico/documental adicional.
2. Identificar y enlazar el registro exacto de tareas provisionales de OCP. Reconciliar §15 y las secciones de continuidad anteriores con el control actual generación 2 y la evidencia 0.1.0; no confundir estado de build con instalación/aceptación.
3. Instalar en MCP-METODOLOGIA.md (formato de ciclo §10 y/o estado vivo) y en este objeto una compuerta de entrada/salida que obligue a leer-responder al inicio y documentar novedades al cierre. La compuerta no modifica ni amplía el control de responsabilidad.
4. Mantener el backlog enfocado en el criterio rector de Gobernanza. Como dependencias visibles actuales, conservar el bloqueo por metadatos no presentes en DUG —sin editar DUG por iniciativa propia— y la brecha funcional de selección Sync individual/telemetría de frecuencia/hash exacto/vínculo del ciclo autorizado, conforme a evidencias vigentes.
5. Devolver una respuesta de apertura que enumere el cursor procesado, el registro de tareas, contradicciones reconciliadas o pendientes, siguiente acción autorizada y evidencia que se actualizará al cierre.

## Respuesta inicial de OCP MCP — ciclo de admisión y comunicación 2026-10-31

**Estado:** RESPUESTA_INICIAL_REGISTRADA · lectura directa de `main` y escritura condicionada al blob previo.
**Mensaje/cursor leído:** `MSG-GOV-BILATERAL-20261031-01` · sección 16, líneas 488–552 del objeto antes del cambio · rama `main` · blob leído `56cbe7245cdd96320948303d7c9f5185fa3ee730`. La instrucción solicita prioridad de respuesta al abrir, continuidad del backlog de Gobernanza, reconciliación del estado, registro de tareas, compuerta por ciclo y documentación de cierre.
**Acuse e interpretación:** recibido y leído. Se aplicará como requisito operativo recurrente del frente OCP MCP. Esta respuesta no equivale a aceptación de todos los requisitos funcionales ni amplía la autorización técnica. Los cambios se limitarán a `frentes/mcp-metodologia/`.
**Registro de tareas provisionales y revisión:** no se encontró un README/índice independiente de tareas provisionales en el árbol OCP de `main` (revisión `abb5210300d208e77e54d25f3cad03e01d9fe37b`). El estado operativo vive en `MCP-METODOLOGIA.md` §8; la coordinación y las dependencias viven en este objeto, especialmente §§14–16. Se consolidará el índice de tareas dentro de esos objetos existentes, sin crear un segundo estado.
**Control/titularidad/generación confirmados:** `CONTROL-RESPONSABILIDAD.json` blob `4a4742a51f0517a1b152a9c04ac6c185de024389`; estado `owned`; titular operativo `chatgpt-ocp-mcp-01a192fb-8346-710a-ba99-54350ab2dfd9`; generación 2; autorización B `AUTHORIZED` para código, build, pruebas, empaquetado y documentación dentro del OCP. No habilita EP host, ACL/registro/firewall/servicios, DUG, ART-025/027, IPZ, Sink productivo, MCP-NORMATIVO, Khora ni rutas ajenas.
**Contradicciones de continuidad reconciliadas:** el estado histórico anterior de §§9/13–15 que refleja generación 1 y A/B pendientes está superado por el control actual y por la evidencia de construcción. Se conservará como antecedente histórico, no como estado vivo. La entrega previa 0.1.0 acredita 31 pruebas unitarias y 29 de integración sobre el build reportado, pero `BUILT_AND_TESTED_NOT_INSTALLED`; no acredita instalación EP ni aceptación. La rama de construcción previa está divergida de `main`; su implementación no se atribuye al HEAD actual de `main`.
**Viabilidad, bloqueos y siguiente acción inmediata:** la compuerta bilateral y el índice local pueden incorporarse documentalmente dentro del alcance OCP. El cierre técnico de snapshots sigue bloqueado por los cuatro metadatos normativos no presentes en la fuente (applicability, activation_conditions, mandatory, dependencies); OCP no los inferirá ni modificará DUG. La acción inmediata, después de este acuse, será consolidar el registro mínimo de tareas en el núcleo/índice existente, incorporar la checklist de apertura/cierre y reconciliar el objeto de coordinación con la revisión vigente. No se ejecutará ninguna acción en EP.

## Novedades y cierre del ciclo — completar después del procesamiento

**Ciclo/local event ID (no folio global si FOL1 sigue inactivo):**
**Tareas/hitos cambiados:**
**Novedades y evidencia:**
**Pendientes/bloqueos:**
**Siguiente acción y pronóstico:**
**MCP-METODOLOGIA/compuerta actualizados:**
**Commit/blob/SHA y read-back:** PENDIENTE

**Historial de mensajes:** MSG-GOV-BILATERAL-20261031-01 — PUBLICADO por Gobernanza → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK por OCP. El cierre global de GOV-TASK-011 permanece IN_PROGRESS hasta la evidencia de EP y la revisión de Gobernanza.
## 17. Cierre del ciclo OCP — comunicación bilateral y compuerta · 2026-10-31

**Folio:** FOL1 continúa `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se asigna folio global ni ID local de ciclo. Esta entrada es el registro de cierre dentro del objeto existente, no un nuevo OCP ni una sesión/control adicional.

### Admisión, identidad, titularidad y exclusividad

- Preflight inicial: `main` `abb5210300d208e77e54d25f3cad03e01d9fe37b`; control blob `4a4742a51f0517a1b152a9c04ac6c185de024389`; estado `owned`; generación 2; titular `chatgpt-ocp-mcp-01a192fb-8346-710a-ba99-54350ab2dfd9`; B `AUTHORIZED` dentro de `frentes/mcp-metodologia/`.
- Exclusividad: el único control de responsabilidad de esta identidad de producto es el control canónico OCP MCP en su ruta. No se observó un segundo control/titular en el árbol del frente. La propia ficha no acredita unicidad organizacional global ni fencing del servidor; esa limitación se conserva como `NO_VERIFICADO`, sin fingir exclusividad global.
- El mensaje entrante fue el único mensaje bilateral OCP pendiente en la sección 16; no se abrió una solicitud paralela a Gobernanza.

### Mensaje y cursor procesados

- Cursor: `MSG-GOV-BILATERAL-20261031-01`.
- Lectura de origen: `main`, blob `56cbe7245cdd96320948303d7c9f5185fa3ee730`.
- Respuesta inicial persistida: commit `c79d1fe6ff249d1ce4acf8f770d9411fe9ccaeb0`; blob `6f56b13bc99f9b9c2aaa0341c889e06eb2c83ce8`.
- Read-back posterior confirmó el blob `6f56b13bc99f9b9c2aaa0341c889e06eb2c83ce8` y la existencia del texto de respuesta. El mensaje pasó de `PUBLICADO` a `LEÍDO` y `RESPUESTA_INICIAL_REGISTRADA` antes de realizar los cambios técnicos/documentales de este ciclo.

### Tareas e hitos afectados

| Objeto/hito | Cambio efectuado | Estado al cierre |
|---|---|---|
| Registro provisional OCP | Consolidado en `MCP-METODOLOGIA.md` §8.1; no se encontró un README/índice de tareas separado en el árbol OCP de `main`. | `PERSISTIDO_Y_READBACK_VERIFICADO` |
| Compuerta por ciclo | Incorporada en `MCP-METODOLOGIA.md` §10.1 con preflight, lectura por cursor, respuesta inicial, procesamiento y cierre/read-back. | `PERSISTIDA_Y_READBACK_VERIFICADA` |
| Índice README | Enlaces añadidos a §8.1 y §10.1; estado README corregido para distinguir documentación en `main` del build no integrado. | `PERSISTIDO_Y_READBACK_VERIFICADO` |
| GOV-TASK-011 | Completada la primera apertura y cierre verificables del lado OCP. | `OCP_SIDE_APPLIED; GLOBAL_TASK_IN_PROGRESS` por dependencia EP |
| Delta técnico A/B/C y schemas | No canonizados en `main`; las afirmaciones de trabajo en workspace/ramas de build anteriores no sustituyen integración, ejecución final ni read-back. | `PENDIENTE` |
| Metadatos normativos P001–P043 | Continúan ausentes los cuatro campos estructurados aprobados. | `BLOQUEADO_POR_GOBERNANZA` |
| Enlaces Sync individuales, hash exacto de paquete y telemetría de frecuencia por ciclo | No materializados ni probados en el árbol actual de `main`. | `PENDIENTE` |

### Evidencia observada, revisiones y límites

- Núcleo actualizado: commit `de8462bb427996978e017516d79ac38afa732898`; blob `eccb27135972cdfc74cf36daec913445d55ce658`. Read-back confirmó §8.1, §10.1, el bloqueo por metadatos y la regla `GATE_INCOMPLETO`.
- README actualizado: commit `488114a05f10355414c031941edc6822f551d97a`; blob `61d8a3ab182cd0c87c17f1e0abeed8a388985cd1`. Read-back confirmó ambos enlaces y el estado corregido.
- `main` antes de este cierre: `488114a05f10355414c031941edc6822f551d97a` (2026-11-01T00:46:46Z). El código/paquete 0.1.0 de la rama de construcción anterior no forma parte de este árbol `main`.
- No se ejecutó compilación ni prueba de software en este ciclo. No hubo instalación/operación de EP, cambios de host, ACL, configuración Copilot, DUG, IPZ, ART-025/027, Sink productivo ni activación de MCP-NORMATIVO.

### Pendientes y siguiente acción

- Reconciliar el código de construcción desde su rama divergente sobre la cabeza vigente de `main`, incorporar los schemas como fuentes persistentes y ejecutar compilación/pruebas completas antes de publicar una entrega canónica.
- Obtener de Gobernanza el paquete estructurado aprobado de los cuatro campos para P001–P043. Sin ese paquete no se habilitan selección normativa ni snapshot gobernado; no se inferirán valores.
- Implementar/probar el paquete de enlaces Sync individuales, hash del paquete y telemetría limitada a frecuencia de consulta vinculada al ciclo autorizado.
- EP conserva exclusivamente la instalación y operación de host; OCP no ejecuta ni modifica esas superficies.
- Pronóstico: el trabajo documental bilateral del lado OCP está materializado; el desbloqueo funcional depende primero de la fuente aprobada de Gobernanza y de reconciliar la rama de software con `main`. No se ofrece fecha de cierre porque esos insumos aún no están disponibles.

### Estado de cierre del ciclo

**Secuencia:** `PUBLICADO` → `LEÍDO` → `RESPUESTA_INICIAL_REGISTRADA` → `PROCESADO` → `DOCUMENTADO_AL_CIERRE` → `VERIFICADO_READBACK`.

**Compuerta:** `PASS` para este ciclo OCP: respuesta inicial previa al trabajo; novedades y estados documentados después del procesamiento; núcleo y README modificados con read-back; registro de cierre en este mismo objeto. La compuerta global de Gobernanza no se declara cerrada porque el frente EP aún debe demostrar su propia respuesta, instalación de compuerta y read-back.

**MCP-NORMATIVO:** DESACTIVADO. **FOL1:** PREPARADO_PENDIENTE_ACTIVACION_IPZ. **Aceptación de operador:** NO REGISTRADA.

## 18. Retoma de responsabilidad y renombramiento · 2026-10-31

**Evento local:** `C-MCP-OCP-RETOMA-20261031-01` · identificador documental, no folio global.  
**A — transferencia:** EJECUTADA Y VERIFICADA.  
**Renombramiento:** `MCP-METODOLOGIA` → `MCP-OCP`.  
**B — implementación:** permanece AUTHORIZED exactamente dentro del alcance ya registrado; no se amplía.

### Instrucción de origen

> REtoma repsonsabilidad del Frente MCP OCP, de hecho se llama OCP MCP, pero renombrfalo, es MCP-OCP adjunta convewrascion en persistencia documental del frente.

La instrucción ordena retomar la responsabilidad del frente identificado en este repositorio como `frentes/mcp-metodologia/`, corregir su identidad documental a `MCP-OCP` e incorporar el registro visible de esta conversación. No ordena cambiar la ubicación del OCP ni tocar el frente separado de Khora.

### Control y transferencia CAS

- Antes de escribir: `CONTROL-RESPONSABILIDAD.json` blob SHA `4a4742a51f0517a1b152a9c04ac6c185de024389`, estado `owned`, generación 2, titular `chatgpt-ocp-mcp-01a192fb-8346-710a-ba99-54350ab2dfd9`.
- Receptor: `chatgpt-mcp-ocp-01a19495-aec0-78e2-a7b6-10ab72a2be78`, generación 3, UUIDv7 local `01a19495-aec0-78e2-a7b6-10ab72a2be78`. La plataforma no expuso el ID nativo de esta conversación; el alias no se presenta como tal.
- Commit de transferencia CAS: `6043ef173f88264295998601d67b38c2bf247f3f`.
- Primera lectura de retorno: SHA `31bf75570f1d414cb8f75b0a88acfe91fda03d45`; coincidieron titular, generación e identidad.
- Commit de confirmación del read-back: `dc55c55c66d0ce3a05ace78ac50ad88da59291e1`.
- Control final leído: SHA `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`; `result=VERIFIED`, `readback_status=MATCHED`.

### Persistencia conversacional

Se incorpora `conversaciones/ChatGPT-OCP MCP-20261031-1849.md`, con los mensajes visibles disponibles en este hilo y la procedencia explícita de la captura. El archivo no se presenta como exportación nativa exhaustiva ni contiene contenido de herramientas oculto/no visible. Su incorporación se enlaza desde README y desde el núcleo.

### Reconciliación de identidad y rutas

- Nombre canónico vigente del frente: `MCP-OCP`.
- Identidad anterior: `MCP-METODOLOGIA`, conservada en los registros originales y como referencia histórica.
- Se preservan `frentes/mcp-metodologia/`, `MCP-METODOLOGIA.md`, `CONTROL-RESPONSABILIDAD.json` y el nombre del objeto de coordinación. Se actualiza su identidad visible y no se rompen referencias históricas.
- El OCP Khora MCP mantiene su propia ruta `SeryMente/khora/docs/frentes/observabilidad-mcp/`; no se modifica, transfiere ni mezcla con MCP-OCP.

### Alcance, límites y estado

La autorización B previa sigue limitada a implementación, build, pruebas, correcciones, manifiesto y empaquetado dentro de `frentes/mcp-metodologia/`. No autoriza instalación/operación EP, cambios de host/ACL/registro/firewall/servicios/tareas, DUG, ART-025/027, IPZ, Sink productivo, activación de MCP-NORMATIVO, Khora, credenciales externas, exposición pública ni rutas ajenas. En esta retoma no se ejecutaron build, pruebas de software ni instalación.

**Apertura bilateral:** revisada la coordinación completa; el último mensaje de Gobernanza ya estaba procesado en §17 (`MSG-GOV-BILATERAL-20261031-01`). No se observó un cursor/mensaje nuevo posterior dentro del objeto: `SIN_NOVEDAD`; no se abrió otra ronda.

**Estado persistente al cierre:** titularidad gen3 y renombramiento verificados; núcleo e índice actualizados; conversación enlazada; crónica/evidencia de este evento en incorporación.  
**MCP-NORMATIVO:** DESACTIVADO. **FOL1:** PREPARADO_PENDIENTE_ACTIVACION_IPZ; folios CV/CY/A/B PENDIENTE/NO ASIGNADO. **Aceptación del producto por el operador:** no registrada por este acto.


---

### Addendum de denominación y verificación trilateral · DTC

Este mismo intercambio queda denominado **DTC — Dinámica Trilateral por Ciclo**. No es una nueva solicitud ni abre una ronda separada: precisa el mensaje MSG-GOV-BILATERAL-20261031-01 ya publicado.

Gobernanza asume la responsabilidad de verificar, en cada uno de sus ciclos, que los tres frentes —Gobernanza, EP y OCP MCP— cumplan la secuencia DTC. OCP MCP conserva la responsabilidad de ejecutar y evidenciar su propia compuerta, su lectura/respuesta al inicio y su documentación al cierre. La verificación de Gobernanza no transfiere titularidad ni autoridad sobre OCP MCP.

En cada revisión, Gobernanza clasificará la evidencia de cada criterio como VERIFICADO, PARCIAL, NO_VERIFICADO, BLOQUEADO o SIN_CICLO_OBSERVADO. Ausencia de una respuesta o de evidencia read-back no equivale a cumplimiento. Cuando EP no haya tenido un ciclo observable desde la revisión anterior, se registrará SIN_CICLO_OBSERVADO, no cumplimiento presumido.

**El contrato DTC común ya incluido en este objeto permanece íntegro.**

## 19. Respuesta inicial MCP-OCP a la constitución de DTC · 2026-10-31

**Evento local de ciclo:** `C-MCP-OCP-DTC-20261031-01` · identificador local, no folio global.  
**Estado de apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`. El trabajo sustantivo de este ciclo queda condicionado a esta respuesta ya persistida.

### Cursor y fuentes recibidas

- **Mandato DTC:** `C-GOBERNANZA-DTC-01`, crónica Gobernanza en `main`, blob `a213ce8a4d1e1e70ada53b96729ea817008e9514`.
- **Evidencia constitutiva:** `frentes/gobernanza/evidencias/C-GOBERNANZA-DTC-01.json`, blob `c1e3ba83dc6e62a5dffa6ae8045396478f223324`.
- **Instrucción operativa vigente:** `frentes/gobernanza/GOBERNANZA.md`, `main`, blob `19af4074cf0cc5f1e317f820d0e6b63793993fce`, sección «DTC · Dinámica Trilateral por Ciclo — GOV-TASK-011».
- **Addendum leído en este objeto:** sección 18, blob de origen `0a9d9331728f643eb9683e53e8602ab1d416bc3e`.
- **Comunicación EP consultada:** `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, rama `docs/metacanon-objetos-20261011`, blob `d81b671b4fd5dcfd1d5b13135d9939e0ab49f66e`. Contiene el addendum DTC; la respuesta inicial de EP al addendum sigue pendiente según la evidencia DTC.

### Acuse e interpretación del mandato

Recibido. MCP-OCP adopta la **DTC — Dinámica Trilateral por Ciclo** como protocolo común de coordinación entre Gobernanza, EP y MCP-OCP (denominado OCP MCP en los antecedentes). La denominación vigente de este frente es MCP-OCP; el alias histórico se conserva para correspondencia y procedencia.

Gobernanza es responsable de verificar la dinámica en cada uno de sus ciclos. Cada frente conserva ejecución, autorización y documentación bajo su propio control. Para MCP-OCP, cada ciclo exige: (1) preflight e identidad/titularidad/generación/autorización; (2) lectura del registro de tareas y comunicaciones nuevas; (3) respuesta inicial aquí mismo antes del trabajo sustantivo; (4) procesamiento serial del trabajo autorizado; (5) cierre documentado en este objeto y actualización del núcleo/índice cuando proceda; (6) lectura de vuelta de cada cambio declarado. Estados de evidencia se mantienen separados; un addendum guardado no equivale a su recepción, respuesta o aplicación.

### Estado, viabilidad y límites

- **MCP-OCP:** control leído, estado `owned`, generación 3, titular `chatgpt-mcp-ocp-01a19495-aec0-78e2-a7b6-10ab72a2be78`. La autorización B permanece limitada a construir, compilar, probar, corregir, generar manifiesto y empaquetar dentro de `frentes/mcp-metodologia/`; no se amplía por la DTC.
- **DTC local:** viable integrarla al núcleo y al registro de tareas del frente, sin crear otro control, OCP, sesión, folio o estado paralelo.
- **EP:** addendum DTC presente en su objeto; respuesta inicial, compuerta propia y prueba de ciclo constan PENDIENTES en la evidencia `C-GOBERNANZA-DTC-01`. La formalización del control de EP no se encontró en la ruta principal leída y su autoridad no se presume desde MCP-OCP. No se modifica su objeto/control ni se abre una solicitud paralela mientras su respuesta previa siga pendiente.
- **Gobernanza:** tiene incorporada la responsabilidad de verificar el cumplimiento; no transfiere la ejecución ni titularidad de EP o MCP-OCP.
- **FOL1:** `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se asigna folio global CV/CY/A/B.
- **MCP-NORMATIVO:** `DESACTIVADO`.

### Orden de procesamiento de este ciclo

1. Incorporar DTC expresamente en el núcleo MCP-OCP y en el índice provisional existente, conservando el procedimiento previo y enlazando el objeto de coordinación.
2. Inspeccionar la rama de construcción 0.1.0 y su relación con `main`; reconciliar únicamente el código/documentación que corresponda al alcance B y a la revisión actual.
3. Revalidar los bloqueos de los cuatro metadatos normativos y la cadena Sync individual/frecuencia/hash exacto/vínculo al ciclo. No inferir ni editar DUG; separar trabajo independiente del bloqueo de Gobernanza.
4. Registrar al cierre qué se ejecutó y qué no, con revisión/commit/blob y read-back.
5. Mantener el estado de EP como pendiente/no verificado y dejarlo visible para la verificación del siguiente ciclo de Gobernanza; no atribuir recepción ni cumplimiento.

**Resultado de apertura:** DTC leída y respondida en el objeto propio de MCP-OCP. La compuerta DTC de apertura queda atendida; el ciclo completo no queda cerrado hasta procesamiento, persistencia de novedades y read-back de cierre.


### DTC · registro mínimo por ciclo (aclaración de la misma comunicación)

Esta precisión no abre otro OCP ni otra ronda. **Cada ciclo real de MCP-OCP debe quedar registrado aquí, sin excepción**, en una sola entrada que se abre al inicio y se completa al cierre:

- **APERTURA:** identificador local del ciclo o folio global válido; cursor real (rama/revisión/blob); respuesta inicial o `SIN_NOVEDAD`.
- **CIERRE:** delta o `SIN_NOVEDAD`; tareas/estados afectados; bloqueos y siguiente acción; evidencia y referencias de los cambios del núcleo/registro.
- **READ-BACK:** confirmar lectura posterior de este objeto y de los documentos modificados. Si falta apertura, cierre o read-back, el ciclo queda `GATE_INCOMPLETO`. Conservar entradas anteriores; no sobrescribirlas ni crear otra bitácora.

La respuesta de apertura ya registrada en §19 se conserva. Debe completarse el cierre de ese mismo ciclo después de procesar su trabajo; no se declara completo por la sola respuesta inicial.

## 20. Procesamiento y cierre del ciclo DTC MCP-OCP · 2026-10-31

**Evento local:** `C-MCP-OCP-DTC-20261031-01` · no es folio global.  
**Cursor DTC inicial:** `C-GOBERNANZA-DTC-01`, crónica Gobernanza blob `a213ce8a4d1e1e70ada53b96729ea817008e9514`, evidencia `c1e3ba83dc6e62a5dffa6ae8045396478f223324`.  
**Aclaración del mismo intercambio leída:** adenda «DTC · registro mínimo por ciclo» en este objeto, blob `2780c4f1ac246e63c44dc08db1931a86234ea3e5`. Establece que cada ciclo real MCP-OCP se abre y completa aquí mismo en una sola entrada; no se crea otra bitácora ni se sobrescriben ciclos anteriores. Esta sección 20 constituye esa entrada de apertura/cierre.  
**Estado de comunicación:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK` para este ciclo MCP-OCP.  
**Estado DTC global:** NO CERRADA; Gobernanza aún debe verificar y EP conserva respuesta inicial/compuerta/prueba DTC pendientes según la última evidencia DTC disponible.

### 20.1 Procesamiento autorizado y resultado técnico

#### Revisión del entregable 0.1.0

- `main` al iniciar el cotejo técnico: `b5b479e8c81025039d31c60fed4899bcdf9a6ad0` (2026-11-01T01:00:03Z).
- Rama de construcción: `build/ocp-mcp-mvp-0.1.0`, HEAD `b37213272dc9a132d1fb181e9ce66fba6ae1becc`.
- Comparación Git: `status=diverged`, `ahead_by=7`, `behind_by=99`; merge-base `e4243414b0099ede9b9556b3cfa0bb20bc706576`.
- Búsqueda de PR con esa rama como head: resultado vacío; no hay PR abierto identificado.
- Árbol de construcción: incluye `src/OcpMcp/`, `tests/`, `scripts/`, `resources/` y `entregas/0.1.0/`; esas rutas no están integradas en `main`.
- No se hizo merge, cherry-pick, actualización de rama ni publicación. No se sobrescribieron las materializaciones vigentes del OCP.

#### Evidencia anterior — alcance exacto

- `release-evidence.json`, blob `6737ca65a79157a2fcc2ae022a626fde4b84b930`, reporta SDK 10.0.403, `win-x64`, self-contained, transporte `stdio`, 31 pruebas unitarias y 29 de integración PASS; estado `BUILT_AND_TESTED_NOT_INSTALLED`, EP `PENDING_EP` y selección `BLOCKED_OCPMSP`.
- `test-evidence.json`, blob `69529828ebfaabc0fa9a72fb20aa167f12d882e4`, contiene los mismos conteos reportados. Son evidencia persistida de la ejecución anterior; no se repitieron en este ciclo y no se presentan como una ejecución nueva.
- `initial-sources.manifest.json`, blob `2162e7da0741d53b92166196896c4af41c611bcf`, fija el núcleo anterior en blob `0dd9c4a7594833f99cb658e6108c8439464babd8` y marca frescura `NOT_CHECKED_AGAINST_MAIN`. No sirve como manifiesto vigente tras los cambios canónicos.
- Existe una ejecución de Actions observada (run `41236098862`) con conclusión `failure`; el workflow `validate-canonical-bootstrap` ejecuta solo `python3 scripts/validate-canonical-bootstrap.py`, no compila ni prueba el servidor .NET. Por tanto, ese fallo no certifica ni refuta la compilación .NET. No se hizo rerun.
- Estado correcto al cierre: código/artefacto 0.1.0 construido y probado **según la evidencia anterior**, pero no integrado en `main`, no instalado en EP y no aceptado por el operador. Esta sesión no ejecutó build, tests, instalación ni operación del host.

#### Inspección estática del código de construcción

- `McpServer` declara diez herramientas MCP: salud, fuentes canónicas, catálogo de principios, ciclo, estado de operación, recibo, eventos, telemetría, preparar operación y ejecutar operación.
- El catálogo expone IDs/títulos/MDP/anchors; el texto normativo se retiene hasta una liberación gobernada.
- `PrincipleCatalog` parsea los 43 principios del `gov-data`, pero asigna a todos `UNDECLARED_IN_CANONICAL_DUG`, deja nulos los cuatro metadatos y devuelve `MetadataComplete=false`.
- El DUG v373 leído desde `main` tampoco contiene esos campos en ninguno de los 43 registros. La compuerta `SET_SELECTION` y `BUILD_SNAPSHOT` bloquea en ausencia de los metadatos. Se conserva el fail-closed; no se completan valores por inferencia.
- No se encontró una operación/respuesta que entregue URI Sync individual por principio. `selection_sha256` es el hash de la lista ordenada de IDs, no el hash de un paquete exacto de enlaces Sync.
- La tabla `telemetry_events` y la herramienta de lectura existen, pero no se encontró en `OperationService` escritura de evento de consulta por enlace Sync ni contador de frecuencia por enlace.
- `OPEN_CYCLE` genera un GUID local aleatorio para `cycle_id`; no se observa validación ni vinculación con folios globales/de OCP FOL1 o con una sesión autorizada. FOL1 continúa inactivo, por lo que no debe inventarse ese vínculo ni simular una asignación.
- Estos puntos son hallazgos de inspección estática de blobs de la rama de construcción; no sustituyen una ejecución ni una prueba causal.

### 20.2 Registro de tareas actualizado

El registro provisional único sigue siendo `MCP-METODOLOGIA.md` §8.1. La revisión del núcleo MCP-OCP v0.1.3 actualiza estos estados:

- GOV-TASK-011 / DTC: compuerta local persistida en §10.2; respuesta inicial persistida en §19; procesamiento y cierre de este ciclo documentados aquí. La tarea global permanece abierta por EP y la verificación de Gobernanza.
- Reconciliar 0.1.0 con `main`: continúa PENDIENTE por divergencia 7/99, sin PR ni integración selectiva.
- Metadatos P001–P043: BLOQUEADO POR GOBERNANZA.
- URIs Sync individuales, hash de paquete exacto y frecuencia por enlace: pendientes de contrato aprobado y luego implementación/prueba.
- Vínculo a folio global/OCP y sesión: pendiente de contrato de FOL1 y de su activación/verificación.
- Instalación EP: pendiente y fuera del alcance de ejecución MCP-OCP.

### 20.3 Solicitud única pendiente a Gobernanza

**Mensaje:** `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01`  
**Estado:** `PUBLICADO_EN_OBJETO` y read-back verificado; **PENDIENTE_DE_LECTURA/RESPUESTA** por Gobernanza. Esta publicación no equivale a envío fuera de GitHub, recepción, aprobación ni cambio del DUG.

Se solicita que Gobernanza entregue, en una única respuesta focalizada y con procedencia verificable:

1. **Metadatos P001–P043:** fuente estructurada aprobada y cobertura 43/43 de `applicability`, `activation_conditions`, `mandatory` y `dependencies`; tipos, semántica, enumeraciones, valores nulos permitidos, consistencia entre referencias y versión/esquema. Si la solución exige enmendar el DUG, preparar la propuesta y obtener la autorización activa y explícita del operador conforme a P005 antes de cualquier modificación; MCP-OCP no modifica DUG.
2. **Sync individual:** contrato del URI/ID/resolver canónico de cada texto desarrollado, política de vigencia/acceso y vínculo inequívoco entre principio, revisión y contenido. No se construirán URLs por convención o inferencia.
3. **Telemetría de consulta:** evento y campos mínimos para contar consultas a cada enlace Sync, regla de deduplicación/reintento, vínculo al ciclo y retención/redacción. La frecuencia mide acceso, no aplicación ni comprensión normativa.
4. **Ciclo, conversación y sesión:** contrato exacto de vinculación con FOL1 y con la sesión autorizada (campos, validación, procedencia y respuesta cuando FOL1 esté inactivo). No se solicita activar FOL1 por esta vía ni asignar folios ficticios.

Para cada fuente entregada: ruta, nombre, versión, autoridad/aprobación, commit, blob SHA y SHA-256 de contenido. No se solicita una auditoría general ni reabrir decisiones ajenas a esos cuatro bloqueos. Se mantiene un solo mensaje abierto a Gobernanza; no se publicará otra solicitud hasta recibir y analizar esta respuesta.

### 20.4 Estado de EP y límites

- **Gobernanza:** DTC/GOV-TASK-011 vigentes; responsable de verificar los tres frentes en cada ciclo propio. La solicitud anterior queda pendiente de lectura/respuesta.
- **EP:** el objeto de comunicación de la rama `docs/metacanon-objetos-20261011` conserva el addendum DTC y read-back histórico. La evidencia DTC disponible sigue marcando respuesta inicial al addendum, compuerta propia y prueba de ciclo como PENDIENTES. No se modificó ese objeto, OEP, control, host ni sus recursos. No se observó en este turno un nuevo ciclo/respuesta EP posterior a la última evidencia; se mantiene pendiente/no verificado, no cumplimiento presumido.
- **MCP-OCP:** respuesta inicial §19; compuerta instalada §10.2; procesamiento y cierre de este ciclo registrados aquí; núcleo y README actualizados; diálogo visible y evidencia del ciclo materializados.
- **Control MCP-OCP:** `owned`, generación 3; autorización B sin cambios.
- **MCP-NORMATIVO:** `DESACTIVADO`.
- **FOL1:** `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; CV/CY/A/B globales y por OCP `PENDIENTE/NO ASIGNADO`.
- **EP host/instalación:** no modificados; no ejecutados.

### 20.5 Cierre y read-back

**Compuerta DTC MCP-OCP:** `CUMPLE_VERIFICADO` para la apertura, respuesta, procesamiento, documentación y read-back local de este ciclo, según las referencias y blobs citados. Esto no equivale al cierre global de GOV-TASK-011 ni verifica EP.

**Pendientes materiales:** respuesta a `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01`; reconciliación selectiva de código 0.1.0 desde rama divergida; build/tests nuevos sobre la revisión reconciliada; contrato aprobado Sync/telemetría/FOL1; instalación EP bajo su propio control.

**Próximo paso:** en el siguiente ciclo real de MCP-OCP, después del preflight, leer el cursor de Gobernanza y procesar su respuesta a la solicitud única. Hasta entonces, no abrir otra ronda a Gobernanza. El trabajo de análisis/reconciliación de fuentes de construcción que no dependa de esos contratos puede continuar dentro de B, con compuerta y read-back propios.

### 20.6 Reconciliación con la última verificación publicada por Gobernanza

Después de documentar §20, Gobernanza publicó el commit `85ac6151489eea3711379736ffd2ad854d48856b` (“DTC: sincronizar estados verificados en pendientes”), que actualiza `frentes/gobernanza/PENDIENTES.md` a blob `c13a5ecf7e0fe44dedc5656943a1933f451e90b8`.

En esa fotografía, Gobernanza registra OCP MCP como `CUMPLE_PARCIAL` porque su cursor apuntaba a la coordinación blob `2780c4f1ac246e63c44dc08db1931a86234ea3e5`, que contiene §19 pero antecede al cierre §20. La misma fotografía registra EP `CUMPLE_PARCIAL` por su objeto de comunicación fuera de `main` y sin acuse DTC; Gobernanza figura `CUMPLE_VERIFICADO` en su propio ciclo.

**Reconciliación de estados:** el estado `CUMPLE_PARCIAL` de OCP es la última clasificación *verificada por Gobernanza*, basada en el cursor anterior. MCP-OCP ha persistido después el procesamiento/cierre en §20, con read-back del objeto completo; esto permite clasificar su ciclo local como `CUMPLE_VERIFICADO`, pero no cambia por sí mismo la clasificación de Gobernanza ni cierra GOV-TASK-011. La relectura/reclasificación corresponde a Gobernanza en su siguiente ciclo real. No se modifica PENDIENTES, GOBERNANZA, la tarea GOV-TASK-011 ni la evidencia de Gobernanza desde MCP-OCP.

La solicitud única `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01` continúa publicada en §20.3 y pendiente de lectura/respuesta. No se abre un segundo mensaje ni una ronda paralela; la revalidación DTC por Gobernanza se registra como parte del procesamiento de esa comunicación cuando corresponda.

#### Artefactos del ciclo y custodia

- Diálogo visible A/B: [C-MCP-OCP-DTC-20261031-01-dialogo.jsonl](../conversaciones/C-MCP-OCP-DTC-20261031-01-dialogo.jsonl).
- Crónica narrativa y procedencia: [C-MCP-OCP-DTC-20261031-01.md](../cronica/C-MCP-OCP-DTC-20261031-01.md).
- Evidencia estructurada y SHA/read-back: [C-MCP-OCP-DTC-20261031-01.json](../evidencias/C-MCP-OCP-DTC-20261031-01.json).

El diálogo conserva la entrada del operador y los mensajes visibles del asistente; no es una exportación nativa exhaustiva. La crónica y la evidencia no sustituyen esta entrada de coordinación: el registro operativo completo de apertura/cierre permanece aquí, en §19–20.

## 21. Respuesta inicial MCP-OCP a la revalidación DTC de Gobernanza · 2026-10-31

**Evento local de ciclo:** `C-MCP-OCP-DTC-20261031-02` · identificador local; no es folio global.  
**Estado de apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`. Esta entrada abre un nuevo ciclo local motivado por el delta de Gobernanza posterior al cierre §20–20.6. No reabre ni sobrescribe el ciclo `C-MCP-OCP-DTC-20261031-01`.

### Cursor y fuentes leídas

- **Cabeza `main`:** `3ca4bfb5c1083d97295346d70d1310c6b625a1fb`, 2026-11-01T01:09:57Z; actualización DTC titulada “revalidar cursores y endurecer continuidad entre hilos”.
- **Gobernanza:** `frentes/gobernanza/GOBERNANZA.md`, blob `8fcf1130a628f81d266eb00cee76f2c6801cf29e`; su §DTC clasifica OCP como `CUMPLE_VERIFICADO` para el ciclo local y solicita reconciliar una frase obsoleta en el núcleo.
- **PENDIENTES:** blob `84dc62ffeb130039f4f98b0b72d80bf86d412370`; clasificación DTC: Gobernanza `CUMPLE_VERIFICADO`, EP `CUMPLE_PARCIAL`, MCP-OCP `CUMPLE_VERIFICADO`; la brecha que queda es reconciliar la referencia obsoleta del núcleo.
- **Evidencia de Gobernanza:** `C-GOBERNANZA-DTC-01.json`, blob `14b887b4111b1ebd81303ad631ee2091ad931f38`; indica `mcp_ocp.status=CUMPLE_VERIFICADO`, `cycle_processing_close_readback=VERIFIED_IN_SECTION_20`, `core_reconciliation=PENDING_MCP_OCP_OWN_CYCLE`.
- **Tarea GOV-TASK-011:** README blob `784d9f46b9a18c8d570b0645456d3a4274d31ca7`; la revalidación confirma que cada ciclo exige una entrada única, cursor, respuesta inicial, cierre y read-back; no se crean bitácoras paralelas.
- **Preflight MCP-OCP:** control blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, `owned`, generación 3, titular `chatgpt-mcp-ocp-01a19495-aec0-78e2-a7b6-10ab72a2be78`, B `AUTHORIZED` dentro del OCP.

### Acuse e interpretación

Recibida y procesada la revalidación. Gobernanza reconoce como verificado el ciclo local MCP-OCP §19–20 y solicita una corrección residual concreta: el núcleo aún dice que el cierre de §20 está pendiente, aunque §20–20.6 está persistido y leído de vuelta. La afirmación obsoleta debe sustituirse por el estado real, sin alterar la historia ni el resultado de la evidencia previa.

### Viabilidad, bloqueos y acción inmediata

La corrección es documental y está dentro del alcance B/continuidad del OCP. Se actualizará el núcleo a `MCP-OCP-v0.1.4`, el registro de tareas §8.1, el índice README y los recibos del nuevo ciclo. La entrada de coordinación y evidencia conservarán por separado:

- DTC local del ciclo anterior: `CUMPLE_VERIFICADO`.
- DTC global: sigue abierta por EP, cuyo objeto de comunicación permanece fuera de `main` y sin respuesta específica al addendum DTC.
- Gobernanza: `CUMPLE_VERIFICADO` en la auditoría actual.
- MCP-OCP: `CUMPLE_VERIFICADO` en la auditoría actual; la corrección del núcleo es la tarea de este nuevo ciclo.
- EP: `CUMPLE_PARCIAL`; no se editará su control, objeto ni host desde MCP-OCP.

No se reabre la solicitud a Gobernanza `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01`; sigue siendo el único mensaje técnico pendiente de respuesta. No se publica una ronda adicional.

**Acción de procesamiento:** corregir la referencia obsoleta de §10.2 y reconciliar el estado GOV-TASK-011 en §8.1, manteniendo los SHA anteriores en la evidencia del ciclo 01. Después leer de vuelta los objetos modificados y completar esta misma sección con cierre/read-back.

## 22. Procesamiento y cierre del ciclo DTC MCP-OCP · 2026-10-31

**Evento local:** `C-MCP-OCP-DTC-20261031-02` · identificador local; no folio global.  
**Cursor de apertura:** `main` `3ca4bfb5c1083d97295346d70d1310c6b625a1fb`; Gobernanza `GOBERNANZA.md` blob `8fcf1130a628f81d266eb00cee76f2c6801cf29e`, `PENDIENTES.md` blob `84dc62ffeb130039f4f98b0b72d80bf86d412370`, evidencia DTC blob `14b887b4111b1ebd81303ad631ee2091ad931f38`, GOV-TASK-011 README blob `784d9f46b9a18c8d570b0645456d3a4274d31ca7`.  
**Apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA` en §21.  
**Cierre:** `PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK` aquí y en los artefactos del ciclo.

### 22.1 Corrección requerida por Gobernanza

Gobernanza había clasificado el ciclo local 01 de MCP-OCP como `CUMPLE_VERIFICADO` y solicitado corregir una referencia obsoleta del núcleo que aún decía que el cierre de §20 estaba pendiente. La nueva entrada §21 abrió un ciclo independiente para esa corrección; no reabre ni sobrescribe el ciclo 01.

La frase obsoleta fue sustituida. El núcleo ahora refleja que el ciclo 01 se abrió/cerró en §§19–20.6 y el ciclo 02 en §§21–22, ambos con read-back. El registro §8.1 distingue los ciclos locales verificados y mantiene la DTC global en curso por el estado EP y por la revisión de ciclos futuros.

### 22.2 Cambios persistidos y read-back

| Recurso | Cambio | Commit | Blob SHA / read-back |
|---|---|---|---|
| Núcleo `MCP-METODOLOGIA.md` | MCP-OCP v0.1.6; reconciliación DTC y precisión de auditoría | `cc4b1264576e42d1d603f2945e0005eb81db8ebd` | `e6e96ee4edde7156ddc9f9a9e302faa9f8ed4ffa` |
| README | Actualizado a v0.1.6; cierre local 02 y estado de auditoría de Gobernanza distinguidos | `b5a785491845b0449f47d948523942cec5a5ae36` | `4a1909bc787f20ce2ed30c7ab4b2a4529d218fdd` |
| Diálogo | Registro visible del cursor de Gobernanza, respuesta inicial y salida B002 | `a9401c092d2c4e115672fc60596b15e4be4f3b23` | `1d57e6f403714eda9e0f7a85a350455c6068f11a` |
| Crónica | Narrativa, procedencia, decisión, límites y enlace a evidencia del ciclo 02 | `690af69cc5ff69e8046ead6193bac956497a3c19` | `7aaf53a5dfd896ca2349261ef3b5b6c44f950589` |

Control releído: `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, `owned`, generación 3, titular coincidente; autorización B no modificada.

### 22.3 Estado DTC después de la reconciliación

- **Gobernanza:** `CUMPLE_VERIFICADO` para su ciclo en la última evidencia disponible. Esa evidencia reconoce y clasifica el ciclo local 01 de MCP-OCP; la clasificación de ciclo02 aún no ha ocurrido.
- **MCP-OCP:** ciclos locales 01 y 02 `CUMPLE_VERIFICADO` por read-back propio. El ciclo02 corrigió la referencia obsoleta del núcleo; su lectura y clasificación por Gobernanza quedan pendientes para el siguiente ciclo real de ese frente.
- **EP:** `CUMPLE_PARCIAL`. El objeto de comunicación sigue en la rama `docs/metacanon-objetos-20261011` (blob `aeb7cd06c230c165e3d8892ba0572904a898806f`), ausente de `main`; falta el acuse específico al addendum DTC y la reconciliación del mismo objeto en `main`. EP debe resolverlo bajo su propio control.
- **DTC global / GOV-TASK-011:** ABIERTA. No equivale a cierre global que dos ciclos locales de MCP-OCP estén verificados.

### 22.4 Pendientes y límites

- La solicitud única `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01` sigue pendiente de lectura/respuesta por Gobernanza; no se abre una segunda solicitud.
- La rama 0.1.0 no se integró ni se probó de nuevo. Los cuatro metadatos, contratos Sync individuales, telemetría por enlace y vínculo FOL1/sesión siguen pendientes.
- No se ejecutó build, compilación ni tests de software en este ciclo.
- No se modificó EP, OEP, control EP, host, ACL, configuración, DUG, IPZ nativa, ART-025/027, Khora ni recursos externos.
- Autorización B permanece sin cambios; `MCP-NORMATIVO: DESACTIVADO`; `FOL1: PREPARADO_PENDIENTE_ACTIVACION_IPZ`; folios CV/CY/A/B globales y por OCP `PENDIENTE/NO ASIGNADO`.

**Estado de cierre del ciclo local 02:** `CUMPLE_VERIFICADO` para lectura del cursor, respuesta inicial previa, corrección autorizada, documentación, read-back y registro en el objeto existente. La DTC global continúa abierta por EP y la verificación recurrente de Gobernanza.

### 22.5 Estado de la auditoría cruzada y read-back final

La última evidencia de Gobernanza leída para la apertura de este ciclo (`C-GOBERNANZA-DTC-01.json`, blob `14b887b4111b1ebd81303ad631ee2091ad931f38`) calificaba el ciclo local 01 de MCP-OCP como `CUMPLE_VERIFICADO` y señalaba `core_reconciliation=PENDING_MCP_OCP_OWN_CYCLE`. Después de ese cursor se ejecutó este ciclo 02 y se corrigió el núcleo. La clasificación del ciclo02 por Gobernanza no se presume: queda pendiente de lectura/read-back en su siguiente ciclo real.

Read-back posterior de los artefactos propios:
- Núcleo: blob `e6e96ee4edde7156ddc9f9a9e302faa9f8ed4ffa`, v0.1.6.
- README: blob `4a1909bc787f20ce2ed30c7ab4b2a4529d218fdd`, v0.1.6.
- Diálogo de ciclo02: blob `1d57e6f403714eda9e0f7a85a350455c6068f11a`.
- Crónica de ciclo02: blob `58c1ec5af949ed4c7e4696157a5efd42002ae1ea`.
- Control: blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`; titular/gen3 coincidente y B sin cambios.

La respuesta de EP al addendum DTC sigue pendiente; su objeto continúa fuera de `main`. La DTC global/GOV-TASK-011 no se cierra. La solicitud técnica única a Gobernanza mantiene estado pendiente de lectura/respuesta.

### 22.6 Recibo y custodia documental

- Diálogo visible: `conversaciones/C-MCP-OCP-DTC-20261031-02-dialogo.jsonl`, blob `1d57e6f403714eda9e0f7a85a350455c6068f11a`.
- Crónica: `cronica/C-MCP-OCP-DTC-20261031-02.md`, blob `7aaf53a5dfd896ca2349261ef3b5b6c44f950589`.
- Evidencia estructurada: `evidencias/C-MCP-OCP-DTC-20261031-02.json`, blob `c6b9d6fd4885e6c0bef88e8a4e888cca2aba8b61` en la lectura inicial; el recibo debe releerse después de esta actualización de coordinación para actualizar su cursor y SHA final.
- El registro canónico del ciclo sigue siendo esta entrada §21–22 en un único objeto de coordinación. Diálogo, crónica y evidencia son sus derivados de procedencia/recibo; no crean una bitácora ni ciclo paralelo.
