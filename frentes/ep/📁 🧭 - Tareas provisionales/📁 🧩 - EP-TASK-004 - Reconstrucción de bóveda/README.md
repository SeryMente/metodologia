# EP-TASK-004 — Reconstrucción integral de la bóveda EP

**Estado provisional:** `pendiente` · **Frente:** Entorno Persistente (EP) · **OCP padre:** `frentes/ep/OEP.md`  
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
| H2 — Revisión B/C presencial | El operador revisa y decide en persona la dirección UX/UI, experiencia de apertura, seguridad y arquitectura de alto nivel. Registrar resultado y evidencia en el mismo núcleo. | BLOQUEA CONSTRUCCIÓN |
| H3 — Diseño visual clean-room | Concepto visual y prototipo completamente nuevos; ninguna referencia/pieza de la UI antigua; estados cerrado, autenticando, desbloqueando, abierto, bloqueando y error definidos y revisados. | BLOQUEADO POR H2 |
| H4 — UI funcional | La bóveda abre/cierra realmente; navegación, listado, alta, edición, eliminación, promoción, revelación y estados de error están conectados a operaciones reales y verificables; no hay controles decorativos. | BLOQUEADO POR H2/H3 |
| H5 — Sesión temporal | Selector con 15 s, 30 s, 1, 2, 3, 5, 10 y 15 min; predeterminado 5 min desde autenticación correcta; expiración bloquea, limpia vistas y descarta material sensible en memoria. Probar cada intervalo sin afectar la bóveda real. | PENDIENTE |
| H6 — CLI/headless | Documentación de comandos, parámetros, códigos de salida, autenticación, permisos, errores, redacción y contrato para modelos; operaciones esenciales funcionan sin GUI. `-Reveal` es explícito; las salidas sensibles no se registran. | DOC EN MAIN + SMOKE CLI SINTÉTICO PASS; integración/regresión final pendientes |
| H7 — Seguridad e integridad | Pruebas positivas y negativas de contraseña incorrecta, manipulación, integridad MAC, atomicidad, DPAPI/ACL, TTL, aislamiento por usuario, promoción, reemplazo explícito, eliminación y lectura de vuelta. | PENDIENTE |
| H8 — Matriz de regresión | PowerShell 5.1, parser, CLI E2E sintético, pruebas de backend, ciclo GUI, bloqueo/expiración, restauración y preservación de variables; pruebas visuales y de interacción en tamaños/DPI representativos. | PENDIENTE |
| H9 — Documentación y release | Manual de usuario, manual de modelos/CLI, inventario de variables por nombre, guía de recuperación/rotación, manifiesto SHA-256, escaneo de secretos y lectura de vuelta del contenido publicado en main. | PENDIENTE |
| H10 — Corte y aceptación | Nueva UI activa; antigua UI retirada sin perder acceso; dos variables formales preservadas y verificadas sin mostrar valores; árbol limpio; commit y read-back en main; aceptación humana final. | PENDIENTE |

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
