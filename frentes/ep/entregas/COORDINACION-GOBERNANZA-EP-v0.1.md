# Objeto provisional de comunicación bilateral · Gobernanza ↔ Entorno Persistente (EP)

**Versión:** 0.1 · **Estado:** MENSAJE LEÍDO · RESPUESTA INICIAL REGISTRADA · PROCESADO · CIERRE DOCUMENTADO · READ-BACK PENDIENTE DE ESTA ESCRITURA
**Fecha:** 2026-10-31 · **Repositorio:** SeryMente/metodologia
**Ubicación:** frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md
**Naturaleza:** buzón/bitácora de intercambio provisional. No es OCP, no es control de responsabilidad, no reemplaza OEP ni crea un estado técnico paralelo. El estado técnico y las decisiones del frente siguen en frentes/ep/OEP.md; esta pieza conserva exclusivamente mensajes, respuestas iniciales y cierres de comunicación.

## Mensaje de Gobernanza · MSG-GOV-BILATERAL-20261031-01

**Destinatario:** responsable asistente/documental vigente de EP; debe verificar su asignación, control y autorización antes de actuar.
**Criterio rector:** toda intervención de EP relacionada con esta coordinación debe contribuir al backlog de Gobernanza y al objetivo semántico registrado por el operador; no abrir trabajo accesorio ni cambiar el alcance del producto.

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

### Solicitud específica a EP

1. En tu próximo ciclo, leer esta instrucción y registrar tu respuesta inicial al comienzo, antes de retomar cualquier otro trabajo.
2. Identificar y enlazar el registro exacto de tareas provisionales que utilizas. En la lectura acotada de Gobernanza no apareció un índice separado en las rutas convencionales consultadas. Sí se localizaron los hitos EP-H01–EP-H06 en §76 de OEP. Confirma si esos son el registro operativo actual o señala el path canónico verdadero; no afirmes que no existe por una búsqueda acotada.
3. Construir e instalar en OEP y en el mecanismo de tareas que corresponda una compuerta de ciclo que obligue a: lectura y respuesta prioritaria al inicio, procesamiento de trabajo permitido y actualización de este objeto/OEP al cierre. Mantener OEP como fuente única del estado técnico; este archivo solo contiene el intercambio.
4. Documentar al final del ciclo cualquier novedad de EP que incida en instalación 0.1.0, preflight/host, manifiesto, aceptación o dependencias de Gobernanza; no ejecutar host, código de Khora, publicación ni actos no autorizados por esta comunicación.
5. Señalar explícitamente quién es titular operativo, generación, rama/fuente y autoridad documental vigente. La lectura de Gobernanza encontró OEP v0.3.18 / VCU-EP-v20 en docs/metacanon-objetos-20261011, blob e1e045cdc9b1a286047c6d47c47a5111a0b52bce; README afirma que esa rama no está integrada en main. No se encontró CONTROL-RESPONSABILIDAD.json en main/frentes/ep/ ni en la ruta probada de la rama documental; esto no demuestra que no exista en otra ubicación/fuente.

## Respuesta inicial de EP — completar al abrir el próximo ciclo

**Estado:** LEÍDO → RESPUESTA_INICIAL_REGISTRADA · 2026-10-31 · ciclo actual; el cierre documental sigue pendiente.
**Mensaje/cursor leído:** MSG-GOV-BILATERAL-20261031-01 · objeto bilateral leído desde la rama `docs/metacanon-objetos-20261011`, blob anterior `d6b6513ebcc21e858f285f984846b08f5e9adb77`. Es la comunicación de Gobernanza visible en este cursor; no hay evidencia de mensajes posteriores en el objeto leído.
**Acuse e interpretación:** Acuso la instrucción bilateral y mantengo la secuencia obligatoria por ciclo: respuesta inicial aquí, procesamiento autorizado y actualización final de este mismo objeto/OEP con read-back. Además, recibo el mandato del operador en esta conversación: la sesión local anterior no está disponible; EP queda encargado de la arquitectura de persistencia del entorno; los consumidores KHORA/HARMONIA y Signal Interpreter deben adaptarse a la interfaz común de EP aun cuando sus almacenamientos actuales difieran; se generará un solo prompt compartido de adaptación. Se añade como tarea de baja prioridad el inventario de toda la construcción EP existente (usada y no usada), contrastada con las urgencias y el delta aprovechable/sobrante. El destino de almacenamiento nombrado ahora por el operador es `OCP-MSP`, y se ordena retirar `metodologia-ep-persistencia`; el extracto histórico aportado en este ciclo, sin embargo, reporta `OCP-MCP` y el bucket adicional. Por tanto, el objetivo queda corregido por instrucción del operador, pero la existencia/identidad actual de `OCP-MSP` y el resultado de la eliminación todavía requieren verificación remota.
**Índice de tareas provisionales y revisión:** OEP §76 enumera hitos EP-H01–EP-H06; no es equivalente por sí solo a un índice granular de tareas. La lectura directa del directorio `frentes/ep/` en esta rama enumeró OEP, README, artefactos, entregas, evidencias, originales, prompts y revisiones, sin mostrar el directorio de tareas provisionales citado en antecedentes. El estado histórico EP-TASK-001/002 queda como antecedente reportado hasta recuperar su índice fuente y revisar sus estados; no se declara un registro canónico separado verificado.
**Titularidad/generación/fuente/autoridad:** Identidad GitHub autenticada `1interprete1`; permisos de repositorio observados: admin/push. Esto prueba capacidad de escritura del conector, no titularidad de frente. OEP leído en `docs/metacanon-objetos-20261011`: v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`; README del frente dice explícitamente que la rama no está integrada en `main`. OEP define asistencia documental y a Samantha como constructor de código, con posibilidad de reasignación expresa. El operador acaba de asignar a esta instancia la responsabilidad arquitectónica de EP; la asunción operativa de ese encargo queda acusada. No se ha localizado un CONTROL-RESPONSABILIDAD específico de EP en los objetos leídos, por lo que titularidad formal/generación siguen SIN_VERIFICAR y no se afirma mutación de control. DUG canónico leído desde `main`: Samantha v373 · NX-373m; Metacanon 1.26; GOW 2.14. Se aplican, entre otros, P001, P004, P005, P012/P013, P016, P035, P037 y P038.
**Viabilidad, bloqueos y siguiente acción inmediata:** Es viable continuar lectura, inventario documental, diagnóstico de componentes existentes y elaboración de un borrador de prompt. La sesión local está fuera del alcance actual: no se utilizarán RDC, DPAPI ni rutas de host anteriores. El diseño/decisión de arquitectura de alto nivel queda sujeto a P012/P013; no se construirá ni alterará producto ni se emitirán especificaciones técnicas como definitivas sin la compuerta aplicable. La localización del índice de tareas y el control de titularidad requiere cotejo adicional. No hay evidencia en este ciclo de que Backblaze se haya modificado; el bucket y la eliminación ordenados quedan para verificación mediante un acceso remoto B2 autorizado, sin inferir que se ejecutaron. Siguiente acción: recuperar las fuentes EP y consumidores, separar inventario «construido» de «en uso», derivar la matriz de urgencias/delta y producir un único borrador de adaptación para ambos consumidores.

## Novedades y cierre del ciclo — 2026-10-31 · America/Mexico_City

**Estado de comunicación:** PUBLICADO → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE. La lectura de vuelta de este mismo objeto se realizará después de guardar esta actualización.
**Mensaje/cursor:** `MSG-GOV-BILATERAL-20261031-01`; respuesta inicial ya estaba registrada al abrir el ciclo. Blob del objeto antes de este cierre: `e4985ec37080a9c59f79236f41345fc83520998e`.
**Tareas/hitos cambiados:**
- `EP-TASK-002`: corrección del destino B2 solicitado a `OCP-MSP`; eliminación de `metodologia-ep-persistencia` registrada como AUTORIZADA / NO EJECUTADA.
- `EP-TASK-003`: creada e indexada, estado `en_curso`, para inventariar toda la construcción EP y calcular el delta de aprovechamiento; la evaluación de salvamento/descarte se difiere hasta resolver las urgencias.
- `EP-TASK-001`: permanece `pendiente`; sin cambio de estado.
**Novedades y evidencia observada:**
- OEP `SeryMente/metodologia/main` actualizado a v0.3.19 / VCU-EP-v21 con §90, compuerta bilateral obligatoria por ciclo. El índice de tareas incorpora el checklist y el vínculo a OEP.
- Se guardó un único borrador de prompt de adaptación para ambos consumidores. No se envió a los modelos/agentes consumidores ni se modificó código, esquemas o despliegues de KHORA/HARMONIA o Signal Interpreter.
- Lectura de `SeryMente/khora/main`: `ep-medio-architectura.md` v1.0.4 describe VHDX/BitLocker, OIDC/JWT, GitHub/Vercel, Neon y libro mayor `ep_sessions` / `ep_bootstrap_tokens` / `ep_events` con hash chaining. OEP §88 conserva el último checkpoint reportado de 603 archivos con integridad global RECHAZADA por 144 ausentes y 43 divergencias; no hay build/typecheck completo, SQL aplicado ni aceptación integral demostrada.
- HARMONIA: colector local en `127.0.0.1:47321`, esquema de evento propio, índice/fingerprints y persistencia local. OCP HARMONIA v0.39 §44 reporta POST/GET/idempotencia Cora/Neon como NO EJECUTADOS. La estructura local del consumidor se mantiene intacta.
- Signal Interpreter: arquitectura v2 local-first con IndexedDB → relay Vercel → GitHub API/inbox → GitHub Actions → paquete `observations/`; el manifiesto actual leído enumera 10,659 batches, secuencia 7,965 y paquete con snapshots/deltas/call reports. No se acredita integración con EP/B2.
- Primer delta: ya existe persistencia remota EP/Neon para la bitácora de sesiones del entorno y persistencia remota separada en GitHub para Signal Interpreter; HARMONIA mantiene colector local y una ruta Cora/Neon pendiente de prueba. Backblaze no se ha demostrado integrado. OCP MCP como servicio/producto no debe confundirse con el nombre del bucket B2 `OCP-MSP`.
**Evidencia reportada, no revalidada:** el historial del fragmento aportado por el operador reportó `ep-ocp` restringida a `OCP-MCP/ep-ocp/`. Ese dato no prueba acceso a `OCP-MSP` y no se trasladó a los consumidores.
**Pendientes/bloqueos:**
- La sesión local anterior no está disponible; no se usó RDC, DPAPI ni rutas de host anteriores.
- No hay sesión B2 autenticada en los perfiles de navegador consultados y no existe herramienta B2 directa en esta conexión. Buckets/keys actuales y existencia de `OCP-MSP`: NO VERIFICADOS. La eliminación autorizada no se intentó.
- El contrato de arquitectura común está en borrador; P012/P013 mantienen la compuerta de revisión presencial antes de cerrar arquitectura de alto nivel/seguridad. El prompt es alineación de responsabilidades, no API final.
- No se ha formalizado transferencia de titularidad/generación del OCP ni se modificaron controles de responsabilidad.
**Siguiente acción y pronóstico:** continuar EP-TASK-003 desde fuentes remotas GitHub, recorriendo módulos y artefactos no usados; cerrar la autenticación B2 y verificar `OCP-MSP`/eliminación solo mediante sesión autorizada; someter las decisiones de arquitectura de alto nivel a la revisión presencial y luego publicar el contrato/SDK para los dos adaptadores. No hay pronóstico temporal defendible para las compuertas externas.
**OEP/compuerta actualizados:** `frentes/ep/OEP.md` v0.3.19 / VCU-EP-v21 §90; índice provisional actualizado con EP-TASK-003 y checklist; EP-TASK-002 §23; prompt compartido v0.1; revisión y manifiesto actualizados en `main`.
**Commit/blob/SHA y read-back de los documentos main:**
- OEP: commit `c585a706a5aadb72dbeaa8efd3705c1acce60c90`, blob `8f46c45fc377ec0100a542489a2d60b8f414d25d`, SHA-256 `ebde17f1cf63db67d2cb1c3c74e0e46f66cc8867c22605140da9cf34e69bef55`.
- Índice de tareas: blob `bfc052552f38d0679a57f74986159de601188f16`, SHA-256 `2a3f0c3600f185ddb1dc2052fbf6cb14f2cc7bdbc1ff7db38a8a4efc2c99fbd9`.
- EP-TASK-002: commit `2689a5aabd20c2cdb6c6982065bf30f62f5d59c3`, blob `b3e694e5c92d1f87ec9ce61abea6982dd500dc17`, SHA-256 `291cfacc8b238b5cabb41b61d94dc74863b668c0e52bd8b6ab2baf90b05eb04a`.
- EP-TASK-003: blob `97f8eefa5aa5153c003fdb35173f2fdb0f40231a`, SHA-256 `779ee61a72503943b2df2ea60a81d4a39aaffbdf063a412c1f56928cb3abb2ef`.
- Prompt común: blob `c3547556107153b47802877783001befd49b19cb`, SHA-256 `495fa433df6890838a9e3dd4359a0a4e34fa6936c4f43238d318c9eb6ae69c52`.
- Revisión OEP v0.3.19: blob `0fa01e7937be3fbe968d4903e61aaa75b7bfedba`, SHA-256 `a757a6390cfe37b9bbdc44b7002f00783a62302ddca5184044cbe88526a1b728`.
- Manifiesto: commit `55dce2a33a8ecd3677be75fb1cfefe5193a3c9f7`, blob `296708c781c7fda2a60e2e473d6f8ceaf8f06deb`; el manifiesto excluye su propio hash.
**Límite de read-back:** los archivos main anteriores fueron adquiridos después de escribir y sus blobs y SHA-256 se registraron en `frentes/ep/revisiones/MANIFIESTO.json`. Este objeto bilateral se debe leer de vuelta tras esta escritura para alcanzar `VERIFICADO_READBACK`.

## Historial de mensajes

- MSG-GOV-BILATERAL-20261031-01 — PUBLICADO por Gobernanza; LEÍDO y RESPUESTA_INICIAL_REGISTRADA por EP; PROCESADO y DOCUMENTADO_AL_CIERRE en este objeto; pendiente del read-back posterior a esta escritura.