# GOV-TASK-015 · Sprint integrado Sink local vía RDC · Gobernanza / MCP-OCP / EP

**Estado:** `EN_CURSO · fase documental de Gobernanza ejecutada; implementación MCP-OCP y preparación/instalación EP sujetas a evidencia de sus frentes`
**Objetivo de release:** entregar MCP-OCP software **1.0.0**, instalado en la carpeta local de Metodología descrita al final de este plan. Las versiones documentales del núcleo MCP-OCP-v0.1.28 y backlog 0.9 son versiones de artefactos auxiliares, no la versión del producto.
**Tipo:** coordinación y aceptación de un único sprint; no crea un frente nuevo ni controles paralelos.
**Responsabilidad:** frente Gobernanza. Las tareas técnicas conservan sus OCP y fuentes.
**Fuente normativa:** Samantha v388 · NX-388m · Metacanon 1.29 · GOW 2.18.
**DUG:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; archivo blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
**MCP-OCP:** núcleo v0.1.28 · commit `01e960b43f0750cd1824aac6a81a89f6a9362c26` · blob `8e763231b28dce62cd60f326b04c9a3cc15d5e32`; backlog v0.9 · commit `64a5a041c9cdf21d4703cea12b877b1129a853f1` · blob `c903c9c1aa5d2461697e8c91182a331c3d19918b`.
**EP:** OEP v0.3.56 · commit `3b997f08e6fba520859a960be304c701c89243f7` · blob `89267f2d263f8367024fa992d10de3b0a3509840`.
**Autorización:** el operador autorizó directamente Sink local por stdio y amplió el producto para incluir el panel local de observabilidad MCP-OCP-13. No se requiere aprobación de titularidad anterior, generación ni folio; dichos campos son auditoría, no compuertas.
**Destino EP designado:** terminal Fila 4, correspondiente a la única sesión RDC disponible indicada por el operador. Últimos datos técnicos conocidos (no lectura viva): Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, sesión `CENTRAL\\fila4`, SessionId 4. Identidad/usuario/SID/permisos y ubicación física requieren preflight vivo. No inferir CECEQ/LOC-OTHER; el dead-man se determina después de verificar la ubicación.
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

**Destino designado por el operador:** terminal Fila 4, correspondiente a la única sesión RDC disponible indicada. La última referencia técnica es el Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, perfil `CENTRAL\\fila4`, SessionId 4; no es lectura viva. La ubicación física queda pendiente de verificación. No volver a pedir selección; confirmar identidad/permisos/USERPROFILE y ubicación en el preflight.

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
- **Panel MCP-OCP-13:** WPF candidato escrito; biblioteca de monitorización, reader/writer/evaluator, dashboard y 23 pruebas sintéticas añadidas; build, tests, revisión visual Windows e integración EP todavía NO VERIFICADOS.
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

**Estado:** panel WPF candidato escrito; 23 pruebas monitor/readiness escritas/0 ejecutadas; build, validación visual, integración EP, paquete e instalación pendientes.

---

## Rectificación del destino y fast path IPZ/SINK · 2026-11-10

Esta sección sustituye como estado vigente del sprint las menciones anteriores a PC 7/LOC-OTHER en esta coordinación. El operador designó **Fila 4** como destino de trabajo e instalación porque corresponde a la única sesión RDC disponible indicada. PC 7 no queda como alternativa ni fallback.

- **Últimos datos técnicos conocidos, no lectura viva:** RDC Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`; sesión interactiva `CENTRAL\\fila4`, SessionId 4. EP debe revalidar dispositivo, hostname, sesión, usuario/SID, `USERPROFILE`, permisos y acceso antes de escribir.
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

**Pin DUG vigente:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. En respuesta al bloqueo, el titular MCP-OCP rebaselinó su núcleo a v0.1.28 y su backlog a v0.9, ambos con DUG v388/NX-388m. EP actualizó OEP a v0.3.56 y las tareas EP-TASK-003/005 para marcar el gate local P0. Los nuevos pins y referencias están asentados en esta ficha; no implican que exista rama/código nuevo ni preflight host.

**Estado:** contrato documental corregido y fase de Gobernanza iniciada. Implementación del resolver, importación de fuente en Fila 4, pruebas, escritura/read-back nativos de IPZ y aceptación E2E siguen sin evidencia en esta ficha. El estado EN_CURSO no declara código construido ni instalación ejecutada.

## Matriz única de dependencias y bloqueo urgente · 2026-11-10

### Bloqueador P0 actual

**MCP-OCP-02 ya fue ejecutado sobre el HEAD actual:** rama `feat/mcp-ocp-p004-rebaseline-20261110-cycle02`, creada desde `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`. La siguiente prioridad técnica es build, 18 pruebas y smoke P004 con logs observables; no declarar piloto funcional hasta PASS.

### Camino crítico, precedencias y salida

1. **MCP-OCP-02 (P0): EJECUTADO / READ-BACK EN RAMA CICLO02.** Rama creada desde main SHA `84cc9ffc...`, pin v388, mapa de portabilidad y SDK/RID fijados. No merge; build y tests pendientes.
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

**Última evidencia:** rama MCP-OCP ciclo02 creada desde el main vigente; candidato P004, pruebas y CI están escritos, pero no hay PASS de compilación/tests/smoke. EP publicó un preflight parcial de Fila 4 con resultado FAIL; no hay instalación/importación. Pendiente: CI observable, correcciones, gates EP, paquete, instalación, IPZ nativa, E2E y panel. No convertir código escrito en PASS.
## Registro de ejecución MCP-OCP · ciclo02 · 2026-11-10

**Estado de sprint:** MCP-OCP-02 ejecutado y read-back verificado. MCP-OCP-05 tiene implementación candidata P004 escrita, no compilada. MCP-OCP-03 tiene 18 escenarios P004 escritos/0 ejecutados; MCP-OCP-13 añade 23 pruebas de monitor/readiness escritas/0 ejecutadas. MCP-OCP-04 tiene harness/CI actualizados con build WPF, pero no hay smoke ni PASS observable; E2E IPZ pendiente.

### Base de trabajo
- Main actual al crear la rama: `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`.
- Rama: `feat/mcp-ocp-p004-rebaseline-20261110-cycle02`.
- Rama creada directamente desde ese SHA; rebaseline limpio.
- DUG Samantha v388/NX-388m: commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`, blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`; blob cotejado en commit pinneado y main actual.
- MCP core v0.1.28, backlog LIST v0.9, control generación 5. Sink STDIO y panel WPF dentro del alcance AUTHORIZED.

### Implementación y validación
- REWRITE: servidor/protocolo/lector/pins y pruebas del corte actual.
- DROP para Hito A: SQLite, vault, crypto, backup, importador persistente, operaciones y artefactos históricos.
- SDK 10.0.403, `net10.0`, 0 dependencias NuGet externas; piloto framework-dependent sin RID; publicación final `win-x64` self-contained.
- Build/tests/smoke aún sin ejecución verificable. PR #25 corresponde a la rama anterior basada en main SHA `06467fb...` y quedó supersedido porque main avanzó con evidencia EP.

### EP — dependencia externa observada (sin cambiar su objeto)
- Main añadió `EP-FILA4-PREFLIGHT-PARCIAL-20261110.json`, commit `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`, blob `8ebf0c2b54efc6d3fe597adfe0f9358e65e6acbe`.
- Resultado: `PREFLIGHT_PARTIAL_FAIL`. C: FullyEncrypted/100 %, pero XTS-AES128, Protection Off y sin protectores; ubicación física UNCLASSIFIED; checkout de Metodología parcial, sin `.git`. El equipo/perfil no está listo para instalación ni importación.
- EP-TASK-003 conserva estado `en_curso`; EP-TASK-005 conserva `pendiente`. MCP-OCP no actualiza sus objetos ni intenta resolver su gate.
- No se tocó Fila 4 desde MCP-OCP; sin DB, DPAPI, fuente privada, REGISTER ni runtime persistente.

### Siguiente acción de MCP-OCP
Abrir PR draft ciclo02; recuperar ejecución CI con steps/logs/artifacts; corregir hasta build/tests/smoke PASS. Después congelar respuesta P004. La E2E real exige gates EP y respuesta visible al modelo desde el contexto IPZ. No mergear main.

### Main posterior a la base de ciclo02

Después de crear la rama ciclo02, main avanzó cuatro commits EP-only hasta `67b48bc041bee372c69389f0aa84ed1a6d19eff5`. La comparación desde la base `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd` confirma que las cuatro rutas modificadas pertenecen a EP y no se solapan con las 30 archivos modificados en el diff MCP/GOV de la rama. Se conserva la rama desde su base limpia verificada; la rama sigue divergente respecto a main; el conteo ahead/behind y de archivos se consulta en la PR #26 para conservar una única lectura vigente. No se toma control ni se modifica el estado EP.


## Implementación candidata WPF/monitor · ciclo02 · 2026-11-10

**Alcance implementado como código candidato (sin build):**
- `src/OcpMcp.Monitoring/`: modelos de sesión/servidor/estado/evento, writer best-effort y reader read-only fail-closed.
- `src/OcpMcp.Panel/`: proyecto WPF `net10.0-windows`, dashboard de una pantalla, FileSystemWatcher coalescido sin polling, control de cierre X/Alt+F4 como minimizar mientras EP sigue ACTIVE y verificación del proceso por PID + hora de inicio.
- `src/OcpMcp/`: `--monitor-root` opt-in; sin argumento no hay persistencia de observabilidad. Al recibir root explícito, el servidor escribe snapshot inicial bloqueado/no listo, cambia protocolo y actividad por eventos sanitizados, y registra parada al EOF.
- EP conserva propiedad y escritura de `session.json`, ACL, cifrado, ciclo de vida y apertura/cierre de la ventana. MCP-OCP no configura ni crea el root de datos de EP, no modifica BitLocker/ACL ni arranca el panel.

**Telemetría:** evento `SINK_READ_SUCCESS` solo tras lectura completa validada; los errores se registran como `TOOL_FAILED` con código saneado y nunca incrementan éxitos. No se guardan argumentos, contenido, texto de principios, tokens, secretos, SID ni payloads.

**Pruebas escritas:** 18 escenarios P004 + 23 de monitor/readiness; 0 ejecutadas. CI ahora restaura/build del servidor, suites P004/monitor, build WPF con `EnableWindowsTargeting` y smoke STDIO. El último run consultable de la revisión previa falló sin pasos/logs/artifacts; esta implementación nueva aún requiere una ejecución observada asociada al HEAD actual.

**Estado:** implementación candidata escrita/read-back; build, tests, smoke, visual review Windows, paquete, integración EP ACTIVE y aceptación permanecen PENDIENTES. El panel no bloquea el corte P004 pero es obligatorio para 1.0.0.


### Estado de CI actualizado · 2026-11-10 · revisión actual

- HEAD de código consultado: `9f66b1ae8e1969cf82c3f753ab30e31c2bd1a8c1` (incluye el negativo del inventario exacto P001–P043).
- MCP-OCP workflow run 56: `42868894554`, job `130014524745`, FAILURE; `steps=null`, `logs_url=null`, sin artefactos. La descarga no aporta logs; el job no acredita que se ejecutaran setup-dotnet, build, tests, WPF o smoke.
- Run 55: `42867891954`, FAILURE sin pasos/logs/artefactos. Se reintentó una vez. En run 56 se aceptó un nuevo reintento; job `130015275379` volvió a terminar FAILURE con `steps=[]`, `logs_url=null`, sin artefactos y descarga de logs `BlobNotFound`. No se ejecutan reintentos ciegos adicionales.
- En ambos commits fallaron también otros workflows del repositorio con el mismo patrón sin pasos recuperables. GitHub Status registró el 10-nov retrasos en workflows disparados por PR desde 16:31 UTC, Actions degradado hasta 17:28 UTC y Pull Requests aún degradadas; esto hace plausible un factor externo, pero **no demuestra la causa específica** del run 56.
- Suite P004: 18 casos escritos / 0 ejecutados. Suite monitor/readiness: 23 escritos / 0 ejecutados. Build WPF y smoke: no verificados. El contenedor local no contiene `dotnet`.

**Estado de verificación:** la implementación candidata está publicada; build, pruebas, smoke y revisión visual continúan NO VERIFICADOS. No se declara fallo de código ni aceptación.


### Reintento de CI run 56 · última lectura

GitHub aceptó un `rerun_workflow_job` del job `130014524745`; la última lectura del run `42868894554` lo mostró en `queued`, sin pasos ni nuevo resultado observable. No se atribuye PASS ni se da por iniciada la compilación.


### Resultado del reintento del CI · run 56

El reintento fue aceptado por GitHub, pero volvió a terminar en `FAILURE`: job `130015275379`, `steps=[]`, `logs_url=null`, cero artefactos; la consulta de logs devolvió `BlobNotFound`. No hay evidencia de ejecución de build, suites, WPF o smoke. Se cierra el reintento controlado sin más reintentos ciegos; esperar recuperación verificable de Actions/PR o un runner autorizado alternativo.


### Readiness EP — rectificación fail-closed

`MonitorReadinessEvaluator` exige que la atestación EP contenga `sessionState=ACTIVE` y `protectionState=Protection On`; Protection Off/UNKNOWN/futuro bloquea. Además coteja proceso RUNNING (PID + hora de inicio), protocolo INITIALIZED, fuentes importadas/VERIFIED/vigentes, operador provisionado, root y readiness del servidor. MCP no sondea BitLocker ni sustituye a EP. 23 tests escritos; 0 ejecutados.

### Revisión de CI y bloqueo de panel · 2026-11-10

- CI MCP-OCP run #78 `42871039884`: el job original `130022076348` y su reintento `130058287914` finalizaron FAILURE sin pasos, logs ni artefactos; la descarga devuelve `BlobNotFound`. En el mismo commit, `validate-canonical-bootstrap` (`42871039938`) y `Validate RDC Governance` (`42871039803`) reprodujeron el fallo sin pasos. No hay evidencia de inicio de build/tests/smoke ni base para atribuir fallo al código.
- La revisión estática del panel confirma que el corte vertical P004 deja Sources/Operator/Readiness bloqueados porque aún no implementa importación de fuentes ni aprovisionamiento del operador. El test positivo de readiness usa un snapshot sintético que representa un estado futuro de 1.0.0, no el corte actual. Deben integrarse esos flujos antes de aceptar readiness del producto final; esto no bloquea el piloto P004 ni autoriza inferir esos estados desde una lectura Sink.
- La revisión del watcher contra `PANEL-OBSERVABILIDAD.md` descarta el supuesto defecto: EP debe crear `monitor/session.json` antes de abrir el panel, así que `monitor/` existe cuando se llama `StartWatching()`. La secuencia aprobada permite la suscripción y no exige cambio.
- Se registra como bloqueo de implementación MCP-OCP-13 la actualización de Sources/Operator/Readiness. Requiere contrato explícito y autorizado EP↔MCP para los estados no sensibles; EP sigue siendo dueño exclusivo de `session.json`. No se altera su contrato ni se afirma integración.
- Estado de validación: 18 pruebas P004 + 23 monitor/readiness escritas / 0 ejecutadas; build, smoke STDIO, WPF, revisión visual e integración EP no verificados. PR #26 continúa draft y sin merge.
