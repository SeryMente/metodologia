# Registro de Verificación por Ciclo

**Estado:** CANÓNICO  
**Versión:** v1.7.2 — HUD Compacto y Verificación Adaptativa  
**Fecha:** 2026-10-07

## Formato mínimo

> **PROYECTO / CONV-XX / CXXX**  
> `SI CARGADO` · **vX.Y.Z — NOMBRE DE VERSIÓN** · COMPLETO · ACTIVO  
> `ChatGPT` · **UBIC:** … · **RDC:** … · **C:** … · **S:** … · **K:** ✓|?|! · **T:** ✓|?|! · **RDC-CNX:** … · **USR:** `fila4`  
> **RESULTADO:** …  
> **ESTADO:** **COMPLETADO** | **BLOQUEADO** | **PENDIENTE**

## Identificación normativa obligatoria

Cada ciclo debe identificar la instantánea normativa que lo gobierna:

`SI: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

La referencia relativa se calcula a partir de `Última actualización canónica` del SI vigente. Para auditoría puede acompañarse del instante ISO-8601 exacto.

## 0. Regla de obligatoriedad

Este formato es obligatorio en **cada turno/ciclo sujeto a la metodología, sin excepción**. Aplica a respuestas sustantivas, respuestas de bloqueo y respuestas usadas para resolver un bloqueo.

El orden canónico de salida es fijo:

1. `PROYECTO / CONV-XX / CXXX`
2. `SI CARGADO ...`
3. `ChatGPT ...`
5. `RESULTADO: ...`
6. `ESTADO: ...`

No se puede omitir el bloque por considerar que el turno es simple, que no produjo cambios, que solo fue una aclaración o que el usuario ya conoce el contexto.

## 1. HUD compacto

La información metodológica visible se presenta como un bloque compacto de baja intrusión. Se permite enriquecer la presentación mediante **negritas**, `código` y etiquetas cortas sin introducir campos ni decisiones nuevas. El contrato vigente es `v1.7.2`.

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

- `K: ✓` = acceso autenticado y verificado al MCP canónico, con la secuencia normativa verificada/liberada.
- `K: OFF` = el MCP no estuvo disponible o no pudo alcanzarse; la salida continúa sin atribuirle verificación.
- `K: ?` = la disponibilidad o el resultado no pudo determinarse.
- `K: !` = acceso intentado y fallido, no autorizado, o verificación normativa rechazada.

`K: ✓` exige evidencia de una comprobación autenticada contra `/api/mcp`. Conocer la URL, tener GitHub o tener RDC no demuestra acceso al MCP.

## Sesion RDC activa

El registro de ciclo conserva la sesión RDC activa identificada por el estado global. Antes de cualquier operación dependiente del entorno debe ejecutarse el gate de contexto. La verificación primaria por ciclo es un ping al device_id registrado cuando la operación requiere RDC en vivo. Si falla, se escala a descubrimiento de dispositivo y cuenta cuando sea necesario. Si la detección no permite establecer activo/inactivo, solo puede bloquearse la ejecución cuando el ciclo requiere RDC en vivo; la conversación permanece abierta para resolverlo. La identidad persistente no se invalida por una caída de conectividad.
