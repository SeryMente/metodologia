# Anexo - Contexto de Ejecucion y Formato de Salida por Ciclo

**Estado:** CANONICO
**Version:** v1.7.6 — HUD Compacto con Verificación de Régimen Personalizado
**Fecha de canonizacion:** 2026-10-08
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

### 4.3 Cibercafé · Luis Pasteur

| Campo | Valor canónico |
|---|---|
| Ubicacion | CIBERCAFE · Luis Pasteur |
| Arquitectura | Múltiples terminales RDC independientes |
| Identidad de terminal | `RDC-CUENTA + RDC-DEVICE-ID` |
| Regla | La ubicación no selecciona una terminal. El dispositivo concreto se resuelve por descubrimiento vivo en cada ciclo. |
| Persistencia | `ESTADO-RDC-ACTIVO.md` conserva identidades conocidas y ciclos de vida; no existe una única terminal global del cibercafé. |

No se inventan identidades Windows ni etiquetas de terminal que el proveedor no proporcione.

## 5. Estado de RDC

Cada ciclo debe distinguir:
- **RDC-REGISTRO:** identidades conocidas y ciclos de vida persistidos.
- **RDC-DESCUBRIMIENTO:** conjunto de dispositivos observables en vivo en las cuentas accesibles.
- **RDC-TERMINAL:** identidad concreta seleccionada para el ciclo, definida por `RDC-CUENTA + RDC-DEVICE-ID`.
- **RDC-CONECTIVIDAD:** posibilidad de uso en vivo del dispositivo seleccionado.
- **RDC-OBSERVABILIDAD:** relación entre señales del proveedor y la evidencia local.
- **RDC-RECUPERACION:** estado de recuperación de la terminal seleccionada.

Cada ciclo debe identificar además:
- PLATAFORMA: ChatGPT.
- RDC-ESTADO: estado del dispositivo/canal seleccionado cuando esté disponible.
- RDC-CUENTA: cuenta de la terminal seleccionada, o NO VERIFICADO.
- RDC-USO-MENSUAL: porcentaje usado y porcentaje restante de la cuenta seleccionada, o NO DISPONIBLE.
- RDC-TERMINAL: dispositivo seleccionado y, cuando sea necesario para auditoría, su device_id.

El nombre del dispositivo no es suficiente para diferenciar terminales. Dos identidades con nombres iguales siguen siendo terminales distintas si sus device_id difieren.

Si la API proporciona remote_calls_left_pct, se calcula:

uso_pct = 100 - remote_calls_left_pct

No se infieren plan, limite bruto, fecha de restablecimiento ni otros datos no proporcionados por la API.

RDC-USO-MENSUAL es obligatorio en la salida de cada ciclo, pero no obliga a consumir una llamada RDC solo para producirlo. Se reutiliza el ultimo dato verificado disponible y se conserva su marca temporal.

## 5.1 Descubrimiento y recuperación por terminal

La fuente RDC en vivo determina qué terminales están ONLINE en el ciclo. `ESTADO-RDC-ACTIVO.md` se utiliza para reconciliar identidades y conservar continuidad, no para decidir presencia actual.

Cuando exista una identidad seleccionada:
- el `ping` verifica su conectividad de ejecución;
- si deja de responder, el ciclo vuelve a descubrir el conjunto ONLINE antes de concluir que la terminal está ausente;
- una terminal diferente no sustituye automáticamente a la seleccionada.

`RDC-REINSTANTIAR` se activa únicamente cuando la terminal requerida no es observable en vivo y la tarea necesita esa terminal.

### Regla de precedencia RDC antes de KHORA

Antes de cualquier certificación o health-check de KHORA, cada ciclo debe consumir el registro persistente y ejecutar descubrimiento vivo cuando RDC sea relevante. La selección de la terminal se establece después de observar el conjunto actual de dispositivos.

Si el modelo comunica una ausencia o pérdida de RDC, debe emitir inmediatamente `RDC-REINSTANTIAR` y el comando oficial vigente. Un handshake fresco actualiza o incorpora la identidad concreta que efectivamente se conectó.

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

METODOLOGÍA CARGADA · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETA · ACTIVA

ChatGPT · CI: ✓|?|! · UBIC: ... · RDC: ... · C: ... · RDC-USO: ...% usado / ...% restante · S: ... · K: ✓|OFF|?|! · T: ✓|?|! · RDC-CNX: ... · USR: ...

RESULTADO: ...
ESTADO: COMPLETADO | BLOQUEADO | PENDIENTE

Convenciones:
- `ChatGPT` se muestra sin etiqueta.
- `UBIC` = ubicación.
- `RDC` = si RDC es requisito: SI, NO o PENDIENTE.
- `C` = cuenta RDC de la terminal seleccionada para este ciclo.
- `RDC-USO` = porcentaje mensual usado y porcentaje restante de la cuenta de la terminal seleccionada. Se presenta con el último dato verificado disponible y su vigencia temporal; cuando no exista, se muestra `NO VERIFICADO` o `NO DISPONIBLE`.
- `S` = estado de sesión de la terminal seleccionada: ACTIVA, INACTIVA o NO VERIFICADA.
- `K` = estado del verificador MCP canónico de KHORA: `✓`, `OFF`, `?` o `!`. `RDC-CNX` conserva la conectividad del canal RDC.
- `USR` = identidad operativa visible del perfil. En CECEQ siempre se muestra `fila4`, nunca `central\\mantenimientorci`.
- El nombre del dispositivo RDC puede añadirse sin etiqueta únicamente cuando sea relevante para la tarea.
- No se muestran en la salida cotidiana el device_id, WIN-ADMIN, WIN-EFECTIVO-RDC, RDC-TERMINAL ni otros identificadores internos.
- Los detalles completos de cuenta, dispositivo, identidad efectiva, timestamps y evidencia permanecen en el estado global y en los registros de auditoría.
- La ausencia de un dato se representa como NO VERIFICADO, NO DISPONIBLE o PENDIENTE. Nunca se inventa.

La foliación global del ciclo, la identificación canónica del SI y el indicador `CI` conservan sus reglas vigentes.

## 7.1 Verificación del régimen de Instrucciones personalizadas

`CI` registra la aplicación verificable del régimen de Instrucciones personalizadas durante el ciclo. No representa una lectura técnica observable del campo interno de la plataforma.

Estados permitidos:
- `CI: ✓` = condiciones observables del régimen satisfechas.
- `CI: ?` = evidencia insuficiente para sostener la aplicación.
- `CI: !` = contradicción o incumplimiento observable.

En una conversación nueva, el primer ciclo establece la continuidad del régimen para los ciclos siguientes. Cada ciclo posterior debe conservar esa continuidad y ejecutar las comprobaciones externas exigidas por el régimen.

`CI: ✓` no puede emitirse por la mera existencia del campo de Instrucciones personalizadas ni por memoria de un ciclo anterior; requiere la manifestación verificable del contrato aplicable al ciclo.

## 8. Procedencia

- Ubicacion: USUARIO cuando sea declarada.
- Cuenta y estado RDC: RDC.
- Usuario Windows activo: SISTEMA OPERATIVO.
- Identidad bajo la que se ejecuto un proceso: PROCESO RDC / SISTEMA OPERATIVO.

Una discrepancia entre la identidad RDC, la identidad Windows operativa esperada y la identidad real de ejecucion debe hacerse visible en el ciclo.

## 9. Activacion inicial

La activación inicial histórica se conserva solo como antecedente. No define la terminal actual ni la ubicación actual.

Los datos de cada ciclo deben provenir del descubrimiento RDC vivo y de la declaración/resolución de ubicación vigente.

## 10. Registro global de identidades RDC

`ESTADO-RDC-ACTIVO.md` es un registro operativo transversal de identidades RDC conocidas. Su unidad de identidad es `RDC-CUENTA + RDC-DEVICE-ID`.

Puede contener múltiples identidades ACTIVAS o conocidas simultáneamente. No contiene una terminal globalmente seleccionada para todas las conversaciones.

El registro conserva historial, nombres de dispositivo, últimas observaciones y ciclos de vida. La conectividad actual siempre se resuelve mediante el proveedor RDC en vivo.

## 11. Verificacion minima por ciclo

Si RDC es relevante, el ciclo:
1. lee el registro persistente;
2. descubre dispositivos ONLINE en las cuentas RDC accesibles;
3. reconcilia por cuenta + device_id;
4. selecciona la terminal concreta;
5. hace ping al dispositivo seleccionado cuando requiera conectividad de ejecución.

No se considera suficiente heredar una terminal por existir en el registro.

## 12. Propagacion entre conversaciones

La continuidad funciona por registro persistente + descubrimiento vivo.

Una conversación nueva recupera las identidades conocidas, pero vuelve a descubrir el conjunto ONLINE y puede seleccionar una terminal distinta de la utilizada por otra conversación.

La ubicación física y la terminal permanecen separadas. `CIBERCAFE · Luis Pasteur` no identifica una única PC.

## 12.1 Gate fail-closed por ciclo

La sección 11 define la verificación mínima cuando RDC es relevante. El gate completo exige además que el registro persistente sea legible y que el conjunto actual de dispositivos pueda descubrirse en vivo.

### Secuencia obligatoria

1. Leer `ESTADO-RDC-ACTIVO.md`.
2. Descubrir dispositivos ONLINE en todas las cuentas RDC accesibles al runtime.
3. Reconciliar por `RDC-CUENTA + RDC-DEVICE-ID`.
4. Si existe una sola terminal ONLINE y RDC es requerida, seleccionarla.
5. Si existen varias, usar una vinculación ya establecida o solicitar la mínima selección necesaria.
6. Si no existe ninguna ONLINE, determinar si RDC es requisito del ciclo.
7. Si RDC es requerida y no hay terminal observable, bloquear y ofrecer `RDC-REINSTANTIAR`.
8. Si RDC no es requerida, registrar `RDC-REQUERIDA: NO`.

La herramienta indisponible nunca se interpreta como ausencia positiva de terminal.

## 12.2 Propagación transversal

`ESTADO-RDC-ACTIVO.md` es el registro persistente global de identidades conocidas, no una propiedad de una conversación y no un selector global.

Toda conversación sujeta a esta metodología consume el registro y, cuando RDC es relevante, realiza descubrimiento vivo. Una conversación nueva puede seleccionar una terminal diferente de la utilizada por otra conversación.

Una terminal nueva no sustituye otra identidad distinta. Solo una transición verificable dentro de la misma identidad cuenta + device_id modifica su ciclo de vida.

La propagación no se considera completada por la mera lectura de un valor almacenado: el ciclo debe vincular su salida a la identidad efectivamente seleccionada y a la observación viva.

## 12.3 Perfil operativo de ubicación

Después de resolver la terminal RDC cuando la tarea dependa de ella, el ciclo debe resolver `UBICACION_ACTUAL` y el perfil operativo correspondiente. Las reglas específicas del perfil se aplican antes de ejecutar operaciones condicionadas por identidad, rutas, permisos, herramientas o configuración.

Para CECEQ, la resolución canónica permanece:

WIN-OPERATIVO = fila4
WIN-ADMIN = central\mantenimientorci

Para CIBERCAFE · Luis Pasteur, la ubicación contiene múltiples terminales y no asocia una PC determinada a la ubicación por defecto.

La identidad efectiva de ejecución y la identidad operativa de referencia pueden diferir. Esa diferencia no bloquea por sí misma el trabajo cuando la operación es técnicamente válida.

## 12.4 Condición de bloqueo

El ciclo se marca BLOQUEADO cuando ocurra cualquiera de estas condiciones:

- no puede leerse el registro persistente de RDC cuando la tarea depende de ese contexto;
- no puede realizarse el descubrimiento vivo y no existe una terminal seleccionada verificable para el ciclo;
- RDC es requerido pero no existe una terminal ONLINE verificable;
- hay múltiples terminales ONLINE y no existe información suficiente para seleccionar la terminal objetivo;
- la ubicación es desconocida cuando la tarea depende de un perfil de ubicación;
- el perfil de la ubicación no existe o no es suficiente;
- la identidad Windows operativa requerida no puede verificarse.

Mientras el ciclo esté BLOQUEADO, no se ejecutan operaciones dependientes del contexto y no se declara cierre exitoso.

## 12.5 Flexibilidad de ejecución para CECEQ

La identidad efectiva del canal RDC puede utilizarse para cualquier operación técnicamente válida.

En CECEQ, `fila4` permanece como identidad operativa definida por el perfil y `central\\mantenimientorci` como identidad administrativa efectiva cuando corresponda. Esta regla es independiente de la selección de terminal.

No se abre una sesión RDC paralela para cambiar de identidad Windows ni se utiliza una identidad histórica como sustituto de una terminal distinta.

## 13. Referencia terminológica

La ubicación y los identificadores de entorno deben utilizar las formas del glosario canónico. Para la ubicación actual, la forma canónica es `CECEQ`. Las formas reconocibles como errores de transcripción no deben propagarse a la salida.


## 14. Gate de Thinking y contrato de salida

**Regla transversal:** `K` queda reservado exclusivamente para el acceso/verificación del MCP canónico de KHORA en todos los documentos metodológicos. La conectividad de RDC se expresa como `RDC-CNX` y no puede reutilizar `K`.

Thinking es la ventana operativa preferente para resolver la cascada normativa cuando la plataforma la expone. No es una precondición para producir una respuesta y su ausencia, `INSTANT`, `UNKNOWN` o `UNAVAILABLE` no bloquean por sí mismos.

La secuencia preferente es:

`THINKING (si disponible) → HEALTH → OPEN → CASCADA NORMATIVA → VERIFY → RELEASE (si disponible) → SALIDA`

El campo `T` registra únicamente el estado observable del runtime cuando exista:
- `T: ✓` = Thinking fue observado/atestado y la salida canónica está establecida.
- `T: ?` = el estado del runtime no pudo determinarse.
- `T: !` = la integración reportó explícitamente un modo no permitido.

`T: ?` y `T: !` no son causas autónomas de bloqueo. Un bloqueo requiere una condición de contexto operativo materialmente requerida por el ciclo.

El MCP de KHORA conserva el mismo carácter adaptativo:
- `K: ✓` = acceso autenticado y secuencia normativa/liberación verificadas.
- `K: OFF` = MCP no accesible o no disponible; la salida continúa sin atribuir verificación externa.
- `K: ?` = estado no determinable.
- `K: !` = acceso intentado y fallido o verificación rechazada.

`K: OFF`, `K: ?` y `K: !` tampoco son causas autónomas de bloqueo. Este anexo no puede reintroducir una precondición dura que contradiga `SI-METACOGNITIVO.md` v1.6.9 o `ANEXO-GATE-THINKING-CHATGPT.md`.

`E: COMPLETADO` se determina por la producción efectiva del resultado solicitado; la verificación externa se declara por separado mediante `K`. Cuando el ciclo esté sustantivamente bloqueado por contexto operativo, se conserva la salida de bloqueo definida por el contrato vigente.
