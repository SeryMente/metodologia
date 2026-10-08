# Procedimiento Canónico de Reinstanciación RDC

**Estado:** CANÓNICO  
**Versión:** v1.3.0  
**Fecha:** 2026-10-08  
**Ámbito:** Recuperación de una terminal RDC concreta cuando exista divergencia entre el registro persistente y la observabilidad viva del proveedor.

## 1. Activación

Se activa cuando una terminal concreta requerida por el ciclo no aparece ONLINE en el descubrimiento vivo, pero el usuario aporta evidencia positiva de que intenta utilizar esa terminal.

No se activa por el mero hecho de que otra terminal aparezca ONLINE. Tampoco se interpreta la ausencia de una identidad histórica como finalización global.

## 2. Comando canónico

**RDC-REINSTANTIAR**

Es un comando conversacional de recuperación. No es un comando de shell y no debe sustituirse por una sintaxis inventada.

## 2.1 Comando oficial del proveedor

La orden recomendada por Desktop Commander para iniciar el Remote Device es:

`npx @wonderwhy-er/desktop-commander@latest remote`

No se sustituye esta orden por heurísticas de búsqueda de ejecutables ni por comandos inventados. El procedimiento reconecta o crea la identidad de la terminal que efectivamente resulte observable; no selecciona ni sustituye automáticamente otra terminal.

## 2.2 Activación proactiva

Este procedimiento debe ofrecerse en el mismo ciclo siempre que el modelo comunique al usuario que RDC está ausente, inactiva, desconectada, no verificable o no disponible. Si RDC no es requisito del ciclo, se ofrece como recuperación opcional; si es requisito, la ejecución dependiente queda bloqueada hasta verificar el handshake.

## 3. Acción del usuario

Al recibir RDC-REINSTANTIAR:

1. cerrar la instancia RDC que el usuario esté intentando recuperar, cuando corresponda;
2. iniciar/reinstanciar el Remote Device;
3. esperar a que el proveedor reporte el nuevo estado;
4. devolver al modelo el bloque RDC-HANDSHAKE de la identidad que efectivamente quedó conectada.

El cierre de la terminal observada es una medida de saneamiento del canal para evitar que una instancia antigua quede mezclada con la nueva.

## 4. RDC-HANDSHAKE mínimo

El usuario debe entregar, en la medida en que la plataforma los proporcione:

    RDC-HANDSHAKE
    RDC-CUENTA: ...
    RDC-DISPOSITIVO: ...
    RDC-DEVICE-ID: ...
    RDC-CONECTIVIDAD: ...
    RDC-PING: ...
    RDC-USO-MENSUAL: ...
    UBICACION: ...
    WIN-OPERATIVO: ...
    WIN-EFECTIVO-RDC: ...
    VERIFICADO-EN: ...

Los campos que la herramienta no proporcione se marcan NO DISPONIBLE; no se inventan. Como mínimo para registrar o refrescar una identidad deben quedar determinados cuenta, dispositivo, device_id y evidencia suficiente de conectividad. Una restauración del mismo device_id refresca esa identidad. Un device_id diferente se registra como identidad distinta; no sustituye automáticamente otra terminal.

## 5. Validación

El modelo:

1. identifica la terminal por cuenta + device_id;
2. verifica evidencia positiva de conexión;
3. comprueba compatibilidad con el perfil de ubicación del ciclo;
4. determina si la identidad ya era conocida o es nueva;
5. conserva procedencia y marca temporal;
6. solo después actualiza el registro persistente cuando corresponda.

Una sustitución o refresco no validado no cuenta como recuperación. Si la escritura de `ESTADO-RDC-ACTIVO.md` falla, la recuperación permanece pendiente y no se permite declarar resuelta la conectividad ni reanudar trabajo RDC-dependiente.

## 5.1 Publicación transaccional

La validación del handshake no completa por sí sola la recuperación. La recuperación requiere la publicación condicionada del estado y su lectura de vuelta:

`VALIDAR → PUBLICAR CON SHA → READ-BACK → RESUELTA`

La escritura debe identificar la versión/sha del recurso que se leyó. Si esa versión cambió, se rechaza el intento, se vuelve a leer el estado actual y se reconcilia.

No se permite force-push, sobrescritura ciega ni modificación de una copia local como sustituto de la fuente global.

## 6. Actualización global

Una vez validado el handshake, `ESTADO-RDC-ACTIVO.md` puede actualizarse con:

- cuenta;
- dispositivo;
- device_id;
- última conectividad verificada;
- última verificación;
- metadatos del ciclo y, cuando corresponda, ubicación declarada como dato del evento.

La actualización no crea una selección global y no sustituye otra identidad distinta.

Cuando exista publicación, debe ejecutarse read-back y comprobar que la identidad y marca temporal publicadas coinciden con el handshake.

## 7. Propagación

La siguiente conversación lee el registro persistente para reconocer la identidad recuperada, pero vuelve a consultar el proveedor en vivo antes de seleccionar una terminal. La recuperación de una terminal no convierte esa terminal en selector global.

## 8. Estados

RDC-RECUPERACION = REQUERIDA → se necesita RDC-REINSTANTIAR para una terminal concreta.  
RDC-RECUPERACION = EN ESPERA HANDSHAKE → el usuario debe entregar los datos de la identidad efectivamente conectada.  
RDC-RECUPERACION = RESUELTA → la identidad concreta fue validada y, si correspondía, persistida.

## 9. Prohibiciones

No borrar la sesión persistente antes de validar la nueva.  
No declarar INACTIVA por un simple OFFLINE.  
No mezclar terminales antiguas y nuevas.  
No inventar comandos de shell para sustituir el procedimiento.  
No reanudar trabajo RDC-dependiente antes de actualizar el estado global.
