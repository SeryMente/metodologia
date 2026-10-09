# Especificación canónica EP: Cybernet, RDC, WP-LAB y OGP-Visual

**Estado:** especificación consolidada; ejecución física y certificación pendientes de evidencia.
**Corte:** 2026-10-09.
**Fuente transversal:** SeryMente/metodologia.
**SI vigente leído con H1 → SI@H1 → H2:** v1.6.21 — Ordenamiento por Preponderancia y Categorías.
**Frescura comprobada:** H1 = H2 = 8ea039d987712d5d154ec2ef3fb47adfea2422d3; blob SI 89ebe84df49300662f996b85130cbcb893b568e0.
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
