# Frente EP — carpeta canónica

**Repositorio propietario:** `SeryMente/metodologia` (privado).  
**Rama canónica vigente:** `main`; las ramas documentales anteriores se conservan como antecedentes y no prevalecen sobre `main`.


- [Persistencia DTC EP/MCP-OCP](OEP.md#95-persistencia-dtc-integrada-epmetodologia-y-continuidad-mcp-ocp--v0325--vcu-ep-v27): continuidad multiubicación EP/Metodología y estado operativo MCP-OCP, con autoridad técnica propia de MCP-OCP.

- [OEP.md](OEP.md): único estado vivo del frente, v0.3.71; §137 es la especificación general única del workspace Cryptomator, su directorio, herramientas, dependencias y confinamiento integral de datos de aplicaciones. Implementación, migración, limpieza del diseño anterior y aceptación siguen pendientes.
- [Especificación general única del workspace](OEP.md): árbol SeryMente, Cryptomator, Herramientas, Repositorios, Datos, Temporal y confinamiento de todos los datos persistentes de aplicaciones.
- [Objeto de coordinación DTC](entregas/COORDINACION-GOBERNANZA-EP-v0.1.md): único registro de comunicación Gobernanza ↔ EP; historial reconciliado en `main`.
- [Control de responsabilidad EP](CONTROL-RESPONSABILIDAD.json): registro autoritativo de titularidad y generación; generación 3; titularidad transferida por TRANSFER_RESPONSIBILITY el 2026-11-09; un titular activo, evento C-EP-TRANSFER-RESPONSIBILITY-20261109-01.
- [MOD-SYNC](OEP.md#mod-sync): propósito aprobado; [especificación de implementación §111](OEP.md#mod-sync-implementation), pendiente de validación técnica.
- [MOD-SCRIPTPWS](OEP.md#94-módulo-funcional-mod-scrippws--powershell-para-entorno-persistente--v0326--vcu-ep-v28): módulo funcional interno PowerShell; responsabilidad funcional delimitada en OEP §94, sin OCP ni control independiente.
- [EP Vault — reconstrucción, CLI y GUI](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-004%20-%20Reconstrucción%20de%20bóveda/README.md): herramienta de Metodología; no es extensión Chrome.
- [Registro de tareas provisionales](📁%20🧭%20-%20Tareas%20provisionales/README.md): índice y compuerta de apertura/cierre por ciclo.
- [Claudia](prompts/CLAUDIA.txt) y [Samantha](prompts/SAMANTHA.txt): materializaciones de rol subordinadas al OEP; verificar frescura antes de usarlas.
- [Originales](originales/): dictados y conversaciones preservados con su procedencia.
- [ChatGPT-EP-20261107-1111.txt](originales/ChatGPT-EP-20261107-1111.txt): original de reanudación del 2026-11-07; byte-exactamente preservado.
- [ChatGPT-JULES-20261101-1732.md](originales/ChatGPT-JULES-20261101-1732.md): conversación fuente del módulo funcional `jules` de KHORA-MCP; original resguardado por EP, sin crear un módulo/OCP de Jules en EP ni transferir la titularidad del frente padre.
- [Evidencias](evidencias/): fuentes adquiridas y límites de custodia; una mención no demuestra recepción.
- [EP-B2-SMOKE-20261107.json](evidencias/EP-B2-SMOKE-20261107.json): recibo saneado de autenticación Master, preflight y upload/read-back sintético. El criterio de segundo equipo físico fue supersedido por OEP §104.
- [Revisiones](revisiones/): recibos/manifiestos; sus hashes se cotejan contra los blobs de `main`.
- [Artefactos](artefactos/): entregas históricas; no sustituyen el estado vivo.

**Límites:** RDC es exclusivo del asistente según OEP; no se presume autenticación B2, operación del host, instalación, restauración ni aceptación técnica. Los secretos no se guardan en Git ni se comparten por chat.

- [ChatGPT-EP-20261107-1144.txt](originales/ChatGPT-EP-20261107-1144.txt): export de continuidad del 2026-11-07; original preservado byte por byte y registrado en OEP §101.
- [ChatGPT-EP-20261109-1104.md](entregas/ChatGPT-EP-20261109-1104.md): export de continuidad del 2026-11-09; 38.069 bytes/999 líneas; SHA-256 B032A6033BABC0B1061C2823D5B3C64C3A041DC842978E73B6D26216977805D4; Git blob f14febd7b5f673d9b2f7b1226603eb1243758ea0; read-back exacto.

- [INSTRUCCION-MATERIALIZACION-UBICACIONES-20261107.txt](originales/INSTRUCCION-MATERIALIZACION-UBICACIONES-20261107.txt): entrada rectora preservada y registrada en OEP §104.
- [PERFIL-CSEC-PREFLIGHT-20261107.json](evidencias/PERFIL-CSEC-PREFLIGHT-20261107.json): preflight histórico inicial del host; la ubicación operativa fue corregida por el operador a CECEQ y su política vigente está en PERFIL-CECEQ-POLITICA-20261107.json.

- [INSTRUCCION-BITLOCKER-CECEQ-20261107.txt](originales/INSTRUCCION-BITLOCKER-CECEQ-20261107.txt): decisión rectora de cifrado ubicuo y excepción de conservación en CECEQ.
- [PERFIL-CECEQ-POLITICA-20261107.json](evidencias/PERFIL-CECEQ-POLITICA-20261107.json): perfil canónico CECEQ, BitLocker y volatilidad por ubicación.

- [EP Vault · estado actual y custodia de recuperación](OEP.md#114-custodia-de-protector-de-recuperación-bitlocker--pc-14--2026-11-09): estado de GUI 3D y protección VHDX PC-14.
- [ChatGPT-EP-20261109-1230.md](entregas/ChatGPT-EP-20261109-1230.md): exportación recibida desde PC-14 / perfil PC 13; 40.832 bytes / 853 líneas; SHA-256 `045FD76745669E2AD08A4A0F517FCB042B5CD2C3B3320AB5AD2E83F0972EF674`; Git blob `1be5a3b2a19dec4dd819648302664606654a4761`; read-back Base64 byte-exacto; análisis en OEP §115.

## Destino vigente sprint MCP-OCP · 2026-11-10

El destino de trabajo e instalación del sprint MCP-OCP es **Fila 4**, alias funcional designado por el operador; PC 7 queda supersedido. El preflight del 2026-11-10 observó una sesión de trabajo activa, pero los identificadores técnicos efímeros de host/sesión y los datos concretos de cuenta/perfil no se conservan conforme a DUG v388, ART-013. La ubicación física permanece **NO CLASIFICADA**; la presencia del operador frente a Fila 4 fue reportada, pero CECEQ no está confirmado. Resultado: **PREFLIGHT_FILA4=PARTIAL_FAIL**; C: XTS-AES128, Protection Off y sin protectores; checkout Metodología parcial sin `.git`; workspace original preservado.

- [OEP §120 · rectificación del host y fast path IPZ/SINK](OEP.md#120-rectificación-de-host-de-trabajo-e-instalación-mcp-ocp--2026-11-10--oep-v0355)
- [EP-TASK-003 · workspace Fila 4](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md)
- [EP-TASK-005 · piloto SINK:P004 y aceptación MCP-OCP 1.0.0](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md)

OEP vigente: v0.3.59. PREFLIGHT_FILA4=PARTIAL_FAIL. EP reanuda la ejecución de EP-TASK-003/005 al recibir el encargo del operador; esta sesión queda como coordinadora interfrente. Control EP generación 3 sin cambios. El VHDX de 30 GiB quedó creado y montado como W: (última observación), GPT/NTFS, vacío y sin BitLocker; no se copió ni sustituyó Desktop/SeryMente. El diseño para conservar la ruta original sigue PROPOSED_NOT_ACCEPTED. Checkout protegido, dead-man si corresponde, instalación y SINK/IPZ E2E permanecen pendientes.

- [OEP §122 · preflight vivo parcial Fila 4](OEP.md#122-preflight-vivo-parcial-de-fila-4--2026-11-10--ejecución-provisional-del-frente-ep)
- [OEP §123 · VHDX de preparación, discrepancia del punto de montaje y pausa operativa](OEP.md#123-rectificación-del-estado-de-almacenamiento-fila-4-y-continuidad-del-sprint--2026-11-10)
- [Evidencia saneada del preflight Fila 4](evidencias/EP-FILA4-PREFLIGHT-PARCIAL-20261110.json): PREFLIGHT_FILA4=PARTIAL_FAIL; commit `2ac3dc5ad2970e71b15a21e33d0740e001c2b183`; blob `9bf9cc7edee2e8a0f483d7191e28b37b1e03e3e5` (evidencia saneada con read-back exacto).


## Canon vigente de seguridad del workspace · 2026-11-12

- [OEP §136](OEP.md#136-canon-de-protección-del-workspace-y-confinamiento-de-aplicaciones--2026-11-12): Cryptomator, EP-CRYPTO, catálogo de aplicaciones, bootstrap mínimo y confinamiento de perfiles/configuración/cachés/logs/temporales.
- [EP-TASK-003](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md): implementación del workspace protegido y migración controlada. Diseño BitLocker-only sustituido; no se ha instalado Cryptomator ni movido datos.

La crónica histórica se conserva para procedencia; las decisiones operativas actuales son las de OEP §136 y el último estado verificado de cada tarea. No interpretar snapshots anteriores como estado vivo.
