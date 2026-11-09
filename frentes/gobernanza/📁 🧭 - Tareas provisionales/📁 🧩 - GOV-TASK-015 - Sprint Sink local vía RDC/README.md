# GOV-TASK-015 · Sprint integrado Sink local vía RDC · Gobernanza / MCP-OCP / EP

**Estado:** `PLANIFICADO · NO_INICIADO`
**Objetivo de release:** entregar MCP-OCP software **1.0.0**, instalado en la carpeta local de Metodología descrita al final de este plan. Las versiones `MCP-OCP-v0.1.26` y backlog `0.7` son versiones documentales, no la versión del producto.
**Tipo:** coordinación y aceptación de un único sprint; no crea un frente nuevo ni controles paralelos.
**Responsabilidad:** frente Gobernanza. Las tareas técnicas conservan sus OCP y fuentes.
**Fuente normativa:** Samantha v386 · NX-386m · Metacanon 1.29 · GOW 2.18.
**DUG:** leído desde `main` HEAD `82843bca9493a522405d840393c229d2af363342`; archivo blob `22dca684830a36dff019b47811d9b800cc9bea0a`.
**MCP-OCP:** núcleo v0.1.26 · blob `2177b6b81028d8ac5188379e2eb4fa36aea06b41`; backlog v0.7 · blob `1eed6511c238b55b4e13899efab7e55981addf8d`.
**EP:** OEP v0.3.54 · blob `cdd738aa025c9acc09cbbe107bfcadfa218d463f`.
**Autorización:** el operador autorizó directamente Sink local por stdio y amplió el producto para incluir el panel local de observabilidad MCP-OCP-13. No se requiere aprobación de titularidad anterior, generación ni folio; dichos campos son auditoría, no compuertas.
**Destino EP designado:** perfil/usuario Windows `PC 7`; dispositivo RDC asociado según el operador; ubicación `LOC-OTHER`. El hostname/ID del dispositivo, usuario/SID efectivos y estado del host requieren preflight vivo. Por LOC-OTHER, el dead-man de EP-TASK-003 es un gate obligatorio antes de runtime persistente.
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
| MCP-OCP-02 | 1 | Reconciliar código fuente remoto con `main` y pins actuales; comparar ramas `integration/ocp-mcp-0.1.0-selective-20261101` y `build/ocp-mcp-mvp-0.1.0`. | Base y diff identificados; código portado sobre `main`; manifiesto actual. |
| MCP-OCP-05 | 2 | Implementar/importar `GOW:ARR`, `DUG` y Sink P001–P043; congelar proyección local de estado/eventos saneados. | Contrato exacto, lote ordenado, hashes y readiness/telemetría sin payloads. |
| MCP-OCP-13 | 3 · paralelo | Construir panel WPF Windows de solo lectura conforme a `PANEL-OBSERVABILIDAD.md`; trabajar contra fixtures y el schema de MCP-OCP-05. | Panel abre en EP ACTIVE, muestra estados separados/actividad y cierra con EP; sin cliente/servidor MCP ni red. |
| MCP-OCP-03 | 4 | Build fresco; pruebas unitarias, contrato, negativas, integración STDIO, writer/reader del panel, secretos, shutdown, hash y root protegido. | Build reproducible con DUG v386/core v0.1.26; suites actuales PASS. No reutilizar 50/30/200 históricos. |
| MCP-OCP-04 | 5 | Probar `initialize`, `tools/list`, `tools/call`, respuesta completa, desconexión y reinicio por el mismo canal RDC de uso; comprobar que el panel observa sin interponerse. | Smoke real RDC/stdio; STDOUT solo MCP; sin listener, URL pública, túnel ni regla de firewall. |
| MCP-OCP-10 | 6 | Congelar fuentes, commits, Git blob SHA, SHA-256, SDK/RID, schema/eventos del panel, tests, manifiestos y limitaciones. | Recibo/manifiesto incluye servidor+panel y read-back. |
| MCP-OCP-07 | 7 | Empaquetar ZIP nuevo con servidor+panel; verificar extracción, hashes, launcher y runbook. | Paquete 1.0.0 vigente recuperable y verificado. |
| MCP-OCP-12 | 8 | Bootstrap local: extracción, import-sources desde checkout fijado y provisión interactiva del operador. | `operator_provisioned=true`, fuentes importadas y panel presente; consentimiento local interactivo. |
| MCP-OCP-08 | 9 | Handoff al frente EP para instalación/aceptación en almacenamiento protegido y apertura por sesión ACTIVE. | EP acepta paquete/hash, ruta, perfil, root de datos, launcher, panel, cierre y rollback. |

Fuera del sprint: MCP-OCP-06/11 (Jules, permanece pausado) y MCP-OCP-09 (PPR/restauración cross-host, P2). Tampoco entran B2, Khora, HTTP público ni activación de MCP-NORMATIVO.

### Frente 3 · Entorno Persistente (EP)

| Tarea | Estado leído | Trabajo de este sprint | Condición |
|---|---|---|---|
| [EP-TASK-003](../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) | En curso | Migrar/verificar workspace y completar dead-man obligatorio para `LOC-OTHER` en el dispositivo RDC asociado al perfil `PC 7`. Confirmar usuario/SID y almacenamiento cifrado en vivo. | Árbol íntegro en volumen protegido; origen intacto hasta SHA-256 cotejado; dead-man probado en el destino real. |
| [EP-TASK-005](../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md) | Nueva · Pendiente | Instalar/bootstrap en perfil Windows `PC 7` tras preflight y dead-man LOC-OTHER; root cifrado, prueba stdio/RDC y apertura/cierre del panel al cambiar la sesión EP ACTIVE. | Paquete/hash, fuentes importadas, `REGISTER <SID>` local, panel visible, shutdown EP y E2E PASS. |
| EP-TASK-004 | En curso · independiente | Reconstrucción/aceptación de la GUI de bóveda. | No bloquea build Sink ni bootstrap DPAPI salvo dependencia técnica demostrada. |

EP-TASK-002 (Backblaze), EP-TASK-001 (NCL) y PPR cross-host no forman parte del camino crítico.

## 3. Secuencia optimizada

| Fase | Actividad | Puede avanzar sin host | Gate para pasar |
|---|---|---|---|
| 0 · Baseline | Releer pins v386, control, backlog, especificación del panel y código remoto. | Sí. | Contratos y dependencias congelados; sin estados heredados como PASS. |
| 1 · Reconciliar | MCP-OCP-02: nueva rama desde main y port selectivo. | Sí. | Diff revisado, base reproducible, SDK/RID fijados. |
| 2 · Corte vertical | MCP-OCP-05: ARR → DUG → SINK:P004 y primera proyección de estado/eventos. | Sí para código/tests; transporte real cuando RDC esté disponible. | Respuesta exacta con pin/hash; schema de observabilidad sin payloads. |
| 3 · Generalizar + panel | MCP-OCP-05 generaliza P001–P043; MCP-OCP-13 construye panel WPF en paralelo con fixtures/schema congelado. | Sí. | 43 IDs/lotes PASS; panel visual contra datos de prueba y estados fail-closed. |
| 4 · Verificación | MCP-OCP-03/04: suite combinada, STDIO real, panel/readiness, caída, shutdown y perímetro. | Sí para suite; E2E final requiere RDC. | Pruebas nuevas ligadas al commit; stdout solo JSON-RPC; sin red. |
| 5 · Paquete | MCP-OCP-10/07: un build/ZIP reproducible con servidor+panel. | Sí. | Manifest/SHA y extracción/read-back PASS; runbook actualizado. |
| 6 · Preparar EP | EP-TASK-003 valida checkout, cifrado y dead-man LOC-OTHER en paralelo al desarrollo. | Parcial, según RDC. | Perfil/host/storage/dead-man verificados en vivo; ningún runtime persistente antes del gate. |
| 7 · Bootstrap | MCP-OCP-12 entrega paquete; EP-TASK-005 instala, registra con consentimiento y abre panel en sesión ACTIVE. | No. | Fuentes, operador, root de datos, panel y STDIO verificados por read-back. |
| 8 · E2E/cierre | GOV-TASK-003 valida servidor+panel; GOV-TASK-013 mide solo con ambos extremos observables. | No. | E2E PASS y aceptación por frente. IPZ/FOL1 mantiene gate independiente y no bloquea release. |

Se usará un único harness del servidor y fixtures del panel: primero corte vertical P004, después 43 IDs/negativos. El panel avanza en paralelo una vez congelado el schema. Dos niveles de pruebas, un build final, un ZIP servidor+panel, un manifest y recibos por frente. Preparación EP corre en paralelo; instalación/autoapertura solo después del gate LOC-OTHER. Frecuencia Sink y latencia RDC no se mezclan.

## 4. Bloqueos y mitigación

| Bloqueo | Evidencia disponible al planificar | Tratamiento |
|---|---|---|
| Código productivo no está en `main` | Hay código C# en ramas remotas; el ZIP 0.1.0 usa pins v377/core v0.1.20 y no está en el repo. | Reconciliar y portar fuente; no recuperar binario ni depender de una terminal histórica. |
| Sink no implementado | El catálogo actual identifica 43 IDs/MDP; el resolver de texto individual no está desplegado en main. | Implementar Sink explícito; no inferir applicability/dependencies faltantes. |
| Root de datos fuera del perímetro cifrado | El código candidato usa `%LOCALAPPDATA%\\SeryMente\\OCP MCP` por defecto. W: fue reportado cifrado en un entorno anterior; no está verificado para PC 7. | Validar/crear el root protegido en PC 7 o demostrar cifrado completo de su volumen de perfil; no heredar el estado de W: anterior. Sin esto no instalar persistente. |
| Workspace no migrado | Última evidencia: 195 archivos/11 directorios en staging; no hay manifiesto de destino ni segundo read-back. El cifrado de W: se observó en un entorno anterior y no acredita PC 7. | EP-TASK-003; preflight de origen/destino, preservar el origen hasta read-back íntegro y validar el perímetro del destino. |
| Capacidad RDC agotada | Última evidencia reportó `remote_calls_left_pct=0`; puede estar desactualizada. | Comprobar disponibilidad una sola vez al comenzar la fase EP; si sigue en 0, pausar solo operaciones remotas y continuar MCP/Gobernanza por GitHub. No repetir sondeos ni eludir cuota. |
| Destino designado; preflight pendiente | El operador designó perfil Windows `PC 7`, con el equipo RDC asociado, y ubicación `LOC-OTHER`; aún no existe lectura en vivo de identidad/permisos. | No volver a pedir selección. Verificar usuario/SID y host al abrir la fase EP. Por LOC-OTHER, cerrar y probar dead-man antes de persistir runtime. |
| Transporte real ChatGPT→RDC→stdio | Hubo smoke JSON-RPC manual en root temporal; no demuestra bridge de uso final. | Corte vertical P004 por el mismo camino de uso antes de generalizar. |
| Autenticación GitHub local | Conector GitHub de ChatGPT está autenticado; el token no se transfiere al perfil Windows. | Verificar `gh auth status` en el perfil final; si falta, login web interactivo local. |
| Provisión del operador | El build histórico no creó trust root en perfil real. | `provision-operator` + `REGISTER <SID>` local, con operador presente; no automatizar ni registrar SID en Git. |
| Metadatos normativos incompletos | Fuente no declara campos de aplicabilidad/activación. | Mantener `MCP-NORMATIVO=DESACTIVADO`; Sink devuelve texto solicitado y trazable, no dictamen. |

## 5. Insumos del operador

**Destino designado por el operador:** perfil Windows `PC 7`, asociado al equipo RDC correspondiente; ubicación `LOC-OTHER`. Esta designación resuelve la selección, pero no sustituye el preflight técnico: al iniciar EP se verifican en vivo identidad de usuario/SID, equipo, rutas, permisos, cifrado y capacidad RDC. No pedir de nuevo la selección.

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
- **Workspace/volumen previo:** la última evidencia de W: cifrado y RecoveryPassword custodiado pertenece al entorno donde se observó; no se presume aplicable a PC 7. Migración/validación en destino, manifiestos y segundo read-back pendientes.
- **Instalación/Bootstrap EP:** NO INICIADOS.
- **E2E:** NO EJECUTADA.
- **IPZ nativa/FOL1:** pendientes; MCP-NORMATIVO sigue desactivado.

**Siguiente transición:** iniciar MCP-OCP-02 y GOV-TASK-008; ejecutar primero el corte vertical P004 y congelar el schema de observabilidad. Después avanzar MCP-OCP-13 en paralelo con la generalización a 43 principios. En paralelo, preparar EP-TASK-003 para migración y dead-man. La instalación en PC 7 comienza solo con paquete verificado, preflight LOC-OTHER y almacenamiento protegido.


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
3. **PC 7 / LOC-OTHER:** C: aparece cifrado XTS-AES256 al 100 %, pero `ProtectionStatus=0 (Off)`; el estado no acredita protección activa del perfil. EP debe verificar volumen protegido efectivo y root de datos antes de instalación.
4. **Herramientas locales:** el repositorio local de Metodología en el Escritorio de PC 7 no está materializado como checkout Git y `git` no está disponible en el perfil observado. No bloquear desarrollo remoto por GitHub; resolver clone/toolchain solo en la fase que lo requiera.
5. **Presencia/consentimiento:** autenticación del perfil, SID y REGISTER son operaciones interactivas locales. No trasladar tokens ni pedir secretos por chat.

### Insumos del operador

No falta una decisión de producto ni otro host: PC 7/LOC-OTHER ya está designado. Solo se requerirá presencia del operador en el gate de instalación/registro local para confirmar las acciones interactivas. No se solicitan credenciales por chat.

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
