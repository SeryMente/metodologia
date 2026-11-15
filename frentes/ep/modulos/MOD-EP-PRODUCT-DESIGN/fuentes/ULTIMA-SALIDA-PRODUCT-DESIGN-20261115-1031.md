# Revisión del Sprint corregido — MOD-EP-PRODUCT-DESIGN

La inspección se refiere al contenido de las **703 líneas** de\:

`frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/SPRINT-GENERAL-PRODUCT-DESIGN.md`

No se ha ejecutado código ni pruebas, ni se han realizado operaciones Git o modificaciones. Los cuatro archivos del frente EP quedan expresamente fuera del alcance.

## 1\. Contrato R-01 a R-18

| ID | Requisito condensado |
|--------|--------|
| **R-01** | ChatGPT + RDC: conversación, consulta de fuentes, salida contractual, ejecución del CLI y recuperación real. |
| **R-02** | Contrato uniforme para los seis perfiles: parámetros, JSON estricto, enums, errores y read-back. |
| **R-03** | Carson consulta dinámicamente `brain.py`\: `categories`, `list` y `show`\. |
| **R-04** | Auditoría automatizada: cero ejecuciones de `memlog.py` y cero eventos de modificación de `.memlog.md`\. |
| **R-05** | `Initialize` crea proyecto y sesión, con auto-nombre y datos de agente, motor y modo. |
| **R-06** | `SaveCycle` conserva texto, autoría y procedencia íntegros; idempotencia y revisiones inmutables. |
| **R-07** | Nombre físico de ciclo `NNNNNN-rNNN.json`, por ejemplo `000001-r001.json`\. |
| **R-08** | Adquirir `.product-design-writer.lock` antes de leer revisiones o decidir numeración. |
| **R-09** | Recuperar locks solo si se demuestra que el proceso propietario terminó y el PID no fue reutilizado. |
| **R-10** | JSON canónico y SQLite/FTS5 derivado; nunca declarar éxito ante inconsistencia. |
| **R-11** | `Verify` coteja hashes, JSON, metadata, FTS5, journal y `PRAGMA integrity_check`\. |
| **R-12** | Search FTS5 con filtros combinables: proyecto, etiqueta, madurez y agente. |
| **R-13** | `RestoreVersion` crea un ciclo nuevo; `ShowSession` reconstruye el contexto persistido. |
| **R-14** | Wrapper PowerShell con JSON validado, pipes asíncronos, timeout y terminación del árbol de procesos. |
| **R-15** | Workspace protegido validado mediante un contrato verificable de EP; sin booleano autodeclarado. |
| **R-16** | Backup/restore de EP incluye específicamente el almacén Product Design. |
| **R-17** | Sincronización clon → `origin/main` → carpeta canónica, con SHA y read-back coincidentes. |
| **R-18** | Los seis perfiles completan individualmente un E2E real ChatGPT + RDC + CLI + Verify + auditoría memlog. |

### Exclusiones y diferimientos de V1.0

La sección 15 excluye expresamente\:

1. Grafo relacional entre proyectos, referencias multi-proyecto y reutilización transversal como entidad compartida.
2. `Save As` y creación de proyectos derivados.
3. Portal, dashboard, Brain Selector y Keepsake HTML.
4. Runtime CIS nativo o despliegue de agentes como procesos/subagentes.
5. Generación automática de PPTX/artefactos de Caravaggio no presentes en sus capacidades locales verificadas.
6. Integración con Prótesis Cognitiva y cognición visoespacial.
7. Integración operativa de Superpowers.

Además, la sección 2 clasifica **Brain Selector y Keepsake como diferidos** y Superpowers como referencia exclusivamente, sin instalación, ejecución o integración como herramienta.

## 2\. Tabla completa de tareas TP-\#

La tabla original presenta cinco columnas. Para ajustarla a tu formato, incorporo `Traza`, `Acción/Archivos` y `Oleada`; las trazas R\# son correspondencias con el alcance, no IDs adicionales asignados por el documento.

| Tarea / Traza | Acción / Archivos | Depende de | Oleada | DoD verificable sin simulación | Estado |
|--------|--------|--------|--------|--------|--------|
| **TP-01 · Carson**\. EP-TASK-009. R-01 a R-07, R-12 a R-14, R-18. | Corregir `prompts/CARSON-CHAT.md`; consulta BMAD dinámica por RDC; persistencia real por ciclo; auditoría memlog. | TP-02A, TP-02B, fuentes BMAD 6.12.4 verificadas y control negativo memlog. | **Oleada 1**\. | Sesión real de Carson; `categories/list/show`; JSON estricto; `Initialize`, `SaveCycle`, `ShowSession`, `Verify`; read-back SHA/contenido; test negativo memlog PASS. Ejercitar los tres modos en sesiones ejecutadas. | **PENDIENTE**\. Las tres transcripciones previas son sintéticas y no cuentan como aceptación. |
| **TP-02A · Nivel A**\. EP-TASK-010. R-06, R-08 a R-14. | Endurecer `product_design_store.py`, `Invoke-ProductDesignStore.ps1` y pruebas: schemas, lock, atomicidad, recuperación, filtros, restauración y wrapper. | Diseño R\# aprobado. Puede trabajar en raíz sintética aislada. | **Trabajo paralelo de base técnica** con EP-C0; sin número explícito de oleada. | Pruebas unitarias e integración sintéticas PASS; concurrencia sin colisiones; lock vivo/huérfano; fallos intermedios recuperables; stdout/stderr y timeout sin bloqueo; `PRAGMA integrity_check`; filtros; `RestoreVersion` y `ShowSession`\. | **PENDIENTE CORRECTIVO**\. Las 12/12 pruebas previas son baseline, no DoD de la corrección. |
| **TP-02B · Nivel B**\. EP-TASK-010. R-15, R-16 y EP-C0.1–C0.4. | Integrar con workspace protegido EP; validar ruta, bóveda e identidad; incorporar `MOD-EP-PRODUCT-DESIGN\data\<TerminalId>\brainstorming` al backup/restore. | EP-C0: ruta Cryptomator, verificador, TerminalId/identidad, backup/restore y autorización expresa para escrituras de prueba. | **Prerequisito EP** para aceptar el flujo productivo. | Preflight EP verifica montaje, vault, raíz, SID, TerminalId, RDC device y ACL; fixture autorizado con read-back; backup B2 de Product Design; descarga a staging; SHA cotejado; restore sin sobrescribir la fuente. | **BLOQUEADO POR EP**\. No usar `-ProtectedWorkspaceVerified` como prueba. |
| **TP-03 · Cinco agentes**\. Sin nuevo EP-TASK. R-02, R-04 y R-18. | Corregir `prompts/MAYA-CHAT.md`, `prompts/DR-QUINN-CHAT.md`, `prompts/VICTOR-CHAT.md`, `prompts/SOPHIA-CHAT.md` y `prompts/CARAVAGGIO-CHAT.md`; fijar fuentes CIS e integrar CLI/recuperación. | TP-02A, TP-02B, contrato común demostrado en TP-01 y fuentes CIS verificadas. | **Oleada 2**\. | Un E2E real por perfil; fuente local verificada; JSON estricto; `Initialize`, `SaveCycle`, `ShowSession`, `Verify`; read-back y auditoría memlog. | **PENDIENTE**\. Los escenarios anteriores son sintéticos y no aceptan los perfiles. |

Orden de TP-03: **Maya → Dr. Quinn → Victor → Sophia → Caravaggio**\. Cada perfil debe obtener su propio PASS. El resultado de uno no se hereda por los demás.

## 3\. Contrato E2E: Agente ↔ fuentes ↔ `Invoke-ProductDesignStore.ps1`

### 3.1 Flujo obligatorio

El Sprint define los perfiles como configuraciones conversacionales de ChatGPT conectadas por RDC, no como runtimes CIS nativos.

El flujo de cada agente es\:

1. Identificar agente, motor y modo.
2. Consultar las fuentes locales correspondientes.
3. Conservar las aportaciones con texto íntegro, autoría y madurez.
4. Construir JSON contractual.
5. Invocar `Initialize` mediante RDC.
6. Construir y ejecutar `SaveCycle` con los identificadores devueltos.
7. Ejecutar `ShowSession` y `Verify`\.
8. Comparar IDs, ciclo, revisión, SHA y contenido de read-back.
9. Declarar guardado confirmado solo ante resultado satisfactorio.

La interfaz de wrapper que fija el Sprint es\:

| Parámetro | Contrato |
|--------|--------|
| `-Operation` | Obligatorio. |
| `-WorkspaceRoot` | Obligatorio; raíz validada. |
| `-TerminalId` | Obligatorio; contrastado con EP. |
| `-PayloadJson` | Obligatorio; JSON UTF-8. |
| `-TimeoutSeconds` | Opcional; valor de diseño predeterminado: 30 segundos. |
| `-TestMode` | Solo para pruebas en raíces sintéticas. |

El flujo no debe requerir que el operador copie manualmente objetos JSON entre etapas ni que el agente se limite a explicar lo que haría.

### 3.2 Seis perfiles y engines

| Perfil | Engine |
|--------|--------|
| Carson | `bmad-brainstorming` |
| Maya | `bmad-cis-design-thinking` |
| Dr. Quinn | `bmad-cis-problem-solving` |
| Victor | `bmad-cis-innovation-strategy` |
| Sophia | `bmad-cis-storytelling` |
| Caravaggio | `bmad-cis-agent-presentation-master` |

Para Carson, la consulta por RDC es obligatoria y dinámica\:

- `brain.py categories`
- `brain.py --file ... list --category <category-slug>`
- `brain.py --file ... show <exact-technique-name>`

Se conservan versión del paquete, SHA-256 del CSV, categorías consultadas y nombres/salidas reales de las técnicas.

Para los otros cinco perfiles, se deben comprobar las fuentes CIS locales, su contenido y SHA antes de aceptar su sesión E2E.

### 3.3 Barrera memlog

El Sprint no confía en la instrucción textual `MEMLOG_READ/WRITE/RESUME=DISABLED`\.

Exige, durante cada E2E\:

- Monitorizar procesos para detectar `memlog.py` en argumentos de `py.exe` o `python.exe`\.
- Monitorizar eventos de filesystem en workspace, `output_folder` y raíz BMAD.
- Fallar ante creación, escritura, renombrado o eliminación de cualquier `*.memlog.md`\.
- Ejecutar búsqueda final en los mismos roots.
- Conservar un reporte de roots, ventana temporal y eventos.

PASS requiere cero ejecuciones, cero eventos de escritura y cero residuos. Una búsqueda final vacía sin monitorización temporal no cuenta. Si no se pueden observar los eventos, el resultado debe ser `NO VERIFICADO`\.

**Límite del diseño\:** el documento establece una auditoría negativa, pero no especifica un mecanismo de denegación preventiva a nivel de sistema operativo que haga imposible toda escritura memlog. Por eso, la barrera propuesta es una condición de detección y rechazo, no una garantía de prevención ya demostrada.

### 3.4 Concurrencia y atomicidad JSON/SQLite

El protocolo que propone el Sprint es\:

1. Validar payload, IDs, enums, ruta y sesión.
2. Adquirir `.product-design-writer.lock` antes de leer ciclos o revisiones.
3. Comprobar colisiones e idempotencia bajo el lock.
4. Escribir journal recuperable.
5. Promover JSON mediante staging, `flush/fsync` y reemplazo atómico.
6. Actualizar metadata y FTS5 dentro de una transacción SQLite.
7. Verificar hashes, metadata y FTS5 contra el mismo ciclo.
8. Retirar journal y liberar lock solo tras confirmar consistencia.
9. Ante un fallo, no devolver `ok=true`; dejar estado recuperable.
10. Reconstruir índices únicamente desde JSON verificados.

El lock tiene TTL inicial de diseño de **600 segundos**, pero TTL por sí solo no autoriza a recuperarlo. Deben demostrarse la terminación del proceso propietario y la ausencia de reutilización del PID; ante incertidumbre se falla cerrado.

`Verify` ejecuta `PRAGMA integrity_check`, compara JSON/metadata/FTS5, coteja hashes y detecta journals pendientes.

El wrapper debe consumir stdout y stderr asíncronamente, aplicar timeout, terminar el árbol de procesos y no aceptar salidas parciales.

**Límite de implementación\:** todo lo anterior es el contrato objetivo. El Sprint reconoce que el wrapper actual aún no implementa `TimeoutSeconds`, los schemas estrictos ni el preflight EP. También reconoce que los seis perfiles todavía no ejecutan actualmente el ciclo del CLI. No presenta ninguno de esos comportamientos como ya resuelto.

## 4\. DAG, ruta crítica y bloqueantes EP

### 4.1 DAG

**Aprobación del Sprint**

**TP-02A**

Endurecimiento técnico sintético

**EP-C0**

Cryptomator, verificador, identidad y backup

Paralelos después de aprobar

**TP-02B · Integración productiva protegida**

**TP-01 · Carson E2E**

**Contrato común aceptado**

**TP-03 · Cinco E2E CIS**

**Gate V1.0 y aceptación expresa**

**Commit/push solo con autorización posterior**

### 4.2 Ruta crítica

1. Aprobación del Sprint.
2. TP-02A y EP-C0 en paralelo.
3. TP-02B después de que ambos estén resueltos.
4. TP-01: Carson, consulta BMAD dinámica y persistencia real.
5. TP-03: cinco perfiles, secuencialmente y con E2E individual.
6. Gate final: seis perfiles, búsqueda, recuperación, consistencia, rutas y backup/restore.
7. Presentación de resultados y aceptación del operador.
8. Commit/push fuera del alcance; exige autorización expresa posterior.

### 4.3 Bloqueantes anticipados

| ID | Bloqueante | Riesgo/estado registrado | Desbloqueo |
|--------|--------|--------|--------|
| **B-01** | Ruta física Cryptomator | No hay ruta montada de Product Design aceptada; `W:\` no mostraba el workspace durante la auditoría. | EP identifica montaje, vault ID y raíz física. |
| **B-02** | Verificación protegida | El código actual confía en `-ProtectedWorkspaceVerified`\. | Verificador estructurado EP consumido por el wrapper; eliminar el switch. |
| **B-03** | Identidad terminal | TerminalId se recibe como texto sin contraste de dispositivo/sesión. | Vincular TerminalId, RDC UUID, SID y raíz autorizada. |
| **B-04** | Backup Product Design | Recibos R2/R4 revisados no incluyen el almacén. | Snapshot, upload, read-back, SHA y restore específicos PASS. |
| **B-05** | Perfiles desconectados | Los seis prompts no ejecutan el ciclo CLI. | Contrato común y seis E2E individuales PASS. |
| **B-06** | BMAD dinámico | Carson aún no acredita `categories/list/show` en un E2E real. | Consulta dinámica registrada y vinculada a sesión persistida. |
| **B-07** | Memlog | Override textual no evita por sí solo ejecución/escritura. | Monitorización de procesos y filesystem; cero eventos. |
| **B-08** | Consistencia JSON/SQLite | El motor puede devolver `ok=true` aunque falle el índice. | Journal/recovery, transacción SQLite, Verify ampliado y fault-injection PASS. |
| **B-09** | Lock/concurrencia | Lectura de revisión/idempotencia anterior al lock; recuperación insuficiente. | Lock previo a lectura, TTL seguro y pruebas concurrentes PASS. |
| **B-10** | Sincronización canónica | El clon tiene Git; `SeryMente\Metodologia` se observó como carpeta sin `.git`; sync no acreditado. | EP identifica el mecanismo y se cotejan SHA/read-back en los tres destinos. |

### 4.4 Entregables requeridos a EP

- **EP-C0.1 — Cryptomator\:** ruta real desbloqueada, vault ID, raíz física, ruta lógica autorizada y tratamiento de bloqueo/desmontaje/cambio de ruta.
- **EP-C0.2 — Verificador\:** resultado estructurado que pruebe montaje, containment, SID, RDC device, ACL y canary sintético con write/read-back/remove.
- **EP-C0.3 — TerminalId\:** vínculo entre identidad de terminal, UUID RDC, SID Windows y raíz Product Design. Ubicación/perfil general como dato separado.
- **EP-C0.4 — Backup/restore\:** cobertura efectiva de `MOD-EP-PRODUCT-DESIGN\data\<TerminalId>\brainstorming`, upload verificado, descarga independiente, SHA y restauración en staging con Verify PASS y ShowSession utilizable.

**Condición\:** mientras EP-C0.1 a EP-C0.4 no estén aceptados, TP-02B sigue bloqueado y TP-01/TP-03 no pueden declararse terminados.

---

## Estado de autorización y límites

- **Documento\:** leído directamente; 703 líneas.
- **Código y pruebas\:** no ejecutados.
- **Archivos modificados\:** ninguno en este turno.
- **Commit, push, staging o sincronización\:** ninguno.
- **Archivos EP protegidos\:** fuera del alcance; no deben modificarse, revertirse ni incluirse en operaciones globales.
- **Aprobación\:** pendiente de tu evaluación.

**Observación relevante para tu decisión\:** el Sprint fija criterios razonables para no confundir conversación con ejecución, pero aún deja dos controles por concretar antes de poder considerarlos garantías: la prevención efectiva de escrituras memlog y el mecanismo técnico verificable que EP entregará para acreditar el workspace protegido.

**Trazabilidad solicitada\:** IPZ v0.7 · antigüedad de commit: NO VERIFICADA. DUG: versión/firma NO VERIFICADAS. CONV, CICLO, A y B: identificadores OCP/FOL no asignados; no se generan folios sin evidencia de control y read-back.

