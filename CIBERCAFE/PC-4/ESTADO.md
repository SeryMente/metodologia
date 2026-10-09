# Estado Persistente de Desempeño - PC-4

**Estado:** ACTIVO · memoria persistente de terminal  
**Ubicación:** CIBERCAFE  
**Unidad:** PC-4  
**Última actualización:** 2026-10-09

## Identidad de terminal

- Identidad persistente de desempeño: CIBERCAFE + PC-4.
- Hostname observado por DNS y Win32_ComputerSystem.Name: PC-4.
- Usuario de proceso observado: PC 4.
- RDC observado en esta sesión: blacksheepsup@gmail.com + ad151d48-3bd6-44a8-9b61-b0d0291643eb.
- Dispositivo RDC visible: PC-4.
- Último ping verificado: 2026-10-09T01:16:35.344Z.
- Nota de entorno: COMPUTERNAME apareció vacío dentro de un proceso RDC de PowerShell; usar también [System.Net.Dns]::GetHostName() y Win32_ComputerSystem.Name.
- El device_id RDC identifica el canal de sesión y no sustituye la identidad persistente CIBERCAFE + PC-4.

## Huella de hardware observada

| Recurso | Estado observado |
|---|---|
| Placa base | Gigabyte Technology Co., Ltd. A520M K V2 |
| CPU | AMD Ryzen 5 4600G with Radeon Graphics; 6 núcleos, 12 hilos |
| GPU física reportada | AMD Radeon(TM) Graphics; driver 31.0.14046.0 |
| Adaptadores adicionales | mv video hook driver2 (6.0.1.0) y AnyViewerIddDriver Device (16.20.27.108), identificados como adaptadores de hook/virtualización/remoto; no atribuirlos como GPU física |
| RAM instalada | 32 GB reportados por WMI; 31.37 GB visibles por el sistema |
| RAM configurada | Kingston KF3200C16D4/32GX; 3200 MHz reportados por WMI |
| Sistema operativo | Windows 11 Pro; build 26200; 64 bits |
| BIOS | FE, según Win32_BIOS |
| Unidad C: | 476 GB de tamaño lógico; 363.81 GB libres al medir (aprox. 76.4% libre) |

La consulta no midió carga sostenida de CPU/GPU, temperaturas, latencia ni rendimiento de disco. No inventar una baseline de desempeño para esos indicadores; medirlos en un ciclo posterior solo si la tarea lo requiere.

## Software y servicios observados

| Componente | Resultado observado |
|---|---|
| Node.js | v24.20.0 |
| npm | 11.19.0 |
| Git | 2.55.0.windows.5, instalado por winget usando la fuente winget y validado con git --version |
| GitHub CLI (gh) | No instalado en la revisión; no necesario para clonar repositorios públicos |
| Vercel CLI | No encontrado; no instalar hasta que el objetivo la requiera |
| OBS Studio | 32.2.2 observado en la ventana/proceso |
| Chrome | 155.0.8059.40 observado durante la sesión |
| Remote Desktop Commander | Proceso remoto en ejecución; identidad verificada mediante ping |

## Cambios y validaciones comprobadas

### 2026-10-09 — OBS Virtual Camera

- El log de OBS contiene “Virtual output started” y “Starting Virtual Camera output to Program”.
- Una prueba local desde Chrome obtuvo una pista de video cuyo label fue OBS Virtual Camera.
- Resultado de captura: 1280 × 720, aproximadamente 30 FPS.
- La política temporal de permiso para localhost se eliminó del Registro y el servidor Node de prueba se detuvo.
- Alcance: se demostró disponibilidad de la cámara para la prueba local. Esto no concede permisos a todos los sitios ni demuestra que Chrome haya persistido OBS como selección predeterminada.

### 2026-10-09 — Git y repositorio de Metodología

- Git no existía en PATH ni en las rutas estándar revisadas.
- Instalación verificada con winget usando --source winget y los acuerdos explícitos de winget.
- El repositorio público https://github.com/SeryMente/metodologia quedó clonado en C:\Users\PC 4\Desktop\metodologia.
- Verificación al finalizar el clon: origin correcto, rama main, HEAD 2815b439fde33d3fdc46ef80e47b2f93f5d97eef y working tree limpio.
- La verificación inicial tuvo un error de sintaxis independiente del clon (Out-String.Trim no es un cmdlet). Una comprobación posterior válida confirmó el clon; no repetir esa expresión.

### 2026-10-09 — Bootstrap CLI integral anclado

- Script canónico: `scripts/bootstrap-cibercafe-cli.ps1`.
- Commit inmutable del script validado: `14756d289f1ddc4c74c6736f5aa021121158541c`.
- SHA-256 verificado del artefacto descargado: `19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154`.
- Prueba de preparación ejecutada con Windows PowerShell 5.1: Git y Node/npm verificados, `Desktop\metodologia` actualizado sin cambios locales, SI/Metodología reconocidos, `PREPARE_ONLY=True`, salida 0.
- Con `-StartOBSVirtualCamera`, la prueba detectó la cámara ya activa y no abrió otra instancia.
- No se lanzó otro handshake RDC durante esta prueba para evitar crear una identidad duplicada; el comando final deja RDC en primer plano para el handshake normal.
- No usar raw `main` como fuente ejecutable del bootstrap: se observó que podía entregar una versión anterior. Descargar el commit fijado y verificar SHA-256 primero.

## Lecciones operativas de esta terminal

1. Para Remote Desktop Commander, PowerShell resolvió npx a npx.ps1 y la política de scripts bloqueó su ejecución. Usar npx.cmd @wonderwhy-er/desktop-commander@latest remote.
2. Los comandos de winget deben especificar --source winget para no activar por accidente la fuente msstore ni quedar detenidos en una solicitud de acuerdos.
3. PowerShell 5.1 con ErrorActionPreference = Stop puede convertir stderr de un ejecutable nativo en NativeCommandError. Capturar salida y verificar LASTEXITCODE de forma aislada.
4. Git y gh son dependencias diferentes. Verificar git.exe antes de operaciones Git o gh auth setup-git.
5. No declarar una cámara funcional solamente por el proceso OBS. Usar log y prueba de captura de extremo a extremo.
6. La edición manual de claves de Chrome Preferences no persistió la ranking/default camera usada en este intento. No repetir escrituras no verificadas; validar por comportamiento observable.
7. Ejecutar solo por CLI en la terminal. No automatizar ventanas, clics ni controles gráficos.

## Perfil operativo CIBERCAFE

- PRESUPUESTO-REINICIO = 0.
- No reiniciar, apagar, resetear ni programar reinicios.
- No ejecutar BIOS/UEFI, firmware ni reparaciones offline que dependan de reinicio.
- Conservar eventos significativos y resultados verificados; no guardar cada muestra de telemetría en GitHub.
