# Gobernanza de Estado Global RDC

**Estado:** CANÓNICO  
**Versión:** v1.0.0  
**Fecha:** 2026-10-07  
**Ámbito:** Todos los ciclos sujetos a la metodología cuando exista estado operativo global de RDC.

## 1. Autoridad y naturaleza del registro global

`ESTADO-RDC-ACTIVO.md` es la fuente persistente de continuidad del conjunto de identidades RDC conocidas. No es la fuente de verdad de la conectividad actual ni contiene una única terminal globalmente seleccionada.

La memoria conversacional no sustituye el registro. El registro tampoco sustituye el descubrimiento vivo del proveedor cuando el ciclo necesita resolver qué dispositivos están conectados ahora.

## 2. Orden obligatorio de adquisición

Antes de cualquier `HEALTH`, `OPEN`, `VERIFY` o `RELEASE` de KHORA, el ciclo debe:

1. adquirir el snapshot normativo vigente;
2. leer `ESTADO-RDC-ACTIVO.md`;
3. descubrir en vivo los dispositivos ONLINE en todas las cuentas RDC accesibles al runtime cuando RDC sea relevante;
4. reconciliar las identidades observadas con el registro persistente;
5. seleccionar, si procede, la terminal objetivo del ciclo;
6. resolver recuperación solo si la terminal requerida no es observable;
7. solo después continuar con KHORA.

Una certificación de KHORA no puede legitimar una selección de terminal RDC que no haya sido resuelta conforme a este orden.

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

La identidad de una terminal se define por `RDC-CUENTA + RDC-DEVICE-ID`. El nombre visible del dispositivo no es suficiente para identificarla.

Múltiples identidades pueden permanecer ONLINE y ACTIVAS simultáneamente cuando corresponden a dispositivos distintos. Esto no es conflicto.

Un cambio de estado debe afectar únicamente a la identidad que lo origina. Una terminal nueva no sustituye automáticamente otra terminal. Un nuevo nombre o device_id observable se registra como identidad independiente hasta que exista evidencia de que es una reinstanciación del mismo dispositivo.

Los datos parciales no pueden alterar una identidad persistente ni atribuir una terminal a otra.

## 8. Propagación

La propagación transversal se produce por el estado persistente del registro. Una conversación posterior recupera las identidades conocidas y su historial, pero debe consultar el proveedor en vivo para conocer qué dispositivos están ONLINE en su propio ciclo.

La conversación que descubrió una terminal no convierte esa terminal en la selección global de las conversaciones posteriores. La selección es local al ciclo/conversación y se basa en la identidad concreta del dispositivo.

## 9. Fail-closed selectivo

Un fallo de lectura/escritura del estado global bloquea las operaciones que dependan de una identidad o conectividad RDC resuelta.

Este bloqueo no puede transformarse en una afirmación de que la sesión terminó.

La indisponibilidad del estado, del conector o de KHORA se mantiene diferenciada de la finalización de la sesión.

## 10. Prueba de recuperación

Una recuperación de una terminal concreta solo puede marcarse `RESUELTA` cuando existe:

- handshake fresco para esa identidad;
- identidad cuenta + device_id validada;
- conectividad vigente según la fuente disponible;
- estado persistente actualizado si el ciclo produjo un cambio que deba propagarse;
- lectura de vuelta satisfactoria cuando hubo publicación.

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

La implementación se considera completa cuando una conversación nueva puede repetir el circuito sin depender de otra conversación para saber qué terminal está activa:

`FRESCURA SI → LEER REGISTRO → DESCUBRIMIENTO VIVO POR CUENTA → RECONCILIACIÓN → SELECCIÓN DE TERMINAL → OPERACIÓN`

Para recuperación de una terminal concreta:

`DESCUBRIMIENTO VIVO → TERMINAL NO OBSERVABLE → RDC-REINSTANTIAR → HANDSHAKE → VALIDACIÓN → PUBLICACIÓN → READ-BACK → PROPAGACIÓN`
