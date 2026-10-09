# Especificación canónica EP: Cybernet, RDC, WP-LAB y OGP-Visual

**Estado:** especificación consolidada; ejecución física y certificación pendientes de evidencia.
**Versión del objeto:** v1.0.0
**Nombre de versión:** Revisión Local Aislada y Publicación Verificable
**Corte:** 2026-10-09.
**Fuente transversal:** SeryMente/metodologia.
**SI vigente leído con H1 → SI@H1 → H2:** v1.6.21 — Ordenamiento por Preponderancia y Categorías.
**Frescura comprobada en esta actualización:** H1 = H2 = ccb0258f5571b9f8a5533a2a17a32c3ce554c294; blob SI 89ebe84df49300662f996b85130cbcb893b568e0; versión/nombre comprobados contra el archivo completo fijado a ese commit.
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
