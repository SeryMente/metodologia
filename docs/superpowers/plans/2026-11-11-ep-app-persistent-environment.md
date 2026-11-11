# EP-App v1.1.0 — Plan de implementación (piloto Writing Plans)

> **Para agentes implementadores:** usar `superpowers:subagent-driven-development` (recomendado) o `superpowers:executing-plans` para ejecutar este plan tarea por tarea. Cada paso usa casillas verificables.

**Estado del documento:** EXPERIMENTO · BORRADOR · NO AUTORIZA IMPLEMENTACIÓN.

**Goal:** preparar una versión candidata EP-App v1.1.0 que amplíe a 3.600 segundos la sesión autenticada de EP Vault, presente una pestaña ENTORNO PERSISTENTE y mantenga bloqueadas las operaciones de VHDX/checkpoint hasta que sus precondiciones de seguridad estén verificadas.

**Architecture:** conservar la arquitectura existente PowerShell 5.1 + WPF/XAML. EP Vault sigue siendo la única bóveda; `EP.Session.psm1` mantiene las operaciones de contenedor y sesión. La nueva interfaz separa selección visual de modo persistente de la capacidad real para restaurar o guardar/cerrar. La capacidad se deriva de estado comprobado en modo lectura; ningún interruptor de interfaz puede concederla por sí solo.

**Tech Stack:** Windows PowerShell 5.1, WPF, XAML, módulos PowerShell EP Vault/EP Session y el harness existente `tests/Test-EPVault.ps1`. No agregar dependencias externas.

**Spec:** EP-TASK-004 (núcleo existente, sin modificarlo), OEP §§128–131 y el reporte del operador incorporado en esta conversación el 2026-11-11. El reporte describe EP-App v1.1.0 y los cambios esperados; esos cambios no se han verificado todavía contra el árbol de código remoto.

## Global Constraints

- Este plan es un artefacto experimental independiente. No modificar EP-TASK-004, ninguna otra tarea provisional, el índice de tareas, OEP.md, CONTROL-RESPONSABILIDAD.json, DUG ni GOW.
- No abrir, desbloquear, leer, migrar ni escribir la bóveda formal. No acceder a valores de variables, contraseñas, notas efímeras ni credenciales.
- No ejecutar `diskpart`, `manage-bde`, `New-VHD`, `Mount-EpSessionContainer`, `New-EpSessionContainer`, `Save-CloseEpSessionContainer` ni `Invoke-EpSessionCryptoErase` durante pruebas del plan.
- Mantener las operaciones mutadoras deshabilitadas por defecto. El botón de modo persistente es una preferencia de interfaz; no acredita protección ni habilita acciones.
- Restaurar/guardar-cerrar solo podrán habilitarse cuando el estado de workspace protegido, checkpoint cifrado y restauración aislada esté verificado; revalidar el gate al hacer clic, no solo al cargar la ventana.
- El TTL de 3.600 segundos corresponde a la sesión autenticada de EP Vault. No cambiar el límite absoluto de 8 horas, el lease, los parámetros del Guardián ni políticas de otras sesiones.
- Añadir 3.600 segundos sin retirar las duraciones preexistentes ni cambiar el valor predeterminado de 300 segundos.
- `EP-App` es una etiqueta provisional de producto. Mantener estables `MOD-EPVAULT`, nombres internos de módulos, rutas de datos y nombres de variables.
- Compatibilidad obligatoria: Windows PowerShell 5.1. Pruebas con perfiles `LOCALAPPDATA` temporales y datos sintéticos; no usar el almacén formal.
- No instalar, desplegar, fusionar a main ni declarar H10 aceptado como resultado de este experimento.

## Review Focus

1. **TTL inválido o fuera de política:** 0, valores negativos, 901–3599 y 3601 deben rechazarse; 3.600 debe aceptarse en Core, CLI, GUI y lectura de sesión compartida. Prueba: `Test-TTL3600-And-Boundaries`.
2. **Compatibilidad retrospectiva:** sesiones válidas con 15, 30, 60, 120, 180, 300, 600 y 900 segundos deben seguir importándose. Prueba: `Test-LegacySessionTtlOptionsRemainValid`.
3. **Registro inconsistente o manipulado:** una duración declarada que no concuerde con `startedAtUtc`/`expiresAtUtc` debe fallar cerrado. Prueba: `Test-SharedSessionTtlMetadataIntegrity`.
4. **Bóveda sellada/sesión expirada:** la pestaña puede mostrar estado informativo, pero no debe revelar secretos ni habilitar operaciones de sesión. Prueba: `Test-PersistentActionsStayDisabledWithoutVaultSession`.
5. **VHDX/checkpoint ausente, incompleto o sin restauración validada:** ninguna acción de crear, montar, restaurar, guardar/cerrar o borrar debe iniciarse. Prueba: `Test-PersistentActionsFailClosedWithoutVerifiedPrerequisites`.

---

### Task 1: Fijar la base de código y reconciliar el reporte v1.1.0

**Files:**
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP.Vault.Core.psm1`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP.Vault.CLI.ps1`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP-Vault.GUI.ps1`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP-Vault.Window.xaml`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP.Session.psm1`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/src/EP.Session.Guardian.ps1`
- Read: `frentes/ep/modulos/MOD-EPVAULT/v1.0.1/tests/Test-EPVault.ps1`
- Create: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/` (copia de trabajo versionada; no sobrescribir v1.0.0 ni v1.0.1)

**Interfaces:**
- Consumes: árbol candidato de `feat/ep-vault-session-mvp-20261110`, HEAD `40967d08eafc81963adbfb60ad750f2d11cb9b65`.
- Produces: baseline v1.1.0 con procedencia explícita y comparación de blobs frente a v1.0.1.

- [ ] **Step 1: Confirmar la base exacta**. Comprobar que los archivos de v1.0.1 coinciden con el HEAD fijado; registrar hashes de blob de entrada en el manifiesto de trabajo.
- [ ] **Step 2: Contrastar el reporte del operador**. Buscar en el árbol remoto el título EP-App v1.1.0, opción TTL 3600, pestaña ENTORNO PERSISTENTE y controles deshabilitados. No presentar el reporte conversacional como código verificado.
- [ ] **Step 3: Documentar la discrepancia observada**. En el snapshot v1.0.1 consultado, Core/CLI/XAML aún enumeran duraciones hasta 900 segundos; `Test-EPVault.ps1` prueba ocho opciones hasta 900. `Add-EpSessionTab` crea controles de crear, montar, guardar/cerrar y emergencia con handlers conectados a operaciones de host. El manifiesto existente bajo v1.0.0 declara versión 1.0.0; no se localizó un árbol v1.1.0 en el commit inspeccionado.
- [ ] **Step 4: Crear el árbol candidato v1.1.0**. Copiar la base v1.0.1 sin mutar su directorio y conservar los blobs de origen para comparación.
- [ ] **Step 5: Ejecutar baseline sintético**.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tests\Test-EPVault.ps1
```

Expected: salida `EP_VAULT_VALIDATION_PASS`, exit code 0. Ejecutar con `LOCALAPPDATA` temporal aislado; el reporte del baseline debe identificar que 3600 todavía no forma parte del conjunto permitido.

### Task 2: Añadir TTL de 3.600 segundos con una sola política coherente

**Files:**
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP.Vault.Core.psm1`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP.Vault.CLI.ps1`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.Window.xaml`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.GUI.ps1`
- Test: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/tests/Test-EPVault.ps1`

**Interfaces:**
- Consumes: `Set-EpVaultSession`, `Import-EpSharedSession`, `Initialize-EpVault`, `Unlock-EpVault` y parámetro CLI `DurationSeconds`.
- Produces: duración permitida 3600 segundos, persistida y reimportable; valor predeterminado sin cambios (300 segundos).

- [ ] **Step 1: Escribir pruebas que fallen**: ampliar la matriz de opciones para incluir 3600; añadir un test de round-trip de sesión compartida con `durationSeconds=3600`; probar CLI `Version -DurationSeconds 3600`; probar rechazo de 0, 901, 3599 y 3601.
- [ ] **Step 2: Ejecutar los tests nuevos**. Expected: FAIL por validación actual limitada a 900 segundos.
- [ ] **Step 3: Actualizar Core**. Ampliar consistentemente los puntos de validación de `Import-EpSharedSession`, `Set-EpVaultSession`, `Initialize-EpVault` y `Unlock-EpVault`; no dejar listas/ValidateSet divergentes.
- [ ] **Step 4: Actualizar CLI y selector**. Ampliar `ValidateSet` de `DurationSeconds` en `EP.Vault.CLI.ps1`; añadir `60 minutos` con `Tag=3600` a `SessionDuration` en XAML. Conservar la opción predeterminada actual.
- [ ] **Step 5: Conservar el paso de valor GUI→Core**. Verificar que `Invoke-EpUnlock` sigue leyendo `SessionDuration.SelectedItem.Tag` y pasa ese entero a `Unlock-EpVault`/`Initialize-EpVault`, sin una segunda lista hardcodeada.
- [ ] **Step 6: Ejecutar pruebas focalizadas y suite completa**. Expected: 3600 aceptado y leído de vuelta; opciones históricas PASS; límites inválidos rechazados; `EP_VAULT_VALIDATION_PASS`.

### Task 3: Construir la pestaña ENTORNO PERSISTENTE y separar modo de capacidad

**Files:**
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.GUI.ps1`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.Window.xaml`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP.Session.psm1`

**Interfaces:**
- Consumes: `Read-EpSessionMetadata`, `Get-EpVaultSession` y consultas de solo lectura de estado BitLocker/checkpoint.
- Produces: `Get-EpPersistentUiCapabilities -State $State`, función pura que devuelve `CanRestoreCheckpoint`, `CanSaveAndClose` y `ReasonCodes`; la interfaz no ejecuta operaciones de almacenamiento.

- [ ] **Step 1: Definir estados de entrada**. Usar estados tipados y explícitos: `WorkspaceProtection=VERIFIED_XTS_AES256_100_PROTECTION_ON|NOT_VERIFIED|FAIL`; `CheckpointEncryption=VERIFIED|NOT_VERIFIED|FAIL`; `RestoreValidation=VERIFIED|NOT_VERIFIED|FAIL`; `VaultSessionActive=$true|$false`.
- [ ] **Step 2: Añadir tests de la función pura**. La capacidad será falsa si cualquiera de las cuatro condiciones no está verificada; solo será verdadera cuando todas estén en estado PASS. El toggle de modo persistente no modifica estos estados.
- [ ] **Step 3: Crear el diseño de la pestaña**. Header `ENTORNO PERSISTENTE`; toggle `PersistentModeToggle`; campos `PersistentWorkspaceStatus`, `PersistentCheckpointStatus`, `PersistentRestoreStatus`; botones `RestoreCheckpointButton` y `SaveAndCloseButton`.
- [ ] **Step 4: Renderizar estado conservador**. Cuando falte evidencia, mostrar `NO VERIFICADO` y razón concreta; no deducir `Protection On`, cifrado cliente o restore a partir de la mera existencia de un VHDX/ZIP.
- [ ] **Step 5: Deshabilitar acciones por defecto**. `RestoreCheckpointButton.IsEnabled=$false` y `SaveAndCloseButton.IsEnabled=$false`. Los controles de crear VHDX y crypto-erasure de la implementación candidata no se habilitan ni se convierten en parte del flujo de este piloto.
- [ ] **Step 6: Agregar revalidación en cada handler**. Antes de cualquier llamada, volver a evaluar `Get-EpPersistentUiCapabilities`. Si no hay PASS, salir sin llamar `Mount-EpSessionContainer`, `Save-CloseEpSessionContainer` ni `Invoke-EpSessionCryptoErase`.
- [ ] **Step 7: Eliminar el re-enable incondicional**. El patrón actual `finally { $button.IsEnabled = $true }` no debe restaurar disponibilidad tras un error; después de cada intento, recalcular el gate y mantener el estado seguro por defecto.

### Task 4: Aplicar el nombre provisional EP-App v1.1.0 sin migración interna innecesaria

**Files:**
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.Window.xaml`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/src/EP-Vault.GUI.ps1`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/README.md`
- Create: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/CHANGELOG.md`

**Interfaces:**
- Consumes: módulo interno `MOD-EPVAULT` y ejecutables/paths actuales.
- Produces: identidad visible `EP-App · v1.1.0`; compatibilidad interna con MOD-EPVAULT y EP Vault.

- [ ] **Step 1: Probar la identidad visible**. Añadir asserts de título de ventana `EP-App · v1.1.0`, encabezados y captions relevantes.
- [ ] **Step 2: Cambiar solo identidad de presentación**. Actualizar título, etiquetas y mensajes visibles de la aplicación. No renombrar módulos, comandos, variables, archivos de bóveda ni directorios de datos.
- [ ] **Step 3: Documentar provisionalidad**. README/CHANGELOG declaran `EP-App` como nombre visible provisional; no convertirlo en nombre canónico del producto.
- [ ] **Step 4: Ejecutar asserts UI**. Expected: las cadenas de presentación reflejan EP-App v1.1.0 y los nombres internos permanecen estables.

### Task 5: Verificar controles, seguridad de interfaz y paquete

**Files:**
- Create: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/tests/Test-EPApp-PersistentEnvironment.ps1`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/tests/Test-EPVault.ps1`
- Create: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/MANIFEST.json`
- Modify: `frentes/ep/modulos/MOD-EPVAULT/v1.1.0/README.md`

**Interfaces:**
- Consumes: tests Core/CLI existentes, XAML, GUI y `Get-EpPersistentUiCapabilities`.
- Produces: suite reproducible, manifiesto de release y evidencia de solo lectura.

- [ ] **Step 1: Probar el contrato XAML**. Parse XML; verificar título EP-App, pestaña ENTORNO PERSISTENTE, toggle y nombres exactos de controles.
- [ ] **Step 2: Probar tabla de capacidades**. Fixtures sintéticos para bóveda sellada, VHDX ausente, BitLocker Off, cifrado cliente ausente, restore pendiente, estado completo verificado y datos inconsistentes.
- [ ] **Step 3: Probar ausencia de efectos laterales**. Con gates falsos, confirmar que las acciones no invocan funciones de montaje, upload, eliminación ni crypto-erasure; verificar que los botones permanecen deshabilitados tras error/cierre/expiración.
- [ ] **Step 4: Ejecutar las dos suites**.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tests\Test-EPVault.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tests\Test-EPApp-PersistentEnvironment.ps1
```

Expected: ambas suites exit 0; salida `EP_VAULT_VALIDATION_PASS` y `EP_APP_PERSISTENT_UI_TESTS_PASS`. Cero secretos en fixtures/logs y cero cambios a almacén formal.
- [ ] **Step 5: Smoke WPF aislado**. Lanzar GUI con `LOCALAPPDATA` temporal sin bóveda formal. Confirmar ventana EP-App v1.1.0, tab, toggle y estados NO VERIFICADO; todos los botones mutadores siguen deshabilitados.
- [ ] **Step 6: Recalcular MANIFEST.json**. Incluir rutas, tamaños y Git blob SHA de cada archivo entregado. Comparar cada archivo del paquete con el manifiesto después de la prueba.
- [ ] **Step 7: Self-review**. Revisar cobertura de cada requisito, consistencia de nombres/funciones, límites de TTL, default 300 s, compatibilidad PS 5.1 y ausencia de acciones de host no habilitadas.
- [ ] **Step 8: Commit aislado**. Commit en rama `feat/ep-app-v1.1.0`; no fusionar a main ni instalar.

## Dependencias y secuencia

Orden: Task 1 → Task 2 → Task 3 → Task 4 → Task 5. Las pruebas de TTL y la capa de capacidad pura se pueden desarrollar en paralelo únicamente después de fijar la copia v1.1.0; la integración WPF depende de que sus interfaces estén congeladas.

## Criterios de salida del piloto

- `EP_APP_TITLE=EP-App v1.1.0` verificado en WPF.
- `VAULT_TTL_3600=PASS` en Core, CLI, selector GUI y round-trip de sesión compartida.
- TTL histórico y valor predeterminado preservados.
- Pestaña `ENTORNO PERSISTENTE` visible; toggle no concede capacidades.
- `RESTORE` y `SAVE_CLOSE` deshabilitados si workspace, checkpoint, restore o sesión Vault no están verificados.
- En los tests y smoke no se ejecutan operaciones DiskPart, BitLocker, B2 ni borrado.
- Manifest/read-back del paquete exactos; commit aislado, sin merge ni instalación.

## Revisión del plan y límites

El snapshot candidato consultado corresponde a `feat/ep-vault-session-mvp-20261110` / `40967d08eafc81963adbfb60ad750f2d11cb9b65`; no equivale a `main` ni demuestra que el reporte conversacional de v1.1.0 ya esté materializado. El piloto valida el método de planificación y acota un cambio; no completa EP-TASK-004, H10, BitLocker, checkpoint cifrado, restore remoto ni aceptación humana.

**Autorización de ejecución:** PENDIENTE. Este documento por sí solo no autoriza implementación, operaciones locales, acceso a secretos, instalación o aceptación.
