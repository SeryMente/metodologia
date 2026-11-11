# 📝 EP-TASK-006 · Inventario y centralización de variables de entorno

**Estado:** `en_curso · VERCEL_KHORA_WEB_52_CURRENT_MATCH · ENTRY_READBACK_9 · NOT_IMPORTED_1 · BLOCKED_42 · EP_VAULT_FORMAL_3352B_PRESENT · ISOLATED_DECRYPT_30_FIELDS_PASS · CURRENT_SESSION_CLOSED · VAULT_NAME_RECONCILIATION_PENDING · ADAPTERS_NOT_IMPLEMENTED`.
**Frente propietario:** Entorno Persistente (EP).  
**Apertura:** instrucción directa del operador · 2026-11-09.  
**Relaciones:** EP-TASK-004 (EP Vault) y EP-TASK-002 (persistencia B2).

## 1. Enunciado

EP Vault debe ser la **fuente central de verdad de todas las variables de entorno de todos los proyectos**. El operador registra o actualiza cada valor una sola vez; los proyectos y entornos autorizados reciben el valor correcto desde la bóveda. El objetivo no se satisface con un listado documental ni con guardar solo nombres: exige custodia central, separación por proyecto/entorno/rama, adaptadores de distribución y read-back.

El operador debe poder introducir una variable una vez, olvidarse de las copias manuales y confiar en que EP la mantiene disponible en los destinos autorizados.

## 2. Estado real del producto

EP Vault v1.0.0 proporciona cifrado autenticado local, almacenamiento de pares nombre/valor, notas efímeras DPAPI, promoción con read-back y ejecución de procesos con allowlist. El almacén actual no mantiene todavía un catálogo de proyectos/entornos/ramas ni sincronización automatizada a Vercel, GitHub Actions u otros destinos.

No se declara cumplido el objetivo de «una sola entrada» hasta implementar y probar:
- catálogo de variables y metadatos de ámbito;
- separación de valores homónimos por proyecto, Production/Preview/Development y rama;
- inyección efímera a procesos autorizados;
- adaptadores para distribuir desde EP Vault hacia Vercel y otros proveedores;
- reconciliación, rotación, revocación, rollback y read-back;
- registro de estado sin valores secretos.

## 3. Inventario verificado · 2026-11-09

### 3.1 Vercel

La conexión devolvió un equipo y un proyecto: \`khora-web\`. Se encontraron **50 entradas y 46 nombres únicos**. Los nombres, sin valores secretos, son:

\`\`\`text
AUTH_SECRET
BLOB_READ_WRITE_TOKEN
DATABASE_URL
EP_ALLOWED_EMAIL
EP_BOOTSTRAP_JWT_SECRET
EP_CANONICAL_URL
EP_TOKEN_TTL_SECONDS
GITHUB_TOKEN
GITHUB_WEBHOOK_SECRET
GROQ_API_KEY
INTERNAL_TRIGGER_SECRET
JULES_API_KEY
KHORA_API_KEY
KHORA_API_URL
KHORA_B2_APPLICATION_KEY
KHORA_B2_BUCKET_ID
KHORA_B2_BUCKET_NAME
KHORA_B2_KEY_ID
KHORA_B2_PREFLIGHT
KHORA_CHAT_ENABLED
KHORA_NORM_GITHUB_TOKEN
KHORA_OBJECT_STORAGE
KHORA_READONLY_DATABASE_URL
KHORA_UI_REVIEW_MODE
MCP_ALLOWED_EMAIL
MCP_CANONICAL_URL
MCP_JWT_SECRET
MCP_OAUTH_CLIENT_ID
MCP_OAUTH_CLIENT_SECRET
MCP_OAUTH_REDIRECT_URIS
NEO4J_PASSWORD
NEO4J_URI
NEO4J_USER
NEXT_PUBLIC_API_URL
NEXT_PUBLIC_TAKEOUT_GOOGLE_APP_ID
NEXT_PUBLIC_TAKEOUT_GOOGLE_PICKER_KEY
NOTION_ROADMAP_DATABASE_ID
NOTION_TOKEN
NPM_CONFIG_LEGACY_PEER_DEPS
OIDC_CLIENT_ID
OIDC_CLIENT_SECRET
OIDC_ISSUER_URL
TAKEOUT_GOOGLE_CLIENT_ID
TAKEOUT_GOOGLE_CLIENT_SECRET
VAULT_AGENT_CANONICAL_URL
X_KHORA_KEY
\`\`\`

Ámbitos duplicados que no deben colapsarse:
- \`AUTH_SECRET\`: 4 registros (Production, Preview general y dos ramas Preview: \`fix/audio-vault-error-state\` y \`fix/audio-player-runtime\`).
- \`KHORA_CHAT_ENABLED\`: Production y Preview de \`feat/cora-openwebui-menu-20261108\`.

Tres valores de tipo \`plain\` observados sin descifrar secretos:
- \`KHORA_B2_PREFLIGHT=1\` · Production.
- \`KHORA_OBJECT_STORAGE=b2\` · Production.
- \`KHORA_CHAT_ENABLED=1\` · Preview de la rama anterior.

Los dos primeros están almacenados en EP Vault con read-back. El tercero aparece como nombre con ámbito Preview en el inventario del Vault; su valor no quedó verificado en este ciclo. La entrada Production de \`KHORA_CHAT_ENABLED\` es sensible y permanece separada.

No se solicitó descifrado masivo de Vercel ni se expusieron valores secretos al chat.

### 3.2 Repositorios GitHub

Repositorios enumerados (11):

\`\`\`text
SeryMente/khora
SeryMente/serymente
SeryMente/otrogranprograma
SeryMente/GDP
SeryMente/khora-effectif
SeryMente/signal-interpreter
SeryMente/metodologia
SeryMente/tercer-ambito
SeryMente/personal
SeryMente/filo-sangriento
SeryMente/Language
\`\`\`

La búsqueda \`process.env\` en la rama predeterminada encontró usos en \`SeryMente/khora\` y dos archivos de pruebas de \`SeryMente/otrogranprograma\`. La búsqueda Python \`os.environ\` en Khora devolvió 31 archivos/referencias. Los otros nueve repositorios no devolvieron coincidencias \`process.env\` en esa búsqueda; esto no demuestra ausencia de variables mediante otros mecanismos, ramas o archivos no indexados.

En \`SeryMente/khora/khora-web/.env.example\` se encontraron 53 nombres de variable. Blob leído: \`cd4497791ba834c178c67f77f640df3e40c525ab\`. Es una plantilla, no prueba de que todos los valores existan o estén activos.

Variables adicionales descubiertas por usos de código, además de las listadas por Vercel:

\`\`\`text
AUDIO_PATH
AUDIO_TRANSCRIPTION_KEY
AUDIO_TRANSCRIPTION_URL
CHROMIUM_EXECUTABLE_PATH
DOCKER_NEO4J
EXPECTED_SHA256
GEMINI_API_KEY
GROQ_GRAPH_MODEL
GROQ_STT_MODEL
HARMONIA_PORT
HARMONIA_TOKEN
KHORA_B2_REGION
KHORA_C030_SOURCE
KHORA_CHUNK_OVERLAP
KHORA_CHUNK_SIZE
KHORA_EMBEDDINGS_BASE_URL
KHORA_ER_CAND_LIMIT
KHORA_EPIS_TWIN_JUDGES
KHORA_FSUM_WINDOW
KHORA_FVAL_MODE
KHORA_LLM_API_KEY
KHORA_LLM_BASE_URL
KHORA_LLM_MODEL
KHORA_MLLM_MODEL
KHORA_OPERADOR_CANONICAL_KEY
KHORA_PERFIL_GROQ_API_KEY
KHORA_TEST_MODE
KHORA_WEB_ORIGIN
KHORA_EXPERIENCE_VERIFY_STORAGE
MAX_CONCURRENT_JULES_SESSIONS
NOTION_DB_VOLCADOS
PGLITE_MODULE
RAZ_MAX_PASOS
SMTP_HOST
SMTP_PASS
SMTP_PORT
SMTP_SECURE
SMTP_USER
SYNC_BENCHMARK_URL
TODOIST_TOKEN
VAULT_AGENT_ALLOWED_EMAIL
\`\`\`

También hay variables intrínsecas o de pruebas/build: \`PLAYWRIGHT_*\`, \`NODE_ENV\`, \`VERCEL_*\`, \`PORT\`, \`HOST\`, \`LOCALAPPDATA\`, \`PATH\`, \`PGLITE_MODULE\`, entre otras. Deben clasificarse antes de custodiarse; no todas son secretos persistentes.

### 3.3 Equipo local PC-7

Variables persistentes del usuario consultadas: \`OneDrive\`, \`Path\`, \`TEMP\`, \`TMP\`. El ámbito Machine devolvió variables estándar de Windows; el ámbito Process añadió variables de ejecución de Windows y Node/npm. No se encontraron credenciales de aplicación en User/Machine en esta lectura.

La búsqueda de archivos \`.env\` y configuraciones equivalentes bajo \`Desktop\\SeryMente\\Repositorios\` devolvió cero coincidencias. La materialización local disponible no equivale a clones completos de los 11 repositorios; por tanto no se afirma cobertura local total.

### 3.4 Medios pendientes de inventario

- GitHub Actions secrets y variables de repositorio/organización.
- Shared Environment Variables de Vercel: el conector permite consultar una por ID, pero no ofrece un listado global para descubrirlas.
- Paneles externos de Google/OIDC, SMTP, Notion, Todoist, Groq, Gemini, Jules, Neo4j y otros servicios.
- Otros equipos/perfiles Windows, ramas distintas de main, archivos ignorados por Git, gestores de secretos y configuraciones de CI.
- Configuración local de extensiones/aplicaciones portables y perfiles de Chrome.

## 4. Estado de EP Vault

La última lectura de nombres confirmó nueve entradas:

\`\`\`text
EP_B2_ACCOUNT_EMAIL
EP_B2_APPLICATION_KEY_ID
EP_B2_BUCKET_NAME
EP_B2_PREFIX
KHORA_B2_MASTER_APPLICATION_KEY
KHORA_B2_MASTER_APPLICATION_KEY_ID
KHORA_B2_PREFLIGHT
KHORA_OBJECT_STORAGE
KHORA_WEB_PREVIEW_FEAT_CORA_OPENWEBUI_MENU_KHORA_CHAT_ENABLED
\`\`\`

La pareja \`KHORA_B2_MASTER_APPLICATION_KEY_ID\` / \`KHORA_B2_MASTER_APPLICATION_KEY\` es de **Khora** y permanece separada de las credenciales EP.

Guardadas con \`VARIABLE_STORED_READBACK_VERIFIED\`:
- \`EP_B2_ACCOUNT_EMAIL\`;
- \`EP_B2_BUCKET_NAME\`;
- \`EP_B2_PREFIX\`;
- \`KHORA_B2_PREFLIGHT\`;
- \`KHORA_OBJECT_STORAGE\`.

La primera nota efímera DPAPI fue promovida a \`EP_B2_APPLICATION_KEY_ID\` con \`PROMOTED_READBACK_VERIFIED_NOTE_REMOVED\`. La asignación se hizo por orden de captura; el valor no se reveló al modelo y su formato/tipo aún requiere validación no expositiva. Una segunda nota DPAPI continúa en \`VOLATILE_DPAPI\`; su promoción a \`EP_B2_APPLICATION_KEY\` no quedó confirmada porque la llamada de ejecución fue bloqueada antes de informar un resultado. La nota no fue borrada ni se declara guardada.

Estado observado de la bóveda: esquema \`ep-env-vault/1\`, PBKDF2-HMAC-SHA256, 600.000 iteraciones, 1.324 bytes y sesión activa al cierre de la lectura. No se incluyen valores ni huellas de secretos en este documento.

## 5. Modelo de centralización requerido

Cada variable debe tener metadatos no secretos: nombre original, proyecto, servicio, entorno, rama, proveedor, finalidad, clasificación, sensibilidad, fuentes consumidoras, estado y última verificación. Las variables homónimas de diferentes entornos se mantienen como registros distintos; no se mezclan Production, Preview o Development.

EP Vault conserva el valor cifrado. Un catálogo de mapeo define dónde se consume. Adaptadores controlados distribuyen los valores a Vercel/CI/procesos autorizados con allowlist, sin escribir secretos en Git, logs, argumentos, archivos \`.env\` permanentes ni contexto del modelo. La actualización desde Vault debe tener read-back del destino y registro saneado. Un cambio remoto divergente se informa; no se sobrescribe silenciosamente.

Clasificación obligatoria:
- \`SECRETO_DE_APLICACIÓN\`
- \`CONFIGURACIÓN_NO_SECRETA\`
- \`CONFIGURACIÓN_PÚBLICA\`
- \`VARIABLE_DERIVADA_DEL_PROVEEDOR\`
- \`PRUEBA/CI\`
- \`LEGADO/NO_USADA\`
- \`PENDIENTE_DE_ORIGEN\`
- \`PENDIENTE_DE_ACCESO\`

La aparición en \`.env.example\` o en el código no basta para declarar una variable activa: se coteja con el consumidor y el entorno real.

## 6. Secuencia y tareas

| Prioridad | Acción | Resultado exigido |
|---|---|---|
| P0 | Completar pareja de credenciales B2 exclusiva de EP y validar tipo/cuenta | Dos variables EP custodiadas, identificadas y verificadas sin revelar valores |
| P0 | Respaldar ciphertext actualizado de EP Vault en \`OCP-MCP/ep-ocp/\` | Upload, descarga/read-back y SHA-256 iguales; original intacto |
| P1 | Completar inventario de las 50 entradas Vercel y migrar sus valores | Cada entrada con ámbito y valor en Vault o pendiente individual |
| P1 | Cotejar los 53 nombres de \`.env.example\` con usos y entornos | Activa, no usada, test, derivada o pendiente |
| P1 | Revisar ramas, workflows, clones reales y equipos desconectados | Cobertura por fuente y huecos explícitos |
| P2 | Obtener credenciales/valores faltantes de paneles externos | Cada valor con origen, titular y ámbito verificados |
| P2 | Implementar catálogo de ámbitos y adaptador Vercel | Aprovisionar desde Vault con read-back y rollback |
| P3 | Añadir adaptadores para el resto de servicios | Flujo «registrar una vez» demostrado en cada proyecto |

Bloqueos actuales:
- la segunda nota B2 de EP continúa efímera;
- no se ha verificado el emparejamiento/alcance efectivo de la credencial EP;
- no se descifraron valores sensibles de Vercel;
- no existe adaptador Vault → Vercel/CI probado;
- no se descubrieron Shared Environment Variables ni GitHub Actions secrets.

## 7. Criterio de cierre

EP-TASK-006 se completa solo cuando todas las variables usadas están catalogadas, cada valor está en EP Vault o tiene una tarea individual con motivo y fuente, todos los ámbitos/proyectos están diferenciados, los adaptadores distribuyen desde la bóveda sin reintroducción manual, los destinos tienen read-back, y las pruebas de rotación, revocación, rollback, fallos parciales y no exposición pasan.

## 8. Crónica inicial · 2026-11-09

Fuentes: conector Vercel (equipos, proyectos y variables); repositorios GitHub accesibles; \`khora-web/.env.example\`; búsquedas \`process.env\`/\`os.environ\`; variables User/Machine/Process de PC-7; búsqueda local de \`.env\`; EP Vault CLI Status/ListVariables/ListNotes.

Resultado: inventario parcial; 5 valores/configuraciones escritos con read-back; primera nota EP promovida; segunda nota permanece. No se realizó autenticación B2 actual ni upload/restore en este ciclo. Próxima acción: terminar la pareja EP, después respaldar el ciphertext de Vault en B2 y seguir con la migración Vercel y los demás medios.


## Evidencia de procedencia de las notas B2 EP · 2026-11-09

Gmail devolvió un mensaje de Backblaze (no-reply@backblaze.com), asunto `A Master Key Has Been Generated in Your Backblaze B2 Account`, dirigido a `blacksheepsup@gmail.com`, con fecha `2026-11-09T21:33:19Z` (message id `1a1c23af91f37d66`). EP Vault registró la primera nota a `2026-11-09T21:33:35.9136717Z` y la segunda a `2026-11-09T21:33:42.1285843Z`. La proximidad temporal respalda que las notas se capturaron durante esa operación de la cuenta EP. No determina por sí sola qué nota contiene el ID y cuál la aplicación key. La primera se promovió por orden de captura a `EP_B2_APPLICATION_KEY_ID`; esa asignación permanece pendiente de validación local no expositiva. La segunda continúa en DPAPI. No se copiaron valores del correo ni se mostraron al modelo.

## 3.5 GitHub Actions y secretos de workflows · 2026-11-09
Se inspeccionaron siete workflows de `SeryMente/khora`. Los nombres de secretos referenciados son:

```text
VERCEL_ORG_ID
VERCEL_PROJECT_ID
VERCEL_TOKEN
GITHUB_TOKEN
NOTION_TOKEN
NOTION_DATABASE_ID
TODOIST_TOKEN
KHORA_EPIS_JUDGE_A_BASE_URL
KHORA_EPIS_JUDGE_A_API_KEY
KHORA_EPIS_JUDGE_A_MODEL
KHORA_EPIS_JUDGE_B_BASE_URL
KHORA_EPIS_JUDGE_B_API_KEY
KHORA_EPIS_JUDGE_B_MODEL
KHORA_EPIS_JUDGE_C_BASE_URL
KHORA_EPIS_JUDGE_C_API_KEY
KHORA_EPIS_JUDGE_C_MODEL
KHORA_EPIS_JUDGE_D_BASE_URL
KHORA_EPIS_JUDGE_D_API_KEY
KHORA_EPIS_JUDGE_D_MODEL
OPENAI_API_KEY
INTERNAL_TRIGGER_SECRET
KHORA_API_PRODUCTION_URL
```

Los nombres anteriores provienen de expresiones `${{ secrets.NAME }}` en `.github/workflows/`. Algunos workflows mapean el secreto a otro nombre de entorno (p. ej. `NOTION_TOKEN` → `NOTION_API_KEY`). `INTERNAL_TRIGGER_SECRET` se referencia en más de un workflow. Los valores reales de GitHub Actions secrets no son legibles mediante el conector GitHub disponible; quedan como `PENDIENTE_DE_ACCESO`. Los `vars.*` y configuraciones de repositorio/organización tampoco se han inventariado por API.

Archivos y blobs cotejados:
- `.github/workflows/deploy-production.yml` · `89a25e99dcc9ef22db3bd64d7cc4d14a370fc63e`
- `.github/workflows/todoist-notion-sync.yml` · `0cacb77f266c3d050052c1e86252573cced6ca45`
- `.github/workflows/epistwin-personalqa.yml` · `524d914687912aa75bc7697fde215db01d2852da`
- `.github/workflows/ichnos-cobertura.yml` · `2393dd20a3622b5dbd6adf64035db4e79cfb7e8c`
- `.github/workflows/board-orchestrator.yml` · `874c76ec34b8403c2775551a8da64491fc2dadd2`
- `.github/workflows/jules-autorespond-cron.yml` · `3858295161b05c1b1d395376faddf604f3ec7f50`
- `.github/workflows/healthcheck-khora-api.yml` · `e8d1cf06de7cb141436dc34a72331719da6ed05c`

## 3.6 Render · servicios y configuración declarada · 2026-11-09

El conector Render devolvió el workspace `My Workspace` y dos servicios:

- `khora` · repo `SeryMente/khora` · branch `fix/chat-epistwin-ent01-main-20261019` · auto-deploy deshabilitado.
- `serymente-wordpress-lab` · repo `SeryMente/serymente` · branch `main` · runtime Docker.

`SeryMente/khora/render.yaml` declara `PYTHON_VERSION=3.11`. La integración Render disponible permite listar servicios y actualizar variables, pero no expone una operación de lectura/listado de los valores configurados por servicio. Por tanto, `PYTHON_VERSION` queda clasificada como configuración no secreta declarada en Git; las variables reales de ambos servicios quedan `PENDIENTE_DE_ACCESO`. No se efectuó ninguna escritura en Render.

## 3.7 Reconciliación de cobertura

El inventario actual ya no se limita a Vercel: cubre variables de código, Vercel, nombres de secretos referenciados en GitHub Actions, configuración versionada de Render, metadatos de los servicios Render, archivos históricos de la Biblioteca y variables del perfil Windows PC-7. Siguen fuera de cobertura los valores internos de GitHub Actions/Render, Shared Environment Variables de Vercel, los demás paneles externos y equipos/perfiles que no están conectados. La tarea permanece `en_curso`; no se declara inventario global completo.


## Verificación incremental del almacén y cobertura · 2026-11-09

EP Vault volvió a informar nueve nombres y una nota efímera restante (`N-20261109213342-BCC5707F`, `VOLATILE_DPAPI`). Estado: esquema `ep-env-vault/1`, PBKDF2-HMAC-SHA256/600.000 iteraciones, 1.324 bytes, sesión activa. Ciphertext local `C:\Users\PC 7\AppData\Local\Khora\secrets\ep-env-vault.enc.json`, SHA-256 `41F79D30165F8381AB8D89198139853467B3DFA405A8BAC8AB2FFAC45013752F`. Este valor es una huella, no el ciphertext.

La búsqueda adicional de GitHub Actions identificó 22 nombres distintos referenciados como secretos en siete workflows de `SeryMente/khora`. Render devolvió dos servicios (`khora` y `serymente-wordpress-lab`) y `render.yaml` declara `PYTHON_VERSION=3.11`; los valores reales de Render no se pudieron listar mediante la API disponible. Los secretos de Actions permanecen `PENDIENTE_DE_ACCESO`.

## Hito incremental · configuración Render almacenada y nueva lectura de Vault · 2026-11-09

Se transfirieron desde los YAML versionados de Render nueve valores no secretos a EP Vault. Cada escritura se realizó con el portapapeles local, acción SetFromClipboard y read-back PASS; el portapapeles se limpió después de cada operación. Alias de Vault y clave original:

| Alias en EP Vault | Variable de origen | Fuente | Resultado |
|---|---|---|---|
| KHORA_RENDER_PYTHON_VERSION | PYTHON_VERSION | SeryMente/khora/render.yaml, rama del servicio khora | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_MYSQL_DATABASE | MYSQL_DATABASE | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_MYSQL_USER | MYSQL_USER | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_WORDPRESS_DB_NAME | WORDPRESS_DB_NAME | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_WORDPRESS_DB_USER | WORDPRESS_DB_USER | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_WORDPRESS_ADMIN_USER | WORDPRESS_ADMIN_USER | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_WORDPRESS_ADMIN_EMAIL | WORDPRESS_ADMIN_EMAIL | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_SYM_LAB_SOURCE_ROOT | SYM_LAB_SOURCE_ROOT | SeryMente/serymente/render.yaml | READBACK_VERIFIED |
| RENDER_SERYMENTE_WORDPRESS_LAB_WORDPRESS_DEBUG | WORDPRESS_DEBUG | SeryMente/serymente/render.yaml | READBACK_VERIFIED |

Se dejan pendientes: MYSQL_PASSWORD y MYSQL_ROOT_PASSWORD (generateValue de Render), WORDPRESS_ADMIN_PASSWORD (generateValue), WORDPRESS_DB_PASSWORD (fromService) y WORDPRESS_DB_HOST (fromService). WORDPRESS_CONFIG_EXTRA se deja pendiente de importación/validación por ser una cadena multilinea de configuración. No se intentó leer los secretos generados ni modificar los servicios Render.

**Lectura consolidada posterior:** EP Vault v1.0.0 informa 18 nombres de variable, una nota DPAPI pendiente (`N-20261109213342-BCC5707F`, `VOLATILE_DPAPI`), estado ENCRYPTED_FILE_PRESENT, esquema `ep-env-vault/1`, PBKDF2-HMAC-SHA256/600.000 iteraciones, 2.048 bytes y sesión activa. La lista anterior de nueve nombres de la sección 4 es un snapshot previo; esta lectura de 18 nombres la sustituye como estado más reciente.

**Ciphertext actual en PC-7:** `%LOCALAPPDATA%\Khora\secrets\ep-env-vault.enc.json`; SHA-256 `D7AD1D745CAF460E047EAE521C1C403F36E99864BC9CD0604FFC564E390F2F7D`. Esta huella identifica el archivo local de este corte; no acredita respaldo remoto.


---

## Reconciliación de variables B2 EP tras migración Master · 2026-11-10 · 10:12 America/Mexico_City

La pareja Master de la **cuenta Backblaze dedicada a EP**, y solo de esa cuenta, quedó centralizada en EP Vault:

- `EP_B2_MASTER_APPLICATION_KEY_ID`: presente y lectura de vuelta verificada; longitud 12.
- `EP_B2_MASTER_APPLICATION_KEY`: presente y lectura de vuelta verificada; longitud 42.
- `EP_B2_APPLICATION_KEY_ID`: alias obsoleto retirado; el registro confirma cero alias B2 EP deprecados restantes.
- `EP_B2_ACCOUNT_EMAIL`, `EP_B2_BUCKET_NAME` y `EP_B2_PREFIX`: preservadas.
- `KHORA_B2_MASTER_APPLICATION_KEY`, `KHORA_B2_MASTER_APPLICATION_KEY_ID` y `KHORA_B2_PREFLIGHT`: preservadas, sin alteración.

**Procedencia:** el operador confirmó que las dos notas de origen pertenecían a EP. Cora mantiene una cuenta y credenciales propias; no se reutilizaron credenciales de Cora ni de Khora. Los valores no se incorporan a este expediente ni se emiten a logs/chat (`valuesEmitted=False`).

**Read-back y huella:** migración `MIGRATION_AND_READBACK_VERIFIED`, completada `2026-11-10T16:01:06Z`; verificación final `16:12:43Z`; ciphertext 2.156 bytes, SHA-256 `F41FE765BCD30787C880C9105E3F6B3C4F6D00D67BA7AEAF70E55F3E7A96514C`.

Esto completa la normalización de la pareja maestra B2 de EP en la bóveda; **no** completa la centralización global de variables de todos los proveedores/proyectos ni demuestra autenticación B2, lectura del bucket, upload o restore. EP-TASK-006 permanece `en_curso`.


---

## OCP MCP 1.0 · cierre de cobertura organizacional y consumidores RDC · 2026-11-10

**Prioridad:** H2 para completar catálogo, persistencia de la bóveda y recuperación; el suministro seguro de credenciales a RDC queda diferido al hito posterior correspondiente.

La definición de alcance deja de limitarse a los repositorios/proveedores ya inspeccionados: completar el universo de variables usadas por KHORA, OCP y la organización Ser y Mente, incluyendo servicios gestionados, CI/CD, runtime, infraestructura, dominios, integraciones y componentes locales, con namespaces separados por producto, proveedor y entorno (DEV/TEST-STAGING/PROD). La lista de fuentes debe ser explícita y cada fuente tener cobertura/status, fecha de inspección y vacíos pendientes.

Registrar metadatos y referencias sin extraer secretos de proveedores por métodos no autorizados. Para secretos, comprobar existencia y procedencia mediante UI/API/custodia autorizada y conservar los valores solo cifrados dentro de EP Vault. No copiar secretos a este documento, Git, scripts, logs, mensajes ni portapapeles.

RDC se autentica al inicio de la sesión. Hacer inventario de mecanismos de autenticación y dependencias de RDC, pero no implementar ahora el broker de secretos. El hito posterior MCP-OCP-16/EP-TASK-007 debe comprobar un canal just-in-time soportado, mínimo privilegio, alcance de proceso, expiración y ausencia del valor en argumentos/logs.

**Estado:** EP-TASK-006 sigue en_curso; la pareja B2 de EP tiene read-back local reportado, pero eso no completa la cobertura organizacional ni demuestra backup/restauración B2.


## Reporte individual obligatorio por tarea
Al resolver esta tarea, el responsable debe agregar el informe individual en este mismo núcleo siguiendo [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md), completar todos sus campos y actualizar el índice padre solo después del read-back. No marcar como completada sin criterios PASS, evidencia ejecutada, integridad verificada y aceptación exigible. Si termina parcial/bloqueada, dejar igualmente el informe con bloqueantes, preocupaciones, riesgos y condición objetiva de desbloqueo. Informar al operador con enlace al informe. Esta instrucción no altera titularidad, generación, permisos ni controles.


## Plan de centralización por contratos e invariantes · 2026-11-11

**Estado:** EP Vault continúa como fuente central prevista; la cobertura organizacional y los adaptadores siguen incompletos. Este plan no implica que todos los valores estén recuperados ni autoriza extraer secretos masivamente.

### Secuencia

1. **Cerrar el inventario de fuentes.** Construir una matriz por proveedor, organización/proyecto, entorno, rama, nombre, tipo (sensible/plain), estado de lectura, procedencia, fecha y evidencia. Conservar como entradas distintas las variables homónimas con ámbitos diferentes. Marcar explícitamente fuentes no consultadas y cobertura no verificada.
2. **Definir el modelo canónico.** Cada registro debe resolver namespace/proyecto/proveedor/entorno/rama y el identificador estable de la variable. Resolver colisiones y aliases sin colapsar valores por coincidencia de nombre. La fuente única permanece EP Vault; documentos/índices conservan solo metadatos no secretos.
3. **Especificar el contrato de adaptadores.** Para cada proveedor, fijar operaciones admitidas, autenticación, mínimo privilegio, lectura de estado, escritura, read-back, rotación, revocación y rollback. Un adaptador no informa PASS solo porque la API acepte la solicitud: debe leer y cotejar el estado resultante.
4. **Implementar inyección efímera.** Entregar valores solo al proceso autorizado y durante su vida necesaria; no escribirlos en argumentos, archivos, logs, historial, telemetría ni variables heredadas no necesarias. La entrega just-in-time desde EP Vault debe probar expiración y revocación.
5. **Sincronizar con idempotencia.** Definir identidad de operación, detección de drift, conflictos, reintentos y compensación. Repetir una operación con la misma identidad no debe crear duplicados ni sobrescribir un ámbito distinto.
6. **Probar con fixtures sintéticos.** Cubrir nombres repetidos en Production/Preview/Development y ramas, variables plain/sensitive, valor ausente, proveedor inaccesible, escritura parcial, read-back discordante, rotación, revocación, rollback, expiración y fuga accidental en logs. Probar cada adaptador por separado antes de una matriz multi-proveedor.
7. **Completar cobertura por evidencia.** Cerrar una fuente solo cuando el inventario, custodia cifrada, distribución autorizada y read-back estén demostrados. Mantener un denominador explícito de fuentes/proveedores y no declarar «todas las variables» a partir del inventario parcial actual.

### Review Focus y aceptación

- No guardar valores, claves, tokens o secretos en Git, documentos, manifiestos, logs o conversación.
- Nombres con ámbitos distintos permanecen separados; no se deduce igualdad de valores.
- Cada escritura tiene read-back, scope correcto y operación idempotente.
- Mínimo privilegio, expiración, revocación, rollback y redacción se prueban para cada adaptador.
- Cierre: inventario de fuentes completo y fechado; catálogo canónico; adaptadores requeridos con pruebas positivas/negativas; cobertura y excepciones cuantificadas; custodia/restore EP Vault demostrados; aceptación del operador.

### Bloqueos

Vault formal sellada, autenticación no disponible, API sin capacidad de lectura, scope ambiguo o imposibilidad de proteger el secreto detienen solo el proveedor/operación afectado. No se elude la API ni se recuperan valores por métodos no autorizados.

---

## Revalidación de cobertura Vercel y disponibilidad de EP Vault · 2026-11-11

**Estado operativo:** en_curso · INVENTORY_SNAPSHOT_52 · STORED_READBACK_10 · VALUE_UNAVAILABLE_42 · FORMAL_VAULT_NOT_INITIALIZED.

### Evidencia y límites

El catálogo local EP-VERCEL-ENV-CATALOG-khora-web.json contiene 52 entradas del proyecto khora-web: 10 marcadas STORED_READBACK_VERIFIED y 42 BLOCKED_VALUE_NOT_RETRIEVABLE. Es evidencia del inventario capturado, no una nueva consulta al proveedor en este ciclo ni prueba de que todos los proveedores/proyectos estén cubiertos.

EPVault-CLI Status en Fila4 devolvió NOT_INITIALIZED, vaultExists=false y sessionActive=false. En consecuencia, no se ejecutó ListVariables, RevealVariable, SetFromClipboard, distribución a proveedores ni adaptación just-in-time. No se copiaron valores ni se intentó obtener por inferencia ninguno de los 42 secretos no recuperables.

### Decisión y siguiente paso

Conservar separados los 10 registros con read-back y los 42 cuyo valor no fue recuperable. Resolver primero la bóveda formal y su procedencia; después completar el mapa de fuentes/proveedores con lecturas autorizadas de solo metadatos, restaurar custodia cifrada y desarrollar adaptadores con read-back/idempotencia. No declarar cobertura organizacional completa a partir del catálogo parcial de Vercel.

 
## Revalidación de Vercel y reconciliación del catálogo · 2026-11-11 · 14:54:41 America/Mexico_City

**Resultado:** `VERCEL_LIVE_METADATA_MATCH_52_OF_52`; sin acceso a valores ni cambios remotos.

### Fuente y correspondencia actual

- Proyecto: `khora-web`, ID `prj_hRN86BKITXYKTnNlp0ygVhaMwFfx`.
- Consulta actual a Vercel mediante `filter_project_envs`, `decrypt=false`: 52 entradas, sin página siguiente; distribución de tipos: 42 `sensitive`, 7 `encrypted`, 3 `plain`.
- Snapshot local: `EP\local-state\run-logs\EP-VERCEL-ENV-CATALOG-khora-web.json`, 14.461 bytes, SHA-256 `97981295D095AA3DCE1505B6DD9214C6662C0FABF57E6ECB3A9B774518C70BC9`.
- La comparación de identidad por `key + target + gitBranch + type` entre los 52 registros vivos y los 52 registros del snapshot obtuvo: altas 0, bajas 0, cambios de tipo 0. La fotografía local coincide con el estado actual consultado.

### Reconciliación de estados del snapshot

La lectura de las 52 entradas individuales produjo:
- `STORED_READBACK_VERIFIED`: 9.
- `NOT_IMPORTED`: 1 (`GROQ_API_KEY`, Production/Preview/Development).
- `BLOCKED_VALUE_NOT_RETRIEVABLE`: 42.

El documento JSON contiene además un contador resumen `storedAndReadbackVerified=10`, que no coincide con los estados individuales (9). No se modifica el archivo fuente: queda registrada la discrepancia. El total por estados individuales sí suma 52. No se clasifica `NOT_IMPORTED` como read-back PASS.

La propiedad `existingVaultName` solo aparece en dos entradas KHORA B2 cuyo estado sigue siendo `BLOCKED_VALUE_NOT_RETRIEVABLE`; la presencia de un alias no demuestra read-back ni disponibilidad del valor.

### Estado de EP Vault y límite de la comparación

- El ciphertext formal existe en la ruta formal, 3.352 bytes, SHA-256 `3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82`. B2 v7 tiene read-back SHA/tamaño idéntico y SSE-B2/AES256; una copia aislada pasó HMAC/AES y contó 30 propiedades.
- La prueba de descifrado anterior no guardó ni emitió una lista de los 30 nombres. La sesión CLI compartida ha vuelto a cerrarse: `Status=ENCRYPTED_FILE_PRESENT`, `vaultExists=True`, `bytes=3352`, `sessionActive=False`. Por ello, `ListVariables` no se ejecutó y no se compararon los 30 nombres con los 52 registros actuales.
- La observación histórica `NOT_INITIALIZED` de la etapa anterior ya no describe el estado actual del archivo formal; ahora está presente y recuperable desde B2. La bóveda está sellada por TTL, no ausente.

### Límites y siguiente paso

No se solicitaron ni descifraron valores Vercel; no se usó `get_project_env`; no se escribieron variables, no se cambió scope/environment, no se desplegó y no se instalaron adaptadores. El próximo gate es que el propietario abra EP Vault localmente; entonces se puede ejecutar `ListVariables` para obtener nombres únicamente y cotejar los alias. Después corresponde definir y probar cada adaptador con mínimo privilegio, inyección efímera, read-back, idempotencia, expiración/revocación y rollback. La existencia de 30 propiedades no demuestra por sí misma que los 10/9 registros Vercel estén almacenados.

**Estado:** EP-TASK-006 continúa `en_curso`; la cobertura organizacional, los adaptadores y la aceptación integral siguen pendientes.
