# MCP-OCP-14 · Contrato de persistencia mínima

**Revisión:** propuesta 0.1 · **Estado:** PROPUESTO / NO ACEPTADO  
**Hitos:** H2 persistencia mínima y H3 workspace completo por instancia.  
**Propietario del contrato:** MCP-OCP. **Host, cifrado operativo, B2 y restore:** EP. **Aceptación:** GOV-TASK-014.

## 1. Alcance

Define el contrato versionado para journal mínimo, snapshots completos, manifiestos cifrados, checkpoints y evidencia de restauración. Permite comenzar con snapshots completos y un journal sencillo, evolucionando después a chunks/deduplicación/incrementales sin cambiar identidad, manifest ni estados de aceptación.

Esta entrega es exclusivamente documental: no crea DB/almacén, no cifra ni escribe datos, no autentica con Backblaze y no ejecuta restore. No incluye claves, tokens, cuentas, nombres de bucket, rutas de host ni datos reales.

## 2. Responsabilidades

| Componente | Responsabilidad |
|---|---|
| MCP-OCP-14 | Tipos, schemas, serialización, integridad, transiciones y pruebas sintéticas. |
| EP-TASK-002/003/007 | Root/ACL/protección, perfil criptográfico aprobado, custodia de claves, operación B2, sesión y restore. |
| GOV-TASK-014 | Aceptar manifest, privacidad, retención, integridad y restauración. |

MCP-OCP no obtiene ni almacena credenciales B2, no crea buckets ni DB operativa, no cambia ACL del host y no manipula Vault. Backblaze es el único backend remoto inicial; EP ejecuta las operaciones.

## 3. Modelo

### 3.1 Envelope de objeto cifrado

Cada objeto se cifra **antes** de entrar al almacén duradero o al backend remoto. El envelope externo expone solo UUIDv7 opaco, tipo de objeto, bytes/hash del ciphertext y referencias opacas al perfil/clave. No contiene material de clave.

Los parámetros exactos del algoritmo, KDF, nonce/tag, rotación y custodia no se eligen aquí. Deben proceder de un perfil aprobado y verificado por EP. El schema solo transporta una referencia no secreta al perfil y metadatos opacos de ese perfil.

### 3.2 Manifest del snapshot

El manifest lógico describe una captura consistente del workspace: UUIDv7 de snapshot/workspace/sesión, instante UTC, secuencia máxima, datasets, inventario de objetos, tamaños, SHA-256 plaintext/ciphertext y referencia a envelope/perfil. **El manifest lógico también se cifra antes de persistirlo o transmitirlo**, porque contiene rutas y metadatos de proyectos, conversaciones y adjuntos.

Datasets iniciales:
- `workspace_files`: archivos/configuración elegibles del workspace.
- `repositories`: checkout, referencias y cambios elegibles; excluir secretos y credenciales.
- `conversations`: registros destinados al workspace cifrado.
- `attachments`: adjuntos.
- `vault_ciphertext`: únicamente ciphertext/envelope autorizado de Vault; nunca valores en claro.
- `ocp_metadata`: metadatos mínimos para reconstruir la instancia.

El inventario debe ser completo respecto del alcance declarado. Exclusiones deben ser explícitas; no se rellenan ausencias con supuestos.

### 3.3 Journal

Journal append-only con eventos ordenados por secuencia dentro de workspace/sesión. Cada evento lleva UUIDv7, UTC, workspace/session, tipo, hash del evento anterior y SHA-256 propio calculado sobre JSON canónico UTF-8 excluyendo el campo `event_sha256`. No guarda cuerpo de conversación, adjuntos, contraseñas, tokens, SID, hostname, IP ni GPS. Los contenidos permanecen en datasets cifrados.

Tipos mínimos: `checkpoint.started`, `checkpoint.local_durable`, `checkpoint.remote_uploaded`, `checkpoint.remote_verified`, `restore.started`, `restore.verified` y `persistence.failed`.

### 3.4 Estados

No se infieren unos de otros:

1. `LOCAL_DURABLE`: objeto escrito, cerrado/flush según el almacén y leído de vuelta con hash coincidente.
2. `REMOTE_UPLOADED`: el proveedor confirmó recepción. No prueba lectura remota correcta.
3. `REMOTE_VERIFIED`: lectura de vuelta desde el proveedor y hash ciphertext coincidente.
4. `RESTORE_VERIFIED`: restore en destino aislado, descifrado mediante mecanismo autorizado y validación de todos los objetos contra el manifest.

Upload no es verificación; verificación ciphertext no es restore. El recibo expone solo el nivel máximo observado.

## 4. Reglas de ejecución

- Cada nueva instancia descarga un **snapshot FULL** del workspace antes de declararse restaurada. Los incrementales/chunks son optimización posterior y no sustituyen ese requisito.
- Empezar con snapshot completo + journal mínimo. Incorporar deduplicación, compresión y chunks después de demostrar restore y compatibilidad.
- Checkpoint normal con presupuesto máximo inicial de **30.000 ms**. Devuelve `CONFIRMED` o `NOT_CONFIRMED`; no puede prolongar lease, impedir cierre ni posponer dead-man.
- En emergencia/sospecha de compromiso, el llamador puede marcar `SKIPPED_EMERGENCY`; no intenta persistir ni demora el cierre criptográfico.
- Retención prevista indefinida para ciphertext útil, sujeta a obligaciones legales y solicitudes válidas. Este contrato no crea expiración ni borrado remoto automático.
- Restore en destino aislado; no sobrescribe un workspace activo por defecto.

## 5. Idempotencia e integridad

- `snapshot_id`, `object_id`, `event_id` y `receipt_id` son UUIDv7.
- Secuencia monótona por workspace/sesión; concurrencia serializada con CAS o transacción equivalente del almacén propietario.
- Canonicalizador UTF-8 y JSON determinista: fijarlo junto con las pruebas; no regenerar timestamps durante read-back.
- SHA-256 plaintext vive dentro del manifest cifrado; el envelope externo permite verificar ciphertext sin descifrar.
- Objeto ausente, hash distinto, manifest inválido o lectura no confirmable ⇒ `NOT_CONFIRMED`; no declarar workspace restaurado.

## 6. Schemas anexos

- [Envelope de objeto cifrado](schemas/encrypted-object-envelope.schema.json)
- [Snapshot manifest](schemas/snapshot-manifest.schema.json)
- [Journal event](schemas/journal-event.schema.json)
- [Checkpoint receipt](schemas/checkpoint-receipt.schema.json)

Los schemas de manifest/journal son lógicos y se guardan cifrados. El envelope externo solo permite localizar/verificar ciphertext; no define por sí mismo el perfil criptográfico final.

## 7. Aceptación falsable

| ID | Prueba | Evidencia |
|---|---|---|
| P14-01 | Schemas positivos/negativos | versión, fixtures y resultados |
| P14-02 | Snapshot FULL inventaría datasets declarados | manifest e inventario cotejado |
| P14-03 | Manifest/datasets cifrados antes de persistir | frontera de cifrado verificada, sin secretos |
| P14-04 | Journal append-only y cadena SHA | secuencia y recomputación |
| P14-05 | Checkpoint ≤30 s | medición monotónica y recibo |
| P14-06 | Upload separado de remote verify | recibos separados + GET/hash EP |
| P14-07 | Restore completo aislado | inventario/hashes versus manifest |
| P14-08 | Timeout/emergencia no prolongan cierre | prueba lease/dead-man EP |
| P14-09 | Clave persistente separada de clave efímera | verificación EP/Vault sin revelar valores |
| P14-10 | Sin contenido conversacional/secretos en logs | inspección automatizada saneada |

## 8. Siguientes pasos

1. EP fija y demuestra perfil criptográfico, root protegido, ACL, claves y operación B2.
2. MCP-OCP congela canonicalización e idempotencia con fixtures sintéticos.
3. MCP-OCP implementa modelos/serializadores y pruebas sintéticas, sin acceso a secretos.
4. El adaptador local se integra cuando EP entregue interfaz y root protegido; operación B2 permanece en EP.
5. Gobernanza acepta estados, manifest, privacidad, retención y restore.

**Estado de entrega:** CONTRATO PROPUESTO · 4 SCHEMAS SINTÉTICOS · NO RATIFICADO · SIN MOTOR/DB/ESCRITURA/B2/RESTORE.