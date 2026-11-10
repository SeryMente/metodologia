# Frente EP — carpeta canónica

**Repositorio propietario:** `SeryMente/metodologia` (privado).  
**Rama canónica vigente:** `main`; las ramas documentales anteriores se conservan como antecedentes y no prevalecen sobre `main`.


- [Persistencia DTC EP/MCP-OCP](OEP.md#95-persistencia-dtc-integrada-epmetodologia-y-continuidad-mcp-ocp--v0325--vcu-ep-v27): continuidad multiubicación EP/Metodología y estado operativo MCP-OCP, con autoridad técnica propia de MCP-OCP.

- [OEP.md](OEP.md): único estado vivo del frente, v0.3.58; §122 conserva el preflight vivo parcial de Fila 4 y §123 registra el VHDX vacío sin cifrar, la discrepancia del punto de montaje y la pausa operativa. §121 fija el P0 del sprint Sink P004 y sus dependencias.
- [Organización canónica del workspace](OEP.md#119-organización-canónica-del-workspace-local-y-persistencia-por-frente--v0354--2026-11-09): repositorios agrupados por frente, datos/temporales separados y secretos fuera del workspace.
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

El host de trabajo e instalación del sprint MCP-OCP sigue siendo **Fila 4**. Preflight vivo del 2026-11-10: hostname **PC10RCIF4EI4**, perfil **CENTRAL\\fila4** / **C:\\Users\\fila4**, sesión **console / ID 1**, RDC Device ID **99383b36-cc22-4457-952f-8799cccac0a7**. El Device ID anterior **d0bbb2a3-d7b4-45e1-8870-652c2c3844fc** y SessionId 4 son referencias históricas no confirmadas en esta lectura. La ubicación física permanece sin clasificar: **central.gob.mx / DomainAuthenticated** no demuestra CECEQ ni LOC-OTHER. Resultado: **PREFLIGHT_FILA4=PARTIAL_FAIL**; C: XTS-AES128, Protection Off y sin protectores; checkout Metodología parcial sin .git. Workspace preservado.

- [OEP §120 · rectificación del host y fast path IPZ/SINK](OEP.md#120-rectificación-de-host-de-trabajo-e-instalación-mcp-ocp--2026-11-10--oep-v0355)
- [EP-TASK-003 · workspace Fila 4](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md)
- [EP-TASK-005 · piloto SINK:P004 y aceptación MCP-OCP 1.0.0](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md)

OEP vigente: v0.3.58. PREFLIGHT_FILA4=PARTIAL_FAIL. El VHDX de 30 GiB quedó creado y montado como W: (última observación), GPT/NTFS, vacío y sin BitLocker; no se copió ni sustituyó Desktop/SeryMente. El diseño para conservar la ruta original sigue PROPOSED_NOT_ACCEPTED. Checkout protegido, dead-man si corresponde, instalación y SINK/IPZ E2E permanecen pendientes.

- [OEP §122 · preflight vivo parcial Fila 4](OEP.md#122-preflight-vivo-parcial-de-fila-4--2026-11-10--ejecución-provisional-del-frente-ep)
- [Evidencia saneada del preflight Fila 4](evidencias/EP-FILA4-PREFLIGHT-PARCIAL-20261110.json): PREFLIGHT_FILA4=PARTIAL_FAIL; commit 84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd; blob 8ebf0c2b54efc6d3fe597adfe0f9358e65e6acbe.
