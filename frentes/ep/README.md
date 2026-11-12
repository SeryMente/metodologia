# Frente EP — carpeta canónica

**Repositorio propietario:** `SeryMente/metodologia` (privado).  
**Rama canónica vigente:** `main`; las ramas documentales anteriores se conservan como antecedentes y no prevalecen sobre `main`.

**OEP vigente:** v0.3.78 (`OEP.md`), leído de vuelta desde `main`. La raíz local del workspace es `SeryMente/`: repositorios como carpetas hijas directas, dentro los frentes, y cada frente con `ambitos/` y `modulos/`. No utilizar `SeryMente/Repositorios/`.


- [Persistencia DTC EP/MCP-OCP](OEP.md#95-persistencia-dtc-integrada-epmetodologia-y-continuidad-mcp-ocp--v0325--vcu-ep-v27): continuidad multiubicación EP/Metodología y estado operativo MCP-OCP, con autoridad técnica propia de MCP-OCP.

- [OEP.md](OEP.md): único estado vivo del frente, v0.3.78; §§137–142 fijan estructura directa de SeryMente, módulos, bóveda y confinamiento de datos de usuario; §138 fija CLI por defecto y excepción ante orden expresa de GUI; §139 define MOD-EP-CRYPTO; §141 registra instalación BMAD/OpenCode y estado de integración Groq; §142 documenta MOD-EPVAULT, cifrado, notas efímeras, CLI/GUI y estado de Fila 4; §142.11 registra incidencias, hotfix y evidencia E2E.
- [Especificación general y operación CLI-only](OEP.md#137-especificación-general-única-del-workspace-ep-protegido--2026-11-12): Cryptomator como motor de bóveda, SeryMente como raíz, repositorios hijos directos, frentes, ámbitos, módulos y confinamiento total. [Régimen CLI por defecto y excepción por orden expresa §138](OEP.md#138-operación-cli-only-de-ep-hasta-disponer-de-segundo-monitor--2026-11-12). [Jerarquía y confinamiento §140](OEP.md#140-estructura-canónica-de-serymente-módulos-y-confinamiento-de-aplicaciones--2026-11-12). [BMAD/OpenCode/Groq/RDC §141](OEP.md#141-módulo-bmad--opencode--groq-y-acceso-mediante-chatgpt-rdc--2026-11-12). [EP Vault, incidencias y hotfix §142.11](OEP.md#14211-incidencias-verificadas-y-artefactos-de-integración--2026-11-12).
- [Objeto de coordinación DTC](entregas/COORDINACION-GOBERNANZA-EP-v0.1.md): único registro de comunicación Gobernanza ↔ EP; historial reconciliado en `main`.
- [Control de responsabilidad EP](CONTROL-RESPONSABILIDAD.json): registro autoritativo de titularidad y generación; generación 3; titularidad transferida por TRANSFER_RESPONSIBILITY el 2026-11-09; un titular activo, evento C-EP-TRANSFER-RESPONSIBILITY-20261109-01.
- [MOD-SYNC](OEP.md#mod-sync): propósito aprobado; [especificación de implementación §111](OEP.md#mod-sync-implementation), pendiente de validación técnica.
- [MOD-EP-CRYPTO](OEP.md#139-módulo-funcional-mod-ep-crypto--operación-y-confinamiento-de-cryptomator--2026-11-12): Cryptomator dentro del módulo EP; almacén físico fuera del punto de montaje para evitar recursión.
- [MOD-EP-BMAD / MOD-EP-OPENCODE / MOD-EP-CHROME](OEP.md#141-módulo-bmad--opencode--groq-y-acceso-mediante-chatgpt-rdc--2026-11-12): BMAD estable, agente OpenCode, proveedor Groq y navegador modular; instalación/aceptación sujetas a evidencia.
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

Antecedente histórico del 2026-11-10: OEP v0.3.59 y PREFLIGHT_FILA4=PARTIAL_FAIL; sus estados VHDX/W: y destinos provisionales quedaron supersedidos por la decisión de Cryptomator y la estructura de SeryMente en OEP §§137–141. Conservar este registro solo como procedencia, no como instrucción vigente.

- [OEP §122 · preflight vivo parcial Fila 4](OEP.md#122-preflight-vivo-parcial-de-fila-4--2026-11-10--ejecución-provisional-del-frente-ep)
- [OEP §123 · VHDX de preparación, discrepancia del punto de montaje y pausa operativa](OEP.md#123-rectificación-del-estado-de-almacenamiento-fila-4-y-continuidad-del-sprint--2026-11-10)
- [Evidencia saneada del preflight Fila 4](evidencias/EP-FILA4-PREFLIGHT-PARCIAL-20261110.json): PREFLIGHT_FILA4=PARTIAL_FAIL; commit `2ac3dc5ad2970e71b15a21e33d0740e001c2b183`; blob `9bf9cc7edee2e8a0f483d7191e28b37b1e03e3e5` (evidencia saneada con read-back exacto).


## Canon vigente de seguridad y operación del workspace · 2026-11-12

- [OEP §137](OEP.md#137-especificación-general-única-del-workspace-ep-protegido--2026-11-12): Cryptomator como motor de bóveda, árbol SeryMente y confinamiento integral de datos de aplicaciones.
- [OEP §138](OEP.md#138-operación-cli-only-de-ep-hasta-disponer-de-segundo-monitor--2026-11-12): CLI obligatorio hasta verificar segundo monitor activo y autorización expresa; la autorización de este ciclo no bastó porque la sesión RDC enumeró una sola pantalla y el segundo monitor físico quedó NO VERIFICADO.
- [OEP §139 · MOD-EP-CRYPTO](OEP.md#139-módulo-funcional-mod-ep-crypto--operación-y-confinamiento-de-cryptomator--2026-11-12): módulo interno del frente EP, sin OCP independiente; CLI build y pruebas sintéticas PASS, bóveda real y migración pendientes.
- [EP-TASK-003](./📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md): build CLI local desde upstream firmado; 12 pruebas unitarias, 5 de integración y E2E sintética PASS. Siguen pendientes wrapper PowerShell 5.1, desmontaje graceful Windows, limpieza staging, bóveda real, confinamiento, migración y aceptación.

La crónica histórica se conserva para procedencia; las decisiones operativas actuales son las de OEP §§137–141 y el último estado verificado de cada tarea. No interpretar snapshots anteriores como estado vivo.


Estado documental añadido: OEP v0.3.74, §§140–141. La organización física de Fila 4 ha empezado; la consolidación de Cryptomator, confinamiento de perfiles, autenticación Groq, pruebas BMAD/OpenCode E2E y continuidad multi-terminal siguen sus propios estados en OEP. No inferir aceptación de la mera existencia de carpetas o paquetes.
