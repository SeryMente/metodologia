# Frente EP — carpeta canónica

**Repositorio propietario:** `SeryMente/metodologia` (privado).  
**Rama canónica vigente:** `main`; las ramas documentales anteriores se conservan como antecedentes y no prevalecen sobre `main`.


- [Persistencia DTC EP/MCP-OCP](OEP.md#95-persistencia-dtc-integrada-epmetodologia-y-continuidad-mcp-ocp--v0325--vcu-ep-v27): continuidad multiubicación EP/Metodología y estado operativo MCP-OCP, con autoridad técnica propia de MCP-OCP.

- [OEP.md](OEP.md): único estado vivo del frente, v0.3.46.
- [Objeto de coordinación DTC](entregas/COORDINACION-GOBERNANZA-EP-v0.1.md): único registro de comunicación Gobernanza ↔ EP; historial reconciliado en `main`.
- [Control de responsabilidad EP](CONTROL-RESPONSABILIDAD.json): registro autoritativo de titularidad y generación; generación 3; titularidad transferida por TRANSFER_RESPONSIBILITY el 2026-11-09; un titular activo, evento C-EP-TRANSFER-RESPONSIBILITY-20261109-01.
- [MOD-SYNC](OEP.md#mod-sync): propósito aprobado; [especificación de implementación §111](OEP.md#mod-sync-implementation), pendiente de validación técnica.
- [MOD-SCRIPTPWS](OEP.md#94-módulo-funcional-mod-scrippws--powershell-para-entorno-persistente--v0326--vcu-ep-v28): módulo funcional interno PowerShell; responsabilidad funcional delimitada en OEP §94, sin OCP ni control independiente.
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

- [EP Vault · diseño hiperrealista v2 y estado actual](OEP.md#113-transferencia-de-titularidad-primaria-ep--generación-3--2026-11-09): estado de GUI 3D y protección VHDX PC-14.