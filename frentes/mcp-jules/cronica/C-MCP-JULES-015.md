# C-MCP-JULES-015 · retoma por RDC, persistencia del original y transferencia de responsabilidad

**Fecha del ciclo:** 2026-10-30.  
**OCP:** `frentes/mcp-jules/`.  
**Evento local UUIDv7:** `01a18f95-61cf-70ce-9321-c56fbd3cc99d`.  
**Folio de sesión:** PENDIENTE / NO ASIGNADO; FOL1 inactivo.  
**Propietario operativo:** `chatgpt-C-MCP-JULES-015-01a18f95-61cf-70ce-9321-c56fbd3cc99d`.  
**Instancia:** `chatgpt-mcp-jules-2026-10-30-01a18f95`.  
**Gobierno adquirido:** DUG v372 · NX-372m; Metacanon 1.26; GOW 2.14, desde `SeryMente/metodologia/main`.

## 1. Instrucciones y alcance del ciclo

El operador indicó que la única sesión local RDC disponible es la que debe utilizarse y autorizó asumir la sesión actual y la responsabilidad del frente MCP Jules. También precisó que no debe tener que generar, copiar, pegar o transportar Bearers, y que no ejecutará comandos manuales; ChatGPT debe operar mediante RDC.

Se conserva la distinción entre consentimiento de seguridad y transporte manual de credenciales: el nuevo puente solicita una única aprobación OAuth explícita en la página de Khora abierta por el propio cliente; no pide al operador crear ni manipular tokens. La sesión activa de RDC observada es PC-14. Cualquier estado local anterior se considera perdido, por instrucción del operador.

## 2. Original documental recibido y persistido

Se localizó mediante RDC el archivo `ChatGPT-JULES-20261030-1858.md` en Downloads. Se preservó el original sin transformación:

- Tamaño: **241.772 bytes**; 4.926 líneas.
- SHA-256 de origen: `B7D25FF3CBF233787D201AB0D7643E45C181EAE4430E3300876BCFE8CF3B1737`.
- Ruta canónica relativa: `documentos/originales/ChatGPT-JULES-20261030-1858.md`.
- Commit de captura: `a5a42c8a4f9c9aec16463b36b367ebbfa521ba13`.
- Blob Git: `606682d92e1d4d1015dd28601ca3f0219888ef16`.

La lectura de vuelta descargó el archivo de la misma rama, decodificó el contenido base64 a un temporal local y comparó el SHA-256 y la longitud. Ambos coincidieron exactamente; el temporal de cotejo se eliminó. Estado: **PERSISTIDO Y VERIFICADO EN LA RAMA DEL PR #19**. No se afirma todavía presencia canónica en `main`.

El primer documento del OCP creó `documentos/MANIFIESTO-DOCUMENTAL.json`, commit `f818744176c4f2a1b840a68554441cfec31a9595`, blob `efcf43dcab2fd5ab2522285779e95ff10a3e8e63`, con lectura de vuelta correcta. El recibo completo se encuentra en [evidencias/C-MCP-JULES-015.json](../evidencias/C-MCP-JULES-015.json).

## 3. Transferencia de responsabilidad del frente

El control observado antes del cambio estaba en generación 2, propietario `chatgpt-C-MCP-JULES-005-SES-20261029-6C2F9A17`, blob SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`. Se utilizó la autorización explícita del operador en este ciclo para transferir únicamente `frentes/mcp-jules/` a la sesión RDC activa.

- Propietario anterior: `chatgpt-C-MCP-JULES-005-SES-20261029-6C2F9A17`, generación 2.
- Nuevo alias operativo: `chatgpt-C-MCP-JULES-015-01a18f95-61cf-70ce-9321-c56fbd3cc99d`.
- Instancia: `chatgpt-mcp-jules-2026-10-30-01a18f95`.
- Nueva generación: **3**.
- Control final blob SHA: `113bf1930638843d52fe68441e76b2e0879e83f5`; el SHA de lectura de vuelta coincide.
- No se expuso un ID nativo de conversación ChatGPT; el alias está declarado como operativo, no nativo.
- No se asignó folio nuevo. `session_folio=null`; estado `PENDIENTE_NOT_ASSIGNED_FOL1_INACTIVE`. El folio anterior se conserva en el historial de transferencia.
- El control padre `frentes/metacanon/` no fue modificado.

La transferencia está escrita y verificada únicamente en la rama documental del PR #19. La titularidad canónica en `main` queda pendiente de la integración de ese PR.

## 4. Solución Khora/Jules y corrección del flujo manual

Se revisó la rama de Khora PR #347. El procedimiento original que requería generar un Bearer manual, copiarlo y pegarlo en PowerShell no satisfacía las instrucciones directas del operador, por lo que se sustituyó por un cliente MCP local de transporte stdio operado por RDC:

`ChatGPT → RDC → cliente MCP local → OAuth 2.1 PKCE de Khora → /api/mcp → herramientas Jules → Jules API`.

El cliente registra un cliente OAuth público, abre automáticamente el navegador local, usa Authorization Code + PKCE S256 y un callback temporal ligado exclusivamente a `127.0.0.1`. El refresh token rotatorio se cifra con DPAPI CurrentUser; el access token permanece en memoria. `JULES_API_KEY` permanece exclusivamente en Khora Production. El propietario autenticado por `MCP_ALLOWED_EMAIL` obtiene `jules:read` y `jules:write` sin grants manuales por repositorio. Otros sujetos conservan ACL exacta y fail-closed.

El consentimiento del propietario en el navegador sigue siendo explícito y no se suplanta con extracción de cookies o reutilización de sesión web. No se exige al usuario introducir comandos ni manipular Bearers.

## 5. Verificaciones del puente

En PC-14:

- `npm ci`: PASS, 576 paquetes.
- Sintaxis Node y parser PowerShell 5.1: PASS.
- TypeScript: PASS.
- UI Review y contrato de navegación: PASS.
- Suite unitaria: **572/572 PASS**.
- Build local Next.js 16.4.0: PASS; **78/78 páginas** generadas. Se usó solo una clave AUTH_SECRET aleatoria, efímera y confinada al entorno de proceso para la prueba de build; no se guardó ni desplegó y se eliminó al finalizar.
- Prueba DPAPI con credencial sintética: Store/Load/Status y lectura de vuelta PASS; fixture eliminado.
- DCR: callback loopback exacto permitido; alias, LAN, IPv6, direcciones numéricas/hexadecimales, puertos privilegiados, rutas y query no permitidos rechazados.

El commit de Khora es `cda38145fd74b109703be24b6e3eda4c0998b15a` en `feat/jules-rdc-local-bridge-20261030`. PR #347 sigue OPEN y no fusionada. Vercel Preview `dpl_GdwKnsFJCo289dsCEfhyQaWPUJ2g` quedó READY para ese commit. El acceso anónimo a su URL devuelve 302 por la protección SSO del equipo; no se intentó eludirla. Production no fue desplegado.

No se ha realizado todavía el consentimiento OAuth real, una llamada autenticada a `tools/list`, la lectura real de fuentes Jules ni una creación de sesión. Esas pruebas siguen pendientes. La aprobación del plan conserva la limitación T22 del proveedor Jules: doble preflight no equivale a aprobación condicional atómica.

## 6. Estado final y siguiente acción

- Original: PERSISTIDO Y VERIFICADO en la rama documental.
- Manifiesto: PERSISTIDO Y VERIFICADO en la rama documental.
- Titularidad: TRANSFERIDA Y VERIFICADA, generación 3, en la rama documental.
- Folio: PENDIENTE / NO ASIGNADO; FOL1 inactivo.
- PR #19: OPEN / DRAFT / NOT MERGED.
- Puente RDC OAuth PKCE: commit publicado y Preview READY; consentimiento real y smoke test autenticado aún pendientes.
- Production: sin despliegue.

Siguiente paso controlado: completar la revisión del PR documental #19 y del PR Khora #347, integrar la documentación a `main` y la implementación a Khora `main` solo tras superar los gates correspondientes; después iniciar el puente mediante RDC, obtener el consentimiento OAuth del propietario en navegador y verificar las siete herramientas más una lectura real de fuentes Jules. No crear una tarea Jules ni ejecutar escritura de desarrollo durante el primer smoke test de lectura.
