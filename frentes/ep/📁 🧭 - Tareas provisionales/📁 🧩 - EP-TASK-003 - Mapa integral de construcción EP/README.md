# EP-TASK-003 · Materialización del workspace y dead-man trigger fuera de CECEQ

**Naturaleza:** tarea provisional del frente EP; sin titularidad, control, sesión ni folio propios.  
**Estado:** `en_curso` — alcance delimitado; implementación del disparador pendiente.  
**Responsabilidad:** frente EP.  
**OEP padre:** [OEP](../../OEP.md), especialmente §106.

## Alcance

1. Materializar la carpeta `Ser y Mente` en el Escritorio efectivo de la sesión Windows, con los repositorios actuales de la organización SeryMente.
2. En los repositorios que sean extensiones de Chrome, mantener la carpeta cargable `extension/` sincronizada con el commit fuente.
3. Cifrar el workspace completo con BitLocker en todas las ubicaciones. Se usa la misma contraseña maestra de la bóveda canónica de variables de entorno.
4. En **CECEQ**, conservar el workspace cifrado al cierre; no aplicar volatilización automática.
5. En ubicaciones **distintas de CECEQ**, implementar exclusivamente un dead-man trigger ligado a la terminación del proceso que mantiene abierta la sesión EP. Al dispararse: bloquear BitLocker, desmontar el volumen y eliminar únicamente el contenedor/carpeta de trabajo EP.

## Diseño histórico revisado: solo el disparador

Fuentes consultadas en KHORA, commit histórico `1db42a7fac9f154ac1afbeffc23ff06ea07b1384`:

- [OEP §28–§30](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/OEP.md): pérdida de control autorizado como condición para volatilizar la instancia local.
- [10-guardian.ps1](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/scripts/khora/modules/10-guardian.ps1): se retiene únicamente el evento de terminación del proceso de control. El resto de señales de ese módulo no se incorpora.
- [11-cleanup.ps1](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/scripts/khora/modules/11-cleanup.ps1): se toma solo como referencia histórica para bloquear/desmontar antes de retirar el contenedor. No se porta su flujo amplio.

## Exclusiones expresas

No implementar ni incluir en el backlog de esta versión: Guardian como subsistema; vigilancia anti-exfiltración; monitoreo de procesos, archivos, red o actividad; heartbeat; polling/sondeo; temporizador de inactividad; cierre de VS Code o de cualquier IDE; tareas programadas, AtStartup, telemetría o vigilancia en segundo plano.

## Estado de ejecución

La actualización documental está publicada. El dead-man trigger todavía no está codificado ni activado. Esta actualización no modificó scripts, tareas de Windows, volúmenes ni perfiles locales.

