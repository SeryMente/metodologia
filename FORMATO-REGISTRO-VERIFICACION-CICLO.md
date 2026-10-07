# Registro de Verificación por Ciclo

**Estado:** CANÓNICO  
**Versión:** v1.2.0 — Identidad, Vigencia y Contexto del Registro de Ciclo  
**Fecha:** 2026-10-07

## Formato mínimo

`CICLO | ATTEMPT | VERIFICACIÓN | EVIDENCIA`

## Identificación normativa obligatoria

Cada ciclo debe identificar la instantánea normativa que lo gobierna:

`SI: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

La referencia relativa se calcula a partir de `Última actualización canónica` del SI vigente. Para auditoría puede acompañarse del instante ISO-8601 exacto.

## Principio de uso

La denominación de versión es específica de la versión y no debe reutilizar el título general `Sistema de Instrucciones Metacognitivas`. El registro histórico de versiones pertenece al SI canónico.
\n\n## Contexto operativo obligatorio\n\nCada registro de ciclo debe conservar el bloque de contexto definido por el anexo canónico:\n\n`PLATAFORMA | UBICACION | RDC-SESION | RDC-CUENTA | RDC-USO-MENSUAL | WIN-OPERATIVO`\n\nCuando exista identidad administrativa relevante, se añade `WIN-ADMIN`. Cuando exista información de terminales RDC, se añade `RDC-TERMINAL`.\n\nLa ausencia de un dato se registra como `NO VERIFICADO`, `NO DISPONIBLE` o `PENDIENTE`. No se debe inferir información faltante.\n\nLa especificación completa se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`.\n