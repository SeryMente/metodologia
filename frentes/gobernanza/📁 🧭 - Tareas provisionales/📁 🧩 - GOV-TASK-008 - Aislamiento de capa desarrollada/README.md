## Alineación vigente · C-GOBERNANZA-STREAMLINE-RESPONSABILIDAD-FOLIACION-20261111-01

Sink es vía preferente cuando MCP-OCP esté implementado y disponible. Si no, obtener el texto normativo exacto del DUG canónico main, verificando ID/título, versión/firma, commit/blob y SHA-256. El fallback no cuenta como evento Sink ni crea una segunda fuente normativa. No usar memoria o MDP como sustituto del texto completo. No afirmar que Sink está instalado o aceptado E2E.

# 📝 GOV-TASK-008 · Catálogo, selección y recuperación individual mediante OCP MCP/Sink local vía RDC

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-008`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Definir y aceptar la semántica de dos capas del flujo OCP MCP: inventario inicial de los 43 principios con ID, nombre canónico y MDP acotado; reconocimiento de pertinencia; recuperación obligatoria del texto desarrollado mediante la operación local `SINK:Pxxx` por MCP STDIO/RDC; telemetría limitada a recuperaciones satisfactorias por principio; y huellas individuales más manifiesto del lote ordenado. Mantener el DUG como fuente normativa única; no tratar MDP como norma ni exponer los textos desarrollados en el catálogo inicial.

## Referencia de origen

DUG Samantha v388 · NX-388m · ART-027, secciones 1–8; estrategia originada en C-GOBERNANZA-MDP-OCP-01 y reconciliada mediante C-GOBERNANZA-ART027-SINK-LOCAL-RECONCILIACION-20261110-01.

## Dependencias y límite observado

El DUG conserva los textos desarrollados dentro del mismo HTML y de su proyección `gov-data`. Sink invocado como `SINK:Pxxx` por STDIO/RDC devuelve únicamente el principio solicitado en la respuesta de la operación. Esta minimización es a nivel de aplicación: no es una barrera criptográfica frente a un actor que ya tenga acceso al archivo DUG completo. El repositorio permanece privado. `MOD-SYNC` es un módulo distinto de EP y no interviene en la recuperación Sink.

No publicar `SeryMente/metodologia`, no duplicar silenciosamente los textos y no alterar la autoridad canónica sin una decisión de arquitectura y las autorizaciones aplicables.

## Siguiente actuación

Aceptar el contrato ART-027 v388 y validar primero el corte `SINK:P004`: texto íntegro, ID/título, versión/firma, commit/blob DUG, SHA-256 y fallo cerrado. Separar aceptación de Gobernanza, implementación/pruebas del servidor MCP-OCP y preflight/instalación de EP. No desplegar aliases HTTP ni infraestructura externa.

## Antecedente técnico histórico supersedido · evaluación preliminar

### Requisito de aislamiento

El alias no debe redirigir al HTML completo ni a un fragmento del mismo archivo: el documento contiene los 43 textos desarrollados en `gov-data`. La consulta por ancla `#Pxxx` selecciona visualmente un principio, pero no restringe el contenido que el modelo puede recuperar.

### Diseño candidato sin duplicar la fuente normativa

1. **Primera capa:** servir una proyección MDP-only generada desde el DUG vigente. Campos permitidos: `id`, `title`, `microdescriptor`, `dug_version`, `dug_signature` y `source_blob_sha`. Debe excluir `normative_text` y `content_markdown`. La proyección es derivada, nunca autoridad.
2. **Alias individual:** cada `p001`…`p043` resuelve a una ruta de extracción, no a `blob/main/...#Pxxx`.
3. **Resolvedor:** un Worker obtiene el DUG privado con credencial de lectura almacenada exclusivamente como secreto; valida revisión y extrae por ID exactamente un objeto de `principles[]`. Responde solo ese principio junto con versión, firma y SHA del blob fuente. Ante ID inexistente, credencial inválida o fuente no verificable, falla cerrado y no devuelve el conjunto completo.
4. **Telemetría:** contar accesos por alias; no inferir lectura efectiva ni aplicación. Mantener excluidos los contadores de aplicación.

### Bloqueo de autenticación y exposición

- Un Worker público devolvería el principio solicitado individualmente, pero permitiría a cualquier visitante recorrer los 43 aliases. Mantendría privado el repositorio, no el texto de cada principio.
- Un Worker protegido por Cloudflare Access preservaría una barrera de acceso, pero el flujo disponible de apertura no permite adjuntar encabezados de autenticación al resolvedor. El conector GitHub sí autentica, pero al leer el HTML canónico expone el archivo completo y no satisface aislamiento.
- La sesión no dispone de integración Cloudflare; PC-14 está en línea, pero Wrangler no está instalado. No se instalará ni desplegará infraestructura ni se manipularán secretos sin la vía de autorización y acceso correspondiente.
- No crear copias por principio como sustitutos normativos. Si se propone una proyección estática, debe ser regenerable, derivada y cotejada contra el SHA del DUG en cada versión.

### Decisión pendiente

Para completar el flujo hay que escoger un límite de autenticación compatible con el canal que usará el modelo: **(A)** permitir exposición pública individual de cada texto a través de Sink, manteniendo privado el repositorio; o **(B)** proporcionar una integración autenticada capaz de invocar el resolvedor privado con credenciales fuera del prompt y de las URLs. No se considera equivalente redirigir a GitHub privado con ancla.

### Siguiente actuación

Implementar la opción aprobada, después de contar con acceso Cloudflare o con el canal autenticado alternativo; crear un alias piloto y ejecutar pruebas positivas y negativas antes de generar los 43.

## Criterio de cierre

La capa de inicio expone únicamente ID/nombre/MDP; la apertura del alias recupera solo el texto desarrollado del principio correspondiente; el DUG sigue siendo la fuente canónica; GitHub permanece privado; y la lectura de vuelta verifica ID, versión y contenido.


## Antecedente histórico supersedido · revisión de alcance · 2026-10-31

El requisito de aislamiento se mantiene, pero el diseño de entrega debe coordinarse con OCP MCP y no presuponer Sink/Cloudflare. El modelo recibe el inventario acotado de 43 principios, comunica cuáles aplican al ciclo y obtiene mediante OCP MCP enlaces Sync individuales a las versiones desarrolladas. Cada enlace debe resolver un único principio y conservar versión/firma/SHA de la fuente; no debe exponer los 43 textos desarrollados en la respuesta inicial.

El MDP debe permitir comprender el significado y reconocer pertinencia, pero no sustituir la lectura del principio completo. La fuente normativa sigue siendo el DUG único; cualquier proyección o extracción es derivada, verificable y no adquiere autoridad independiente. La telemetría de esta tarea se limita a frecuencia de acceso.


## Antecedente histórico supersedido · brecha del producto OCP MCP 0.1.0 · 2026-10-31

Las propuestas Worker/Sink/Cloudflare descritas en las secciones precedentes son antecedentes de diseño. Quedaron supersedidas por la decisión aprobada de Sink local mediante MCP STDIO/RDC del 2026-11-09. No existe un requisito operativo llamado Sync para recuperar principios ni se reactivan aliases web.

La rama `build/ocp-mcp-mvp-0.1.0` acredita código persistido, 31 pruebas unitarias y 29 de integración aprobadas; el recibo declara `BUILT_AND_TESTED_NOT_INSTALLED`. Por ello no afirmar instalación ni aceptación E2E. El producto contiene cifrado de fuentes/snapshots AES-256-GCM con DPAPI CurrentUser, importación con commit/blob/SHA-256 y snapshot transaccional BLOB/SQLite con eventos/recibos.

Brechas frente al vector que deben resolverse en OCP MCP:
1. Los metadatos `applicability`, `activation_conditions`, `mandatory` y `dependencies` faltan; selección/snapshot devuelve `BLOCKED_OCPMSP`.
2. El catálogo ofrece 43 IDs/títulos/MDP, pero aún no la etiqueta visible compacta `Principio DI` ni demuestra el mapeo de una a tres palabras hacia título/ID canónicos.
3. No se observan enlaces Sync individuales a textos desarrollados ni herramienta de ampliación individual.
4. No se demuestra telemetría de frecuencia disparada por apertura de cada enlace Sync individual.
5. `selection_sha256` cubre la lista de IDs seleccionados; no demuestra hash del paquete exacto y ordenado de URLs Sync.
6. No se demuestra aceptación del folio global de ciclo y verificación de su vínculo con la sesión autorizada.
7. El manifiesto inicial observado contiene DUG y núcleo OCP, no §ARR/GOW; la frescura frente a `main` figura `NOT_CHECKED_AGAINST_MAIN`.

El código/resolución del servidor corresponde a OCP MCP dentro de su autorización; instalación/host y lectura de vuelta corresponden a EP. Gobernanza define el contrato y verifica aceptación. No abrir una nueva solicitud OCP mientras siga sin recibirse y analizarse la última respuesta registrada en el protocolo bilateral. No reinstalar Sink/Cloudflare por inercia. Trazabilidad: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).



## Decisión de entrega aprobada · Sink local mediante RDC · 2026-11-09 · C-GOBERNANZA-IPZ-RDC-SINK-01

Se elige la opción local autenticada por el perfil Windows, invocada por RDC contra el servidor MCP-OCP local por stdio. Quedan sustituidas como vías de implementación para este desarrollo la exposición individual pública, Worker/Cloudflare Access, URLs Sync por principio y cualquier endpoint/túnel público. GOV-TASK-002 sigue cancelada; no se reactiva.

**Contrato funcional:**
- Capa 1: catálogo con exactamente 43 IDs, nombre de vista y MDP (11–16 palabras). No exponer los 43 textos desarrollados en el inventario inicial.
- Capa 2: consulta obligatoria del texto completo mediante `SINK:Pxxx` cuando el MDP indique pertinencia, aun si el modelo recuerda el principio o lo consultó antes.
- `GOW:ARR` recupera §ARR; `DUG` comprueba y manifiesta la fuente canónica y el pin vigente.
- MCP-OCP entrega solo el principio solicitado. Cada objeto de respuesta contiene ID, título, texto desarrollado íntegro, versión/firma, commit/blob del DUG y SHA-256 propio.
- Puede existir una invocación agrupada con IDs ordenados para reducir viajes RDC; cada principio conserva su resultado verificable y un evento independiente de frecuencia tras recuperación completa satisfactoria.
- El manifiesto/hash cubre el conjunto exacto y ordenado, pin del DUG y huella de cada texto. El hash anterior de IDs seleccionados no basta.
- La frecuencia mide accesos completos registrados por principio; no mide lectura consciente, comprensión, pertinencia ni aplicación. La latencia total del viaje RDC es otra métrica: `ipz.resolve.rdc.duration_ms`, gobernada por GOV-TASK-013.
- El almacén local es una proyección cifrada derivada del DUG único. No se convierte en fuente normativa paralela ni se expone el texto en una URL pública.
- Si la fuente no está importada, no está vigente, falla una huella o RDC no completa la operación, declarar metodología/principio no verificado y no aplicar desde memoria/MDP.
- Los campos de selección automática ausentes en los 43 registros no se infieren. `MCP-NORMATIVO` permanece `DESACTIVADO`.

**Pins históricos del diseño del 2026-11-09:** DUG Samantha v384/NX-384m y MCP-OCP v0.1.21. Quedaron supersedidos por el pin vigente v388/NX-388m indicado en la sección de prioridad P004. Antes del build, el frente MCP-OCP debe revalidar sus propios pins y reconciliar la candidata histórica; este documento de Gobernanza no modifica el OCP técnico.

**Autorización interfrente (registro histórico actualizado):** Gobernanza define y valida el contrato. La autorización vigente para implementar Sink local por STDIO ya está registrada en `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json` (generación 5; `implementation_authorization.status=AUTHORIZED`) y cubre resolver/importador, GOW:ARR, DUG, SINK:P001–P043, lotes, hashes, pruebas, build y paquete. La autorización separada del panel también está registrada como `AUTHORIZED_FOR_PRODUCT_SCOPE_AND_IMPLEMENTATION`. EP conserva la autoridad de host, perfil, almacenamiento e instalación. Gobernanza no modifica esos controles.

**Estado:** decisión de arquitectura resuelta; construcción, importación real, instalación y aceptación E2E siguen pendientes. Las alternativas HTTP/Cloudflare quedan como antecedentes, no como siguiente ejecución.


## Contrato final de dos capas · Sink local por STDIO · 2026-11-09 · reconciliado con ART-027 v388

El inventario de primera capa expone ID, nombre canónico y MDP; no publica los 43 textos desarrollados. Si un principio resulta pertinente, el cliente invoca `SINK:Pxxx` como operación local de MCP-OCP por STDIO/RDC. No se usan URLs Sync, aliases HTTP, acortadores, Cloudflare, túneles ni endpoints públicos. `MOD-SYNC` pertenece a EP y no interviene.

**Respuesta individual:** ID, título, revisión exacta del DUG (versión/firma/commit/blob), texto desarrollado, SHA-256 y estado de verificación. **Lote:** conserva exactamente el orden solicitado y produce subresultado/huella/evento individual solo por recuperación íntegra satisfactoria; los errores no cuentan como recuperación. El hash de lote cubre serialización canónica UTF-8 de la secuencia ordenada, pins comunes y hashes individuales, no solo la selección de IDs.

La telemetría Sink cuenta recuperaciones satisfactorias por ID; no registra aplicación semántica. La latencia RDC es métrica aparte en GOV-TASK-013. `MCP-NORMATIVO` permanece DESACTIVADO. Gobernanza acepta el contrato; MCP-OCP implementa/prueba/paquetea; EP controla host e instalación. Binarios instalados en `frentes/mcp-metodologia/instalacion-local/`; DB, claves, logs operativos y backups fuera del checkout y protegidos. No modificar DUG/ART-025/ART-027/IPZ desde esta tarea.

---

## Prioridad del primer piloto local · SINK:P004 · 2026-11-10

El primer caso de aceptación del contrato de dos capas será `GOW:ARR → DUG → SINK:P004`, con respuesta individual que contenga ID, título, texto desarrollado íntegro, DUG Samantha v388/NX-388m, commit/blob de la fuente y SHA-256 del texto. El lote y P001–P043 se generalizan después del piloto; no se reducen los criterios de integridad del contrato.

La primera E2E debe probar el recorrido que usará el modelo: IPZ → RDC autorizado → MCP-OCP por STDIO → respuesta visible con pin/hash. Un smoke JSON-RPC de consola no demuestra que IPZ pueda invocar Sink.

**Pin DUG vigente para implementación/aceptación:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. En `main` el núcleo MCP-OCP está rebaselined a v0.1.29 y el backlog a v0.10, ambos referidos a DUG v388. La rama candidata `feat/mcp-ocp-sink-p004-pilot-20261110` sigue anclada al commit antiguo `1676901cc09af6fcec4d052800b031e4c2f1ab40`; no satisface el requisito de partir del main vigente y conserva documentación anterior. Por tanto MCP-OCP-02 sigue abierto: el frente MCP-OCP debe producir una rama válida desde el `main` vigente y reconciliarla en su propio OCP antes del build. Gobernanza no modifica código ni backlog MCP.

**Destino del sprint:** alias funcional Fila 4, designado por el operador; PC 7 queda supersedido. Conforme a ART-013, este registro no conserva Device IDs ni SessionIds efímeros de RDC. El preflight vigente se consulta en EP-TASK-003 y OEP §§122–123: el gate sigue PARTIAL_FAIL y la ubicación física continúa sin clasificar. EP determina el dead-man solo tras conocer la ubicación real. La importación privada y el piloto esperan checkout/root protegidos.

**Estado:** contrato de piloto documentado; implementación, importación, respuesta real, hashes cotejados en runtime y E2E siguen pendientes. MCP-NORMATIVO permanece DESACTIVADO.



## Reconciliación del Sprint SINK-P004 · 2026-11-10

**Objetivo:** validar que el contrato de dos capas funciona en la primera prueba vertical `GOW:ARR → DUG v388 → SINK:P004`, sin esperar a la generalización P001–P043 ni al panel.

- **MCP-OCP-02:** P0 abierto; rama limpia desde main y mapa REUSE/ADAPT/REWRITE/DROP.
- **MCP-OCP-05:** P0; implementación de respuesta P004 íntegra, con texto, identidad y hashes, primero con fixtures sintéticos.
- **MCP-OCP-03/04:** P0 paralelo; contrato y negativos sintéticos, harness/smoke STDIO/RDC. El smoke no equivale a E2E desde IPZ.
- **EP-TASK-003:** EP retoma ejecución del preflight Fila 4. El gate sigue PARTIAL_FAIL; la propuesta de almacenamiento que conserva `%USERPROFILE%\Desktop\SeryMente` sigue sin aceptación. No importar fuentes privadas ni instalar antes de PASS.
- **EP-TASK-005:** instalación del piloto por EP después de EP-TASK-003 PASS y paquete P004 probado/manifestado.
- **GOV-TASK-007/003:** preparar IPZ compacta después de congelar contrato; aceptar solo respuesta P004 visible al modelo desde IPZ real → RDC → STDIO.

**Reparto de funciones:** Gobernanza valida y acepta; MCP-OCP implementa/paquetea; EP ejecuta host/instalación. GOV-TASK-015 centraliza. `MCP-NORMATIVO=DESACTIVADO`; FOL1 no bloquea P004; panel WPF obligatorio solo para 1.0.0.

`SINK_P004=NOT_IMPLEMENTED_NOT_ACCEPTED` · `MCP_OCP_02=OPEN` · `EP_TASK_003=PARTIAL_FAIL` · `EP_TASK_005=PENDING` · `GOV_E2E=PENDING`.


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.


## Contrato mínimo verificable · corte vertical P004 · 2026-11-11

Para acelerar H1, separar el contrato individual P004 de catálogo completo, lotes y manifiesto global.

### Capa 1 · inventario

El catálogo presenta 43 entradas con ID, título canónico y MDP, más identidad/pin DUG. Excluye normative_text y texto desarrollado. Esta minimización es de aplicación, no una frontera criptográfica frente a quien ya tiene acceso al HTML DUG; mantener el repositorio privado.

### Capa 2 · recuperación P004

SINK:P004 devuelve un solo principio. MCP-OCP define nombre real de herramienta y schema; Gobernanza no inventa método/argumentos. El resultado permite verificar ID/título canónicos, texto desarrollado íntegro, DUG Samantha v388/NX-388m, firma, commit/blob y SHA-256 del texto con representación documentada. No afirma aplicación automática del principio.

### Fallo cerrado y frecuencia

- ID fuera de P001..P043, fuente no importada/obsoleta, blob distinto, texto ausente o SHA discrepante: no entregar texto parcial ni reemplazo; resultado no verificado.
- Servidor/STDIO/RDC no disponible: no afirmar recuperación; no usar memoria ni MDP como fallback normativo.
- Solo recuperación completa y satisfactoria incrementa frecuencia. Fallos no incrementan.
- Para H1 basta P004 y un negativo representativo; MCP-OCP-03 cubre fuente ausente, stale pin, blob alterado y SHA discrepante mediante fixtures.

### Fuera del corte P004

Lotes, orden, hash global de manifiesto y telemetría de 43 principios se verifican después de P004 PASS. No condicionar H1 a batch, 43+8, panel WPF ni release 1.0.0. El manifiesto de lote no aplica a recuperación individual; procedencia y SHA individual sí son obligatorios desde P004.

### Evidencia mínima de aceptación

Respuesta capturada por camino real y cotejada contra texto DUG; identidad/pin DUG; ID/título; SHA del principio; un evento de frecuencia; un negativo que no incrementa; read-back del informe. MCP-OCP acredita prueba técnica/paquete; EP acredita instalación; Gobernanza acepta semántica y E2E.

**Estado:** contrato mínimo P004 aclarado; no hay aceptación técnica ni E2E por esta actualización.

---
## Reconciliación estática del schema piloto P004 · 2026-11-11

La revisión de solo lectura del candidato PR #27 identificó este contrato declarado por MCP-OCP:

- Herramienta: sink_principle.
- Entrada: objeto con propiedad principle_id de tipo string y enum limitado a P004.
- Propiedad requerida: principle_id; additionalProperties=false.
- Invocación declarada: tools/call con name=sink_principle y arguments={principle_id:P004}.
- Otro ID devuelve PILOT_ONLY_SUPPORTS_P004; por tanto el piloto no expone P001–P043 completos.

**Fuente:** frentes/mcp-metodologia/src/OcpMcp/McpServer.cs, blob 0b116f82edb2fe60fa2351c12f7b6c7850e146e8, rama feat/mcp-ocp-sink-p004-main-a34c1c5b, PR #27 head 5cc59b708c1d5894e7dbfd2a724504fdf5b92974. Al corte: PR OPEN/DRAFT/NOT MERGED; main d167c17d2882e05821f28ce19f7e505fc460c4a1; compare DIVERGED 53 ahead / 160 behind. Es inspección estática de una candidata no aceptada; no demuestra el schema publicado por proceso instalado.

**Condición para congelar contrato:** MCP-OCP debe reconciliar su candidata con main y entregar el artefacto final. EP instala ese artefacto. Luego GOV-TASK-003 verifica tools/list por la conexión real y coteja tools/call. No inventar nombres ni argumentos alternativos.

**Estado:** mapping documental P004 preparado; runtime/read-back y aceptación E2E NO_VERIFICADOS.


---

## Informe parcial · GOV-TASK-008 · contrato P004 y pin v389 · 2026-11-11

- **Estado:** EN_CURSO; schema estático observado, runtime no verificado.
- **Corte:** main `a1ba2611fd1c218d8f7647f02f7adf5c1dbff8e8`; DUG v389/NX-389m blob `bcd99e72113f444a045d7f1c91b4ad36865b8ea8`; PR #28 HEAD `86e58cff0e58a2452361ff8abe031917dc9a5b11`, 52/17 DIVERGED.
- **Resultado:** `tools/list` estáticamente declara `sink_principle`; `inputSchema` requiere `principle_id` string enum [P004], `additionalProperties=false`. `tools/call` usa ese nombre y argumento; ID distinto devuelve `PILOT_ONLY_SUPPORTS_P004`. Fuente MCP-OCP `McpServer.cs` blob `0b116f82edb2fe60fa2351c12f7b6c7850e146e8`. No equivale a runtime.
- **Hallazgo P0:** SourcePin blob `a99dcd448724256de238da0e312d12f0d96e4152` y SOURCE-PIN blob `d1e2de14d5959fe61d64ce4b8ec3c3c8ec574c06` fijan v388/blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. DUG v389 es blob `bcd99e72113f444a045d7f1c91b4ad36865b8ea8`. DugSourceReader blob `294116597fdb281ca1e4e8bf2d9a5e2e94234af3` recalcula el Git blob y falla cerrado (`DUG_GIT_BLOB_PIN_MISMATCH`) ante diferencia. El texto P004 actual coincide con el observado en v388, pero la fuente íntegra no.
- **Paquete:** ZIP 137.784 B, SHA `705716c7aa581a98817869eb281b87500b591c4e811653c3a6825e1ceb59a3d2`; manifest SHA `03ef3b75d21a153d6b659056c4e401ca65fd6e7f2355cc57d48ed6e71746f750`; recibo SHA `b068287641fa908d56bc2196dad2a4e840a0120eacf6538c74914e1bc1fdcffd`. RUNBOOK y manifest/SOURCE-PIN discrepan en base/merge; candidato no aceptado.
- **Validación:** schema estático PASS documental; pin contra DUG v389 FAIL; tools/list runtime, llamada, negativo runtime, instalación y E2E NOT_RUN.
- **Bloqueantes:** MCP-OCP debe sincronizar branch, actualizar pin/fixtures, validar v389 y regenerar paquete completo; EP debe superar gates e instalarlo; Gobernanza coteja runtime después.
- **Riesgos:** instalar v388 sobre DUG v389 genera rechazo fail-closed; no sustituir por memoria ni MDP. MCP-NORMATIVO DESACTIVADO.
- **Aceptación:** contrato candidato no congelado para runtime; tarea sigue abierta.
- **Siguiente acción:** esperar artefacto v389 y verificar tools/list/call reales.
- **Conclusión:** PARCIAL · PIN ACTUAL INCOMPATIBLE.

