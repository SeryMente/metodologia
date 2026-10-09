# Registro Operativo Global — Identidades RDC

**Naturaleza:** registro operativo mutable; no es una fuente de verdad de conectividad actual ni selecciona una terminal global para todas las conversaciones.
**Ultima actualizacion registrada:** 2026-10-09T01:10:54.905Z
**Funcion transversal:** conservar identidades RDC conocidas, ciclos de vida y observaciones verificadas para continuidad entre conversaciones.

## Modelo de estado

| Concepto | Regla |
|---|---|
| Identidad RDC | `RDC-CUENTA + RDC-DEVICE-ID` |
| Terminal | Dispositivo concreto identificado por la identidad RDC |
| Ubicacion | Contexto fisico independiente de la identidad RDC |
| Conversacion | Contenedor independiente que selecciona terminal por ciclo |
| Registro persistente | Conserva identidades, historial y metadatos de continuidad |
| Fuente de conectividad actual | Proveedor RDC en vivo (`list_devices`, `ping` y herramientas equivalentes) |
| Seleccion actual | **NO GLOBAL**; se determina por ciclo/conversacion |
| Multiples terminales simultaneas | Permitidas cuando corresponden a identidades distintas |

## Observacion viva mas reciente

**Momento:** 2026-10-09T01:10:54.905Z  
**Tipo:** HANDSHAKE FRESCO + PING VERIFICADO  
**Cuenta RDC:** blacksheepsheepsup@gmail.com  
**Dispositivo:** PC-4  
**RDC-DEVICE-ID:** ad151d48-3bd6-44a8-9b61-b0d0291643eb  
**RDC-CONECTIVIDAD:** VERIFICADO-ACTIVO  
**RDC-ORIGEN:** proveedor RDC en vivo + ping satisfactorio  
**Nota:** identidad RDC independiente; no sustituye identidades previas con nombres visibles similares.


## Descubrimiento vivo por cuenta · instantánea del ciclo

### Cuenta: blacksheepsheepsup@gmail.com

| Dispositivo | RDC-DEVICE-ID | Estado observado | Ultimo visto reportado |
|---|---|---|---|
| PC-4 | ad151d48-3bd6-44a8-9b61-b0d0291643eb | ONLINE | proveedor reportó 3m al momento de descubrimiento; ping 2026-10-09T01:10:54.905Z |

**Nota:** el proveedor devolvió esta identidad como ONLINE. Una identidad no devuelta en una lista posterior no se elimina ni se declara finalizada solo por inferencia.

**Uso mensual observado de esta cuenta:** 86% usado / 14% restante.  
**Fuente:** who_am_i del proveedor RDC durante el mismo ciclo; no implica fecha de reinicio del contador.

### Cuenta: elathanor111@gmail.com

| Dispositivo | RDC-DEVICE-ID | Estado observado | Ultimo visto reportado |
|---|---|---|---|
| PC10RCIF4EI4 | e2673ecd-dc26-45ac-8e53-f8475ae01d58 | OFFLINE | 26h |
| PC10RCIF4EI4 | f1690b1c-5833-4203-a361-1b35dc64f4d6 | OFFLINE | 34h |
| PC10RCIF4EI4 | a0e844b8-4876-44f3-bbfd-e476c9360c74 | OFFLINE | 50h |
| PC10RCIF4EI4 | 3de5e950-8696-48a8-99d4-8dd23aa4b8d6 | OFFLINE | 55h |
| PC10RCIF4EI4 | b6aca917-2346-41be-9e0d-928ed858990e | OFFLINE | 56h |
| PC-7 | addd4ea6-c208-4a95-9baa-dd8d78983447 | OFFLINE | 72h |
| PC-7 | 506f4dc3-01d2-48c3-bc86-c5879dacee50 | OFFLINE | 73h |


## Registro de ciclo de vida conocido

| Identidad RDC | Estado persistente | Nota |
|---|---|---|
| blacksheepsheepsup@gmail.com + ad151d48-3bd6-44a8-9b61-b0d0291643eb | CONOCIDA · ONLINE EN ULTIMA OBSERVACION | PC-4; handshake fresco y ping 2026-10-09T01:10:54.905Z; identidad RDC nueva e independiente |
| blacksheepsup@gmail.com + ad151d48-3bd6-44a8-9b61-b0d0291643eb | CONOCIDA · ONLINE EN ULTIMA OBSERVACION | PC-4; handshake fresco y ping verificado 2026-10-09T00:30:31.732Z; identidad RDC nueva e independiente |
| blacksheepsup@gmail.com + e5a4159e-cb32-4ba6-89d6-3a2083a49893 | CONOCIDA · ONLINE EN ULTIMA OBSERVACION | PC-7; nueva conexion verificada y ping 2026-10-08T19:21:57.319Z |
| blacksheepsup@gmail.com + 418659b7-64bc-4cb2-a2cb-ed8fd83c5005 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC-7; identidad distinta |
| blacksheepsup@gmail.com + 5165397f-3ccf-4c7d-939f-821526119101 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC-7; identidad distinta |
| blacksheepsup@gmail.com + 7fabbc1d-7c0d-4400-bd31-88b3b4229286 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| blacksheepsup@gmail.com + 87d6fd01-77e1-4a93-ba1a-8faf6b387016 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC-4 |
| elathanor111@gmail.com + e2673ecd-dc26-45ac-8e53-f8475ae01d58 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| elathanor111@gmail.com + f1690b1c-5833-4203-a361-1b35dc64f4d6 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| elathanor111@gmail.com + a0e844b8-4876-44f3-bbfd-e476c9360c74 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| elathanor111@gmail.com + 3de5e950-8696-48a8-99d4-8dd23aa4b8d6 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| elathanor111@gmail.com + b6aca917-2346-41be-9e0d-928ed858990e | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC10RCIF4EI4 |
| elathanor111@gmail.com + addd4ea6-c208-4a95-9baa-dd8d78983447 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC-7 |
| elathanor111@gmail.com + 506f4dc3-01d2-48c3-bc86-c5879dacee50 | CONOCIDA · OFFLINE EN ULTIMA OBSERVACION | PC-7 |

## Reglas de lectura

1. Este archivo no responde por si solo a la pregunta «¿qué terminal está activa ahora?».
2. Para esa pregunta, el ciclo debe consultar el proveedor RDC en vivo.
3. El registro permite reconciliar nombres, device_id, historial y ciclos de vida.
4. Una identidad ONLINE nueva se registra sin sustituir automaticamente otra identidad.
5. La misma etiqueta `PC-7` puede pertenecer a varias identidades y nunca constituye por si sola un selector.
6. La ubicacion no se almacena como propiedad intrínseca de una terminal salvo evidencia y decisión especifica; una misma terminal puede usarse en distintas ubicaciones a lo largo del tiempo.
7. Una conversación nueva no hereda una terminal seleccionada por otra conversación.
8. Una terminal seleccionada para un ciclo se considera vigente para ese ciclo tras la verificación del proveedor; su persistencia transversal depende del registro.
9. Los cambios persistentes se publican con control de versión/SHA y read-back.

## Estado global de selección

`RDC-SELECCION-GLOBAL = NO EXISTE`

`RDC-TERMINAL-POR-CICLO = OBLIGATORIA CUANDO RDC ES REQUERIDA`

`RDC-FUENTE-ACTUAL = PROVEEDOR EN VIVO`
