# Registro de Verificación por Ciclo

**Estado:** CANÓNICO  
**Versión:** v1.6.0 — Salida Minimalista con Health-Check MCP  
**Fecha:** 2026-10-07

## Formato mínimo

`PROYECTO / CONV-XX / CXXX`

`SI CARGADO · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETO · ACTIVO`

`ChatGPT · UBIC: ... · RDC: ... · C: ... · S: ... · K: ✓|?|! · fila4`

`NOTAS · 🟢 SIN NOTAS | 🟡 NOTAS PENDIENTES`

`RESULTADO: ...`

`ESTADO: ...`

## Identificación normativa obligatoria

Cada ciclo debe identificar la instantánea normativa que lo gobierna:

`SI: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

La referencia relativa se calcula a partir de `Última actualización canónica` del SI vigente. Para auditoría puede acompañarse del instante ISO-8601 exacto.

## Principio de uso

La denominación de versión es específica de la versión y no debe reutilizar el título general `Sistema de Instrucciones Metacognitivas`. El registro histórico de versiones pertenece al SI canónico.
\n\n## Salida de bloqueo

Cuando un ciclo quede BLOQUEADO, la notificación debe iniciar con este bloque visual, sin texto previo:

```
╔════════════════════════════════════════════════════════════╗
║ ⛔⛔⛔  BLOQUEADO · EJECUCIÓN DETENIDA  ⛔⛔⛔              ║
╠════════════════════════════════════════════════════════════╣
║ MOTIVO: <código/motivo canónico>                           ║
║ RDC: <REQUERIDA|NO VERIFICADA|NO DISPONIBLE>               ║
║ ESTADO DEL CICLO: BLOQUEADO                                ║
║ CONVERSACIÓN: ABIERTA PARA RESOLUCIÓN                      ║
╚════════════════════════════════════════════════════════════╝
```

El bloque visual es obligatorio y debe preceder cualquier explicación. Su función es permitir reconocer el bloqueo de un vistazo. El bloqueo detiene la ejecución sustantiva y el cierre del ciclo, pero **no impide conversar con el modelo para resolverlo**.

Después del bloque, solo se debe informar lo necesario para levantar la condición de bloqueo, incluyendo la información mínima que debe proporcionar el usuario o la verificación que deba realizarse. Mientras el estado sea BLOQUEADO no se declara éxito ni se ejecutan operaciones sustantivas dependientes del contexto.

## Contexto operativo obligatorio\n\nCada registro de ciclo debe conservar el bloque de contexto definido por el anexo canónico:\n\n`PLATAFORMA | UBICACION | RDC-REQUERIDA | RDC-SESION | RDC-CUENTA | RDC-USO-MENSUAL | WIN-OPERATIVO | CONTEXTO-VERIFICACION`\n\nCuando exista identidad administrativa relevante, se añade `WIN-ADMIN`. Cuando exista información de terminales RDC, se añade `RDC-TERMINAL`. `CONTEXTO-VERIFICACION` registra el resultado del gate: `VERIFICADO-ACTIVO`, `VERIFICADO-INACTIVO`, `NO-REQUERIDO` o `BLOQUEADO`.\n\nLa ausencia de un dato se registra como `NO VERIFICADO`, `NO DISPONIBLE` o `PENDIENTE`. No se debe inferir información faltante.\n\nLa especificación completa se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`.\n

## Indicador discreto de acceso MCP KHORA

El campo `K` significa acceso al MCP canónico de KHORA y tiene semántica estricta:

- `K: ✓` = acceso autenticado y verificado al recurso MCP canónico con `volcados:read`, `runtime:read` y `norm:turn`.
- `K: ?` = acceso no verificado en el ciclo.
- `K: !` = acceso intentado pero fallido, no autorizado o no disponible.

`K: ✓` exige evidencia de una comprobación autenticada contra `/api/mcp`. Conocer la URL, tener GitHub o tener RDC no demuestra acceso al MCP.

## Sesion RDC activa

El registro de ciclo conserva la sesión RDC activa identificada por el estado global. Antes de cualquier operación dependiente del entorno debe ejecutarse el gate de contexto. La verificación primaria por ciclo es un ping al device_id registrado. Si falla, se escala a descubrimiento de dispositivo y cuenta. Si la detección no permite establecer activo/inactivo, el ciclo queda bloqueado hasta resolver explícitamente con el usuario si RDC es requisito.
