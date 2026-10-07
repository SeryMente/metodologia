# Registro de Verificación por Ciclo

**Estado:** CANÓNICO  
**Versión:** v1.3.0 — Gate de Contexto Operativo y Sesión RDC Verificable  
**Fecha:** 2026-10-07

## Formato mínimo

`CICLO | ATTEMPT | VERIFICACIÓN | EVIDENCIA`

## Identificación normativa obligatoria

Cada ciclo debe identificar la instantánea normativa que lo gobierna:

`SI: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

La referencia relativa se calcula a partir de `Última actualización canónica` del SI vigente. Para auditoría puede acompañarse del instante ISO-8601 exacto.

## Principio de uso

La denominación de versión es específica de la versión y no debe reutilizar el título general `Sistema de Instrucciones Metacognitivas`. El registro histórico de versiones pertenece al SI canónico.
\n\n## Contexto operativo obligatorio\n\nCada registro de ciclo debe conservar el bloque de contexto definido por el anexo canónico:\n\n`PLATAFORMA | UBICACION | RDC-REQUERIDA | RDC-SESION | RDC-CUENTA | RDC-USO-MENSUAL | WIN-OPERATIVO | CONTEXTO-VERIFICACION`\n\nCuando exista identidad administrativa relevante, se añade `WIN-ADMIN`. Cuando exista información de terminales RDC, se añade `RDC-TERMINAL`. `CONTEXTO-VERIFICACION` registra el resultado del gate: `VERIFICADO-ACTIVO`, `VERIFICADO-INACTIVO`, `NO-REQUERIDO` o `BLOQUEADO`.\n\nLa ausencia de un dato se registra como `NO VERIFICADO`, `NO DISPONIBLE` o `PENDIENTE`. No se debe inferir información faltante.\n\nLa especificación completa se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`.\n

## Sesion RDC activa

El registro de ciclo conserva la sesión RDC activa identificada por el estado global. Antes de cualquier operación dependiente del entorno debe ejecutarse el gate de contexto. La verificación primaria por ciclo es un ping al device_id registrado. Si falla, se escala a descubrimiento de dispositivo y cuenta. Si la detección no permite establecer activo/inactivo, el ciclo queda bloqueado hasta resolver explícitamente con el usuario si RDC es requisito.
