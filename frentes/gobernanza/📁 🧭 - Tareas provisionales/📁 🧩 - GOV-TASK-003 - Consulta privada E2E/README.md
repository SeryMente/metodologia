# 📝 GOV-TASK-003 · Prueba E2E del flujo OCP MCP/Sink local vía RDC

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-003`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Verificar de extremo a extremo el uso real desde el contexto IPZ: `GOW:ARR` → identidad y procedencia DUG → catálogo de 43 MDP → recuperación `SINK:Pxxx` mediante MCP-OCP local por STDIO/RDC → respuesta visible, íntegra y validada. El primer corte de aceptación es P004; la generalización P001–P043 y los lotes se prueban después. Comprobar frecuencia solo por recuperación satisfactoria, pins/hashes individuales y manifiesto del lote ordenado cuando corresponda. FOL1 y los folios globales no son compuerta del piloto P004.

## Referencia de origen

ART-027 vigente en DUG Samantha v388 · NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`; repositorio privado `SeryMente/metodologia`.

## Dependencias y límites

Depende de GOV-TASK-001, GOV-TASK-007, GOV-TASK-008, la implementación MCP-OCP y la instalación/read-back autorizados por EP. La prueba no se satisface con leer manualmente el HTML ni con una llamada JSON-RPC desde consola: debe comprobar la invocación real desde contexto IPZ por RDC/STDIO y la respuesta visible al modelo. Incluye controles positivos y negativos y conserva el DUG como única fuente normativa. No requiere FOL1 para el piloto P004.

## Siguiente actuación

Tras la entrega de OCP MCP y la instalación validada por EP, ejecutar el flujo completo de aceptación. Antes de esa condición, revisar schemas y artefactos de release; no ejecutar instalaciones en el host ni declarar prueba E2E a partir de unit tests o de telemetría genérica.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.


## Antecedente histórico supersedido · revisión de alcance · instrucción del operador · 2026-10-31

La prueba E2E deja de describirse exclusivamente como «Sink → GitHub». Debe verificar el flujo completo con OCP MCP: validar el folio del ciclo y su vínculo con la sesión autorizada; entregar el inventario de 43 principios; recibir la selección del modelo; devolver enlaces Sync individuales a los textos completos seleccionados; registrar la frecuencia de cada acceso; permitir solicitar principios adicionales cuando la información sea insuficiente; y emitir un hash verificable del paquete exacto de enlaces.

La prueba debe cubrir respuestas positivas y negativas, IDs inexistentes, ciclo/sesión no válidos, enlace no resoluble, fuente desactualizada, hash alterado y fallo cerrado. No declarar que el servidor 0.1.0 satisface el flujo hasta obtener evidencia de cada operación. La instalación/operación local y el transporte RDC pertenecen a EP; esta tarea define aceptación funcional desde Gobernanza.



## Rectificación de arquitectura aprobada · 2026-11-09 · C-GOBERNANZA-IPZ-RDC-SINK-01 · reconciliada con ART-027 v388

La aceptación E2E se realizará sobre el flujo **ChatGPT/IPZ → RDC → MCP-OCP local por stdio → almacén local → respuesta validada**. Las referencias ejecutables son `GOW:ARR`, `DUG` y `SINK:P001` … `SINK:P043`. No se exige una URL por principio ni un resolvedor HTTP. Las menciones previas a Sync URLs y paquetes de URLs quedan como antecedentes sustituidos para este flujo.

Pruebas exigidas:
1. `GOW:ARR` devuelve §ARR desde la fuente importada y verificada.
2. `DUG` identifica versión, firma, commit, Git blob SHA y SHA-256 del documento; el inventario conserva los 43 IDs/MDP.
3. Cada `SINK:Pxxx` devuelve únicamente el texto desarrollado correspondiente, su ID, título, pin de DUG y SHA-256; un ID inexistente o un texto cuyo hash no coincida falla cerrado.
4. Cada recuperación completa y satisfactoria produce un evento individual de frecuencia para ese principio. Una llamada agrupada conserva el orden pedido y produce un resultado/evento por cada principio recuperado; una consulta fallida no cuenta como recuperación lograda.
5. El manifiesto representa el conjunto exacto y ordenado: IDs solicitados, versión/firma/commit/blob del DUG y SHA-256 de cada texto. Su hash se calcula sobre serialización canónica UTF-8; no basta `selection_sha256` de IDs ni un hash de URLs.
6. Si RDC no responde, el servidor no está disponible, la fuente está obsoleta/no importada o hay una discrepancia de hash, el resultado es no verificado y no se aplica el principio. No se sustituye por memoria ni por MDP.
7. La latencia de extremo a extremo se registra separadamente mediante `ipz.resolve.rdc.duration_ms` según GOV-TASK-013: reloj monotónico, inicio inmediatamente antes del despacho RDC y final al recibir y validar mínimamente la respuesta completa. Si no se pueden observar ambos extremos: `NOT_MEASURED`. No mezclar latencia y frecuencia.

**Compuertas:** el piloto P004 requiere Sink implementado y probado por MCP-OCP, pins DUG v388 actuales y la instalación/read-back en Fila 4 que corresponda a EP. La generalización P001–P043 y los lotes es una fase posterior al PASS P004. Esta tarea no autoriza host, instalación ni cambio de control ajeno. FOL1 sigue pendiente y no bloquea el piloto; no inventar folios globales. `MCP-NORMATIVO` permanece desactivado.

**Estado:** la especificación de aceptación está armonizada; la ejecución E2E permanece `PENDIENTE`.


## Contrato de aceptación del sprint · instalación local Metodología · 2026-11-09

La prueba acepta el producto instalado en el recorrido que utilizará el operador, no un root temporal de test. La aplicación local deberá estar en `frentes/mcp-metodologia/instalacion-local/` dentro del checkout de Metodología (`SeryMente/Repositorios/Metodologia/metodologia/`). Su ruta Windows se resuelve desde la raíz real del checkout. La base SQLite, claves, logs operativos y backups quedan fuera del checkout, bajo un root separado protegido y verificado por EP; no aceptar DB, claves ni datos de usuario dentro de Git.

**Secuencia E2E:** fase piloto P004: comprobar readiness real (separada de proceso activo); MCP `initialize`; `tools/list`; recuperar `GOW:ARR`, identidad/procedencia DUG, catálogo 43 MDP y `SINK:P004`; cotejar texto íntegro, ID/título, pin y SHA-256; confirmar evento de frecuencia solo tras recuperación satisfactoria; provocar rechazo por ID inexistente, fuente ausente/obsoleta/alterada y hash distinto; cerrar limpiamente. Tras aceptar el piloto, ampliar la misma suite a `SINK:P001..P043`, lotes ordenados, parámetros inválidos y rutas no autorizadas; verificar eventos por principio y manifiesto/hash del lote.

**Salida:** recibo con host/perfil, ruta de instalación, commit y versión MCP-OCP, pins DUG, casos, hashes, eventos/frecuencias, resultado de pruebas y limitaciones. La latencia `ipz.resolve.rdc.duration_ms` se toma de GOV-TASK-013 y queda `NOT_MEASURED` si no se prueban ambos extremos monotónicos.

**Separaciones:** esta prueba no instala la IPZ nativa ni activa FOL1; no activa `MCP-NORMATIVO`; no usa Sync/HTTP/Cloudflare ni sustituye fuentes con memoria.


---

## Estado vigente de dependencias para SINK:P004 · 2026-11-10

- **P004:** implementación y aceptación E2E continúan pendientes. No se confunde la rama candidata existente con una rama limpia aceptable.
- **MCP-OCP-02 (cotejo histórico):** la referencia `feat/mcp-ocp-sink-p004-pilot-20261110` apunta al commit antiguo `1676901cc09af6fcec4d052800b031e4c2f1ab40`. El cotejo registrado entonces la mostraba 53 commits detrás de un `main` de esa fecha, sin commits exclusivos. Esa cifra no es un estado vivo; el dato operativo prevalente es que la rama no parte del `main` vigente. MCP-OCP-02 sigue abierto; se requiere rama desde main actual y baseline core v0.1.29/backlog v0.10/DUG v388.
- **EP:** destino Fila 4; EP-TASK-003 sigue `PARTIAL_FAIL`. El VHDX de preparación está vacío, sin BitLocker, y el diseño para conservar `%USERPROFILE%\Desktop\SeryMente` no está aceptado. El checkout local sigue parcial/sin `.git`. EP-TASK-005 permanece pendiente.
- **Paralelismo habilitado:** MCP-OCP-03 puede ejecutar pruebas con fixtures sintéticos; MCP-OCP-04 puede preparar harness/smoke; MCP-OCP-05 puede construir la vertical no sensible con fixtures. El gate EP no bloquea esas tareas remotas.
- **Comprobación local bloqueada:** no importar DUG/fuentes privadas, crear DB real, instalar, aprovisionar operador ni dejar runtime persistente hasta EP-TASK-003 PASS y paquete P004 verificable.
- **Aceptación final:** requiere uso desde contexto IPZ real → RDC → MCP-OCP STDIO y respuesta íntegra P004 visible al modelo con pin/hash. El smoke de consola no basta.

`GOV-TASK-003=SPECIFIED_PENDING_E2E` · `IPZ_NATIVE=NOT_VERIFIED` · `FOL1=PREPARADO_PENDIENTE_ACTIVACION_IPZ` · `MCP-NORMATIVO=DESACTIVADO`.


---

## Reanudación del Sprint SINK-P004 · criterio E2E vigente · 2026-11-10

GOV-TASK-003 es la tarea de aceptación del piloto; no implementa ni instala el servidor. Su criterio de cierre para la primera fase es una demostración observable de `GOW:ARR → DUG v388 → SINK:P004` invocada desde el contexto IPZ real por RDC/STDIO y con respuesta íntegra visible al modelo. La evidencia debe incluir ID/título, versión/firma, commit/blob de fuente y SHA-256 del texto. Un smoke JSON-RPC de consola, una prueba de unidad o la presencia de un ejecutable no son E2E.

**Precedencias:** MCP-OCP-02 debe producir rama limpia desde main; MCP-OCP-05 implementa P004; MCP-OCP-03 y 04 ejecutan contrato/harness; EP-TASK-003 debe pasar y EP-TASK-005 debe instalar el paquete P004 verificado. GOV-TASK-007 prepara el candidato IPZ compacto en paralelo, pero su congelación depende del contrato de respuesta P004. La escritura/read-back nativa de IPZ es acto separado y no se afirma realizada.

**Estado de ejecución:** `GOV-TASK-003=PENDING_E2E`; `MCP_OCP_02=OPEN`; `MCP_OCP_05=PENDING`; `EP_TASK_003=PARTIAL_FAIL`; `EP_TASK_005=PENDING`; `IPZ_NATIVE=NOT_VERIFIED`. FOL1 no bloquea este piloto y sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`. `MCP-NORMATIVO=DESACTIVADO`.

**Responsabilidad:** Gobernanza ejecuta y acepta la prueba; MCP-OCP entrega el servidor y las pruebas; EP ejecuta el preflight/instalación local. GOV-TASK-015 es el coordinador interfrente único.
