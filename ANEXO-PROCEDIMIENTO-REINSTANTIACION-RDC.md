# Procedimiento Canónico de Reinstanciación RDC

**Estado:** CANÓNICO  
**Versión:** v1.2.0  
**Fecha:** 2026-10-07  
**Ámbito:** Recuperación de sesiones RDC cuando exista divergencia entre el estado persistente y la observabilidad del canal.

## 1. Activación

Se activa cuando la sesión global figura ACTIVA, pero el canal RDC aparece OFFLINE, NO VERIFICADO o inaccesible, y el usuario informa evidencia local positiva de actividad de una terminal o sesión RDC.

No se interpreta la divergencia como prueba de finalización.

## 2. Comando canónico

**RDC-REINSTANTIAR**

Es un comando conversacional de recuperación. No es un comando de shell y no debe sustituirse por una sintaxis inventada.

## 2.1 Comando oficial del proveedor

La orden recomendada por Desktop Commander para iniciar el Remote Device es:

`npx @wonderwhy-er/desktop-commander@latest remote`

No se sustituye esta orden por heurísticas de búsqueda de ejecutables ni por comandos inventados. El reinicio normal reutiliza la sesión persistida del dispositivo cuando sigue vigente.

## 2.2 Activación proactiva

Este procedimiento debe ofrecerse en el mismo ciclo siempre que el modelo comunique al usuario que RDC está ausente, inactiva, desconectada, no verificable o no disponible. Si RDC no es requisito del ciclo, se ofrece como recuperación opcional; si es requisito, la ejecución dependiente queda bloqueada hasta verificar el handshake.

## 3. Acción del usuario

Al recibir RDC-REINSTANTIAR:

1. cerrar la terminal/sesión RDC que el usuario está observando como activa;
2. iniciar/reinstanciar una sesión RDC nueva;
3. esperar a que el nuevo canal reporte sus datos de conexión;
4. devolver al modelo el bloque RDC-HANDSHAKE.

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

Los campos que la herramienta no proporcione se marcan NO DISPONIBLE; no se inventan. Como mínimo para sustituir o refrescar el estado global deben quedar determinados cuenta, dispositivo, device_id y evidencia suficiente de conectividad. Una restauración de la misma identidad también cuenta como refresco válido y actualiza la marca temporal.

## 5. Validación

El modelo:

1. compara la nueva identidad con la identidad persistente;
2. verifica que existe evidencia positiva de conexión;
3. comprueba compatibilidad con el perfil de ubicación;
4. conserva la procedencia y la marca temporal;
5. solo después actualiza ESTADO-RDC-ACTIVO.md.

Una sustitución o refresco no validado no cuenta como recuperación. Si la escritura de `ESTADO-RDC-ACTIVO.md` falla, la recuperación permanece pendiente y no se permite declarar resuelta la conectividad ni reanudar trabajo RDC-dependiente.

## 5.1 Publicación transaccional

La validación del handshake no completa por sí sola la recuperación. La recuperación requiere la publicación condicionada del estado y su lectura de vuelta:

`VALIDAR → PUBLICAR CON SHA → READ-BACK → RESUELTA`

La escritura debe identificar la versión/sha del recurso que se leyó. Si esa versión cambió, se rechaza el intento, se vuelve a leer el estado actual y se reconcilia.

No se permite force-push, sobrescritura ciega ni modificación de una copia local como sustituto de la fuente global.

## 6. Actualización global

Una vez validado el handshake, ESTADO-RDC-ACTIVO.md se actualiza con:

- nueva cuenta;
- nuevo dispositivo;
- nuevo device_id;
- nueva conectividad;
- nueva verificación;
- ubicación/perfil;
- identidad efectiva;
- estado de recuperación RESUELTA;
- sustitución explícita de la sesión anterior.

La actualización debe realizarse antes de reanudar cualquier operación sustantiva dependiente de RDC. Después debe ejecutarse un read-back sobre `main` y confirmar que la identidad, conectividad y marca temporal publicadas coinciden con el handshake validado.

## 7. Propagación

La propagación entre conversaciones ocurre por lectura del estado global actualizado en el siguiente ciclo. Las conversaciones no deben depender de la memoria de la conversación que realizó la recuperación.

## 8. Estados

RDC-RECUPERACION = REQUERIDA → se necesita RDC-REINSTANTIAR.  
RDC-RECUPERACION = EN ESPERA HANDSHAKE → el usuario debe entregar los datos de la nueva sesión.  
RDC-RECUPERACION = RESUELTA → la nueva sesión fue validada y ya gobierna globalmente.

## 9. Prohibiciones

No borrar la sesión persistente antes de validar la nueva.  
No declarar INACTIVA por un simple OFFLINE.  
No mezclar terminales antiguas y nuevas.  
No inventar comandos de shell para sustituir el procedimiento.  
No reanudar trabajo RDC-dependiente antes de actualizar el estado global.
