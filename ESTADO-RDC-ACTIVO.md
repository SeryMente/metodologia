# Estado Operativo - Sesion RDC Activa

**Naturaleza:** registro operativo mutable; no constituye por si mismo una nueva norma.
**Ultima actualizacion:** 2026-10-08T16:22:08.620Z
**Funcion transversal:** fuente global de continuidad de la identidad de la sesion RDC entre conversaciones.

## Sesion activa

| Campo | Valor |
|---|---|
| Plataforma | ChatGPT |
| Ubicacion | CECEQ |
| RDC-REGISTRO-ID | RDC-20261008-0001 |
| RDC-SESION | ACTIVA · IDENTIDAD PERSISTENTE |
| RDC-CONECTIVIDAD | VERIFICADO-ACTIVO · PING · 2026-10-08T16:20:35.092Z |
| RDC-CUENTA | blacksheepsup@gmail.com |
| RDC-DISPOSITIVO | PC-7 |
| RDC-DEVICE-ID | 5165397f-3ccf-4c7d-939f-821526119101 |
| RDC-VERIFICACION-CONEXION | VERIFICADO · SESSION RESTORED · CHANNEL SUBSCRIBED · DEVICE ONLINE · 2026-10-08T16:20:35.092Z |
| Ultima verificacion de conexion | 2026-10-08T16:20:35.092Z · RESULTADO: VERIFICADO-ACTIVO · EVIDENCIA: PING + HANDSHAKE DEL REMOTE DEVICE |
| RDC-FINALIZACION | NO REGISTRADA |
| RDC-SUSTITUCION | SUSTITUYE RDC-20261007-0001 · 2026-10-08T16:22:08.620Z |
| PERSISTENCIA DE SESION | VIGENTE HASTA FINALIZACION O SUSTITUCION EXPLICITAS |
| RDC-MENSUAL | 61% usado / 39% restante |
| RDC-MENSUAL-VERIFICACION | 2026-10-08 · FUENTE: RDC who_am_i · CUENTA DE LA SESIÓN ACTIVA |
| WIN-OPERATIVO | fila4 |
| WIN-ADMIN | central\\mantenimientorci |
| WIN-EFECTIVO-RDC | central\\mantenimientorci |
| RDC-REQUERIDA | PENDIENTE POR CICLO; NO SE PRESUPONE ACTIVA |
| CONTEXTO-VERIFICACION | VERIFICADO-ACTIVO · SUSTITUCION PUBLICADA Y READ-BACK VERIFICADO |
| PERFIL-UBICACION | CECEQ · COMPLETO |
| IDENTIDAD-OPERATIVA | fila4 · PERFIL CECEQ; NO IMPLICA SESION RDC SEPARADA |
| RDC-OBSERVABILIDAD | COHERENTE · PROVIDER REPORTA DEVICE ONLINE Y PING VERIFICADO |
| RDC-RECUPERACION | RESUELTA · COMANDO CANONICO: RDC-REINSTANTIAR |
| RDC-RECUPERACION-ESTADO | RESUELTA · HANDSHAKE VALIDADO · ESTADO GLOBAL PUBLICADO · READ-BACK VERIFICADO |

## Regla de lectura

Este registro representa la identidad de la sesión RDC globalmente vigente para todas las conversaciones sujetas a la metodologia. Debe leerse al inicio de cada ciclo y no se reinicia por cambio de conversación.

**Persistencia:** `RDC-SESION = ACTIVA` permanece vigente mientras no exista un registro explícito de `FINALIZADA` o `SUSTITUIDA`. Un corte temporal, dispositivo offline, reinicio de cliente o indisponibilidad de la herramienta RDC cambia la conectividad observable, pero no borra ni invalida por si mismo la identidad persistente de la sesión.

**Conectividad separada:** la verificación por ping determina si el canal puede utilizarse en vivo. La identidad persistente responde a qué sesión debe reconocerse globalmente; la conectividad responde a si puede ejecutarse trabajo RDC en ese momento.

Una nueva conversación debe heredar la sesión registrada antes de pedir al usuario que vuelva a identificarla. Solo una evidencia de cierre/cambio sustituye la identidad global. Si una operación requiere RDC en vivo y la conectividad no está verificada, el gate puede bloquear esa operación sin declarar que la sesión dejó de existir.

Una nueva sesion verificada debe sustituir este registro y actualizar su marca temporal. La identidad efectiva del canal RDC puede usarse para el trabajo tecnicamente valido; fila4 permanece como identidad operativa de referencia y no implica una segunda sesion RDC.

## Ultimo handshake validado

**RDC-HANDSHAKE:** recibido y validado desde el Remote Device. La identidad persistente vigente es la sesión RDC-20261008-0001 y la conectividad quedó confirmada por el proveedor.

- Estado del dispositivo: Online
- Sesion: Session restored
- Canal: Channel subscribed
- Remote Device: connected
- Device: PC-7
- Device ID: 5165397f-3ccf-4c7d-939f-821526119101
- Marca: HANDSHAKE FRESCO DEL CICLO

## Sustitución registrada

La sesión anterior RDC-20261007-0001 (PC10RCIF4EI4 / 7fabbc1d-7c0d-4400-bd31-88b3b4229286) fue apagada mediante shutdown y posteriormente confirmada OFFLINE. La nueva sesión RDC-20261008-0001 fue verificada mediante handshake y ping y quedó publicada como sesión global vigente.

## Restricciones

La sesión RDC vigente puede utilizarse para trabajo técnicamente válido. Para CECEQ, fila4 permanece como identidad operativa de referencia y central\\mantenimientorci como identidad efectiva del canal. No se abren sesiones RDC paralelas para resolver diferencias de identidad.

La única restricción específica de materialización es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.

## Fuente histórica

El ciclo de vida de esta sesión y de las anteriores se conserva en HISTORIAL-RDC.md.

## Cierre operativo del estado anterior · 2026-10-07

Se conserva como antecedente histórico y no como estado vigente. Los datos anteriores del deployment y de KHORA pertenecen al cierre del 2026-10-07.
