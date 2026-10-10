# Especificación canónica EP: Cybernet, RDC, WP-LAB y OGP-Visual

**Estado:** especificación consolidada; ejecución física y certificación pendientes de evidencia.
**Versión del objeto:** v1.1.9
**Nombre de versión:** Diagnóstico Reproducible de CI y Corrección Publicada de KHORA
**Corte:** 2026-10-09.
**Fuente transversal:** SeryMente/metodologia.
**SI vigente leído con H1 → SI@H1 → H2:** v1.6.21 — Ordenamiento por Preponderancia y Categorías.
**Frescura comprobada antes de esta actualización:** H1 = H2 = 5b6814a6164d33344448889b0485e631686fef87; blob SI 89ebe84df49300662f996b85130cbcb893b568e0; versión/nombre verificados leyendo la cabecera actual de `SI-METACOGNITIVO.md` (`v1.6.21 — Ordenamiento por Preponderancia y Categorías`).
**Objeto relacionado:** [consolidación EP-WP-LAB](ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md).

## 1. Propósito y autoridad

Este documento reúne las especificaciones transversales de Entorno Persistente (EP) para sesiones efímeras de Cybernet, Remote Desktop Commander (RDC), repositorios y taxonomía de extensiones, OBS Virtual Camera, telemetría por terminal, WordPress local EP-WP-LAB y capacidad de generación/edición visual local para Otro Gran Programa (OGP).

Metodología es el registro transversal de requisitos, decisiones, contratos, evidencias, bloqueos y secuencia. Por ser público, no almacena secretos, credenciales, datos privados de clientes, bases de datos, snapshots completos, temas propietarios ni pesos de modelos. Los repositorios de implementación pueden especificar los detalles propios de código, pero deben remitir a este objeto y evitar autoridades documentales en competencia. Antes de modificar, volver a leer el SI y las fuentes desde la versión/commit actual de main. Las anclas aquí registradas describen este corte, no reemplazan una nueva adquisición normativa.

Este objeto consolida especificaciones y analiza artefactos; no certifica que la infraestructura física esté instalada o funcionando.

## 2. Identidad formal y modelo de volatilidad

El usuario declara que las terminales de Cybernet, cibercafé de la calle Luis Pasteur, operan con un mecanismo estilo Deep Freeze. Al reiniciar o iniciar una nueva sesión, los archivos de trabajo de la sesión actual se borran por defecto. Se registra como premisa de diseño declarada por el usuario, no como medición independiente en cada PC.

Separar en código, logs, estado y contexto:

1. Ubicación declarada: Cybernet, cibercafé de la calle Luis Pasteur.
2. Terminal física lógica: CIBERCAFE + PC-N, por ejemplo PC-7, PC-4 u otra terminal individual. Cada computadora tiene su identidad y memoria por separado.
3. Identidad de conexión RDC: cuenta, RDC-DEVICE-ID, nombre y estado observado por el proveedor. Cambian con una sesión/conexión y no sustituyen la identidad persistente de terminal.
4. Sesión de Windows: perfil, procesos, PATH y archivos locales temporales.
5. Conversación: origen de la solicitud, no identidad del host.
6. Raíz efímera de ejecución: directorio de trabajo de esta sesión.
7. Almacenamiento duradero: repositorio canónico, volumen/VHDX demostrado o servicio privado autorizado y probado.
8. Capacidad certificada: hardware, runtimes, artefactos, workflows y pruebas ligados a una terminal específica.

El Escritorio, Descargas, el perfil de usuario y los procesos se presumen volátiles por defecto. La existencia de una carpeta llamada Entorno Persistente no demuestra persistencia, junction, VHDX ni cifrado. No registrar como activo canónico una ruta efímera de una sesión. Una ausencia local tras Deep Freeze tampoco demuestra pérdida si aún no se han comprobado fuentes canónicas y almacenes duraderos.

Una etiqueta PC-N, hostname, IP, gateway o ID RDC por sí solos no constituyen atestación criptográfica de ubicación. Diferenciar siempre declaración del usuario, observación técnica y verificación independiente. Resolver en vivo la terminal y la sesión objetivo; nunca heredar ciegamente una identidad de otra conversación. Si ubicación, identidad o conectividad son indeterminadas, bloquear solo las operaciones que dependen de ellas y documentar la razón.

**Regla invariable:** PRESUPUESTO-REINICIO = 0. No reiniciar, apagar ni programar reinicio en las terminales Cybernet. Toda acción que requiere reinicio se registra BLOQUEADA-REINICIO.

## 3. Especificación de RDC

### 3.1 Propósito y secuencia

Cada sesión efímera en Cybernet necesita levantar de nuevo RDC. RDC se ejecuta al final de la preparación local y permanece en primer plano en la consola principal. La consola hija del observador de eventos/desempeño debe estar separada.

El comando estándar reflejado por el hilo histórico es:

    npx.cmd @wonderwhy-er/desktop-commander@latest remote

En PowerShell, usar npx.cmd o una ruta de ejecutable validada, no npx.ps1 si la Execution Policy impide scripts. La versión actual del script canónico tiene precedencia sobre comandos históricos aislados. Mantener un único bootstrap que coordine los pasos; no construir uno paralelo que duplique autenticación, clonado, cámara u observador.

### 3.2 Preflight

Antes de iniciar RDC:
- Obtener SI y contexto actuales; crear RunId y registro de eventos de la sesión.
- Resolver nombre de terminal con DNS y Win32_ComputerSystem además de la etiqueta declarada; no depender solo de COMPUTERNAME.
- Resolver Git, GitHub CLI y Node/npx.cmd; refrescar PATH tras instalar dependencias.
- Verificar autenticación de GitHub CLI y acceso a todos los repositorios privados/públicos requeridos antes de actualizar clones.
- Comprobar repositorios existentes, origin exacto, rama main, estado de árbol y HEAD antes de cualquier pull/copia.
- No guardar tokens, contraseñas, códigos de autorización, cookies ni credenciales en logs, portapapeles o repositorios.
- No abrir Chrome para completar la autenticación del bootstrap ni alterar políticas/perfiles; cualquier autorización de dispositivo que exija interacción del usuario queda explícita.
- Cuando falla un gate, parar antes de los pasos dependientes, preservar el estado actual y registrar el diagnóstico. No simular éxito por el solo hecho de iniciar un proceso.

### 3.3 Estados de RDC que no deben confundirse

Verificar por separado:
1. Cliente iniciado.
2. Cliente conectado al Desktop Commander local.
3. Conexión al servicio remoto establecida.
4. Device flow/autorización de usuario completado si el proveedor lo solicita.
5. Canal suscrito.
6. Dispositivo marcado Online.
7. Nombre e ID de dispositivo devueltos por el proveedor.
8. Coincidencia reconciliada con la terminal y la cuenta esperadas.
9. Estado en vivo de la conexión, mediante lista/ping u otra prueba soportada.
10. Ficha de sesión generada con datos de esta ejecución.

Un proceso activo no demuestra los estados 3–10. Si el proceso sale, el dispositivo no figura Online, el ID no puede recuperarse o la identidad no se puede reconciliar, registrar FAILED/BLOCKED/NOT VERIFIED en el paso exacto.

### 3.4 Ficha RDC en el portapapeles

Después de comprobar el handshake, copiar una ficha de texto con:
- proveedor RDC;
- terminal lógica CIBERCAFE + PC-N, y si fue declarada u observada;
- nombre y RDC-DEVICE-ID recién devueltos;
- cuenta RDC solo cuando sea necesaria y con minimización de datos;
- status y timestamp de verificación;
- RunId, versión/commit/hash del bootstrap;
- estado del observador y de sincronización del log.

La ficha se construye a partir de valores vivos de esta ejecución, no a partir de una sesión anterior. No incluir códigos de verificación temporales ni credenciales. El portapapeles facilita compartir el contexto con otros hilos, pero no es evidencia de persistencia ni certificación de hardware.

### 3.5 Cierre

RDC queda como última operación interactiva, en primer plano. No finalizarla para cerrar el observador. No depender de un evento de cierre para sincronizar todo, porque Deep Freeze o un fallo pueden suprimir el cierre ordenado. La persistencia necesita checkpoints periódicos e incrementales.

## 4. Bootstrap y repositorios

### 4.1 Secuencia general

Un solo bootstrap, idempotente, verificable y compatible con Windows PowerShell 5.1 donde corresponda:
1. SI fresco H1 → SI@H1 → H2.
2. Resolver tarea, terminal, sesión, conectividad y almacenamiento.
3. Crear RunId, log y raíz efímera de esta sesión.
4. Clasificar EP_VOLATIL o EP_CIFRADO solo después de comprobar target/junction, volumen/VHDX y BitLocker.
5. Verificar dependencias y autenticación de GitHub.
6. Confirmar acceso a cada repositorio antes de tocar clones.
7. Sincronizar repositorios con comprobaciones de origin/rama/estado y postchecks.
8. Exportar extensiones a una raíz con manifest.json solo cuando marcador e integridad autorizan reemplazo.
9. Preparar telemetría y observador en sesión hija con terminal y ruta explícitas.
10. Preparar OBS Virtual Camera si es aplicable y permitido por los privilegios disponibles.
11. Registrar verificación por componente y bloqueos.
12. Iniciar RDC como paso interactivo final y copiar su ficha solo tras validación viva.

Los modelos de IA y otras dependencias de varios gigabytes nunca deben bloquear el bootstrap útil ni iniciarse minutos antes de abandonar una sesión efímera.

### 4.2 Repositorios y taxonomía esperada

Repositorios recogidos en el contexto:
- SeryMente/metodologia: fuente pública transversal de especificaciones y continuidad no sensible.
- SeryMente/otrogranprograma: Otro Gran Programa (OGP).
- SeryMente/GDP: Gestor de Procesos.
- SeryMente/signal-interpreter: código fuente completo de Signal Interpreter.
- SeryMente/khora: KHORA. El usuario corrigió explícitamente “Cora” a “KHORA”.
- El checkout fuente y la extensión exportada deben estar separados cuando la arquitectura así lo exige.

Estructura lógica esperada en la raíz de trabajo de la sesión:
- metodologia: checkout Git de Metodología.
- otro-gran-programa: checkout de OGP.
- gestor-de-procesos: extensión consumible con manifest.json en la raíz, alimentada desde su repositorio fuente.
- signal-interpreter-source: checkout Git completo de Signal Interpreter.
- signal-interpreter: exportación de extension/ con manifest.json en la raíz.
- khora: checkout Git de KHORA.

Los nombres finales de carpetas deben seguir el bootstrap actual y no crear un segundo workspace. Validar los repositorios reales, sus ramas y manifiestos; no inventar URL, renombrar arbitrariamente ni meter la extensión bajo una carpeta extra que impida a la aplicación encontrar el manifiesto.

### 4.3 Seguridad de sincronización

Antes de operar sobre clon existente: verificar .git, origin exacto, rama main, git status y HEAD. Si el árbol está sucio, origin no coincide, la rama no es main o la consulta falla, conservar el directorio y registrar el bloqueo. No aplicar git reset --hard, git clean ni borrados recursivos de un árbol desconocido. Usar pull fast-forward solo con árbol limpio y origen correcto. Verificar commit final tras cada sincronización.

Para exportaciones generadas, preservar destinos sin marcador o con archivos modificados. Antes de regenerarlas, verificar hashes, confirmar propiedad del export y usar un staging/rollback. La carpeta Entorno Persistente de cada sesión es volátil; no describirla como fuente canónica ni como almacenamiento duradero.

## 5. OBS Virtual Camera y navegador

El historial leído reporta un intento que instaló Node.js 24.20.0 y OBS Studio 32.2.2 desde winget, pero falló al verificar el arranque de la cámara virtual con OBS_VIRTUAL_CAMERA_DID_NOT_START. El resultado histórico es fallo de activación, no prueba del estado actual de OBS.

El script auxiliar obs-chrome-camera-fix.ps1 puede localizar/instalar OBS, iniciar Virtual Camera según el log reciente y abrir la configuración de privacidad de cámara de Windows. Sin embargo, el requisito explícito más reciente del hilo de arranque dice: “Prohibido para el comando trabajar con chrome, todo es por terminal”. Por ello, el bootstrap canónico no debe abrir, cerrar, inspeccionar ni modificar Chrome, editar Preferences/Local State, añadir políticas, cambiar permisos o terminar procesos del navegador automáticamente.

Separar estados:
- OBS instalado/encontrado;
- proceso OBS vivo;
- dispositivo PnP de OBS visible;
- salida Virtual Camera confirmada en log reciente;
- fuente de vídeo configurada y mostrando imagen;
- aplicación destino detecta y puede utilizar la cámara de forma autorizada.

Un dispositivo PnP no prueba vídeo útil; proceso iniciado no prueba camera start; log de start no prueba fuente con imagen. Si requiere elevación y no se concede, registrar PENDIENTE_ADMIN, no forzar políticas o reinicios.

Se admite cámara virtual para producción audiovisual o pruebas de AV permitidas. No canonizarla como método para suplantar a otra persona o eludir verificación de identidad/presencia o controles de acceso de una plataforma. No presentar la detección en Chrome como automática o certificada.

## 6. Agente de desempeño, observador y eventos

Separación obligatoria:
- **Agente:** obtiene métricas, evalúa oportunidades, aplica solo cambios permitidos, valida resultados, revierte regresiones y escribe eventos.
- **Observador:** lee el registro y lo presenta en una ventana hija dedicada; no crea un segundo optimizador.

El bootstrap debe crear primero la raíz efímera y configurar identidad y log; luego pasar path e identidad explícitamente al observador. No deducir rutas. Prevenir procesos duplicados y procesos huérfanos. La telemetría local debe ser ligera, con muestreo de referencia cada 5–10 segundos cuando sea útil; no llamar RDC por cada muestra local.

Registro por ejecución: RunId, timestamp con zona horaria, terminal, ID RDC una vez verificado, paso, severidad, duración, versiones/SHAs, métricas y antigüedad, acción y motivo, validación posterior, reversión, error, estado de agente/observador y checkpoint de sincronización. Distinguir 0, no disponible, no compatible y obsoleto. No registrar secretos ni datos de clientes.

La memoria duradera por terminal conserva baselines, hardware conocido, cambios/reversiones, errores, oportunidades pendientes y fecha de última validación. El log local dentro de la sesión es solo diagnóstico temporal. Los eventos semánticos críticos deben sincronizarse por lotes a almacenamiento privado aprobado. Deadman solo puede retirar una copia local después de que el estado remoto duradero haya sido confirmado; no borrar registros remotos confirmados ni depender solo de un flush final.

## 7. Secuencia de carga de EP por utilidad y coste

| Prioridad | Capa | Criterio |
|---|---|---|
| P0 | Contexto y gobierno | SI fresco, especificación EP actual y tarea entendida. |
| P1 | Identidad/terminal/RDC | Sesión y terminal reconciliadas en vivo. |
| P2 | Herramientas esenciales | Git, gh, Node/npx.cmd, autenticación y acceso a repositorios verificados. |
| P3 | Workspace básico | Checkouts/exports y taxonomía correcta; log y observador separados; permitir trabajar cuanto antes. |
| P4 | Estado duradero | Target físico/privado verificado; checkpoints y recuperación. Si no, EP_VOLATIL. |
| P5 | WP-LAB | Inventariar y proteger el sitio local, DB/media, versión de Studio/WP/PHP/tema; staging y rollback. |
| P6 | Preflight IA sin pesos | Terminal autorizada, GPU, driver, VRAM, runtime, espacio, licencias y destino persistente. |
| P7 | Runtime/pesos grandes | Descargar solo componentes ausentes o dañados, con versiones/licencias/hash validados, desde fuentes fiables y hacia caché duradera. |
| P8 | Certificación IA | Prueba real CUDA, backend, modelos, workflows, generación y edición; rechazo de host no elegible. |
| P9 | Integración OGP | Una imagen maestra de aceptación, trazabilidad y evaluación antes de integrar en OGP. |

P0–P3 son prioritarios y deben ser rápidos. Descargas grandes no deben comenzar si el usuario se va a desconectar, si EP es volátil, si no hay almacenamiento duradero o si la compatibilidad y licencias no están resueltas. Instalar el runtime/modelo una vez en un almacén seguro evita repetir descarga en cada sesión, pero solo cuando se demuestra que esa ubicación sobrevive a Deep Freeze.

## 8. EP-WP-LAB y Divi

Se documentó históricamente un laboratorio WordPress Studio 1.23.0, WordPress 6.4.13, PHP 8.2, Divi 4.24.0 y localhost:8881 en un perfil PC-7. Son referencias históricas que deben revalidarse en la sesión actual; no implican que la carpeta exista hoy.

La versión solicitada ahora por el usuario para la siguiente sesión es **divi-theme_4.23.1.zip**, reportada en Descargas, proveniente —según el usuario— de Internet Archive. En este ciclo no se inspeccionó el ZIP ni se verificó la ruta, el contenido, la versión real, procedencia o hash. Esta referencia actual reemplaza la selección de versión histórica para el próximo intento, sujeto a verificación.

Al volver a tener el archivo:
1. Resolver su ruta real en la sesión activa; no registrar Descargas como persistente.
2. Validar que es ZIP, inspeccionar su contenido, versión real y calcular SHA-256.
3. Verificar procedencia y autorización/licencia de la copia. La llave de activación declarada por el usuario no prueba por sí sola autenticidad del ZIP ni activación válida.
4. Nunca publicar tema, archivos propietarios, clave o credenciales en el repositorio público.
5. Conservar el sitio original; crear staging, respaldo completo verificable y rollback.
6. Reemplazar tema activo solo tras verificar versión, integridad, licencia y funcionamiento en staging.
7. Si falta Divi, bloquear solo las pruebas que dependen de él y continuar las tareas independientes.

La integración en almacenamiento duradero evita re-descargar una copia autorizada, pero no elimina copyright ni transforma el producto en software libre.

### Bootstrap de WordPress: bloqueo preventivo

El bootstrap revisado previamente NO debe ejecutarse hasta corregirse: puede usar git reset --hard origin/main; eliminar sym-lab-source antes de verificar replacement; borrar themes/Divi antes de tener un reemplazo íntegro; caer a una reconstrucción titulada Cloud Lab Reconstruction con raíz /opt/serymente, no probada compatible con Studio local; mantener una ruta duplicada/inconsistente para el módulo Blog; y no generar/validar backup completo antes de sobrescribir.

Corregir en staging, con árbol limpio/origin/commit, backup, hashes, rutas de plugins reconciliadas, manifiesto real y rollback. Nunca restaurar automáticamente encima de un sitio funcional. Revalidar en host la página principal, /psicologos/, /blog/, /comenzar/ y /para-terapeutas-psicologos/. Los HTTP 200 históricos no valen como prueba actual.

## 9. Infraestructura visual de IA local OGP

### 9.1 Candidatos iniciales

- Orquestación: ComfyUI local para Windows, controlable por API.
- Backend candidato: Nunchaku y sus nodos personalizados.
- Generación candidata: Z-Image-Turbo cuantizado FP4, incluyendo el candidato svdq-fp4_r128-z-image-turbo.safetensors solo si pasa compatibilidad.
- Edición candidata: Qwen-Image-Edit-2509 o variante compatible certificada.

Ninguna versión/modelo se considera certificada por aparecer en el prompt. Un intento anterior en PC-7 informó RTX 5060 con aproximadamente 8 GiB VRAM, Ryzen 5 5600X, 32 GiB RAM, compute capability 12.0 y driver 610.47; son datos históricos, no inventario actual ni datos extrapolables a otras terminales. El intento falló durante la instalación/reparación de PyTorch/Nunchaku y la descarga del modelo quedó no certificada.

Fijar versiones y hashes del SO/runtimes, Python embebido, PyTorch/CUDA, driver, GPU compute capability, ComfyUI, Nunchaku, nodos, modelos, encoders, VAE y workflows. Verificar las licencias vigentes de cada pieza por separado. Las fuentes candidatas para revalidar son:
- https://github.com/Comfy-Org/ComfyUI
- https://huggingface.co/nunchaku-ai/nunchaku-z-image-turbo
- https://huggingface.co/nunchaku-ai/nunchaku-qwen-image-edit-2509

### 9.2 Gate fail-closed

Antes de iniciar inferencia, validar contexto canónico, terminal y conexión RDC en vivo, nivel de atestación del lugar, sistema operativo, CPU/RAM/espacio, GPU/VRAM/driver/compute capability, CUDA/PyTorch, cálculo real en GPU, logs/warnings incompatibles, ComfyUI, nodos/Nunchaku, modelos/encoders/VAE/workflow, licencias y destino de salida/persistencia. torch.cuda.is_available() no basta.

Si la ubicación es externa o incierta, la identidad no cuadra, no hay GPU compatible, la inferencia requiere CPU fallback, un kernel falta, la carga/modelo falla o el destino no sobrevive a la sesión, bloquear capacidad y registrar código de fallo. Aplicar el mismo guard a API local, arranque automático y CLI para impedir bypass. No iniciar ComfyUI para descubrir después incompatibilidades.

Solo descargar pesos después de P0–P6 y una vez verificado destino duradero, espacio, fuentes y licencias. Reusar artefactos íntegros y reanudar descargas incompletas; no descargar gigabytes por sesión.

### 9.3 Certificación mínima

1. Integridad/runtime/importaciones.
2. GPU elegible y operación CUDA real sin CPU fallback.
3. Carga válida de Nunchaku/nodos.
4. Carga íntegra de todos los modelos necesarios.
5. Generación real de archivo válido.
6. Workflow de edición con imagen de referencia.
7. Recuperación tras nueva instancia efímera sin reinstalación repetida.
8. Bloqueo real de terminal/ubicación/GPU no elegible sin proceso de inferencia.
9. Instanciación repetida idempotente.

### 9.4 TEST 01 — UMBRAL / ENTRY AS TRANSFORMATION

Una imagen maestra horizontal 4:3. Umbral monumental abstracto construido con piedra, mineral, cerámica o estratos comprimidos; apertura asimétrica que revela profundidad interior; transformación material/perceptiva, no puerta literal; iluminación física direccional, profundidad y espacio negativo; trazas de azul profundo integradas en los estratos; sin personas, texto ni logotipos. Lenguaje rector: CARTOGRAFÍA DE LA TRANSFORMACIÓN. Hipótesis primaria Material Intelligence; secundaria Dark Field Cinema. Evitar cerebros azules, neuronas, redes de nodos, circuitos, estética cyberpunk, futurismo genérico, partículas decorativas, explosiones, stock e ilustración corporativa.

Guardar fuera del repositorio OGP con prompt, modelo/versiones, parámetros, seed cuando aplique, hashes y evidencia de GPU. Gate visual: promedio mínimo 4.2/5 y ningún criterio crítico inferior a 3/5. Antes de aprobar, no modificar sitio OGP, story-v3.js ni JSON canónicos.

## 10. Destino de persistencia y Deadman

Metodología es público: guardar decisiones, runbooks, hashes, versiones, estados, resultados y referencias a almacenamiento privado; no guardar snapshots binarios de WordPress, DB/media, secretos, Divi ZIP ni modelos grandes.

No asumir que el PostgreSQL o Vercel Blob de KHORA almacena los backups de WordPress o pesos IA; verificar cada destino. Un checkpoint final no es suficiente frente a Deep Freeze, caída o Deadman. Requerir checkpoints incrementales, lectura de vuelta, SHA-256, ID de snapshot y restauración aislada. Deadman puede retirar copia local solo después de confirmar que existe otra copia duradera verificada; nunca borrar copias remotas confirmadas.

No declarar EP_CIFRADO hasta demostrar VHDX/junction target, BitLocker XtsAes256, protección activa y cifrado al 100 %. Si falta prueba, clasificar EP_VOLATIL y no mover el sitio o los modelos.

## 11. Evidencia y próximos ciclos

### Verificado en el corte
- SI v1.6.21 leído por H1 → SI@H1 → H2, con ambos SHA coincidentes.
- main de Metodología estaba en 8ea039d987712d5d154ec2ef3fb47adfea2422d3.
- Existían scripts/bootstrap-cibercafe-cli.ps1, scripts/bootstrap-entorno-persistente.ps1 y scripts/obs-chrome-camera-fix.ps1 en esa ref.
- Se leyó a través de RDC el archivo ChatGPT-Cyber - Arranque-20261009-1024.txt desde Downloads en PC-7. El archivo tiene 1,992 líneas. La búsqueda en la biblioteca no lo encontró porque estaba en el host remoto, no porque no existiera.
- La transcripción informa Node 24.20.0 y OBS 32.2.2 instalados en un intento histórico que abortó cuando la cámara virtual no inició. No es prueba del estado actual.
- El usuario solicita Divi 4.23.1 para la siguiente sesión; el ZIP no se inspeccionó durante esta consolidación.

### No verificado
- Estado real de la cámara virtual en la sesión siguiente.
- Autenticación/identidad de RDC en sesiones futuras.
- Target/junction, VHDX, BitLocker y almacén duradero EP.
- Presencia del ZIP y licencia/integridad de Divi.
- WordPress local y rutas actuales.
- Almacenamiento privado, restauración y conducta completa de Deadman.
- Agente y observador de desempeño.
- GPU/runtime/modelos/workflows y certificación de OGP.

### Orden de ejecución
1. Adquirir el SI y esta especificación de main en cada sesión nueva.
2. Resolver terminal, conectividad y almacenamiento en vivo.
3. Llegar a workspace básico con repositorios y RDC; no descargar pesos grandes mientras el usuario se desconecta.
4. Mantener el navegador fuera del bootstrap.
5. Inventariar assets en solo lectura; nunca hacer resets/borrados sobre árbol desconocido.
6. Corregir bootstrap WP-LAB en staging con backup/rollback y prueba de rutas.
7. Certificar el destino de persistencia antes de transferir sitio, cachés o modelos.
8. Implementar el preflight IA luego de que el bootstrap básico sea usable.
9. Certificar la generación/edición y realizar TEST 01.
10. Abrir PR, revisar diff, merge controlado y verificar read-back en main.

No confundir documentado, implementado, instalado, funcional, certificado y publicado. Un proceso iniciado no significa servicio conectado; un dispositivo PnP no significa vídeo válido; un modelo descargado no significa carga; CUDA disponible no significa cálculo en GPU; una carpeta local no significa persistencia.

## 12. Entradas del usuario verbatim

Los fragmentos de esta sección son especificaciones aportadas literalmente por el usuario. Los análisis y estados técnicos aparecen fuera de las citas. Se omiten de este objeto público los códigos de autorización, tokens, cookies, credenciales e identificadores transitorios de conexión extraídos del log de RDC.

### 12.1 Volatilidad de terminales y Divi

> Te recuerdo que las sesiones de PC-7, PC-4, etc, (son como 8 todas nomvbradas similar), son parte de las computadoras disponibles en el Cybercafe Cybernet, que tiene mecanimso estilo deepfreze, por lo que cada sesion aqui es efimera ya de por si. Al reiniciar la maquina, o iniciar nueva sesion, se borra todo pro defecto.
>
> divi-theme_4.23.1.zip usa este tema de divi para instalar.
>
> Entonces, estás identificando una carpeta en el escritorio, pero como es parte de una sesión efímera en una de las terminales de Cybernet, el cibercafé de Luis Paseo, pues no tiene mucho caso que la registres para el elemento canónico porque es efímera. Y luego, ahorita tengo diez minutos para que instancies el sistema. Posteriormente, debido a restricciones de propietariedad y derechos de autor, no creo que GitHub nos deje canonizar un objeto que tenga un enlace hacia una descarga del tema de Divi. A pesar de que sí cuento con la llave de activación, que por cierto te la puedo dar en un momento dado cuando sea necesario, no tengo el nombre y usuario de Elegant Themes para descargar el tema Divi más actual. La copia que te estoy proporcionando, que por cierto está en la carpeta de descargas y va a estar ahí durante los siguientes diez minutos, es la descarga del Internet Archive. Entonces mi recomendación es que te tomes otro ciclo para consolidar toda esta información, endurecer bien lo que tienes y trataré de confirmarte rápidamente luego de que hayas canonizado un objeto en el repositorio de metodología para que todo lo que tiene que ver con entorno persistente quede en contexto y podamos recuperar la ventana de contexto incluso si trabajo en otra plataforma. Entonces, haz eso y continuamos.

### 12.2 Secuenciación de elementos

> Bueno, me parece que sí voy a tener que volverte a proporcionar el divi en la siguiente sesión, porque nada más nos quedan siete minutos. Por ahora te voy a pasar otro prompt de otro hilo que tiene que ver con la generación de contenido complementario para el instrumento de comunicación de otro gran programa que involucra la instalación de una solución local con uso de modelos de lenguaje de gran tamaño open source en computadoras con GPU, como las que están ubicadas en el cibercafé Cybernet de la calle Luis Pasteur. Eso implica que como parte del entorno de persistencia se debe, y esto tiene que irse instalando en el orden correcto, ¿de acuerdo? O sea, el entorno persistente ya tiene muchos elementos que deben de ser secuenciados de una manera que tenga sentido para que primero se cargue lo esencial y me permita ponerme a trabajar lo antes posible conforme voy instanciando las sesiones efímeras. y algunos elementos más robustos, como la descarga de los lenguajes de modelo de gran tamaño para la solución que te acabo de mencionar, dejarlos para lugares ulteriores en la secuencia. Entonces, considerado eso, te paso el prompt que generó el modelo constructor del hilo de esa solución para que lo tomes en cuenta en la organización general del entorno persistente para la canonización del objeto canónico en el repositorio de metodología.

### 12.3 Alcance del bootstrap para navegador

> Prohibido para el comando trabajar con chrome, todo es por terminal

### 12.4 Requisitos de repositorios y ficha RDC

> ...es importante que clones los otros repositorios: otro gran programa, gestor de procesos, que antes se llamaba Census, Signal intérprete. Estos últimos dos son extensiones y la extensión como tal, con el manifiesto y todo normal, debe de ir en la carpeta raíz. Dentro de la carpeta raíz tiene que ir el repositorio Cora y creo que son todos los repositorios además de metodología.

> Esto se descarga en una carpeta de escritorio llamada Entorno Persistente y añade un archivo de logging de registro de eventos muy detallado, tan detallado como para que sirva para mejorar, mejora continua y diagnóstico de bugs y errores. Recuerda que todo esto es exclusivo para la ubicación cibercafé Luis Pasteur, donde las máquinas tienen un mecanismo tipo Deep Freeze que hace que todo se reinicie y cada sesión es efímera. Además puedo moverme en diferentes máquinas al mismo tiempo, tomar eso siempre en cuenta. Digo, cada sesión puedo ocupar una máquina distinta de acuerdo.

> Por último, en el script, como la última parte es RDC, asegúrate de que copie al portapapeles las especificaciones de la sesión de RDC que se abrió. Siempre se va a abrir sesión nueva en este cibercafé porque cada sesión es efímera y añade telemetría al script y al registro de eventos que vas a dejar en un archivo de texto en cada ejecución en la carpeta de trabajo.

### 12.5 Mandato de OGP visual (extracto verbatim)

> No te limites a documentar la solución. Inspecciona la arquitectura canónica, determina los puntos de integración correctos, implementa los cambios necesarios en el ámbito de Entorno Persistente, verifica los resultados y publica los cambios conforme al procedimiento canónico de ese proyecto.
>
> No descargues varios gigabytes en cada nueva sesión efímera. Los artefactos deben conservarse en un caché local recuperable por la siguiente instancia cuando el diseño canónico lo permita; de lo contrario, documenta y controla la materialización necesaria.
>
> La misma protección debe aplicarse a los arranques automáticos y a las solicitudes a la API local. Ningún segundo punto de entrada debe permitir saltarse el gate.
>
> No ejecutes inferencia hasta recuperar un entorno consistente.
>
> No modifiques story-v3.js, los JSON canónicos, la estructura visual ni el sitio publicado de OGP como parte de esta instalación. La integración visual de OGP queda condicionada a la evaluación y aprobación de TEST 01.
>
> No confundas implementado, instalado, funcional, certificado y publicado. Cada uno es un estado distinto que requiere evidencia propia.

### 12.6 Mandato de canonización

> Organízalo todo. Te quedas trabajando nada mas si necesitas con conexion a github. Para que actualizes el objeto canonico. QUe sea de la mas alta calidad, documentando toda la especificacion para rdc. Registra ademas, una seccion de mis entradas verbatim, para que sean tomadas como especificaciones canonicas para el EP.
>
> Se implacable con el grado de rigurosa calidad al objeto de persitencia de especificaicones canonicas del repositorio en metodologia para ep, tomandoen cuenta todo!
>
> MNe voy ahora resuelve de extremo a extremo. No te detengas hasta terminar. Es importante esfuerzate!
>
> Fijate que no falle, que quede bien todo a la primera.

## 13. Criterio de conclusión

La documentación se considera incorporada cuando el PR se revisa, se integra en main y se verifica con read-back. La implementación física solo se considera completa cuando los gates tienen evidencia viva. Sin RDC se puede seguir trabajando en documentación y GitHub; inspección/ejecución en la PC requiere conexión nueva.

No confundir:
- documentado con implementado;
- instalado con funcional;
- proceso activo con servicio conectado;
- cámara registrada con vídeo útil;
- sesión local con persistencia;
- copia de seguridad con restauración probada;
- modelo descargado con modelo cargable;
- CUDA disponible con operación real GPU;
- dato declarado con evidencia independiente;
- publicación de código con aceptación funcional.


---

## 14. Entrada OGP íntegra, verbatim

Se conserva a continuación la especificación completa aportada por el usuario en cuanto a sus requisitos. Se redactan únicamente datos de cuenta e identificadores RDC transitorios que no constituyen requisitos reutilizables, para no publicar identificadores personales/operativos en este repositorio público. Los delimitadores Markdown se preservan al serializar el texto.

```text
# INTEGRACIÓN DE INFRAESTRUCTURA LOCAL DE IA GENERATIVA VISUAL EN ENTORNO PERSISTENTE

## Instrucción de implementación para el modelo constructor

### 1. Rol y objetivo

Actúa como arquitecto e ingeniero de implementación responsable de **Entorno Persistente**, respetando su arquitectura canónica, sus mecanismos de instanciación efímera, su gobernanza de contexto y sus procedimientos de instalación, recuperación y certificación.

Debes integrar como capacidad nativa de Entorno Persistente la infraestructura local de IA generativa visual necesaria para producir y editar los recursos gráficos complementarios del instrumento de comunicación de **Otro Gran Programa (OGP)**.

El objetivo es que, cuando se instancie un entorno persistente en una terminal elegible del cibercafé de Luis Pasteur, el sistema prepare, valide y deje disponible automáticamente la infraestructura necesaria para que un agente de IA pueda generar, editar, evaluar y guardar recursos visuales mediante modelos ejecutados localmente en GPU.

**No te limites a documentar la solución.** Inspecciona la arquitectura canónica, determina los puntos de integración correctos, implementa los cambios necesarios en el ámbito de Entorno Persistente, verifica los resultados y publica los cambios conforme al procedimiento canónico de ese proyecto.

### 2. Recuperación obligatoria del contexto canónico

Antes de modificar cualquier componente:

1. Recupera desde su fuente canónica la versión vigente de `SI-METACOGNITIVO.md` en la rama `main` del repositorio de metodología. Comprueba la identidad exacta del snapshot y su vigencia.
2. Recupera la documentación canónica actual de Entorno Persistente, incluidos su arquitectura, bootstrap, instanciación efímera, persistencia local, gestión de dependencias, resolución de contexto, identificación de terminales y pruebas.
3. Identifica el repositorio y las rutas canónicas exactas donde debe implementarse la capacidad. No inventes nombres, ubicaciones, contratos ni dependencias.
4. Inspecciona los mecanismos de instanciación reales y las modificaciones pendientes. Distingue el entorno efímero de los componentes persistentes que permiten reconstruirlo.
5. Determina el estado real de los recursos y procesos previamente preparados para OGP. No des por concluida ninguna instalación basándote únicamente en que existe un archivo o se inició un proceso.

Las fuentes canónicas vigentes prevalecen sobre este prompt, sobre copias locales antiguas y sobre cualquier estado heredado de una conversación anterior.

### 3. Ámbito funcional

La capacidad que debe integrarse es una infraestructura de **generación y edición visual mediante modelos abiertos ejecutados localmente**.

No la confundas con un servicio de generación de imágenes en la nube ni con la instalación genérica de un modelo conversacional. El pipeline seleccionado es una infraestructura especializada de generación visual y transformación de imágenes.

Debe proporcionar:

- Generación automatizada de imágenes a partir de instrucciones textuales.
- Edición y refinamiento de imágenes existentes mediante modelos compatibles.
- Uso de imágenes de referencia y mecanismos de coherencia visual.
- Ejecución de workflows reproducibles.
- Control programático mediante API local, Python o CLI.
- Procesamiento por lotes y gestión de colas.
- Conservación de originales, versiones, metadatos, prompts, parámetros y resultados.
- Escritura de resultados en un workspace de integración accesible al agente de IA.
- Recuperación de la capacidad después de destruir y volver a instanciar una sesión efímera.

El sistema debe permitir automatizar el flujo completo:

`SOLICITUD → VALIDACIÓN DE CONTEXTO → RESOLUCIÓN DE TERMINAL → PREFLIGHT GPU → GENERACIÓN → EVALUACIÓN → EDICIÓN → PRESERVACIÓN → INTEGRACIÓN`

La publicación o modificación del sitio OGP permanece condicionada a la validación visual y al gate de aceptación definidos por el proyecto OGP.

### 4. Restricción geográfica y de terminal

La infraestructura local de inferencia está autorizada exclusivamente para terminales situadas en el **cibercafé de Luis Pasteur**, siempre que satisfagan todas las comprobaciones de identidad, hardware, software y ubicación.

Esta restricción es obligatoria y debe materializarse en código ejecutable, no solamente en documentación.

Debes mantener separadas las siguientes entidades:

- **Ubicación:** el cibercafé de Luis Pasteur.
- **Terminal:** cada computadora física individual.
- **Identidad RDC:** cuenta y `RDC-DEVICE-ID` concretos.
- **Sesión:** instancia efímera de Entorno Persistente.
- **Conversación:** contexto desde el que se solicita una operación.
- **Capacidad local:** combinación certificada de hardware, runtime, modelos y workflows.

Una ubicación puede tener múltiples terminales. Una terminal no representa por sí sola una ubicación y no debe seleccionarse por su nombre, por la etiqueta `PC-7` ni por un registro histórico.

En cada instanciación que requiera esta capacidad, realiza descubrimiento vivo de las terminales RDC, reconcilia las identidades y resuelve la terminal objetivo conforme a la metodología canónica. No heredes ciegamente la terminal de otra conversación.

#### Comportamiento requerido por escenario

**Terminal autorizada en el cibercafé, con GPU compatible:**

- Verificar identidad y atestación de ubicación.
- Inventariar hardware y runtime.
- Recuperar dependencias y modelos existentes.
- Instalar o reparar lo que falte.
- Ejecutar las pruebas de certificación pendientes.
- Habilitar la capacidad cuando el preflight completo sea satisfactorio.

**Terminal fuera de la ubicación autorizada:**

- No ejecutar inferencia para OGP.
- No iniciar ComfyUI ni otros runtimes de modelos para esta finalidad.
- No descargar innecesariamente los modelos pesados.
- Permitir el resto de la instanciación de Entorno Persistente si sus requisitos independientes se cumplen.

**Terminal sin GPU compatible, con GPU no detectable o con runtime CUDA/PyTorch incompatible:**

- Bloquear la inferencia local.
- No efectuar fallback a CPU.
- No declarar la capacidad disponible.
- Registrar el fallo concreto y su solución necesaria.

**Ubicación, identidad o conectividad indeterminadas:**

- Aplicar fail-closed.
- No ejecutar la generación.
- No resolver la incertidumbre mediante inferencias basadas en memoria conversacional.

La resolución del contexto debe distinguir una atestación declarada por el usuario de una verificación técnica independiente. No presentes como prueba criptográfica una identificación basada únicamente en hostname, IP, gateway o dispositivo RDC.

### 5. Infraestructura técnica seleccionada

Implementa inicialmente el siguiente candidato, sujeto a la validación de compatibilidad real y a las licencias vigentes:

**Orquestación:** ComfyUI local, en modo portable para Windows y controlable mediante API.

**Aceleración y cuantización:** Nunchaku, con sus nodos personalizados para ComfyUI y el binario nativo exacto compatible con el runtime.

**Generación primaria:** Z-Image-Turbo, usando una variante cuantizada FP4 apropiada para la GPU disponible, como la variante Nunchaku `svdq-fp4_r128-z-image-turbo.safetensors`, siempre que supere las pruebas de compatibilidad.

**Edición:** Qwen-Image-Edit-2509 o la variante de edición compatible que supere la certificación.

No instales versiones arbitrarias ni combines binarios por semejanza de nombres. Resuelve explícitamente las compatibilidades de Windows, versión de Python embebido, PyTorch, CUDA, driver NVIDIA, Nunchaku, ComfyUI, arquitectura GPU y modelos.

Fija versiones y hashes de los componentes certificados. Si el candidato no puede instalarse de forma reproducible en la GPU elegible, determina la alternativa local compatible antes de proclamar la capacidad operativa.

No sustituyas silenciosamente la inferencia local por un servicio en la nube.

### 6. Aprovisionamiento integrado en la instanciación

Integra un provisionador idempotente en el punto apropiado del ciclo de vida de Entorno Persistente.

Cada ejecución del provisionador debe:

1. Detectar el contexto de ejecución y resolver si esta capacidad es aplicable.
2. Obtener una instantánea actual del hardware y comprobar elegibilidad.
3. Determinar la ubicación, identidad y autorización de la terminal.
4. Inventariar instalaciones, versiones, dependencias, modelos, archivos temporales y espacio disponible.
5. Comprobar si el runtime existente es íntegro y compatible.
6. Reutilizar las instalaciones, cachés y modelos íntegros.
7. Descargar únicamente los componentes ausentes o dañados, utilizando fuentes oficiales y hashes verificables cuando estén disponibles.
8. Reanudar o reiniciar de forma segura descargas interrumpidas.
9. Instalar las dependencias en el orden correcto y verificar su integridad.
10. Ejecutar pruebas de GPU y de carga de modelos.
11. Publicar el estado de la capacidad y las evidencias de certificación.
12. Dejarla disponible automáticamente para el agente de IA cuando todos los gates hayan sido superados.

**Idempotencia:** instanciar varias veces el entorno no debe provocar reinstalaciones innecesarias, duplicación de modelos, pérdida de configuraciones, descargas repetidas ni divergencia de versiones.

No descargues varios gigabytes en cada nueva sesión efímera. Los artefactos deben conservarse en un caché local recuperable por la siguiente instancia cuando el diseño canónico lo permita; de lo contrario, documenta y controla la materialización necesaria.

Elimina o aísla artefactos temporales incompletos. No sobrescribas una instalación funcional con otra incompatible sin una operación controlada de reparación.

### 7. Preflight obligatorio y bloqueo de ejecución

Implementa un componente explícito de control de ejecución, denominado según las convenciones reales del proyecto.

Debe impedir el arranque de la inferencia hasta verificar, como mínimo:

- Snapshot canónico vigente y contexto operativo resuelto.
- Identidad RDC concreta y conectividad actual.
- Ubicación autorizada y atestación vigente para la terminal.
- Coincidencia del fingerprint autorizado de hardware.
- CPU, RAM, espacio disponible y sistema operativo.
- GPU NVIDIA esperada, VRAM, driver y capacidad de cómputo.
- CUDA funcional y PyTorch compatible con la arquitectura GPU.
- Operación real de cálculo ejecutada en GPU.
- Disponibilidad de ComfyUI y sus nodos personalizados.
- Compatibilidad e integridad de todos los modelos, encoders, VAE y demás recursos requeridos por el workflow.
- Workspace y directorio de salida válidos.

El preflight no puede limitarse a comprobar que `torch.cuda.is_available()` devuelve verdadero. Ejecuta una operación real en GPU y verifica que no existen warnings de incompatibilidad de arquitectura ni kernels necesarios ausentes.

Si falla cualquier requisito, devuelve un estado bloqueado identificable y un diagnóstico accionable. No arranques ComfyUI para después descubrir la incompatibilidad; verifica previamente lo que pueda validarse sin iniciar la inferencia.

La misma protección debe aplicarse a los arranques automáticos y a las solicitudes a la API local. Ningún segundo punto de entrada debe permitir saltarse el gate.

### 8. Fingerprint y certificación por terminal

El diseño debe admitir varias computadoras en el cibercafé, cada una con capacidades distintas.

Por cada terminal autorizada, conserva un registro versionado que identifique, según corresponda:

- Cuenta RDC y RDC-DEVICE-ID.
- Identidad de la terminal y hostname.
- CPU, RAM y GPU.
- Driver NVIDIA, capacidad de cómputo, VRAM y runtime CUDA.
- Versiones de Python, PyTorch, ComfyUI y Nunchaku.
- Modelos y workflows certificados, con sus hashes.
- Resultado y fecha de las pruebas.
- Identidad y vigencia de la atestación de ubicación.
- Estado actual de la capacidad y motivo de bloqueo, en caso de existir.

No presupongas que todas las computadoras del cibercafé tienen GPU o hardware idénticos. Determina la capacidad de cada terminal a partir de su inventario real.

Si cambia la GPU, el driver, el runtime, una dependencia crítica o un artefacto certificado, invalida las certificaciones afectadas y vuelve a verificarlas.

### 9. Recuperación del intento de instalación existente

Existe un intento previo de preparación en el workspace:

`C:\\Users\\PC 7\\Downloads\\OGP-Visual-Pipeline`

Incluye una distribución portable de ComfyUI y una copia de `ComfyUI-nunchaku`. Durante ese intento se detectó una incompatibilidad entre la versión de PyTorch incluida originalmente y la RTX 5060, seguida de operaciones de sustitución de PyTorch y una instalación fallida de Nunchaku por conflicto de dependencias y bloqueo de archivos. También se inició la descarga del modelo Z-Image-Turbo.

La terminal utilizada tenía las siguientes características observadas:

- Identidad RDC: cuenta informada en el registro histórico (dato transitorio; no reutilizar automáticamente en futuras sesiones).
- RDC-DEVICE-ID: identificado en el registro original de la sesión, no fijado aquí como identidad actual.
- Hostname: PC-7.
- CPU: AMD Ryzen 5 5600X, 6 núcleos y 12 hilos.
- RAM: aproximadamente 32 GiB.
- GPU: NVIDIA GeForce RTX 5060.
- VRAM reportada por nvidia-smi: 8151 MiB.
- Compute capability: 12.0.
- Driver NVIDIA observado: 610.47.

La ubicación CIBERCAFE fue declarada por el usuario en el ciclo correspondiente; debe reconciliarse con la atestación y los procedimientos canónicos vigentes, no considerarse automáticamente una certificación física independiente.

**Estado del intento: no certificado.** La última fase de operaciones remotas sufrió timeouts. No asumas que la reparación de PyTorch, el establecimiento de Nunchaku, la descarga del modelo ni la última escritura del guard finalizaron correctamente.

La primera acción sobre estos artefactos debe ser recuperar la conectividad en vivo, inventariar los archivos, comprobar los procesos y validar la integridad de la instalación. No repitas una instalación potencialmente destructiva sin verificar antes su estado real.

No ejecutes inferencia hasta recuperar un entorno consistente.

### 10. Pruebas de certificación

Define pruebas automáticas y persistentes para los siguientes niveles:

**Nivel 1 — Integridad del entorno:** importación de PyTorch, versiones fijadas y ausencia de dependencias rotas.

**Nivel 2 — GPU:** detección de la RTX correspondiente, operación CUDA real y ausencia de fallback a CPU.

**Nivel 3 — Backend:** importación correcta de Nunchaku y carga de sus nodos personalizados en ComfyUI.

**Nivel 4 — Modelos:** verificación de integridad y carga real de los componentes necesarios para el workflow.

**Nivel 5 — Generación:** producir una imagen en un workflow controlado y comprobar que el archivo de salida es válido, legible y está en el destino esperado.

**Nivel 6 — Edición:** validar un workflow de edición con una imagen de referencia cuando el modelo y sus dependencias estén certificados.

**Nivel 7 — Recuperación:** destruir y volver a instanciar la sesión efímera, comprobando que el entorno persiste, recupera sus dependencias y supera nuevamente el preflight sin intervención repetitiva.

**Nivel 8 — Rechazo:** comprobar automáticamente que un hostname, RDC-DEVICE-ID, perfil de ubicación o hardware no autorizado produce un bloqueo efectivo. Verificar también que no se inicia ningún proceso de inferencia.

**Nivel 9 — Reproducibilidad:** repetir la instanciación y demostrar que no se vuelven a descargar o instalar artefactos que ya están íntegros.

La capacidad no puede declararse certificada únicamente porque ComfyUI se abre o porque los nodos aparecen en su interfaz.

### 11. Primera prueba visual de OGP

Una vez certificada la infraestructura, prepara una única generación de aceptación, denominada:

**TEST 01 — UMBRAL / ENTRY AS TRANSFORMATION**

Objetivo: producir la primera imagen maestra de la dirección visual de OGP.

Formato: horizontal 4:3.

Dirección visual:

- Umbral monumental abstracto construido con materia densa: piedra, mineral, cerámica o estratos comprimidos.
- Apertura asimétrica que revele profundidad interior.
- Transformación material y perceptiva, no una puerta literal.
- Iluminación física direccional, profundidad y espacio negativo.
- Trazas de azul profundo integradas en los estratos estructurales.
- Sin personas, texto ni logotipos.

Lenguaje rector: **CARTOGRAFÍA DE LA TRANSFORMACIÓN**.

Hipótesis visual primaria: Material Intelligence. Hipótesis secundaria: Dark Field Cinema.

Evita cerebros azules, neuronas, redes de nodos, circuitos, estética cyberpunk, futurismo genérico, partículas decorativas, explosiones, fotografía de stock e ilustraciones corporativas.

Genera primero una imagen maestra. No produzcas un conjunto de decenas de imágenes independientes. El modelo de producción debe permitir derivar estados y variaciones a partir de maestros preservados.

El resultado debe guardarse en un workspace de integración separado del repositorio OGP, acompañado de prompt, modelo, versiones, parámetros, seed cuando corresponda, hashes y evidencia de ejecución en GPU.

No modifiques story-v3.js, los JSON canónicos, la estructura visual ni el sitio publicado de OGP como parte de esta instalación. La integración visual de OGP queda condicionada a la evaluación y aprobación de TEST 01.

La aceptación estética debe respetar el criterio canónico de OGP: promedio mínimo de 4.2/5 y ningún criterio crítico por debajo de 3/5.

### 12. Costes, licencias y autonomía

La solución debe funcionar sin depender de:

- Suscripciones comerciales de generación visual.
- Créditos de APIs de inferencia alojadas.
- Claves de proveedor que requieran pagos.
- Tarjetas bancarias.
- Servicios remotos necesarios para ejecutar cada generación.
- Intervenciones manuales repetitivas.

Se admite conexión a Internet para recuperar releases, dependencias y modelos durante el aprovisionamiento inicial o las actualizaciones controladas. La inferencia debe permanecer local.

Antes de fijar una combinación de modelos y dependencias, verifica sus licencias vigentes y su autorización para el uso previsto. No des por hecho que todos los componentes o pesos tienen idénticas condiciones de licencia por ser descargables públicamente.

Las dependencias críticas deben estar fijadas, documentadas y sujetas a comprobaciones de integridad. No ejecutes instalaciones arbitrarias de paquetes ni actualizaciones generales no controladas.

### 13. Entregables dentro de Entorno Persistente

Integra la capacidad en los componentes canónicos que correspondan, evitando duplicar mecanismos que ya existan.

Los entregables deben incluir:

1. Provisionador idempotente asociado al ciclo de instanciación.
2. Resolución y autorización de contexto, ubicación y terminal.
3. Inventario de hardware y resolución de compatibilidad.
4. Guard de ejecución fail-closed.
5. Gestor de artefactos, caché y recuperación de instalaciones incompletas.
6. Configuración versionada del pipeline y sus dependencias.
7. Interfaz de control programático para solicitudes de generación y edición.
8. Registro de ejecución, certificación, fallos y recuperación.
9. Documentación canónica de operación y reparación.
10. Pruebas automatizadas para todos los gates anteriores.
11. Integración con los mecanismos existentes de recuperación de sesiones efímeras.
12. Actualización y publicación canónica de los cambios de Entorno Persistente mediante su flujo de control de versiones.

No crees un segundo sistema de persistencia o de selección RDC si Entorno Persistente ya tiene un componente canónico que cumple esa función. Extiende o adapta el mecanismo existente.

### 14. Secuencia de implementación

Ejecuta el trabajo en este orden:

**Fase A. Auditoría:** recuperar la documentación canónica, identificar los puntos de integración, revisar el estado existente y determinar el cambio mínimo suficiente.

**Fase B. Diseño:** definir contratos, estados, gates, dependencias fijadas y ciclo de recuperación.

**Fase C. Implementación:** integrar el provisionador, el registro de capacidades y el guard de ejecución en Entorno Persistente.

**Fase D. Certificación:** probar detección de contexto, hardware, CUDA, backend, modelos, generación y rechazo en condiciones no elegibles.

**Fase E. Primera prueba visual:** ejecutar TEST 01 en la terminal autorizada y guardar la evidencia.

**Fase F. Persistencia:** demostrar que una nueva instancia efímera recupera automáticamente una instalación válida sin repetir pasos manuales.

**Fase G. Publicación:** ejecutar pruebas de regresión, publicar los cambios conforme al procedimiento canónico y verificar la versión finalmente publicada.

En cada fase, conserva evidencia comprobable de los resultados. Si un gate falla, corrige su causa y repite la prueba correspondiente; no ocultes fallos ni declares certificaciones pendientes como aprobadas.

### 15. Criterio de finalización

El trabajo solo estará terminado cuando se demuestre que:

- Entorno Persistente reconoce y selecciona la terminal individual correcta.
- La capacidad queda restringida al cibercafé autorizado y a terminales elegibles.
- El entorno efímero puede destruirse y volver a crearse sin perder la capacidad recuperable.
- Las instalaciones y descargas son idempotentes, reproducibles y verificables.
- La generación y edición se controlan programáticamente y usan GPU real.
- Una terminal no elegible no puede activar la inferencia ni siquiera mediante una ruta alternativa.
- TEST 01 ha producido una imagen válida, con trazabilidad y evaluación documentadas.
- La infraestructura está integrada y documentada en el ámbito canónico de Entorno Persistente.
- El repositorio OGP permanece sin cambios hasta superar el gate visual correspondiente.

No confundas **implementado**, **instalado**, **funcional**, **certificado** y **publicado**. Cada uno es un estado distinto que requiere evidencia propia.
```



---

## 15. Auditoría de implementación del bootstrap y brechas explícitas

**Fecha de auditoría:** 2026-10-09. **Código base revisado:** main = 71eb24ff2e285501990374fe03fd5368245e0e06. Esta auditoría es estática, por lectura de los archivos en GitHub; no implica ejecución local ni prueba de la terminal.

### 15.1 Scripts contrastados

| Archivo | Blob SHA en el commit auditado | Lo que sí contiene | Brechas comprobadas |
|---|---|---|---|
| scripts/bootstrap-cibercafe-cli.ps1 | bad15eddd4feca2d0c576ee6390863c94618faa4 | 442 líneas; resuelve hostname por DNS/WMI, asegura Git y Node, sincroniza metodología, incluye el parámetro StartOBSVirtualCamera y deja RDC en primer plano. Si se solicita, trata de registrar la cámara, lanza OBS y espera confirmación en un log reciente. | No contiene Set-Clipboard; no extrae RDC-DEVICE-ID/nombre/cuenta del flujo; no genera la ficha RDC; no inicia un observador; no crea performance-events.log ni contiene telemetría del agente; no usa Get-PnpDevice como validación de la cámara. |
| scripts/bootstrap-entorno-persistente.ps1 | f88da1c3631c2038232caa8027c19d0d429dfbcf | 322 líneas; crea estado por terminal CIBERCAFE/PC-N, log por sesión, performance-events.log y una consola hija de observador; muestra CPU/RAM/disco y GPU si nvidia-smi está disponible; consulta el estado de una tarea de desempeño; prepara repositorios/extensiones y termina ejecutando RDC en primer plano. | No contiene Set-Clipboard ni extracción de RDC-DEVICE-ID; no crea la ficha RDC. Consulta si existe una tarea CyberCafe Performance Liberator, pero no contiene la implementación del agente ni demuestra que esa tarea emita muestras. El observador y el agente son estados distintos. El script reutiliza el bootstrap CLI fijado a una ref histórica concreta, de modo que sus comportamientos no deben equipararse automáticamente al bootstrap CLI actual en main. |
| scripts/obs-chrome-camera-fix.ps1 | 5b8ba374bd0a0c8b7fc49e4e8c40daee5d7b1448 | Intenta iniciar OBS, analiza su log y ayuda a revisar el dispositivo de cámara. | Accede directamente a Chrome, contempla reinicio de procesos, inspección/edición de perfil, preferencias/políticas y apertura de páginas Chrome. Está fuera del alcance del bootstrap canónico porque la instrucción vigente del usuario es “todo es por terminal; no trabajar con Chrome”. No ejecutarlo desde el arranque de EP. |

Los SHA anteriores identifican los blobs revisados en el commit citado, no necesariamente nuevas copias de estos archivos si el código cambia en otra publicación.

### 15.2 Estado real por requisito

| Requisito canónico | Estado auditado | Próxima implementación/verificación necesaria |
|---|---|---|
| SI H1 → SI@H1 → H2 en esta sesión | PASS para la auditoría documental; la implementación base valida headers locales pero este análisis no certificó que el script compare dos lecturas de main. | Mantener el gate de frescura explícito y verificarlo con el procedimiento canónico vigente. |
| Identidad terminal separada de RDC | PARCIAL en bootstrap-entorno-persistente: usa terminal PC-N y registra el contexto; no completa la reconciliación con el dispositivo RDC recién asignado. | Analizar el handshake/estado del proveedor sin reutilizar valores históricos; persistir identidad por terminal y registrar la identidad RDC como efímera. |
| Ficha RDC al portapapeles | MISSING en los dos bootstraps revisados: ninguno llama Set-Clipboard ni extrae la ficha del texto de RDC. | Añadir un extractor robusto de los campos de sesión después de la autorización y comprobación Online, sin guardar código de verificación, token ni contraseña. Si el formato del proveedor cambia o los campos faltan, no copiar una ficha falsa; marcar el campo no disponible. |
| Clonado/sincronización y taxonomía de repositorios | PRESENTE en el orquestador de EP con validación del árbol y exportación de Signal Interpreter; la validación de manifest.json de GDP es solo una comprobación de existencia. | Incorporar pruebas estructurales del manifiesto y de la raíz de la extensión. Resolver si el entrypoint canónico será bootstrap-cibercafe-cli.ps1 invocando un orquestador único o bootstrap-entorno-persistente.ps1 que lo llame en modo PrepareOnly; no mantener dos puntos de entrada ambiguos. |
| Observador en consola independiente | IMPLEMENTADO en bootstrap-entorno-persistente.ps1, no en el entrypoint CLI por sí solo. | Decidir un único entrypoint canónico y demostrar que abre exactamente un observador, con cierre controlado y sin duplicados. |
| Agente persistente de rendimiento | NO VERIFICADO. El script consulta el nombre/estado de una tarea y lee un fichero de eventos, pero no contiene el código del agente ni demuestra que la tarea produzca muestras actuales. | Encontrar el código fuente real de Performance Liberator, comprobar su origen/versión, frecuencia de muestras, acciones permitidas, rollback y ausencia de operaciones que rompan PRESUPUESTO-REINICIO = 0. No crear un optimizador duplicado. |
| OBS Virtual Camera | PARCIAL estáticamente: el bootstrap CLI puede registrar DLL y comprobar un log reciente; el script auxiliar standalone tiene más interacciones, pero no se debe integrar porque toca Chrome. Ningún resultado prueba el estado de una sesión nueva. | Verificar dispositivo y salida en la terminal activa, permisos, fuente de vídeo y log. Registrar PENDIENTE_ADMIN/BLOCKED si requiere elevación no disponible; no reiniciar ni editar Chrome. |
| Prohibición de operaciones en Chrome | Cumplida por el alcance declarado del bootstrap CLI; incumplida por el script auxiliar standalone, que debe permanecer excluido. | Conservar una prueba estática que garantice que el entrypoint no invoca el helper ni accede a procesos, perfiles o políticas Chrome. |
| Atestación efectiva de ubicación Cybernet | NOT IMPLEMENTED / NOT VERIFIED en los scripts contrastados. La terminal lógica y el hostname no equivalen a prueba independiente de ubicación. | Integrar el mecanismo canónico de autorización/atestación ya existente o mantener el pipeline OGP bloqueado hasta definir uno; no inventar una prueba criptográfica. |
| VHDX/junction/BitLocker y estado durable | NOT VERIFIED. | Verificar ubicación física, destino, BitLocker XtsAes256, protección y cifrado al 100 %, además de write/read-back y restauración desde el almacén privado aprobado. |
| EP-WP-LAB y Divi 4.23.1 | PENDING. | Obtener el ZIP de nuevo en sesión activa, verificar contenido/hash/autorización, corregir bootstrap en staging y probar backup, rollback y rutas. |
| Pipeline local OGP | NOT CERTIFIED. | Revalidar GPU/runtime/modelos/licencias, aplicar guard en todos los puntos de entrada y completar pruebas sin descargas pesadas hasta superar los gates. |

### 15.3 Contrato para el siguiente cambio de código

1. No modificar scripts en la misma operación documental ni ejecutarlos sobre la sesión del usuario sin conexión RDC activa y mandato específico.
2. Resolver la relación entre los dos bootstraps: el entrypoint de usuario debe ser único; el script de preparación puede permanecer como módulo subordinado con interfaz explícita.
3. Añadir la ficha RDC solo tras observación viva del resultado del handshake. El portapapeles es un producto de conveniencia, no una fuente de verdad ni almacenamiento persistente.
4. No invocar scripts auxiliares que actúen sobre Chrome.
5. No afirmar que existe agente de rendimiento porque exista la ventana de observador o una tarea programada.
6. Reutilizar el mecanismo real de identidad y persistencia; no escribir memoria terminal duradera solamente en el Escritorio volátil.
7. Tras cada ajuste: lint/parse estático compatible con PowerShell 5.1, revisión de diff, pruebas unitarias/simuladas de datos faltantes y fallos, validación de no reinicio/Chrome, PR, merge y read-back. Pruebas físicas se ejecutan solo cuando haya una sesión RDC nueva disponible y sin reiniciar Cybernet.



---

## 16. Fase fundacional EP-Cybernet: alcance cerrado, criterios de aceptación y ciclos de mejora

**Objetivo inmediato:** que una llegada a Cybernet/Luis Pasteur produzca una sesión de trabajo utilizable y repetible con el mínimo de fricción, y que los fallos queden registrados para corregirlos en uno o dos ciclos. No se habilitarán todavía WP-LAB, migración física completa ni modelos grandes de IA hasta que esta fase supere sus gates.

### 16.1 Alcance cerrado

La ubicación objetivo declarada por el usuario para esta etapa es Cybernet, cibercafé de la calle Luis Pasteur. Esto no certifica técnicamente la ubicación ni habilita inferencia GPU OGP. Cada terminal física es individual, identificada como CIBERCAFE/PC-N y separada de la sesión RDC.

Capacidades fundacionales requeridas:

1. **Reinstanciación fluida de EP básico:** contexto vigente, identidad de terminal, log de ejecución, herramientas esenciales y workspace de sesión.
2. **RDC nuevo por sesión:** cliente Desktop Commander Remote en primer plano, handshake y autorización realmente completados, nombre e ID del dispositivo extraídos de la sesión actual, estado Online verificado y ficha de sesión copiada al portapapeles.
3. **OBS Virtual Camera:** OBS presente; componente virtual instalado/registrado sin reinicio; proceso iniciado; log reciente confirma su salida; dispositivo presente en Windows y escena con una fuente válida.
4. **Detección por Chrome:** Chrome enumera OBS Virtual Camera como dispositivo disponible. Es una prueba independiente del registro PnP y del arranque de OBS.
5. **Workspace actualizado:** raíz Desktop/Entorno Persistente creada para la sesión activa; cinco repositorios correctos disponibles (metodologia, otro-gran-programa, gestor-de-procesos, signal-interpreter-source, khora); exportación consumible de GDP y Signal Interpreter con sus manifiestos en la raíz esperada, derivada de los commits actuales de main.
6. **Notepad++:** instalar o reutilizar versión oficial válida, comprobar ejecutable y configurarlo como predeterminado para .txt y los formatos acordados de texto/código; verificar que Windows resuelve la asociación al ejecutable correcto.
7. **Registro de eventos:** bitácora por ejecución con resultado por etapa, códigos de error, duración, versiones/SHAs y evidencia posterior. Distinguir el log local volátil del checkpoint remoto duradero.

Fuera del alcance de esta fase: WordPress/Divi, VHDX/BitLocker/Deadman completo, ComfyUI/Nunchaku y pesos IA OGP. Estas capas no deben retrasar el arranque básico.

### 16.2 Orden de ejecución

| Orden | Etapa | Gate de salida obligatorio |
|---|---|---|
| F0 | Contexto canónico y sesión | H1 → SI@H1 → H2 verificados; RunId; fecha/hora con zona; terminal y sesión como entidades separadas. |
| F1 | Workspace y repositorios | Herramientas/autenticación verificadas; acceso a todos los repos; árbol existente protegido si está sucio; origin/rama correctos; SHA post-sync registrado; manifiestos JSON parseados y exportación Signal con hashes. |
| F2 | Notepad++ | Fuente de instalación acordada y ejecutable/versiones comprobados; asociaciones predeterminadas verificadas por extensión. Si la política de Windows compartido bloquea la asociación, usar BLOCKED_DEFAULT_APP, nunca éxito supuesto. |
| F3 | OBS/Virtual Camera en Windows | Módulo y registro correctos; permisos resueltos; log reciente de arranque; dispositivo PnP presente/activo; cero reinicios. Si faltan privilegios, BLOCKED_ADMIN sin reintentos destructivos. |
| F4 | Prueba de cámara en Chrome | Chrome enumera OBS Virtual Camera y una prueba autorizada confirma que puede abrir el dispositivo con permisos normales. No editar directamente perfiles, claves de UserChoice, políticas ni listas de URLs permitidas. Si el navegador necesita actualizar su lista de dispositivos, cualquier acción debe ser explícita, reversible y no arriesgar formularios abiertos. |
| F5 | RDC | Iniciar el cliente; observar handshake y estado Online; extraer campos de la conexión en vivo; copiar ficha sin secretos. Si el proveedor requiere autorización humana, esperar ese paso y comprobar coincidencia; no reutilizar códigos ni IDs de otra sesión. |
| F6 | Cierre de preparación | Log final PASS/BLOCKED/FAIL/NOT_VERIFIED por etapa, resumen copiable y estado del checkpoint. RDC permanece en la consola principal; el observador, si se usa, en una consola hija. |

Un error debe producir una causa concreta y permitir corregir la etapa fallida sin reinstalar componentes íntegros. El presupuesto de reinicio continúa en cero.

### 16.3 Gate de cámara: detección no equivale a simular presencia

OBS Virtual Camera se admite para usos autorizados de producción audiovisual, presentación y pruebas técnicas. La meta verificable es que Windows y Chrome enumeren un dispositivo funcional con una fuente de vídeo legítima. No utilizarla para suplantar a una persona, fingir presencia o eludir controles de identidad/presencia de una plataforma de interpretación. Si la plataforma exige captura directa, liveness o un dispositivo específico, respetar sus controles.

Implementar el gate de navegador mediante comprobación no invasiva y reproducible de enumerateDevices/acceso normal a cámara, o inspección explícita en los ajustes de cámara de Chrome. No alterar Preferences, Local State, VideoCaptureAllowedUrls ni políticas del navegador para forzar el resultado. No declarar PASS solo porque pnputil /scan-devices, un CLSID, un log histórico o un proceso OBS aparezcan correctos.

Fuentes upstream para el siguiente ciclo de código:
- Guía oficial de OBS Virtual Camera: https://obsproject.com/kb/virtual-camera-guide
- Solución oficial de problemas de OBS Virtual Camera para Windows: https://obsproject.com/kb/virtual-camera-troubleshooting
- Manual de Notepad++ — asociaciones de archivos: https://github.com/notepad-plus-plus/npp-usermanual/blob/master/content/docs/preferences.md
- Manual de Notepad++ — instalador y argumentos de línea de comandos: https://github.com/notepad-plus-plus/npp-usermanual/blob/master/content/docs/command-prompt.md
- Microsoft — asociaciones y aplicaciones predeterminadas en Windows: https://learn.microsoft.com/en-us/windows/win32/shell/default-programs

Las fuentes de upstream describen capacidades generales; no demuestran el estado de una terminal concreta.

### 16.4 Contrato de Notepad++

La aplicación predeterminada no se considera configurada porque exista notepad++.exe. La prueba debe resolver asociaciones de Windows para .txt y las extensiones objetivo acordadas (como .log, .md, .json, .ps1 y formatos fuente del workspace), y demostrar que el destino es la versión de Notepad++ instalada.

No modificar a ciegas HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\UserChoice ni inventar su hash. Preferir el registro de la aplicación y los mecanismos soportados por Windows/Notepad++; si el sistema exige confirmación interactiva, informar qué elección falta. Comprobar asociaciones al iniciar cada sesión por la volatilidad de Cybernet; reutilizar la instalación si sobrevive y reinstalar solo si falta.

### 16.5 Workspace y pruebas estructurales

Para cada repo: comprobar .git, origin exacto, rama main, árbol limpio antes de actualizar, pull --ff-only y SHA resultante. No hacer reset forzado ni borrar contenido local desconocido.

Comprobar:
- gestor-de-procesos/manifest.json existe, parsea como JSON y tiene identificadores/versión válidos.
- signal-interpreter-source/extension/manifest.json existe y parsea; la exportación signal-interpreter/manifest.json coincide semánticamente con el origen y su marcador conserva commit fuente y hashes del árbol.
- Los otros repos corresponden a SeryMente/metodologia, SeryMente/otrogranprograma y SeryMente/khora. KHORA no es Cora.
- Todo se materializa bajo una sola raíz de trabajo de la sesión actual, clasificada como volátil; no registrar esa ruta como almacén persistente.

### 16.6 Contrato de la ficha RDC

Tras verificar el handshake, copiar una ficha con campos tales como TERMINAL_ID, TERMINAL_ID_SOURCE, RDC_DEVICE_NAME, RDC_DEVICE_ID, RDC_STATUS, RDC_VERIFIED_AT, SESSION_RUN_ID, BOOTSTRAP_COMMIT, BOOTSTRAP_SHA256, CAMERA_OS_STATUS, CAMERA_CHROME_STATUS, NOTEPADPP_VERSION, REPOS_HEADS y LOG_PATH.

Cada valor debe tener evidencia; si falta, informar NOT_VERIFIED. No obtenerlo de memoria conversacional. No incluir contraseña, PAT, código temporal de autorización, cookie ni otra credencial. La ficha es contexto operativo de la sesión, no memoria persistente. Redactar secretos antes de escribir logs.

### 16.7 Observabilidad para corregir en uno o dos ciclos

Cada etapa debe emitir eventos estructurados, preferiblemente JSON Lines, con timestamp, run_id, terminal_id, stage, status, duration_ms, exit_code, evidence_ref, versiones/SHAs, error_code, resumen técnico y siguiente acción sugerida.

Estados normalizados: PASS, BLOCKED, FAIL, NOT_VERIFIED, SKIPPED. El resultado global no puede ser PASS si algún gate obligatorio está bloqueado, falló o no fue verificado. Mostrar primero los bloqueos y luego los éxitos. El ciclo de corrección siguiente debe enfocarse en el gate fallido y sus regresiones; no repetir toda la instalación.

Deep Freeze puede borrar el log local. Hasta probar destino privado duradero mediante put → read-back → SHA-256, usar REMOTE_CHECKPOINT=NOT_VERIFIED. Solo sincronizar a Metodología pública resúmenes saneados y no personales; logs con IDs RDC o datos personales requieren almacenamiento privado aprobado.

### 16.8 Criterio de conclusión fundacional

La fase se aprueba después de dos instanciaciones consecutivas controladas, sin reiniciar el equipo, que demuestren:
1. Bootstrap básico fluido e idempotente.
2. Todos los repositorios correctos y actualizados y manifiestos válidos.
3. Notepad++ como aplicación predeterminada comprobada para extensiones objetivo.
4. OBS Virtual Camera activa y detectada por Windows.
5. Chrome enumera la cámara en una prueba real con permisos normales.
6. RDC Online con identidad de la sesión actual y ficha correcta al portapapeles.
7. Log completo, estados explícitos y ausencia de secretos.
8. La segunda ejecución no destruye cambios del usuario ni reinstala artefactos íntegros.
9. PRESUPUESTO-REINICIO=0.

Después de esos dos éxitos, congelar la capa fundacional como base estable antes de ampliar EP. No iniciar WordPress/Divi o pesos de modelos hasta pasar el gate. La certificación de ubicación/terminal y el almacenamiento remoto duradero continúan como estados separados hasta obtener evidencia.



---

## 17. Auditoría de integridad del estado real de código (H1/H2 2026-10-09)

**H1 = H2 = d0d116e298b5bd3f6e1e69950fbbf9389b4edd48.** SI leído exactamente desde H1: versión v1.6.21, blob SHA 89ebe84df49300662f996b85130cbcb893b568e0. Esta auditoría sustituye cualquier lectura anterior de blobs de scripts cuando no coincida con la tabla actual.

| Artefacto en main | Blob SHA actual | Evidencia estática | Estado frente a la Fase Fundacional |
|---|---|---|---|
| scripts/bootstrap-cibercafe-cli.ps1 | bad15eddd4feca2d0c576ee6390863c94618faa4 | Tiene preparación de Git/Node, sincronización de Metodología, parámetro StartOBSVirtualCamera y lanzamiento RDC en primer plano. | No clona todos los repositorios. No instala Notepad++. No extrae identidad RDC ni copia ficha RDC al portapapeles. La cámara queda confirmada por log OBS, no por Chrome. |
| scripts/bootstrap-entorno-persistente.ps1 | f595ca78cc08cff649b4b9f422a6704747b89cb8 | Sincroniza los cinco repositorios listados; exporta la extensión Signal Interpreter; crea log de bootstrap, eventos y observador; separa la identidad CIBERCAFE/PC-N. La comprobación actual de OBS registra que la salida empezó y ejecuta un rescan PnP. | No instala/configura Notepad++; no verifica la enumeración real de Chrome; no extrae el RDC-DEVICE-ID de la sesión ni crea ficha RDC. Usa Set-Clipboard únicamente para borrar un PAT de GitHub del portapapeles cuando detecta que sigue allí: esto no satisface el requisito de ficha RDC. No contiene el agente Performance-Liberator; solo consulta estado de una tarea y lee marcas del log. |
| scripts/obs-chrome-camera-fix.ps1 | 5b8ba374bd0a0c8b7fc49e4e8c40daee5d7b1448 | Inicia OBS y consulta su log; abre/gestiona Chrome y modifica preferencias o políticas en el flujo histórico. | No integrarlo en el bootstrap fundacional tal como está. Requiere rediseño si se va a conservar: no editar perfiles/políticas, no cerrar a la fuerza el navegador, y demostrar enumeración de cámara por un test consentido. |
| ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md | 1b2b9c889ef9bdf32f73cfdbcd782c7e98dcf185 | Procedimiento de apoyo para arranque, debe compararse con ambos scripts. | Mantenerlo alineado con el punto de entrada que se elija; evitar que describa como una sola capacidad lo que hoy está repartido entre dos scripts. |

### 17.1 Riesgo adicional de versionado de bootstrap

El script bootstrap-entorno-persistente.ps1 descarga bootstrap-cibercafe-cli.ps1 desde el commit histórico 14756d289f1ddc4c74c6736f5aa021121158541c y valida un hash hard-coded. Ese anclaje hace la base reproducible, pero también la mantiene congelada deliberadamente en una versión antigua mientras el archivo actual en main puede cambiar. El próximo cambio debe resolver explícitamente la estrategia de releases: pin de una versión coordinada/documentada o pin actualizado desde el proceso de publicación. No permitir que el orquestador se presente como actualizado mientras ejecuta silenciosamente una base antigua. No sustituirlo por latest sin hash.

### 17.2 Repositorios y manifiestos

La inspección del árbol actual de SeryMente/GDP encontró manifest.json en la raíz del repositorio. La inspección de SeryMente/signal-interpreter encontró extension/manifest.json, coherente con exportar la carpeta extension a la raíz de la extensión consumible. El bootstrap actual solo comprueba existencia de manifest.json en GDP; la siguiente implementación debe parsear JSON y validar campos obligatorios/versiones, además de verificar HEAD y árbol exportado. La lista real de repositorios y sus ramas debe verificarse de nuevo antes de la descarga, porque main puede avanzar después de esta auditoría.

### 17.3 Notepad++: bloqueo de implementación actual

No se encontró en ninguno de los dos bootstraps una instalación o configuración de Notepad++. El cambio debe instalarlo solo cuando falte, registrar versión/ruta y comprobar asociación predeterminada para cada extensión acordada. La función oficial de asociaciones de Notepad++ existe, pero en un Windows compartido la configuración puede requerir elevación o confirmación del usuario; no escribir a ciegas UserChoice ni declarar predeterminado sin una consulta posterior. En sesión Cybernet, tratar el resultado como volátil y revalidarlo en cada arranque.

### 17.4 Cámara y RDC: no confundir fases

El flujo actual de OBS puede confirmar un evento reciente en el log y un rescan PnP; no comprueba que Chrome exponga el dispositivo a una sesión real ni que un permiso normal permita abrirlo. El próximo gate requiere prueba a nivel de Chrome. Mantener fuera del bootstrap el helper actual que altera perfiles/políticas y desarrollar una comprobación no invasiva separada, respetando permisos y controles de la aplicación objetivo.

En cuanto a RDC, ambos scripts ejecutan el cliente en primer plano, pero el análisis estático no encontró una extracción fiable de los campos finales del handshake ni el copy de la ficha RDC. La siguiente versión debe parsear datos de esta ejecución en vivo y fallar explícitamente ante formato cambiado, IDs ausentes o estado no Online. El copy al portapapeles se hace solo después del gate; nunca guardar códigos temporales o credenciales.

### 17.5 Resultado del ciclo

- **Verificado:** SI fresco; hashes/blobs actuales leídos; estructura de archivos y presencia de funcionalidades comprobada estáticamente.
- **Bloqueado/no verificado:** ejecución real de los scripts en la terminal; cámara detectada por Chrome; asociación de Notepad++; nueva ficha RDC; salida del agente de rendimiento; almacenamiento duradero.
- **Sin cambios locales o de hardware:** el trabajo en este ciclo es documental y en GitHub. No se hicieron instalaciones, no se editó Chrome, no se manipuló el ZIP de Divi ni se reinició ningún equipo.



---

## 18. Entrada del usuario verbatim: alcance fundacional actual

> Enduredelo un turno, verifica su integridad, y Todo, mira, llevo un tiempo tratando de tener este entorno persistente y no lo he podido lograr, y es algo básico. Entonces sí necesito poderlo perfeccionar. Así que en este nuevo esfuerzo vamos a tratar de irlo haciendo por secciones. Identifica dentro de tu estrategia general para entorno persistente cuáles son los elementos fundacionales. De momento nada más voy a estar trabajando cibercafé, cibernet, Luis Pasteur. ya sabes cuáles son las características de la ubicación. y este, debo de poder llegar y reiniciar la sesión persistente sin fallos y de manera fluida. Debo de poder levantar la sesión RDC en cada sesión para esta ubicación. Debo de poder instalar OBS cámara virtual, debe de quedar la cámara virtual ya detectada por Chrome, debe de descargar la carpeta de trabajo a escritorio con todos los repositorios y las extensiones para gestor de procesos y Signal Interpreter en su versión más actualizada. Debe de descargar Notepad++ y hacerlo el programa predeterminado. Esos son los elementos fundacionales para esta ubicación, ayúdame a tenerlos para que funcionen de manera fluida. El registro de eventos es importante para que podamos perfeccionarlo porque sí va a haber uno que otro error, pero al cabo de un par de ciclos de desarrollo ya debería de quedar esta parte antes de pasar a otros elementos del entorno de persistencia.

Esta entrada fija el alcance de prioridad de la Fase Fundacional y complementa los requisitos verbatim anteriores. Las decisiones de seguridad, privacidad, ausencia de reinicios, persistencia no certificada y gates de aceptación se formalizan en las secciones 16 y 17 sin reinterpretar el texto anterior.


---

## 19. Ciclo operativo: revisión local de la interfaz EP de KHORA y publicación (2026-10-09)

**Estado del ciclo:** UI de revisión local disponible por loopback; autenticación demo local verificada mediante CLI; operaciones reales de lanzamiento deliberadamente desactivadas en esta vista; publicación nueva en Vercel limitada; persistencia física de EP no certificada.

### 19.1 Narrativa de versión · Antes → Cambio → Motivo → Resultado

- **Antes:** el hilo disponía de un servidor local en el puerto 3000 y de una ruta de producción cuyo deployment más reciente no estaba listo. La interfaz EP dependía de configuración de Auth.js/OIDC y sus llamadas de catálogo, sesión y observabilidad fallaban cuando faltaban variables de entorno y base de datos. El procedimiento local previamente recordado —acceso local sin OIDC, limitado a loopback— no estaba presente de forma verificable en el checkout actual.
- **Cambio:** se añadió un modo de demostración para desarrollo que exige simultáneamente `NODE_ENV=development` y `KHORA_LOCAL_DEMO_MODE=1`; usa un proveedor Auth.js `local-demo` solo en esa configuración, valida que el host sea `localhost`, `127.0.0.1` o `::1`, genera un secreto de sesión aleatorio por proceso y fija el servidor en `127.0.0.1`. El launcher CLI `khora-web/scripts/start-local-demo.mjs` limpia los flags de Playwright y `AUTH_SECRET`, inicia Next.js en un puerto libre desde el 3001 y escribe registro en `%USERPROFILE%\Desktop\log.txt`. El modo de revisión usa `.next-local-demo`, presenta un aviso visible de solo lectura, suprime las consultas del panel de EP y la telemetría global, y deshabilita la emisión de tokens y el arranque del entorno.
- **Motivo:** permitir inspeccionar la interfaz de KHORA sin depender de un proveedor OIDC remoto ni convertir un bypass de pruebas Playwright en mecanismo de acceso normal. La vista debe ser honesta sobre sus límites: el acceso visual no demuestra que existan base de datos, permisos GitHub, persistencia de datos, VHDX o BitLocker disponibles.
- **Resultado:** el flujo Auth.js de demostración respondió por loopback; el proveedor expuesto fue únicamente `local-demo`; la ruta de seguridad EP respondió HTTP 200 cuando se envió la cookie de sesión de prueba mediante CLI; TypeScript no reportó errores y el contrato de navegación pasó. La UI puede revisarse en la misma terminal que ejecuta el servidor. Esta implementación de revisión no emite ni simula credenciales de bootstrap.

### 19.2 Comandos y acceso de la sesión

Desde `C:\Users\PC 7\Desktop\Entorno Persistente\khora\khora-web`, el launcher se inicia por CLI:

```powershell
npm run local:demo -- 3001
```

El enlace de acceso local de esta sesión es `http://127.0.0.1:3001/auth/signin`. Al pulsar **Entrar en modo local**, abrir `http://127.0.0.1:3001/sistema/seguridad?tab=entorno-persistente`. Estos URLs son efímeros y locales a la terminal; no son un servicio público ni una URL canónica de producción. No abrir ni conducir la interfaz mediante RDC: RDC se limita a CLI; la inspección visual la realiza el usuario en el navegador de la propia terminal.

La vista local no consulta `/api/ep/repos`, `/api/ep/token` ni `/api/ep/logs`, no ejecuta el bootstrap y no envía `/api/observaciones/runtime-state`. No inventa repositorios, sesiones, tokens o resultados de persistencia. El catálogo, la emisión y la bitácora remota solo se reactivan en el flujo operativo normal con su configuración real, no dentro de este modo.

### 19.3 Separación de OIDC y la autenticación real

La excepción de autenticación es exclusivamente de desarrollo y loopback. Producción mantiene el proveedor OIDC original; `PLAYWRIGHT_TEST_RUN` y `PLAYWRIGHT_TEST_BYPASS` se eliminan del proceso local. No se reutiliza `AUTH_SECRET` ni credencial de OIDC de producción. El secreto `KHORA_LOCAL_DEMO_SECRET` se genera aleatoriamente al iniciar, solo se pasa al proceso hijo por su entorno y no se registra. La contraseña maestra de EP, el PAT de GitHub y una sesión local de demostración son credenciales distintas; la demo no habilita la custodia o recuperación del PAT.

La implementación local de revisión está en el árbol de trabajo de esta terminal. No se ha publicado el cambio de código de KHORA, no se ha modificado el deployment de producción ni se afirma que el cambio local sobreviva a una sesión volátil hasta que se integre y verifique desde el repositorio de KHORA.

### 19.4 Evidencia de Vercel

El deployment de producción más reciente consultado, `dpl_5KjFtipEd88pnpKorU5jMFajmNsW`, se creó desde `SeryMente/khora` commit `5ececf8f7977b8423d61ef4f1acbd3f0c54d2856` y terminó en `ERROR` por error sintáctico en `khora-web/lib/ui-review/registry.ts`. La rama actual de KHORA consultada está en `e2d89dbdc7aa0f537cea94188abdecb5e99215a3`; incluye la corrección de sintaxis `0a39692` y la versión web `0.3.8`. Un nuevo intento explícito de deployment de producción desde este HEAD fue rechazado por Vercel con HTTP `402 payment_required`, recurso `api-deployments-free-per-day`, `retryAfter=86400` (>100 deployments/día). No se cambió el plan, la facturación ni la configuración de seguridad. No crear otra identidad, equipo o proyecto para evitar la restricción. El deployment anterior `dpl_9wegjRrLbkVGiFcdQuKyp6R6tJgd` existe como `READY` para `b94e05f7a3f8e8bb3d48bf635054fd3b44702c4c`, pero no fue promovido de nuevo y no sustituye la verificación de la versión actual.

### 19.5 Registro de validación y límites

| Control | Resultado | Evidencia/limitación |
|---|---|---|
| Launcher Node.js | PASS | `node --check scripts/start-local-demo.mjs` |
| TypeScript | PASS | `tsc --noEmit`, salida 0 tras los cambios locales |
| Contrato de navegación | PASS | `npm run ui:contract` |
| Auth.js local | PASS | `/api/auth/providers` listó solo `local-demo`; inicio de sesión CLI creó sesión `khora-local-demo@localhost` |
| Binding de red | PASS | puerto 3001 escucha en `127.0.0.1`, sin listener en `0.0.0.0` ni `::` |
| UI Review gate | FAIL no atribuible a este modo | `npm run ui-review:check` detectó un `onClick` en elemento no semántico en el archivo preexistente modificado `PipelineView.tsx`; no se amplió el alcance para corregirlo |
| Suite unitaria | FAIL parcial | `334/345` tests pasaron; 11 fallaron en rutas/contratos de Ingesta/Custody y sincronización del contrato metodológico local `v1.7.6` frente al canónico `v1.7.7`. La suite no se certifica completa |
| Integración real del launcher EP | NO VERIFICADA | El modo visual no conecta base de datos, catálogo GitHub o bitácora remota; no se intentó crear un token de bootstrap |
| Persistencia VHDX/BitLocker/Deadman | NO VERIFICADA | No hay prueba nueva de junction, volumen cifrado, destino privado ni recuperación |
| Deployment de producción | LIMITADO | Vercel rechazó el intento de publicación por el límite diario de la cuenta |

Las cuatro modificaciones que ya existían en el checkout local al comenzar el ciclo (`IngresoWorkspace.tsx`, `PipelineView.tsx`, `app/sistema/volcados/page.tsx` y `lib/ui-review/states.ts`) se conservaron. No se mezclaron con el modo de revisión. Las modificaciones de revisión que quedan locales tampoco deben presentarse como canonizadas en el repositorio de código: la canonización de este apartado preserva la decisión, el procedimiento y la evidencia en Metodología.

### 19.6 Decisión operativa vigente

Hasta que el usuario revise la interfaz local, **no continuar con las demás líneas del esfuerzo**. Mantener el servidor loopback disponible para esa revisión. Aceptar comentarios de UI antes de preparar un cambio de código para KHORA. La limitación de Vercel deja solo la publicación remota pendiente; la revisión local sigue disponible. No declarar el Entorno Persistente completado, no afirmar persistencia física y no emitir tokens ni lanzar un entorno real en modo demo.


---

## 20. Ciclo operativo 005: UI de bóveda GitHub cifrada y puerta maestra OEP (2026-10-09)

**Versión del objeto:** v1.1.5 — EP v1.0: Alcance Mínimo y Gates.
**Tipo de trabajo de este ciclo:** inspección documental y de código fuente en GitHub; no se usaron RDC, Vercel ni un runtime local. No se cambió el despliegue ni se afirma que exista una implementación operativa del nuevo acceso.
**SI transversal:** v1.6.21 — Ordenamiento por Preponderancia y Categorías; referencia de lectura: ccb0258f5571b9f8a5533a2a17a32c3ce554c294.

### 20.1 Narrativa de versión · Antes → Cambio → Motivo → Resultado

- **Antes:** el panel EP de KHORA exigía sesión OIDC/Google para emitir la sesión y leer el catálogo. El comando PowerShell generado usaba un token KHORA temporal para descargar el gate, pero después pedía un PAT de GitHub por portapapeles si GitHub CLI no estaba autenticado. El token de KHORA y el PAT son credenciales distintas. OEP ya nombraba la contraseña maestra como intención, pero no tenía criterios completos de aceptación ni una bóveda de PAT administrable desde la UI.
- **Cambio:** en la rama `feat/ep-github-token-vault-ui` se implementa una UI de Cora para cargar, validar, rotar y borrar un PAT; cifrado server-side AES-256-GCM; entrega del secreto solo a una sesión EP con scope `ep:github:token`; catálogo de workspace conectado a la bóveda; puerta de contraseña maestra limitada a EP; y sustitución del prompt del portapapeles por recuperación HTTPS mediante el `apiBase` ya configurado. Se actualizó el PowerShell embebido para que coincida con `scripts/khora/khora.ps1`, se añadieron migración y pruebas estáticas. No se crea una GitHub App ni se cambia el path canónico existente.
- **Motivo:** atender la aclaración del usuario: la ruta ya existe; la carencia era una interfaz segura para introducir el PAT, cifrarlo y hacerlo disponible al PowerShell servido por Cora, sin reingresarlo al arrancar en Cybernet.
- **Resultado al cierre de aquel subciclo:** la propuesta estaba en PR #292, rama `feat/ep-github-token-vault-ui`, con cabecera observada entonces `8f0b3f24e0a9c323f8ae9aec4f739caeadb5408e`. Los ciclos posteriores endurecieron la frontera OIDC, el fallback de la bóveda y la ruta de acceso; el estado vigente se registra en 20.9 y 21.5. Se reintentaron desde GitHub los workflows fallidos `CI`, `Khora Single Script Guard`, `khora-ok / gate` y `UI Quality`; todos volvieron a fallar y los logs de los jobs no existen en el almacenamiento consultado (404 `BlobNotFound`). No hay prueba real en Windows PowerShell 5.1. No se cargó PAT/contraseña real, no se aplicó la migración y no se certifica operación end-to-end en producción.

### 20.2 Evidencia inspeccionada

- KHORA auth.ts: proveedor OIDC; SHA blob observado dc87c3cfa142bd01f46c2a26577f7923c5e0f58a.
- KHORA khora-web/app/api/ep/token/route.ts: GET y POST dependen de auth() e isEpUserAllowed; SHA blob observado 9195a357b615ba2658f1ec5e547fa2ff39a6ece6.
- KHORA khora-web/lib/server/ep.ts: el catálogo web usa GITHUB_TOKEN del entorno de servidor; no debe exponerse al cliente; SHA blob observado 4b93221b1e43e739b6c0b91b0fb7a4fca3c7526d.
- KHORA ep-medio-architectura.md: arquitectura canónica v1.0.4, SHA blob observado 382e4a929a984a96926fd6f9080f80bedd109a0b.
- KHORA OEP.md: puerta OEP Master Password en estado de diseño y OEP-PENDING-001 abierto; SHA blob observado antes del intento de escritura 362f878237045e6a88e905b8e561c9dba4e0c4d9.
- Metodología bootstrap scripts/bootstrap-entorno-persistente.ps1: blob observado 04a442f1f735e0fd1a2a3aeceb30b1e49f38996f, 41 147 caracteres y 583 líneas. Solicita el PAT vía portapapeles, verifica los cinco repositorios por API y git ls-remote, mantiene configuración Git efímera y limpia variables antes de arrancar procesos secundarios. El SHA-256 incluido en el comando se conserva como dato aportado por el usuario; no se declara recalculado en este ciclo.
- Lista exacta del bootstrap de referencia: SeryMente/metodologia, SeryMente/otrogranprograma, SeryMente/GDP, SeryMente/signal-interpreter y SeryMente/khora.

### 20.3 Contrato técnico obligatorio

1. La URL canónica de KHORA debe permitir entrar a la puerta EP con contraseña maestra sin iniciar Google OIDC, mediante autorización específica, expirable, revocable y de mínimo privilegio. Las páginas y APIs generales continúan protegidas por OIDC; ocultar pestañas no sustituye autorización de servidor.
2. El verificador maestro se configura fuera del repositorio y nunca almacena la contraseña en claro. Debe usar una KDF resistente, sal aleatoria, límites de intentos, bloqueo/backoff, rotación, revocación y recuperación segura. Los fallos no revelan cuentas, estado de repositorios ni detalles de configuración.
3. La sesión EP debe emitir un JWT de alcance limitado. El PowerShell servido por KHORA recupera el PAT con `GET /api/ep/github-token` usando el `apiBase` existente y el JWT con scope `ep:github:token`. El secreto no forma parte del comando, URL, argumentos de proceso ni logs; el launcher lo mantiene en memoria y lo protege con DPAPI dentro del volumen cifrado. No se crea un path canónico alternativo ni una credencial de instalación GitHub App.
4. El PAT ya existente se administra en la UI de Cora y se cifra con AES-256-GCM en el servidor. Nunca se devuelve a la UI después de guardarlo. La clave se deriva con separación de dominio de `EP_BOOTSTRAP_JWT_SECRET`; si esa raíz se rota, hay que cargar nuevamente el PAT. La UI solo muestra cuenta, últimos cuatro caracteres, repositorios validados y fecha; nunca el secreto.
5. El contrato actual valida por API el usuario y seis repositorios necesarios para bootstrap/workspace: `CENSUS`, `GDP`, `metodologia`, `otrogranprograma`, `signal-interpreter` y `khora`. El catálogo de workspace expone los cinco repositorios de trabajo y conserva `khora` como el repositorio del propio bootstrap. La inspección de metadata no demuestra por sí sola los scopes efectivos de escritura de un fine-grained PAT; hay que asegurar `Contents: Read and write` y `Metadata: Read` en todos los repositorios y verificar un push real antes de certificar escritura.
6. Preservar compatibilidad con el bootstrap de referencia hasta que la vía nueva pase una matriz equivalente en Windows PowerShell 5.1: pin de commit y hash SHA-256, detección de herramientas, mutex anti-duplicación, cinco repositorios, preservación de directorios/archivos WIP, limpieza de secretos, comprobación posterior y arranque real. No declarar ausencia de regresiones a partir de inspección estática.
7. La instanciación funcional es la primera prioridad de aceptación. La volatilidad y limpieza siguen siendo requisitos de EP y no se eliminan por la presencia de Deep Freeze. Se puede priorizar su validación después de demostrar el arranque inicial, sin declarar completado EP.
8. La vía maestra no concede acceso general a KHORA ni permite usar una sesión EP temporal para eludir la autorización de endpoints no EP. No persistir credenciales en logs, DOM, historial de PowerShell, argumentos de proceso ni configuración Git.

### 20.4 Comando de referencia aportado por el usuario (verbatim)

```powershell
$ErrorActionPreference='Stop'; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $u='https://raw.githubusercontent.com/SeryMente/metodologia/ccb0258f5571b9f8a5533a2a17a32c3ce554c294/scripts/bootstrap-entorno-persistente.ps1'; $f=Join-Path $env:TEMP 'bootstrap-entorno-persistente.ps1'; Invoke-WebRequest -UseBasicParsing -Uri $u -OutFile $f; $h=(Get-FileHash -LiteralPath $f -Algorithm SHA256).Hash; if($h -ne 'DCD96B217E4FB236ABDE40641303CC2EEAC40142F5A140F8D9F5DA6D4F0CCF75'){Remove-Item -LiteralPath $f -Force -ErrorAction SilentlyContinue; throw 'BOOTSTRAP_SHA256_MISMATCH'}; $ps=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'; & $ps -NoProfile -ExecutionPolicy Bypass -File $f
```

Este comando es la referencia aportada para Windows PowerShell 5.1; el bootstrap que descarga todavía solicita el PAT. No se afirma que por sí solo cumpla el nuevo requisito de no pedirlo.

### 20.5 Solicitud del usuario verbatim

> Ok, mira, vamos bien. Este, nada más había un pequeño... bueno, vamos bien. reitero que todo tiene que ser a cada ciclo, tienes que ir actualizando el objeto canónico del sprint en el repositorio de metodología para que siempre estemos en contexto, siempre estemos en contexto. Este, incluye lo de Versel y todo para que únicamente con revisar ese objeto podamos retomar la tarea. Entonces, ya quedó eso. Dale una endurecida al requerimiento de que la interfaz de Cora permita tener el token de GitHub especialmente diseñado para que tengamos acceso a todos los repositorios que tenemos que tener acceso, para que el comando de PowerShell que nosotros utilicemos a través de la puerta vía contraseña maestra en la implementación de Versel, que es... o sea, esto va a estar en Versel para que yo nada más llegue, por ejemplo, y me siente en Cybernet y me maneje para poder entrar a mi cuenta de Google, que es la que me permite... o mejor dicho, nada más abra Chrome, ingrese la URL canónica de Cora y sin tener que ingresar a mi cuenta de Google, utilizando la contraseña maestra, pueda extraer un comando de PowerShell que ya tenga lo que necesite para que no me vuelva a pedir el token de GitHub y que al correrlo instancie todo el entorno persistente para empezar. Para empezar me interesa que lo instancie. La volatilidad todavía no es como que... bueno, tiene que traerla, es necesario, pero no me interesa mucho porque ya de por sí las computadoras de este lugar tienen un mecanismo tipo Deep Freeze que hace que las sesiones sean efímeras y de momento me interesa que arranque el sistema. ¿Sí? Te voy a pasar entonces un... te voy a pasar un comando que ya se sabe que funciona a la perfección y tiene varias características. analízalo cuidadosamente para que sea para que por lo menos funcione al nivel que funciona este comando. Lo único que yo le ingreso a este comando es el token de GitHub. Todo lo demás funciona a la perfección. No quiero regresiones, es importante que no haya regresiones. Entonces básicamente, como mínimo, deja todo hasta ese punto. Ya me voy a desconectar y no vas a tener RDC disponible. trabaja únicamente con GitHub y resuelve lo de extremo a extremo y no te detengas hasta terminar, pase lo que pase. Máximo grado de implacable rigurosidad en la atención al detalle y la calidad y sobre todo ve registrando todo lo que es verbatim que yo haya dicho para que lo tengas como especificación canónica cuando tengas que tomar decisiones.

> Una vez más resuelve de extremo a extremo y no te detengas hasta terminar sin excusas y sin RDC únicamente trabajo en GitHub y en Cora nada de Vercel ni implementación local puro trabajo en los repositorios conforme a lo que te acabo de decir vuelvo en una media hora.

### 20.6 Estado y reanudación

- Este ciclo no ejecutó Vercel ni un runtime local y no usó RDC. No se integró la rama en `main` para evitar disparar el workflow existente de despliegue.
- PR #292 permanece abierto y draft: https://github.com/SeryMente/khora/pull/292. Rama `feat/ep-github-token-vault-ui`; cabecera observada al cierre del ciclo 009 `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`. La arquitectura de rama es v1.0.7, OEP es v0.1.9 y este objeto es v1.1.6.
- La UI gestiona el PAT en un campo temporal del navegador; el servidor valida el acceso requerido, persiste solo ciphertext AES-256-GCM, y no lo devuelve por el endpoint de administración. El endpoint de entrega solo admite un JWT EP válido con scope `ep:github:token` y usa no-store. El catálogo consulta primero la bóveda y usa `GITHUB_TOKEN` solo como compatibilidad. El launcher obtiene el token por el `apiBase` existente y ya no solicita pegarlo en el portapapeles.
- La contraseña maestra OEP usa scrypt, salt aleatorio, pepper derivado por ámbito, comparación constante, límite de ocho intentos fallidos por origen hasheado cada 15 minutos y cookie firmada de 15 minutos limitada a EP. Alta/rotación requiere una sesión OIDC autorizada; el uso diario del submódulo EP puede entrar por contraseña maestra sin convertirla en autenticación general de KHORA.
- `ep-integrity-manifest.sha256` conserva 607 entradas. Se refrescaron los hashes conocidos de los archivos de este ciclo; las entradas no relacionadas no fueron recalculadas en bloque, por lo que no se declara una verificación integral del manifiesto completo.
- GitHub registra como fallidos `CI`, `Khora Single Script Guard`, `khora-ok / gate` y `UI Quality` para la cabecera indicada. La herramienta no pudo recuperar los logs de los jobs (404 BlobNotFound); no se debe afirmar que los fallos están corregidos ni que las pruebas pasaron. Los checks externos Vercel/Netlify también aparecen fallidos; no se ejecutó ningún despliegue.
- No se cargó un PAT real ni se configuró una contraseña maestra real; no se aplicó la migración `017_ep_github_credential_vault.sql` en el runtime y no se probó el arranque real con Windows PowerShell 5.1. Para uso operativo deben integrarse los cambios en un ciclo autorizado, aplicar la migración mediante el flujo de despliegue permitido, configurar contraseña maestra desde OIDC, cargar el PAT, y verificar un arranque completo y una escritura efectiva a las ramas/repositorios pertinentes.
- `OEP-PENDING-001` permanece abierto hasta que CI, migración, permisos efectivos de escritura, PowerShell 5.1 E2E y seguridad de las rutas hayan quedado verificados. El PR en draft no equivale a aceptación ni despliegue.
- Regla de ciclo: actualizar el objeto canónico al cierre de cada ciclo con narrativa Antes → Cambio → Motivo → Resultado, cambios, hashes/commits, evidencia, fallos, bloqueos y punto de reanudación. Un resumen de chat no sustituye este registro.

### 20.7 Aclaración del usuario verbatim

> Ok, estaba revisando los comentarios de tu razonamiento y me di cuenta que estabas trabajando para resolver la necesidad de un path. Ese path yo ya lo tengo configurado y de hecho lo único que te estoy pidiendo es que me des interfaz en la UI de Cora para poder cargar el token de manera segura, conforme es un secreto, guardarlo, encriptarlo y hacerlo disponible para que se utilice mediante el comando de PowerShell que Cora va a servir. Esto debería de zanjar cualquier duda que tengas al respecto o me equivoco?

### 20.8 Ciclo operativo 006 — Compatibilidad de tokens GitHub y reintento de CI

- **Antes →** el cambio inicial aceptaba PAT clásicos y granulares, pero excluía el prefijo OAuth `gho_` aunque el bootstrap anterior ya lo admitía. La cabecera `009fc2d5952285193e45732b52de92f95d545e55` seguía marcada con fallos de workflows y el conector no permitía leer sus logs.
- **Cambio →** se restauró `gho_` en la validación del token en servidor y PowerShell; se actualizó la UI, la redacción de secretos, la prueba de contrato y la arquitectura para documentar `ghp_`, `github_pat_` y `gho_`. Se regeneró el PowerShell embebido desde el fuente y se verificó igualdad tras normalizar finales de línea. Se actualizó OEP a `v0.1.7` y su hash dentro del manifiesto de 606 entradas.
- **Motivo →** preservar compatibilidad del flujo ya configurado y evitar que la nueva bóveda obligue a cambiar la credencial que ya funciona con el launcher.
- **Resultado →** cabecera de PR observada `8f0b3f24e0a9c323f8ae9aec4f739caeadb5408e`. Se reintentaron en GitHub los cuatro workflows y todos volvieron a fallar: CI (#2525), UI Quality (#306), Khora Single Script Guard (#118) y khora-ok / gate (#572). Los siete jobs fallidos devolvieron 404 `BlobNotFound` al recuperar los logs, por lo que la causa exacta no está demostrada. El manifiesto se actualizó para los archivos tocados; los demás hashes preexistentes no se recalcularon integralmente. No se desplegó, no se integró `main`, no se cargaron secretos reales y no se probó PowerShell 5.1. `OEP-PENDING-001` permanece abierto.


### 20.9 Ciclo operativo 009 — Separación OIDC, origen y bóveda fail-closed

- **Antes →** la primera propuesta permitía administrar el token persistente también con la cookie maestra, podía caer a `GITHUB_TOKEN` si la bóveda no podía leer/descifrar y la ruta de acceso `/auth/ep` no estaba declarada como excepción del contrato de navegación. Además, el POST que emite la sesión EP no exigía un origen coincidente cuando su principal era la cookie maestra.
- **Cambio →** cargar/rotar/borrar la credencial GitHub ahora requiere OIDC autorizado; la sesión maestra solo consulta estado redactado y puede usar el token durante el bootstrap. La UI oculta los controles administrativos cuando `canManage` es falso. La emisión por cookie maestra requiere `Origin` coincidente. El catálogo solo usa el token de entorno legado si la bóveda responde correctamente y confirma que no hay credencial; los errores de almacenamiento o descifrado fallan cerrados. `/auth/ep` se añade a `NAVIGATION_EXEMPT_ROUTES` y una prueba de contrato protege esa regla. Arquitectura actualizada a v1.0.7, OEP a v0.1.9 y el manifiesto a 607 entradas con las huellas de los archivos cambiados recalculadas.
- **Motivo →** limitar autoridad de la contraseña maestra, evitar cambios silenciosos de credencial y dejar el contrato de navegación consistente con la nueva puerta de OEP.
- **Resultado →** cabecera observada `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`, PR #292 abierto y draft. En esa cabecera `CI`, `Khora Single Script Guard`, `khora-ok / gate` y `UI Quality` finalizaron en fallo. El conector no ofrece sus logs ni pasos; la variante temporal de diagnóstico también falló sin producir pasos, logs ni artefactos y fue retirada. El manifiesto conserva 607 entradas y se actualizaron los hashes de OEP, arquitectura, catálogo, API de token, registro de navegación y pruebas. Esto no constituye una validación de todos los hashes restantes ni evidencia de CI aprobada. No se integró `main`, no se desplegó, no se usó RDC ni runtime local, no se cargaron secretos reales, no se aplicó la migración a producción y no se ejecutó PowerShell 5.1 real. `OEP-PENDING-001` permanece abierto.

### 20.10 Solicitud del usuario verbatim — progreso y ausencia de RDC

> En este momento no esta RDC activo, pero no lo necesitas verdad? Empieza no te detengas hasta terminar. Reportame en tu razonamiento peridoicamente tiempo estimado para terminar. Y reporta progreso feneral, siempre.

## 21. Ciclo operativo 010 — Inventario integral del EP y planificación de fases

**Corte:** 2026-10-09 (UTC de GitHub puede mostrar actividad del 2026-10-10).
**Ámbito:** inventario del EP completo, con fronteras entre lo implementado, lo preparado, lo no verificado y las capacidades posteriores. Este ciclo es documental y de planificación; no afirma funcionamiento físico.
**Estado de entrada:** PR #292 sigue abierto en draft, cabecera de código `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`. Arquitectura KHORA en la rama v1.0.7; OEP v0.1.9; CI no certificado; migración 017 sin aplicar al entorno productivo; sin prueba de Windows PowerShell 5.1 E2E.

### 21.1 Narrativa de versión · Antes → Cambio → Motivo → Resultado

- **Antes →** los elementos de EP existían distribuidos entre el launcher KHORA, la arquitectura OEP, la especificación de Metodología, el bootstrap histórico y las futuras líneas fundacionales de Cybernet, WP-LAB y OGP-Visual. La continuidad podía interpretarse como una única instalación, cuando en realidad contiene varios subsistemas y dependencias con estados de validación distintos.
- **Cambio →** se enumeran las capas, sus interfaces, sus límites y sus gates; se propone una secuencia por fases que prioriza un arranque básico verificable antes de infraestructura pesada, persistencia avanzada y modelos de IA.
- **Motivo →** evitar omisiones entre el acceso web, la sesión PowerShell, la identidad de cada terminal, el workspace cifrado, herramientas, observabilidad, limpieza y las capas de trabajo posteriores.
- **Resultado →** este inventario es el checklist transversal para planificar los próximos ciclos. No cambia el alcance inmediato de PR #292 ni reemplaza los contratos técnicos de KHORA. Todo elemento sin evidencia física debe permanecer como PREPARADO, BLOQUEADO o NO VERIFICADO, nunca como PASS.

### 21.2 Inventario integral de elementos del EP

Los siguientes números identifican componentes del sistema, no el orden temporal de instalación. Los elementos 1–23 componen la capa fundacional y operativa; WP-LAB y OGP-Visual son capas posteriores que dependen del gate fundacional.

1. **Plano de control canónico y continuidad.** Repositorio público `SeryMente/metodologia` para especificaciones, decisiones, runbooks, fases, estado, bloqueos, manifiestos saneados y trazabilidad entre conversaciones. Cada ciclo debe dejar el número/nombre de versión, narrativa Antes → Cambio → Motivo → Resultado, evidencia y punto de reanudación. No publicar secretos, dumps, contenido privado ni binarios propietarios.

2. **Arquitectura de KHORA/OEP y contratos de implementación.** `SeryMente/khora` mantiene UI, API, launcher, migraciones, pruebas y manifiestos de integridad. La arquitectura OEP define el comportamiento y se enlaza desde este objeto transversal; cualquier divergencia entre los contratos se debe reconciliar, no resolver por inferencia.

3. **URL canónica y API base existente.** La interfaz se sirve en la URL canónica de Cora y reutiliza el `apiBase` actual que termina en `/api/ep`. No inventar un segundo path ni modificar la ruta existente para solucionar el almacenamiento de credenciales.

4. **Identidad global y acceso rápido OEP.** OIDC conserva la identidad primaria de KHORA y la administración de seguridad. La contraseña maestra abre únicamente el submódulo EP mediante una sesión específica, breve y revocable; no sustituye OIDC para el resto del sistema. La primera configuración/recuperación de la contraseña maestra requiere OIDC.

5. **Bóveda del token de GitHub.** Entrada del PAT mediante campo protegido en la UI; validación server-side; almacenamiento solo como ciphertext AES-256-GCM; metadatos limitados a cuenta, sufijo, repositorios/permiso observado y fecha. La clave se deriva con separación de dominio de `EP_BOOTSTRAP_JWT_SECRET`; su rotación requiere recargar el PAT. El token no se devuelve al navegador después de guardarlo.

6. **Autorización y fronteras de la bóveda.** Consultar estado no sensible y consumir el token para iniciar EP son capacidades distintas de administrar el secreto. Carga, rotación y borrado requieren OIDC autorizado; un JWT EP con scope `ep:github:token` puede solicitar la credencial para el bootstrap. Los endpoints de cookie maestra que emiten sesión validan el origen cuando corresponda. La bóveda falla cerrada si no se puede consultar/descifrar; no cambia silenciosamente a otra identidad.

7. **Credenciales diferenciadas y comando sin secreto.** El token temporal de KHORA, la contraseña maestra OEP, el PAT GitHub, la llave del volumen cifrado y una sesión RDC son credenciales/artefactos distintos. El comando visible no debe contener el PAT; no se permite en URL, argumentos de proceso, historial, HTML, logs o repositorios. El clipboard no debe usarse para volver a introducir el PAT.

8. **Launcher y ejecución de Windows PowerShell 5.1.** Comando de bootstrap controlado, versión y commit fijados, hash SHA-256 comprobado, validación del path API HTTPS, proceso hijo/elevación controlada, errores estables y limpieza de temporales en éxito/fallo. La compatibilidad se debe probar en Windows PowerShell 5.1 real; parser moderno o revisión estática no sustituyen el arranque completo.

9. **Descubrimiento y clasificación del host.** Inspeccionar edición/build de Windows, arquitectura, privilegios, usuario interactivo, Escritorio real y escribible, disco/espacio libre, volúmenes, herramientas disponibles, señales de host administrado y política de uso de herramientas. Reutilizar toolchain instalado cuando sea válido; no reinstalarlo por defecto.

10. **Identidad de ubicación, terminal y sesión.** Mantener separadas la ubicación general (por ejemplo, Cybernet/Luis Pasteur), la identidad estable de la terminal física (por ejemplo, CIBERCAFE + PC-N), el usuario/perfil Windows y el identificador del dispositivo/sesión RDC. El cibercafé no es una única máquina; pueden existir varias terminales y sesiones concurrentes. Nunca usar el RDC-DEVICE-ID efímero como identidad estable de la terminal.

11. **Modelo de volatilidad y estado del EP.** Clasificar explícitamente el estado como EP_VOLATIL o EP_CIFRADO; una carpeta del Escritorio o una ejecución satisfactoria no acreditan persistencia. Deep Freeze hace que el estado local pueda desaparecer entre sesiones, pero no reemplaza la obligación de verificar cifrado, limpieza, recuperación y un destino remoto duradero cuando se requiera continuidad.

12. **Volumen cifrado y llave local.** Crear/montar un VHDX nuevo dentro del espacio autorizado; protegerlo con BitLocker XTS-AES-256; verificar cifrado al 100 % y ProtectionStatus=On antes de declarar PASS. Proteger secretos efímeros que deban sobrevivir entre procesos mediante DPAPI dentro del contexto y volumen correctos. El mecanismo de limpieza debe desmontar/bloquear el volumen de forma segura.

13. **Workspace y ruta visible.** Mantener una sola raíz de trabajo de la sesión dentro del volumen cifrado. `Desktop/EP` es una junction NTFS al workspace interno, no una segunda copia ni un almacén duradero; validar tipo y target exacto. Si ya existe y apunta a algo desconocido, fallar cerrado, no sobrescribir ni eliminar contenido desconocido.

14. **Repositorios Git y estrategia de releases.** Obtener repositorios privados por commit/versión aprobada; verificar `.git`, `origin`, rama, SHA, árbol de trabajo y actualizaciones fast-forward. No hacer resets forzados sobre árboles desconocidos y no perder WIP. El bootstrap debe evitar ejecutar silenciosamente un script base histórico cuando se presenta como versión nueva; los pins/hash deben actualizarse mediante proceso de publicación coordinado.

15. **Matriz de repositorios y extensiones.** La especificación OEP de la bóveda requiere acceso a `CENSUS`, `GDP`, `metodologia`, `otrogranprograma`, `signal-interpreter` y `khora`; el workspace de trabajo expone cinco y reserva `khora` como repositorio del bootstrap. Un bootstrap de referencia anterior enumera cinco e incluye metodología, otrogranprograma, GDP, signal-interpreter y khora, sin listar CENSUS. **No colapsar ni renombrar CENSUS/GDP por suposición:** la siguiente reconciliación debe confirmar si son repositorios distintos o un alias histórico de Gestor de Procesos. Para cada manifiesto, parsear JSON, validar campos/versiones y comprobar la equivalencia de las extensiones exportadas. La extensión Signal Interpreter parte de `extension/manifest.json` y se exporta con el manifiesto en la raíz consumible.

16. **Conservación de WIP y contexto de repositorios.** Crear/recuperar ramas `ep-wip/*` y persistir/verificar los cambios de KHORA y repositorios seleccionados. No sobrescribir contenido local, configuración Git de usuario ni archivos desconocidos. La continuidad de un entorno no equivale a clonar `main`: también exige preservar y recuperar trabajo en curso con evidencia.

17. **Perfil de Visual Studio Code.** Restaurar configuración, extensiones y workspace necesarios al materializar una instancia nueva. Determinar qué elementos pertenecen al perfil portable/usuario y cuáles al workspace cifrado. No guardar secretos en settings, archivos de workspace, logs o sincronización pública.

18. **Toolchain del host y Notepad++.** Detectar reutilizables (por ejemplo Git, Node 22 compatible, VS Code y herramientas requeridas). Instalar Notepad++ solo si falta; registrar la versión/ruta y verificar las asociaciones de `.txt`, `.log`, `.md`, `.json`, `.ps1` y fuentes objetivo. No manipular a ciegas `UserChoice` ni declarar aplicación predeterminada solo porque existe `notepad++.exe`.

19. **OBS Virtual Camera y gate de Chrome.** Preparar/validar OBS Virtual Camera y su detección por Windows; después demostrar que Chrome enumera y puede abrir la cámara mediante permisos normales en una prueba consentida. El evento del log de OBS o el rescan PnP no bastan. No modificar preferencias/políticas de Chrome, forzar permisos, cerrar el navegador a la fuerza ni simular presencia/liveness.

20. **RDC: lanzamiento, handshake e identidad de sesión.** Abrir una sesión RDC nueva cuando así lo exija el entorno de terminal efímero; validar estado Online mediante datos del handshake real, capturar los campos actuales y fallar explícitamente si faltan o cambia el formato. Solo después copiar una ficha saneada de sesión con terminal_id, fuente, RDC device name/ID, estado y hora, run_id, commit/hash de bootstrap, estados de cámara/Notepad++, cabezas de repos y ruta de logs. No copiar credenciales ni códigos temporales al clipboard.

21. **Bitácora estructurada y ventana de eventos en vivo.** Mantener registro humano y JSON Lines/NDJSON con timestamp, run_id, terminal_id, etapa, estado, duración, exit code, versión/SHA, error_code, referencia de evidencia, resumen técnico y siguiente acción. Los identificadores de etapa `EP-IN-*`, `EP-RUN-*` y `EP-OUT-*` deben ser estables. Lanzador e interfaz de eventos pueden vivir en ventanas hijas independientes; ninguna salida debe revelar PAT, contraseña, cookie, JWT completo o llave del volumen.

22. **Integridad, manifiesto y estado de aceptación.** Calcular/verificar hashes de scripts, artefactos y snapshots autorizados; asociarlos con commits y versiones. Los estados permitidos incluyen PASS, BLOCKED, FAIL, NOT_VERIFIED y SKIPPED. El resultado global no puede ser PASS si cualquier gate obligatorio está bloqueado o no verificado. Distinguir documentado, implementado, instalado, funcional, certificado y publicado.

23. **Deadman, guardian, salida limpia y reinicio inesperado.** Programar limpieza al reinicio; vigilar procesos/terminal según el contrato; cerrar procesos y quitar primero la junction conocida; bloquear/desmontar VHDX; eliminar temporales/DPAPI que no deban sobrevivir y limpiar restos volátiles. No borrar repositorios/WIP desconocidos ni artefactos remotos confirmados. En Cybernet rige `PRESUPUESTO-REINICIO=0`; pruebas de reinicio solo en host autorizado y ventana explícita.

24. **Persistencia remota y checkpoints duraderos.** Elegir un destino privado aprobado para logs completos, snapshots y contenido mutable que no puede publicarse en Metodología. Probar `put → read-back → SHA-256`, metadatos de snapshot y recuperación desde un entorno nuevo. Hasta demostrarlo, `REMOTE_CHECKPOINT=NOT_VERIFIED`; Deep Freeze no demuestra persistencia remota.

25. **Capa WordPress / Divi / WP-LAB.** Es una carga de trabajo posterior con sitio, snapshots, código recuperable de `SeryMente/serymente`, WordPress Studio, Node/PHP, plugins/MU-plugins, dependencias y pruebas de rutas. Encontrar activos en modo de solo lectura, proteger el original, comprobar hashes antes de rehidratar, probar restauración en staging y las rutas acordadas. Divi es un binario propietario y no se sube al repositorio público. Resolver explícitamente la divergencia registrada entre Divi 4.23.1 y referencias históricas a 4.24.0; no elegir equivalencia sin una decisión/validación autorizada.

26. **Capa OGP-Visual e IA local en GPU.** Capacidad posterior y separada del arranque básico: preflight de host/GPU/memoria/runtime, compatibilidad de drivers/Python/CUDA, infraestructura seleccionada (ComfyUI/Nunchaku/Z-Image-Turbo/Qwen-Image-Edit), caché recuperable de artefactos pesados, modelos/pesos versionados, generación/edición/evaluación y TEST 01. No descargar varios GB cada sesión efímera ni ejecutar inferencia hasta recuperar un entorno consistente y pasar el gate de hardware. No editar los artefactos visuales canónicos ni el sitio publicado de OGP como parte de la instalación.

27. **Costos, licencias y fronteras de privacidad/seguridad.** Separar credenciales, tokens de usuario, datos privados, licencias y artefactos con copyright de la documentación pública. Usar almacenamiento privado para datos personales/RDC completos, WP snapshots y logs sensibles. No eludir liveness/controles de plataformas ni crear bypasses de autenticación. Las restricciones externas de deploy (Vercel/Netlify) son un estado separado del CI del código y no se deben mezclar en el diagnóstico.

28. **Multisesión y recuperación entre terminales.** Cada ejecución tiene run_id propio y ficha de host/terminal, pudiendo alternar entre distintas PCs del mismo cibercafé o trabajar en varias simultáneamente. Debe descubrir qué estado es local a la sesión, cuál reside en el volumen, cuál se ha guardado remotamente y cuál no puede recuperarse. No reutilizar ciegamente perfiles, paths, IDs RDC o estado de una terminal previa.

29. **Control de secuencia y eficiencia.** Resolver en orden: acceso al comando y autenticación → bootstrap básico → repositorios/workspace → estado de sesión y logs → RDC y herramientas de trabajo → estabilidad del arranque → persistencia duradera/Deadman → WP-LAB → IA local pesada. Evitar instalar o descargar capas posteriores antes de que el gate fundacional las habilite.

30. **Mecanismo de cambio, continuidad y publicación.** Toda modificación funcional requiere diff revisado, pruebas aplicables, hashes actualizados, actualización del objeto canónico y read-back desde GitHub. No integrar ni desplegar un PR con CI fallido. Las limitaciones del runner/log se registran como bloqueo real, no se convierten en PASS por inspección del código.

### 21.3 Plan de fases futuras por dependencias y gates

El plan se mantiene secuencial en las dependencias y puede avanzar en documentación mientras un gate físico/externo esté bloqueado. No autoriza por sí mismo el merge, despliegue, migración productiva, cargas de secretos ni reinicios.

| Fase | Alcance | Dependencia principal | Criterio de salida verificable | Estado actual |
|---|---|---|---|---|
| 0. Gobierno y reconciliación | Alinear Metodología, KHORA, OEP, arquitectura, `EP-VALIDATION.md`, manifiestos y ruta de bootstrap; resolver discrepancias de nombres y autoridad documental. | Lectura fresca de fuentes canónicas y SHA. | Una especificación transversal, contratos enlazados, inventario de repos confirmados y versiones coherentes con read-back. | En curso; este ciclo incorpora inventario y hoja de ruta, el alineamiento integral permanece pendiente. |
| 1. Desbloqueo de CI y validación de código | Recuperar evidencia real de los cuatro workflows; corregir fallos demostrados en typecheck, contratos, unit, E2E y parser/guard de PowerShell. | Logs/steps/artifacts utilizables de GitHub Actions o una vía aprobada que los produzca. | Todos los gates requeridos en verde en una misma cabecera; sin logs inaccesibles ni checks interpretados por suposición. | BLOQUEADO: CI #292 sigue en fallo y los logs/steps no están disponibles en el conector. |
| 2. Entrega operativa del acceso OEP en Cora | Revisión de seguridad, integración por flujo autorizado, despliegue válido y migración 017; configurar primero master password por OIDC y cargar PAT en la UI. | Fase 1 aprobada; mecanismo de publicación permitido y DB destino autorizada. | La URL canónica sirve la UI; migración aplicada; la contraseña maestra limita a EP; la bóveda persiste ciphertext; se ve estado redactado y la API solo entrega token con JWT EP autorizado. | PREPARADO, NO OPERATIVO/NO VERIFICADO; PR #292 draft, sin merge/deploy. Vercel/Netlify muestra restricción externa de repo privado; este ciclo no ejecutó esos servicios. |
| 3. Arranque núcleo en Windows PowerShell 5.1 | Validar el comando servido, path existente, JWT de sesión, recuperación HTTPS del PAT, descarga del gate fijado, validación SHA, elevación, temporales y ausencia de secretos. | Fase 2 desplegada con credenciales configuradas. | Arranque frío de Windows PowerShell 5.1 hasta materializar KHORA privado; PAT no aparece en comando/historial/logs/clipboard; limpieza de temporales comprobada. | NO VERIFICADO; sin ejecución física en este ciclo. |
| 4. Workspace cifrado y repositorios | Preflight del host; VHDX + BitLocker XTS-AES-256 al 100 %; junction exacta; seis accesos validados y catálogo/repos seleccionados conciliados; manifests de extensiones válidos; preservar WIP. | Fase 3; permisos Git efectivos en todos los repos. | Workspace único en volumen verificado, repos con remote/HEAD/manifests exactos, exportaciones correctas, no pérdida de WIP y ninguna ruta desconocida sobrescrita. | NO VERIFICADO; hay discrepancy CENSUS/GDP por resolver antes de implementar la matriz definitiva. |
| 5. Perfil de trabajo fundacional | Restaurar VS Code, toolchain del host y Notepad++; registrar versiones, asociaciones reales y preflight idempotente. | Fase 4 y perfil/instaladores permitidos. | Reutilización cuando sea válida, configuración restaurada en nueva sesión y asociaciones de archivo demostradas; no reinstala componentes íntegros por defecto. | PENDIENTE de inspección física. |
| 6. RDC y observabilidad end-to-end | Lanzar RDC, analizar handshake real, distinguir terminal/device/session, copiar ficha saneada, comprobar logs y estados normalizados. | Fase 4; acceso a una terminal autorizada. | RDC Online corroborado; ficha con origen de cada campo; logs completo+JSONL sin secretos, ventana de eventos en vivo y errores con siguiente acción. | NO VERIFICADO sin RDC. |
| 7. Gate fundacional de estabilidad | Dos instanciaciones consecutivas controladas sin reiniciar la terminal, con repos/manifest, launcher, perfiles, toolchain, OBS y cámara Chrome autorizada, RDC y logs. | Fases 3–6; host físico elegible. | Dos PASS consecutivos, segunda instancia preserva WIP y artefactos válidos, `PRESUPUESTO-REINICIO=0`. Cámara no se certifica solo por log OBS/PnP. | BLOQUEADO hasta pruebas en Cybernet; no usar el entorno productivo para pruebas de reinicio. |
| 8. Persistencia remota y recuperación | Destino privado duradero; checkpoints incrementales; snapshots/logs, Deadman, guardian, limpieza y recuperación de contexto entre PCs/sesiones. | Fase 7 como base usable; backend privado autorizado. | Put/read-back/SHA y restauración desde entorno nuevo, Deadman no destruye copias remotas y los secretos/identidades RDC permanecen en almacén privado. | PENDIENTE de definir/verificar destino durable; no asumir que PostgreSQL/Blob ya contiene todos los activos. |
| 9. WP-LAB | Inventario read-only de activos, proteger original, compatibilidad WordPress/Studio/Node/PHP/Divi, rehidratar en staging, probar rutas y restauración. | Fase 8 o mecanismo de persistencia explícitamente aprobado; activos/licencia autorizados. | Snapshot verificado, versión de Divi decidida con evidencia, pruebas funcionales por ruta, restauración en staging y destino remoto validado. | POSTERIOR; activos físicos/ZIP y destino privado no verificados. |
| 10. OGP-Visual/GPU | Preflight de GPU, instalar/reutilizar pipeline, cachear pesos en almacenamiento recuperable y evaluar generación/edición visual. | Fase 8; hardware compatible y presupuestos/licencias confirmados. | Modelo cargado y ejecución real GPU demostrada, artefactos y prompts/resultados versionados; TEST 01 aprobado sin alterar el sitio canónico. | POSTERIOR; no descargar pesos pesados antes del gate fundacional. |
| 11. Operación estable y mantenimiento | Versionado semántico, regresiones, reconciliación diaria de estado, recuperación entre conversaciones/terminales y cierre de ciclo por manifiesto. | Gates anteriores apropiados al alcance de operación. | Estado reproducible con version/hash/evidencias actuales, tablero de pendientes y rollback/recuperación verificados por artefacto. | Continuo, cada ciclo desde ahora. |

### 21.4 Reglas de secuencia y de decisión

- **Prioridad operativa inmediata:** conseguir una ejecución CI diagnosticable y cerrar los fallos demostrados del acceso/bóveda/launcher antes de declarar utilizable la URL canónica.
- **Prioridad de arranque del usuario:** que la puerta OEP entregue el comando que usa el `apiBase` existente y que ese comando instancie el núcleo sin volver a pedir el PAT. La bóveda aún no está desplegada ni configurada en producción.
- **No bloquear capas ligeras por capas pesadas:** la planificación de WP-LAB y OGP continúa en Metodología, pero sus instalaciones/pesos no deben retrasar el arranque básico.
- **No saltar gates:** una UI visible no demuestra API operativa; una API verde no demuestra scope GitHub de escritura; un VHDX creado no demuestra BitLocker 100 %; un proceso RDC iniciado no demuestra Online; un log OBS no demuestra que Chrome enumeró la cámara; un archivo local no demuestra persistencia remota.
- **Privacidad de registros:** la especificación pública conserva decisiones, hashes y logs saneados. Logs completos con identificadores RDC, datos de usuario, snapshots WP-LAB y cualquier contenido privado requieren destino privado aprobado.
- **Cambio de versión:** el siguiente ciclo debe actualizar esta hoja de ruta si cambia la secuencia o un gate. No marcar una fase como completa solo porque sus documentos/código existan.

### 21.5 Punto de reanudación

1. Fuente transversal: este archivo en `SeryMente/metodologia/main`, versión v1.1.4.
2. Implementación de UI/bóveda: PR #292 en `SeryMente/khora`, rama `feat/ep-github-token-vault-ui`, última cabecera de código conocida `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`.
3. Bloqueo inmediato: `CI`, `UI Quality`, `Khora Single Script Guard` y `khora-ok / gate` en fallo; el conector no entregó logs/steps/artifacts utilizables, incluyendo el intento de diagnóstico temporal, que ya fue retirado.
4. Aún no realizado: merge/deploy, migración productiva 017, configuración real OIDC/contraseña maestra/PAT, validación de permisos de escritura, prueba PowerShell 5.1, host real, RDC, cámara Chrome, Notepad++, persistencia remota, WP-LAB y OGP-GPU.
5. Riesgo de nomenclatura de repositorios por resolver: el contrato de bóveda lista seis nombres incluyendo CENSUS y GDP; el bootstrap histórico lista cinco y no incluye CENSUS. Confirmar remotes/nombres en GitHub antes de consolidar la lista definitiva.

## 22. Ciclo operativo 011 — Alcance mínimo de EP v1.0 y control de GitHub por turno

**Corte:** 2026-10-10.
**Versión del objeto:** v1.1.5 — EP v1.0: Alcance Mínimo y Gates.
**Narrativa Antes → Cambio → Motivo → Resultado**
- **Antes:** el inventario enumeraba todas las capas del EP, pero la aceptación del producto inicial podía confundirse con la terminación de cámaras, RDC, persistencia remota, WP-LAB o IA local.
- **Cambio:** se fija una frontera estricta para EP v1.0: acceder a Cora, autenticarse con la contraseña maestra ya configurada, recuperar el comando usando el path existente, utilizar el PAT cifrado de servidor sin volver a solicitarlo, y ejecutar el bootstrap privado con trazabilidad mínima.
- **Motivo:** llegar primero al primer arranque real sin ampliar la versión inicial con subsistemas que no son necesarios para demostrar ese flujo.
- **Resultado:** las demás capas continúan en el inventario/roadmap, pero no bloquean por sí solas la aceptación de la interfaz y bootstrap mínimos. Ningún gate de seguridad o arranque real se omite.

### 22.1 Alcance obligatorio de EP v1.0

1. **Entrada:** URL canónica de Cora y ruta EP existentes; no crear otra URL ni otra vía de bootstrap.
2. **Autenticación diaria:** contraseña maestra con sesión limitada a EP. La configuración/rotación administrativa inicial sigue requiriendo OIDC. No crear bypass general de KHORA.
3. **PAT:** introducirlo una vez en la UI autorizada; validar desde servidor; cifrar/persistir como AES-256-GCM; nunca devolver el secreto a la UI. La gestión del secreto requiere OIDC; el uso del secreto para bootstrap exige un JWT EP vigente con scope `ep:github:token`.
4. **Comando:** mantener el flujo de bootstrap existente, su `apiBase`, pin de fuente y validación SHA-256. La entrega del token temporal de KHORA continúa separada del PAT; la versión 1.0 elimina la necesidad de volver a introducir el PAT, no confunde ni elimina otros factores del flujo.
5. **PowerShell 5.1:** obtener el PAT por HTTPS desde la API EP con scope autorizado; validar URL, formato/purpose de la respuesta; no incluir el PAT en el comando, portapapeles, historial, argumentos de proceso o logs; no caer silenciosamente a un token alternativo.
6. **Bootstrap mínimo:** materializar la fuente privada fijada, validar integridad y repositorio destino, crear/usar el workspace requerido por el launcher y devolver un estado de salida inequívoco. Los cambios locales/WIP desconocidos no se sobrescriben.
7. **Migración/configuración:** la migración 017 debe aplicarse al ambiente autorizado antes del uso real; el secreto raíz `EP_BOOTSTRAP_JWT_SECRET`, la cuenta OIDC permitida y la contraseña maestra se configuran por el flujo aprobado, nunca en el repositorio.
8. **Prueba/observabilidad mínima:** registro saneado con run_id, etapa, status, código de error y siguiente acción; sin secretos. Los estados de cada gate son PASS, BLOCKED, FAIL o NOT_VERIFIED.
9. **Readiness:** no integrar ni declarar operativo hasta que las pruebas automáticas requeridas pasen, la migración esté aplicada y una ejecución real de Windows PowerShell 5.1 termine el flujo.

### 22.2 Fuera del alcance de bloqueo de v1.0

Estas capacidades siguen dentro del EP general, pero quedan para fases posteriores y no se instalarán ni descargarán como parte del primer arranque salvo dependencia explícita del bootstrap:

- certificación de OBS Virtual Camera en Windows/Chrome y configuración completa de cámara;
- Notepad++ como asociación predeterminada universal;
- ficha RDC completa y certificación de la identidad de cada terminal, salvo la identificación mínima del host necesaria para log/diagnóstico;
- checkpoints remotos duraderos, recuperación completa entre terminales, Deadman/guardian y pruebas de reinicio;
- rehidratación de WordPress/Divi/WP-LAB;
- infraestructura local OGP/GPU, ComfyUI, modelos/pesos y TEST 01;
- optimizaciones, paneles, instalaciones generales y automatizaciones que no sean necesarias para el recorrido de aceptación de v1.0.

No es una renuncia a estas capacidades, sino una frontera de entrega: se documentan y se planifican, pero no amplían el gate del primer arranque. La seguridad esencial del volumen y la protección de secretos pertenecen a v1.0 cuando el bootstrap escriba en ese workspace; no se difieren para ahorrar trabajo.

### 22.3 Gate único de aceptación de v1.0

El recorrido completo debe aprobarse en la misma cabecera de código:

1. UI de Cora permite entrar mediante la contraseña maestra únicamente al submódulo EP.
2. La administración del PAT solo está disponible con OIDC autorizado; tras guardarlo, la UI solo muestra estado redactado.
3. El PAT persiste cifrado y se entrega solo tras un JWT EP válido con el scope requerido.
4. El comando generado mantiene el path canónico `apiBase`, descarga la fuente fijada y verifica SHA-256 antes de ejecutarla.
5. En Windows PowerShell 5.1, el bootstrap llega al estado de workspace/entorno inicial sin prompt para el PAT ni exposición del secreto.
6. Las pruebas de CI, contratos de UI/API, regresión y guard de PowerShell pasan con pasos y logs accesibles.
7. Se comprueba la limpieza de temporales y la respuesta de fallo de cada paso crítico; no se declara PASS cuando el runner no entrega logs/steps.
8. Se verifica el estado por read-back de GitHub y se registra la cabecera exacta, hashes relevantes, migración, configuración y evidencia de la prueba real.

### 22.4 Comprobación obligatoria de GitHub en cada turno

En cada turno de trabajo relacionado con EP se debe consultar el estado del PR, cabecera, workflows, jobs, pasos/logs, checks externos, revisiones/comentarios relevantes y cambios en las fuentes canónicas antes de decidir el siguiente cambio. Si un check falla, intentar recuperar los pasos/logs; si siguen ausentes, registrar evidencia exacta y no inferir la causa. Solo después se cambia el código correspondiente. Reintentar un run no es corregir un fallo y que el API acepte el reintento no significa que el check pase.

**Estado verificado en este ciclo:**

- PR #292: abierto y en draft; rama `feat/ep-github-token-vault-ui`; cabecera `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`.
- `CI` run 2577, `UI Quality` run 332, `khora-ok / gate` run 598 y `Khora Single Script Guard` run 144: todos siguen en `failure`.
- Se reintentaron los jobs fallidos de las cuatro ejecuciones. Los nuevos jobs volvieron a fallar inmediatamente; para los siete jobs, los endpoints de pasos devolvieron listas vacías y los logs devolvieron 404 `BlobNotFound`. Por ello, esta sesión no permite distinguir un fallo de código de un fallo de ejecución/retención de logs.
- Los checks externos Vercel/Netlify reportan fallo por la configuración/limitación del proyecto privado. No se ejecutó Vercel ni se desplegó.
- No hay revisiones ni hilos inline en el PR. No hay evidencia nueva de ejecución local, migración productiva, secreto real o Windows PowerShell 5.1.
- El reintento no cambió los resultados. No se declara CI aprobado ni v1.0 operativo.

### 22.5 Qué falta endurecer antes de ejecutar

1. **Bloqueo inmediato de CI:** conseguir que GitHub Actions entregue pasos/logs reproducibles o corregir la causa real cuando esté observada. No añadir más código de diagnóstico ciego ni repetir reintentos indefinidamente.
2. **Permisos reales del PAT:** demostrar read/write efectivo para la lista definitiva de repositorios, incluida la discrepancia CENSUS/GDP frente al bootstrap histórico.
3. **Configuración de producción autorizada:** aplicar migración 017, raíz criptográfica y cuenta OIDC permitida; establecer/rotar la contraseña maestra, cargar el PAT y confirmar estado redactado. Nada de esto se ha ejecutado en este ciclo.
4. **E2E Windows PowerShell 5.1:** arranque frío real con PAT no solicitado ni expuesto, hash correcto, workspace listo y limpieza comprobada.
5. **Readiness del PR:** mantenerlo sin merge/deploy hasta satisfacer los gates anteriores y registrar evidencia verificable.

**Siguiente acción autorizada:** continuar resolviendo únicamente la causa demostrada del CI y las comprobaciones necesarias de EP v1.0. No ampliar el alcance a OBS, cámara, WP-LAB, OGP/GPU ni persistencia avanzada durante esta etapa. No desplegar, no integrar y no usar credenciales reales sin el procedimiento/permiso correspondiente.

## 23. Ciclo operativo 012 — Regla permanente de documentación exhaustiva y continuidad del sprint EP

**Corte:** 2026-10-10.
**Versión del objeto:** v1.1.6 — Regla Operativa de Continuidad EP.
**Narrativa Antes → Cambio → Motivo → Resultado**
- **Antes:** el objeto establecía comprobación de GitHub por turno y documentaba el alcance mínimo, pero no formalizaba con suficiente fuerza el deber de registrar cada instrucción, acción, evidencia y decisión del sprint en cada ciclo.
- **Cambio:** se eleva la documentación canónica exhaustiva a regla operativa obligatoria para cualquier actividad relacionada con EP, aplicable a cada turno y cada ciclo, no solo al cierre de una fase.
- **Motivo:** permitir que el esfuerzo se retome desde cualquier conversación o instancia con una ventana de contexto de máxima calidad, sin depender de memoria implícita ni repetir investigación.
- **Resultado:** cada ciclo futuro debe dejar una actualización persistente del objeto canónico en este repositorio de Metodología, y comprobar por lectura de vuelta que se guardó correctamente.

### 23.1 Instrucción del usuario — registro verbatim

> Sigue documentando, y de ehcho que el objeto canonico lo diga como obligatorio para todo lo que tenga que ver con EP, a cada ciclo, debes de dejar bien documentado,
>
> Ve documentando en un objeto canonico del repositorio todo lo que tenga que ver con este sprint, a niovel de ultra detalle a cada ciclo, entiendes? esta es una regla operativa del sprint, , en el repositorio de metodologia. El documento debe de poder aportar una ventana de contexto de altisima calidad, para retomar el esfuerzo desde donde sea. Esfuerzate siempre con el objeto canonico y siempre mantelo adctualziado a cada paso con todo. imncluidas misinstrucciones verbatim.
>
> Avanza siempre con un objetivo de engregarme una actualizacion lo mas pronto posbile. Yo necesito ver reustlados frecuentemente,.

La instrucción se conserva tal como fue recibida, incluidas sus grafías, puntuación y errores tipográficos. No se corrige dentro de la cita.

### 23.2 Regla normativa permanente

Para **todo lo relacionado con EP**, sin excepción por subsistema, rama, repositorio, conversación, herramienta o fase:

1. **Actualizar en cada ciclo.** Antes de dar por terminado un ciclo de trabajo, actualizar el objeto canónico en el repositorio Metodología con lo ocurrido en ese ciclo. No acumular varios ciclos sin documentar.
2. **Registrar instrucciones verbatim.** Conservar literalmente las nuevas instrucciones operativas del usuario que afecten el sprint, además de la interpretación operativa y sus consecuencias. Distinguir siempre cita original de resumen o análisis.
3. **Registrar el estado observado, no el supuesto.** Anotar fecha/corte, repositorio, rama, PR, SHA exacto, versión documental y de código conocida, checks, jobs, pasos/logs disponibles, errores exactos, cambios de archivos, hashes cuando se hayan comprobado, revisiones, dependencias, límites de acceso y resultados de lectura de vuelta.
4. **Separar hecho, inferencia y pendiente.** Etiquetar claramente qué se observó directamente, qué es una hipótesis pendiente de validar y qué no pudo comprobarse. Nunca convertir ausencia de logs en diagnóstico de código.
5. **Preservar decisiones y razones.** Cada decisión material debe explicar el estado anterior, cambio, motivo, resultado y consecuencia para el próximo ciclo. Los estados históricos se conservan; corregir el estado vigente no significa reescribir la historia.
6. **Dejar un plan ejecutable de reanudación.** Incluir el siguiente paso concreto, las precondiciones, el archivo o sistema exacto, el criterio de aceptación, los comandos/pruebas previstos cuando sean conocidos y las acciones expresamente prohibidas.
7. **Documentar seguridad y límites.** Indicar qué secretos/configuración real no se ha aplicado, qué acciones externas no se ejecutaron, qué permisos faltan y qué evidencia hace falta. Nunca registrar valores secretos; solo nombres de variables, estado de configuración y metadatos saneados.
8. **Comprobar persistencia documental.** Tras actualizar, leer de vuelta el archivo desde GitHub y verificar versión, sección nueva y commit. Si la actualización falla, no afirmar que quedó documentada: reportar el fallo y reintentarlo por una ruta segura.
9. **Comprobar GitHub en cada turno.** Antes de cambiar código o concluir, revisar PR/cabecera, workflows/checks, jobs, logs/pasos, comentarios/revisiones y las fuentes canónicas pertinentes. Recuperar evidencias de los fallos antes de corregir; si GitHub no las expone, documentar el límite exacto y buscar una alternativa autorizada de diagnóstico, sin reintentos ciegos indefinidos.
10. **Entregar resultados incrementales.** Priorizar una mejora pequeña, verificable y comunicable frente a grandes bloques de trabajo opaco. Informar del estado real y del siguiente paso útil tan pronto exista resultado persistente.
11. **No ampliar el alcance por iniciativa propia.** Para EP v1.0, mantener los gates mínimos definidos en §22. Los subsistemas de fases posteriores se documentan y planifican, pero no se incorporan al bootstrap mínimo sin dependencia y autorización explícitas.
12. **No declarar cierre sin evidencia.** No afirmar PASS, integración, despliegue, persistencia real ni prueba E2E si no existe evidencia directa y verificable. Mantener PR abierto/no integrado cuando los gates sigan pendientes.
13. **No depender de contexto conversacional.** El objeto debe permitir que otra instancia retome el trabajo sin necesitar el historial del chat: describir el objetivo, estado exacto, restricciones, decisiones, referencias a archivos y siguiente acción suficiente para continuar.
14. **Mantener una sola fuente canónica de continuidad del sprint.** La ubicación normativa de este registro es este archivo del repositorio `SeryMente/metodologia`. Otros documentos pueden enlazarlo, pero no sustituirlo ni crear una fuente paralela de estado que diverja.

### 23.3 Plantilla mínima obligatoria para cada ciclo

Cada nuevo ciclo se añade como sección numerada sin borrar los anteriores y debe contener, como mínimo:

- **Identificación:** número de ciclo, fecha/corte, nombre y versión del objeto canónico.
- **Objetivo del ciclo:** resultado concreto que se intenta conseguir y por qué pertenece al alcance vigente.
- **Instrucciones del usuario:** citas verbatim nuevas que tengan impacto operativo, sin normalización.
- **Estado inicial:** PR, rama, SHA, checks y estado documental consultados antes de actuar.
- **Acciones realizadas:** llamadas/operaciones relevantes en términos legibles, archivos tocados y commits producidos.
- **Evidencia:** resultados directos, checks, pruebas, hashes o lecturas de vuelta; incluir errores exactos y referencias.
- **Resultado:** PASS / BLOCKED / FAIL / NOT_VERIFIED por cada gate afectado, con criterio de estado.
- **Seguridad y límites:** secretos no mostrados, permisos, acciones no ejecutadas y riesgos abiertos.
- **Qué falta endurecer:** lista priorizada, sin duplicar tareas ya cerradas ni ocultar bloqueos.
- **Reanudación:** siguiente acción concreta, precondiciones, criterios de aceptación y prohibiciones.
- **Lectura de vuelta:** commit del objeto canónico y comprobación de que la nueva sección/versionado se encuentran en GitHub.

Se puede añadir detalle adicional según el ciclo; estos campos son el mínimo, no un límite de profundidad. Para un cambio que abarque varios subsistemas, se registran las evidencias de cada uno.

### 23.4 Procedimiento de cada turno EP

1. Consultar primero el estado vivo de GitHub y las fuentes canónicas necesarias.
2. Identificar el bloqueo o mejora mínima de mayor prioridad dentro de EP v1.0.
3. Ejecutar un cambio pequeño, con alcance y permisos claros, o recuperar la evidencia que impide actuar.
4. Validar el cambio con las pruebas disponibles; distinguir pruebas ejecutadas de pruebas planificadas.
5. Actualizar inmediatamente este objeto canónico con los resultados del paso, no solo con el resumen final del turno.
6. Leer el objeto de vuelta desde GitHub y verificar el commit/sección/versionado.
7. Comunicar brevemente el resultado y **qué falta endurecer**.
8. Repetir mientras haya una acción segura y concreta que pueda mejorar el estado. No inventar trabajo ni simular actividad cuando el siguiente paso requiere acceso o evidencia ausente.

### 23.5 Contexto de reanudación al cierre del ciclo 012

**Objetivo vigente:** EP v1.0 mínimo: Cora/ruta EP existente → contraseña maestra con alcance EP → PAT administrado bajo OIDC y cifrado en servidor → endpoint de token protegido por JWT EP y scope → bootstrap fijado e íntegro → ejecución real en Windows PowerShell 5.1 sin volver a introducir ni exponer el PAT.

**Estado conocido de KHORA:** PR #292, rama `feat/ep-github-token-vault-ui`, cabecera registrada `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`. Antes de actuar en un turno nuevo, consultar de nuevo el SHA: este valor es el último estado registrado, no garantía de que siga siendo el head.

**Bloqueo de CI conocido al corte anterior:** `CI` run 2577, `UI Quality` run 332, `khora-ok / gate` run 598 y `Khora Single Script Guard` run 144 fallaban. Los reintentos produjeron nuevos jobs que fallaron, pero sus pasos aparecieron vacíos y la recuperación de logs devolvió HTTP 404 `BlobNotFound`. No se conoce la causa exacta. Los checks externos Vercel/Netlify figuraban fallidos por limitaciones de configuración del proyecto privado; no se ha invocado Vercel ni desplegado desde este esfuerzo.

**Acceso/ejecución no demostrados:** no se ha acreditado aplicación de migración 017 en producción, configuración real de `EP_BOOTSTRAP_JWT_SECRET`, alta/rotación de contraseña maestra, almacenamiento del PAT real, permisos efectivos de escritura en los repositorios definitivos ni ejecución E2E con Windows PowerShell 5.1. No se debe afirmar que el flujo está operativo.

**Siguiente paso recomendado:** volver a consultar PR y checks actuales. Recuperar logs de un job representativo y verificar si el problema de `BlobNotFound` afecta a todas las ejecuciones o solo a esos runs; buscar una vía autorizada para hacer accesible la causa del fallo. No seguir reintentando indefinidamente. Con evidencia, corregir el fallo concreto más pequeño; luego actualizar este objeto al cierre de ese subciclo.

**Prohibiciones vigentes:** no merge, no deploy, no uso de secretos reales sin autorización, no prueba local/RDC si no está disponible, no ampliar el alcance a OBS/cámara, WP-LAB, OGP/GPU o persistencia avanzada para resolver el gate mínimo. No inventar resultados de ejecución.

**Nota de integridad documental:** este ciclo añade la norma de continuidad y la ventana de reanudación; no afirma haber corregido los checks de KHORA ni cambia el estado del PR.


## 24. Ciclo operativo 013 — Objetivo concreto visible y obligatorio en cada ciclo

**Corte:** 2026-10-10.
**Versión del objeto:** v1.1.7 — Objetivo Concreto Visible por Ciclo.
**Narrativa Antes → Cambio → Motivo → Resultado**
- **Antes:** la plantilla de continuidad ya requería un objetivo del ciclo, pero no obligaba de forma suficientemente explícita a que el usuario lo recibiera en cada actualización visible de la conversación.
- **Cambio:** se establece como regla operativa informar, en cada ciclo y antes de continuar el trabajo, el objetivo concreto actual y el entregable específico que se intenta proporcionar; al cambiar el objetivo, se debe anunciar la actualización. Al cierre se comparan objetivo, resultado demostrado y brecha restante.
- **Motivo:** el usuario necesita conocer en todo momento qué resultado específico está intentando conseguir el trabajo en curso, sin confundir actividad, intención y entrega efectiva.
- **Resultado:** la regla queda incorporada al objeto canónico y debe cumplirse tanto en las actualizaciones conversacionales como en el registro de cada ciclo.

### 24.1 Instrucción del usuario — registro verbatim

> Regla operativa del sprint. ducmentala yu siempre la debes de seguir:
> REPORTAME EN CADA CICLO CUAL ES EL OBJETIVO CONCRETO ACTUAL QEU INTENTAS ENTREGARME

La cita se conserva con la redacción, capitalización y errores tipográficos originales. No se corrige dentro del registro verbatim.

### 24.2 Regla normativa obligatoria

Para **cada ciclo de cualquier trabajo relacionado con EP**, y sin esperar al cierre:

1. **Reportar el objetivo al usuario.** En la primera actualización visible del ciclo, incluir explícitamente la etiqueta **“Objetivo concreto de este ciclo”** seguida de una frase específica que identifique el resultado/entregable que se intenta conseguir ahora. No sustituirlo por una descripción vaga de actividad como “revisar”, “investigar” o “seguir trabajando”.
2. **Definir el entregable verificable.** Indicar qué artefacto, decisión, evidencia, reparación o comprobación se pretende dejar disponible al terminar el ciclo, y qué criterio permite distinguir un resultado logrado de uno solo intentado.
3. **Mantenerlo actualizado.** Si cambia el objetivo, el bloqueo principal o el entregable buscado, declarar el nuevo objetivo antes de continuar con las acciones afectadas y registrar la causa del cambio en el objeto canónico.
4. **Distinguir intención de resultado.** Al finalizar el ciclo, informar por separado: objetivo inicial/vigente, resultado observado, estado (PASS, BLOCKED, FAIL o NOT_VERIFIED), evidencia y brecha que sigue abierta. Un objetivo comunicado no cuenta como entrega conseguida.
5. **Registrar también el objetivo aquí.** Cada nueva sección de ciclo en este archivo debe abrir con un campo **Objetivo concreto del ciclo**, describiendo el entregable y su criterio de aceptación. Si un ciclo tiene subciclos con objetivos distintos, documentarlos por separado sin perder la trazabilidad del ciclo padre.
6. **Conservar la disciplina incremental.** Reportar el objetivo antes de continuar, y comunicar el resultado tan pronto haya una mejora persistente o un bloqueo comprobado. No demorar la actualización para presentar una historia de progreso más grande y no simular avance cuando no se haya producido.
7. **Aplicarlo en todos los turnos EP.** Es obligatorio aunque el ciclo sea principalmente documental, de diagnóstico, de recuperación de evidencia o esté bloqueado por acceso. Si no existe todavía una vía para completar el entregable, declarar el objetivo concreto pendiente y el impedimento verificable.
8. **No ampliar el alcance para llenar el ciclo.** El objetivo debe pertenecer al alcance actual de EP y respetar §22; la obligación de reportarlo no autoriza un merge, despliegue, uso de credenciales reales ni pruebas en máquinas que no estén disponibles/autorizadas.

Esta regla complementa, no reemplaza, las obligaciones de documentación exhaustiva, instrucciones verbatim, comprobación de GitHub, lectura de vuelta y separación entre hechos, inferencias y pendientes establecidas en §23.

### 24.3 Estado vivo consultado antes de documentar

**Repositorio canónico:** `SeryMente/metodologia`, rama `main`.
**Objeto antes del cambio:** versión v1.1.6 — Regla Operativa de Continuidad EP; blob SHA `445485ac91a2f82cb4b8afbe6331aa462a7b1f14`.
**KHORA / PR #292:** [Add EP master-password gate and encrypted GitHub token UI](https://github.com/SeryMente/khora/pull/292), estado open en la consulta. La comparación de `main` con `feat/ep-github-token-vault-ui` mostró 71 commits ahead y 0 behind. La comparación del head de esa rama con el SHA registrado `c9f21d14a05d9153bb65d25b6d1f50b552aa092c` devolvió `identical`, por lo que ese SHA sigue siendo el head observado en esta comprobación.
**Workflows consultados para esa cabecera:**
- `CI`, run 2577: `failure`.
- `UI Quality`, run 332: `failure`.
- `khora-ok / gate`, run 598: `failure`.
- `Khora Single Script Guard`, run 144: `failure`.
**Checks externos:** cinco contextos Vercel y uno de Netlify devolvieron `failure`. No se ejecutó un despliegue.
**Alcance de la acción:** actualización documental solamente. No se modificó el repositorio KHORA, no se integró el PR ni se modificó infraestructura.

### 24.4 Resultado y endurecimiento pendiente

- **Regla documental:** objetivo — añadir la obligación de reportar explícitamente el entregable concreto de cada ciclo. Resultado tras la escritura y lectura de vuelta: se confirmará a continuación con el commit y el contenido de GitHub.
- **CI de KHORA:** `FAIL/BLOCKED` según la evidencia actual; los resultados fallidos no exponen por sí mismos la causa. No se atribuye el fallo a un defecto específico de código sin pasos/logs utilizables.
- **EP v1.0 operativo:** `NOT_VERIFIED`; la actualización de esta regla no modifica los gates pendientes de §22.
- **Qué falta endurecer:** recuperar evidencia diagnóstica accesible de CI; verificar permisos efectivos del PAT y la lista definitiva de repositorios; aplicar y comprobar la configuración autorizada de la migración 017; completar una ejecución real E2E en Windows PowerShell 5.1.
- **Siguiente acción:** en el próximo ciclo EP, abrir con “Objetivo concreto de este ciclo”, consultar el estado vivo de GitHub, resolver la siguiente acción segura de mayor prioridad y registrar su resultado antes de cerrar.
- **Prohibiciones mantenidas:** no merge, no deploy, no uso de secretos reales sin autorización, no E2E inventado, no expansión del alcance de EP v1.0.

**Lectura de vuelta:** completada tras la escritura. La versión v1.1.7 y la sección 24 fueron leídas desde GitHub; la comprobación automática confirmó encabezado, sección normativa y siguiente acción. En la respuesta de este ciclo se registra el blob SHA exacto de esta lectura.


## 25. Ciclo operativo 014 — Objetivo de construcción, resultado valioso y viabilidad de CI local

**Corte:** 2026-10-10.
**Versión del objeto:** v1.1.8 — Objetivo de Construcción y Diagnóstico Local de CI.
**Objetivo concreto de construcción vigente:** conseguir que el PR #292 de KHORA alcance checks de CI verdes y verificables mediante diagnóstico reproducible, corrección mínima de la causa real y publicación de la revisión corregida. El entregable sustantivo es código corregido publicado en el PR con evidencia de checks verdes; actualizar documentación por sí solo no satisface este objetivo de construcción.
**Entregable de este subciclo:** determinar con pruebas observables si el entorno Windows disponible se puede usar para ejecutar pruebas locales que aceleren el diagnóstico de CI, sin hacer cambios destructivos ni declarar el resultado final conseguido.
**Criterio de aceptación del subciclo:** identificar una máquina accesible, runtime y herramientas relevantes, posibilidad de lectura del head privado exacto y bloqueos que impidan ejecutar las pruebas. No cuenta como aceptación que se haya intentado una conexión; se exige resultado observado.
**Narrativa Antes → Cambio → Motivo → Resultado**
- **Antes:** §24 formalizó que cada ciclo debe comunicar un objetivo, pero la formulación anterior podía tratar el mantenimiento documental como el entregable final, aunque el usuario pide resultados de construcción útiles, visibles y publicados.
- **Cambio:** se distingue ahora de forma normativa el objetivo de construcción sustantivo del subciclo técnico/documental. Cada ciclo debe orientarse a un resultado de producto que merezca publicarse; la documentación obligatoria es trazabilidad y continuidad, no un sustituto del entregable.
- **Motivo:** evitar confundir actividad o administración del sprint con progreso de código demostrable.
- **Resultado:** el objetivo de construcción vuelve a centrarse en corregir los fallos de CI del PR #292; la comprobación local confirma que hay una máquina Windows accesible y acceso Git de lectura a la rama privada, aunque falta un checkout en las rutas comprobadas y no se han ejecutado pruebas del proyecto.

### 25.1 Instrucción del usuario — registro verbatim

> Objetivo concreto de este ciclo: registrar y verificar en el objeto canónico de Metodología la obligación de reportarte, en cada ciclo, cuál es el entregable concreto que estoy intentando conseguir.
>
> ERROR: No es lo que quiero. Lo que quioero es el objhetivo de construccion, osea que estas tratando de entregarme. Tu me tienes que entregar a mi resutlkados que pueda ver publicados. OSea no cualqueir cosa e sun resultadop. Resutlados que valgan la pena. 
>
> Pregubnta puedfes usar el entorno local para acelerar el proceso de los CI? Es una pregunta que quiero que me respondas con objetividad.

Se conserva la instrucción exactamente como fue recibida, incluidos errores tipográficos y puntuación; no se normaliza dentro de la cita.

### 25.2 Estado vivo de KHORA/GitHub — corrección publicada y CI aún bloqueado

- PR: [#292 — Add EP master-password gate and encrypted GitHub token UI](https://github.com/SeryMente/khora/pull/292), abierto, en borrador y sin merge.
- Rama: `feat/ep-github-token-vault-ui`.
- Head anterior reproducido en PC-1: `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`.
- Commit de corrección publicado: [`6738c1f1aeffe5835a725531e0774d4420af13c5`](https://github.com/SeryMente/khora/commit/6738c1f1aeffe5835a725531e0774d4420af13c5). La referencia Git de la rama y la API directa de la PR confirmaron ese head.
- El commit actualiza 10 archivos: declara y restablece el estado `archivado`; tipa la comprobación del inventario; normaliza el buffer de firma Web Crypto para TypeScript; completa fixtures de UI Review; elimina la redeclaración `tokenRoute` en el test de seguridad; hace semántica la tarjeta seleccionable de Pipeline; sincroniza el esquema canónico con Metodología v1.7.7 e incorpora el campo `RA` al renderer, parser y tests.
- La copia del esquema bajo `khora-web/contracts/FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json` se comparó desde GitHub con el archivo canónico de Metodología: los contenidos coinciden, versión `v1.7.7`.
- No se hizo merge ni despliegue. No se configuró una contraseña maestra real, no se cargó un PAT real y no se expusieron secretos.

### 25.3 Reproducción local en PC-1 — evidencia directa y límites

**Checkout y dependencias:**
- RDC confirmó PC-1 en línea al inicio de la prueba; se creó un checkout temporal aislado: `C:\Users\PC 9\AppData\Local\Temp\khora-ci-20261009-191854-c2581ce7`.
- Se verificó el head antes de instalar: `c9f21d14a05d9153bb65d25b6d1f50b552aa092c`, idéntico al head anterior de la PR.
- `npm.cmd ci --no-audit --no-fund` terminó con código 0 e instaló 552 paquetes en el checkout temporal.
- El host tenía Windows x64, Windows PowerShell 5.1.19041.6456, Git 2.55.0.windows.5, Node.js v24.20.0 y npm 11.19.0. `npm.cmd` funciona; el shim `npm.ps1` fue bloqueado por Execution Policy y esta política no se modificó.
- GitHub CLI 2.102.0 no está autenticado; aun así, `git ls-remote` había demostrado lectura de la rama privada. No se presupone permiso de escritura local.

**Gates ejecutados antes de aplicar el commit publicado:**
- `npm run typecheck`: FALLÓ con errores de estado `archivado` inexistente, callback con `item` implícitamente any, tipo de buffer en Web Crypto, fixtures incompletas y redeclaración `tokenRoute`. Los archivos afectados forman parte del commit publicado.
- `npm run ui:contract`: PASS; el contrato de navegación se informó íntegro.
- `npm run ui-review:check`: FALLÓ porque `PipelineView.tsx` usaba `onClick` en un `div` no semántico. El commit publicado cambia la tarjeta a un `button` nativo y conserva contenido de modelo de frase, con `aria-pressed`.
- `npm run test:unit`: FALLÓ; quedó demostrada la divergencia del contrato local v1.7.6 contra el contrato canónico v1.7.7. El renderer/parser tampoco representaba el nuevo campo `RA`; el commit publicado sincroniza esquema, implementación y regresión.
- La prueba de tipo y las suites no se reejecutaron después de publicar, porque RDC pasó a estar fuera de línea. No se declara que los tests locales hayan pasado tras el parche.

**Lectura estática post-publicación:** se volvieron a leer los archivos desde GitHub y pasaron 16 verificaciones de presencia/consistencia: head de PR; estado y reinicio de `archivado`; anotación de tipo; buffer Web Crypto; fixtures de Ingreso y Pipeline; variables del test de seguridad; tarjeta semántica; parser/renderer/tests de `RA`; versión documental; igualdad exacta del esquema contra Metodología. Estas comprobaciones estáticas no sustituyen compilación ni tests de runtime.

### 25.4 Estado de GitHub Actions en el commit publicado

Para el SHA `6738c1f1aeffe5835a725531e0774d4420af13c5`, GitHub creó las ejecuciones:
- [CI — push #2578](https://github.com/SeryMente/khora/actions/runs/38018055932): FAILURE.
- [CI — pull request](https://github.com/SeryMente/khora/actions/runs/38018059324): FAILURE.
- [UI Quality](https://github.com/SeryMente/khora/actions/runs/38018059383): FAILURE.
- [khora-ok / gate](https://github.com/SeryMente/khora/actions/runs/38018059361): FAILURE.
- [Khora Single Script Guard](https://github.com/SeryMente/khora/actions/runs/38018059308): FAILURE.

Los jobs del head publicado se completaron en aproximadamente 1–2 segundos, devuelven `steps: []`, tienen `runner_name` vacío y las descargas de logs fallan con HTTP 404 `BlobNotFound`. Este comportamiento también se observó en el head previo `c9f21d14…`; por ello no demuestra que la suite haya alcanzado un test de código ni localiza una causa de test. No se repetirán workflows idénticos sin evidencia diagnóstica nueva.
- Los checks externos Vercel/Netlify continúan en FAILURE. No se invocó despliegue.

**Estado de RDC:** tras el trabajo local, la lista del servicio mostró PC-1 y PC-7 fuera de línea; no se intentó seguir ejecutando comandos contra un dispositivo desconectado. Para reanudar pruebas CLI cuando el host esté disponible, debe iniciarse Desktop Commander en una terminal elevada con `npx @wonderwhy-er/desktop-commander@latest remote`; hasta entonces, la ruta de continuidad es GitHub.

### 25.5 Qué cuenta como resultado valioso, bloqueo actual y siguiente acción

**Objetivo concreto de construcción:** entregar una revisión de KHORA publicada en el PR #292 que corrija los fallos demostrados y consiga checks remotos verdes verificables. La primera corrección está publicada, pero el objetivo no puede darse por completado mientras Actions no aporte una ejecución útil y CI no quede verde. La actualización documental, un checkout, una instalación exitosa o un conjunto de comprobaciones estáticas no son cierre del objetivo.

**Bloqueo actual:** los workflows principales fallan antes de registrar pasos y sus logs no están disponibles (`BlobNotFound`). No se puede certificar si el código del nuevo commit pasa en Ubuntu hasta recuperar logs/annotations o disponer de otra ejecución útil. La conexión RDC está fuera de línea, así que no puede repetirse ahora la validación local sobre el commit corregido.

**Secuencia siguiente:**
1. Continuar vía GitHub mientras RDC siga desconectado; consultar el estado de ejecución y metadatos de checks, sin reintentar fallos opacos en bucle.
2. Si la API/runner vuelve a ofrecer pasos o logs, localizar la primera causa real y corregir solo con evidencia.
3. Cuando RDC se reinicie, llevar al checkout temporal el SHA publicado y ejecutar `npm.cmd run typecheck`, `npm.cmd run ui-review:check`, `npm.cmd run ui:contract` y `npm.cmd run test:unit` antes de modificar otra vez.
4. No declarar CI verde hasta observarlo en GitHub; no hacer merge ni desplegar sin validación.

**Directriz del usuario para este ciclo, registrada literalmente:**

> Haz lo que tengas que usar via rdc que esta disponible durante lso siguientes 10 minutos para acelerar las pruebas via CLIs, pero hazlo ya
>
> Ademas, creo que es el ultumo ciclo anbtes de irme, y regresar en un ratop. Cuando me vaya te quedaras solo con trabajo via github, pero no quiero que te detengas, ahsta terminar por nada del mundo. Asi que sigue trabajando en github, en rdc y en github en este ciclo, para resolver todo de extremo a extrmeo.
>
> No tienes autorizado a parar ahsta termianr.

El usuario preguntó después: «Sigues procesando en que te quedaste? O ya terminaste?». La respuesta fue que el trabajo no estaba terminado y se mantuvo la ejecución dentro del turno.

**Estado por gate al cierre de la actualización:**
- Checkout aislado del head anterior: PASS.
- Instalación por lockfile en PC-1: PASS.
- Contrato de navegación `ui:contract` en head anterior: PASS.
- Typecheck/UI Review/unit tests del head anterior: FAIL, con defectos concretos abordados por el commit publicado, aún sin reejecución post-patch.
- Consistencia estática de los archivos publicados contra el head nuevo: PASS.
- CI / UI Quality / gate / guard remotos en head nuevo: FAIL sin pasos/logs utilizables.
- PR #292: abierto, en borrador y sin merge.
- CI verde, merge, despliegue y prueba E2E de Windows PowerShell 5.1: no alcanzados/no ejecutados.

**Reglas vigentes:** no inventar éxito de CI; no atribuir causa a tests que no ejecutaron; no suponer autenticación de escritura; no cambiar Execution Policy; no sobrescribir workspaces existentes; no exponer secretos; no hacer merge ni desplegar.

