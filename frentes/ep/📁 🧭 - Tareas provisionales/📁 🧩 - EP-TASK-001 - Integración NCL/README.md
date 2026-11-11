# 📝 EP-TASK-001 · NCL — Navegador Compartido Local: integración de Playwright y KeePassXC

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una capacidad ya implementada.  
**Estado:** `en_curso · NCL_PREFLIGHT_PARTIAL · OCP_PROFILE_36_CONFIRMED · PLAYWRIGHT_EXTENSION_PRESENT_0.4.0 · KEEPASSXC_BROWSER_PRESENT_1.10.4.1 · EXTENSION_ENABLEMENT_UNVERIFIED · NATIVE_MESSAGING_REGISTRY_UNVERIFIED · KEEPASSXC_PROCESS_NOT_RUNNING · KEEPSHARE_ROTATION_PENDING`
**Responsabilidad:** vinculada al frente Entorno Persistente, `frentes/ep/`; sin control ni sesión propios.  
**task_id:** `EP-TASK-001` (identificador local de este registro; no es folio global).  
**scope_ref:** `frentes/ep/`  
**Condición de activación:** REACTIVADA el 2026-11-11 por instrucción expresa del operador; la espera anterior queda levantada para preflight y trabajo independiente, sin omitir dependencias técnicas ni compuertas de seguridad.

## 1. Enunciado

Diseñar, construir e integrar el Navegador Compartido Local (NCL) como capacidad reutilizable del entorno persistente, para que el usuario y los agentes de inteligencia artificial puedan trabajar sobre la misma instancia existente de Chrome, compartiendo el perfil, las pestañas y las sesiones autenticadas que el usuario utiliza, sin depender de navegadores remotos de pago ni de instancias independientes que obliguen a repetir autenticaciones. La arquitectura preferida combina Chrome con el perfil OCP existente, Playwright Extension para conectar con pestañas abiertas, Playwright MCP como puente local de automatización y KeePassXC con KeePassXC-Browser y Native Messaging para custodia y utilización autorizada de credenciales y TOTP. La primera validación funcional será una navegación autenticada de solo lectura en Cora, desde una pestaña dedicada del perfil OCP identificado inequívocamente. La solución deberá minimizar la interferencia visual en un único monitor, mantener al usuario en control, limitar al agente a las pestañas delegadas, preservar sesiones y pestañas ajenas, impedir exposición de secretos y permitir detener y reanudar la automatización sin cerrar Chrome. El trabajo comprende auditoría del estado local, diagnóstico de KeePassXC portable y Native Messaging, identificación del perfil OCP, configuración de Playwright Extension, conexión con Playwright MCP, pruebas progresivas, seguridad, recuperación, integración en EP y documentación arquitectónica canónica. Esta tarea permanece provisional y sin ejecución hasta que termine el trabajo prioritario actual del frente EP o el operador ordene expresamente retomarla antes.

## 2. Referencia de origen

Encargo directo del operador recibido el 2026-10-31 en esta conversación: “ENCARGO PROVISIONAL — NCL / Navegador Compartido Local”. Este núcleo conserva su objetivo, antecedentes reportados, decisiones de arquitectura, fases, restricciones y criterios de aceptación. No se crea un archivo original separado ni un segundo objeto de estado vivo.

Documentación técnica indicada para la fase de ejecución; los enlaces y contratos deberán revalidarse al reanudar:

- Playwright Extension: https://github.com/microsoft/playwright/blob/main/packages/extension/README.md
- Configuración de browser extension para Playwright MCP: https://playwright.dev/mcp/configuration/browser-extension
- Playwright MCP: https://github.com/microsoft/playwright-mcp
- Guía de usuario KeePassXC: https://keepassxc.org/docs/KeePassXC_UserGuide
- KeePassXC-Browser: https://github.com/keepassxreboot/keepassxc-browser

## 3. Necesidad y alcance funcional

El objetivo no es simplemente automatizar páginas web ni instalar Playwright. Se requiere que el agente pueda trabajar en el mismo contexto de navegación que utiliza el usuario:

- Reutilizar sesiones autenticadas y el perfil habitual.
- Interactuar con pestañas ya existentes y con sistemas autenticados como Cora.
- Mantener la interacción visible y supervisable.
- Evitar lanzar un segundo navegador independiente y repetir autenticaciones/MFA.
- Mantener navegador, perfil, sesiones y credenciales bajo control local.
- Ofrecer una capacidad reutilizable por otros agentes y frentes; no una integración exclusiva de Cora o Harmonia.

## 4. Arquitectura de referencia

**Navegación y automatización:**

`Chrome existente + perfil OCP → Playwright Extension → Playwright MCP → agente de IA`

**Custodia de credenciales:**

`KeePassXC → Native Messaging → KeePassXC-Browser → formularios del navegador`

Responsabilidades separadas:

- Chrome conserva el contexto de navegación y las sesiones.
- Playwright Extension conecta al agente con el navegador existente y las pestañas autorizadas.
- Playwright MCP expone las herramientas de navegación/automatización local.
- KeePassXC conserva credenciales y TOTP localmente.
- KeePassXC-Browser comunica el navegador con la bóveda mediante Native Messaging.

La modalidad preferida es conectar la extensión al Chrome que ya está abierto; no lanzar otro Chrome, Chromium administrado por Playwright ni un navegador headless independiente. La configuración debe fijar explícitamente el directorio real del perfil mediante `--profile-dir-name=<DIRECTORIO_REAL_DEL_PERFIL>`; no depender del último perfil usado ni de su nombre visual.

## 5. Estado técnico conocido al crear la tarea

Todo lo siguiente es **estado reportado en el encargo del operador**, no una nueva inspección ni una certificación ejecutada durante la creación de esta tarea. Debe revalidarse cuando se active.

### 5.1 Entorno

| Componente | Estado reportado |
|---|---|
| Windows x64 | Detectado |
| Perfil de referencia del usuario | `fila4`; ruta conocida `C:\\Users\\fila4` |
| Node.js | v24.0.0 |
| npm | 11.3.0 |
| Git | 2.45.2 |
| Chrome / Edge | Instalados |
| KeePassXC | 2.8.0 portable |
| Playwright | 1.64.1 |
| Playwright MCP | 0.0.84 |
| Base KeePassXC OCP | Creada por el usuario; su contenido no fue leído ni exportado |
| Integración de navegador KeePassXC | Habilitada por el usuario |
| Conexión funcional KeePassXC-Browser | Pendiente de verificación |
| Playwright Extension conectada | Pendiente |
| Perfil OCP inequívocamente identificado | Pendiente |
| Sesión de Cora mediante NCL | Pendiente |

### 5.2 KeePassXC portable

- Ejecutable reportado: `C:\\Users\\fila4\\AppData\\Local\\Programs\\KeePassXC-Portable\\KeePassXC.exe`
- Versión reportada: KeePassXC 2.8.0.
- Distribución portable descargada y SHA-256 cotejado por el operador contra el digest oficial.
- SHA-256 reportado del ejecutable: `72200BFE1A6C59162BEE904832F3B292EDE45325EFFCEF54060C6AFF836DD28D`.
- Acceso directo reportado: `C:\\Users\\fila4\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\KeePassXC Portable.lnk`.
- El usuario informó que creó la base OCP y habilitó la integración con el navegador. No leer, exportar ni revelar su contenido.

### 5.3 Instalador MSI

El instalador MSI convencional de KeePassXC 2.8.0 quedó detenido en “Installing KeePassXC”, con barra de progreso en cero. La ventana dejó de mostrarse después de solicitar su cierre normal, pero los procesos de Windows Installer seguían activos en la última inspección. No existe evidencia de instalación MSI completada.

Restricción: no volver a ejecutar el MSI ni terminar a la fuerza procesos compartidos de Windows Installer. Utilizar la distribución portable verificada.

### 5.4 Playwright local

Directorio inicial reportado: `C:\\Users\\fila4\\AppData\\Local\\Harmonia\\BrowserPilot`.

Versiones reportadas:
- Playwright 1.64.1.
- `@playwright/mcp` 0.0.84.

Archivos que el operador reportó preparados:
- `package.json`
- `package-lock.json`
- `node_modules`
- `mcp-config.json`
- `run-playwright-mcp.cmd`
- `README-SETUP.md`

La configuración MCP tiene JSON válido según la inspección reportada. La conexión efectiva con el navegador OCP aún no se ha conseguido.

### 5.5 Intentos fallidos de lanzamiento

Se intentó lanzar Chrome, Edge y Chromium administrado por Playwright en instancias independientes. Los procesos terminaron antes de completar la primera navegación, con errores de navegador cerrado. No repetir ese enfoque como solución operativa; continuar con la arquitectura de extensión en el navegador existente.

## 6. Identificación del perfil OCP

Antecedente crítico: durante inspecciones se detectaron directorios `Profile` y `Profile 36`; metadatos locales mostraban el nombre visual OCP asociado a `Profile 36`. Una prueba anterior abrió una instancia adicional de Chrome con `--profile-directory="Profile 36"`, pero el usuario advirtió que no era el perfil autenticado correcto. La captura visual tampoco confirmó la sesión OCP esperada ni las extensiones necesarias.

**No asumir que Profile 36 es el perfil correcto.**

Al reanudar:
1. Partir de la instancia que el usuario reconoce como su Chrome operativo.
2. Consultar `chrome://version` en esa instancia y obtener el campo “Profile Path”.
3. Identificar y fijar el directorio real del perfil que corresponda.
4. No abrir una instancia adicional para adivinarlo.
5. No inferir el perfil por nombre visual ni confundir una pestaña “OCP MCP” con el perfil OCP.

## 7. KeePassXC y Native Messaging

Estado reportado:
- Configuración portable contiene `[Browser]` y `Enabled=true`.
- Existen manifiestos `org.keepassxc.keepassxc_browser_chrome.json`, `org.keepassxc.keepassxc_browser_brave.json`, `org.keepassxc.keepassxc_browser_chromium.json` y `org.keepassxc.keepassxc_browser_vivaldi.json`.
- Existe `keepassxc-proxy.exe`.
- La clave Native Messaging de Chrome apuntaba al manifiesto de Brave; Chrome y Brave mostraban contenido de manifiesto idéntico en la inspección reportada.
- Se intentó corregir el Registro y Windows rechazó la operación por permisos. No se modificó la clave.

No insistir en modificar el Registro ni eludir permisos. Primero comprobar si la asociación existente opera realmente; solo ante un fallo demostrado, evaluar una corrección mínima y autorizada. No cambiar configuración MCP del entorno global durante el estado provisional.

## 8. Extensiones requeridas

| Extensión | ID reportado | Estado que debe comprobarse |
|---|---|---|
| KeePassXC-Browser | `oboonakemofpalcgghocfoadofidjkkk` | Instalación, habilitación, perfil correcto y conexión a KeePassXC |
| Playwright Extension | `mmlmfjhmonkocbjadbfplnigmagldckm` | Instalación, habilitación, versión, permisos y conexión con Playwright MCP |

Se observaron directorios correspondientes a ambas extensiones dentro de `Profile 36`; esto no acredita que estén instaladas y habilitadas en el perfil operativo correcto.

## 9. Experiencia con un único monitor y control humano

La solución debe privilegiar una sola instancia de Chrome y el perfil OCP existente. El agente trabajará en una pestaña dedicada, visible y supervisable, sin abrir ventanas adicionales, cambiar de perfil, cerrar/reiniciar Chrome ni interferir con otras pestañas.

Debe existir un protocolo explícito para:
- Anunciar la toma de control de la pestaña delegada.
- Limitar al agente a las pestañas delegadas.
- Detenerse ante intervención humana en la pestaña controlada.
- Evitar que usuario y agente modifiquen simultáneamente la misma pestaña.
- Devolver el control al usuario de forma visible.
- Permitir pausar/reanudar la automatización sin cerrar el navegador.

El navegador puede recibir foco y la pestaña delegada puede cambiar de contenido; esa intrusión es admisible solo si es limitada, previsible e interrumpible.

## 10. Seguridad y credenciales

KeePassXC mantiene la custodia local de contraseñas y TOTP. No solicitar, leer, revelar ni exportar contraseña maestra, códigos TOTP, códigos de un solo uso, cookies, tokens de sesión ni contenido de la base. El usuario no debe pegar credenciales ni códigos 2FA en el chat.

La asociación KeePassXC ↔ KeePassXC-Browser debe ser autorizada localmente. El token local de conexión Playwright Extension debe permanecer protegido y fuera de archivos públicos/versionados. No habilitar extracción de cookies, almacenamiento o red fuera del mínimo requerido; toda ampliación de permisos necesita necesidad demostrada y autorización específica. No registrar secretos ni volcarlos a logs.

## 11. Plan de ejecución futuro

Al reactivar la tarea, ejecutar en este orden:

1. Identificar inequívocamente el perfil OCP desde la instancia existente y `chrome://version`.
2. Auditar KeePassXC portable y Native Messaging sin alterar permisos.
3. Verificar KeePassXC-Browser y su asociación funcional.
4. Verificar Playwright Extension en el perfil correcto.
5. Obtener y proteger el token local de conexión.
6. Configurar Playwright MCP con el directorio real del perfil OCP explícito.
7. Conectar al Chrome ya abierto sin lanzar otra instancia.
8. Verificar control de una pestaña delegada.
9. Ejecutar navegación de solo lectura.
10. Probar interrupción humana y devolución del control.
11. Validar navegación autenticada de solo lectura en Cora.
12. Integrar la capacidad como servicio/componente reutilizable de EP, una vez aprobada su arquitectura.
13. Documentar arquitectura, configuración, seguridad, recuperación y mantenimiento.
14. Ejecutar y registrar pruebas de aceptación.

## 12. Límites y autorizaciones

La autorización reportada para preparar Playwright y KeePassXC no permite por sí sola:
- Reorganizar la base OCP.
- Exportar credenciales o secretos.
- Modificar el perfil personal o perfiles ajenos.
- Cambiar configuraciones de producción.
- Ejecutar escrituras generales en Neon.
- Realizar despliegues.
- Fusionar ramas o publicar cambios no relacionados.
- Instalar TinyFish ni consumir su saldo.

El operador reportó una autorización anterior, específica y acotada, para una única prueba de persistencia sintética anonimizada mediante sesión autenticada de Cora, con lectura posterior e idempotencia. Esa autorización es distinta de la navegación de solo lectura del NCL: no se ejecuta durante esta tarea provisional ni se amplía. Si la prueba llega a ser pertinente cuando se active la tarea, primero recuperar y verificar el payload y procedimiento originales y comprobar que el alcance autorizado sigue vigente.

## 13. Criterios de aceptación

| ID | Criterio |
|---|---|
| NCL-01 | Perfil OCP identificado mediante Profile Path de la instancia existente |
| NCL-02 | Sesión autenticada existente reutilizada |
| NCL-03 | KeePassXC disponible y base OCP preservada |
| NCL-04 | Native Messaging operativo y validado |
| NCL-05 | KeePassXC-Browser conectado |
| NCL-06 | Playwright Extension instalada y habilitada en el perfil correcto |
| NCL-07 | Token local de conexión protegido y fuera del repositorio |
| NCL-08 | Playwright MCP conectado al navegador existente |
| NCL-09 | Perfil fijado explícitamente mediante su directorio real |
| NCL-10 | Una sola instancia de Chrome durante la operación |
| NCL-11 | Pestaña delegada controlable por el agente |
| NCL-12 | Pestañas ajenas preservadas y fuera del alcance del agente |
| NCL-13 | Interrupción humana efectiva y devolución del control |
| NCL-14 | Credenciales y TOTP protegidos, sin exposición a chat/logs/repositorio |
| NCL-15 | Navegación autenticada de solo lectura en Cora |
| NCL-16 | Recuperación de conexión tras reinicio, sin duplicar Chrome ni perder perfil |
| NCL-17 | Documentación arquitectónica fiel al comportamiento probado |
| NCL-18 | Evidencia reproducible y verificable para cada criterio aceptado |

## 14. Criterio de cierre

La tarea solo podrá marcarse `completada` cuando los criterios aplicables estén verificados en el entorno autorizado, exista evidencia recuperable de la conexión y del control de pestañas, la navegación autenticada de solo lectura en Cora haya sido demostrada, la seguridad de credenciales se haya comprobado y la documentación arquitectónica describa fielmente la implementación real. La mera instalación de extensiones, JSON válido, un proceso iniciado o una captura de pantalla no bastan para declarar NCL operativo.

Si un criterio queda bloqueado, mantenerlo explícitamente abierto; no sustituirlo por una prueba más débil ni declarar aceptación por inferencia.

## 15. Siguiente actuación al reanudar

Mantener esta tarea en `pendiente` durante el trabajo prioritario actual de alojamiento de OCP MCP. Cuando ese trabajo concluya —o el operador ordene expresamente cambiar la prioridad—, adquirir de nuevo OEP, DUG y las fuentes técnicas actuales; comprobar el estado del equipo y de todos los componentes desde sus fuentes reales; y comenzar por identificar el perfil OCP desde la instancia Chrome que el usuario reconoce como suya. No reutilizar datos volátiles ni asumir que el estado técnico reportado continúa vigente.

**Estado al crear esta tarea:** ningún componente de NCL fue modificado, conectado, instalado, probado o aceptado en este ciclo.


## 16. Bitácora acumulativa obligatoria por ciclo · delta 2026-10-31

Por instrucción directa del operador, NCL adopta la regla común del registro de tareas provisionales: cada ciclo sustantivo de NCL debe dejar una entrada abundante, cronológica y recuperable en este mismo README antes de cerrar el ciclo. La entrada debe cubrir fuentes/revisiones adquiridas; objetivo y estado previo; hallazgos observados y reportados distinguidos; decisiones y su autoridad; cambios exactos; pruebas y resultados; SHA/read-back cuando haya escritura; limitaciones y bloqueos; viabilidad; estimación sustentada del siguiente hito y del cierre; pendientes y siguiente acción.

La crónica es acumulativa: no se sustituye la historia anterior. Un NO-OP requiere cotejo y debe declararse como tal. No se crea un segundo OCP, bitácora paralela ni folio global. Las pruebas no realizadas no se describen como éxito. Esta regla no modifica el alcance técnico, el orden de activación, las autorizaciones de NCL ni convierte la tarea pendiente en tarea ejecutada.

**Registro de incorporación · 2026-10-31:** se añadió el requisito documental solicitado por el operador. No se revalidó Chrome, KeePassXC, Native Messaging, Playwright, perfil OCP ni Cora en este ciclo; el estado técnico previo permanece como antecedente reportado y pendiente de revalidación.


## Reporte individual obligatorio por tarea
Al resolver esta tarea, el responsable debe agregar el informe individual en este mismo núcleo siguiendo [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md), completar todos sus campos y actualizar el índice padre solo después del read-back. No marcar como completada sin criterios PASS, evidencia ejecutada, integridad verificada y aceptación exigible. Si termina parcial/bloqueada, dejar igualmente el informe con bloqueantes, preocupaciones, riesgos y condición objetiva de desbloqueo. Informar al operador con enlace al informe. Esta instrucción no altera titularidad, generación, permisos ni controles.


## Plan de ejecución estructurado para la reanudación · 2026-11-11

**Estado de este plan:** preparado para cuando se cumpla la condición de activación vigente o el operador cambie expresamente el orden. No cambia el estado pendiente de EP-TASK-001 ni autoriza conexión, instalación, autenticación o uso de credenciales.

### Línea base, interfaces y secuencia

1. **Adquirir la línea base real en modo read-only.** Registrar fecha, perfil Chrome OCP identificado sin copiar cookies ni secretos, versiones de Chrome/Playwright/KeePassXC, extensión instalada, Native Messaging registrado, rutas efectivas y procesos. Contrastar el reporte histórico con los archivos y versiones remotos vigentes; no ejecutar cambios sobre el perfil del usuario durante este inventario.
2. **Congelar el mapa de integración antes de construir.** Documentar los contratos entre Chrome/perfil existente, Playwright Extension, Playwright MCP, Native Messaging, KeePassXC y la pestaña delegada. Cualquier cambio del mapa de componentes, del perímetro de credenciales o de la experiencia visible debe pasar por los candados P012/P013; no inferir revisión presencial ni aprobación por este plan.
3. **Implementar por cortes verticales independientes.** Primero conexión a una pestaña delegada; después limitación de alcance a esa pestaña; después custodia/uso autorizado de credenciales y TOTP mediante KeePassXC; por último pausa/reanudación y presentación visible. Cada corte identifica archivos de lectura/creación/modificación, interfaz consumida/producida y rollback. No cambiar el perfil completo ni las extensiones ajenas al alcance.
4. **Probar con datos y cuentas de prueba.** Los escenarios mínimos son: perfil equivocado, extensión desconectada, Native Messaging ausente, pestaña no delegada, intento de acceso a pestaña ajena, sesión expirada, credencial denegada, TOTP no disponible, agente interrumpido y recuperación. Ninguna salida de prueba puede contener contraseña, TOTP, cookie, token o contenido de KeePass.
5. **Smoke funcional supervisado.** La primera navegación real será la validación de solo lectura en Cora definida por la tarea, desde la pestaña dedicada del perfil OCP verificado. Confirmar que el usuario puede observar, detener y reanudar el control y que Chrome permanece abierto.

### Review Focus y aceptación

- Reutiliza el Chrome/perfil existente; no crea un perfil paralelo ni fuerza una nueva autenticación como sustituto.
- El agente solo opera en pestañas delegadas; el resto del perfil, ventanas, sesiones y pestañas se preservan.
- La operación es visible, interrumpible y compatible con un solo monitor; no se declara UX aceptada por una prueba estructural.
- KeePassXC conserva la custodia; no se exportan secretos a argumentos, logs, archivos, conversación ni variables persistentes innecesarias.
- Cada prueba declara PASS/FAIL/NOT_RUN, código de salida, evidencia saneada y límites.
- Criterio de cierre: navegación Cora read-only verificada, control humano probado, sesión preservada, pruebas negativas PASS, documentación/read-back y aceptación humana aplicable.

### Rollback y registro

Antes de cada mutación, preservar configuración previa y anotar cómo volver a ella. Ante fallo, desconectar el puente y restaurar únicamente los archivos/configuraciones modificados; nunca cerrar Chrome ni borrar sesiones como rollback. Registrar el resultado en esta tarea y actualizar el índice solo tras read-back. La tarea continúa pendiente mientras no se cumpla su activación.

---

## Reactivación por instrucción expresa y preflight NCL · 2026-11-11 · 10:38 America/Mexico_City

**Estado operativo:** en_curso · PREFLIGHT_PARTIAL · OCP_PROFILE_IDENTIFIED · PLAYWRIGHT_EXTENSION_PRESENT · KEEPASSXC_BROWSER_MISSING · NATIVE_MESSAGING_UNVERIFIED.

### Decisión de prioridad y perfil

El operador ordenó explícitamente resolver todas las tareas EP en este ciclo; esto levanta la espera operativa previa que subordinaba NCL a la finalización de la instalación MCP-OCP. La reanudación habilita planificación y preflight, no omite requisitos técnicos, revisión humana ni gates de seguridad.

La sesión RDC de trabajo se identificó por el usuario CENTRAL/fila4 y el perfil C:/Users/fila4. Los metadatos locales de Chrome identifican dos perfiles: Profile = Tu Chrome y Profile 36 = OCP. Por tanto, el perfil OCP queda identificado como Profile 36; no se leyeron cookies, historial, URLs, pestañas, credenciales ni contenido de sesiones.

### Componentes observados

- Chrome está instalado y activo. Se identificó Profile 36 con nombre OCP mediante Local State, leyendo solo nombre y directorio de perfil. No se determinó si la extensión está habilitada o conectada a un servidor.
- Playwright Extension 0.4.0 está materializada en Profile 36. El manifiesto declara permisos debugger, activeTab, tabs y tabGroups. La búsqueda de archivos playwright-mcp dentro de los repositorios SeryMente no encontró coincidencias; esto no excluye una instalación fuera de esa raíz.
- KeePassXC portable existe bajo AppData/Local/Programs/KeePassXC-Portable con KeePassXC.exe y keepassxc-proxy.exe. El proceso KeePassXC no estaba en ejecución durante el inventario.
- En los directorios Extensions examinados de Profile y Profile 36 no se encontró KeePassXC-Browser: Profile contiene Google Docs Offline y Profile 36 contiene Playwright Extension.
- El manifiesto host de KeePassXC disponible declara dos allowed_origins que no incluyen el origen de Playwright Extension. La comprobación del registro NativeMessagingHosts fue bloqueada por la política RDC al intentar reg query; no se intentó una ruta alternativa. El registro/activación real del host permanece NO_VERIFICADO.
- No se ejecutó Cora, no se conectó Playwright MCP y no se realizó navegación autenticada.

### Incidente de custodia KeeShare · observación saneada

Durante una lectura local de configuración de KeePassXC, la salida incluyó material de clave privada KeeShare. No se reproduce ni conserva su contenido en esta documentación, no se exportó a Git ni a ningún otro archivo y no se abrió la base de datos. Por precaución debe tratarse como material expuesto en el contexto de esta inspección: el propietario debe rotar la pareja KeeShare y revisar o revocar la confianza de los grupos compartidos afectados. No se ejecutó la rotación ni se alteró la base.

### Review Focus y bloqueos actuales

- Perfil OCP identificado, pero falta confirmar autorización/presencia para conectar una pestaña concreta y revisar la experiencia visible.
- Falta instalar o validar KeePassXC-Browser en el perfil OCP, habilitar el origen correcto y acreditar Native Messaging. No alterar perfiles o extensiones hasta superar la revisión P012/P013.
- La clave KeeShare requiere rotación local controlada; no leer ni volver a exponer la configuración.
- Siguiente paso seguro: revisar presencialmente el perfil OCP y aprobar la configuración UX/seguridad; después configurar KeePassXC-Browser y Native Messaging, conectar una pestaña delegada de prueba y ejecutar únicamente el smoke read-only en Cora.

 
## Revalidación NCL read-only de Profile 36 · 2026-11-11 · 14:51 America/Mexico_City

**Resultado:** `PREFLIGHT_UPDATED · KEEPASSXC_BROWSER_PRESENT · EXTENSION_ENABLEMENT_UNVERIFIED · NATIVE_MESSAGING_UNVERIFIED`. Esta observación actualiza la fotografía anterior de 10:38; no permite determinar en qué momento se materializó la extensión ni acreditar conexión funcional.

### Identidad y estado del perfil

- RDC activo en el equipo `PC10RCIF4EI4`, contexto propietario `CENTRAL\fila4`, SessionId 1. Chrome tiene procesos activos en esa sesión.
- Directorio de perfil `Profile 36` existe bajo el User Data de Chrome; es el perfil identificado previamente como OCP. Se leyeron solo metadatos de extensiones, sin historial, cookies, pestañas, URLs, contenido de sesión o credenciales.
- **Playwright Extension:** ID `mmlmfjhmonkocbjadbfplnigmagldckm`, versión 0.4.0, Manifest V3; permisos declarados `debugger`, `activeTab`, `tabs`, `tabGroups`.
- **KeePassXC-Browser:** ID `oboonakemofpalcgghocfoadofidjkkk`, versión 1.10.4.1, Manifest V3. Su carpeta de extensión y entrada de Secure Preferences están presentes; From Web Store=True, location=1, DisableReasons vacío. El campo `state` no está presente en la entrada consultada, por lo que **no se afirma que esté habilitada**.
- La lectura anterior que reportó KeePassXC-Browser ausente queda sustituida como estado actual; se conserva como antecedente de la observación 10:38, sin inferir cuándo cambió.

### KeePassXC portable y host manifests

- Raíz portable localizada en `AppData\Local\Programs\KeePassXC-Portable`; `KeePassXC.exe` y `keepassxc-proxy.exe` existen.
- Proceso KeePassXC no estaba ejecutándose durante esta lectura. Por tanto, no se verificó asociación funcional ni diálogo de conexión.
- Se encontraron cuatro manifiestos host: variantes Chrome, Brave, Chromium y Vivaldi, en `KeePassXC-Portable\config\`. Cada uno declara el host `org.keepassxc.keepassxc_browser`; el ejecutable de host referenciado existe; los cuatro incluyen el origen de KeePassXC-Browser.
- Los manifiestos no incluyen el origen de Playwright Extension. No se propone añadirlo: el puente de automatización Playwright y el host de KeePassXC son componentes distintos, y cualquier cambio de orígenes/permiso requiere análisis y revisión explícitos.
- La asociación del Registro `NativeMessagingHosts` no pudo volver a consultarse: la consulta previa fue bloqueada por RDC. No se buscó un método alternativo para eludir esa limitación. La mera existencia de los manifiestos no prueba qué archivo está registrado para Chrome ni que Chrome pueda lanzar el host.

### Candados y trabajo no ejecutado

- No se modificaron registro, archivos de configuración, manifiestos, extensiones, perfiles ni permisos.
- No se abrió KeePassXC ni la base; no se volvió a leer configuración KeeShare; no se expusieron claves, contraseñas, TOTP, cookies, tokens ni contenido de la base.
- KeeShare sigue requiriendo rotación local controlada por su propietario. No se ejecutó.
- No se habilitó ni conectó la extensión, no se conectó Playwright MCP, no se delegó pestaña, no se abrió Cora y no se ejecutó navegación autenticada.
- P012/P013 continúan como gates para cambios UX/seguridad y validación supervisada.

### Siguiente gate

Conservar el inventario como `PARTIAL`. Requiere revisión presencial del propietario P012/P013, rotación KeeShare y verificación local de que Chrome mantiene KeePassXC-Browser habilitada y que Native Messaging puede iniciar el host. Solo después se probará una asociación local supervisada, sin exportar secretos, antes de delegar una pestaña para Cora read-only.

**Límites:** la instalación materializada de KeePassXC-Browser ya no se considera ausente, pero el preflight NCL no está completado ni aceptado.


## Revalidación Native Messaging y estado de Chrome · 2026-11-11 · ejecución read-only

**Resultado:** `NCL_PREFLIGHT_UPDATED · HOST_MANIFEST_AND_REGISTRY_STATIC_PASS · EXTENSION_ENABLEMENT_UNVERIFIED · LIVE_HANDSHAKE_NOT_RUN · KEEPSHARE_ROTATION_PENDING`.

### Evidencia nueva bajo CENTRAL\fila4

- Perfil Chrome OCP: `Profile 36`. En Secure Preferences la entrada de KeePassXC-Browser (`oboonakemofpalcgghocfoadofidjkkk`) existe; ruta relativa `oboonakemofpalcgghocfoadofidjkkk\1.10.4.1_0`, carpeta y `manifest.json` presentes; versión 1.10.4.1 y nombre `KeePassXC-Browser`.
- La entrada Secure Preferences no expone el campo `state`; `active_bit=false`, `has_started_service_worker=true`, `disable_reasons` vacío y `withholding_permissions=false`. Estos metadatos no permiten demostrar de forma inequívoca el estado habilitado y no se hizo una conexión real.
- Registro `HKCU\Software\Google\Chrome\NativeMessagingHosts\org.keepassxc.keepassxc_browser` presente. Su valor apunta a `...\config\org.keepassxc.keepassxc_browser_brave.json`; la denominación `_brave` no constituye por sí sola una incompatibilidad: los cuatro manifiestos Chrome/Brave/Chromium/Vivaldi cotejados tienen SHA-256 idéntico `D3667E44162E5DEE88B0A4F7E2F9E9AF927D921321C10186080A991938C43B92`, declaran `name=org.keepassxc.keepassxc_browser`, `type=stdio`, el mismo `keepassxc-proxy.exe` existente y el origen Chrome de KeePassXC-Browser (`chrome-extension://oboonakemofpalcgghocfoadofidjkkk/`).
- KeePassXC portable 2.8.0 y `keepassxc-proxy.exe` presentes. El proceso KeePassXC no estaba activo durante la lectura; no se abrió la GUI ni la base.
- No se volvió a leer ni copiar configuración KeeShare. La rotación de la pareja KeeShare y la revisión presencial de P012/P013 siguen pendientes del propietario.

### Interpretación y próximo paso acotado

La capa estática de Native Messaging está materializada (clave de Registro, manifiesto compatible y ejecutable existente). No equivale a handshake runtime ni a asociación funcional. El estado de habilitación de la extensión permanece `UNVERIFIED`; la prueba de conexión supervisada y la navegación Cora read-only no se ejecutaron. No se modificaron Registro, extensiones, Profile 36, permisos, KeePassXC, base, KeeShare ni procesos.

**Siguiente gate de EP-TASK-001:** propietario completa la rotación local controlada de KeeShare y revisión P012/P013; a continuación se valida la extensión desde la interfaz y se realiza el handshake Native Messaging supervisado, sin exponer secretos, antes del smoke Cora read-only.
