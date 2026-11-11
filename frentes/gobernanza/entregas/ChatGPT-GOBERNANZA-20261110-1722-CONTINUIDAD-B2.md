# Registro provisional de continuidad · Gobernanza · 2026-11-10

**Fuente incorporada:** `ChatGPT-GOBERNANZA (1)-20261110-1722.txt`  
**Ubicación original:** `C:\Users\Fila4\Downloads\ChatGPT-GOBERNANZA (1)-20261110-1722.txt`  
**Metadatos de origen:** exportado el 10-11-2026 a las 17:22:26 (hora local reportada por el equipo); 98.367 bytes; 1.974 líneas.

> Este registro conserva las decisiones, secuencia y evidencia operacional relevantes. No publica la transcripción íntegra ni el enlace privado de conversación en el repositorio; el TXT original permanece en Downloads. La transcripción contiene contexto de sesión y datos locales que no deben exponerse en un repositorio público.

## 1. Decisiones de continuidad preservadas

- Alcance de OCP MCP: México; inspección de equipos bajo autorización del operador.
- Persistencia inicial: Backblaze B2 como destino principal; medio alternativo queda para una etapa posterior.
- Workspace completo por instancia; conversaciones y datos del proyecto cifrados.
- Vault: preservar el ciphertext; no exportar secretos en claro ni incluir contraseñas en el paquete.
- RDC: normalmente una sesión activa; una segunda solo como excepción controlada.
- Política de cierre: intentar checkpoint dentro de un límite, pero priorizar cierre y borrado criptográfico local cuando venza el dead-man.
- Lease aprobado: renovación cada 60 segundos mientras haya actividad; vencimiento a los 30 minutos; aviso previo; cierre por 10 minutos de inactividad; máximo de 8 horas.
- No se debe retrasar SINK:P004 por el panel WPF. El panel sigue siendo obligatorio para el release 1.0.0.

## 2. Secuencia general de hitos

| Hito | Alcance | Estado en este corte |
|---|---|---|
| H1 | SINK:P004 desde IPZ por RDC/STDIO, con respuesta íntegra y trazable | **Siguiente hito de producto; listo para reanudar desarrollo sintético, aún no aceptado** |
| H2 | Persistencia mínima y bóveda | **Parcialmente demostrado:** ciphertext y workspace en B2; restore aislado; descifrado de Vault pendiente |
| H3 | Workspace completo recuperable entre instancias | **Parcial:** restauración aislada en el mismo host; prueba cross-host pendiente |
| H4 | Identidad y telemetría | Pendiente |
| H5 | Lease y dead-man | Parámetros aprobados; ejecución y aceptación pendientes |
| H6 | Limpieza adaptativa y crypto-erasure | Pendiente |
| H7 | Continuidad, integración segura Vault/RDC y panel | Pendiente |
| H8 | Release MCP-OCP 1.0.0 y aceptación integral | Pendiente |
| H9 | Medio alternativo de persistencia | Diferido a post-release |

**Secuencia inmediata acordada para este sprint:** cerrar primero la persistencia B2 de EP; después reanudar H1 SINK:P004 sin reabrir tareas ya superadas ni repetir diagnósticos que no cambien una decisión.

## 3. Método mínimo de recuperación en un solo archivo

**Archivo principal:** `EP-Backup-Provisional-20261110-164004-R2.zip`  
**Destino:** bucket privado `OCP-MCP`, prefijo `ep-ocp/workspace/`  
**Tamaño:** 119.076.640 bytes.  
**Contenido inventariado:** raíz `SeryMente`; 3.289 archivos; 159.547.658 bytes originales.  
**Vault ciphertext incluido:** `SeryMente/EP/local-state/Khora/secrets/ep-env-vault.enc.json` (2.200 bytes).

### Restauración sencilla

1. Descargar únicamente `EP-Backup-Provisional-20261110-164004-R2.zip` desde el bucket/prefijo indicados.
2. Extraer el ZIP en el Escritorio del perfil de destino. El archivo contiene la carpeta raíz `SeryMente`; el resultado esperado es `%USERPROFILE%\Desktop\SeryMente`.
3. Abrir EP Vault con el mecanismo normal y la credencial maestra de recuperación. El ciphertext está dentro del paquete; la contraseña/clave maestra NO está incluida.
4. Reanudar desde el estado de workspace extraído. Los manifiestos y sidecars de SHA son auxiliares de auditoría; no son necesarios para la extracción manual simple.

Si ya existe una carpeta `SeryMente` en destino, no mezclar archivos en caliente: renombrar la carpeta actual o extraer en una ubicación vacía y cambiarla después de detener procesos.

## 4. Evidencia y límites

- Snapshot local R2: 3.289 entradas del ZIP verificadas; receipt reporta 119.076.640 bytes.
- B2: el cierre de ciclo reportó 4/4 objetos cargados y descargados con read-back, SHA-256 coincidente y SSE-B2/AES256.
- Restauración aislada: `C:\R2R`; 3.289/3.289 restaurados; cero fallos y cero archivos inesperados; el workspace original no se modificó.
- El ZIP contiene ciphertext de Vault. La restauración de archivos no equivale a descifrar Vault: `restoredFilesDecrypted=false`; la prueba de descifrado y la restauración cross-host siguen pendientes.
- La copia ZIP se subió sin cifrado del lado cliente por la urgencia del operador. Backblaze SSE-B2/AES256 confirma cifrado del lado del proveedor; no equivale a cifrado extremo a extremo ni a una garantía de confidencialidad frente al proveedor.
- Por ello, el método es **simple y con recuperación del archivo probada**, pero no puede calificarse como infalible ni como restauración completa de Vault en otra máquina. La clave de recuperación debe mantenerse independiente del ZIP.

## 5. Criterio de eficiencia

No repetir inventarios, hashes ni pruebas ya confirmadas cuando no cambien la decisión. Mantener solo los controles que prueban autorización, presencia del objeto, posibilidad de lectura/restauración y disponibilidad de la clave necesaria. El hash queda como evidencia disponible, pero no se exige al usuario para la extracción manual básica.

## 6. Próximo paso del sprint

Con la copia R2/B2 y la extracción aislada documentadas, Gobernanza puede habilitar la reanudación de desarrollo sintético H1 SINK:P004 en el ciclo MCP-OCP existente. No declarar H1 aceptado hasta demostrar el recorrido real IPZ → RDC/STDIO → SINK:P004 → salida visible y trazable al modelo.

**Estado:** registro provisional creado desde el TXT de origen; procedimiento de descarga/extracción documentado; descifrado cross-host de Vault NO_VERIFICADO.


## 7. Paquete R3 posterior · corte 17:21 local

Se encontró un segundo paquete más reciente, **solo local** en el corte de esta nota:

- Archivo: `Downloads/EP-Workspace-Recovery-R3-20261110.zip`.
- Creación: `2026-11-10T23:21:27Z` = `17:21:27 -06:00`.
- Tamaño: 107.014.352 bytes; 3.342 entradas ZIP; 3.339 archivos del workspace según su manifiesto.
- Incluye dos ciphertexts: `EP/local-state/Khora/secrets/ep-env-vault.enc.json` (2.200 bytes) y `EP-Vault/ep-env-vault.enc.json` (2.048 bytes).
- Añade `__EP_RECOVERY__/RESTORE-INSTRUCTIONS.txt` y `Restore-Workspace.ps1`. La guía indica extracción a `C:\R3R` y restauración a un destino vacío como `C:\SeryMente`; el script rechaza sobrescribir un destino existente.
- Excluye expresamente secretos en claro, claves privadas sueltas, reparse points y directorios regenerables. Mantiene la excepción de no tener cifrado cliente.

**Estado remoto de R3: NO_VERIFICADO / no usar como fuente remota confirmada.** En B2, la fuente remota con read-back demostrado sigue siendo R2. Para salir hoy, R2 es el archivo remoto de recuperación; R3 es una mejora local pendiente de carga y read-back cuando Vault/credenciales estén disponibles. No duplicar ni borrar R2.


## 8. Convención obligatoria de nombre · hora local

**Zona horaria:** `America/Mexico_City` (Fila 4 / Santiago de Querétaro).  
**Reloj comunicado por el operador para este corte:** martes 10 de noviembre de 2026, **17:32** (5:32 p. m.), UTC−06:00.

Todo nuevo paquete provisional deberá usar día de semana en español, fecha local y hora local de 24 horas:

```text
EP-Workspace-Recovery_YYYY-MM-DD_DIA_HH-mm_America-Mexico_City_RN.zip
```

Ejemplo para un snapshot creado en el instante comunicado por el operador:

```text
EP-Workspace-Recovery_2026-11-10_Martes_17-32_America-Mexico_City_RN.zip
```

La marca horaria representa el momento real de creación/cierre del snapshot, no el momento posterior en que se renombra o se copia. Incluir el mismo prefijo base en manifiesto, recibo y sidecars; conservar el timestamp ISO 8601 con offset dentro de los metadatos.

**No reescribir el historial:** el objeto remoto ya confirmado conserva su nombre original `EP-Backup-Provisional-20261110-164004-R2.zip`; corresponde al snapshot de las 16:40:04 local y no se renombra retroactivamente. El R3 local corresponde a las 17:21:27 local y tampoco debe recibir una marca 17:32. El próximo snapshot generado sí adoptará esta convención. R3 permanece solo local hasta que su carga B2 sea demostrada.


## 9. R4 remoto confirmado y restauración E2E aislada · 2026-11-10

**Archivo remoto actual (canónico y descargable):**

`OCP-MCP/ep-ocp/workspace/EP-Workspace-Recovery_2026-11-10_Martes_17-35_America-Mexico_City_R4.zip`

- Snapshot creado: `2026-11-10T23:35:36.7846057Z` = martes 17:35:36.784 (-06:00).
- ZIP: 107.081.813 bytes; SHA-256 `DD84AA680CDE49D9940E35203E8D29355FB6904105680E87128DE8C868F883CE`.
- Upload y read-back B2: `R4_UPLOAD_AND_REMOTE_READBACK_PASS`; 107.081.813 bytes descargados; SHA-256 de read-back idéntico.
- Cifrado del proveedor confirmado: SSE-B2/AES256. No hay cifrado del lado cliente por excepción urgente del operador.
- File ID fuente: `4_z974c6cb88be79f3fa9150c16_f20062b1a07ef15c5_d20261110_m233752_c005_v0501052_t0012_u01794353872691`.
- Hora local en que el read-back quedó verificado y el archivo fue acreditado como recuperable: **martes 10-11-2026, 17:46:17.620 (-06:00)**.
- Caché temporal de autorización limpiada; ningún valor secreto emitido.

**Restauración aislada: PASS.** El ZIP abrió y extrajo sus 3.348 entradas. La validación completa del manifiesto reportó 3.345 archivos; se restauraron 145.501.528 bytes en `C:\R4-RestoreValidation`, con ciphertext primario de Vault presente. La carpeta de trabajo original no fue modificada. La prueba usó el mismo contenido que descargó B2 y cuyo SHA coincidió byte por byte.

**Defecto encontrado en el script auxiliar incluido:** `Restore-Workspace.ps1` usa `Test-Path`/`Get-Item`/`Get-FileHash` con comodines y puede rechazar falsamente rutas reales que contienen `[id]`. En la prueba aislada se corrigió la copia extraída con parámetros `-LiteralPath`; después `PACKAGE_VALIDATED` y `RESTORE_PASS`. El ZIP remoto no fue modificado para sustituir ese helper. Para la recuperación inmediata, descargar el ZIP y usar **Extraer todo** de Windows en un destino vacío; no ejecutar el helper incluido. El archivo de datos y sus entradas están íntegros.

**Bóveda:** el paquete incluye los dos ciphertexts (`EP/local-state/Khora/secrets/ep-env-vault.enc.json`, 2.200 bytes; `EP-Vault/ep-env-vault.enc.json`, 2.048 bytes). El descifrado de Vault en otro perfil/equipo y la portabilidad DPAPI siguen pendientes; la contraseña maestra no está dentro del ZIP. Abrir Vault localmente con esa contraseña después de extraer.

**Marca temporal:** el nombre remoto R4 refleja el instante de captura del snapshot (17:35). El instante en que se confirmó su recuperación desde B2 fue 17:46:17.620. Un intento posterior de crear un alias B2 `17-46` falló sin cambiar ni eliminar el objeto remoto válido. Para próximos paquetes, el nombre publicado como recuperable deberá usar la hora del primer read-back remoto PASS; el manifiesto interno conservará por separado la hora de captura.

R2 sigue existiendo como respaldo remoto anterior; no se modificó ni eliminó.


## 10. Cambio de procedimiento · enlace público con cifrado cliente · 2026-11-10

**Decisión solicitada por el operador para los próximos respaldos provisionales:** descargar sin autenticarse en Backblaze mediante una URL pública directa, pero publicar únicamente el paquete cifrado de extremo a extremo.

### Diseño de publicación

- Mantener el bucket existente `OCP-MCP` como **privado**. No cambiar su privacidad ni publicar/mover los objetos históricos R2/R4.
- Preparar un bucket separado, dedicado exclusivamente a paquetes de recuperación cifrados. Nombre candidato: `ocp-mcp-recovery-public-encrypted` (propuesto; disponibilidad, creación y privacidad efectiva pendientes de EP).
- La privacidad pública se aplica a todo el bucket, no a un archivo individual. Por tanto, ese bucket no podrá contener ZIP en claro, ciphertext de Vault suelto, manifests/sidecars no cifrados, logs, llaves ni objetos ajenos al procedimiento.
- Generar localmente el snapshot ZIP y cifrarlo antes de cualquier upload usando **age** con cifrado de destinatario X25519 y autenticación ChaCha20-Poly1305. El objeto que se publica llevará extensión `.zip.age`; la clave pública de recuperación es la destinataria de cifrado, nunca la clave privada.
- Custodiar la identidad/clave privada age fuera de B2 y fuera del propio paquete, con copia de contingencia independiente. No puede depender exclusivamente del Vault que solo está dentro del paquete que esa clave debe descifrar.
- Subir únicamente `.zip.age`. El SHA-256 de aceptación será el del ciphertext publicado; no publicar hashes del ZIP en claro ni metadatos sensibles.
- Tras upload, obtener la URL pública directa/Friendly URL del objeto. La descarga debe funcionar en una sesión limpia, sin login ni token B2. El enlace no es un secreto ni tiene caducidad automática: quien lo posea podrá descargar el ciphertext.
- Recuperación: descargar `.zip.age`, descifrar localmente con la identidad privada independiente, comprobar el ZIP y su manifiesto, y extraer en destino aislado. No ejecutar sobre un workspace activo.
- Retirar el ZIP intermedio en claro del staging después de la validación, manteniendo staging dentro del volumen protegido; no afirmar borrado físico irrecuperable en SSD.

### Estado histórico y gate de transición

R4 permanece en `OCP-MCP/ep-ocp/workspace/` como objeto privado, sin modificación. Su SHA-256 remoto/local confirmado es `DD84AA680CDE49D9940E35203E8D29355FB6904105680E87128DE8C868F883CE`; se cargó sin cifrado del lado cliente y solo tuvo SSE-B2/AES256. **No se reutiliza como objeto público ni se etiqueta retroactivamente como cifrado.**

El siguiente snapshot nuevo (R5, sujeto a confirmar la secuencia libre en EP) deberá producirse como `.zip.age`. Su estado solo será PASS cuando se demuestre, por separado: (1) cifrado local antes del upload; (2) ausencia de paquete en claro en el bucket público; (3) read-back por URL pública sin autenticación; (4) SHA-256 idéntico del ciphertext; (5) descifrado con la identidad custodiada independientemente; y (6) restauración aislada del ZIP resultante.

**No ejecutado en esta actualización documental:** no se creó bucket, no se cambió ACL/privacidad, no se generó identidad age, no se subió un nuevo objeto, no se publicó URL real y R4/R2 no se modificaron. La implementación queda pendiente del frente EP en EP-TASK-002 y la aceptación integrada GOV-TASK-014.

**Referencias técnicas:** [Backblaze — buckets y acceso público/privado](https://www.backblaze.com/docs/cloud-storage-buckets) · [Backblaze — descarga por nombre y URL directa](https://www.backblaze.com/docs/cloud-storage-download-files-with-the-native-api) · [age — especificación de cifrado](https://c2sp.org/age@v1.0.0) · [age — implementación y uso](https://github.com/FiloSottile/age).
