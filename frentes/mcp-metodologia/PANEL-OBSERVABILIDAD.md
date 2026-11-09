# MCP-OCP · Panel local de observabilidad

**Producto:** MCP-OCP 1.0.0  
**Versión de esta especificación:** 1.0 · **Estado:** CONTRATO APROBADO PARA IMPLEMENTACIÓN · implementación pendiente  
**Fuente normativa:** Samantha v386 · NX-386m · Metacanon 1.29 · GOW 2.18  
**Servidor:** MCP-OCP por STDIO · MCP-NORMATIVO: DESACTIVADO

## 1. Resultado que debe entregar

Una ventana de escritorio local, ligera y visual, que permita al operador saber de un vistazo qué ocurre con MCP-OCP: si la sesión EP está vigente, si el proceso del servidor existe, si el protocolo MCP quedó inicializado, si las fuentes están importadas y verificadas, si el operador está provisionado y si el conjunto está realmente listo.

El panel forma parte de la experiencia de MCP-OCP 1.0.0. No es un segundo servidor MCP, no es un cliente MCP, no sustituye al cliente que abre STDIO y no es MCP Inspector. Es una superficie de observación de solo lectura.

**Regla esencial:** proceso activo no significa servidor listo. El panel nunca mostrará “Listo” por el solo hecho de encontrar un PID.

## 2. Decisión de arquitectura

- **Aplicación:** escritorio Windows nativa con WPF y C#, dentro de la solución .NET del producto. Usar el SDK/RID que se fije al reconciliar el código; no actualizar el stack solo para la interfaz.
- **Dependencias:** controles WPF nativos y gráficos vectoriales sencillos. Sin motor de gráficos de terceros, WebView2, navegador embebido, Node, servidor web, base de datos nueva ni framework visual pesado.
- **Distribución:** ejecutable del panel incluido en el mismo paquete reproducible que el servidor; instalación relativa prevista: `frentes/mcp-metodologia/instalacion-local/panel/OcpMcp.Panel.exe`.
- **Alcance de plataforma:** Windows x64 para el perfil de trabajo designado. WPF es una tecnología Windows-only; no se promete una UI equivalente en otros sistemas en el release 1.0.0.
- **Transporte MCP:** el servidor conserva STDIO. La ventana no lee ni escribe stdin/stdout y no se interpone entre cliente y servidor.
- **Comunicación panel-servidor:** proyección local de estado/eventos mediante archivos del root de datos protegido. Sin HTTP, TCP, localhost, named pipes, sockets, túneles ni endpoints de red.

La documentación oficial del SDK C# confirma que STDIO es una sesión por proceso, lanzada como proceso hijo por el cliente; por eso el panel observa una proyección de estado y no intenta apropiarse de la sesión del cliente.

## 3. Ciclo de vida ligado a EP

1. El controlador de sesión EP verifica el estado de la sesión persistente y completa sus gates de seguridad aplicables.
2. Solo cuando EP emite/declara `ACTIVE`, el controlador abre el panel como proceso hijo de esa sesión interactiva.
3. El controlador EP escribe y coteja primero `monitor/session.json`, y después abre el panel pasándole el root de datos como parámetro no secreto. El panel abre mostrando **“Sesión activa · esperando servidor MCP”** si el cliente MCP aún no ha lanzado el servidor. Esto permite mostrar el estado EP sin depender de un proceso MCP inexistente.
4. Cuando el cliente inicia el proceso MCP por STDIO, el servidor publica su estado y el panel actualiza sus indicadores.
5. Mientras la sesión EP siga activa, el panel permanece disponible. El operador puede minimizarlo; el cierre de la sesión EP cierra el panel de forma limpia.
6. Si el proceso MCP se detiene o falla pero EP continúa vigente, el panel permanece abierto y muestra el estado detenido/desconectado; no intenta reiniciar el servidor ni apropiarse de su proceso.

No iniciar el panel por el mero inicio de Windows, no registrar un servicio Windows, tarea programada ni proceso residente independiente. La apertura automática pertenece al evento de sesión activa existente en EP-TASK-005. No modificar el dead-man de EP-TASK-003 ni ampliar su disparador.

## 4. Proyección local de observabilidad

El servidor MCP escribe en el root protegido que EP configure, en un subdirectorio `monitor/`:

- `state.json`: snapshot actual, sustituido atómicamente.
- `events.jsonl`: secuencia append-only de eventos operativos minimizados, con rotación/tamaño acotado.

El panel solo tiene lectura. EP aplica ACL y protección del volumen; el servidor no crea ni modifica ACL, BitLocker, Registro, firewall o configuración del host. La señal de protección del volumen pertenece exclusivamente a la atestación EP en `session.json`; el servidor reporta solo disponibilidad/acceso a su data root.

- `session.json`: archivo atómico escrito por el controlador EP; contiene `schemaVersion`, `sessionState`, `sessionStartedAtUtc`, `protectionState` y `protectionCheckedAtUtc`. No contiene SID, credenciales, claves ni identificadores sensibles. EP actualiza `sessionState` al terminar la sesión. Si falta, es inválido o no corresponde a la sesión en curso, el panel muestra **“Sesión no verificada”** y nunca asume ACTIVE.
- `state.json` y `events.jsonl`: escritos por el servidor MCP-OCP; representan su propio ciclo de vida, protocolo, fuentes y actividad.

La comprobación de protección del volumen se presenta como **“verificada por EP a las [hora]”**. No se proclama protección actual a partir de un archivo antiguo ni se sondea BitLocker en segundo plano; la fecha de comprobación queda visible.

### 4.1 Snapshot mínimo

El esquema versionado `state.json` debe exponer, como mínimo:

- `schemaVersion`, `updatedAtUtc`.
- Servidor: lifecycle, PID, hora de inicio del proceso, versión del software y transporte. La sesión EP no se infiere desde este archivo: procede exclusivamente de `session.json`.
- Protocolo: no iniciado / iniciando / inicializado / desconectado.
- Fuentes: importadas, integridad, vigencia, versión/firma DUG y resultado de verificación.
- Operador: provisionado / no provisionado / desconocido.
- Acceso al data root desde el servidor: configurado, lectura/escritura disponible o desconocido. No inferir cifrado BitLocker desde el proceso MCP.
- Readiness del servidor y un `reasonCode` seguro cuando no esté listo. El panel calcula el estado compuesto incorporando la atestación EP de `session.json`.
- Actividad: herramienta en curso, inicio, último evento y contadores de éxito/error.

El schema se versiona y se valida antes de presentarlo. Campo ausente o formato inválido produce **“Estado no disponible / requiere revisión”**, nunca un falso PASS.

### 4.2 Eventos

Registrar solo metadatos necesarios para la visualización:

- inicio/fin de proceso;
- initialize MCP y desconexión;
- importación/verificación de fuentes;
- inicio, éxito o fallo de una herramienta;
- duración, identificador de herramienta, outcome y código de razón sanitizado.

No registrar argumentos, contenido de documentos, texto de principios, respuestas completas, credenciales, tokens, SID, claves, secretos ni datos privados. Un fallo puede aparecer en la línea de actividad, pero nunca cuenta como recuperación Sink satisfactoria. Los contadores de Sink/frecuencia solo se incrementan conforme al contrato del servidor ante recuperación íntegra exitosa.

Los eventos se mantienen acotados (ventana reciente y tamaño máximo documentado); no se convierte el panel en plataforma de analítica o telemetría histórica.

### 4.3 Actualización y detección

- El controlador EP publica `session.json` al activar/cerrar la sesión. El servidor publica `state.json` en cambios de estado y `events.jsonl` al comenzar/terminar operaciones.
- El panel consume cambios por notificación del sistema de archivos (`FileSystemWatcher`) con lectura defensiva y debounce.
- Para detectar la terminación abrupta, el panel abre una referencia al proceso identificado por PID y hora de inicio y escucha el evento de salida del proceso. Nunca confía solo en el PID, para evitar confusión por reutilización.
- No se incorpora heartbeat de fondo, sondeo de EP ni vigilancia general de procesos/archivos/red. La observación ocurre dentro de la ventana abierta y se limita al proceso MCP identificado.
- Una falla al escribir/leer la proyección no detiene el servidor: el panel informa “Observabilidad no disponible” y el estado funcional sigue determinado por las comprobaciones reales del servidor.

## 5. Diseño visual y jerarquía de atención

Ventana principal de una sola pantalla, optimizada para lectura rápida en una ventana de escritorio de formato panorámico y adaptable al redimensionamiento.

### 5.1 Composición

1. **Barra superior:** MCP-OCP, versión de software, sesión EP y duración de sesión.
2. **Estado dominante:** una señal principal grande: `LISTO`, `ATENCIÓN`, `BLOQUEADO`, `ESPERANDO SERVIDOR` o `DETENIDO`.
3. **Ruta visual del servicio:** cinco etapas conectadas: `SESIÓN EP → PROCESO → MCP/STDIO → FUENTES → READINESS`. Cada etapa expresa estado, icono y texto; no solo color.
4. **Tarjetas de salud:** proceso, protocolo, fuentes/DUG, operador y almacenamiento protegido.
5. **Actividad actual:** herramienta en ejecución, duración transcurrida y resultado cuando finalice. Si está inactivo, mostrar “Sin operaciones en curso”.
6. **Actividad reciente:** últimas operaciones con herramienta, estado, duración y hora; sin argumentos ni contenidos.
7. **Atención requerida:** un único mensaje prioritario con razón y siguiente paso verificable. Los diagnósticos secundarios quedan plegados.

La vista principal debe permitir entender el estado global en unos segundos, sin navegar por pestañas ni leer logs. Las métricas solo se dibujan con eventos reales; sin muestras, se muestra “Sin actividad registrada”, nunca una gráfica simulada.

### 5.2 Sistema visual y comportamiento

- Estética profesional, limpia y deliberadamente visual: fondo oscuro sobrio, superficies diferenciadas, acento azul/cian y señales verde/ámbar/rojo con contraste suficiente.
- Jerarquía tipográfica clara: estado dominante, tarjetas grandes y textos secundarios breves.
- Icono + etiqueta + color para todos los estados; el color nunca es la única señal.
- Indicadores de actividad discretos; sin parpadeos, destellos repetitivos, sonido, animación constante ni ventanas modales intrusivas.
- Respetar configuración de accesibilidad/reducción de movimiento de Windows; navegación por teclado y escalado DPI.
- La ventana inicia visible al activar EP y permanece como aplicación abierta durante la sesión. Mientras EP siga ACTIVE, `X`/Alt+F4 minimiza a la barra de tareas en lugar de terminar el proceso; el operador puede restaurarla desde allí. El controlador EP es quien termina el panel al cerrar la sesión. No usar always-on-top por defecto.
- La interfaz no ofrece acciones de escritura ni botones para autorizar operaciones. Su función es observar y explicar, no ejecutar.

## 6. Matriz de estados

| Condición observada | Estado visible |
|---|---|
| EP activo, servidor aún no iniciado | Sesión activa · esperando servidor |
| Proceso creado, MCP no inicializado | Iniciando · protocolo pendiente |
| Proceso activo y initialize confirmado, pero faltan fuentes/operador/root | Atención o bloqueado, con el gate concreto |
| Proceso y protocolo activos, fuentes importadas/verificadas, operador configurado y root protegido | Listo |
| Proceso termina o se pierde STDIO con EP vigente | Servidor detenido/desconectado |
| Fuente ausente, obsoleta, alterada, hash incorrecto o proyección inválida | Bloqueado / integridad no verificada |
| Panel sin acceso al root de monitor | Observabilidad no disponible; no inferir estado |

`READINESS=READY` exige que todos los gates requeridos por el contrato estén verificados. No se deriva de un proceso vivo, un archivo antiguo ni un estado de caché.

## 7. Pruebas de aceptación obligatorias

1. EP llega a `ACTIVE` sin servidor iniciado: EP escribe y coteja `session.json`; el panel abre y muestra “esperando servidor”.
2. Cliente lanza el servidor por STDIO: el panel diferencia proceso activo de protocolo inicializado.
3. Fuentes ausentes, obsoletas, alteradas o no importadas: el panel muestra el gate fallido y nunca “Listo”.
4. Operador no provisionado o data root no protegido: readiness sigue degradado/bloqueado.
5. Una llamada correcta aparece con herramienta, hora, duración y éxito, sin exponer contenido.
6. Una llamada fallida aparece como fallo y no incrementa la frecuencia de recuperaciones exitosas.
7. El servidor termina abruptamente: el panel detecta el proceso exacto y actualiza el estado sin confundir PID reutilizado.
8. `session.json` ausente/inválido/desfasado, JSON operativo inválido, ACL denegada o archivo inaccesible: estado de sesión/observabilidad no disponible, sin excepción no controlada ni elevación de permisos.
9. Cierre de la ventana por `X`/Alt+F4 durante EP ACTIVE: se minimiza y sigue restaurable; cierre de la sesión EP: el panel termina limpiamente y no queda proceso huérfano.
10. El tráfico STDIO conserva stdout exclusivamente para MCP; el panel no abre listeners, sockets, HTTP ni túneles.
11. Build/package incluye el ejecutable, recursos y dependencias necesarias; manifest y SHA-256 coinciden tras extracción/read-back.
12. Prueba visual en el host Windows objetivo a resolución común y escalado DPI; contraste, teclado y reducción de movimiento verificados.

## 8. Alcance excluido de 1.0.0

No incluye control remoto del servidor desde el panel, chat, llamadas MCP originadas por la UI, herramientas de escritura, gestión de ACL/BitLocker, reinicio automático, servicio Windows, tarea programada, analítica histórica, envío a nube/B2, listener local, HTTP, MCP Apps, MCP Studio ni dependencia de MCP Inspector en producción.

MCP Inspector puede utilizarse de forma opcional durante desarrollo para inspeccionar el protocolo; no se distribuye ni se convierte en requisito de instalación. El panel es la interfaz operativa cotidiana del operador.

## 9. Entregables de implementación

- Proyecto WPF separado y pequeño dentro de la solución MCP-OCP.
- Schema versionado de snapshot/eventos y writer del lado del servidor.
- Panel lector con estados, actividad, diagnósticos y ciclo de vida.
- Integración de apertura/cierre en el evento de sesión EP activa, bajo propiedad de EP-TASK-005.
- Pruebas automáticas del schema/writer/reader y smoke visual en Windows.
- Paquete MCP-OCP 1.0.0 con servidor y panel, manifest, SHA-256 y runbook.
- Recibo de build y aceptación con evidencia de funcionamiento real.

**Estado:** especificación documental preparada; código, build, integración EP e instalación todavía no ejecutados.
