# Portable Recovery Package v1 — contrato de implementación

**Estado:** APROBADO POR EL OPERADOR; implementación/código aún no implementados.  
**Ámbito:** exclusivamente frentes/mcp-metodologia/.  
**Versión:** PPR v1.  
**Compatibilidad:** no sustituye ni altera el formato local .ocpbak.

## 1. Objetivo y límites

PPR v1 debe permitir reconstruir una instalación MCP-OCP a partir de un único paquete portable, sin depender de backup_points.package_path ni del SID DPAPI del origen. Debe conservar identidad de instalación, claves públicas, recibos firmados e historial de eventos; todas las claves privadas/de contenido se reenvuelven para DPAPI CurrentUser del destino.

No es un backup remoto, no interactúa con B2, no instala el servidor y no demuestra por sí solo un restore cross-host. El destino debe ser Windows con DPAPI CurrentUser y una consola interactiva. La frase de recuperación es un secreto offline del operador, no se persiste.

## 2. Contenedor y artefactos

Extensión propuesta: .ocprecovery. Contenedor ZIP sin compresión, cuatro entradas exactas y sin directorios:

| Entrada | Contenido |
|---|---|
| manifest.json | Metadatos públicos, algoritmos, parámetros KDF, hashes y longitudes. Nunca incluye frase ni claves. |
| snapshot.sqlite.enc | Snapshot coherente de SQLite cifrado mediante AES-256-GCM bajo PMK aleatoria de 256 bits. |
| recovery-envelope.bin | PMK cifrada bajo KEK derivada de frase interactiva con Argon2id. |
| recovery-map.enc | Mapa de claves DPAPI del origen descifradas en memoria y cifradas con PMK mediante AES-256-GCM. |

Rechazar archivos duplicados, rutas absolutas, separadores alternativos, segmentos .., entradas adicionales, entradas comprimidas, tamaños no válidos, longitudes fuera de límite y cualquier hash/longitud discrepante. No extraer directamente rutas suministradas por el ZIP. El lector debe exigir el conjunto exacto de nombres.

### 2.1 Manifest

El esquema normativo de campos está en schemas/portable-recovery-package-v1.schema.json. Requisitos adicionales:

- format = OCPMCP-PORTABLE-RECOVERY, format_version = 1.
- package_id UUID; installation_id y source_operator_sid son identificadores de origen, no secretos.
- database_sha256 se calcula sobre bytes exactos del snapshot SQLite antes del cifrado.
- kdf: Argon2id v=19, salt aleatoria de 16 bytes, memoria 65.536 KiB, 3 iteraciones, paralelismo 1, salida 32 bytes. Parámetros y límites se validan antes de derivar.
- aead: AES-256-GCM, nonce 12 bytes, tag 16 bytes.
- artifacts: tamaño exacto y SHA-256 sobre bytes cifrados de cada uno de los tres artefactos binarios.
- No incluir nombre de cuenta, frase, KEK, PMK, DEK, HMAC, clave privada ni valores envueltos DPAPI.

### 2.2 AAD y framing

Usar UTF-8 canónico y separadores constantes:

- Envelope PMK: OCPMCP|PPR|ENVELOPE|v1|{package_id}|{installation_id}.
- Snapshot: OCPMCP|PPR|SNAPSHOT|v1|{package_id}|{installation_id}|{database_sha256}.
- Recovery map: OCPMCP|PPR|KEYMAP|v1|{package_id}|{installation_id}|{database_sha256}.

Los tres blobs binarios usan framing versionado: magic ASCII PPR1, nonce de 12 bytes, tag de 16 bytes y ciphertext restante. Validar tamaño mínimo antes de parsear. Los campos del manifest se validan antes de usarse como AAD.

## 3. Exportación

1. Exigir Windows, SID actual igual a installation.operator_sid, consola de entrada/salida real e instalación coherente. Pedir frase dos veces con eco deshabilitado; mínimo 16 caracteres; nunca aceptar frase por CLI, variable de entorno ni stdin redirigido.
2. Crear snapshot mediante SQLite Online Backup API a un archivo temporal. Verificar PRAGMA quick_check, integrity_check y foreign_key_check; cerrar conexiones y checkpoint antes de leer bytes.
3. Abrir el snapshot temporal —no la DB activa— para capturar las claves correspondientes exactamente a esa misma revisión.
4. Extraer en memoria, con fail-closed y cero de buffers:
   - todas las filas key_store de propósitos permitidos hmac-authority y receipt-ed25519, incluyendo versiones HMAC retired que deben preservarse;
   - cada DEK de canonical_sources, con entropy derivada de installation ID, canonical-source, source_id y dek_id;
   - cada DEK de snapshots, con entropy derivada de installation ID, snapshot, snapshot_id y dek_id.
5. Rechazar cualquier propósito desconocido, scope DPAPI inesperado, material faltante, fila duplicada o fallo de unprotect.
6. Cifrar snapshot y recovery map con PMK distinta; envolver PMK con KEK Argon2id/AES-GCM; crear manifest con hashes/longitudes de artefactos cifrados.
7. Construir ZIP en staging, releerlo desde disco, comprobar nombres, tamaños, hashes y descifrado/authenticación en memoria; flush-to-disk y renombrado atómico. No insertar un backup_points que dependa del ZIP portable.

## 4. Mapa de recuperación

El JSON del mapa, cifrado como unidad, contiene solo el material imprescindible para reenvelop:

- key_store[]: key_id, purpose, key_type, key_version, status y clave en claro codificada en Base64 dentro del mapa cifrado;
- canonical_source_deks[]: source_id, dek_id y DEK;
- snapshot_deks[]: snapshot_id, dek_id y DEK.

No incluir entropy ni valores DPAPI originales. En destino se reconstruye cada entropy con los mismos identificadores de objeto, el nuevo SID y las versiones existentes. La relación entre filas y mapa debe ser biyectiva: mismo conjunto, sin extras, ausencias o duplicados.

## 5. Restauración

1. Exigir Windows, consola interactiva, ausencia de conexiones activas del servicio y confirmación humana RESTORE {package_id_prefix}. No aceptar confirmación por argumento.
2. Validar ZIP y manifest antes de leer/decrypt; límites de tamaño y KDF, hashes, longitudes, magic, nonce/tag y nombres exactos.
3. Solicitar frase con eco deshabilitado; derivar KEK Argon2id; autenticar envelope; obtener PMK; autenticar/descifrar snapshot y mapa; comparar SHA-256 de DB.
4. Escribir snapshot en staging dentro del directorio data destino. Antes de sustituir DB, verificar integridad y foreign keys. La DB de staging debe abrir en modo read-write con FK activadas.
5. Verificar installation_id == manifest, SID origen == manifest, esquema compatible, fingerprints y correspondencia de cada clave. Rewrap de todas las claves usando DPAPI CurrentUser del SID destino:
   - key_store: entropy CryptoBox.BuildEntropy(installation_id, purpose, source_operator_sid, key_version) en origen para unprotect y el SID destino al protect.
   - canonical_sources: entropy BuildEntropy(installation_id, canonical-source, source_id, dek_id).
   - snapshots: entropy BuildEntropy(installation_id, snapshot, snapshot_id, dek_id).
6. Dentro de transacción: reemplazar wrapped_key/wrapped_dek; actualizar dpapi_scope='CurrentUser'; vincular installation.operator_sid al SID destino; revocar grants APPROVED no consumidos y requests pendientes/autorizables del SID origen; marcar filas backup_points históricas como SOURCE_HOST_ONLY (conservar IDs, hashes, fechas y tags, ya que sus paths y DEK DPAPI son del host origen); preservar key_metadata, clave pública, receipts y events.
7. Agregar evento de auditoría PORTABLE_RECOVERY_IMPORTED con IDs/estado no secreto. Verificar EventChain completa, fingerprints Ed25519 y consultas de receipts sin alterarlas; comprobar integrity_check y foreign_key_check otra vez.
8. Commit DB staging; swap con rollback en el mismo volumen, solo con servicio detenido y archivos SQLite libres. Si swap falla, restaurar DB original sin eliminar rollback.
9. Cero de todos los buffers de claves/PMK/KEK/plaintext lo antes posible. No registrar valores sensibles en logs/excepciones.

## 6. Criterios de aceptación

- [ ] El paquete portable es autónomo: restore no consulta la base de origen ni backup_points.package_path del origen.
- [ ] Manifest y cada artefacto pasan SHA-256, tamaño, magic, allowlist y límites.
- [ ] Frase incorrecta, tag alterado, hash alterado, manifest manipulado, entrada duplicada o traversal fallan antes de escribir el destino.
- [ ] Claves de todas las filas permitidas se recuperan y se reenvuelven DPAPI CurrentUser; recuentos e identidades coinciden exactamente.
- [ ] installation_id, clave pública/fingerprint, receipts y hash chain se preservan; firmas históricas siguen verificables.
- [ ] Grants aprobados no consumidos quedan revocados; requests pendientes de SID anterior no pueden aprobarse; registros consumidos no se reescriben.
- [ ] Rutas de backup antiguas quedan marcadas SOURCE_HOST_ONLY; .ocpbak sigue funcionando en origen y sigue siendo formato separado.
- [ ] Integridad SQLite, foreign keys, EventChain y readiness pasan.
- [ ] Pruebas unitarias/sintéticas completas en Windows. Test cross-host real solo cuando un segundo host/perfil autorizado esté disponible; hasta entonces RESTORE_CROSS_HOST_VERIFICADO=NOT_VERIFIED.
- [ ] El servicio no instala, no modifica el host EP, no opera B2, no expone red y no altera MCP-NORMATIVO.

## 7. Matriz mínima de pruebas

| Área | Casos |
|---|---|
| Manifest/ZIP | allowlist exacta, archivo faltante/extra/duplicado, traversal, zip bomb, límite de tamaño, JSON inválido, algoritmos/versión no permitidos |
| Argon2id | parámetros válidos, parámetros fuera de política, frase equivocada, salt truncada, salida exacta de 32 bytes |
| AES-GCM | round-trip, nonce/tag/cipher tampered, AAD de package/install/hash distinto |
| Key map | propósito inesperado, duplicate IDs, fila faltante/extra, DEK equivocada, DPAPI unprotect fallido |
| SQLite | quick_check, integrity_check, foreign_key_check, snapshot WAL coherente, staging corrupto, rollback de swap |
| Identidad/seguridad | SID distinto, operator_sid actualizado, grants pendientes revocados, consumed grants intactos, clave pública y recibos verificables, EventChain íntegra |
| Límites | .ocpbak intacto, no B2/host operations, no secretos en manifest/logs/args/env |

## 8. Riesgos y condiciones no resueltas

- La frase de recuperación es irrecuperable si el operador la pierde; el programa no debe copiarla ni persistirla.
- Este paquete concentra claves privadas y DEKs bajo una única PMK; la custodia y distribución del package y frase deben mantenerse separadas.
- La memoria y rendimiento de Argon2id deberán medirse en el entorno mínimo soportado; registrar NOT_MEASURED hasta medir.
- DPAPI CurrentUser exige una prueba en el usuario/perfil destino. Un build o restore en el mismo perfil no acredita un segundo host.
- La importación de los fuentes candidatos a esta rama es una base de trabajo, no build ni prueba de PPR.
