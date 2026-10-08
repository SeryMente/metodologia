# Anexo - Gate de Contexto Operativo Fail-Closed

**Estado:** CANONICO
**Fecha de canonizacion:** 2026-10-07
**Ambito:** Todos los proyectos y conversaciones sujetas a la metodologia comun.

## 1. Proposito

Este anexo define el mecanismo obligatorio para resolver, al inicio de cada ciclo, si el contexto operativo que puede condicionar la ejecucion esta suficientemente determinado.

El objetivo no es garantizar que una herramienta, red o plataforma nunca falle. El objetivo es mantener identidades RDC individuales entre conversaciones, separar registro persistente de conectividad observable y evitar que un registro histórico se convierta silenciosamente en la terminal actual.

## 2. Regla de entrada

Antes de trabajo sustantivo dependiente del entorno, y en todo caso antes de intentar la certificación de KHORA, cada ciclo debe:

1. consumir el registro persistente de RDC desde `ESTADO-RDC-ACTIVO.md`;
2. descubrir en vivo los dispositivos ONLINE en todas las cuentas RDC accesibles al runtime cuando RDC sea relevante;
3. reconciliar cada identidad observada por `RDC-CUENTA + RDC-DEVICE-ID` con el registro;
4. resolver la terminal concreta del ciclo, si la tarea requiere RDC;
5. resolver la ubicacion actual y su perfil;
6. determinar la identidad efectiva cuando sea relevante para la operación y comprobar su compatibilidad;
7. continuar solo con un estado de gate permitido.

No se permite continuar desde un estado de deteccion fallida.

### Bloqueo de ejecución, conversación abierta

Cuando el gate produzca BLOQUEADO, el bloqueo se aplica exclusivamente a la ejecución sustantiva y al cierre exitoso del ciclo. La conversación permanece abierta para que el modelo pueda explicar el motivo, solicitar la información mínima, recibir la decisión del usuario y volver a verificar el contexto.

La salida inicial del bloqueo debe utilizar el formato visual canónico definido en FORMATO-REGISTRO-VERIFICACION-CICLO.md. No se debe presentar el bloqueo como cierre de la conversación ni como indisponibilidad del modelo.


## 2.1 Regla anti-regresión normativa

Este gate no puede ser utilizado para reintroducir bloqueos que el SI vigente haya retirado. En particular, `THINKING` no observable, `INSTANT`, `UNKNOWN`, `UNAVAILABLE`, `K: OFF`, `K: ?` y `K: !` no son causas autónomas de BLOQUEADO. Si una instancia dispone de una copia anterior del SI que los trate como bloqueo, esa copia es histórica y debe refrescarse antes de continuar.

## 3. Fuente global

La fuente global de la sesion RDC es ESTADO-RDC-ACTIVO.md.

Ese registro no pertenece a una conversacion. Una conversacion nueva consume el estado mas reciente y realiza su propia verificacion ciclo a ciclo.

El registro debe contener como minimo:

- identidad persistente de la sesión;
- estado independiente de conectividad;
- condición de finalización o sustitución explícita;
- ubicacion;
- RDC-REQUERIDA-POR-CICLO;
- RDC-SESION;
- RDC-CUENTA;
- RDC-DISPOSITIVO;
- RDC-DEVICE-ID;
- ultima verificacion;
- estado de canal;
- usuario Windows operativo esperado;
- usuario Windows administrativo;
- perfil de ubicacion;
- estado del gate.

## 4. Deteccion automatica

### 4.1 Fast path

El fast path ya no hereda una terminal como dispositivo actual.

Cuando RDC sea relevante:
- descubrir los dispositivos ONLINE mediante `list_devices` en vivo en todas las cuentas RDC accesibles;
- identificar cada dispositivo por `RDC-CUENTA + RDC-DEVICE-ID`;
- usar `ESTADO-RDC-ACTIVO.md` únicamente para reconciliar nombre, historial y metadatos;
- hacer `ping` al dispositivo seleccionado cuando el ciclo requiera conectividad de ejecución;
- actualizar el registro persistente solo cuando exista una identidad nueva o un cambio verificable de ciclo de vida.

Un dispositivo persistido como activo pero ausente del descubrimiento vivo no se considera la terminal actual por herencia.

### 4.2 Escalamiento

Si el dispositivo seleccionado no responde:
- volver a consultar el conjunto ONLINE por cuenta;
- comprobar si el mismo `RDC-DEVICE-ID` reaparece bajo su cuenta;
- comprobar si existe otra identidad ONLINE que pueda corresponder a una terminal distinta;
- no sustituir automáticamente la terminal objetivo por esa identidad distinta;
- si la tarea requiere la terminal seleccionada y sigue sin observarse, activar el procedimiento de recuperación correspondiente.

El fallo de conectividad de una identidad no invalida ni elimina otras identidades RDC concurrentes.

### 4.3 Ausencia positiva

Una sesión persistente solo pasa a `VERIFICADO-INACTIVO` cuando existe evidencia fiable de finalización/sustitución o una fuente capaz de establecer inequívocamente que ya no existe la sesión registrada.

La ausencia de respuesta, el dispositivo offline o la indisponibilidad de la herramienta no son evidencia suficiente de finalización y no eliminan la identidad persistente.

## 4.4 Regla de conversación nueva

Una conversación nueva no hereda una terminal seleccionada por otra conversación.

Debe:
1. leer el registro persistente;
2. ejecutar descubrimiento vivo en las cuentas RDC accesibles;
3. reconciliar las identidades observadas;
4. seleccionar la terminal concreta del ciclo.

Si hay una sola identidad ONLINE, se selecciona automáticamente. Si hay varias, se usa una vinculación ya establecida en la conversación o se solicita la mínima selección necesaria. Si no hay ninguna ONLINE, se evalúa si RDC es requisito del ciclo.

La mera existencia de un registro `ACTIVA` no evita el descubrimiento vivo.

## 4.4.1 Divergencia de observabilidad RDC y recuperación

Se activa este protocolo cuando concurren las siguientes señales:

- `RDC-SESION = ACTIVA` en el estado global;
- la verificación RDC informa `OFFLINE OBSERVADA`, `NO VERIFICADA` o no puede usar el dispositivo conocido;
- el usuario aporta evidencia local positiva de actividad de la terminal o sesión RDC.

El modelo no debe resolver la contradicción por inferencia. Debe registrar:

`RDC-SESION = ACTIVA`
`RDC-CONECTIVIDAD = NO VERIFICADA/OFFLINE OBSERVADA`
`RDC-OBSERVABILIDAD = DIVERGENTE`
`RDC-RECUPERACION = REQUERIDA`

Si el ciclo requiere RDC en vivo, el estado es `BLOQUEADO` para ejecución sustantiva y la salida debe emitir inmediatamente:

`RDC-REINSTANTIAR`

El comando de recuperación instruye a cerrar la terminal/sesión RDC observada, iniciar una nueva sesión y devolver el `RDC-HANDSHAKE` definido por `ANEXO-PROCEDIMIENTO-REINSTANTIACION-RDC.md`.

La conversación permanece abierta. El modelo no solicita una nueva identidad por la mera divergencia, no marca la sesión anterior como finalizada y no ejecuta operaciones dependientes de RDC hasta verificar la nueva sesión.

Cuando el handshake llega, se valida primero y se actualiza después `ESTADO-RDC-ACTIVO.md`. La nueva sesión verificada sustituye la anterior y la marca de recuperación pasa a `RESUELTA`.

## 4.4.2 Recuperación proactiva ante reporte de ausencia

Siempre que el modelo vaya a comunicar al usuario que RDC no está activa, no está disponible, está desconectada, no está verificada o se perdió durante el ciclo, debe proporcionar en el mismo ciclo el comando canónico `RDC-REINSTANTIAR`.

El comando debe incluir la sintaxis oficial vigente del proveedor para iniciar el Remote Device:

`npx @wonderwhy-er/desktop-commander@latest remote`

Esta oferta es obligatoria aunque la tarea no requiera RDC y aunque el diagnóstico previo pueda resultar falso. Cuando RDC no sea requerida, el comando funciona como mecanismo de recuperación opcional y no crea por sí mismo un bloqueo.

Cuando RDC sea requerida para el ciclo, la falta de conectividad sí bloquea la ejecución sustantiva hasta que el usuario entregue un `RDC-HANDSHAKE` fresco y verificable.

## 4.4.3 Publicación transaccional del estado global

Toda recuperación o refresco de sesión RDC que modifique `ESTADO-RDC-ACTIVO.md` debe completar la transacción:

`LEER ESTADO → VALIDAR HANDSHAKE → ESCRIBIR CONDICIONADO POR SHA → LEER DE VUELTA → CONFIRMAR`

La escritura se rechaza si el SHA de la versión leída ya no es el actual. En ese caso se vuelve a leer, se reconcilia y se reintenta; no se usa `force` para ocultar una carrera.

El modelo no puede presentar `RDC-RECUPERACION = RESUELTA`, `RDC-CONECTIVIDAD = VERIFICADO-ACTIVO` ni continuar una operación dependiente de RDC hasta que el read-back confirme el estado publicado.

Si la publicación o el read-back no pueden completarse, el estado operativo queda pendiente y las operaciones RDC-dependientes quedan bloqueadas; la sesión persistente no se declara finalizada.

## 5. Fallo de detección y decisión del usuario

Cuando el descubrimiento vivo no permita determinar una terminal requerida, el sistema no utiliza un registro persistente como sustituto.

La pregunta de control se limita a determinar el requisito del ciclo:

¿Esta conversación requiere RDC en vivo?

### Si responde SI

El ciclo queda BLOQUEADO hasta que exista una terminal ONLINE verificable o se complete `RDC-REINSTANTIAR` para la terminal requerida.

### Si responde NO

El ciclo pasa a `NO-REQUERIDO` y solo puede ejecutar trabajo que no dependa de RDC.

Cuando hay varias terminales ONLINE, la selección de terminal es el único dato adicional que se solicita; no se pide al usuario reconstruir cuentas, ids o historial que el proveedor ya expone.

## 6. Fallos que siempre bloquean

El estado BLOQUEADO es obligatorio cuando:

- el estado global no puede leerse;
- la deteccion automatica no puede establecer activo/inactivo y el usuario aun no ha resuelto si RDC es requisito;
- RDC es requerido pero no hay sesion verificada;
- la ubicacion no puede determinarse y la tarea depende de su perfil;
- el perfil de ubicacion no existe o es insuficiente;
- existe una discrepancia material entre cuenta RDC, dispositivo, ubicacion o identidad de ejecucion.

Bloqueado significa: no ejecutar, no declarar exito, no sustituir datos por inferencia.

## 7. Resolucion del perfil de ubicacion

Una vez verificada la ubicacion, el sistema carga el perfil canonico correspondiente.

Para CECEQ:

- UBICACION = CECEQ;
- WIN-OPERATIVO = fila4;
- WIN-ADMIN = central\mantenimientorci.

Para OFFICE-DEPOT y CIBERCAFE, mientras no exista perfil operativo suficiente, las propiedades no definidas permanecen PENDIENTES y no se inventan.

## 8. Ejecución flexible y única restricción de materialización

### 8.1 Regla para CECEQ

- WIN-OPERATIVO = fila4.
- WIN-ADMIN = central\mantenimientorci.
- La sesión RDC utilizada para consumo y acceso remoto permanece bajo central\mantenimientorci.
- No se inicia un segundo canal RDC bajo fila4.
- central\mantenimientorci puede ejecutar cualquier trabajo técnicamente válido.
- La única restricción específica es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.

Cuando exista una divergencia de observabilidad RDC y el ciclo requiera conectividad en vivo, la recuperación mediante `RDC-REINSTANTIAR` es obligatoria antes de reanudar el trabajo dependiente del canal.

### 8.2 Secuencia

1. detectar la identidad efectiva cuando sea relevante;
2. resolver la ubicación y su perfil;
3. comprobar si la operación es técnicamente válida bajo la identidad efectiva;
4. si la operación es clonación o materialización inicial de repositorio, comprobar que el destino no esté dentro del perfil o ruta de MantenimientoRCI;
5. ejecutar y verificar el resultado.

La discrepancia entre fila4 y central\mantenimientorci no bloquea por sí misma.

### 8.3 Qué no hacer

No abrir sesiones RDC paralelas ni almacenar credenciales adicionales para resolver la diferencia de identidad. No clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.

### 8.4 Elevación

Las operaciones que requieran privilegios administrativos reales pueden utilizar la sesión RDC vigente bajo central\mantenimientorci.

## 9. Maquina de estados

    CICLO
      |
      v
    LEER REGISTRO PERSISTENTE
      |
      v
    DESCUBRIMIENTO EN VIVO POR CUENTA
      |
      +--> 0 ONLINE ----> ¿RDC REQUERIDA?
      |                         |
      |                         +--> NO ----> NO-REQUERIDO
      |                         |
      |                         +--> SI ----> BLOQUEADO → RDC-REINSTANTIAR
      |
      +--> 1 ONLINE ----> SELECCIONAR AUTOMATICAMENTE
      |
      +--> >1 ONLINE ---> VINCULACIÓN EXISTENTE
                              |
                              +--> sí ----> SELECCIONAR
                              |
                              +--> no ----> SELECCIÓN MÍNIMA DEL USUARIO
                                                   |
                                                   v
                                             VERIFICAR
                                                   |
                                                   v
                                            RESOLVER PERFIL
                                                   |
                                                   v
                                                  APTO

## 10. Propagacion entre conversaciones

La propagación funciona por estado persistente + descubrimiento vivo, no por memoria de una conversación ni por herencia ciega de una terminal.

Contrato de continuidad:

    CONVERSACION A
       |
       v
    REGISTRO RDC PERSISTENTE
       |
       +--> identidades conocidas / historial
       |
       v
    CONVERSACION B
       |
       v
    DESCUBRIMIENTO RDC EN VIVO
       |
       v
    SELECCIÓN LOCAL DE TERMINAL
       |
       v
    estado del ciclo

El registro permite reconstruir identidades conocidas. El descubrimiento vivo decide presencia actual. Una nueva conversación puede seleccionar una terminal diferente de la usada por otra conversación.

Múltiples identidades ONLINE simultáneas no constituyen conflicto. Solo una contradicción dentro de la misma identidad cuenta + device_id requiere reconciliación.

## 10.1 Evidencia de propagacion

El ciclo debe conservar internamente el origen de la identidad RDC como `GLOBAL_STATE` y la marca temporal de lectura/verificación. En la salida cotidiana esto no se expone como etiqueta adicional: queda representado de forma compacta por el estado RDC vigente.

## 11. Contrato minimo de salida

Cada ciclo debe declarar:

CONTEXTO | PLATAFORMA | UBICACION | RDC-REQUERIDA | RDC-SESION | RDC-CUENTA | RDC-MENSUAL | WIN-OPERATIVO | CONTEXTO-VERIFICACION

Y, cuando corresponda:

WIN-ADMIN | RDC-TERMINAL | RDC-DISPOSITIVO | RDC-DEVICE-ID | ULTIMA-VERIFICACION

Los estados permitidos de CONTEXTO-VERIFICACION son:

- VERIFICADO-ACTIVO;
- VERIFICADO-INACTIVO;
- NO-REQUERIDO;
- BLOQUEADO.

NO-VERIFICADO, INDETERMINADO, FUENTE-NO-DISPONIBLE o equivalentes nunca constituyen estados de paso.

## 12. Limitacion tecnica y regla de seguridad

Una interfaz nativa de ChatGPT no puede convertir por si sola una herramienta externa en una llamada tecnicamente inevitable si la plataforma no ofrece un gate de ejecucion obligatorio.

Por ello, la metodologia adopta la garantia disponible mas fuerte:

si la verificacion automatica no puede ejecutarse o no produce evidencia suficiente, la ejecucion sustantiva queda bloqueada.

La imposibilidad de invocar la herramienta no se transforma en falso exito ni en una suposicion de continuidad.

## 12.1 Health-check MCP obligatorio para ciclos normativos
Antes de la apertura normativa del turno, el cliente sujeto al canon debe comprobar el acceso al único MCP canónico de KHORA mediante `khora_mcp_health`.

El health-check detecta explícitamente:
- autenticación válida;
- scopes requeridos;
- lectura del SI canónico;
- contrato de MCP único y versión del verificador.

Resultado:
- `K: ✓` = acceso completo comprobado.
- `K: ?` = no comprobado.
- `K: !` = acceso insuficiente o no disponible.

`K: ✓` es una condición de infraestructura/acceso, no un veredicto normativo.
## 13. Criterio de completitud del mecanismo

El mecanismo se considera implementado cuando:

1. el registro persistente es consultable desde cualquier conversación sujeta al canon;
2. el ciclo ejecuta descubrimiento vivo en todas las cuentas RDC accesibles cuando RDC es relevante;
3. cada dispositivo se identifica por cuenta + device_id;
4. la selección de terminal es local al ciclo y no se hereda ciegamente;
5. múltiples terminales ONLINE pueden coexistir sin conflicto;
6. una terminal ausente del descubrimiento vivo no se convierte en INACTIVA global por inferencia;
7. `RDC-REINSTANTIAR` se activa solo cuando una terminal requerida no es observable y debe recuperarse;
8. los cambios persistentes se publican transaccionalmente y con read-back;
9. el perfil de ubicación se carga después de resolver la terminal;
10. la salida registra el resultado del gate;
11. una conversación nueva puede resolver el conjunto ONLINE actual sin depender de otra conversación.

## 14. Dependencias canonicas

- SI-METACOGNITIVO.md
- METODOLOGIA.md
- LINEAMIENTOS.md
- ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md
- ESTADO-RDC-ACTIVO.md
- GLOSARIO-OPERATIVO.md

Este anexo desarrolla P032; no sustituye ni redefine los principios fundamentales.


## 15. Memoria persistente de desempeno por terminal

Para CIBERCAFE, resolver el gate de RDC no implica repetir la auditoria de desempeno ya realizada. Una vez identificada la terminal del ciclo, el proceso debe consultar `CIBERCAFE/PC-N/ESTADO.md` y el log de eventos recientes antes de ejecutar diagnosticos profundos.

La memoria persistente es por `PC-N`; una nueva identidad RDC puede observar la misma PC sin crear una nueva computadora. La telemetria de alta frecuencia puede mantenerse local y las llamadas RDC deben reservarse para evidencia o acciones nuevas, verificacion de transiciones y sincronizacion requerida.
