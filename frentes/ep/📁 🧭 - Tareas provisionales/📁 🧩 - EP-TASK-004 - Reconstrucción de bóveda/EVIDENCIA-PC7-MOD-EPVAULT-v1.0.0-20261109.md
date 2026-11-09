# Evidencia de materialización local — MOD-EPVAULT v1.0.0 — PC 7

**Fecha:** 2026-11-09 · **Host/usuario observados:** PC-7 / PC 7  
**Origen del paquete:** `SeryMente/metodologia`, rama `feat/ep-vault-pc7-hardened-20261109`, PR #21.  
**Destino local:** `Desktop/SeryMente/Repositorios/Metodologia/metodologia/frentes/ep/modulos/MOD-EPVAULT/v1.0.0/`.

## Resultado de materialización

- Se materializó el directorio versionado del módulo sin sobrescribir EP-TASK-004.
- Los 14 archivos declarados en `MANIFEST.json` se cotejaron con sus Git blob SHA-1. También se cotejaron README, CHANGELOG y MANIFEST: **17/17 Git blobs PASS**.
- Los dos WAV se copiaron desde el staging local histórico y sus SHA-256 de origen/destino coincidieron.
- PowerShell 5.1.26100.9711, usuario PC 7.
- Se crearon accesos directos en el Escritorio para GUI y CLI. Se verificaron destino y directorio de trabajo mediante read-back.
- La GUI se inició desde el módulo versionado. Windows enumeró una ventana activa cuyo título identifica EP Vault v1.0.0.

## Comprobaciones ejecutadas

| Comprobación | Resultado |
|---|---|
| Git blob SHA de 14 archivos del manifiesto + 3 documentos raíz | PASS · 17/17 |
| SHA-256 de los dos recursos WAV tras copia | PASS |
| Parser PowerShell (3 archivos fuente) | PASS |
| Carga real WPF/XAML | PASS |
| Controles XAML requeridos | PASS · 22/22 |
| CLI `Version` | PASS · 1.0.0 · exit 0 |
| CLI `Status` inicial, solo lectura | PASS · `NOT_INITIALIZED` |
| Core crypto self-test | PASS · PBKDF2-SHA256, AES-256-CBC, HMAC-SHA256, round-trip, password incorrecta y manipulación |
| Job Object self-test | PASS |
| Job timeout/process-tree termination self-test | PASS |
| Ventana GUI en PC 7 | PASS · 1 ventana enumerada |
| Accesos directos GUI/CLI | PASS · read-back de destinos |

## Pruebas pendientes y límites

- La suite sintética E2E completa de v1.0.0 **no se ejecutó**: el lanzamiento del runner desde el canal remoto fue rechazado por el control de ejecución. No se intentó eludirlo. Este rechazo no es un fallo de la suite ni un PASS.
- El instalador integral no se ejecutó porque su ruta predeterminada incluye esa suite. No se usó `-SkipSyntheticTests` para fingir conformidad.
- H10 sigue pendiente: revisión presencial de experiencia visual/auditiva, interacción, DPI, teclado, accesibilidad, movimiento reducido y cierre/expiración.
- PR #21 permanece abierta; el merge a `main` sigue sujeto a P012/P013 del DUG.

## Estado del almacén formal y preservación

La primera consulta CLI de esta materialización devolvió `NOT_INITIALIZED`, `vaultExists=false`, `sessionActive=false`. Una consulta posterior, con la GUI ya iniciada, devolvió `ENCRYPTED_FILE_PRESENT`, KDF PBKDF2-HMAC-SHA256 con 600.000 iteraciones y sesión activa. **La causa/persona que produjo el cambio no quedó atribuida técnicamente.** Los comandos de esta intervención no ejecutaron `Initialize`, no escribieron variables y no revelaron contenido.

Por integridad y privacidad, se preservó el almacén tal como fue observado: no se inspeccionó su payload, no se copió, no se borró, no se migró ni se bloqueó. No inferir el número ni la identidad de variables a partir del tamaño del archivo.

## Protección del volumen del host

Consulta de solo lectura `manage-bde -status C:`:

- Conversión/sectores usados: 100 % cifrado.
- Algoritmo: XTS-AES 128.
- **Protección: desactivada.**
- **Protectores: ninguno.**

Por tanto, el volumen C: no aporta actualmente protección BitLocker activa. El cifrado de archivo propio de EP Vault no sustituye BitLocker. No introducir credenciales de alta sensibilidad en este perfil hasta que el control de dispositivo exigido por EP esté activado y verificado.

## Conclusión

**Materializada localmente y operable en superficies CLI/GUI; verificación de integridad y pruebas de componentes PASS. No declarar la release aceptada ni la suite E2E completa PASS.** El almacén formal se preserva sin inspección; H10 y merge a `main` permanecen pendientes.
