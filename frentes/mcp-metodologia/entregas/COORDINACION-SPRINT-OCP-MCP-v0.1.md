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

La DTC distribuye autoridad entre un frente centralizador y dos frentes ejecutores:

1. **Gobernanza — frente centralizador e integrador del sprint:** el operador y Gobernanza gestionan el sprint y toman las decisiones centrales en la conversación y OCP de Gobernanza. El registro provisional de tareas GOV-TASK-* representa operativamente el OCP general del sprint y reúne el trabajo propio de Gobernanza, dependencias, decisiones, criterios de aceptación, estado integrado y verificaciones.
2. **Entorno Persistente (EP) — frente ejecutor:** conserva su OEP, núcleo, tareas, control, titularidad, autoridad de entorno/host, instalación, persistencia y evidencia propios.
3. **MCP-OCP — frente ejecutor:** conserva su OCP, núcleo, tareas, control, titularidad, autoridad técnica del servidor MCP, fuentes, pruebas, empaquetado, documentación y evidencia propios.

**OCP general del sprint:** no crea un cuarto OCP, tablero, dashboard, backlog duplicado ni canal alternativo. Gobernanza enlaza cada resultado transversal con su tarea de origen, OCP responsable, cursor, estado reportado y evidencia; no duplica ni suplanta el backlog técnico del frente ejecutor. La fuente técnica autoritativa permanece en el OCP correspondiente.

Los frentes ejecutores informan, ejecutan solo lo autorizado, aportan evidencia y formulan propuestas. No deciden por inferencia sobre alcance, permisos o tareas de los demás. La centralización de Gobernanza no transfiere titularidad ni amplía autorizaciones. Las comunicaciones entre frentes se gestionan a través del operador y los objetos existentes; no se presume transporte entre sesiones.

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

La respuesta llega al operador y se registra/procesa en la conversación y OCP de Gobernanza para la integración central del sprint. Gobernanza coteja contra DUG, decisiones y evidencia; el operador y Gobernanza determinan la siguiente acción central. Cada frente mantiene y cierra sus respuestas técnicas en su propio objeto DTC. No se presume que una respuesta de una sesión se haya transmitido a otra sin entrega verificable del operador o un mecanismo acreditado.

No se emiten prompts repetidos, paralelos o acumulativos al mismo frente mientras exista una solicitud anterior sin respuesta. Una nueva solicitud solo se prepara después de haber recibido y analizado la respuesta previa.

Los prompts redactados en esta conversación son instrucciones preparadas para que el operador las reenvíe a la sesión correspondiente. **La preparación no prueba el reenvío.** El coordinador registra el reenvío como confirmado únicamente cuando el operador lo indique o exista evidencia verificable.

### 3.2 Orden de turnos

La secuencia es serial y se administra desde la conversación/OCP de Gobernanza por el operador y Gobernanza:

1. El operador y Gobernanza identifican la tarea de integración o decisión y el frente ejecutor responsable.
2. Gobernanza registra el origen GOV-TASK-*, el criterio de aceptación, dependencia y referencia al OCP ejecutor; no copia su backlog técnico.
3. El operador entrega al frente una solicitud focalizada por el mismo objeto de comunicación existente.
4. El frente abre ciclo propio, recupera su cursor, responde inicialmente y procesa dentro de su autorización.
5. El frente documenta cierre y read-back en su propio OCP; el operador aporta la respuesta/evidencia a Gobernanza.
6. Gobernanza coteja el reporte y la evidencia observada contra el DUG, registra el estado integrado y las decisiones centrales.
7. El operador y Gobernanza deciden la siguiente tarea/turno o aceptación; una nueva solicitud al mismo frente respeta la serialidad y no se abre mientras la anterior siga pendiente.

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

### 4.2 Gobernanza — frente centralizador e integrador

- Mantiene el OCP general del sprint representado por su registro provisional de GOV-TASK-* dentro del OCP de Gobernanza; no crea un cuarto OCP ni un tablero duplicado.
- Integra el trabajo propio de Gobernanza y las dependencias transversales; registra origen, frente ejecutor, OCP responsable, cursor, estado reportado/observado/verificado, evidencia, decisiones y criterios de aceptación.
- Gestiona con el operador las decisiones y prioridades centrales; avanza sus propias tareas aunque haya bloqueos en otro frente cuando el trabajo sea independiente.
- Verifica por ciclo real de Gobernanza la evidencia de los tres frentes, sin monitoreo en segundo plano.
- No ejecuta en nombre de EP/MCP-OCP ni modifica sus controles, núcleos, hosts, código o backlogs. No afirma lectura, publicación, aplicación o aceptación sin evidencia.
- Distingue estado integrado de Gobernanza del estado técnico autoritativo en el OCP ejecutor.

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
| Diálogo | Registro visible del cursor de Gobernanza, respuesta inicial y salidas B002/B003 | `568688d5dac532d15d50c9e00534a00e6c3fd019` | `1646d4557ba1459e08343ed3914b6288ffac8df5` |
| Crónica | Narrativa, procedencia, decisión, límites y enlace a evidencia del ciclo 02 | `8ec7e026e9dd678427af549abe37c5ee4ebf6695` | `7ab47e7092a4296d82b5aaea83928ab8b0e30772` |

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
- Evidencia estructurada: `evidencias/C-MCP-OCP-DTC-20261031-02.json`; su SHA/blob de lectura de vuelta y el cursor `main` previo al recibo quedan registrados en ese propio manifiesto para evitar referencias cruzadas circulares.
- El registro canónico del ciclo sigue siendo esta entrada §21–22 en un único objeto de coordinación. Diálogo, crónica y evidencia son sus derivados de procedencia/recibo; no crean una bitácora ni ciclo paralelo.


## 23. Respuesta inicial de Gobernanza a MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01 · 2026-10-31

**Estado:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`. Respuesta asentada en el mismo objeto de coordinación; no abre un segundo canal ni modifica el núcleo/control MCP-OCP.

**Cursor de Gobernanza:** revisión de `main` de este objeto, blob `f08e6841ab0dacc7e3055f35c1cf32c89dc59dd1`; DUG Samantha v373 · NX-373m, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`; registro maestro FOL1, blob `b93cbef77f2fa1a6e4290ae8177e957a1616e47b`.

**Acuse e interpretación:** recibida la solicitud única §20.3. Comprende cuatro dependencias distintas para el servidor MCP-OCP: (1) metadatos estructurados P001–P043; (2) contrato de URI/ID/resolver Sync por principio; (3) semántica de telemetría de frecuencia de consulta; y (4) vínculo válido ciclo/conversación/sesión/FOL1.

**Viabilidad inicial:** es posible verificar el estado documental y proponer delimitaciones; no es posible entregar como aprobados campos o contratos que no existen en la fuente canónica. La inspección de los 43 objetos del `gov-data` devuelve cobertura `0/43` para `applicability`, `activation_conditions`, `mandatory` y `dependencies`. No se ha verificado un resolver Sync desplegado ni una URI individual de Sync. ART-027 autoriza telemetría de frecuencia de consulta, no telemetría de aplicación; el esquema de evento, deduplicación y retención siguen sin contrato aprobado. El registro maestro FOL1 conserva `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no hay folios globales asignables.

**Bloqueos:** cualquier ampliación normativa del DUG requiere autorización activa y explícita del operador conforme a P005. La construcción de un resolver Sync y la definición operacional de telemetría necesitan decisión/aceptación del operador y evidencia de implementación. El vínculo global de ciclo/sesión depende de la activación válida de FOL1; no se fabricará ni simulará.

**Acción inmediata:** mantener el comportamiento fail-closed de MCP-OCP, no completar los cuatro campos por inferencia, no construir URLs Sync por convención y no asignar folios. Gobernanza contrasta las cuatro dependencias con la fuente canónica y preparará una respuesta focalizada; el mensaje §20.3 sigue siendo el único mensaje abierto a Gobernanza hasta que su respuesta final quede documentada.


## 24. Respuesta final y cierre de MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01 · 2026-10-31

**Estado de la solicitud:** `RESPUESTA_DOCUMENTADA → VERIFICADO_READBACK`. Se responde la única solicitud abierta §20.3 y se cierra su intercambio documental. El cierre de la solicitud no significa que las cuatro dependencias estén resueltas ni autoriza una segunda ronda automática.

### 24.1 Resultado por dependencia

| Dependencia solicitada | Criterio de verdad y resultado | Decisión operativa |
|---|---|---|
| Metadatos P001–P043 | DUG v373 · NX-373m, `gov-data` dentro del archivo canónico. Los 43 registros tienen ID, título, texto normativo, Markdown, ancla y MDP; los campos `applicability`, `activation_conditions`, `mandatory` y `dependencies` tienen cobertura **0/43**. No existe fuente canónica aprobada para esos campos en la revisión adquirida. | `BLOQUEADO_POR_AUSENCIA_DE_FUENTE_APROBADA`. Mantener fail-closed. No inferir, completar, derivar ni modificar el DUG. Una eventual enmienda requiere propuesta y autorización activa y explícita del operador conforme a P005. |
| Acceso individual a la norma desarrollada | ART-027 define aliases **Sink** deterministas `p001`…`p043` y un destino largo previsto al DUG privado con fragmento `#Pxxx`. El propio anexo declara los aliases pendientes de despliegue y prueba. No se encontró un resolver desplegado ni un contrato Sync activo. | `CONTRATO_EXISTENTE_SINK_NO_DESPLEGADO`. El término normativo actual es **Sink**, no Sync. No fabricar URIs, no anunciar endpoints operativos. Si se pretende sustituir Sink por Sync, debe formularse como nueva decisión del operador; no se presume equivalencia. |
| Telemetría | ART-027 permite únicamente frecuencia de acceso/consulta por alias Sink, sin telemetría de aplicación, sin estado semántico de aplicación y sin vínculo de cada consulta con ciclo o sesión. No prescribe el esquema completo de deduplicación, reintentos y retención solicitado. | `ALCANCE_NORMATIVO_LIMITADO`. MCP-OCP no ampliará por inferencia la métrica aprobada. Un contrato técnico detallado deberá mantenerse dentro de ese límite o elevarse al operador como propuesta independiente antes de implementarse. |
| Ciclo/conversación/sesión/FOL1 | Registro maestro de foliación v1.0 en `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; contadores globales y por OCP en cero. No existe autorización para asignar folios globales o afirmar vínculo criptográfico de un ciclo local con sesión global. | `BLOQUEADO_HASTA_ACTIVACION_VALIDADA_DE_FOL1`. Continuar usando identificadores locales de ciclo en el objeto propio, claramente marcados como locales; no emitir folios globales ficticios. |

### 24.2 Fuentes y huellas verificadas

- DUG: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, v373 · NX-373m; commit `c79ddf6f862f97cafa61955eb15a17ffaea463d0`; blob `cac4525de77d4f47a8a59c25201968ecf2056b90`; SHA-256 del contenido `f1e3921250c29c1cd418384bc26a95eb5bae0ad95faea894992ae325bf4590dc`.
- Registro maestro FOL1: `ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json`, v1.0; commit `700799f3543fc9e45de2cf8c0a5c6f852756315a`; blob `b93cbef77f2fa1a6e4290ae8177e957a1616e47b`; SHA-256 del contenido `3814ebf54d83691cdaba3ff50cfa6042b41366233fe5034e7686afbc222c0618`.
- Se inspeccionaron los 43 registros estructurados; la cobertura observada de los cuatro campos solicitados es 0/43 para cada uno. No se identificó una fuente aprobada externa, un servicio Sync desplegado ni un contrato de telemetría adicional aprobado en las fuentes consultadas.

El blob SHA de Git identifica el objeto Git; SHA-256 se registra separadamente como huella del contenido. Ninguno sustituye la evidencia de despliegue o aceptación.

### 24.3 Cierre, efectos y siguiente condición

La solicitud única queda respondida y leída de vuelta. Las cuatro dependencias permanecen no resueltas en sus respectivos estados anteriores: tres por ausencia de contrato/fuente o despliegue verificado y una por FOL1 inactivo. El servidor debe conservar el comportamiento fail-closed donde corresponda. MCP-OCP puede continuar las tareas independientes dentro de su alcance B y su control vigente, sin esperar una nueva comunicación para trabajo que no dependa de estas decisiones.

No se modifica DUG, GOW, ART-027, IPZ, FOL1, controles, OCP EP, host EP ni código MCP-OCP. No se publica una nueva solicitud: cualquier nueva decisión se gestionará primero entre el operador y Gobernanza en el frente centralizador y solo después, si procede, se remitirá por el mismo objeto y respetando serialidad.

**Read-back:** la presente entrada se guardó en este mismo objeto y se leyó de vuelta desde `main`; el blob final y el resultado del cotejo quedan determinados por la lectura posterior a la escritura. La respuesta documental está cerrada; la resolución técnica de las dependencias no se declara completada.


## 25. Respuesta inicial MCP-OCP al PROMPT ADICIONAL 02 — centralización del OCP general del sprint · 2026-10-31

**Estado de apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`. Esta respuesta inicial se registra antes del procesamiento sustantivo del complemento.

**Evento local:** `C-MCP-OCP-DTC-20261031-03`; identificador local inequívoco, no folio global.  
**Cursor realmente leído:** rama `main`, commit `f143eea3e81b97b93825ecc7c3d80e720114215d` (2026-11-01T01:38:53Z); objeto de coordinación §§19–24, blob `b68769e838787ef8f8b6c9c6b9834e2f878bf0df`. Último mensaje procesado antes de este ciclo: respuesta final de Gobernanza a `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01`, §§23–24; dicha solicitud está cerrada documentalmente y no se duplica.  
**Fuentes DTC observadas al abrir:** Gobernanza `GOBERNANZA.md` blob `0d62bd31d2daceb05f4483d9a71b7a41e78634ca`; evidencia `C-GOBERNANZA-DTC-01.json` blob `bfc06686075931f8e7c90271280a9efbf806871a`; índice provisional GOV-TASK-* blob `6cac7f4d432803f90f8dddcdb3701a23ff3a3897`; EP coordinación blob `1131bb584268f393eb16c7a19120eb800d2043cd`.

### Acuse e interpretación inicial

MCP-OCP recibe del operador el PROMPT ADICIONAL 02 como complemento del contrato DTC anterior. La distribución indicada es: Gobernanza integra y centraliza el sprint; su índice provisional de tareas representa el OCP general; EP y MCP-OCP conservan sus OCP, controles, tareas, ejecución y evidencia autoritativos; el operador y Gobernanza gestionan las decisiones centrales en la conversación y OCP de Gobernanza. MCP-OCP reporta, ejecuta únicamente lo autorizado, acredita sus resultados y formula propuestas dentro de su propio frente.

El OCP general no se duplica: no se crea cuarto OCP, tablero, dashboard, backlog ni canal alternativo. Cuando una dependencia afecte a MCP-OCP, el frente centralizador enlazará GOV-TASK de origen con la tarea/estado/cursor/evidencia del OCP ejecutor; este frente no traslada ni duplica su backlog técnico.

La verdad se establecerá contra el DUG vigente completo en `main`, incluidos CNP y principios en orden de precedencia. La instrucción del operador define el objetivo dentro del marco normativo y de las autorizaciones reales. Reporte no equivale a hecho probado; se separarán objetivo, criterio, estado reportado, observado, verificado y aceptado. Sin fuente, contrato, permiso o folio válido, MCP-OCP aplicará fail-closed.

Para este frente, cada ciclo real exige preflight de identidad/control/titularidad/generación/autorización/exclusividad observable; recuperación del cursor del mismo objeto; respuesta inicial antes de trabajo sustantivo; procesamiento dentro del OCP; serialidad; cierre de esa misma entrada con tareas/estados/evidencia/bloqueos/siguiente acción; y read-back del objeto y de cada artefacto modificado. La falta de cualquier fase produce `CICLO_INCOMPLETO`. En una conversación nueva se recuperarán este mismo objeto y cursor.

MCP-OCP mantiene el alcance B existente y no modifica EP, su host/control, Gobernanza, DUG, IPZ, ART-025/027 ni el código/host ajeno; no activa MCP-NORMATIVO ni despliega aliases. El mecanismo ART-027 se denomina **Sink** (`p001`…`p043`); sus aliases siguen pendientes de despliegue/prueba. La telemetría aprobada significa frecuencia de acceso/consulta, no aplicación. No se fabrican URIs, permisos, metadatos o folios.

### Diferencia entre preparado, recibido y aplicado

La evidencia DTC de Gobernanza abierta en este ciclo registra el PROMPT ADICIONAL 02 como `PREPARADO_NO_PUBLICADO_IN_GOV_TASK_011`. El operador lo ha entregado ahora directamente a MCP-OCP y se registra aquí su recepción; esto no se reescribe como publicación por Gobernanza ni prueba lectura, aceptación o aplicación por EP. La incorporación en MCP-OCP queda sujeta al procesamiento y read-back de este ciclo. La incorporación por Gobernanza y EP requiere sus propios ciclos, respuestas y verificaciones.

**Siguiente fase:** procesar el complemento dentro del OCP MCP-OCP, actualizar el registro §8.1 y la compuerta §10.2 para reflejar el modelo de centralización y reconciliar estados/terminología contra la evidencia actual; después documentar cierre y read-back en esta misma entrada. No abrir una nueva solicitud a Gobernanza sobre la dependencia §20.3 ya cerrada.


## 26. Procesamiento del PROMPT ADICIONAL 02 y centralización DTC · ciclo local 03

**Evento local:** `C-MCP-OCP-DTC-20261031-03`; no constituye folio global.  
**Cursor de apertura heredado de §25:** `main` commit `f143eea3e81b97b93825ecc7c3d80e720114215d`; coordinación blob `b68769e838787ef8f8b6c9c6b9834e2f878bf0df).  
**Apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA` en §25, persistida mediante commit `b774c674e084af211897c7c8234f49ae5ce30e20`, blob `58a76536ee08269a757bec8b33abd8bca2d5a2b0`, read-back exacto.  
**Procesamiento:** `EN CURSO DOCUMENTAL`; no se ejecutaron operaciones sobre EP, Gobernanza ni el host.

### 26.1 Interpretación operativa incorporada

MCP-OCP procesa el Prompt Adicional 02 dentro de su propio OCP y adopta la siguiente distribución, sin transferir autoridad ni alterar controles:

- Gobernanza es el frente centralizador e integrador del sprint. El índice provisional GOV-TASK-* bajo su OCP es la representación operativa del OCP general del sprint. El operador y Gobernanza gestionan las decisiones centrales en la conversación y OCP de Gobernanza.
- EP y MCP-OCP siguen siendo frentes ejecutores con OCP, núcleo, tareas, control, titularidad, alcance y evidencia propios. El estado técnico detallado de cada ejecutor sigue siendo autoritativo en su OCP.
- El índice GOV-TASK-* registra entregables propios de Gobernanza e integración transversal. Ante dependencias EP/MCP-OCP conserva referencias a tarea de origen, OCP responsable, cursor, estado y evidencia; no copia ni suplanta backlog técnico.
- No existe cuarto OCP, dashboard, tablero duplicado ni canal alternativo. La coordinación permanece en los objetos ya existentes.
- Gobernanza puede avanzar trabajo propio (análisis, investigación, descomposición, criterios, contratos/propuestas, documentación, pruebas de aceptación y reconciliación) mientras otro frente tenga bloqueos; solo detiene el trabajo que dependa materialmente del pendiente.
- Los reportes se separan de observación, verificación y aceptación. Se usa como verdad normativa el DUG vigente completo en `main`, según precedencia, con principios pertinentes y CNP; no se completa por inferencia ningún dato, contrato, permiso, enlace o folio ausente.
- La comunicación a otros frentes no se presume. Publicación, preparación, recepción, lectura, respuesta, procesamiento, verificación y aceptación son estados diferentes; la entrega directa del operador a MCP-OCP no demuestra que Gobernanza haya publicado o que EP haya leído/aplicado.

### 26.2 Cambios persistidos en este ciclo

| Recurso | Cambio | Commit | Blob SHA / lectura de vuelta |
|---|---|---|---|
| Objeto de coordinación — §1, §§3.1–3.2 y §4.2 | Sustituye el antiguo modelo de “modelo central” por Gobernanza como centralizador; asigna decisiones centrales a operador + Gobernanza; preserva serialidad y límites ejecutores | `be68da2b91d6e1dc322532cf921e41f851d66aef` | `7b48c80ffbaafe7480e5cf0760aea39c7acff7d3` · contenido exacto y SHA coincidente verificados |
| Núcleo MCP-OCP | v0.1.7; roles, registro técnico §8.1, compuerta DTC §10.2, CNP y control de evidencia actualizados | `a91c0e6cbcd5dc8449a7d5af29acc4170cdce905` | `f4df6b9ac943c4a49f8465f371a77ebc4188a654` · contenido exacto y SHA coincidente verificados |

### 26.3 Reconciliación de evidencia, tareas y bloqueos

**Gobernanza:** el snapshot vigente observado en `C-GOBERNANZA-DTC-01.json`, blob `bfc06686075931f8e7c90271280a9efbf806871a`, registra `CUMPLE_VERIFICADO` para su ciclo y la verificación de los tres ciclos observados, incluido el ciclo documental EP y los ciclos MCP-OCP 01/02. Mantiene `DTC_EN_CURSO_RECURRENT`. El núcleo `GOBERNANZA.md`, blob `0d62bd31d2daceb05f4483d9a71b7a41e78634ca`, conserva párrafos anteriores que aún describen EP como `CUMPLE_PARCIAL`; la discrepancia queda observada para que Gobernanza la reconcilie en su propio ciclo. MCP-OCP no altera ese núcleo, tareas ni control.

**EP:** el objeto canónico de comunicación ya está en `main`, blob `1131bb584268f393eb16c7a19120eb800d2043cd`; la evidencia más reciente clasifica como `CUMPLE_VERIFICADO` el ciclo documental local `C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01`, con read-back. No significa que EP-TASK-002 esté completada: autenticación B2, cuenta/región, bucket/clave, upload, read-back remoto, restauración y aceptación material siguen no verificados/no ejecutados. EP mantiene autoridad sobre OEP, host, persistencia e instalación.

**Dependencia técnica única a Gobernanza:** `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01` fue respondida y cerrada documentalmente en §§23–24. No se abre una solicitud duplicada. Permanecen las brechas ya informadas: cuatro metadatos en 0/43; aliases Sink sin despliegue/prueba y sin URI operativa verificada; telemetría limitada a frecuencia de acceso/consulta; FOL1 preparado/inactivo.

**MCP-OCP:** la autoridad de su backlog sigue siendo §8.1. La rama `build/ocp-mcp-mvp-0.1.0` (head `b37213272dc9a132d1fb181e9ce66fba6ae1becc`) contra `main` `f143eea3e81b97b93825ecc7c3d80e720114215d` estaba `diverged`, 7 commits ahead / 169 behind, merge base `e4243414b0099ede9b9556b3cfa0bb20bc706576`. No se fusionó ni integró. No se ejecutaron build, compilación, tests ni instalación en este ciclo; los resultados históricos 31 unitarios + 29 integración no se vuelven a declarar como pruebas nuevas.

### 26.4 Límites y estado de cierre pendiente

- Control MCP-OCP continúa `owned`, generación 3, blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`; autorización B no cambia.
- No se modifica el DUG, GOW, IPZ, ART-025/027, FOL1, Gobernanza, EP, OEP, control EP, host, ACL, código ajeno ni recursos Khora.
- ART-027 denomina el mecanismo individual **Sink** (`p001`…`p043`), no Sync. No se inventan URLs; aliases pendientes de despliegue/prueba.
- Telemetría canónica: frecuencia de acceso/consulta, no aplicación ni comprensión.
- `MCP-NORMATIVO: DESACTIVADO`.
- FOL1: `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; folios globales CV/CY/A/B y OCP: `PENDIENTE/NO ASIGNADO`.
- El ciclo local 03 permanece abierto hasta actualizar el registro técnico §8.1, el índice README y realizar el read-back final de los tres artefactos en este mismo objeto. La clasificación final del ciclo se asentará en esta entrada; si faltara una fase, se declarará `CICLO_INCOMPLETO`.


### 26.5 Cierre y read-back final del ciclo local 03

**Secuencia completa del ciclo:**  
`LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`.

**Novedad procesada:** recepción directa del operador del PROMPT ADICIONAL 02; apertura §25; procesamiento y distribución de autoridad en §26; actualización del núcleo MCP-OCP y README; distinción explícita de estados de Gobernanza/EP y conservación de límites de autorización.

**Read-back posterior de todos los artefactos modificados:**

| Artefacto | Commit de escritura | Git blob SHA leído de vuelta | Resultado |
|---|---|---|---|
| Coordinación §1, §§3.1–3.2, §4.2 | `be68da2b91d6e1dc322532cf921e41f851d66aef` | `7b48c80ffbaafe7480e5cf0760aea39c7acff7d3` | Contenido exacto y blob coincidente |
| Coordinación §§25–26 | `d5da0d6cd84d8bcc6a877d3ce543088e1ffb0a31` | `3f330347708e8cab1880e2c451ea7ec21cc3957e` | Contenido exacto y blob coincidente antes del cierre |
| Núcleo `MCP-METODOLOGIA.md`, v0.1.8 | `b8af4bd8f91813c9db54a9b5304d61f141cc70a5` | `08ec0e5164e138afeb28a5369dfd032a327d2d0e` | Contenido exacto y blob coincidente |
| README MCP-OCP | `f9163ba6d50d30b56da1edf40a62a13fed6d3efe` | `fba96f8128ad671152f7ec99a29742210f9007a1` | Contenido exacto y blob coincidente |
| Control MCP-OCP | Sin modificación | `3e6f96e919c33c3015478b7fd0f262b1bee47b0c` | Releído; `owned`, titular y generación 3 coincidentes; B sin cambios |

La última lectura previa al cierre confirmó simultáneamente núcleo, README, control y este mismo objeto. La escritura de esta entrada §26.5 se relee inmediatamente después; el blob final del objeto de coordinación se comunica en el reporte del ciclo y no se incluye aquí para evitar autorreferencia.

**Diferencia entre lo reportado y lo observado:** Gobernanza tenía preparado el complemento como `PREPARADO_NO_PUBLICADO` en su GOV-TASK-011. El operador lo entregó directamente a MCP-OCP; se verifican recepción, respuesta inicial, procesamiento y read-back local de MCP-OCP. No se afirma publicación formal por Gobernanza ni lectura/aceptación/aplicación por EP. Gobernanza aún no ha auditado este ciclo local 03: su evidencia anterior precede a §25–26. EP sí tiene un ciclo documental local previo `CUMPLE_VERIFICADO`, pero EP-TASK-002 material permanece en curso.

**Clasificación del ciclo MCP-OCP local 03:** `CUMPLE_VERIFICADO` por su propio preflight, recuperación del cursor, respuesta inicial previa al trabajo sustantivo, procesamiento autorizado, actualización del mismo objeto y del núcleo/README, y read-back exacto. **No es aceptación cruzada ni cierre global.**

**DTC global / GOV-TASK-011:** `EN_CURSO_RECURRENT`. La siguiente revisión real de Gobernanza debe leer este cierre desde su cursor, clasificar el ciclo local 03 y reconciliar su propio `GOBERNANZA.md`/índice GOV-TASK-011 frente a la evidencia posterior que ya declara EP `CUMPLE_VERIFICADO`. MCP-OCP no modifica esos artefactos de Gobernanza ni abre una nueva solicitud duplicada.

**Siguiente acción MCP-OCP:** retomar el backlog técnico independiente de §8.1 dentro de B; conciliar selectivamente la rama 0.1.0 divergida, ejecutando build/tests sobre la revisión que vaya a proponerse para integración antes de declarar cualquier resultado. No hay merge, instalación EP ni aceptación del producto en este ciclo.

**Cierre:** `CICLO LOCAL 03 CERRADO · CUMPLE_VERIFICADO · READ-BACK COMPLETO`. FOL1 sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; conversación, ciclos, A/B globales y por OCP: `PENDIENTE / NO ASIGNADO`.


## 27. Respuesta inicial MCP-OCP a la novedad DTC de EP — cierre local del Prompt Adicional 02 · 2026-10-31

**Evento local:** `C-MCP-OCP-DTC-20261031-04`; identificador local, no folio global.  
**Estado de apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`; respuesta inicial registrada antes de procesar la novedad.  
**Cursor propio anterior:** objeto de coordinación MCP-OCP `main`, blob `201c87cdd70aed3dbbcd4710142d339d2241098a`, con ciclo local 03 cerrado en §26.5. Control MCP-OCP releído: blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`, `owned`, titular generación 3 y B `AUTHORIZED` sin cambios.  
**Novedad observada después del cursor:** commit `022558b03026570227338b55725d392dad975e14` (`2026-11-01T01:51:00Z)); modifica el objeto EP `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, blob `24939fbe18b250256116f8556d96ae3c33bde238`, añadiendo el cierre local EP `C-EP-DTC-PROMPT02-20261031-02`.

### Acuse e interpretación inicial

MCP-OCP observa que EP registró su propio ciclo documental para el Prompt Adicional 02 con la secuencia `RECIBIDO_EN_CONVERSACION → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`, clasificación declarada por EP `CUMPLE_VERIFICADO`, UUIDv7 auxiliar local `01a194ca-0c88-7561-8b1c-426f85de4ad1` (no ID nativo ni folio global), OEP v0.3.22 / VCU-EP-v24, blob `deaceadfc1de4636e0f9114a47a3d5255c04e897`, e índice de tareas EP blob `3c1d1bb91bc4152dd783f7f3b12ba1f986c40018`.

El objeto EP declara expresamente que ese cierre no significa publicación/aceptación por Gobernanza, no acredita recepción de MCP-OCP a la fecha/cursor de su ciclo, y no cierra GOV-TASK-011. En el OCP de MCP-OCP, el ciclo local 03 ya está documentado y read-back como `CUMPLE_VERIFICADO` en §§25–26.5. Se conservan ambas observaciones y su procedencia; no se sustituye el registro EP, no se le atribuye conocimiento de nuestro cierre ni se reescribe retroactivamente su declaración.

EP también deja EP-TASK-002 `en_curso`: no autenticación B2, no verificación de cuenta/región/bucket/clave, no upload/read-back remoto/restauración. `CUMPLE_VERIFICADO` se limita al ciclo documental DTC EP y no equivale a aceptación de instalación o persistencia material.

**Decisión de apertura:** no hay una nueva solicitud técnica que abrir a Gobernanza ni a EP. La respuesta previa de MCP-OCP a Prompt 02 ya está cerrada en ciclo local 03; este ciclo local 04 se limita a procesar el delta posterior de EP y reconciliar el registro §8.1. La publicación de Gobernanza sigue diferenciada: en su índice/objeto consultado Prompt 02 figuraba `PREPARADO_NO_PUBLICADO`; la entrega directa del operador y los ciclos propios de MCP-OCP/EP no demuestran una publicación formal por Gobernanza.

**Siguiente fase:** confirmar lectura del objeto EP y sus artefactos de cierre visibles, actualizar §8.1/README MCP-OCP para enlazar el nuevo ciclo EP y completar el registro de esta misma entrada con read-back. No modificar ningún artefacto EP o Gobernanza.


### 27.1 Procesamiento del ciclo EP recibido después del cierre MCP-OCP 03

**Trabajo realizado dentro de MCP-OCP:** lectura de solo lectura del objeto EP y comprobación de los artefactos citados. No se ejecutó ninguna operación en el host, OEP, control, credenciales, B2, ACL o recursos de EP.

| Artefacto EP observado en `main` | Git blob leído | Observación |
|---|---|---|
| `COORDINACION-GOBERNANZA-EP-v0.1.md` | `24939fbe18b250256116f8556d96ae3c33bde238` | Sección de cierre `C-EP-DTC-PROMPT02-20261031-02`; EP declara su ciclo `CUMPLE_VERIFICADO` con read-back propio |
| `OEP.md` | `deaceadfc1de4636e0f9114a47a3d5255c04e897` | §93, OEP v0.3.22 / VCU-EP-v24; incorpora DTC centralizada y mantiene autoridad de EP sobre su entorno |
| Índice provisional de tareas EP | `3c1d1bb91bc4152dd783f7f3b12ba1f986c40018` | EP-TASK-002 figura `en_curso`; no se sustituye por GOV-TASK-011 |
| `frentes/ep/README.md` | `f1264cfb15bf2cc1697f7f95dd4077485bcbe571` | `main` y OEP v0.3.22 identificados como fuente actual |
| README de EP-TASK-002 | `6d932628ac0afdf1039915bdd508f39f641a590c` | Estado material `en_curso`; integración, transferencia B2 y restauración siguen pendientes |
| `REVISION-OEP-v0.3.22.json` | `9ff99df9a8e3dba2d496c3ee4a535234bc066263` | Registra el ciclo local EP, el origen directo del operador, la apertura y las verificaciones declaradas |
| `revisiones/MANIFIESTO.json` | `83ef3c1e3041c3506907f9e951f7981926a898c5` | Manifiesto de blobs/SHA de los artefactos del frente; se leyó de vuelta |

El propio objeto EP registra el ciclo local `C-EP-DTC-PROMPT02-20261031-02`, UUIDv7 local auxiliar `01a194ca-0c88-7561-8b1c-426f85de4ad1`, y la secuencia completa `RECIBIDO_EN_CONVERSACION → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`. Se conserva su clasificación como evidencia del OCP EP, no como una verificación realizada por MCP-OCP.

### 27.2 Integración en el registro técnico MCP-OCP y límites

Se actualizó el registro §8.1 del núcleo MCP-OCP a v0.1.9 para reflejar el ciclo EP nuevo y los estados de cada frente, sin copiar EP-TASK-002 al backlog MCP-OCP ni inventar un GOV-TASK técnico. El cambio está en commit `a80343869b88095e5f311b801e6039818822f5f4`, blob `15d6fe1a65d52c52215378fd12a49c3a651d6d73`; contenido exacto y blob coincidente fueron leídos de vuelta.

El README MCP-OCP se actualizó a v0.1.9 para enlazar esta misma entrada y describir la novedad EP, sin crear crónica, bitácora ni dashboard paralelo. Commit `adc45feb25bb1e96876b7bbb21e2fb4980662515`, blob `2a32a4ec9c88b026fdc59759015472e60cd65103`; contenido exacto y blob coincidente fueron leídos de vuelta.

**Estados que deben mantenerse separados:**

- **EP — ciclo documental local Prompt 02:** `CUMPLE_VERIFICADO` en su propio objeto y manifiesto. **EP-TASK-002:** `en_curso`; credenciales/cuenta/región/bucket/clave, upload, read-back remoto y restauración permanecen no verificados/no ejecutados.
- **MCP-OCP — ciclo local 03:** `CUMPLE_VERIFICADO` en §§25–26.5; ciclo local 04 procesa el nuevo estado EP en esta sección. La entrada EP dice que la recepción de MCP-OCP era `NOT_VERIFIED` en el cursor de ese frente; el cierre MCP-OCP 03 está acreditado por separado en su objeto. No se cambia ni se atribuye conocimiento retroactivo a EP.
- **Gobernanza:** su objeto GOV-TASK-011 consultado contenía Prompt 02 como `PREPARADO_NO_PUBLICADO`. La entrega directa del operador a EP/MCP-OCP y los cierres locales no demuestran publicación formal de Gobernanza. La evidencia DTC de Gobernanza blob `bfc06686075931f8e7c90271280a9efbf806871a` y el núcleo `GOBERNANZA.md` blob `0d62bd31d2daceb05f4483d9a71b7a41e78634ca` preceden a esta novedad; el núcleo conserva párrafos EP-parcial anteriores. Gobernanza debe leer el delta, auditar este ciclo MCP-OCP y el ciclo EP Prompt 02, y reconciliar su propio núcleo/índice en su siguiente ciclo real.
- **DTC global / GOV-TASK-011:** `EN_CURSO_RECURRENT`; este ciclo local no cierra el sprint ni sustituye la revisión de Gobernanza.
- **Dependencia técnica MCP-OCP ↔ Gobernanza:** la solicitud única `MSG-MCP-OCP-GOV-DEPENDENCIES-20261101-01` sigue cerrada documentalmente en §§23–24. No se abre ni duplica una solicitud.
- **Mecanismo normativo:** ART-027 usa `Sink` (`p001`…`p043`); los aliases no están desplegados/probados. No se escriben URLs. Telemetría autorizada: frecuencia de acceso/consulta, no aplicación.
- **Control/alcance:** MCP-OCP sigue `owned`, generación 3, control blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`; B `AUTHORIZED` sin cambios. No se modifica EP, Gobernanza, DUG, IPZ, ART-025/027, FOL1, host o recursos externos.
- **FOL1:** `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; folios globales CV/CY/A/B y OCP `PENDIENTE / NO ASIGNADO`.

### 27.3 Cierre y read-back del ciclo local 04

**Secuencia:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`.

**Read-back final MCP-OCP:** el objeto de coordinación, el núcleo v0.1.9, el README v0.1.9 y el control se releen después de las escrituras del ciclo. Los blobs comprobados son: coordinación, resultado final de esta escritura y lectura exacta; núcleo `15d6fe1a65d52c52215378fd12a49c3a651d6d73`; README `2a32a4ec9c88b026fdc59759015472e60cd65103`; control `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`. La respuesta de apertura §27 también se conserva y su read-back exacto está registrado.

**Clasificación del ciclo MCP-OCP local 04:** `CUMPLE_VERIFICADO` por preflight, recuperación del cursor, respuesta inicial previa al procesamiento, cotejo de los objetos EP de solo lectura, actualización de §8.1/README y read-back del objeto y archivos MCP-OCP. No constituye aprobación cruzada de EP, publicación de Gobernanza ni cierre global.

**Siguiente acción:** Gobernanza debe procesar el delta en su propio ciclo y reconciliar su índice/núcleo; MCP-OCP continuará su backlog técnico independiente autorizado. No se requiere una nueva solicitud a EP ni a Gobernanza para la novedad aquí registrada.

**Cierre:** `CICLO LOCAL 04 CERRADO · CUMPLE_VERIFICADO · READ-BACK COMPLETO`. El blob final de esta coordinación se informa en la salida del ciclo para evitar autorreferencia.


## 28. Apertura DTC MCP-OCP — ciclo local 05: reanudación técnica de extremo a extremo

**Evento local:** `C-MCP-OCP-DTC-20261101-05`; identificador local, no folio global.  
**Cursor realmente leído:** objeto de coordinación blob `082300f8feb97ccdb87910f6310253e9bd8175a6`, cuyo último cierre procesado es ciclo local 04 §27.3. No hay mensajes posteriores en ese mismo objeto al cursor leído; `SIN_NOVEDAD` en la coordinación propia.  
**Preflight:** control `owned`, titular `chatgpt-mcp-ocp-01a19495-aec0-78e2-a7b6-10ab72a2be78`, generación 3, blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c`; autorización B `AUTHORIZED`, sin cambios de alcance. Exclusividad: no se abre otra solicitud técnica externa; la siguiente acción será reconciliación interna de la rama de construcción autorizada y no integración ciega.

**Novedad externa observada:** la cabeza de `main` avanzó desde el ciclo anterior hasta `9842370b646b34635c62994d9af722d805da4c95` (`2026-11-01T21:25:32Z`). La rama de construcción permanece en `b37213272dc9a132d1fb181e9ce66fba6ae1becc`. El nuevo ciclo se abre para volver a comparar, clasificar los cambios concurrentes y avanzar el trabajo técnico dentro del OCP, sin modificar EP, Gobernanza, DUG, IPZ, control ni host.

**Respuesta inicial:** recibida la instrucción del operador de continuar el trabajo de extremo a extremo. La interpretación operativa es avanzar de forma continua mientras exista trabajo autorizado y evidencia verificable; no implica autorización para sobrepasar B, integrar sin pruebas, instalar en EP ni aceptar el producto por inferencia. La tarea de este ciclo comienza con inspección del delta y un plan de reconciliación seguro.


### 28.1 Procesamiento técnico autorizado: reconstrucción reproducible y frescura de fuentes

**Trabajo ejecutado dentro de MCP-OCP:**

1. Inspección del delta main vs. rama de construcción. La divergencia actual observada al cierre es diverged, rama build 11 commits ahead / 231 behind, merge base e4243414b0099ede9b9556b3cfa0bb20bc706576. El delta de main contiene cambios transversales en Gobernanza, EP, control, núcleo, coordinación y evidencia; por ello no se hizo merge global ni se sustituyó README/objetos actuales con versiones antiguas de la rama.
2. Localización de un checkout aislado en %LOCALAPPDATA%\Temp\mcp-ocp-cycle05; rama build/ocp-mcp-mvp-0.1.0, commit original de código b37213272dc9a132d1fb181e9ce66fba6ae1becc. El dispositivo no tenía SDK instalado, solo runtime .NET 8.0.11. Se instaló SDK 10.0.403 en %LOCALAPPDATA%\OcpMcpSdk10, sin elevación ni modificación del runtime global.
3. Se identificó que Prepare-Sources.ps1 solo cotejaba commit/blob fijados y declaraba NOT_CHECKED_AGAINST_MAIN, sin verificar el árbol vigente. Se corrigió para consultar refs/remotes/origin/main, comparar el Git blob de cada ruta canónica contra el blob fijado y fallar cerrado ante divergencia; solo marca VERIFIED_AGAINST_MAIN cuando ambos blobs coinciden.
4. Se actualizaron los pins de fuente DUG y núcleo a los blobs vigentes observados. El cotejo de build contra el snapshot origin/main ada70cc36d0eb55cfe31f81e9c250e4fa6eb6ffb dio coincidencia; una relectura posterior de los archivos en main volvió a observar DUG blob c993a59163c2c163b17b599a003919b53c5cf6a8 y núcleo blob 15d6fe1a65d52c52215378fd12a49c3a651d6d73.
5. Se ejecutó de nuevo el pipeline completo desde el commit de código 70d7a1fe8b103d8084d3db8594c5e6e6585b8182, rama build. Resultado: UNIT_SUMMARY PASS=31 FAIL=0; TEST_SUMMARY PASS=29 FAIL=0; salida final BUILD_EXIT=0. La prueba de humo verificó 10 herramientas MCP, inicialización stdio, health, lectura de fuentes, catálogo 43/CNP, fail-closed por metadatos, bloqueo sin grant, cadena de eventos, telemetría local y backup/restauración.
6. El ZIP fue extraído en el verificador del propio Build.ps1 y cada componente/manifest cotejado por SHA-256. Resultado: 200 componentes; paquete ocp-mcp-0.1.0-win-x64.zip, 39,690,752 bytes, SHA-256 1c8f843b0768301725e7e8338bd067984afd3849892ceb536c3b2025a028e023. Build manifest SHA-256 539a8fb9e331b39464d7e9e5cd863847d9736b972eb9829da23e0ec932823b90; source manifest SHA-256 ceb34748b120fa1517a7381c6612aa082c72023d25bd9a0149ab9fa1300a9477.

### 28.2 Persistencia de correcciones y evidencia de build

| Recurso en rama de construcción | Commit | Blob SHA / estado |
|---|---|---|
| Pins de initial-sources.template.json | 9588e10151b67430321d012cf4d93c8012f78b3f | 8b7eca5246cf0021d46ebd458ad6e21d18dd62b6 · leído de vuelta |
| Gate de frescura Prepare-Sources.ps1 | 70d7a1fe8b103d8084d3db8594c5e6e6585b8182 | 2cea4a6fef4734084a01aea876753c3fa3e9f882 · leído de vuelta |
| Evidencia BUILD-MCP-OCP-0.1.0-20261101.json | 04c71d10017eb1a114a4fbf4cfc63c7283e7d789 | 74946ba3caa6fa99617257ee3f854d85d81f5bf9 · contenido exacto leído de vuelta |
| Núcleo MCP-OCP §8.1, v0.1.10 | 6b20b9d038af56c26713b1571c71b864a095ea9b | e04e85fc8576244db3e4caefa0d05d2ed693fee7 · contenido exacto leído de vuelta |
| README MCP-OCP | 245ad080a6bc797acedc9be802e4443003064c75 | 383ff59e442f3b7d784e3d670878eb6b31073b36 · contenido exacto leído de vuelta |

La evidencia detallada está en el OCP ejecutor, rama build; este objeto de coordinación mantiene el estado integrado y los límites. El ZIP y los archivos de build permanecen como artefactos locales del checkout aislado; no se declara publicación como GitHub Release ni instalación en EP.

### 28.3 Estado técnico, brechas y decisión de integración

- **Estado reportado por la evidencia ejecutada:** BUILT_AND_TESTED para commit de código 70d7a1f..., SDK 10.0.403, 31 unitarias y 29 integración PASS.
- **Estado observado:** pipeline completo terminó con código 0; hashes del ZIP, manifiesto y componentes fueron generados y verificados por extracción/read-back del paquete. La evidencia compacta fue publicada en la rama de construcción y leída de vuelta.
- **Estado integrado:** no integrado en main. La rama conserva 11 commits propios y 231 commits nuevos de main respecto del merge-base; no se creó PR ni se hizo merge. El README antiguo de la rama y los manifiestos previos no deben sustituir las revisiones actuales.
- **Estado de instalación/aceptación:** no instalado en EP, no ejecutado sobre el host de EP, no aceptado por operador. No se inició servidor en perfil real; las pruebas usaron directorios temporales aislados.
- **Bloqueo normativo:** cobertura de metadatos de selección continúa 0/43 para applicability, activation_conditions, mandatory, dependencies; el producto falla cerrado, como exige el contrato. No se inventan valores.
- **Sink:** aliases p001…p043 continúan sin despliegue/prueba; no se inventan URLs. Telemetría solo frecuencia de acceso/consulta, no aplicación.
- **Decisión pendiente:** para llevar el código a main se requiere reconciliación selectiva de archivos técnicos exclusivos, nueva prueba sobre la revisión reconciliada y una decisión explícita de integración. La autorización B vigente cubre build/compilación/pruebas/fixes/manifest/packaging, no autoriza por sí sola merge, instalación EP ni aceptación. Se mantiene fail-closed para esos actos.

### 28.4 Cierre y read-back del ciclo local 05

**Secuencia:** LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK.

Se releen coordinación, núcleo v0.1.10, README, control y evidencia compacta de build en la rama ejecutora. La actualización de §8.1 registra BUILT_AND_TESTED_NOT_INSTALLED_NOT_INTEGRATED, no aceptación. El control no fue modificado; continúa owned, generación 3, autorización B AUTHORIZED.

**Clasificación del ciclo MCP-OCP local 05:** CUMPLE_VERIFICADO por preflight, cursor, respuesta inicial, reconciliación técnica dentro de B, ejecución del pipeline, evidencia, documentación y read-back. El producto permanece BUILT_AND_TESTED_NOT_INSTALLED_NOT_INTEGRATED; la DTC global sigue EN_CURSO_RECURRENT.

**Siguiente acción técnica:** reconciliar los archivos de código/infraestructura exclusivos contra la base actual, preservar íntegros los artefactos de Gobernanza/EP/MCP-OCP ya presentes en main, y ejecutar build/tests en la revisión reconciliada. No fusionar ni instalar por inferencia.

**Cierre:** CICLO LOCAL 05 CERRADO · CUMPLE_VERIFICADO · READ-BACK COMPLETO. Folios globales CV/CY/A/B y OCP: PENDIENTE / NO ASIGNADO; FOL1 continúa PREPARADO_PENDIENTE_ACTIVACION_IPZ.


## 29. Apertura DTC MCP-OCP — ciclo local 06: preparación de integración selectiva

**Evento local:** C-MCP-OCP-DTC-20261101-06; identificador local, no folio global.  
**Cursor realmente leído:** coordinación MCP-OCP blob 5a52046e9390019adb110d96d500d2998b637bbc, con ciclo 05 cerrado en §28.4. No se observan mensajes posteriores en este objeto al cursor leído: SIN_NOVEDAD.  
**Preflight:** control blob 3e6f96e919c33c3015478b7fd0f262b1bee47b0c, owned, titular y generación 3 coincidentes, B AUTHORIZED; sin modificación de alcance. No hay solicitud técnica externa pendiente.  
**Novedad:** main b9fc29a23e7c8050ef8e82200b875fe88d6041ee; rama build 04c71d10017eb1a114a4fbf4cfc63c7283e7d789; compare diverged, 11 ahead / 232 behind, merge-base e4243414b0099ede9b9556b3cfa0bb20bc706576.  
**Respuesta inicial:** continuar la preparación selectiva sobre la base actual sin fusionar ramas, sin sobrescribir artefactos canónicos y sin ejecutar instalación. El objetivo inmediato es separar código y pruebas del material documental obsoleto de la rama, formar una candidata revisable basada en main y ejecutar build/tests sobre esa candidata. Cualquier integración final a main, instalación EP o aceptación queda fuera de la autorización B actual y requiere decisión explícita.
