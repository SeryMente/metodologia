# GOV-TASK-011 — DTC · Dinámica Trilateral por Ciclo

**Estado:** en_curso · **Responsable de verificación:** Gobernanza, generación 9. **Ejecución/evidencia:** cada frente, bajo su propio control.

## Regla mínima — sin excepción

En cada ciclo real de Gobernanza, EP y MCP-OCP:

1. Tras el preflight, leer el registro provisional de tareas y el objeto de comunicación vigente.
2. Abrir una sola entrada en ese mismo objeto: identificador de ciclo, cursor real (rama/revisión/blob) y respuesta inicial; si no hay mensaje nuevo, registrar `SIN_NOVEDAD`.
3. Procesar solo trabajo autorizado y analizar la respuesta previa antes de abrir otra solicitud.
4. Al cierre, completar esa misma entrada con delta o `SIN_NOVEDAD`, tareas/estados, bloqueos, siguiente acción y evidencia.
5. Leer de vuelta el objeto y los documentos modificados.

Sin apertura, cierre o read-back, el ciclo queda incompleto. No sobrescribir entradas anteriores ni crear otro OCP, buzón, bitácora, control, sesión o folio.

## Verificación de Gobernanza

En cada ciclo propio, verificar los tres frentes y registrar uno de estos estados por frente: `CUMPLE_VERIFICADO`, `CUMPLE_PARCIAL`, `NO_CUMPLE`, `NO_VERIFICABLE` o `SIN_CICLO_OBSERVADO`. La falta de ciclo observable no equivale a cumplimiento. Gobernanza analiza la respuesta y formula como máximo una corrección material por frente. Esta verificación no transfiere ejecución, titularidad ni autorización.

## Objetos y registros

- **EP:** [comunicación provisional](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md), actualmente en `docs/metacanon-objetos-20261011`; pendiente de reconciliar por EP con `main`. OEP e índice de tareas se consultan en `main`.
- **MCP-OCP:** [comunicación provisional](../../../mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md), en `main`; registro de tareas §8.1 y compuerta §10.1 de `MCP-METODOLOGIA.md`.
- **Gobernanza:** esta tarea, `GOBERNANZA.md`, `PENDIENTES.md` y la evidencia DTC.

## Resultado de auditoría · 2026-10-31

- **Gobernanza:** `CUMPLE_VERIFICADO` al cierre de este ciclo, sujeto al read-back final de los artefactos propios.
- **EP:** `CUMPLE_PARCIAL`. OEP v0.3.20 / VCU-EP-v22 e índice provisional en `main` ya contienen compuertas; el objeto de comunicación sigue únicamente en la rama documental y el addendum DTC no tiene respuesta específica. EP debe reconciliar el mismo objeto en `main`, preservando el historial.
- **MCP-OCP:** `CUMPLE_PARCIAL`. Control `owned`, generación 3; registro §8.1 y compuerta §10.1 presentes; respuesta inicial DTC registrada en §19. Falta el cierre/read-back de ese ciclo en el mismo objeto.

## Automatización y límites

La DTC es **semiautomática** mediante cursor, compuerta y registro obligatorio en cada ciclo. No se verificó un disparador autónomo que obligue a otros frentes a escribir ni monitoreo continuo; Gobernanza verifica en cada ciclo real. No declarar automatización plena.

## Procedencia

Instrucción directa del operador: mantener comunicación recurrente con EP y MCP-OCP mediante los objetos provisionales existentes, con lectura/respuesta al inicio y documentación/read-back al cierre. Se conserva la constitución y sus antecedentes en [crónica DTC](../../cronica/C-GOBERNANZA-DTC-01.md) y [evidencia DTC](../../evidencias/C-GOBERNANZA-DTC-01.json).

FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; los folios globales CV/CY/A/B continúan `PENDIENTE / NO ASIGNADO`.

## Continuidad DTC entre conversaciones

Reanudar en un hilo nuevo no reinicia el historial. Tras el preflight, recuperar desde `main` el DUG vigente, el núcleo/registro del frente y el último cursor del mismo objeto de comunicación; abrir una entrada de ciclo en ese objeto, procesar serialmente, completar el cierre y hacer read-back. Si no hay mensaje nuevo, escribir `SIN_NOVEDAD` con cursor. No crear otro canal ni declarar completo un ciclo sin apertura, cierre y read-back.

**Última revalidación:** Gobernanza `CUMPLE_VERIFICADO`; EP `CUMPLE_PARCIAL` (OEP §90 e índice de tareas con compuerta, pero objeto fuera de `main` y acuse específico al addendum pendiente); MCP-OCP `CUMPLE_VERIFICADO` para el ciclo local §19–20, aunque su núcleo conserva una referencia obsoleta que MCP-OCP debe corregir en su propio ciclo.