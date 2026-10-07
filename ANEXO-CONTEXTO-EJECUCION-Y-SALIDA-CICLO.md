# Anexo - Contexto de Ejecucion y Formato de Salida por Ciclo

**Estado:** CANONICO
**Version:** v1.7.1 — Thinking y HUD Compacto por Turno
**Fecha de canonizacion:** 2026-10-07
**Ambito:** Todos los proyectos y conversaciones sujetos a la metodologia comun.

## 1. Proposito

Este anexo define el contexto operativo minimo que acompana cada ciclo y las reglas para identificar el entorno desde el que se ejecuta el trabajo.

Ubicacion, cuentas, dispositivos, usuarios concretos, porcentajes de uso y formatos son datos y mecanismos operativos; permanecen en este nivel y no se elevan a principio fundamental salvo que una revision posterior determine una necesidad normativa irreductible.

## 2. Identidad de ejecucion

Cada ciclo distingue:
- Ubicacion: lugar fisico de trabajo.
- RDC: canal y cuenta de Remote Desktop Commander que proporcionan acceso al entorno remoto.
- Usuario Windows operativo: identidad operativa de referencia definida por el perfil de ubicación; no implica que cada operación deba ejecutarse bajo ella.
- Usuario Windows administrativo/elevado: identidad efectiva que puede sostener la sesión RDC y ejecutar cualquier trabajo técnicamente válido; no requiere cambio de identidad salvo que una operación concreta exija otro permiso.

La cuenta de RDC y las identidades de Windows son entidades distintas.

## 3. Ubicaciones canonicas

| Codigo | Nombre |
|---|---|
| CECEQ | CECEQ |
| OFFICE-DEPOT | Office Depot |
| CIBERCAFE | Cibercafe |

No se infiere una cuarta ubicacion. Una nueva ubicacion requiere actualizacion canonica de este anexo.

La ubicacion es un estado transversal y persistente de trabajo. Una declaracion explicita del usuario establece o cambia UBICACION_ACTUAL; permanece vigente entre ciclos y conversaciones hasta que el usuario declare otra ubicacion. Sin declaracion vigente ni fuente fiable, se muestra NO VERIFICADA.

## 4. Perfil por ubicacion

### 4.1 CECEQ

| Campo | Valor canonico |
|---|---|
| Ubicacion | CECEQ |
| Usuario Windows operativo | fila4 |
| Usuario Windows administrativo/elevado | central\mantenimientorci |
| Regla de sesión | El canal RDC permanece bajo central\\mantenimientorci; no se abren sesiones RDC paralelas bajo fila4. |
| Regla | fila4 es la identidad operativa del perfil; central\\mantenimientorci es la identidad efectiva del canal RDC. La diferencia se conserva y se resuelve por procedimiento, no por cambio de sesión. |

### 4.2 Office Depot

Perfil operativo detallado: PENDIENTE DE PERFILADO.

### 4.3 Cibercafe

Perfil operativo detallado: PENDIENTE DE PERFILADO.

No se inventan identidades Windows para perfiles pendientes.

## 5. Estado de RDC

Cada ciclo debe distinguir dos dimensiones:
- **RDC-SESION:** identidad persistente global (`ACTIVA`, `INACTIVA` o `NO VERIFICADA`).
- **RDC-CONECTIVIDAD:** posibilidad de uso en vivo del canal/dispositivo (`VERIFICADA`, `NO VERIFICADA`, `OFFLINE OBSERVADA` o equivalente).

Cada ciclo debe identificar además:
- PLATAFORMA: ChatGPT.
- RDC-ESTADO: estado del dispositivo/canal cuando este disponible.
- RDC-CUENTA: correo de la cuenta RDC efectivamente utilizada, o NO VERIFICADO.
- RDC-USO-MENSUAL: porcentaje usado y porcentaje restante, o NO DISPONIBLE.
- RDC-TERMINAL: estado o numero de sesiones terminales cuando este disponible.

Si la API proporciona remote_calls_left_pct, se calcula:

uso_pct = 100 - remote_calls_left_pct

No se infieren plan, limite bruto, fecha de restablecimiento ni otros datos no proporcionados por la API.

RDC-USO-MENSUAL es obligatorio en la salida de cada ciclo, pero no obliga a consumir una llamada RDC solo para producirlo. Se reutiliza el ultimo dato verificado disponible y se conserva su marca temporal.

## 6. Flexibilidad de identidad y restricción de repositorios

1. La identidad efectiva del canal RDC puede utilizarse para cualquier operación técnicamente válida.
2. La identidad operativa de referencia del perfil se conserva como contexto; no constituye una obligación de cambio de usuario para cada operación.
3. La diferencia con WIN-OPERATIVO se registra como contexto, pero no constituye por sí misma una condición de bloqueo.
4. No se abren sesiones RDC paralelas para resolver la diferencia.
5. La única restricción específica es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.

## 7. Formato obligatorio de salida por ciclo

La salida visible de un ciclo debe ser minima y suficiente. Su funcion es mostrar identidad, estado contextual y resultado; no repetir el detalle del mecanismo interno ni el registro de auditoria. El HUD utiliza una presentación compacta con **negritas**, `código` y estados discretos.

Formato canónico visible:

PROYECTO / CONV-XX / CXXX

SI CARGADO · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETO · ACTIVO

ChatGPT · UBIC: ... · RDC: ... · C: ... · S: ... · K: ✓|?|! · T: ✓|?|! · RDC-CNX: ... · USR: ...

RESULTADO: ...
ESTADO: COMPLETADO | BLOQUEADO | PENDIENTE

Convenciones:
- `ChatGPT` se muestra sin etiqueta.
- `UBIC` = ubicación.
- `RDC` = si RDC es requisito: SI, NO o PENDIENTE.
- `C` = cuenta RDC.
- `S` = sesión RDC persistente: ACTIVA, INACTIVA o NO VERIFICADA.
- `K` = conectividad RDC: OK, NO VERIFICADA u OFFLINE.
- `USR` = identidad operativa visible del perfil. En CECEQ siempre se muestra `fila4`, nunca `central\\mantenimientorci`.
- El nombre del dispositivo RDC puede añadirse sin etiqueta únicamente cuando sea relevante para la tarea.
- No se muestran en la salida cotidiana el device_id, WIN-ADMIN, WIN-EFECTIVO-RDC, RDC-TERMINAL ni otros identificadores internos.
- Los detalles completos de cuenta, dispositivo, identidad efectiva, timestamps y evidencia permanecen en el estado global y en los registros de auditoría.
- La ausencia de un dato se representa como NO VERIFICADO, NO DISPONIBLE o PENDIENTE. Nunca se inventa.

La foliación global del ciclo y la identificación canónica del SI conservan sus reglas vigentes.

## 8. Procedencia

- Ubicacion: USUARIO cuando sea declarada.
- Cuenta y estado RDC: RDC.
- Usuario Windows activo: SISTEMA OPERATIVO.
- Identidad bajo la que se ejecuto un proceso: PROCESO RDC / SISTEMA OPERATIVO.

Una discrepancia entre la identidad RDC, la identidad Windows operativa esperada y la identidad real de ejecucion debe hacerse visible en el ciclo.

## 9. Activacion inicial CECEQ

En la activacion inicial de este anexo se verifico:
- dispositivo RDC ONLINE: PC10RCIF4EI4, ID 7fabbc1d-7c0d-4400-bd31-88b3b4229286;
- cuenta RDC autenticada: blacksheepsup@gmail.com;
- 96% de llamadas RDC restantes este mes, equivalente a 4% usado;
- la nueva conexion RDC informa canal activo y dispositivo ONLINE;
- existe una sesion interactiva de Windows fila4 activa;
- el shell de RDC se ejecuta bajo central\mantenimientorci.

Conclusion: CECEQ esta identificado. La sesion RDC actualmente verificada se ejecuta bajo central\mantenimientorci y esa identidad puede utilizarse para el trabajo tecnicamente valido. fila4 permanece como identidad operativa de referencia del perfil. No se abren sesiones paralelas ni se cambia la identidad solo para trabajar.## 10. Registro global de la sesion RDC activa

La sesion RDC activa es estado operativo transversal y no pertenece a una conversacion particular. Su identidad persiste entre conversaciones hasta que se registre explícitamente su finalización o sustitución. Su registro global se conserva en ESTADO-RDC-ACTIVO.md.

El registro contiene como minimo ubicacion, cuenta RDC, identidad de conexion, device_id, nombre de dispositivo, estado de la sesión persistente, estado de conectividad, usuario Windows operativo esperado, identidad administrativa cuando exista, fecha de configuracion, ultima verificacion y consumo mensual disponible.

Una nueva sesion configurada sustituye la sesion activa anterior. No se mantienen varias sesiones como activas simultaneamente salvo canon posterior.

## 11. Verificacion minima por ciclo

Si existe una sesion registrada como activa y no existe una marca de finalización/sustitución, la identidad de esa sesión se hereda automáticamente al ciclo.

Metodo primario para **conectividad en vivo**:
1. reutilizar cuenta y device_id registrados;
2. ejecutar ping sobre el dispositivo conocido cuando la tarea requiera RDC en vivo;
3. si responde, mantener la sesion ACTIVA y actualizar la marca de verificacion de conexion;
4. si falla, conservar la identidad persistente y escalar a descubrimiento solo cuando sea necesario para determinar un cambio o recuperar la conectividad.

Un fallo de ping no convierte por sí mismo la sesión en INACTIVA.

No se ejecutan list_devices ni who_am_i exclusivamente en cada ciclo cuando el ping confirma la misma sesion.

El porcentaje mensual se reutiliza desde la ultima lectura validada y solo se actualiza cuando una llamada ya necesaria lo expone o cuando el usuario solicita comprobacion explicita.

La verificacion de sesion RDC y la verificacion de sesiones de terminal son estados distintos.

## 12. Propagacion entre conversaciones

El registro global de sesion activa es independiente de la conversacion contenedora. Cada nueva conversacion sujeta a la metodologia consume primero el estado global mas reciente y hereda la identidad persistente antes de formular cualquier pregunta al usuario sobre la sesión.

La verificacion de conectividad es una comprobación distinta: se ejecuta cuando el ciclo necesita utilizar RDC en vivo, no para decidir si la identidad persistente sigue existiendo.

Un cambio de conversación no finaliza la sesión. Solo un cierre o sustitución explícitos, o evidencia positiva suficiente de que la sesión registrada ya no existe, puede cambiar la identidad global.

Cuando la verificacion detecte una nueva sesion, esta pasa a ser la sesion activa global y el registro debe actualizarse antes de ejecutar operaciones sustantivas dependientes de RDC.


## 12.1 Gate fail-closed por ciclo

La sección 11 define la verificación mínima cuando ya existe una sesión registrada. El gate completo exige además verificar que el estado global sea legible y que pueda distinguirse entre ACTIVA, INACTIVA e INDETERMINADA.

### Secuencia obligatoria

1. Leer ESTADO-RDC-ACTIVO.md.
2. Intentar detección automática de la sesión actual mediante la fuente RDC disponible.
3. Si existe una sesión registrada y el dispositivo conocido responde al ping, conservarla como activa y actualizar la marca temporal.
4. Si el ping falla, escalar a descubrimiento de dispositivos y cuenta.
5. Si la detección demuestra inequívocamente que no existe sesión activa, registrar RDC-SESION: INACTIVA.
6. Si no puede determinarse si existe una sesión activa, registrar RDC-SESION: NO VERIFICADA y detener el trabajo sustantivo hasta preguntar al usuario si la conversación requiere una sesión RDC activa.
7. Si el usuario responde sí, solicitar la información mínima para establecerla (como mínimo, la evidencia final de conexión RDC que permita identificar cuenta y dispositivo), actualizar el estado global y verificarlo antes de continuar.
8. Si el usuario responde no, registrar RDC-REQUERIDA: NO y permitir únicamente trabajo que no dependa de RDC.

La herramienta indisponible nunca se interpreta como ausencia de sesión.

## 12.2 Propagación transversal

ESTADO-RDC-ACTIVO.md es el estado global lógico de la sesión, no una propiedad de una conversación. Toda conversación sujeta a esta metodología consume el estado más reciente al iniciar cada ciclo.

Cuando una verificación identifica una sesión diferente de la registrada, la nueva sesión sustituye a la anterior antes de cualquier operación dependiente de RDC.

La propagación no se considera completada por la mera lectura de un valor almacenado: el ciclo debe vincular su salida al estado efectivamente verificado y conservar la marca temporal y procedencia de la verificación.

## 12.3 Perfil operativo de ubicación

Después de resolver la sesión RDC, el ciclo debe resolver UBICACION_ACTUAL y el perfil operativo correspondiente. Las reglas específicas del perfil se aplican antes de ejecutar operaciones condicionadas por identidad, rutas, permisos, herramientas o configuración.

Para CECEQ, la resolución canónica es:

WIN-OPERATIVO = fila4
WIN-ADMIN = central\\mantenimientorci

La identidad efectiva de ejecución y la identidad operativa de referencia pueden diferir. Esa diferencia no bloquea por sí misma el trabajo. La restricción especial del perfil es únicamente no clonar ni materializar repositorios nuevos dentro de MantenimientoRCI.

## 12.4 Condición de bloqueo

El ciclo se marca BLOQUEADO cuando ocurra cualquiera de estas condiciones:

- no puede leerse el estado global de RDC;
- la detección automática no puede establecer activo/inactivo y el usuario aún no ha resuelto si RDC es requisito;
- RDC es requerido pero no existe una sesión verificada;
- la ubicación es desconocida cuando la tarea depende de un perfil de ubicación;
- el perfil de la ubicación no existe o no es suficiente;
- la identidad Windows operativa requerida no puede verificarse;
- la resolución por el canal operativo conocido no puede establecerse cuando el canal actual está bajo la identidad administrativa.

Mientras el ciclo esté BLOQUEADO, no se ejecutan operaciones dependientes del contexto y no se declara cierre exitoso.

## 12.5 Flexibilidad de ejecución para CECEQ

No se requiere puente ni sesión adicional. La sesión RDC vigente se conserva bajo `central\\mantenimientorci` para todos los efectos de uso de RDC.

En CECEQ, `fila4` permanece como identidad operativa definida por el perfil, pero no se abre una sesión RDC paralela ni se altera la sesión existente para transformarla en fila4.

Secuencia:

1. detectar la identidad efectiva del canal RDC;
2. comparar contra `WIN-OPERATIVO` del perfil;
3. conservar intacta la sesión RDC bajo central\\mantenimientorci;
4. ejecutar solo operaciones compatibles con la identidad efectiva y verificar el resultado;
5. si una operación requiere necesariamente identidad fila4 y no puede resolverse desde la sesión vigente, bloquearla en lugar de crear una sesión paralela.

No se almacenan credenciales, no se usa `runas`, no se cierra sesión y no se inicia un segundo canal RDC.

## 13. Referencia terminológica

La ubicación y los identificadores de entorno deben utilizar las formas del glosario canónico. Para la ubicación actual, la forma canónica es `CECEQ`. Las formas reconocibles como errores de transcripción no deben propagarse a la salida.


## 14. Gate de Thinking y contrato de salida

**Regla transversal:** `K` queda reservado exclusivamente para el acceso/verificación del MCP canónico de KHORA en todos los documentos metodológicos. La conectividad de RDC se expresa como `RDC-CNX` y no puede reutilizar `K`.

Todo ciclo sujeto a la metodología debe ejecutarse en modo Thinking de ChatGPT. La secuencia normativa se realiza durante el razonamiento del turno:

`THINKING → HEALTH → OPEN → CASCADA NORMATIVA → VERIFY → RELEASE → SALIDA`

El campo `T` tiene semántica fail-closed:
- `T: ✓` = atestado `reasoning_mode=THINKING` aceptado y formato `v1.7.0` establecido.
- `T: ?` = condición no verificable; bloqueo.
- `T: !` = modo no permitido; bloqueo.

El servidor MCP no recibe actualmente de ChatGPT una metadata documentada que exponga directamente el selector del modo Thinking. Por ello, el protocolo no debe fingir una prueba de interfaz que no existe: exige el atestado `THINKING` y rechaza cualquier ausencia o valor distinto.

El formato visible `v1.7.0` es obligatorio en todos los ciclos, incluidos ciclos BLOQUEADOS. `E: COMPLETADO` requiere además `VERIFIED_RELEASE`.
