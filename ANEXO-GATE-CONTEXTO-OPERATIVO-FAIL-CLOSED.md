# Anexo - Gate de Contexto Operativo Fail-Closed

**Estado:** CANONICO
**Fecha de canonizacion:** 2026-10-07
**Ambito:** Todos los proyectos y conversaciones sujetas a la metodologia comun.

## 1. Proposito

Este anexo define el mecanismo obligatorio para resolver, al inicio de cada ciclo, si el contexto operativo que puede condicionar la ejecucion esta suficientemente determinado.

El objetivo no es garantizar que una herramienta, red o plataforma nunca falle. El objetivo es mantener la identidad de una sesión global estable entre conversaciones, separar esa identidad de la conectividad observable y evitar que un fallo de deteccion se convierta silenciosamente en un supuesto de finalizacion.

## 2. Regla de entrada

Antes de trabajo sustantivo dependiente del entorno, cada ciclo debe:

1. consumir el estado global de RDC;
2. intentar deteccion automatica;
3. determinar ACTIVA, INACTIVA o INDETERMINADA;
4. resolver la ubicacion actual y su perfil;
5. determinar la identidad efectiva cuando sea relevante para la operación y comprobar su compatibilidad;
6. continuar solo con un estado de gate permitido.

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

Cuando exista una sesion registrada como activa y no exista una marca de `FINALIZADA` o `SUSTITUIDA`:

- heredar cuenta y device_id;
- conservar la identidad de la sesión aunque la conversación sea nueva;
- ejecutar ping al dispositivo conocido cuando el ciclo requiera conectividad RDC en vivo;
- si responde, marcar `VERIFICADO-ACTIVO` y actualizar la marca de conexión;
- si no responde, conservar la sesión y marcar la conectividad como no verificada; no convertir el fallo en finalización de sesión.

No se deben realizar llamadas de descubrimiento de mayor costo solo para reconstruir una identidad que ya está persistida.

### 4.2 Escalamiento

Si el ping falla:

- descubrir dispositivos disponibles solo si es necesario para determinar un cambio o recuperar la conectividad;
- comprobar la cuenta RDC autenticada;
- determinar si la sesion cambio, fue finalizada o el registro quedo obsoleto;
- si aparece una nueva sesion verificable, sustituir el estado global;
- si el dispositivo registrado aparece offline pero no existe evidencia positiva de finalizacion o sustitucion, conservar la identidad persistente y marcar la conectividad como NO VERIFICADA;
- si existe evidencia positiva de ausencia o finalizacion, registrar INACTIVA.

El fallo de conectividad por si solo no invalida la sesión persistente.

### 4.3 Ausencia positiva

Una sesión persistente solo pasa a `VERIFICADO-INACTIVO` cuando existe evidencia fiable de finalización/sustitución o una fuente capaz de establecer inequívocamente que ya no existe la sesión registrada.

La ausencia de respuesta, el dispositivo offline o la indisponibilidad de la herramienta no son evidencia suficiente de finalización y no eliminan la identidad persistente.

## 4.4 Regla de herencia en conversación nueva

Si `ESTADO-RDC-ACTIVO.md` es legible y contiene una sesión persistente `ACTIVA` sin `FINALIZADA` ni `SUSTITUIDA`, la conversación nueva debe heredar esa identidad antes de formular cualquier pregunta de control. No se puede convertir `device offline`, `ping fallido` o `herramienta indisponible` en una pregunta sobre si la sesión existe.

La pregunta al usuario solo es válida cuando, después de consumir el estado global y las fuentes disponibles, la existencia de la sesión permanece materialmente indeterminada. Cuando la sesión sí está determinada pero la conectividad está caída, la decisión es operacional: si la tarea requiere RDC en vivo, el ciclo queda bloqueado por conectividad; si no lo requiere, puede continuar sin RDC.

## 5. Fallo de deteccion y decision del usuario

Cuando no sea posible determinar si existe una sesion RDC activa, el sistema formula una sola pregunta de control:

¿Esta conversacion requiere que exista una sesion RDC activa?

### Si responde SI

El ciclo pasa a BLOQUEADO cuando no existe una sesión persistente verificable o cuando la operación requiere conectividad RDC en vivo y esta no puede establecerse.

Si ya existe una sesión persistida en `ESTADO-RDC-ACTIVO.md`, no se solicita al usuario que vuelva a identificarla: se conserva como sesión global y se solicita únicamente la evidencia necesaria para recuperar o verificar la conectividad.

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

Contrato de continuidad:

    CONVERSACION A
       |
       v
    ESTADO-RDC-ACTIVO.md
       |
       +--> identidad persistente de sesión
       |
       +--> conectividad observable separada
       |
       v
    CONVERSACION B
       |
       v
    heredar identidad + verificar conectividad cuando corresponda
       |
       v
    estado vigente del ciclo

Una nueva sesion verificada sustituye a la anterior. Una finalización explícita sustituye `ACTIVA` por `INACTIVA`. Ninguna de las dos acciones ocurre por el mero cambio de conversación o por una desconexión temporal.

Una conversación nunca debe pedir al usuario que vuelva a declarar una sesión ya persistida: debe heredarla. La verificación de conectividad se realiza solamente cuando la operación del ciclo necesite RDC en vivo. `RDC-REQUERIDA-POR-CICLO` se determina por la tarea y es independiente de `RDC-SESION`.

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
