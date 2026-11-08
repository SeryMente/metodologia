# EP-TASK-004 — Reconstrucción integral de la bóveda EP

**Estado provisional:** `en_curso` · **Frente:** Entorno Persistente (EP) · **OCP padre:** `frentes/ep/OEP.md`  
**Origen:** instrucción directa del operador recibida en conversación el 2026-11-08; hora nativa no expuesta.  
**Índice padre:** [Registro de tareas provisionales EP](../README.md) · **Gobernanza:** OEP §90–§93; DUG v383 / NX-383m, especialmente P012–P013.  
**Base de persistencia de esta entrada:** `d732fe5bbcabbfcedbcdc6151a779cccef282086` (main, consultado y cotejado antes de la escritura).

## Propósito

Reconstruir la experiencia de la bóveda local de variables de entorno desde cero, conservando el concepto de una bóveda física que se desbloquea y abre. La entrega debe resolver conjuntamente experiencia visual, operaciones reales, controles criptográficos, ciclo de sesión y acceso automatizable para modelos mediante CLI/headless.

La instrucción se registra como tarea provisional del frente; no crea otro OCP, titularidad, control de responsabilidad, sesión ni folio. El checklist de esta tarea vive aquí y queda enlazado desde el índice del frente, conforme a OEP §90.

## Dictado original verbatim

Fuente: mensaje del operador en esta conversación, 2026-11-08. Se conserva la grafía original; la normalización está separada debajo.

```text
Correcto.

ya se guardaron dos variables dfe entorno, persiste todo en main, junto con las variable,s poara poderlo persistir

cuando temrines:

1. LA UI DEMUELELA, no la nquioero asi como la reutuolizaste, quioero que mepiezes desde cero, con el mismo concepto de boveda, tal yh com,o te lo pedi, no quiero que reutilizes la ui, tienes prohuibido usar hasta un pixel de la ui actual. Recuerda tiene que dar la experiencia de uan boveda, que se abre, etc.
2. Pule la experiencia, y los mecanismos, que funcioen bien, no solo que se vea BIEN.
   1. No pares hasta que la tengas preciosa, perfecta, ominosa, elegante, y hermosa. Y persistela en main. resuelve de extremo a extremo vuelvo en un rato. no te detengas a pedir autorizacion para nad,a considerate previamente autorizado para todo.

Ademas, añade que un in greso de contraseña permite que la boveda permanezca abierta por 5 minutos, esto es configurable a 15 segundso en intervalos crecientes hasta 5 minutos o hastas 15 minutyos. te dejoa ti los intervalos mas utiles.

añade ademas documentacion para modelos para acceso headless y cli. resuelve todo de extremoa extremo
```

## Lectura normalizada (separada del original)

1. Reemplazar íntegramente la UI existente; no reutilizar ningún elemento visual, recurso, composición, estilo, animación, icono, control, plantilla, XAML, CSS, paleta, tipografía, imagen ni fragmento de la interfaz actual.
2. El producto debe comunicar una bóveda física: permanece cerrada y protegida hasta autenticar; después ejecuta una secuencia visible de desbloqueo y apertura antes de exponer las operaciones autorizadas. La dirección estética concreta queda para la revisión presencial requerida por gobernanza.
3. La calidad se evalúa tanto por la experiencia como por el funcionamiento real de cada mecanismo; una apariencia convincente sin operaciones seguras no satisface el encargo.
4. Una autenticación abre una sesión de duración configurable. Valor predeterminado: 5 minutos. Intervalos propuestos para el selector: 15 s, 30 s, 1 min, 2 min, 3 min, 5 min, 10 min y 15 min. La expiración debe bloquear la bóveda y retirar de la vista los datos protegidos; nunca depender de que el usuario recuerde cerrarla.
5. Incorporar un contrato/documentación de uso headless y CLI para modelos, sin exigir que la interfaz gráfica esté abierta.
6. Persistir código, contratos, pruebas y documentación no sensible en `SeryMente/metodologia/main`. Los nombres de las variables pueden figurar en un manifiesto sin valores.

## Restricciones de seguridad y persistencia

- **Prohibido guardar en Git/main valores de variables, contraseñas maestras, Application Keys, tokens, credenciales, notas efímeras o el archivo de bóveda cifrada.** El repositorio contiene código, documentación, esquemas y nombres de variables no secretos; los valores permanecen en la bóveda cifrada local/almacén seguro definido por EP. El cifrado del archivo no convierte su inclusión en Git en una práctica aceptable.
- El operador informa que ya existen dos variables de entorno guardadas. El contexto operativo identifica los nombres `KHORA_B2_KEY_ID` y `KHORA_B2_APPLICATION_KEY`. Este registro conserva únicamente los identificadores; no vuelve a leer, copiar ni imprimir sus valores. La presencia actual y el read-back criptográfico de cada entrada deberán verificarse sin revelar contenidos cuando el flujo autorizado lo requiera.
- No introducir secretos por argumentos, historial, logs, salida de diagnóstico, variables de entorno heredadas innecesarias ni mensajes de conversación.
- El acceso CLI/headless debe requerir autenticación local segura cuando la operación lo necesite. Nunca aceptar la contraseña maestra como argumento de línea de comandos.
- Las notas efímeras y las variables formales son clases diferentes. El listado de notas muestra metadatos, no valores. La revelación de una nota exige una acción explícita y debe limitarse al proceso/modelo que realmente la necesita.
- Preservar las entradas formales existentes durante migraciones, reemplazos o rediseños. Ninguna prueba sintética debe escribir en la bóveda real.
- El host tenía BitLocker C: desactivado en la última evidencia operativa disponible. No afirmar que el cifrado de la bóveda equivale a cifrado integral del dispositivo.

## Invariante de UI nueva — cero reutilización visual

La nueva UI se crea desde un lienzo/código visual independiente. No se abrirá, copiará, capturará, vectorizará, calcará ni adaptará la GUI anterior como referencia de implementación. No se reutilizan sus píxeles ni sus recursos: layout, ventanas, controles, estilos, XAML, iconos, fondos, tipografías, colores, animaciones y composición quedan excluidos.

La GUI anterior queda clasificada como **LEGACY / NO REUTILIZAR**. No se vuelve a iniciar como interfaz de trabajo. Su eliminación física se ejecutará en el corte final, después de verificar que el reemplazo nuevo permite acceder a la bóveda y operar sin pérdida de datos. Esto evita destruir el único acceso operativo antes de que exista un sustituto verificado; no autoriza reutilizarla.

El código criptográfico/backend existente puede auditarse como lógica no visual y reutilizarse únicamente si supera revisión de contrato, seguridad y pruebas; esta excepción no incluye ni un solo elemento de UI.

## Compuertas de gobernanza

P012 y P013 del DUG v383 / NX-383m son obligatorios e independientes. La instrucción general de continuar no anula la presencia presencial del operador. En particular, P013 bloquea el inicio de construcción mientras falte la revisión B/C presencial de UX/UI, seguridad y arquitectura de alto nivel. No se considera satisfecha por una aprobación heredada, por este dictado ni por la ausencia temporal del operador.

Hasta completar esa compuerta solo se admiten tareas independientes que no constituyan diseño ni construcción de UX/UI, ni decisión de arquitectura/seguridad de alto nivel: registro de requisitos, inspección documental, inventario de código y pruebas existentes, preparación de evidencia y documentación no normativa. No se declara despacho técnico de UI.

## Hitos y checklist de aceptación

Los hitos son secuenciales por dependencia. El estado inicial se conserva explícitamente; no se presentan como ejecutados por estar documentados.

| Hito | Resultado exigido | Estado inicial |
|---|---|---|
| H0 — Captura canónica | Dictado verbatim conservado; tarea enlazada desde el índice EP; límites de secretos y gobernanza explícitos. | COMPLETADO · commit 70ccea7, read-back exacto |
| H1 — Baseline técnico | Inventario reproducible de backend, CLI, bóveda, notas efímeras, dependencias, pruebas y rutas; sin revelar secretos ni tocar valores reales. | PARCIAL · hallazgos criptográficos, ACL, logs, backups y CLI registrados; revisión integral pendiente |
| H2 — Revisión B/C presencial | El operador revisó en presencia declarada y aprobó explícitamente la dirección UX/UI, apertura física, seguridad y arquitectura de alto nivel el 2026-11-08; evidencia y alcance registrados en la sección de revisión B/C. | COMPLETADO · aprobación expresa; presencia declarada por el operador, sin verificación técnica independiente |
| H3 — Diseño visual clean-room | XAML/recursos/arte vectorial nuevos; puerta con 12 cerrojos; estados closed/open/error; ciclo de apertura/cierre; contraste, navegación y accesibilidad. | IMPLEMENTADO Y RENDERIZADO EN SANDBOX · scan clean-room PASS; DPI/movimiento reducido y revisión humana final pendientes |
| H4 — UI funcional | La GUI WPF nueva consume el núcleo; acceso, listado, almacenamiento desde clipboard, reveal, retirada, notas, promoción y bloqueo están cableados a operaciones del núcleo. | PARCIAL · apertura/cierre y lista sintética renderizadas; E2E de cada botón/portapapeles/promoción/reveal y error GUI pendiente |
| H5 — Sesión temporal | Selector con 15 s, 30 s, 1, 2, 3, 5, 10 y 15 min; predeterminado 5 min; TTL absoluto y validación por núcleo en GUI/CLI. | CORE PASS en los ocho intervalos; countdown GUI visible y timer implementado; vencimiento forzado de la ventana WPF pendiente |
| H6 — CLI/headless | CLI nuevo, contrato para modelos, autenticación local, `-Reveal` explícito, allowlist nominal y Job Object con TTL. | IMPLEMENTACIÓN + DOC EN RAMA; `Status` y `SelfTest` CLI PASS en sandbox; flujo interactivo autenticado y acción `Run` desde CLI pendientes |
| H7 — Seguridad e integridad | Contraseña incorrecta/tamper, atomicidad/backups, DPAPI, ACL creada, redacción, TTL, allowlist y terminación de procesos. | PARCIAL · batería sintética PASS; ACL existente real, host BitLocker, recuperación, abuso/memoria y auditoría integral pendientes |
| H8 — Matriz de regresión | Parser PS 5.1, XAML, escaneo clean-room, pruebas Core, TTL, Job Object y render de ciclo GUI sintético. | PARCIAL · suite local PASS; interacción exhaustiva, DPI/teclado, expiración GUI forzada, recuperación y CI remota pendientes |
| H9 — Documentación y release | Especificación clean-room y contrato de modelos CLI/headless en repo; hashes calculados localmente para fuente/pruebas. | PARCIAL · doc modelo inicial ampliada en rama; manual usuario, recuperación/rotación, manifiesto y release pendiente |
| H10 — Corte y aceptación | Merge/read-back en main; instalación controlada; verificación no reveladora de variables formales; retirada legacy tras rollback probado; aceptación humana. | PENDIENTE · no se modificó la bóveda formal, no se instaló la GUI nueva y la PR continúa sin fusionar |

### Criterios transversales de cierre

- La UI no se considera terminada por una captura: cada botón/acción debe completar una operación real, presentar el resultado correcto y manejar fallos sin perder ni exponer datos.
- Toda escritura formal debe ser atómica, autenticada, íntegra y verificada mediante lectura de vuelta. Una nota efímera solo se elimina después de confirmar la promoción.
- Un reemplazo exige confirmación explícita; el flujo debe distinguir alta, actualización, eliminación y cancelación.
- Los errores no pueden dejar la bóveda en un falso estado abierto ni mostrar valores protegidos en listados, logs o diagnósticos.
- La expiración debe probarse con reloj controlado/falso cuando sea posible, además de una comprobación real acotada.
- Los tests usan valores sintéticos y almacenes aislados; los secretos existentes no se usan como fixtures.
- Main recibe fuentes, documentación, pruebas y manifiestos sin secretos. El archivo de bóveda, sus respaldos y los valores reales quedan fuera de Git.
- Los hitos H2–H4 no pasan a construcción/cierre hasta que la compuerta P012/P013 sea satisfecha y registrada.

## Baseline heredado — evidencia reportada y límites

La sesión técnica previa dejó estos resultados, que se conservan como evidencia de antecedente; no sustituyen la revalidación en el nuevo diseño:

- Backend: self-test criptográfico reportado PASS (PBKDF2-HMAC-SHA256, AES-256-CBC, HMAC-SHA256, round-trip, rechazo de contraseña incorrecta y manipulación).
- Notas efímeras: creación/listado/lectura/eliminación sintética con DPAPI CurrentUser reportada PASS; valores no incluidos en el listado.
- CLI: captura/listado/lectura explícita/eliminación de una nota sintética reportada PASS.
- Promoción/reemplazo/eliminación en almacén sintético aislado reportados PASS después de corregir la selección explícita del nombre de variable en la rutina de eliminación.
- Parser PowerShell 5.1 de backend, GUI heredada y CLI reportado PASS.
- La GUI anterior fue modificada como puente de emergencia y se abrió en estado bloqueado. **No se completó una aceptación E2E autenticada por el operador.** Esa GUI no es candidata ni base de la nueva interfaz.
- No se creó commit de producto de la bóveda en main. El código local de AppData no se considera persistido en el repositorio.
- La instrucción del operador confirma dos variables formales guardadas; este ciclo no vuelve a leer sus valores ni presenta un read-back criptográfico independiente.

## Documentación de modelos

- [Contrato de acceso headless y CLI](./MODEL-CLI-HEADLESS.md).

## Registro de ejecución de la tarea

### Entrada inicial · 2026-11-08

- **Estado anterior:** no había EP-TASK específico para esta reconstrucción; el índice contenía EP-TASK-001 a 003.
- **Acción de este ciclo:** crear EP-TASK-004, preservar el dictado literal, normalizarlo por separado, establecer hitos H0–H10 y enlazar el núcleo desde el índice canónico.
- **Trabajo de producto/UI:** NO INICIADO. Bloqueado por P012/P013 para revisión presencial.
- **Secretos:** no leídos, no copiados y no incluidos en esta escritura. Solo se registran identificadores de variables.
- **Fuente base:** main `d732fe5bbcabbfcedbcdc6151a779cccef282086`; DUG v383 / NX-383m; OEP v0.3.40; índice provisional blob `1ef005e6ad965e869334cd65d6deaff121e59cc0`.
- **Siguiente acción independiente:** auditar el backend/CLI y las pruebas existentes en modo de solo lectura, identificando interfaces, defectos y brechas sin diseñar ni construir la UI ni acceder a valores de secretos.
- **Cierre H0:** persistido en main y verificado por lectura de vuelta exacta.
- **Sincronización local:** PC-13 hizo fast-forward desde `70ccea7` hasta `eb78d5a`; `HEAD` cotejado con `origin/main` y árbol limpio.
- **H1, auditoría parcial (2026-11-08):** backend 32,438 bytes, SHA-256 `649C53E0CDB9F8613C26F6CC58E6CC669714548A72DE100EE844C5C226634951`; CLI wrapper 1,731 bytes, SHA-256 `A1EFEA2B43AC2C223553FF0326986DFD56410C32E015C83BC177AE0D59D2D971`; documentación local previa 3,859 bytes. Backend/CLI pasan parser PowerShell; contrato estático confirma rutas para `RemoveVariable`, `PromoteNote`, `DeleteNote`, `ListNotes` y `ReadNote -Reveal`.
- **Pruebas de este ciclo:** backend self-test PASS con PBKDF2/AES-256-CBC/HMAC-SHA256, rechazo de contraseña incorrecta y tamper; prueba sintética aislada de promoción, reemplazo explícito y eliminación con lectura de vuelta PASS. La prueba usó una carpeta temporal independiente, eliminada en `finally`.
- **CLI smoke E2E (2026-11-08):** `CLI_LIST_METADATA_ONLY_PASS`; `CLI_READ_REQUIRES_EXPLICIT_REVEAL_PASS`; `CLI_REVEAL_SYNTHETIC_VALUE_PASS`; `CLI_DELETE_READBACK_PASS`. La prueba usó una nota DPAPI sintética en el directorio de trabajo habitual, no usó el portapapeles ni la bóveda formal y concluyó con `REAL_WORKING_NOTE_FILES_AFTER_TEST=0`.
- **Bóveda real:** archivo presente, 5,976 bytes según metadatos; no se descifró ni inspeccionó contenido. No había archivos de notas efímeras en la ruta de trabajo consultada. No se modificaron variables reales.
- **Incidencia de ejecución 1:** un intento de self-test desde la shell padre falló antes de ejecutar el backend porque la ExecutionPolicy del proceso bloqueaba scripts. Es una recurrencia de una causa ya observada. RCA: el wrapper omitió el preflight de política. Corrección: `Set-ExecutionPolicy -Scope Process Bypass -Force` antes de invocar los scripts, o proceso dedicado con `-ExecutionPolicy Bypass`; el self-test pasó después. Prevención: el preflight de ExecutionPolicy debe ser obligatorio antes de invocar `.ps1`; no repetir bajo la misma política.
- **Incidencia de ejecución 2:** un ensayo CLI con `%LOCALAPPDATA%` aislado creó un directorio temporal sintético, pero la limpieza intentó usar `%TEMP%` con la forma corta `C:\Users\PC12~1`, que PowerShell no resolvió en `Remove-Item`. Se enumeró la ruta larga real bajo `%LOCALAPPDATA%\Temp`, se verificó que solo contenía el archivo de nota sintética esperado y se eliminó el directorio completo; lectura de vuelta confirmó su ausencia. La prueba final se ejecutó con un único valor sintético en `working-notes` normal y eliminó la nota correctamente. No hubo valores reales ni archivos de bóveda afectados.
- **Alcance no verificado:** no se realizó autenticación real de la GUI; la GUI legacy no se reabrió ni se reutilizó. El test de captura CLI previo sigue atribuido a la prueba sintética reportada en la sesión anterior.
- **Estado de construcción:** ninguna UI nueva ni cambio de backend se ha construido ni publicado en main. Los archivos de código siguen en AppData; el commit 70ccea7 solo contiene el registro de la tarea.
- **Próxima acción:** cerrar auditoría estática de los flujos `Load/Lock`, almacenamiento DPAPI/ACL, TTL y salida del CLI; después esperar la compuerta presencial P012/P013 antes de decisiones de diseño o construcción.


## Hallazgos de auditoría técnica y límites abiertos · 2026-11-08

Esta sección separa observaciones directas de requisitos aún por resolver. No constituye aprobación de arquitectura ni autorización para iniciar construcción bloqueada por P012/P013.

### Hechos observados en el código actual

1. **Cryptografía formal:** PBKDF2-HMAC-SHA256 con 200,000 iteraciones deriva 64 bytes; 32 bytes se usan para AES-256-CBC/PKCS7 y 32 para HMAC-SHA256. El MAC se verifica antes del descifrado. El self-test cubre round-trip, contraseña incorrecta y manipulación.
2. **Escritura formal:** se escribe un temporal, se ejecuta `Flush()` y se usa `File.Replace` cuando el destino ya existe. `File.Replace` crea respaldos `.pre-<guid>.bak`. Se observaron tres respaldos cifrados y un archivo `.lock` de cero bytes. No se borraron ni se alteraron.
3. **ACL de la bóveda:** directorio formal con ACL protegida y ACE Allow para el usuario Windows actual y LocalSystem; no se observaron otras ACE Allow en la lectura de vuelta de este ciclo.
4. **ACL de notas:** directorio DPAPI de notas efímeras con ACL protegida y ACE Allow para usuario actual y LocalSystem. La implementación de inicialización de notas verifica que la ACL esté protegida, pero no vuelve a cotejar la lista exacta de identidades cuando el directorio ya existe; la ACL viva actual sí coincide con los dos principales esperados.
5. **Eventos:** el log `ep-env-vault-events.jsonl` está en `Desktop/EP/KHORA/OCP-MCP-EP-Vault/TRABAJO/DIAGNOSTICO`, fuera del directorio cifrado de variables. Se observaron 19,532 bytes, propietario `BUILTIN\Administradores` y `AreAccessRulesProtected=False`. No se leyó su contenido. El diseño nuevo debe decidir y probar su ubicación, ACL, retención y redacción; no se presume que el log actual sea seguro por el solo hecho de que el código pretende omitir valores.
6. **SecretString:** hay funciones que ponen la variable SecureString en `$null` pero no llaman explícitamente a `Dispose()` (incluidas rutas de Load/List/SetFromClipboard). La nueva implementación debe auditar el ciclo de vida y liberar explícitamente objetos descartables. Las cadenas .NET inmutables no admiten borrado garantizado; no afirmar zeroization absoluta.
7. **Carga headless:** `Load` carga todas las variables formales al entorno del proceso PowerShell invocador; los procesos hijos heredan esos valores. No modifica el entorno del sistema ni el de la shell padre. El wrapper actual no ofrece selección por nombre en `Load`.
8. **Duración CLI:** `Load` permanece abierto hasta `Lock` o terminación del proceso; la CLI no aplica todavía caducidad automática de sesión ni el selector 15 s–15 min solicitado.
9. **Captura CLI:** `Capture` depende del portapapeles de Windows; el wrapper no ofrece entrada por stdin/stream. Por tanto, la ruta es headless respecto de la GUI de la bóveda, pero no constituye captura totalmente independiente de la sesión de escritorio.
10. **Notas:** se protegen con DPAPI CurrentUser, TTL 1–240 minutos (default 30) y un identificador validado. La lista expone solo ID/fechas/estado; la lectura exige `-Reveal`. El backend verifica la lectura de vuelta de promoción antes de borrar la nota.
11. **Estado de host:** C: tenía BitLocker desactivado en la última evidencia operativa; la protección de la bóveda no demuestra cifrado de disco completo.

### Riesgos y decisiones pendientes para la revisión B/C

- Diseñar una política de backups cifrados: retención, restauración probada, límites de acumulación y eliminación autorizada de copias obsoletas.
- Incorporar el archivo de eventos al perímetro de seguridad correcto, validar ACL exacta, limitar retención y demostrar redacción de secretos mediante pruebas negativas.
- Revisar el ciclo de vida de SecureString y buffers sensibles; distinguir limpieza best-effort de eliminación garantizada.
- Definir least privilege para procesos headless: selección explícita de variables por nombre frente a la carga de todas las variables.
- Aplicar expiración automática de sesión al modo headless, con default 5 minutos y selector 15 s, 30 s, 1, 2, 3, 5, 10 y 15 minutos.
- Definir una vía de captura apta para operación headless que no dependa obligatoriamente del portapapeles y que no exponga valores en argumentos, historial o archivos temporales.
- Corregir y verificar el preflight de ACL de notas existentes para comparar los principales permitidos, no únicamente el bit de ACL protegida.

**Límite:** estos son hallazgos de auditoría de código y metadatos del host. No se cambiaron el backend, la GUI, el log, los backups, la ACL, las credenciales ni la bóveda formal.

## Revisión B/C, candado D y despacho A — aprobados · 2026-11-08

### Evidencia de revisión y autorización

- **Presencia del operador:** ante la pregunta directa de disponibilidad presencial, el operador respondió «Si» y, tras revisar la propuesta completa en este mismo ciclo, la aprobó expresamente con «Exacto. ... Si la apruebo». La presencia física se registra como **declarada por el operador**; esta conversación no dispone de un sensor ni de verificación técnica independiente de ubicación.
- **B/C (P012):** **APROBADO** por el operador después de revisar el alcance de UX/UI y seguridad. La aprobación cubre el concepto de bóveda física, la máquina de estados, la sesión temporal, el modelo de acceso headless, la separación entre GUI/CLI y el tratamiento de secretos descritos abajo.
- **D (P013):** **APROBADO** en cuanto a arquitectura de alto nivel: WPF local independiente, núcleo PowerShell 5.1 compartido por GUI y CLI/headless, operaciones locales sin servicio remoto ni telemetría externa, con prioridad a mínimo privilegio y compatibilidad.
- **A (P012):** **DESPACHADO** por la instrucción expresa del operador: «Documenta en tarea provisional del frente antes de iniciar, y a partir de ahí resuelve por hitos conforme las instrucciones». El despacho queda condicionado a la persistencia y lectura de vuelta de este registro; su alcance es EP-TASK-004 y sus hitos, no una autorización general para otros frentes.
- **Resultado de compuertas:** H2 queda completado documentalmente tras el registro y read-back; la construcción de H3/H4 queda habilitada dentro del alcance aprobado. No se declara implementado ningún componente por el solo hecho de aprobarlo.

### Decisiones vinculantes aprobadas

**1. Experiencia visual clean-room**

La aplicación se concibe como una bóveda física que permanece sellada hasta autenticar. El lenguaje visual aprobado es monumental, ominoso, elegante y sobrio: acero oscuro/ennegrecido, latón envejecido, mecanismo radial y luz interior contenida. La puerta circular y sus cerrojos deben tener una secuencia mecánica de apertura y cierre legible.

Estados obligatorios:
1. CERRADA — puerta y cerrojos sellados; sin datos expuestos.
2. AUTENTICANDO — contraseña solicitada localmente; el acceso sigue cerrado.
3. DESBLOQUEANDO — validación superada; secuencia mecánica real de apertura.
4. ABIERTA — cámara y compartimentos de variables disponibles; valores ocultos por defecto.
5. BLOQUEANDO — operación de cierre, revocación del acceso temporal y limpieza de vistas.
6. ERROR — no simular apertura; conservar el estado seguro/cerrado y comunicar un código comprensible sin revelar datos.

La prohibición de reutilización es absoluta para la interfaz anterior: no copiar, abrir como referencia, capturar, calcar, adaptar ni reutilizar píxeles, XAML, controles, layouts, estilos, recursos, imágenes, iconos, tipografías, colores o animaciones. La nueva presentación debe crearse en archivos independientes. La GUI antigua sigue clasificada LEGACY / NO REUTILIZAR; su eliminación física se difiere al corte H10, cuando exista sustituta probada y recuperación verificada.

**2. Arquitectura aprobada**

- GUI local WPF con XAML y recursos propios, independiente de la GUI anterior.
- Núcleo de dominio/seguridad en PowerShell compatible con Windows PowerShell 5.1.
- GUI y CLI/headless consumen el mismo contrato y las mismas operaciones del núcleo; no duplicar lógica criptográfica.
- El modo headless no requiere abrir la GUI, pero sí mantiene autenticación local segura para las operaciones que la requieren.
- No introducir un servicio remoto, endpoint de red ni telemetría externa.
- Mantener inicialmente el formato criptográfico formal existente por compatibilidad; endurecer sus controles. Cualquier cambio de formato requiere versión explícita, migración reproducible, respaldo y pruebas sintéticas de recuperación antes de tocar datos reales.

**3. Sesión temporal aprobada**

- Duración por defecto: **5 minutos** desde autenticación correcta.
- Opciones: **15 segundos, 30 segundos, 1 minuto, 2 minutos, 3 minutos, 5 minutos, 10 minutos y 15 minutos**.
- Expiración absoluta, no deslizante y no extendida por actividad.
- Aplicación uniforme en GUI y CLI/headless.
- Al vencer: cerrar/bloquear la bóveda, ocultar y limpiar vistas de datos, invalidar el contexto de sesión y detener el trabajo temporal administrado.
- No afirmar que una aplicación puede borrar de forma garantizada todas las copias de secretos ya heredadas por procesos hijos. El diseño debe limitar la herencia desde el inicio, gestionar el árbol de procesos que crea y declarar los límites de revocación de memoria/entorno.

**4. Acceso headless y mínimo privilegio aprobado**

- Reemplazar el Load indiscriminado de todas las variables por selección explícita de nombres autorizados para una operación.
- Ejecutar consumidores dentro de un contexto/proceso administrado y acotado; no dejar variables cargadas en una shell padre ni permitir procesos hijos desprendidos sin control.
- El vencimiento debe aplicarse también al flujo CLI/headless.
- La contraseña maestra nunca se recibe por argumentos, variables de entorno, archivos temporales ni conversación; el prompt seguro se atiende localmente.
- Reveal continúa siendo una acción explícita, excepcional y no registrable.
- Las listas y diagnósticos solo exponen nombres/metadatos; ningún valor se escribe en logs, trazas, transcripciones o Git.

**5. Persistencia y datos**

- main contiene fuentes, XAML nuevo, recursos originales, contratos, pruebas, documentación y manifiestos de integridad.
- main nunca contiene valores de variables, contraseña maestra, Application Keys, tokens, archivo cifrado formal, notas efímeras ni respaldos.
- Los dos nombres de variables existentes se mantienen como dato de inventario; no se leen, imprimen ni usan como fixtures.
- Todas las pruebas usan valores sintéticos y almacenes aislados. La bóveda formal no se modifica durante pruebas de diseño/regresión.
- No borrar respaldos existentes sin política explícita de retención/restauración y prueba de recuperación.

### Restricciones de ejecución que permanecen vigentes

- La asignación de roles del OEP §13 sigue vigente: Claudia = asistencia/documentación; Samantha = constructor y único escritor de código. Esta aprobación no cambia por sí sola esa asignación. El constructor no invoca RDC; RDC es exclusivo del asistente para acciones remotas acotadas.
- El control formal EP permanece owned, generación 1, con su alcance específico. Este registro no amplía permisos sobre credenciales, recursos/cuentas/objetos B2, cambios de otros frentes, enmiendas DUG/GOW/MCP, ni operaciones destructivas fuera de EP-TASK-004.
- No modificar DUG, GOW ni controles de responsabilidad por esta tarea.
- La aprobación del diseño no equivale a prueba, release, aceptación final ni a verificación de las dos variables reales.

### Replanificación de hitos tras la aprobación

| Hito | Estado actualizado |
|---|---|
| H0 — Captura canónica | COMPLETADO |
| H1 — Baseline técnico | PARCIAL · auditoría y remediaciones técnicas pendientes |
| H2 — Revisión B/C presencial | COMPLETADO · aprobación explícita registrada; presencia declarada |
| H3 — Diseño visual clean-room | DESPACHADO · construir exclusivamente desde cero |
| H4 — UI funcional | PENDIENTE · depende del diseño H3 y de integración real |
| H5 — Sesión temporal | ESPECIFICACIÓN APROBADA · implementación y pruebas GUI/CLI pendientes |
| H6 — CLI/headless | DOCUMENTACIÓN INICIAL EN MAIN · contrato mínimo privilegio/TTL aprobado; implementación y regresión pendientes |
| H7 — Seguridad e integridad | PENDIENTE · endurecimiento y auditoría |
| H8 — Matriz de regresión | PENDIENTE |
| H9 — Documentación y release | PARCIAL · documento de modelos existente; manual final y manifiestos pendientes |
| H10 — Corte y aceptación | PENDIENTE · requiere pruebas, recuperación y aceptación humana final |

### Registro de acciones posteriores a esta decisión

Este registro constituye la precondición documental solicitada por el operador. La escritura de este apartado en main y su lectura de vuelta deben completarse antes de iniciar cualquier construcción. Las acciones posteriores deberán añadirse por hito con: objetivo, fuente/base, archivos afectados, SHA-256, pruebas, resultado, incidencias/RCA y read-back. Ningún hito pasará a COMPLETADO por intención o por escritura documental solamente.




## Avance de implementación H3–H8 — revisión 2026-11-08

### Artefactos en rama

Rama de trabajo: `feat/ep-vault-clean-room-20261108`  
PR de integración: [#20 — bóveda clean-room](https://github.com/SeryMente/metodologia/pull/20) · ABIERTA · DRAFT · NO FUSIONADA.

| Archivo | Git blob SHA (rama) | SHA-256 local (PC-13) |
|---|---|---|
| `src/EP.Vault.Core.psm1` | `c3f5e3b389f635550b2bc0332f36b4a5b9b77969` | `A25E3561B2AC2C4AF464257BFFA8116BCCB70B3CF390FAEFF5B4D0926674BC8E` |
| `src/EP.Vault.CLI.ps1` | `484e4aa045d07788cb9ac091a67d10947877789d` | `6A1F14A48CED071E471092C213B73F9627E9A96A7C29059DD494581021E454B3` |
| `src/EP-Vault.GUI.ps1` | `d514092bbb306a8c6f6f330d3cec44dc3724633b` | `5B67337122F5AA3E409A824E92CE95BD48131A44A9549BB811AD06BCB06C056F` |
| `src/EP-Vault.Window.xaml` | `38cb4c9cf5b1fe120ba2485399b54ea28184fb8f` | `0C9161D12A67CF91547392F93C7E7643F13460C6EA1764EA36BDB806E811B634` |
| `tests/Test-EPVault.ps1` | `7dfc3dabe2331f9b0a1ddd0b984bf76833278c0c` | `3FCD711517FF94E29598C236D5813D96575E81E3B37F7A76FF9F8A6DF477885A` |

Los SHA-256 fueron calculados sobre los archivos exactos copiados a `%LOCALAPPDATA%\Temp\EPVaultValidation` en PC-13. Los Git blob SHA identifican su contenido en la rama. El archivo de preview y los perfiles de prueba son efímeros y no forman parte de la entrega.

### Evidencia de validación local

**Entorno:** PC-13, usuario `PC-13\PC 12`, Windows PowerShell `5.1.26100.9168`, .NET `4.0.30319.42000`. Toda la prueba se ejecutó en directorios temporales aislados y con contraseñas/valores sintéticos.

Resultado final de `tests/Test-EPVault.ps1`: `EP_VAULT_VALIDATION_PASS` · exit code `0`.

Comprobaciones con resultado PASS:
- Parser PowerShell para Core, CLI y GUI.
- Parseo WPF/XAML y contrato de nombres de controles.
- Escaneo de referencias visuales legacy: cero referencias encontradas.
- PBKDF2-SHA256, AES-256-CBC, HMAC-SHA256, round-trip, password incorrecta y tamper rechazado.
- Job Object: proceso suspendido → asignación → reanudación → exit code.
- Job Object: timeout termina el árbol administrado.
- Los ocho intervalos TTL: 15, 30, 60, 120, 180, 300, 600 y 900 segundos.
- Ejecución con allowlist: el consumidor recibe la variable solicitada y no hereda la variable arbitraria sintética del proceso padre.
- DPAPI CurrentUser: metadatos sin valor, Reveal explícito, eliminación y lectura de vuelta.
- CRUD sintético, integridad MAC, rechazo de alteración, backup atómico y TTL absoluto.
- Redacción del log: no aparecen los valores sintéticos.
- CLI wrapper: `Status` → `NOT_INITIALIZED`, exit code 0; `SelfTest` → PASS, exit code 0.

**Prueba visual WPF:** se renderizó la ventana sobre un perfil sintético, se inicializó una bóveda de prueba, se abrió mediante `Start-CleanRoomOpeningSequence`, se mostró el compartimento con `EP_PREVIEW_SYNTHETIC`, y se cerró mediante `Close-EpVaultUi`. La secuencia terminó en `SELLADA`; el callback de cierre se corrigió al detectar que usaba una variable local fuera de alcance. Las capturas no se incorporan al repositorio porque son evidencia temporal con fixture sintético, no assets de producto.

### Incidencias y límites abiertos

- Una ejecución inicial de GitHub Actions falló antes de asignar runner: `runner_id=0`, cero pasos ejecutados. No es un resultado de prueba de código ni un PASS de CI. El workflow remoto sigue sin validación; la evidencia actual es la ejecución local en PC-13.
- La UI legacy no se abrió ni se usó como referencia. Sigue LEGACY / NO REUTILIZAR y no se elimina hasta H10.
- No se abrió, autenticó, descifró ni modificó la bóveda formal. Los valores reales de variables no se leyeron, revelaron ni verificaron en este ciclo.
- No se ejecutó diagnóstico ni operación B2 y no se usaron claves B2.
- La sesión GUI con TTL forzado no se esperó hasta su vencimiento en el render; el vencimiento del núcleo está probado. Falta una prueba UI automatizada de expiración real.
- El perfil temporal de preview contiene exclusivamente datos sintéticos; no copiarlo al entorno formal ni a Git.
- La auditoría de ACL real, recuperación/restauración de backups, BitLocker del host, abuso de memoria, teclado/DPI y matriz de interacción completa siguen pendientes.
- La PR #20 sigue en draft y la rama está un commit detrás de main. Antes de merge hay que conciliar la divergencia, revisar diff completo, volver a ejecutar la suite sobre el head final y registrar read-back de main.

### Próximo orden de hitos

1. Cerrar H3 con pruebas de DPI, teclado, movimiento reducido y matriz de estados, conservando la regla clean-room.
2. Cerrar H4 con pruebas de cada acción GUI, incluidos clipboard en fixtures, reveal temporal, promoción y bloqueo ante error.
3. Cerrar H5 con prueba real de expiración GUI y CLI para cada intervalo o un plan de equivalencia verificable.
4. Completar H6 con smoke E2E del wrapper CLI en perfil sintético, incluida autenticación local sintética y `Run`.
5. Completar H7/H8: auditoría de seguridad, recuperación y regresión sin tocar la bóveda formal.
6. Conciliar main/PR, merge con SHA esperado, leer de vuelta contenido/commits y sincronizar el clon local.
7. Solo después, preparar instalación controlada y H10, protegiendo primero el acceso de recuperación y retirando la UI legacy al final.

## Incidente operativo — lanzamiento no autorizado de diagnóstico B2 · 2026-11-08

- **Hecho confirmado:** una llamada RDC del asistente `start_process` del 2026-11-08 a las 15:34:28 lanzó una ventana PowerShell separada con un diagnóstico de autorización Backblaze B2. El script solicitaba el identificador y la Master Application Key, y si recibía ambos podía invocar `b2_authorize_account` y posteriormente `b2_list_buckets`.
- **Desviación:** esa acción no pertenecía al alcance autorizado de EP-TASK-004 ni había sido solicitada en ese punto. Fue un error de alcance del asistente. La afirmación inicial de que no se había lanzado fue incorrecta y se rectificó tras consultar el historial RDC.
- **Contención:** el proceso exacto identificado por PID 2768 (creado a las 15:34:28 en PC-13) fue terminado mediante RDC. Una comprobación posterior confirmó que el PID ya no existía.
- **Evidencia local:** el archivo de resultado previsto `%TEMP%\khora-b2-auth-check.json` no estaba presente al comprobarlo después de la terminación. Por tanto no existe resultado persistido de autenticación; esta ausencia no prueba por sí sola que ninguna solicitud hubiese comenzado ni que no se hubiesen introducido credenciales.
- **Límites:** no se consultaron valores de credenciales desde el asistente, no se escribió ninguna credencial en Git, no se cambió configuración/credenciales/recursos B2 y no se ejecutó ninguna acción de escritura o borrado B2. El posible ingreso de credenciales por el operador queda **NO VERIFICADO**.
- **Acción preventiva:** detener cualquier diagnóstico B2 fuera de una instrucción explícita, nunca solicitar ni manipular la Master Application Key sin alcance específico aprobado, y mantener las tareas de bóveda/EP separadas de pruebas de autorización de cuentas externas.
- **Estado:** incidente contenido a nivel de proceso; impacto de autenticación B2 **NO DETERMINADO** hasta confirmar si el operador introdujo la clave antes de la terminación.
