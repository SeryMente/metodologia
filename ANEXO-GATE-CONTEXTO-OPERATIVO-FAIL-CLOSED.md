# Anexo - Gate de Contexto Operativo Fail-Closed

**Estado:** CANONICO
**Fecha de canonizacion:** 2026-10-07
**Ambito:** Todos los proyectos y conversaciones sujetas a la metodologia comun.

## 1. Proposito

Este anexo define el mecanismo obligatorio para resolver, al inicio de cada ciclo, si el contexto operativo que puede condicionar la ejecucion esta suficientemente determinado.

El objetivo no es garantizar que una herramienta, red o plataforma nunca falle. El objetivo es que ningun fallo de deteccion pueda convertirse silenciosamente en un supuesto: cuando la evidencia requerida no exista, el ciclo queda bloqueado hasta resolver la indeterminacion.

## 2. Regla de entrada

Antes de trabajo sustantivo dependiente del entorno, cada ciclo debe:

1. consumir el estado global de RDC;
2. intentar deteccion automatica;
3. determinar ACTIVA, INACTIVA o INDETERMINADA;
4. resolver la ubicacion actual y su perfil;
5. verificar la identidad Windows operativa exigida por el perfil;
6. continuar solo con un estado de gate permitido.

No se permite continuar desde un estado de deteccion fallida.

## 3. Fuente global

La fuente global de la sesion RDC es ESTADO-RDC-ACTIVO.md.

Ese registro no pertenece a una conversacion. Una conversacion nueva consume el estado mas reciente y realiza su propia verificacion ciclo a ciclo.

El registro debe contener como minimo:

- ubicacion;
- RDC-REQUERIDA;
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

Cuando exista una sesion registrada como activa:

- reutilizar cuenta y device_id;
- ejecutar ping al dispositivo conocido;
- si responde, marcar VERIFICADO-ACTIVO;
- actualizar la marca de verificacion;
- conservar el ultimo consumo mensual verificado.

No se deben realizar llamadas de descubrimiento de mayor costo solo para confirmar una sesion que ya responde por ping.

### 4.2 Escalamiento

Si el ping falla:

- descubrir dispositivos disponibles;
- comprobar la cuenta RDC autenticada;
- determinar si la sesion cambio, se volvio inactiva o el registro quedo obsoleto;
- si aparece una nueva sesion verificable, sustituir el estado global;
- si no puede determinarse el estado, marcar INDETERMINADA.

### 4.3 Ausencia positiva

Una respuesta fiable que establezca que no existe una sesion RDC activa se registra como VERIFICADO-INACTIVO.

La ausencia de respuesta no es evidencia de ausencia.

## 5. Fallo de deteccion y decision del usuario

Cuando no sea posible determinar si existe una sesion RDC activa, el sistema formula una sola pregunta de control:

¿Esta conversacion requiere que exista una sesion RDC activa?

### Si responde SI

El ciclo pasa a BLOQUEADO.

Se solicita la evidencia minima para establecer la sesion, preferentemente el bloque final de conexion RDC que permita identificar cuenta y dispositivo.

La sesion no se considera establecida hasta que el sistema la verifique mediante la fuente RDC.

### Si responde NO

El ciclo pasa a NO-REQUERIDO.

Se registra explicitamente que RDC no es precondicion del ciclo. Solo pueden ejecutarse operaciones que no dependan de RDC.

## 6. Fallos que siempre bloquean

El estado BLOQUEADO es obligatorio cuando:

- el estado global no puede leerse;
- la deteccion automatica no puede establecer activo/inactivo y el usuario aun no ha resuelto si RDC es requisito;
- RDC es requerido pero no hay sesion verificada;
- la ubicacion no puede determinarse y la tarea depende de su perfil;
- el perfil de ubicacion no existe o es insuficiente;
- la identidad Windows operativa esperada no coincide con la identidad real y no existe un puente verificado;
- existe una discrepancia material entre cuenta RDC, dispositivo, ubicacion o identidad de ejecucion.

Bloqueado significa: no ejecutar, no declarar exito, no sustituir datos por inferencia.

## 7. Resolucion del perfil de ubicacion

Una vez verificada la ubicacion, el sistema carga el perfil canonico correspondiente.

Para CECEQ:

- UBICACION = CECEQ;
- WIN-OPERATIVO = fila4;
- WIN-ADMIN = central\mantenimientorci.

Para OFFICE-DEPOT y CIBERCAFE, mientras no exista perfil operativo suficiente, las propiedades no definidas permanecen PENDIENTES y no se inventan.

## 8. Resolución rápida de identidad Windows por canal operativo conocido

### 8.1 Objetivo

Resolver la diferencia entre la identidad administrativa que sostiene el canal RDC y la identidad operativa requerida, sin instalar un puente permanente, sin almacenar credenciales y sin cerrar sesión.

### 8.2 Camino corto conocido

En CECEQ, el camino conocido y ya probado es la tarea interactiva `\\DesktopCommander-Remote-fila4`, configurada para ejecutar `C:\\WINDOWS\\system32\\cmd.exe /d /c "C:\\Program Files\\nodejs\\desktop-commander.cmd" remote` con `fila4`.

Cuando el canal actual aparece bajo `central\\mantenimientorci`, el modelo debe tratarlo como una discrepancia de identidad, activar o reutilizar ese canal operativo conocido y verificar la identidad efectiva antes de continuar.

### 8.3 Secuencia

1. detectar la identidad real del canal actual;
2. comparar contra `WIN-OPERATIVO` del perfil;
3. si hay discrepancia, reutilizar o activar `\\DesktopCommander-Remote-fila4`;
4. verificar `whoami`, perfil del usuario y ruta de trabajo;
5. continuar solo si la identidad efectiva es `fila4`.

### 8.4 Qué no hacer

No usar como mecanismo ordinario:

- `runas` con contraseña;
- almacenar credenciales de `fila4`;
- cerrar y volver a iniciar sesión;
- instalar un servicio o ejecutable de puente permanente;
- ejecutar el trabajo de proyecto bajo la identidad administrativa.

### 8.5 Elevación

Cuando una operación requiera privilegios administrativos reales, la elevación debe ser puntual y explícita. El trabajo ordinario se mantiene bajo la identidad operativa.

El canal operativo conocido es un procedimiento de resolución, no un componente residente adicional.

## 9. Maquina de estados

    CICLO
      |
      v
    LEER ESTADO GLOBAL
      |
      v
    DETECTAR RDC
      |
      +--> ACTIVA ----> VERIFICAR ----> RESOLVER PERFIL ----> VERIFICAR IDENTIDAD ----> APTO
      |
      +--> INACTIVA --> ¿RDC REQUERIDA?
      |                    |
      |                    +--> NO ----> NO-REQUERIDO ----> APTO SIN RDC
      |                    |
      |                    +--> SI ----> BLOQUEADO
      |
      +--> INDETERMINADA --> PREGUNTAR USUARIO
                           |
                           +--> NO ----> NO-REQUERIDO
                           |
                           +--> SI ----> BLOQUEADO
                                        |
                                        v
                                ESTABLECER SESION
                                        |
                                        v
                                    VERIFICAR
                                        |
                                        v
                                       APTO

## 10. Propagacion entre conversaciones

La propagacion funciona por estado compartido, no por memoria de una conversacion.

Contrato:

    CONVERSACION A
       |
       v
    ESTADO-RDC-ACTIVO.md
       |
       v
    CONVERSACION B
       |
       v
    verificacion minima
       |
       v
    estado vigente del ciclo

Una nueva sesion verificada sustituye a la anterior.

Una conversacion nunca puede declarar por si sola que su sesion local continua siendo la globalmente activa sin consultar el estado compartido y pasar el gate.

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

## 13. Criterio de completitud del mecanismo

El mecanismo se considera implementado cuando:

1. el estado global es consultable desde cualquier conversacion sujeta al canon;
2. el ciclo intenta automaticamente la deteccion;
3. el fast path usa ping sobre la sesion conocida;
4. el escalamiento resuelve cambios o inactividad;
5. una deteccion fallida abre la decision unica de requisito RDC;
6. la respuesta SI bloquea hasta establecer y verificar la sesion;
7. la respuesta NO permite solo trabajo sin dependencia RDC;
8. el perfil de ubicacion se carga antes de operaciones condicionadas;
9. la identidad Windows operativa se valida antes de trabajar;
10. una discrepancia bloquea;
11. la salida registra el resultado del gate invariablemente;
12. el estado global se actualiza cuando cambia la sesion.

## 14. Dependencias canonicas

- SI-METACOGNITIVO.md
- METODOLOGIA.md
- LINEAMIENTOS.md
- ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md
- ESTADO-RDC-ACTIVO.md
- GLOSARIO-OPERATIVO.md

Este anexo desarrolla P032; no sustituye ni redefine los principios fundamentales.
