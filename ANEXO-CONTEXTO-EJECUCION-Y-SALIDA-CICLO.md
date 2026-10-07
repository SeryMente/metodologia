# Anexo - Contexto de Ejecucion y Formato de Salida por Ciclo

**Estado:** CANONICO
**Fecha de canonizacion:** 2026-10-07
**Ambito:** Todos los proyectos y conversaciones sujetos a la metodologia comun.

## 1. Proposito

Este anexo define el contexto operativo minimo que acompana cada ciclo y las reglas para identificar el entorno desde el que se ejecuta el trabajo.

Ubicacion, cuentas, dispositivos, usuarios concretos, porcentajes de uso y formatos son datos y mecanismos operativos; permanecen en este nivel y no se elevan a principio fundamental salvo que una revision posterior determine una necesidad normativa irreductible.

## 2. Identidad de ejecucion

Cada ciclo distingue:
- Ubicacion: lugar fisico de trabajo.
- RDC: canal y cuenta de Remote Desktop Commander que proporcionan acceso al entorno remoto.
- Usuario Windows operativo: identidad bajo la que se ejecutan las operaciones de trabajo.
- Usuario Windows administrativo/elevado: identidad destinada a elevacion o establecimiento del puente operativo; no es la identidad de trabajo ordinario.

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
| Regla | El trabajo se ejecuta como fila4; mantenimientorci se limita al puente o elevacion administrativa. |

### 4.2 Office Depot

Perfil operativo detallado: PENDIENTE DE PERFILADO.

### 4.3 Cibercafe

Perfil operativo detallado: PENDIENTE DE PERFILADO.

No se inventan identidades Windows para perfiles pendientes.

## 5. Estado de RDC

Cada ciclo debe identificar:
- PLATAFORMA: ChatGPT.
- RDC-SESION: ACTIVA, INACTIVA o NO VERIFICADA.
- RDC-ESTADO: estado del dispositivo/canal cuando este disponible.
- RDC-CUENTA: correo de la cuenta RDC efectivamente utilizada, o NO VERIFICADO.
- RDC-USO-MENSUAL: porcentaje usado y porcentaje restante, o NO DISPONIBLE.
- RDC-TERMINAL: estado o numero de sesiones terminales cuando este disponible.

Si la API proporciona remote_calls_left_pct, se calcula:

uso_pct = 100 - remote_calls_left_pct

No se infieren plan, limite bruto, fecha de restablecimiento ni otros datos no proporcionados por la API.

RDC-USO-MENSUAL es obligatorio en la salida de cada ciclo, pero no obliga a consumir una llamada RDC solo para producirlo. Se reutiliza el ultimo dato verificado disponible y se conserva su marca temporal.

## 6. Separacion operativo-administrativa

1. Las operaciones de trabajo sobre archivos, instalaciones, configuraciones y demas estado operativo se ejecutan bajo el usuario Windows operativo del perfil vigente.
2. La identidad administrativa/elevada no se utiliza directamente para esas operaciones.
3. La identidad elevada puede actuar como puente tecnico para iniciar un proceso que opere bajo la identidad operativa autorizada.
4. Si el canal RDC ejecuta directamente bajo la identidad elevada y no existe un puente operativo verificado, la operacion de trabajo se detiene; no se sustituye el usuario operativo por el administrativo.

## 7. Formato obligatorio de salida por ciclo

Cada ciclo debe mostrar invariablemente:

PROYECTO / CONV-XX / CXXX

SI CARGADO · vX.Y.Z - NOMBRE DE VERSION · COMPLETO · ACTIVO · ULTIMO CAMBIO: ...

CONTEXTO · PLATAFORMA: ChatGPT · UBICACION: ... · RDC-SESION: ... · RDC-CUENTA: ... · RDC-MENSUAL: ... · WIN-OPERATIVO: ...

NOTAS · SIN NOTAS | NOTAS PENDIENTES

Cuando exista distincion administrativa relevante, se anade WIN-ADMIN: ...

Cuando este disponible, se anade RDC-TERMINAL: ...

La ausencia de un dato se representa como NO VERIFICADO, NO DISPONIBLE o PENDIENTE. Nunca se inventa.

La foliacion global del ciclo y la identificacion canonica del SI conservan sus reglas vigentes.

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

Conclusion: CECEQ esta identificado y el perfil operativo esta establecido como fila4. La conexion RDC actualmente verificada permanece administrativamente elevada bajo mantenimientorci; por tanto, no se ejecutan operaciones de trabajo directamente bajo esa identidad hasta disponer de un puente verificado hacia fila4.


## 10. Registro global de la sesion RDC activa

La sesion RDC activa es estado operativo transversal y no pertenece a una conversacion particular. Su registro global se conserva en ESTADO-RDC-ACTIVO.md.

El registro contiene como minimo ubicacion, cuenta RDC, identidad de conexion, device_id, nombre de dispositivo, estado del canal, usuario Windows operativo esperado, identidad administrativa cuando exista, fecha de configuracion, ultima verificacion y consumo mensual disponible.

Una nueva sesion configurada sustituye la sesion activa anterior. No se mantienen varias sesiones como activas simultaneamente salvo canon posterior.

## 11. Verificacion minima por ciclo

Si existe una sesion registrada como activa, al inicio de cada ciclo se verifica por el metodo de menor costo disponible.

Metodo primario:
1. reutilizar cuenta y device_id registrados;
2. ejecutar ping sobre el dispositivo conocido;
3. si responde, mantener la sesion ACTIVA y actualizar la marca de verificacion;
4. si falla, escalar a descubrimiento de dispositivos y comprobacion de cuenta para determinar cambio, inactividad o necesidad de reconfiguracion.

No se ejecutan list_devices ni who_am_i exclusivamente en cada ciclo cuando el ping confirma la misma sesion.

El porcentaje mensual se reutiliza desde la ultima lectura validada y solo se actualiza cuando una llamada ya necesaria lo expone o cuando el usuario solicita comprobacion explicita.

La verificacion de sesion RDC y la verificacion de sesiones de terminal son estados distintos.

## 12. Propagacion entre conversaciones

El registro global de sesion activa es independiente de la conversacion contenedora. Cada nueva conversacion sujeta a la metodologia consume el estado global mas reciente y lo verifica por el mecanismo minimo definido.

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

La identidad administrativa no sustituye a la operativa. Cuando una operación requiera elevación, debe conservarse la separación entre el proceso de trabajo y el puente administrativo.

## 12.4 Condición de bloqueo

El ciclo se marca BLOQUEADO cuando ocurra cualquiera de estas condiciones:

- no puede leerse el estado global de RDC;
- la detección automática no puede establecer activo/inactivo y el usuario aún no ha resuelto si RDC es requisito;
- RDC es requerido pero no existe una sesión verificada;
- la ubicación es desconocida cuando la tarea depende de un perfil de ubicación;
- el perfil de la ubicación no existe o no es suficiente;
- la identidad Windows operativa requerida no puede verificarse.

Mientras el ciclo esté BLOQUEADO, no se ejecutan operaciones dependientes del contexto y no se declara cierre exitoso.

## 12.5 Puente rápido de identidad para CECEQ

La estrategia preferente es no cambiar de usuario de Windows ni almacenar credenciales. El proceso administrativo de RDC conserva su función de puente y, cuando ya existe una sesión interactiva de fila4, crea el proceso operativo mediante el token de esa sesión.

Orden de preferencia:

1. reutilizar el token interactivo ya existente de fila4;
2. verificar el usuario efectivo y el perfil (whoami, perfil de usuario y ruta de trabajo);
3. lanzar el proceso ordinario bajo fila4;
4. utilizar central\\mantenimientorci únicamente para elevación/puente cuando sea indispensable.

runas con credenciales, cierre de sesión, reautenticación y ejecución ordinaria como administrador no son el camino rápido ni el camino canónico.

El mecanismo concreto de duplicación/creación del proceso pertenece a la implementación y se documenta en ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md.

## 13. Referencia terminológica

La ubicación y los identificadores de entorno deben utilizar las formas del glosario canónico. Para la ubicación actual, la forma canónica es `CECEQ`. Las formas reconocibles como errores de transcripción no deben propagarse a la salida.
