# GOV-TASK-015 · OCP MCP 1.0 · Coordinación Gobernanza / MCP-OCP / EP

**Estado:** `EN_CURSO · coordinación centralizada · listo para handoff de ejecución a EP; implementación MCP-OCP y gates EP siguen pendientes de evidencia`
**Objetivo de release:** entregar MCP-OCP software **1.0.0**, instalado en la carpeta local de Metodología descrita al final de este plan. Las versiones documentales del núcleo MCP-OCP-v0.1.28 y backlog 0.9 son versiones de artefactos auxiliares, no la versión del producto.
**Tipo:** coordinación y aceptación de un único sprint; no crea un frente nuevo ni controles paralelos.
**Responsabilidad:** frente Gobernanza. Las tareas técnicas conservan sus OCP y fuentes.
**Fuente normativa:** Samantha v388 · NX-388m · Metacanon 1.29 · GOW 2.18.
**DUG:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; archivo blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
**MCP-OCP:** núcleo v0.1.30 · commit `4610a81f6522142859ecf7345bc3836763434bd6` · blob `4eea02bcc6dc086af7177ba8791b7e51fb205a2e`; backlog v0.11 · commit `a43d53543df79f659888997f332e86ef03cb97b8` · blob `a328dc4fcda6beb0a45ffcc09f68ab5c6407588f`.
**EP:** OEP v0.3.59 · commit `a8882deba14fb38b2dcdb59cbc313b388d971dd9` · blob `b29e806d2d9473f3828972a0c67d09bf7dcafc4e`. EP-TASK-003=`PARTIAL_FAIL`; EP-TASK-005=`PENDING`; OEP §124 prepara reanudación por EP, sin alterar control generación 3.
**Autorización:** la implementación Sink local por STDIO, pruebas, build/paquete y panel siguen dentro del control MCP-OCP generación 5. La coordinación no amplía permisos de host EP ni altera los controles MCP-OCP/EP/Gobernanza.
**Destino EP designado:** alias funcional **Fila 4**, único destino RDC designado por el operador; PC 7 queda supersedido. No se conservan Device IDs, hostnames, cuentas de Windows, rutas concretas de perfil ni identificadores de sesión efímeros conforme a DUG v388/ART-013. El operador reportó estar físicamente frente a Fila 4; CECEQ no fue confirmado y la ubicación física continúa `UNCLASSIFIED`. No inferir CECEQ/LOC-OTHER; el dead-man solo aplica si se confirma ubicación distinta de CECEQ.
**Alcance:** contrato, implementación Sink local, panel de observabilidad, pruebas, paquete, handoff, bootstrap en el perfil designado y aceptación E2E. Esta ficha es planificación: no acredita código, build, instalación ni prueba ejecutados.

## 1. Objetivo y contrato

Entregar el recorrido local:

`ChatGPT/IPZ → RDC → MCP-OCP por stdio → fuentes canónicas locales protegidas → respuesta validada`

| Referencia | Resultado obligatorio |
|---|---|
| `GOW:ARR` | Recuperar §ARR desde la fuente importada y verificada. |
| `DUG` | Verificar versión, firma, commit, Git blob SHA, SHA-256 y catálogo de 43 IDs/MDP. |
| `SINK:P001` … `SINK:P043` | Recuperar solo el texto desarrollado del ID solicitado, con ID, título, pin DUG y SHA-256 del contenido. |
| Lote | Conservar el orden solicitado y emitir resultado/huella/evento individual por ID exitoso. |
| Frecuencia | Un evento por recuperación completa y satisfactoria; una llamada fallida no cuenta como recuperación. |
| Manifiesto | Hash sobre serialización canónica UTF-8 del conjunto exacto y ordenado: IDs, versión/firma/commit/blob DUG y SHA-256 de cada texto. |
| Fallo | ID inexistente, fuente ausente/antigua, importación no verificada, desconexión o hash distinto ⇒ fallo cerrado. No sustituir con memoria ni MDP. |

El catálogo inicial expone IDs/MDP; el texto desarrollado se devuelve solo mediante una referencia Sink explícita. La recuperación de texto no activa un motor de evaluación normativa. `MCP-NORMATIVO` continúa DESACTIVADO.

## 2. Tareas provisionales por frente

### Frente 1 · Gobernanza

| Tarea | Estado leído | Trabajo en este sprint | Salida |
|---|---|---|---|
| [GOV-TASK-015](./README.md) | En curso | Coordinación maestra, dependencias, bloqueos y aceptación integrada. | Plan único, matriz actualizada y recibo de aceptación. |
| [GOV-TASK-008](../📁%20🧩%20-%20GOV-TASK-008%20-%20Aislamiento%20de%20capa%20desarrollada/README.md) | En curso | Contrato Sink, recuperación individual, frecuencia y manifiesto hash. | Contrato request/response, lote ordenado, evento y hash. |
| [GOV-TASK-001](../📁%20🧩%20-%20GOV-TASK-001%20-%20Validación%20de%20MDP/README.md) | En curso | Ejecutar matriz semántica de 43 MDP: 43 positivos y 8 controles negativos/frontera. | Resultados por caso, falsos positivos/negativos y mapeo etiqueta–ID–título. |
| [GOV-TASK-003](../📁%20🧩%20-%20GOV-TASK-003%20-%20Consulta%20privada%20E2E/README.md) | Pendiente | Aceptación funcional ChatGPT/IPZ → RDC → stdio → respuesta, con positivos y negativos. | Recibo E2E con pins, hashes, frecuencia y fallos cerrados. |
| [GOV-TASK-013](../📁%20🧩%20-%20GOV-TASK-013%20-%20Medición%20y%20optimización%20de%20ciclos/README.md) | En curso | Medir solo `ipz.resolve.rdc.duration_ms` con reloj monotónico y ambos extremos observables. | Registro mínimo; `NOT_MEASURED` si falta un extremo; línea base preliminar después de ≥10 muestras completas comparables. |
| [GOV-TASK-007](../📁%20🧩%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md) | En curso | Preparar IPZ/read-back nativo y evaluar FOL1 en su gate propio, sin condicionar build, paquete, panel ni instalación MCP-OCP 1.0.0. | Evidencia IPZ y decisión FOL1 separadas; no es camino crítico del release. |
| [GOV-TASK-009](../📁%20🧩%20-%20GOV-TASK-009%20-%20Revisión%20del%20glosario%20operativo/README.md) | En curso | Solo comprobar vocabulario §ARR y ausencia de colisiones de alias; no reabrir revisión general del GOW. | Mapeo `GOW:ARR` y alias verificados. |

GOV-TASK-010 ya contiene la corrección de admisión por instrucción directa y generaciones como auditoría. GOV-TASK-011 (DTC recurrente), GOV-TASK-012 (fluidez general), GOV-TASK-014 (Backblaze) y la incubación Tareas no son dependencias de ejecución de este sprint.

### Frente 2 · MCP-OCP

| Tarea | Orden | Trabajo ejecutable | Criterio de salida |
|---|---:|---|---|
| MCP-OCP-02 | 1 · P0 CRÍTICO / BLOQUEO ACTUAL | Crear rama limpia desde HEAD de `main`; pin DUG v388; ramas históricas solo fuentes de port selectivo. | Rama/diff revisables; matriz REUSE/ADAPT/REWRITE/DROP; SDK/RID fijados. |
| MCP-OCP-05 | 2 · P0 SIGUIENTE | Corte vertical P004; desarrollo con fixtures y fuente sintética hasta EP PASS. | Texto íntegro P004 con DUG v388/pin/commit/blob/SHA-256 y rechazo fail-closed. Generalización posterior. |
| MCP-OCP-13 | 7 · paralelo · P1 secuencia | Construir panel WPF de solo lectura después de congelar schema; trabajar con fixtures mientras se generaliza Sink. | Panel abre en EP ACTIVE y distingue readiness; obligatorio en el ZIP 1.0.0, pero no bloquea el piloto P004. |
| MCP-OCP-03 | 3 · P0 PARALELO | Contrato y pruebas P004 con fixtures sintéticos; fuente real tras EP PASS. | Recibo ligado a commit con casos positivos/negativos y suite posterior; no reutilizar PASS históricos. |
| MCP-OCP-04 | 4 · P0 PARALELO | Preparar harness/smoke STDIO/RDC; E2E IPZ después de instalar el piloto. | Smoke técnico y E2E IPZ diferenciados; JSON-RPC de consola no cuenta como aceptación IPZ. |
| MCP-OCP-10 | 8 | Congelar fuentes/pins DUG v388, commit/base, SDK/RID, schema panel, pruebas, manifiestos y limitaciones. | Recibo y hashes del servidor+panel, read-back. |
| MCP-OCP-07 | 9 | Empaquetar el producto final servidor+panel una vez que pruebas y manifiesto pasen. | ZIP 1.0.0, SHA/manifest y extracción/read-back PASS. |
| MCP-OCP-12 | 10 | Bootstrap del piloto y después instalación final en checkout Fila 4; datos fuera del checkout en root protegido. | Piloto/P004 y final 1.0.0 identificados separadamente; REGISTER interactivo solo con consentimiento. |
| MCP-OCP-08 | 11 | Handoff a EP para recepción, instalación y aceptación del paquete final. | EP verifica Fila 4, root, panel ACTIVE, hash, cierre y rollback. |

Fuera del sprint: MCP-OCP-06/11 (Jules, permanece pausado) y MCP-OCP-09 (PPR/restauración cross-host, P2). Tampoco entran B2, Khora, HTTP público ni activación de MCP-NORMATIVO.

### Frente 3 · Entorno Persistente (EP)

| Tarea | Estado leído | Trabajo de este sprint | Condición |
|---|---|---|---|
| [EP-TASK-003](../../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) | En curso · P0 | Preflight vivo Fila 4, checkout íntegro, volumen XTS-AES256/Protection On/100 %, protector/read-back y root protegido; dead-man condicional a ubicación. | Gate para fuentes privadas/DB/runtime local; no bloquea rama/código/fixtures remotos. |
| [EP-TASK-005](../../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md) | Pendiente · P0 piloto | Tras EP-TASK-003 PASS, extraer paquete P004, verificar SHA/manifest, importar DUG v388 y probar STDIO/RDC; REGISTER interactivo. | Piloto P004 instalado/read-back y evidencia para GOV-TASK-003; panel solo en release 1.0.0. |
| EP-TASK-004 | En curso · independiente | Reconstrucción/aceptación de la GUI de bóveda. | No bloquea build Sink ni bootstrap DPAPI salvo dependencia técnica demostrada. |

EP-TASK-002 (Backblaze), EP-TASK-001 (NCL) y PPR cross-host no forman parte del camino crítico.

## 3. Secuencia optimizada

| Fase | Actividad | Puede avanzar sin host | Gate para pasar |
|---|---|---|---|
| 0 · Baseline | Pins DUG v388/core 0.1.28, control, Fila 4 designado, ramas y fuente de código. | Sí. | Contrato y fuentes verificadas; ubicación/host queda preflight EP. |
| 1 · Reconciliar | MCP-OCP-02: rama nueva desde main y port selectivo. | Sí. | Diff revisable, base, SDK/RID fijados. |
| 2 · Piloto Sink | MCP-OCP-05: GOW:ARR → DUG → SINK:P004 y respuesta con pin/hash. | Sí para código; fuente privada en host protegido. | Contrato P004 y respuesta exacta; fail-closed. |
| 3 · Prueba IPZ | MCP-OCP-03/04 + GOV-TASK-007: initialize/tools/list/tools/call P004 y camino real IPZ/RDC/STDIO. | Parcial; E2E requiere Fila 4 y contexto IPZ. | Respuesta visible al modelo con pin/hash; consola sola no basta. |
| 4 · Generalizar | MCP-OCP-05/03 + GOV-TASK-001/008: P001–P043, lote ordenado y negativos. | Sí tras contrato P004. | 43 casos, lote/hash/frecuencia PASS. |
| 5 · Panel | MCP-OCP-13 tras congelar schema, en paralelo con generalización. | Sí con fixtures. | Panel visual y ciclo EP ACTIVE/caída/cierre probado; requerido en 1.0.0. |
| 6 · Paquete | MCP-OCP-10/07: un ZIP reproducible servidor+panel. | Sí. | Manifest/SHA, extracción y read-back PASS. |
| 7 · Preparar Fila 4 | EP-TASK-003: preflight, checkout protegido, root y dead-man según ubicación. | Parcial según RDC. | Identidad/USERPROFILE, XTS-AES256/Protection On/100 %, root y read-back; dead-man PASS si no CECEQ. |
| 8 · Piloto/bootstrap y release | EP-TASK-005 + MCP-OCP-12: piloto P004 y después instalación final en checkout Fila 4. | No. | Gates EP, consentimiento REGISTER, fuente/importación, STDIO, panel y SHA instalados. |
| 9 · Aceptación | GOV-TASK-003 y GOV-TASK-013. | No. | E2E completo servidor+panel y evidencia por frente; FOL1 separado. |

Se usará un único harness del servidor y fixtures del panel: primero corte vertical P004, después 43 IDs/negativos. El panel avanza en paralelo una vez congelado el schema. Dos niveles de pruebas, un build final, un ZIP servidor+panel, un manifest y recibos por frente. Preparación EP corre en paralelo; instalación/autoapertura solo después de los gates EP aplicables a la ubicación verificada. Frecuencia Sink y latencia RDC no se mezclan.

## 4. Bloqueos y mitigación

| Bloqueo | Evidencia disponible al planificar | Tratamiento |
|---|---|---|
| Código productivo no está en `main` | Hay código C# en ramas remotas; el ZIP 0.1.0 usa pins v377/core v0.1.20 y no está en el repo. | Reconciliar y portar fuente; no recuperar binario ni depender de una terminal histórica. |
| Sink no implementado | El catálogo actual identifica 43 IDs/MDP; el resolver de texto individual no está desplegado en main. | Implementar Sink explícito; no inferir applicability/dependencies faltantes. |
| Root de datos fuera del perímetro cifrado | El código candidato usa `%LOCALAPPDATA%\\SeryMente\\OCP MCP` por defecto. W: y los volúmenes de PC-14/PC 7 son historia de otros perfiles; no prueban Fila 4. | Validar/crear root protegido en Fila 4 mediante preflight vivo; no heredar estado de otro host. Sin esto no importar fuentes ni instalar runtime. |
| Workspace no migrado | Última evidencia: 195 archivos/11 directorios en staging; no hay manifiesto de destino ni segundo read-back. Los estados de W:/PC-14/PC 7 no acreditan la protección de Fila 4. | EP-TASK-003; preflight de origen/destino, preservar el origen hasta read-back íntegro y validar el perímetro del destino. |
| Capacidad RDC agotada | Última evidencia reportó `remote_calls_left_pct=0`; puede estar desactualizada. | Comprobar disponibilidad una sola vez al comenzar la fase EP; si sigue en 0, pausar solo operaciones remotas y continuar MCP/Gobernanza por GitHub. No repetir sondeos ni eludir cuota. |
| Destino designado; preflight pendiente | El operador designó Fila 4; la identidad técnica y la ubicación física siguen pendientes de lectura en vivo. | No volver a pedir selección. Verificar usuario/SID y host al abrir la fase EP. Aplicar el dead-man solo si la ubicación confirmada está fuera de CECEQ; probarlo antes del runtime persistente. |
| Transporte real ChatGPT→RDC→stdio | Hubo smoke JSON-RPC manual en root temporal; no demuestra bridge de uso final. | Corte vertical P004 por el mismo camino de uso antes de generalizar. |
| Autenticación GitHub local | Conector GitHub de ChatGPT está autenticado; el token no se transfiere al perfil Windows. | Verificar `gh auth status` en el perfil final; si falta, login web interactivo local. |
| Provisión del operador | El build histórico no creó trust root en perfil real. | `provision-operator` + `REGISTER <SID>` local, con operador presente; no automatizar ni registrar SID en Git. |
| Metadatos normativos incompletos | Fuente no declara campos de aplicabilidad/activación. | Mantener `MCP-NORMATIVO=DESACTIVADO`; Sink devuelve texto solicitado y trazable, no dictamen. |

## 5. Insumos del operador

**Destino designado por el operador:** alias funcional Fila 4. No volver a pedir selección. Antes de operaciones locales, revalidar el perfil efectivo y los permisos, sin persistir identificadores temporales de RDC. La ubicación física sigue `UNCLASSIFIED`; CECEQ no fue confirmado. El preflight parcial y su estado vigente están en EP-TASK-003/OEP §§122–123.

Acciones locales futuras, sin enviar secretos por chat:

- Si el perfil destino no está autenticado para el repositorio privado, el operador realiza `gh auth login --web` en esa misma sesión Windows; el token permanece en el almacén local.
- El operador ejecuta `provision-operator` y confirma `REGISTER <SID>` en la consola local cuando el paquete y la ruta de datos estén verificados.
- El RecoveryPassword vigente ya aparece custodiado y leído de vuelta en EP Vault; no se solicita volver a copiarlo ni publicarlo.

No son insumos por ahora: contraseña, token, SID, RecoveryPassword, B2, OAuth Jules, Cloudflare, DNS, Vercel, GitHub Actions ni nuevas generaciones/folios.

## 6. Aceptación integral

1. GOW:ARR y DUG se recuperan desde fuentes importadas, con identidad/procedencia/hash verificados.
2. Los 43 SINK:Pxxx devuelven exactamente su texto desarrollado y hash; sin sustitución por memoria ni MDP.
3. Batch conserva orden, resultados y evento de frecuencia individual por recuperación exitosa.
4. Manifiesto canónico coincide con el contenido exacto y su SHA-256.
5. Matriz semántica GOV-TASK-001 y suite MCP cubren positivos, negativos, obsolescencia, desconexión y corrupción.
6. Round-trip real ChatGPT/RDC/stdio probado; latencia solo se acepta con ambos extremos observables.
7. DB, backups y runtime en almacenamiento protegido; provisión local verificada.
8. E2E Gobernanza PASS con evidencia y read-back.
9. El panel abre al entrar EP ACTIVE, diferencia proceso/protocolo/fuentes/readiness, informa caída/desconexión, no expone payloads y cierra sin proceso huérfano.
10. IPZ/FOL1 conserva su gate independiente; no bloquea el release MCP-OCP.
11. MCP-NORMATIVO desactivado; sin endpoints públicos ni secretos en repo/logs/salida.

## 7. Estado de planificación

- **Autorización Sink:** directa del operador y vigente.
- **Implementación Sink en main:** NO IMPLEMENTADA.
- **Panel MCP-OCP-13:** especificado y autorizado; NO IMPLEMENTADO.
- **Código fuente candidato:** recuperable desde ramas remotas; requiere reconciliación con main y pins actuales.
- **Build/paquete vigente:** NO GENERADO.
- **Workspace/volumen:** el estado histórico de W:/PC-14/PC 7 no acredita Fila 4. Checkout protegido, manifest y segundo read-back en Fila 4 pendientes.
- **Instalación/Bootstrap EP:** NO INICIADOS.
- **E2E:** NO EJECUTADA.
- **IPZ nativa/FOL1:** pendientes; MCP-NORMATIVO sigue desactivado.

**Siguiente transición:** MCP-OCP-02 → corte GOW:ARR/DUG/SINK:P004 → pruebas mínimas → preparación de IPZ por GOV-TASK-007 → E2E P004 desde contexto IPZ por RDC/STDIO. EP prepara Fila 4 y su root protegido en paralelo. Tras P004, generalizar 43, desarrollar el panel y cerrar el paquete final 1.0.0.


## 8. Contrato de producto consolidado · instrucción del operador · 2026-11-09

Esta sección incorpora el encargo de consolidación básica y funcional de MCP-OCP como alcance rector de las tareas técnicas del sprint. No crea un proyecto, OCP, control, servidor ni backlog paralelo.

### Resultado del producto

Entregar MCP-OCP como servidor MCP propio de la Metodología Ser y Mente: sencillo, confiable, seguro, reproducible y mantenible con ingeniería profesional básica. Debe facilitar consultas de DUG, Samantha, GOW/§ARR, documentación y objetos OCP, versiones, procedencia y evidencia; además, apoyar el desarrollo de proyectos gobernados. Permanece completamente separado de Khora-MCP.

### Arquitectura y límites no negociables

- C# / .NET y protocolo MCP oficial; proceso local Windows por STDIO, invocado por cliente MCP compatible y la vía RDC autorizada.
- Reutilizar el núcleo, almacenamiento y dependencias existentes que superen la revisión. No introducir base, servicio, framework o dependencia adicional sin necesidad demostrada.
- Fuentes del repositorio privado `SeryMente/metodologia`; almacenamiento local protegido.
- Sin servicio público, túnel, listener de red innecesario, endpoint Internet ni integración con Khora.
- MCP-NORMATIVO permanece DESACTIVADO. Sink es recuperación de contenido, no evaluación ni aplicación normativa automática.
- No modificar DUG, IPZ, credenciales ni secretos de otros proyectos; no ejecutar escritura remota como parte de este MVP. No añadir herramientas MCP de escritura salvo que una necesidad existente y autorizada lo demuestre.

### Capacidades mínimas

1. **Diagnóstico real:** diferenciar proceso vivo de servidor listo; exponer estado MCP, importación de fuentes, vigencia e integridad, configuración local del operador y capacidad operativa.
2. **GOW:** recuperar §ARR desde la fuente importada y verificada.
3. **DUG:** devolver versión, firma, commit, Git Blob SHA, SHA-256, adquisición, vigencia/verificación e inventario de principios y metadatos realmente disponibles.
4. **Sink individual:** resolver SINK:P001–SINK:P043 y devolver ID, título, pin exacto de DUG y SHA-256 del texto.
5. **Lotes:** aceptar varios IDs, conservar estrictamente el orden solicitado y generar resultado, huella y evento individual solo para cada recuperación íntegra y satisfactoria. No sustituir faltantes con memoria ni MDP.
6. **Documentos/OCP:** permitir consulta de documentación y objetos OCP únicamente dentro de fuentes y rutas autorizadas, sin convertir el servidor en un lector arbitrario del disco.

### Seguridad y calidad esenciales

- Acceso limitado a fuentes/rutas autorizadas; validar entradas y prevenir traversal o lecturas fuera de raíz.
- Rechazar fuente ausente, antigua, alterada, no importada o sin procedencia verificable; ante discrepancia, detener esa operación y explicar el motivo.
- Respetar autorizaciones locales; proteger fuentes y datos; no guardar ni mostrar credenciales, tokens, contraseñas o secretos en repositorio, respuestas o logs.
- Código modular y legible, responsabilidades claras, nombres descriptivos, funciones pequeñas, configuración separada, errores controlados, logs sanitizados y cierre limpio.
- Mantener solo patrones, abstracciones y dependencias que resuelvan una necesidad concreta.

### Pruebas de salida obligatorias

- Build limpio; inicialización de cliente MCP; tools/list y tools/call; respuestas correctas.
- Recuperación íntegra individual y por lotes en orden.
- Coincidencia de hashes con fuente; rechazo ante fuente ausente/alterada/antigua y ante entradas inválidas.
- Cierre limpio al desconectar.
- Ausencia demostrada de exposición de red no autorizada.
- Automatizar pruebas repetibles; usar MCP Inspector solo cuando añada valor. Build PASS por sí solo no es aceptación.

### Paquete y entrega

Generar ejecutable local independiente de una terminal de desarrollo, con dependencias necesarias, configuración de ejemplo, manifiesto de archivos, SHA-256 e instrucciones simples. Verificar extracción y lectura de vuelta. Debe poder reconstruirse desde el código fuente disponible en GitHub. La instalación persistente, el root de datos definitivo y el alta interactiva del operador pertenecen a EP y conservan sus gates; nunca ejecutar REGISTER <SID> sin consentimiento explícito y presencia del operador.

### Informe de cierre exigido

Identificar por separado funcionalidades implementadas y probadas, pruebas PASS/FAIL, defectos corregidos, archivos cambiados, versiones DUG/OCP usadas, commit, hash y ubicación del paquete, y pendientes de instalación/uso. Cada estado se clasificará como propuesto, implementado, probado, publicado, instalado o aceptado; no se infiere uno del otro.

**Criterio de éxito:** inicia localmente con sencillez, conecta por STDIO, recupera ARR/DUG/principios/documentación permitida, demuestra procedencia e integridad, rechaza entradas o fuentes no verificables, protege la identidad y se reconstruye de forma reproducible.

## 9. Diseño ejecutable del sprint · flujo mínimo

| Secuencia | Frente y tareas existentes | Trabajo acotado | Salida verificable / gate |
|---|---|---|---|
| 0 · Baseline | Gobernanza: GOV-TASK-015. MCP: MCP-OCP-02. EP: preflight EP-TASK-003/005, sin instalar | Fijar pins desde main; leer controles; inventariar árbol, ramas, código y pruebas; declarar duplicados y discrepancias | Matriz única de estado y dependencias. No ejecutar sobre ramas históricas directamente |
| 1 · Reconciliar | MCP-OCP-02 | Crear rama candidata desde main actual; trasladar selectivamente lo reutilizable de las ramas históricas; documentar cada componente conservado/corregido/descartado | Rama limpia basada en main, diff revisable y pruebas de regresión |
| 2 · Corte vertical | MCP-OCP-05 + MCP-OCP-03 + MCP-OCP-04; GOV-TASK-008 | Validar fuente/importación y hacer funcionar, por el mismo transporte final, initialize → tools/list → GOW:ARR → DUG → SINK:P004 → respuesta con pin/hash → cierre | Primer recorrido real RDC/stdio PASS. Si falla, corregir aquí antes de generalizar |
| 3 · Generalización | MCP-OCP-05 + MCP-OCP-03; GOV-TASK-001/008 | Extender a 43 IDs, recuperación individual y batch ordenado; eventos individuales solo por recuperación completa; hash del paquete exacto | 43 casos positivos, lote ordenado, hashes y frecuencia por ID; 8 casos negativos/frontera de MDP como matriz de Gobernanza |
| 4 · Robustez | MCP-OCP-03/04/10; GOV-TASK-003 | Suite automatizada de protocolo, parámetros, datos faltantes/obsoletos/corruptos, rutas, permisos, logs, cierre y ausencia de red | Evidencia de pruebas nueva ligada al commit. Ningún PASS histórico sustituye esta suite |
| 5 · Paquete | MCP-OCP-10/07 | Build reproducible y paquete autónomo; manifiesto, hashes, configuración de ejemplo y runbook; extracción/read-back | Artefacto y evidencia cotejados; paquete reconstruible desde GitHub |
| 6 · Instalación | EP-TASK-003/005 + MCP-OCP-08/12 | Instalar el ejecutable dentro del checkout local de Metodología, en `frentes/mcp-metodologia/instalacion-local/`; proteger el root de datos independiente | Instalación y read-back solo después de paquete PASS y gates EP. Sin secretos por chat |
| 7 · Aceptación | GOV-TASK-003/007/009; GOV-TASK-013 como medición paralela | E2E con ChatGPT/RDC/stdio; validar ARR, DUG, Sink y fail-closed; medir latencia solo si ambos extremos son observables | Recibo de aceptación con evidencias. GOV-TASK-007/IPZ y eventual FOL1 siguen su gate separado; FOL1 no bloquea desarrollo |

### Reglas de fluidez y control de alcance

- Un solo producto, servidor, almacenamiento y paquete. No crear un servidor Sink independiente ni una arquitectura de despliegue.
- Un corte vertical funcional antes de extender a 43. Un build final de release; los builds intermedios serán pruebas locales, no paquetes entregables.
- Aprovechar el almacenamiento y los módulos actuales solo después de verificar seguridad, vigencia y pruebas; no conservarlos por el simple hecho de existir.
- Mantener separados los tres responsables: Gobernanza define contrato/pruebas/aceptación; MCP-OCP construye y empaqueta; EP prepara entorno e instala. RDC es transporte, no frente.
- GOV-TASK-013 conserva su responsable y alcance propios; se consume como dependencia de medición, sin apropiarse de su ejecución.
- Quedan fuera: cambios al DUG/IPZ, MCP-NORMATIVO, Khora, MOD-SYNC, Cloudflare, Jules, B2 y servicios públicos.
- No cerrar el sprint por documentación, compilación o smoke aislado: se requiere prueba del recorrido real, paquete verificado e instalación/aceptación por etapas.

### Bloqueadores y condiciones ya observados

1. **Código candidato:** las ramas `integration/ocp-mcp-0.1.0-selective-20261101` y `build/ocp-mcp-mvp-0.1.0` están divergidas de main. En la comparación más reciente: integración, 3 commits por delante y 518 por detrás; build, 11 por delante y 837 por detrás. No fusionar ramas completas; portar selectivamente a una rama nueva basada en main.
2. **Pins obsoletos:** cualquier referencia del plan/backlog a DUG v385, v377 o core v0.1.20 es histórica; usar el baseline vigente del encabezado de esta tarea.
3. **Fila 4:** la última observación histórica registró C: FullyEncrypted/100 %, `ProtectionStatus=Off`, `XtsAes128`; no acredita protección efectiva. EP debe revalidar en vivo y preparar el volumen de trabajo XTS-AES256/Protection On/100 % y root protegido.
4. **Herramientas locales Fila 4:** Git y GitHub CLI se observaron instalados históricamente (2.45.2/2.52.0), pero autenticación y checkout completo no están verificados en la sesión actual. Resolver en el preflight; no bloquear desarrollo remoto por GitHub.
5. **Presencia/consentimiento:** autenticación del perfil, SID y REGISTER son operaciones interactivas locales. No trasladar tokens ni pedir secretos por chat.

### Insumos del operador

No falta selección de host: Fila 4 ya fue designada. Falta preflight vivo de identidad, permisos, protección y ubicación física. Solo se requerirá presencia del operador en el gate de instalación/registro local para confirmar las acciones interactivas. No se solicitan credenciales por chat.

**Estado de salida de esta planificación:** DISEÑO CONSOLIDADO · NO INICIADO. Este plan no acredita implementación, pruebas, build, paquete, instalación ni aceptación.


### Ubicación final del ejecutable MCP-OCP

El requisito de instalación local queda fijado así para servidor y panel:

- **Checkout propietario:** `SeryMente/Repositorios/Metodologia/metodologia/`.
- **Carpeta de instalación:** `frentes/mcp-metodologia/instalacion-local/` (Windows, relativa al checkout: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`).
- **Contenido:** ejecutable MCP-OCP, panel Windows, runtime/dependencias, launcher/configuración de ejemplo, schema de observabilidad y manifiesto/hash del conjunto instalado.
- **Git:** materialización local excluida de commits; binarios generados no se mezclan con el código fuente ni con el paquete reproducible versionado.
- **Fuera del checkout:** DB SQLite, claves DPAPI, datos importados sensibles, logs operativos y backups usan una raíz de datos protegida independiente. Nunca guardar secretos/datos sensibles en `instalacion-local/` ni en Git.
- **Secuencia:** build y paquete verificado → checkout completo/sincronizado → extracción/instalación local → configurar root de datos protegido → importar fuentes → `provision-operator` solo con presencia/consentimiento local → cliente STDIO/RDC y read-back.

Esta ruta es el destino obligatorio del ejecutable; no sustituirla por `%LOCALAPPDATA%` como ubicación del programa. LocalAppData solo podrá usarse como root de datos si EP demuestra protección efectiva y lo configura expresamente.


### Paralelización para terminar 1.0.0 sin tiempos muertos 

**Carril A — producto (MCP-OCP):** iniciar MCP-OCP-02 desde main; portar módulos selectivamente. Después del corte vertical ARR → DUG → SINK:P004 y del schema de estado/eventos, implementar P001–P043 y MCP-OCP-13 en paralelo; ejecutar suite combinada. MCP-OCP-03/04/10 avanzan junto con 05 durante la estabilización; no se espera a terminar toda la funcionalidad para diseñar pruebas o manifiestos. MCP-OCP-07 empaqueta el candidato final una sola vez tras PASS.

**Carril B — aceptación (Gobernanza):** GOV-TASK-001 prepara/ejecuta matriz MDP; GOV-TASK-008 congela contrato de respuesta/lote/frecuencia; GOV-TASK-009 valida contenido ARR. Estas tres tareas pueden correr mientras MCP desarrolla. GOV-TASK-003 espera solo al ejecutable instalado para la E2E final. GOV-TASK-013 mide después de que ambos extremos sean observables; no se duplica esa función.

**Carril C — destino local (EP):** EP-TASK-003 verifica checkout íntegro, usuario/dispositivo, protección BitLocker efectiva y dead-man LOC-OTHER en paralelo con el desarrollo. No instala un paquete inexistente. EP-TASK-005 prepara el procedimiento y ejecuta extracción/read-back/bootstrap más apertura del panel solo cuando MCP-OCP-07 entregue paquete PASS y los gates EP estén en PASS.

**Punto de sincronización único:** paquete verificado + checkout sincronizado + root de datos protegido + dead-man PASS. Entonces MCP-OCP-12 materializa en frentes/mcp-metodologia/instalacion-local/; EP-TASK-005 completa su aceptación local; Gobernanza ejecuta GOV-TASK-003. Ningún frente espera por trabajos que no dependen de él.


## 8. Panel de observabilidad incluido en MCP-OCP 1.0.0

Por instrucción directa del operador se incorpora MCP-OCP-13 como tarea P0 del release, sin crear un nuevo OCP ni un control paralelo.

**Contrato:** [PANEL-OBSERVABILIDAD.md](../../mcp-metodologia/PANEL-OBSERVABILIDAD.md). Aplicación Windows nativa WPF, C#, ligera y de solo lectura, incluida en el paquete junto al servidor. EP escribe/coteja `monitor/session.json` (sesión y atestación de protección con timestamp); MCP-OCP escribe `monitor/state.json` y `monitor/events.jsonl`. La vista dominante combina esas fuentes y enseña estado global, sesión EP, proceso, protocolo STDIO, fuentes/DUG, operador, data root, actividad actual, últimas llamadas y una sola atención prioritaria. Icono+texto+color; sin parpadeo, sonido ni métricas simuladas.

**Integración cruzada:** MCP-OCP construye y publica snapshots/eventos saneados dentro del data root protegido. EP-TASK-005 escribe/coteja `session.json` y abre el panel solo en `EP_SESSION=ACTIVE`, incluso si el servidor aún no inició; lo mantiene mientras EP siga activa y lo cierra al terminar. EP conserva ACL, root protegido y ciclo de vida de host. EP-TASK-003 no se modifica; el dead-man no adquiere heartbeat ni monitor genérico.

**Pruebas:** panel waiting-server, initialize, readiness parcial, fuente alterada/ausente, operador/root no configurado, tool success/failure, crash del proceso, sesión EP finalizada, ACL/JSON inválidos, stdout STDIO intacto, ausencia de red y manifest/SHA. MCP Inspector es opcional para diagnóstico de desarrollo; ni Inspector ni MCP Studio se distribuyen en producción.

**Estado:** alcance/documentación actualizados; panel no implementado, no compilado, no incluido en paquete ni instalado.

---

## Rectificación del destino y fast path IPZ/SINK · 2026-11-10

Esta sección sustituye como estado vigente del sprint las menciones anteriores a PC 7/LOC-OTHER en esta coordinación. El operador designó **Fila 4** como destino de trabajo e instalación porque corresponde a la única sesión RDC disponible indicada. PC 7 no queda como alternativa ni fallback.

- **Último destino designado:** alias funcional Fila 4. No se retienen Device ID, hostname, usuario/SID ni SessionId; EP debe revalidar perfil efectivo, privilegios, permisos y acceso antes de escribir.
- **Ubicación física:** PENDIENTE_DE_VERIFICACIÓN. La terminal Fila 4 y la ubicación son dimensiones distintas. No clasificar automáticamente como CECEQ ni LOC-OTHER; EP aplicará conservación o dead-man después de comprobar el lugar.
- **Checkout:** `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`.
- **Piloto:** `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\piloto-sink\\`.
- **Producto final:** servidor+panel 1.0.0 en `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`.
- **Datos:** DB/DPAPI/fuentes/logs/backups en `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout y dentro del volumen protegido por EP.
- Última lectura histórica de Fila 4: C: `FullyEncrypted/100 %`, `ProtectionStatus=Off`, `XtsAes128`; no acredita protección efectiva. El preflight debe repetirlo en vivo y verificar workspace XTS-AES256, Protection On, 100 %, protector recuperable y SHA/read-back. No reutilizar W:/VHDX/DPAPI/recovery/workspace de PC-14 ni de PC 7.

### Nuevo orden de ejecución

1. **MCP-OCP-02:** rama nueva desde HEAD de main; comparar las ramas históricas solo como fuentes y portar por componente.
2. **MCP-OCP-05 — piloto P004:** implementar `GOW:ARR`, identidad DUG v388 y `SINK:P004` con texto íntegro, pin/commit/blob y SHA-256.
3. **MCP-OCP-03/04 — prueba piloto:** contrato mínimo, errores/fuentes inválidas, initialize/tools/list/tools/call, STDIO/RDC y cierre limpio.
4. **EP-TASK-003/005 + GOV-TASK-007:** preparar checkout/root protegido en Fila 4; elaborar IPZ candidato bajo 1.500 caracteres con `GOW:ARR → DUG → MDP → SINK:Pxxx`; primer caso P004. La escritura de IPZ nativo y su read-back son un acto separado, no se presumen.
5. **GOV-TASK-003/007 + MCP-OCP-04:** demostrar uso real desde contexto IPZ por RDC → MCP-OCP STDIO y respuesta visible al modelo con pin/hash. Una llamada JSON-RPC desde consola solo valida transporte y no acredita E2E IPZ.
6. Tras aceptar el piloto, **MCP-OCP-05/03** generalizan a 43, lotes ordenados, hashes, eventos y negativos.
7. **MCP-OCP-13** implementa el panel WPF cuando el schema esté congelado y en paralelo con la generalización. Baja a P1 de secuencia, pero sigue obligatorio dentro de 1.0.0; no bloquea P004.
8. **MCP-OCP-10/07** cierran manifest/build/ZIP reproducible servidor+panel. **MCP-OCP-12/08 + EP-TASK-003/005** efectúan bootstrap/instalación y read-back en Fila 4 después de los gates. **GOV-TASK-003** acepta el producto integral.

FOL1 no bloquea el piloto P004 ni la construcción del servidor; su activación conserva el gate propio posterior al IPZ nativo verificado. MCP-NORMATIVO continúa DESACTIVADO. No se modifica DUG, ART-025/027, IPZ nativa ni controles desde esta rectificación.

**Estado:** destino y secuencia documental corregidos; no hay preflight Fila 4, branch, código, piloto, IPZ nativo, build, paquete, instalación ni E2E ejecutados por esta actualización.



## Reconciliación del contrato Sink · DUG v388 · 2026-11-10

Gobernanza publicó la rectificación de ART-027 mediante el evento `C-GOBERNANZA-ART027-SINK-LOCAL-RECONCILIACION-20261110-01`. El contrato operativo vigente es `SINK:Pxxx` como operación local del servidor MCP-OCP por STDIO, invocada vía RDC. La respuesta debe contener un único principio íntegro y su procedencia/pin/hash; la frecuencia registra solo recuperaciones satisfactorias. Los diseños de Worker, Cloudflare, D1/KV, Analytics Engine, URLs cortas y aliases HTTP quedan supersedidos. `MOD-SYNC` de EP es distinto y no participa en este flujo.

**Pin DUG vigente:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. En respuesta al bloqueo, el titular MCP-OCP rebaselinó su núcleo a v0.1.28 y su backlog a v0.9, ambos con DUG v388/NX-388m. EP actualizó OEP a v0.3.58 y las tareas EP-TASK-003/005 para registrar el preflight parcial, el VHDX de preparación vacío/sin cifrar y la pausa sobre el punto de montaje. Los nuevos pins y referencias están asentados en esta ficha; no implican que exista rama/código nuevo ni preflight host.

**Estado:** contrato documental corregido; implementación P004, pruebas nuevas, importación de fuente, instalación local, escritura/read-back nativos de IPZ y aceptación E2E siguen pendientes de evidencia. El estado EN_CURSO no declara código construido ni instalación ejecutada.

## Matriz única de dependencias y bloqueo urgente · 2026-11-10

### Bloqueador P0 actual

**MCP-OCP-02 es la primera acción técnica crítica:** crear rama limpia desde el HEAD actual de `main` y reconciliar código/SDK/RID con el núcleo MCP-OCP v0.1.28 y DUG Samantha v388/NX-388m. El contrato ART-027 ya está actualizado; no compilar ni aceptar el piloto con pins v386 ni portar ramas históricas completas. La rama y el código no sensible no dependen del preflight EP.

### Camino crítico, precedencias y salida

1. **MCP-OCP-02 (P0):** HEAD actual de main → rama limpia → mapa REUSE/ADAPT/REWRITE/DROP → SDK/RID fijados. Salida: rama/diff revisables y source pins v388.
2. **MCP-OCP-05 (P0):** sobre esa rama, corte `GOW:ARR → DUG → SINK:P004`. Desarrollo con fixtures sintéticos en paralelo; respuesta real exige fuente importada y pins cotejados.
3. **MCP-OCP-03 (P0, paralelo):** contrato, positivos/negativos, integridad y fail-closed con fixtures; repetir contra fuente real después del gate EP.
4. **MCP-OCP-04 (P0):** harness y smoke STDIO/RDC; la E2E IPZ exige piloto instalado y respuesta visible al modelo. JSON-RPC de consola no cumple E2E.
5. **EP-TASK-003 (P0 host):** Fila 4 preflight vivo, ubicación, checkout íntegro, volumen XTS-AES256/Protection On/100 %, protector/read-back y root protegido. Dead-man solo fuera de CECEQ. Bloquea importación privada, DB, runtime e instalación; no la rama ni fixtures.
6. **EP-TASK-005 + MCP-OCP-12 (P0 piloto local):** después de EP-TASK-003 PASS y paquete P004 verificado, extraer `instalacion-local/piloto-sink/`, root separado, importar DUG v388; `REGISTER <SID>` con presencia/consentimiento. Leer de vuelta.
7. **GOV-TASK-007/003:** candidato IPZ después de congelar P004; prueba real IPZ → RDC → STDIO → respuesta visible con pin/hash. IPZ nativa/read-back separado. FOL1 no bloquea piloto.
8. **Después de P004 PASS:** MCP-OCP-05/03 generalizan P001–P043 y lotes; GOV-TASK-001 ejecuta matriz 43+8; GOV-TASK-008 acepta frecuencia/hash/manifiesto.
9. **Release 1.0.0:** MCP-OCP-13 panel obligatorio después del schema y en paralelo; MCP-OCP-10/07 manifiesto/build/ZIP; MCP-OCP-12/08 + EP-TASK-005 instalación/handoff final.

### Exclusiones y trabajo no bloqueante

EP-TASK-004 GUI de bóveda y EP-TASK-002/Backblaze no bloquean P004 ni el build salvo dependencia material demostrada. MCP-OCP-06/11 Jules y MCP-OCP-09 PPR/cross-host permanecen fuera del sprint. No reabrir `applicability`, `activation_conditions`, `mandatory` o `dependencies` como condición de Sink; ART-027 v388 define recuperación de contenido, no selección normativa automática. `MCP-NORMATIVO` permanece `DESACTIVADO`.

### Estado de evidencia

**Documentación:** DUG v388, tareas Gobernanza, núcleo/backlog MCP-OCP y OEP/tareas EP rebaselined y leídos de vuelta. **Estado vigente de host:** preflight Fila 4 observado `PARTIAL_FAIL`; VHDX vacío y sin BitLocker, diseño de montaje sobre Desktop\\SeryMente no aceptado, checkout parcial. **No verificado/pendiente:** rama MCP-OCP-02 válida desde main, código P004, pruebas nuevas, manifest/paquete piloto, importación, instalación, IPZ nativa, E2E y panel. No convertir el cierre documental en PASS de producto.

---

## Reconciliación de la rama candidata y estado real del gate EP · 2026-11-10

### Hallazgo MCP-OCP

La consulta de referencias de GitHub encontró la rama `feat/mcp-ocp-sink-p004-pilot-20261110`. Su punta es `1676901cc09af6fcec4d052800b031e4c2f1ab40`, anterior al main de coordinación. Los cotejos históricos del 2026-11-10 mostraron que main avanzaba respecto de esa referencia y que esta no tenía commits exclusivos que pudieran portarse como una base nueva. Los documentos de esa rama conservaban pins DUG v386/core v0.1.27, incompatibles con el baseline v388/v0.1.29 actual. No usar esa referencia como base ni fusionarla completa; MCP-OCP-02 debe crear una rama limpia desde el HEAD vigente.

**Conclusión:** la rama existe como referencia, pero no satisface MCP-OCP-02. No se declara una rama limpia rebaselined ni código P004 implementado. La salida de MCP-OCP-02 sigue siendo una rama nueva/limpia desde el HEAD de `main` vigente, con mapa REUSE/ADAPT/REWRITE/DROP, SDK/RID fijados y lectura de vuelta del pin DUG v388. No fusionar la referencia histórica completa.

### Estado EP que afecta al camino local

OEP v0.3.58 §123 y EP-TASK-003 registran que el VHDX de 30 GiB fue creado, GPT/NTFS, vacío, con `W:` como último punto de acceso observado y sin BitLocker. El origen `Desktop/SeryMente` permanece preservado y no hay copia ni manifiesto SHA-256. La propuesta de montar el volumen cifrado bajo la ruta original no está aceptada; se mantiene la pausa sobre nuevas operaciones de almacenamiento. La ubicación física de Fila 4 permanece `UNCLASSIFIED`; el operador ya había reportado presencia física ante el dispositivo, pero no confirmó CECEQ.

EP-TASK-003: `en_curso / PARTIAL_FAIL`. EP-TASK-005: `pendiente`. No se ejecutan checkout protegido, importación privada, DB, provisión de operador, runtime ni instalación piloto hasta que EP-TASK-003 llegue a PASS y MCP entregue paquete P004 verificable.

### Camino crítico que prevalece

1. **MCP-OCP-02:** crear/reconciliar rama desde el `main` vigente (no desde la referencia candidata antigua).
2. **MCP-OCP-05:** corte vertical `GOW:ARR → DUG v388 → SINK:P004`; usar fixtures para la vertical inicial mientras las fuentes privadas sigan bloqueadas por EP.
3. **MCP-OCP-03/04:** avanzar en paralelo con pruebas contractuales sintéticas y harness/smoke STDIO/RDC. No confundir smoke de consola con E2E IPZ.
4. **EP-TASK-003:** resolver el diseño para proteger el workspace conservando la ruta `Desktop/SeryMente`, completar volumen XTS-AES256/Protection On/100 %, protector custodiado/read-back, checkout íntegro y root protegido. El dead-man se implementa y prueba solo si la ubicación física confirmada es distinta de CECEQ.
5. **EP-TASK-005 + MCP-OCP-12:** solo con EP-TASK-003 PASS y paquete P004/manifest/SHA/pruebas, instalar en `instalacion-local/piloto-sink/`, configurar el root protegido e importar fuentes fijadas a DUG v388.
6. **GOV-TASK-007/003:** preparar candidato IPZ y aceptar únicamente el recorrido real IPZ → RDC → STDIO → respuesta P004 visible al modelo; la escritura/read-back nativos de IPZ es acto separado.
7. Tras P004 PASS, generalizar P001–P043 y la matriz 43+8. El panel MCP-OCP-13 sigue obligatorio para release 1.0.0, pero no bloquea el piloto P004.

### Estado común

`SINK_P004_IPZ=NO_IMPLEMENTADO_NO_ACEPTADO` · `MCP_OCP_02=OPEN_STALE_BRANCH_FOUND` · `EP_TASK_003=PARTIAL_FAIL` · `EP_TASK_005=PENDING` · `IPZ_NATIVE=NOT_VERIFIED` · `FOL1=PREPARED_NOT_ACTIVE` · `MCP_NORMATIVO=DESACTIVADO`.

Esta reconciliación es documental y de referencias. No modifica el repositorio MCP-OCP, sus archivos de titularidad, DUG ni controles. Tampoco realiza nuevas operaciones en Fila 4.

---

## Sprint SINK-P004 · plan central vigente y handoff EP · 2026-11-10

**Nombre operativo oficial:** `SINK-P004`. **Propósito:** habilitar cuanto antes la primera recuperación SINK:P004 consumible desde el contexto IPZ real por RDC → MCP-OCP STDIO → respuesta íntegra visible al modelo. El producto completo sigue siendo MCP-OCP 1.0.0 (servidor + panel WPF). GOV-TASK-015 es el coordinador único del sprint; no crea otro frente ni cambia controles.

### Baseline canónico y situación actual

- DUG: Samantha v388/NX-388m · ART-027 · commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c` · blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- Núcleo MCP-OCP v0.1.30 · blob `4eea02bcc6dc086af7177ba8791b7e51fb205a2e`; backlog v0.11 · blob `a328dc4fcda6beb0a45ffcc09f68ab5c6407588f`.
- OEP v0.3.59 · blob `b29e806d2d9473f3828972a0c67d09bf7dcafc4e`; EP-TASK-003 `PARTIAL_FAIL`; EP-TASK-005 `PENDING`. OEP §124 deja preparado el relevo operativo al frente EP, sin modificar su control generación 3. La aceptación del handoff por EP queda pendiente.
- **Punta histórica de rama:** `1676901cc09af6fcec4d052800b031e4c2f1ab40`. El recuento exacto de distancia respecto de main se conserva solo en recibos de comparación de la fecha en que fue calculado; no se presenta como métrica viva. La conclusión estable es que la referencia no parte del main vigente y no cumple MCP-OCP-02.
- Control MCP-OCP generación 5, autorización y exclusiones sin cambios. Control EP generación 3 sin cambios. Control Gobernanza generación 17 sin cambios. Este coordinador no transfiere titularidad ni permisos entre frentes.

### Responsables por frente

- **MCP-OCP:** crear la rama limpia, portar código selectivo, construir P004, probar contrato/STDIO, fijar SDK/RID y generar paquete verificable. No opera el host EP.
- **Entorno Persistente:** retomar EP-TASK-003 y EP-TASK-005; resolver el diseño de almacenamiento conservando la ruta `Desktop/SeryMente`, completar el gate de Fila 4, proteger el root, importar fuentes e instalar el piloto después de recibir paquete probado. La pausa de almacenamiento no está levantada: el diseño VHDX/BitLocker sobre la ruta original sigue no aceptado.
- **Gobernanza:** mantener ART-027 v388 y GOW/IPZ, preparar el candidato compacto después de congelar contrato P004, validar MDP/semántica y ejecutar GOV-TASK-003 E2E. No declarar IPZ nativa modificada ni FOL1 activado.
- **Coordinación:** esta ficha consolida orden y dependencias, y revisa recibos de cada frente; no ejecuta host EP ni escribe código MCP-OCP.

### Camino crítico y paralelismo

1. **MCP-OCP-02 · P0:** rama nueva desde el HEAD vigente de main; mapa REUSE/ADAPT/REWRITE/DROP; SDK, target framework y RID fijados. No usar la rama candidata antigua como base.
2. **MCP-OCP-05 · P0:** corte vertical `GOW:ARR → DUG v388 → SINK:P004`, primero con fixtures sintéticos. Respuesta P004 íntegra, ID/título, pin, commit/blob, SHA-256 y fail-closed.
3. **MCP-OCP-03 · P0 paralelo:** pruebas de contrato con fixtures sintéticos desde ahora; repetir con fuente real tras EP PASS.
4. **MCP-OCP-04 · P0 paralelo:** preparar harness/smoke STDIO/RDC; ejecutar initialize/tools/list/tools/call:P004/cierre cuando exista build. Consola manual no equivale a E2E IPZ.
5. **EP-TASK-003 · P0 local (EP):** readquirir el estado vivo de Fila 4; presentar al operador el diseño recomendado para proteger `Desktop/SeryMente` conservando su ruta; no copiar/cifrar/mover/renombrar/desmontar/cambiar mountpoint antes de aceptación expresa; tras aceptar, completar XTS-AES256/Protection On/100 %, recovery Vault read-back, copia y SHA, checkout completo, root protegido y dead-man solo si ubicación confirmada fuera de CECEQ.
6. **GOV-TASK-007 · paralelo:** elaborar candidato IPZ compacto con `GOW:ARR → DUG → MDP → SINK:P004` cuando el contrato P004 quede congelado. Medir salvaguardas y límite nativo; escritura/read-back nativos es acto separado.
7. **EP-TASK-005 + MCP-OCP-12 · P0 local (EP):** solo tras EP-TASK-003 PASS y paquete P004 verificado + MCP-OCP-03/04 smoke PASS; instalar en `instalacion-local/piloto-sink/`, configurar root protegido, importar DUG v388, validar readiness. `REGISTER <SID>` requiere operador presente y consentimiento explícito.
8. **GOV-TASK-003 + GOV-TASK-007 + MCP-OCP-04:** aceptar piloto solo si la llamada real nace desde IPZ y la respuesta P004 aparece visible al modelo con texto íntegro y pin/hash.
9. **Después de P004 PASS:** generalizar P001–P043/lotes; GOV-TASK-001 ejecuta 43 positivos + 8 controles negativos/frontera; GOV-TASK-008 verifica integridad/frecuencia por recuperación satisfactoria.
10. **Release MCP-OCP 1.0.0:** MCP-OCP-13 panel WPF obligatorio tras congelar schema (en paralelo con generalización, no bloquea P004); MCP-OCP-10/07 manifiesto/build/ZIP; MCP-OCP-12/08 + EP-TASK-005 instalación/handoff final.

### Grafo de dependencias

`MCP-OCP-02 → MCP-OCP-05`

`MCP-OCP-03 (fixtures) ∥ MCP-OCP-04 (harness) ∥ GOV-TASK-007 (candidato IPZ) ∥ EP-TASK-003 (preflight/almacenamiento)`

`MCP-OCP-05 + MCP-OCP-03 + MCP-OCP-04 + EP-TASK-003 PASS → EP-TASK-005/MCP-OCP-12`

`EP-TASK-005 + respuesta P004 congelada + IPZ disponible → GOV-TASK-003 E2E`

`P004 PASS → generalización 43 + matriz 43+8 → panel/schema + manifest/build/ZIP → instalación final 1.0.0`

### Estado común que no debe sobreescribirse por inferencia

`SINK_P004=NOT_IMPLEMENTED_NOT_ACCEPTED` · `MCP_OCP_02=OPEN_STALE_BRANCH_FOUND` · `MCP_OCP_03=PARALLEL_FIXTURES` · `MCP_OCP_04=PARALLEL_HARNESS` · `EP_TASK_003=PARTIAL_FAIL` · `EP_TASK_005=PENDING` · `GOV_E2E=PENDING` · `IPZ_NATIVE=NOT_VERIFIED` · `FOL1=PREPARED_NOT_ACTIVE` · `MCP_NORMATIVO=DESACTIVADO`.

**Criterio de cierre del sprint:** el primer resultado útil es SINK:P004 operativo desde IPZ; el release 1.0.0 no se declara completo hasta panel, generalización, manifest/ZIP, instalación final y aceptación correspondiente. Las tres fuentes de frente conservan sus propios estados y evidencia.

---

## Rebaseline vigente · OCP MCP 1.0 · 2026-11-10

**Nombre canónico del programa:** OCP MCP 1.0. **Versión del producto:** MCP-OCP 1.0.0. **Primer hito funcional:** SINK:P004. El nombre anterior SINK-P004 queda como denominación histórica del primer corte, no del programa completo.

### Objetivo integral

Entregar un entorno OCP MCP que permita consultar SINK desde IPZ por RDC → MCP STDIO; trabajar desde equipos temporales/no confiables con workspace cifrado de sesión y caducidad; persistir y restaurar la carpeta de trabajo, la bóveda de variables de entorno y los datos de usuario/OCP; y observar el estado operativo desde el panel WPF.

### Hitos y secuencia · corte previo · SUPERSEDIDO POR REBASELINE APROBADO

1. **H1 · SINK:P004 desde IPZ:** respuesta íntegra visible al modelo con ID/título, DUG, commit/blob y SHA-256.
2. **H2 · Workspace cifrado verificado:** comprobar la protección que el operador reporta existente; apertura, bloqueo, cierre y desmontaje; no asumir que la existencia de un contenedor demuestra protección efectiva.
3. **H3 · Restore B2 verificado:** respaldar workspace, ciphertext de bóveda y datos elegibles; verificar upload, descarga, hashes y restauración aislada.
4. **H4 · Sesión efímera con vencimiento:** lease renovable; al expirar, cerrar procesos OCP, bloquear y desmontar workspace, destruir solo la clave efímera local y limpiar residuos OCP.
5. **H5 · Limpieza adaptativa:** detectar HDD/SSD/UNKNOWN al inicio mediante lectura no destructiva; usar ese dato solo para saneamiento complementario. En SSD/desconocido, no confiar en sobrescritura convencional.
6. **H6 · Panel WPF:** estado de sesión, proceso, STDIO, fuentes/readiness, cifrado, B2, último restore y limpieza.
7. **H7 · MCP-OCP 1.0.0:** generalización P001–P043, batería 43+8, panel, manifest/ZIP reproducible, instalación y aceptación.

### Principios del dead-man de sesión efímera

- Tratar las computadoras de cibercafé como persistentes/no confiables.
- Cifrar la copia local efímera. Inspección inicial del host: tipo de medio, modelo/bus, sistema de archivos, permisos, cifrado anfitrión y condiciones observables de suspensión/hibernación. Resultado desconocido se trata conservadoramente.
- Separar la clave efímera de cada sesión de la clave persistente/de recuperación. La expiración no destruye la capacidad de restaurar B2.
- Al vencimiento: detener procesos OCP, bloquear, cerrar/desmontar contenedor, destruir la clave efímera local y limpiar residuos creados por OCP. No borrar disco anfitrión, perfiles ajenos ni objetos/versiones B2.
- En SSD/UNKNOWN no confiar en sobrescritura convencional; saneamiento específico del medio solo si capacidad y permiso se verifican.
- Este dead-man no es el gate físico de EP-TASK-003 para Fila 4.
- Si el host está comprometido mientras el workspace está abierto puede copiar datos; el borrado posterior no revierte la exfiltración previa.

### Responsables y paralelismo

- **MCP-OCP:** MCP-OCP-02 → MCP-OCP-05; MCP-OCP-03/04 en paralelo; define datasets, consistencia, cifrado y mecanismo nativo de backup; implementa panel y release.
- **EP:** EP-TASK-002 reconcilia/ejecuta B2; EP-TASK-003 protege workspace y gates de host; EP-TASK-005 instala cuando proceda. La ejecución permanece en el frente EP.
- **Gobernanza:** GOV-TASK-015 coordina; GOV-TASK-014 integra criterios de persistencia; GOV-TASK-007 prepara IPZ; GOV-TASK-003 acepta E2E; GOV-TASK-001/008 cubren 43+8 y contrato.
- P004 y su desarrollo no esperan al panel ni a la matriz 43+8. B2 no bloquea fixtures, harness o código no sensible. Instalación y datos privados sí esperan gates EP.

### Estado B2 reconciliado

El operador reporta persistencia Backblaze terminada; el último read-back EP-TASK-002 disponible en main registra sesión CLI inactiva (0/5 variables), ciphertext local presente, workers/wrapper sintácticamente válidos, pero sin recibo, autenticación, upload, descarga ni SHA remoto. Estado integrado: B2_REMOTE=NOT_VERIFIED_PENDING_EP_RECONCILIATION. Mantener discrepancia abierta hasta evidencia fresca de EP.

### Decisiones pendientes · corte previo · SUPERSEDIDAS POR REBASELINE APROBADO

Nivel final de seguridad; duración/renovación del lease; triggers y acciones exactas; workspace completo local o copia selectiva/remote-first; clasificación de rutas; retención/versionado B2. El ejemplo de 30 minutos no es parámetro aprobado.

**Estado común:** OCP_MCP_1_0=DOCUMENTALMENTE_REBASELINED · SINK_P004=NOT_IMPLEMENTED_NOT_ACCEPTED · MCP_OCP_02=OPEN · EP_TASK_002=B2_REMOTE_NOT_VERIFIED_PENDING_RECONCILIATION · EP_TASK_003=PARTIAL_FAIL · EP_TASK_005=PENDING · GOV_E2E=PENDING · IPZ_NATIVE=NOT_VERIFIED · FOL1=PREPARED_NOT_ACTIVE · MCP_NORMATIVO=DESACTIVADO.

Detalle y salida literal: anexo ChatGPT-GOBERNANZA-20261110-OCP-MCP-1.0-ULTIMO-TRAMO.md. Actualización documental únicamente; no hubo código, pruebas, build, B2, restore, host, dead-man, instalación ni escritura IPZ nativa.


---

## Rebaseline aprobado por el operador · OCP MCP 1.0 · 2026-11-10

Esta sección sustituye las decisiones de diseño que antes figuraban pendientes. Las instrucciones originales y las respuestas del operador se conservan verbatim en el anexo vinculado al final; ese anexo es el criterio de verdad ante discrepancias. Se configuran tareas y handoffs; no se declara ejecución técnica ni se alteran controles.

### Decisiones cerradas

- Jurisdicción operativa declarada: México. El operador declara autorización para inspeccionar las máquinas donde opere; EP debe respetar permisos, controles del SO y obligaciones legales, sin bypass.
- Inventario robusto por defecto, incluyendo ubicación GPS, IP y contexto de red cuando sean accesibles por interfaces soportadas y sin degradar la sesión. Capturar fuente, timestamp, precisión y estado; no fingir campos no disponibles.
- Retención prevista indefinida para datos útiles cifrados, con obligaciones legales y solicitudes válidas como límites.
- Workspace completo descargado en cada instancia. Todo cifrado, conversaciones/adjuntos incluidos.
- Lease aprobado: heartbeat/renovación 60 s; lease 30 min; aviso previo; cierre por 10 min de inactividad; máximo absoluto 8 h.
- RDC autentica al iniciar la sesión; una sesión activa por defecto, segunda solo por excepción explícita, máximo dos y aislamiento total de identidad/lease/claves/workspace.
- Backblaze es el único backend remoto inicial. Medio alternativo pasa a H9/post-release y no se aprovisiona ahora.
- Cierre: checkpoint primero con presupuesto inicial de 30 s; borrado local tiene prioridad. Emergencia/sospecha de compromiso omite espera y ejecuta crypto-erasure inmediata. Jamás se destruyen claves persistentes de recuperación ni se borran discos/perfiles/artefactos ajenos.
- Nomenclatura: UUIDv7 técnico y etiquetas secuenciales legibles, sin datos personales incrustados; secuencias atómicas y reconciliables si la sesión inicia offline.

### Secuencia por hitos y responsables

| Hito | Resultado celebrable | Gobernanza | MCP-OCP | EP |
|---|---|---|---|---|
| H1 | SINK:P004 visible desde IPZ con texto íntegro y pin/hash | GOV-015/007/003 | MCP-OCP-02/03/04/05 | gates e instalación cuando proceda |
| H2 | Persistencia mínima + bóveda organizacional cifrada en B2 | GOV-014 integra aceptación | MCP-OCP-14 define schema/datasets/checkpoint | EP-TASK-002/004/006 implementan y verifican |
| H3 | Workspace completo cifrado descargable y restaurable por instancia | GOV-014 acepta manifiesto/hash/restore | MCP-OCP-14 y pruebas | EP-TASK-002/003 ejecuta; EP-TASK-007 integra ciclo |
| H4 | Identidad y telemetría útil de sesión/host/ubicación/red/ciclo | GOV-013 conserva semántica y acepta integridad | MCP-OCP-15 schema/store | EP-TASK-007 captura inventario |
| H5 | Lease renovable y dead-man iniciado por GUI | GOV-015 coordina | MCP-OCP-15 eventos/contrato | EP-TASK-007 guardián y trigger |
| H6 | Limpieza adaptativa y crypto-erasure | criterios de aceptación | integración con proceso local | EP-TASK-007 implementa/verifica |
| H7 | Integración Vault→RDC just-in-time | aceptar evidencia | MCP-OCP-16 diferida | EP audita canal seguro y Vault |
| H8 | Release MCP-OCP 1.0.0 | GOV-003 aceptación E2E | panel, pruebas, manifest, paquete | EP-TASK-005 instalación/aceptación |
| H9 | Medio alternativo de persistencia | revisar propuesta | MCP-OCP-17 evalúa | EP evalúa sin provisionar antes de autorización |

### Paralelismo y gates

- H1 continúa como corte rápido; desarrollo P004 con fixtures/harness no espera a la bóveda, panel, telemetry ni gates host.
- H2 es prioridad P0 inmediata. EP-TASK-004/006 inventarían y preparan bóveda; EP-TASK-002 ejecuta B2 tras sus gates. MCP-OCP-14 define contrato de journal, snapshot y restauración.
- H3 espera evidencia de cifrado, manifiesto, download y restore. La descarga completa se exige por sesión.
- H4 puede diseñarse con fixtures en paralelo; captura real de datos del host pertenece a EP.
- H5/H6 no se activan en host hasta la compuerta EP correspondiente. EP-TASK-007 es distinto de EP-TASK-003: uno construye la política de sesiones del producto; el otro conserva el gate de almacenamiento/Fila 4.
- H7 se documenta ahora, pero no se implementa hasta auditar canal RDC y superar H2/restore de bóveda.
- H9 no bloquea MCP-OCP 1.0.0 y no se aprovisiona en este sprint.

### Grafo de dependencias actualizado

MCP-OCP-02 → MCP-OCP-05; MCP-OCP-03 ∥ MCP-OCP-04.
H2: EP-TASK-004/006 → EP-TASK-002 + MCP-OCP-14.
H3: H2 PASS + EP-TASK-003 gates → workspace full download/restore → EP-TASK-007.
H4: MCP-OCP-15 schema ∥ EP-TASK-007 inventory ∥ GOV-TASK-013 correlation.
H5/H6: H3 + H4 schema frozen + EP-TASK-007 tests → local guard/cleanup acceptance.
H7: H2 vault restore PASS + RDC channel audit → MCP-OCP-16.
H8: P004 E2E + panel + generalization + manifest/build/package + EP-TASK-005 → GOV-TASK-003 acceptance.
H9: after H8; evaluate alternative persistence medium only.

### Criterios comunes no negociables

- Toda conversación y adjunto se incluye en el workspace cifrado; no aparece en claro en telemetría o logs.
- GPS/IP/inventario robusto son best-effort y no bloquean apertura: registrar AVAILABLE/UNAVAILABLE/DENIED/ERROR con fuente y precisión. No evadir permisos o degradar la sesión.
- B2 único inicialmente; si no se puede verificar el snapshot remoto esperado, no declarar la instancia completa ni usar backend alternativo no aprobado.
- Cierre normal: un único checkpoint ≤30 s, después crypto-erasure local aunque el checkpoint no se confirme. Emergencia: crypto-erasure inmediato.
- El saneamiento se limita al workspace y artefactos propios OCP; nunca disco/perfil de terceros. SSD/UNKNOWN: crypto-erasure, no sobrescritura tradicional.
- Todas las escrituras/documentos deben incluir criterios falsables, evidencia de ejecución y read-back. Diseño y tarea configurada no equivalen a implementación.

### Estado de frente

Gobernanza: coordinación y criterios configurados. MCP-OCP: las tareas 14–17 están definidas en LIST v0.11; implementación pendiente. EP: EP-TASK-007 creada, acuse EP y ejecución pendientes. EP-TASK-002/004/006 actualizadas como asignaciones documentales, sin declarar operación. Controles EP generación 3, MCP-OCP generación 5 y Gobernanza generación 17 permanecen sin cambios. FOL1 PREPARADO_NO_ACTIVO; MCP-NORMATIVO DESACTIVADO.

**Fuente de verdad:** instrucciones verbatim y respuestas del operador en [anexo OCP MCP 1.0](../../entregas/ChatGPT-GOBERNANZA-20261110-OCP-MCP-1.0-ULTIMO-TRAMO.md).


---

## Revisión de flujo interfrentes · 2026-11-10 · corte main `cca31e6a`

### Instrucción literal del operador

~~~text
Los frentes ya estan avanzando, vuelve a revisar las tareas, asegurandote que todo este bien y fluya
~~~

### Diagnóstico consolidado

**Resultado:** la arquitectura de dependencias es coherente y permite avanzar en paralelo. No se debe convertir H2–H9 en condiciones previas para el corte P004. La revisión detecta sincronización, validación ejecutable y gates EP pendientes; no declara el producto aceptado.

**Baseline de esta revisión:**
- Repositorio: `SeryMente/metodologia`, `main`.
- HEAD observado: `cca31e6aab91b68041121a227770e73d24d5cc9a`.
- Los tres commits posteriores al último corte de Gobernanza son EP-only: `d7ecaf2d26576e58d0d4d7174623cc7cdc09a0b4`, `dfac0fdbc864c9023b19548538d72e8b980bbb47` y `cca31e6aab91b68041121a227770e73d24d5cc9a`. Se leyeron sus cambios; no alteran controles ni rutas MCP/Gobernanza.

### H1 · SINK:P004 — una sola línea activa

- **PR #27** (`feat/mcp-ocp-sink-p004-main-a34c1c5b`) queda como única candidata activa del corte P004. Contiene el lector/servidor STDIO, pin DUG v388, respuesta P004 fail-closed, harness y 41 pruebas escritas.
- La rama aparece **13 ahead / 3 behind** respecto a `main`; GitHub informa `mergeable=false`. Los tres commits nuevos de main afectan únicamente archivos EP, sin solapamiento con las rutas modificadas por la PR; aun así, MCP-OCP debe sincronizar la rama con el HEAD actual antes de solicitar revisión/merge.
- Su backlog candidato tiene referencias superiores desactualizadas en el encabezado: declara núcleo v0.1.30/LIST v0.11, mientras la misma rama contiene núcleo v0.1.34/LIST_VERSION 0.15. Corregir el pin documental antes de cerrar MCP-OCP-02.
- **Validación:** 41 pruebas están escritas; 0 ejecutadas con evidencia. El último run consultado (`42904265411`, job `130138018804`) concluyó FAILURE con `runner_id=0`, `steps=[]`, sin logs ni artefactos. Esto no demuestra fallo del código ni PASS. La salida requerida es runner observable, build, 41 pruebas y smoke STDIO/EOF con logs/artefactos verificables. No repetir reintentos ciegos.
- **PR #26** queda como fuente histórica/selectiva de componentes WPF para H8, después de congelar schema; no competir ni fusionar su rama completa en H1.
- **PR #24** queda como iteración anterior supersedida; conservar para auditoría/port selectivo, sin merge completo.

### H2/H3 · EP persistencia, bóveda y Fila 4

- EP publicó la actualización de EP-TASK-002 y su índice en main. El diagnóstico más reciente observó GUI EP Vault abierta pero **SELLADA**, sesión compartida CLI inactiva, cero variables disponibles y ciphertext local de 2.200 bytes.
- El worker P0-C para subir **solo ciphertext de Vault** está preparado y pasa análisis sintáctico. No hubo autenticación B2, bucket preflight, upload, descarga, SHA remoto ni recibo. `B2_REMOTE=NOT_VERIFIED` sigue siendo el estado correcto.
- Próxima acción EP: el operador desbloquea la GUI Vault localmente; EP confirma sesión compartida y disponibilidad de las cinco variables sin imprimir valores y ejecuta P0-C dentro del TTL. El recibo debe demostrar objeto privado, descarga y SHA-256 idéntico.
- No subir el ZIP de workspace sin cifrado cliente. El workspace completo se incorpora después, cifrado antes de B2 y con manifest/hash/restore.
- EP-TASK-003 sigue `PARTIAL_FAIL` y EP-TASK-005 sigue `PENDING`. OEP §123–124 conserva la pausa de mutaciones: el diseño VHDX/montaje sobre `Desktop\\SeryMente` sigue `PROPOSED_NOT_ACCEPTED`; no copiar, cifrar, renombrar, desmontar ni cambiar puntos de montaje hasta que el operador acepte la propuesta. La última observación histórica no sustituye una relectura en vivo de Fila 4.
- La PR #21 de EP Vault se basa en **PC 7**, destino supersedido. Se conserva como fuente selectiva de código genérico; no instalar/aceptar en PC 7 ni transportar sesiones/objetos DPAPI CurrentUser entre equipos. Fila 4 y EP-TASK-003/005 mandan.
- EP-TASK-006 conserva cobertura organizacional incompleta; la pareja Master B2 EP en Vault no equivale a inventario completo KHORA/OCP/Ser y Mente.
- EP-TASK-007 está configurada, pero el índice aún marca acuse EP pendiente. No declarar guardián, GPS/IP, lease ni crypto-erasure implementados hasta pruebas/evidencia del propio frente.

### Flujo autorizado sin esperas artificiales

1. **En paralelo inmediato:** MCP-OCP sincroniza PR #27 con main, corrige pins y obtiene runner observable; EP desbloquea Vault localmente y ejecuta P0-C; EP realiza read-only preflight actualizado de Fila 4 y prepara una única propuesta de almacenamiento sin mutar.
2. **Corte local P004:** solo tras MCP-OCP build + 41 tests + STDIO smoke verificables y EP-TASK-003 PASS, EP puede instalar/aceptar en `instalacion-local/piloto-sink/` bajo EP-TASK-005. No esperar H4/H5/H6, panel WPF, generalización 43+8 ni backend alternativo.
3. **Aceptación H1:** Gobernanza ejecuta GOV-TASK-007/003 con el recorrido real IPZ → RDC → STDIO y respuesta P004 íntegra visible para el modelo, pin/hash incluidos. JSON-RPC de consola no basta; escritura IPZ nativa sigue siendo operación separada.
4. **Después del primer P004 aceptado:** H2/H3 completan Vault/workspace completo B2 y restore; H4 telemetría; H5 lease/guardian; H6 crypto-erasure; H7 Vault→RDC JIT tras auditoría de canal; H8 producto 1.0.0/panel/WPF/43+8; H9 alternativa de persistencia post-release.

### Criterio de coordinación y no regresión

- Ningún hito posterior bloquea el desarrollo remoto P004 con fixtures sintéticos.
- EP es dueño de host, Vault, B2, guardián y la instalación local; MCP-OCP es dueño del código/schema/pruebas; Gobernanza conserva IPZ y aceptación E2E.
- Una tarea externa solo bloquea el subpaso que realmente necesita su salida. No usar un gate de host para detener diseño/build remoto, ni usar un PASS sintético para autorizar importación privada/instalación.
- No se modificaron controles EP generación 3, MCP-OCP generación 5 ni Gobernanza generación 17. No se ejecutó B2, modificación de host, instalación, escritura IPZ ni pruebas de código en esta revisión.

**Estado del corte:** coordinación actualizada documentalmente; PR #27 es la línea activa; validación MCP pendiente de runner; Vault B2 pendiente de desbloqueo local y recibo remoto; Fila 4 pendiente de relectura y aceptación de diseño; SINK:P004 todavía no aceptado desde IPZ real.


---

## Actualización final de avance y gates · 2026-11-10 · main `4afb9b36`

### Evidencia EP recién publicada

- Main HEAD observado: `4afb9b368b7e8be74aba239796993e71e1d41f43`.
- Recibo: [EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json](../entregas/EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json) · solo lectura/saneado.
- VHDX existe y está adjunto; volumen W: GPT/NTFS sigue FullyDecrypted, 0 %, Protection Off, sin protectores. No hay workspace observado en W:.
- C: aparece 100 % FullyEncrypted con XTS-AES128, pero Protection Off y sin protectores: no satisface el gate.
- Workspace fuente `Desktop\\SeryMente`: 3.103 archivos, 659 directorios, 159.162.208 bytes; 2 errores de enumeración. Checkout parcial sin Git; root de datos aún no existe.
- EP Vault: ciphertext 2.200 bytes; sesión inactiva; cero variables disponibles; GUI en estado SELLADA. B2 CLI está instalado, pero autenticación/upload/download no ejecutados.
- Ubicación física UNCLASSIFIED; IP/GPS no consultados/recopilados. Diseño `PROPOSED_NOT_ACCEPTED`; fuente y VHDX sin modificar; pausa de almacenamiento continúa.
- EP-TASK-007 aporta inventario local saneado, pero no acredita todavía IP/GPS, guardián, lease, crypto-erasure o cierre probado.

### MCP-OCP · cambio de candidato y CI

- PR #27 incorporó contrato y esquemas de MCP-OCP-14, además de actualizar su núcleo a v0.1.35 y backlog a LIST_VERSION 0.16. Es avance documental/material de schema; no acredita implementación de persistencia ni ejecución de pruebas.
- Tras el último commit EP `4afb9b36`, PR #27 vuelve a `mergeable=false`; su responsable debe integrar/reconciliar ese commit antes de proponer merge. El cambio EP es de una ruta de evidencia, sin solapamiento funcional con las rutas MCP identificadas.
- CI más reciente: runs P004 `42906110092`, bootstrap `42906110073` y RDC Governance `42906110188`; todos FAILURE con `steps=null`, `logs_url=null` y cero artefactos. No hay evidencia de ejecución de build, 41 pruebas o smoke; causa raíz NO VERIFICADA.
- Observación de seguridad a corregir antes de integrar PR #27: su modificación de `.gitignore` elimina exclusiones para `.env/.env.*`, claves/certificados, archivos de base de datos y logs. Restaurar esas exclusiones. También revisar el alcance del `global.json` propuesto en la raíz: preferir pin local dentro de `frentes/mcp-metodologia/` para no condicionar proyectos .NET no relacionados.
- PR #27 única candidata H1; PR #26 referencia selectiva WPF para H8; PR #24 antecedente. Ninguna fusionada ni aceptada.

### Estado consolidado al cierre

- H1: código y pruebas escritas avanzan; runner sigue sin asignarse; sincronización de PR #27 y revisión de seguridad pendientes; smoke y E2E IPZ no verificados.
- H2/H3: diseño/contratos preparados; EP Vault sellada y B2 sin autenticar; workspace no migrado ni restaurado. No declarar persistencia remota.
- H4–H6: contratos y EP-TASK-007 definidos; telemetría ampliada, guardian, lease y crypto-erasure no implementados/verificados.
- H7: diferido a auditoría posterior del canal RDC/Vault.
- H8: panel/paquete/aceptación 1.0.0 pendientes; panel no bloquea H1.
- H9: posterior a release; no aprovisionar proveedor alternativo.

**Flujo recomendado:** mantener MCP-OCP en código/fixtures/pruebas sin datos privados y corregir PR #27; EP atiende primero el desbloqueo local de Vault/P0-C y propone solución de almacenamiento sin mutar hasta aceptación expresa; Gobernanza continúa preparando aceptación IPZ/E2E. Cada frente conserva sus permisos y registra evidencia fresca.

**Límites de esta revisión:** no se modificó host, Vault, B2, IPZ, controles ni ramas MCP; únicamente se consolidó evidencia ya publicada y se actualizaron observaciones de revisión en las PR. No se declara aceptación de producto ni activación de FOL1/MCP-NORMATIVO.


## Mandato de reporte individual por tarea

Como coordinador interfrentes, exigir que cada responsable documente el cierre en su propia ficha/núcleo usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). GOV-TASK-015 no reemplaza los informes de EP, MCP-OCP ni las demás tareas de Gobernanza. Antes de reflejar una tarea como completada en la coordinación, comprobar el enlace, el informe, los criterios terminales, la evidencia ejecutada y el read-back. Por cada tarea cerrada, entregar al operador un enlace y síntesis de solución, verificación, bloqueantes y preocupaciones. Si falta un informe o evidencia, el estado correcto es parcial/no verificado, no completado.


---

## Regla operativa · resumen semivivo y cierre por ciclo · 2026-11-10

Esta coordinación adopta el contrato operativo incorporado en [el núcleo OCP Gobernanza](../../GOBERNANZA.md#contrato-operativo-resumen-semivivo-por-ciclo-2026-11-10).

**Cadencia obligatoria:** resumen de apertura; actualización tras cada hito material; síntesis de cierre con read-back. «Semivivo» es seguimiento por hitos y consultas puntuales mientras se trabaja, no vigilancia permanente ni promesa de trabajo en segundo plano.

**Formato de cada entrega al operador:**  
🎯 Hito · 🚦 Estado · ✅ Confirmado · ⛔ Bloqueantes · ⚠️ Preocupaciones · ➡️ Siguiente acción · 🔎 Fuente/corte.  
Mantener cada campo en una o dos líneas cuando sea posible; ampliar solo el dato que cambie una decisión o un riesgo. Usar verbos y estados inequívocos. No ocultar fallos con porcentajes ni llenar vacíos con estimaciones.

**Criterios de rigor:**
- Separar `PROPUESTO`, `AUTORIZADO`, `INTENTADO`, `EJECUTADO`, `VERIFICADO` y `ACEPTADO`.
- Separar `PASS`, `FAIL`, `NOT_RUN`, `BLOQUEADO` y `NO_VERIFICADO`.
- Identificar evidencia, commit/blob/SHA, hora/zona y responsable cuando existan. Declarar explícitamente la ausencia de evidencia.
- Revalidar estados efímeros (Vault/TTL), CI, ramas y objetos remotos antes de depender de ellos.
- No repetir operaciones con efectos laterales si existe un proceso en ejecución o no se comprobó el resultado del intento anterior.
- No exponer secretos o valores de variables en resúmenes, recibos, logs o repositorios.

**Cierre por tarea:** el resumen ejecutivo interfrentes no sustituye el informe individual. EP, MCP-OCP y Gobernanza conservan la obligación de reportar dentro del núcleo de su propia tarea. GOV-TASK-015 consolida, verifica read-back y enlaza; no reasigna autoría ni permisos. Ninguna tarea se presenta completada sin criterios terminales y aceptación exigible verificados.

## Primer resumen ejecutivo bajo esta regla · 2026-11-10 · corte 16:27 America/Mexico_City

### 🎯 Hito
Sprint OCP MCP 1.0 / SINK-P004: recuperar el texto normativo íntegro P004 desde IPZ real vía RDC/STDIO y cerrar los gates EP que habilitan el piloto. El primer Sink operativo todavía no está aceptado.

### 🚦 Estado por frente

| Frente / gate | Estado al corte | Evidencia y límite |
|---|---|---|
| EP-TASK-004 · suite Vault sintética | `PASS_SINTÉTICO` | Dos corridas E2E exactas MOD-EPVAULT/v1.0.0: exit 0 (165,41 s y 142,61 s). H10 humano e integración a main pendientes. |
| EP-TASK-002 · B2 P0-C | `FAIL_ANTES_DE_UPLOAD` | v1 `UNEXPECTED_WORKER_FAILURE`; v2 `PropertyNotFoundException`; ambos sin objeto remoto, descarga ni SHA remoto. v3 parser PASS, no ejecutada. |
| Vault · sesión local | `SELLADA` | Read-back 16:27:35 local: ciphertext presente 2.200 B, `sessionActive=false`. La apertura anterior habilitó consultas temporales; el TTL no se presume vigente. |
| B2 · preflight read-only | `PASS_PARCIAL` | Consulta independiente confirmó cuenta autorizada, key ID coincidente, capacidades requeridas, bucket OCP-MCP `allPrivate`, SSE-B2/AES256 por defecto y 0 reglas de lifecycle. No hubo upload ni cambio de bucket. La causa exacta/línea del fallo del worker sigue NO VERIFICADA. |
| EP-TASK-003 · workspace Fila 4 | `PARTIAL_FAIL` | Diseño aceptado por el operador; inventario/preflight físico no habilita aún crear/proteger/montar ni copiar. Actividad concurrente en Temporal impide congelar el manifiesto. |
| MCP-OCP H1 · PR #27 | `OPEN · DRAFT · NOT MERGED` | 37 commits ahead / 2 behind; comparación con main `diverged`, mergeable=true. 41 pruebas están escritas; ejecución observable/build/smoke siguen sin acreditarse. |
| Gobernanza · SINK:P004 E2E | `PENDIENTE` | No hay respuesta íntegra aceptada desde IPZ real. Consola/fixture no equivalen al E2E solicitado. |

### ✅ Cambios/confirmaciones de este corte

- El contrato de resumen semivivo ya está en el núcleo de Gobernanza.
- Se verificó por vía read-only el acceso B2 y su bucket; no se alteró configuración remota.
- El PR #27 ya no muestra `.gitignore` entre las rutas modificadas y el pin `global.json` está acotado a `frentes/mcp-metodologia/`; esto elimina del diff actual las dos observaciones de alcance señaladas antes. No significa aceptación ni merge.
- No se subió ciphertext ni workspace; no existe backup remoto verificado. No se alteraron controles, BitLocker, VHDX, workspace ni IPZ.

### ⛔ Bloqueantes y siguiente movimiento

1. **EP:** el operador vuelve a abrir la cámara de Vault localmente. EP revalida Status y los cinco nombres sin revelar valores; entonces ejecuta únicamente la v3 ya preparada para capturar la línea exacta de `PropertyNotFoundException`. No repetir v1/v2. Después corregir en variante nueva y hacer un único P0-C final, con recibo propio y gates de upload/download/SHA/SSE/restore.
2. **MCP-OCP:** sincronizar los dos commits de main que faltan; corregir el lector/fixture DUG v388; obtener runner/logs y ejecutar build, 41 pruebas y smoke STDIO/EOF.
3. **Gobernanza:** mantener GOV-TASK-003 como aceptación E2E real y GOV-TASK-007 como fast path IPZ; no declarar Sink aceptado hasta el recorrido completo.

**Preocupaciones vigentes:** la causa raíz exacta del worker P0-C y la ejecución de CI MCP aún no están verificadas; EP-TASK-003 no permite migración física; H10 visual sigue pendiente; FOL1 está preparado pero inactivo; IPZ nativa NO VERIFICADA; MCP-NORMATIVO DESACTIVADO.

**Criterio de salida del hito:** P0-C solo pasa con objeto remoto, descarga íntegra, tamaño/SHA idénticos, SSE-B2 confirmado y restore aislado; H1 solo pasa con build/pruebas/smoke observables; SINK:P004 solo se acepta con respuesta normativa íntegra desde IPZ real y pin/hash validado.


### Revalidación incremental · MCP-OCP CI y estado efímero Vault · 2026-11-10 · 16:27 America/Mexico_City

- PR #27 HEAD `b3aaf38ab913aba62e5d80d2aeacf36e62e81c3d`; OPEN/DRAFT/NOT MERGED; mergeable=true, pero branch comparison `diverged` (37 ahead / 2 behind). Se requiere sincronización con main tras estas escrituras de Gobernanza.
- Runs del HEAD: P004 `42914167259`, bootstrap `42914167018`, RDC Governance `42914167119`; los tres FAILURE. En P004, job `130172154766` devuelve `steps=null`, `logs_url=null`; fetch de logs responde `BlobNotFound`. No hay evidencia de runner, build, pruebas o smoke iniciados; causa de la falta de ejecución NO VERIFICADA. No clasificar como fallo de código ni PASS.
- Revalidación local de EP Vault a las 16:27:35.0084186-06:00 bajo CENTRAL\fila4: `ENCRYPTED_FILE_PRESENT`, ciphertext 2.200 B, `sessionActive=false`. La sesión/TTL observada previamente no se presume vigente; no se inició v3 ni nueva transferencia.
- La comprobación B2 read-only anterior sí logró autorizar la cuenta, emparejar key ID y leer bucket OCP-MCP privado con SSE-B2/AES256 predeterminado y cero reglas de lifecycle. No escribió bucket/objeto. Esto no corrige la excepción del worker ni acredita upload/restore.
- Siguiente gate EP: nueva apertura local de Vault por el operador; EP revalida Status y los cinco nombres y solo entonces ejecuta v3 para registrar la línea exacta de `PropertyNotFoundException`. No repetir v1/v2. Se conserva el ciphertext local; sin objeto remoto demostrado.

## Corte semivivo · prioridad Backblaze satisfecha en transferencia · 2026-11-10 · 17:08 America/Mexico_City

### 🎯 Hito

**H2/H3 · continuidad EP por Backblaze:** transferencia R2 de workspace y ciphertext Vault completada; sigue pendiente restore aislado. Por instrucción del operador, esta prioridad se atendió antes de iniciar nuevo desarrollo del sprint SINK:P004.

### 🚦 Estado por frente

| Frente / gate | Estado | Evidencia y límite |
|---|---|---|
| EP-TASK-002 · B2 | `UPLOAD_READBACK_SHA256_PASS` | 4 objetos en OCP-MCP: ZIP, Vault ciphertext, manifest y checksum; descargas SHA-256 MATCH; SSE-B2/AES256; recibo exit 0. Restore cross-host NOT_RUN. |
| EP-TASK-003 · Fila 4 | `PARTIAL_FAIL` | Diseño VHDX aceptado; gates físicos/BitLocker/checkout no habilitan migración. |
| EP-TASK-004 · Vault GUI | `PASS_SINTÉTICO` | Dos ejecuciones exactas; H10 humano y merge pendientes. |
| EP-TASK-005 · instalación P004 | `PENDING_BLOCKED` | Espera EP-TASK-003 PASS y paquete P004/manifest/SHA + MCP-OCP-03/04 PASS. |
| MCP-OCP H1 | `PAUSADO_POR_PRIORIDAD_DEL_OPERADOR` | DTC ciclo local 13 permanece abierto; PR #27 OPEN/DRAFT/NOT MERGED; no handoff/instalación nueva durante prioridad B2. |
| Gobernanza SINK:P004 | `PENDIENTE` | Aceptación IPZ real sigue pendiente. |

### ✅ Confirmado

- Snapshot local R2: 3.289 entradas ZIP, 119.076.640 bytes, integridad interna PASS.
- ZIP remoto descargado y cotejado con SHA-256 idéntico al origen: `9D511614FC6B4001DBA5F8CAAF69ED06107F8B5F5111165F186BE7B2C5C06E09`.
- Ciphertext Vault, manifiesto y checksum también descargados y cotejados; SSE-B2/AES256 confirmado para los cuatro objetos.
- Recibo local `ep-backblaze-r2-final-receipt-v1.json`; exit 0; caché B2 temporal limpia; valores secretos no emitidos.

### ⛔ Bloqueantes y siguiente acción

1. EP completa restore aislado de ZIP/ciphertext sin sobrescribir workspace activo; declara de forma separada qué componentes DPAPI no son portables y el bootstrap de acceso B2.
2. EP-TASK-003 continúa con sus gates físicos; no asumir que el respaldo permite copiar/montar el VHDX.
3. Solo tras actualizar informes e índice y cerrar la secuencia B2/restore, se reanuda desarrollo H1 SINK:P004 sobre el estado actualizado y se procesa el handoff ya abierto de MCP-OCP.

**Riesgo:** el ZIP se subió sin cifrado cliente por excepción de urgencia informada/ordenada por el operador; únicamente TLS y SSE-B2/AES256 confirmados. No equivale al diseño permanente de cifrado cliente de OCP MCP 1.0.

**Estado integrado:** `B2_UPLOAD_READBACK=PASS` · `CROSS_HOST_RESTORE=NOT_RUN` · `DEVELOPMENT_H1=PAUSED_UNTIL_TASKS_UPDATED_AND_RESTORE_GATE` · `IPZ_E2E=NOT_ACCEPTED` · `MCP_NORMATIVO=DESACTIVADO`.


## Corte semivivo · restore R2 aislado PASS · P004 listo · 2026-11-10 · 17:12

**Hito general:** H3 de 9 (workspace descargable/restaurable por instancia) tiene `SAME_HOST_ISOLATED_RESTORE_PASS`; H2 tiene upload/read-back del ciphertext Vault PASS, pero descifrado aislado pendiente. No se declara restore cross-host completo.

| Frente / gate | Estado | Evidencia |
|---|---|---|
| EP-TASK-002 B2 | `UPLOAD_READBACK_PASS_4_OF_4` | ZIP/Vault/manifest/checksum; SHA match 4/4; SSE-B2/AES256. |
| EP-TASK-002 workspace restore | `SAME_HOST_ISOLATED_RESTORE_PASS` | C:\\R2R; 3.289/3.289; cero fallos/inesperados. |
| EP Vault decrypt | `NOT_RUN` | Ciphertext íntegro; cross-host y bootstrap pendientes. |
| EP-TASK-003 | `PARTIAL_FAIL` | Gates físicos VHDX/BitLocker/checkout pendientes. |
| EP-TASK-005 | `PENDING_BLOCKED` | Requiere EP-TASK-003 PASS y paquete P004/MCP-OCP-03/04. |
| MCP-OCP H1 | `READY_TO_RESUME` | Ciclo local 13 abierto; PR #27 OPEN/DRAFT/NOT MERGED. |

**Decisión operativa:** tareas EP/Gobernanza y los cursores de retroalimentación interfrentes están actualizados/leídos. Está habilitado reanudar desarrollo sintético P004 dentro del ciclo local 13 existente. Instalación/aceptación en EP sigue bloqueada por sus gates. Riesgo: ZIP sin cifrado cliente por excepción del operador; TLS/SSE-B2/AES256 sí confirmados. `MCP-NORMATIVO=DESACTIVADO`.

---

## Corte de continuidad y recuperación B2 · 2026-11-10 17:22–17:27

- **Conversación incorporada:** exportación `ChatGPT-GOBERNANZA (1)-20261110-1722.txt` (Downloads; 98.367 bytes; 1.974 líneas). Gobernanza conserva un registro operativo sintetizado y referencia de origen; el TXT íntegro no se publica en el repositorio para no exponer contexto privado/local.
- **Procedimiento de un archivo:** [Registro y recuperación R2/B2](../../entregas/ChatGPT-GOBERNANZA-20261110-1722-CONTINUIDAD-B2.md). Descargar solo `EP-Backup-Provisional-20261110-164004-R2.zip` del bucket `OCP-MCP`, prefijo `ep-ocp/workspace/`, y extraer en Escritorio para recrear `SeryMente`. El ZIP ya contiene el ciphertext de Vault.
- **H2 / EP-TASK-002:** upload + read-back de los cuatro objetos PASS; ZIP de 119.076.640 bytes, 3.289 archivos, ciphertext Vault de 2.200 bytes incluido; SSE-B2/AES256.
- **H3 / restore:** extracción aislada PASS en `C:\R2R`, 3.289/3.289, cero fallos y cero inesperados. No se modificó el workspace original.
- **Límite explícito:** Vault se restauró como ciphertext; descifrado y restore cross-host permanecen NO_VERIFICADOS. El ZIP carece de cifrado cliente; SSE-B2 es cifrado del proveedor. No declarar recuperación infalible.
- **Secuencia:** prioridad inmediata Backblaze atendida; habilitar reanudación de desarrollo sintético H1 SINK:P004 en el ciclo MCP-OCP existente. H1 continúa sin aceptación E2E IPZ.



### Paquete de recuperación R3 · distinción local/remoto

R3 `EP-Workspace-Recovery-R3-20261110.zip` (creado 17:21:27 local; 107.014.352 bytes; 3.342 entradas) incluye dos ciphertexts de Vault y un `Restore-Workspace.ps1` con instrucciones de un paso. **R3 está solo local; presencia/carga en B2 NO_VERIFICADA.** No reemplaza al R2 remoto acreditado. R2 sigue siendo el objeto remoto utilizable para descarga/extracción sencilla. No se repite transferencia R2. R3 queda como candidato para siguiente carga cuando Vault esté desbloqueada y se pueda autenticar B2.


### Nomenclatura de snapshots · hora local obligatoria

A partir del siguiente paquete nuevo, usar:

`EP-Workspace-Recovery_YYYY-MM-DD_DIA_HH-mm_America-Mexico_City_RN.zip`

Día en español; hora 24h; zona IANA `America/Mexico_City`; instante de creación real del snapshot. Para el corte comunicado por el operador (martes 10-11-2026 17:32, UTC−06:00), ejemplo: `EP-Workspace-Recovery_2026-11-10_Martes_17-32_America-Mexico_City_RN.zip`. No renombrar retroactivamente los objetos remotos existentes ni falsear la hora del snapshot: R2 remoto fue creado 16:40:04; R3 local 17:21:27.


## Cierre de persistencia urgente · R4 · 2026-11-10

**B2 PASS:** `ep-ocp/workspace/EP-Workspace-Recovery_2026-11-10_Martes_17-35_America-Mexico_City_R4.zip` (107.081.813 bytes). Upload + download/read-back SHA-256 PASS; SSE-B2/AES256. SHA `DD84AA680CDE49D9940E35203E8D29355FB6904105680E87128DE8C868F883CE`. Read-back acreditado el martes 10-11-2026 a las **17:46:17.620 America/Mexico_City**. R2 anterior preservado.

**Restore R4 aislado PASS:** 3.345 archivos, 145.501.528 bytes; ciphertext Vault presente; workspace original intacto. El ZIP tiene 3.348 entradas. No se declara descifrado de Vault ni restore cross-host; DPAPI CurrentUser no es portable.

**Instrucción inmediata de recuperación:** descargar el ZIP R4 desde el bucket privado `OCP-MCP`, prefijo `ep-ocp/workspace/`; usar Windows **Extraer todo** en un destino vacío. Se recrea `SeryMente`. El script auxiliar incluido tiene un defecto de comodines con rutas `[id]`; no ejecutarlo. El contenido del ZIP está validado y la restauración aislada pasó usando el mismo contenido con el helper corregido en la copia de prueba.

**Límite de seguridad:** no hay cifrado cliente; solo SSE-B2/AES256. Vault viaja como ciphertext; requiere contraseña maestra independiente. H2 persistencia/backup+restore aislado demostrado; descifrado cross-host pendiente. H1 SINK:P004 sigue como siguiente hito de producto, no aceptado.
