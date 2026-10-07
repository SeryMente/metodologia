# Gobernanza de Estado Global RDC

**Estado:** CANÓNICO  
**Versión:** v1.0.0  
**Fecha:** 2026-10-07  
**Ámbito:** Todos los ciclos sujetos a la metodología cuando exista estado operativo global de RDC.

## 1. Autoridad del estado global

`ESTADO-RDC-ACTIVO.md` es la fuente única del estado lógico global de la sesión RDC. La memoria conversacional, el estado heredado por contexto, una terminal local o una observación aislada de la herramienta no pueden sustituirlo.

El estado global se consume en cada ciclo. No es válido asumir que el valor del ciclo anterior continúa siendo actual.

## 2. Orden obligatorio de adquisición

Antes de cualquier `HEALTH`, `OPEN`, `VERIFY` o `RELEASE` de KHORA, el ciclo debe:

1. adquirir el snapshot normativo vigente;
2. leer `ESTADO-RDC-ACTIVO.md`;
3. resolver `RDC-SESION`, `RDC-CONECTIVIDAD` y, cuando corresponda, `RDC-OBSERVABILIDAD`;
4. resolver recuperación si existe;
5. solo después continuar con KHORA.

Una certificación de KHORA no puede legitimar una sesión RDC que no haya sido resuelta conforme a este orden.

## 3. Invariante de recuperación

Cuando exista cualquier reporte al usuario de ausencia, pérdida, desconexión, inactividad, no verificación o indisponibilidad de RDC, el mismo ciclo debe ofrecer:

`RDC-REINSTANTIAR`

y el comando oficial vigente del proveedor:

`npx @wonderwhy-er/desktop-commander@latest remote`

El modelo no debe esperar a que el usuario pida el comando.

## 4. Handshake como evidencia de recuperación

La entrega de un `RDC-HANDSHAKE` fresco por el usuario es evidencia candidata de una conexión actual. El modelo debe validar el conjunto mínimo disponible y no exigir que el diagnóstico anterior haya sido correcto.

Una recuperación puede ser válida aunque la incidencia previa haya sido un falso positivo.

## 5. Publicación transaccional

La resolución de una sesión no está completa cuando el modelo recibe el handshake. Está completa únicamente cuando:

`HANDSHAKE → VALIDAR → ESCRIBIR ESTADO GLOBAL → VERIFICAR LECTURA DE VUELTA → RESOLVER`

La lectura de vuelta debe comprobar que el estado publicado contiene la identidad y conectividad que se pretendían registrar.

Si la escritura o la lectura de vuelta falla, `RDC-RECUPERACION` permanece pendiente y el ciclo no puede declarar la recuperación resuelta.

## 6. Protección contra carreras

Toda actualización del estado global debe usar la versión/sha actual del recurso como condición de escritura.

Si el recurso cambió entre lectura y escritura, la operación debe abortarse, volver a leer el estado más reciente y reconciliar antes de reintentar.

No se permiten actualizaciones ciegas ni force-push sobre el estado global para resolver carreras.

## 7. Integridad de identidad

La sustitución de una sesión requiere evidencia suficiente para identificar como mínimo cuenta, dispositivo, device_id y conectividad.

Si los datos representan la misma identidad persistente, se realiza un refresco; no se crea una segunda sesión.

Si representan otra identidad, la sustitución debe quedar explícita.

Los datos parciales no pueden sustituir el estado global.

## 8. Propagación

La propagación transversal se produce por el estado publicado en el repositorio. Una conversación posterior debe reconstruir la sesión global leyendo `ESTADO-RDC-ACTIVO.md`.

La conversación que recibió el handshake no tiene autoridad para hacer que otras conversaciones dependan de su memoria.

## 9. Fail-closed selectivo

Un fallo de lectura/escritura del estado global bloquea las operaciones que dependan de una identidad o conectividad RDC resuelta.

Este bloqueo no puede transformarse en una afirmación de que la sesión terminó.

La indisponibilidad del estado, del conector o de KHORA se mantiene diferenciada de la finalización de la sesión.

## 10. Prueba de recuperación

Una recuperación solo puede marcarse `RESUELTA` cuando existe:

- handshake fresco;
- identidad validada;
- estado global actualizado;
- lectura de vuelta satisfactoria;
- conectividad vigente según la fuente disponible.

El sistema no debe emitir una marca positiva basada únicamente en que el proceso local esté abierto.

## 11. No retroceso

Ningún anexo, bootstrap, README, formato, procedimiento o memoria puede introducir una regla que permita:

- omitir la lectura de `ESTADO-RDC-ACTIVO.md`;
- certificar KHORA antes de resolver RDC;
- aceptar datos de RDC de una conversación previa sin consultar el estado global;
- declarar recuperación sin escritura y lectura de vuelta;
- convertir `OFFLINE` en `INACTIVA` sin evidencia positiva de finalización;
- eliminar la oferta proactiva de `RDC-REINSTANTIAR`.

Si aparece una contradicción, prevalece este contrato y el SI canónico vigente.

## 12. Implementación verificable

La implementación se considera completa cuando una recuperación puede repetirse mediante el mismo circuito sin depender de la conversación donde empezó:

`FRESCURA SI → ESTADO RDC → DIAGNÓSTICO → RDC-REINSTANTIAR → HANDSHAKE → VALIDACIÓN → PUBLICACIÓN → READ-BACK → PROPAGACIÓN`
