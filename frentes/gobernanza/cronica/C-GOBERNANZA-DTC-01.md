# C-GOBERNANZA-DTC-01 — Constitución de la DTC

**Fecha:** 2026-10-31 · **Frente:** Gobernanza · **Tarea:** GOV-TASK-011 · **Folio global:** PENDIENTE / NO ASIGNADO; FOL1 continúa inactivo.

## Decisión del operador

El operador establece que la dinámica de trabajo recurrente entre los tres frentes se denomina de forma compacta **DTC — Dinámica Trilateral por Ciclo**. Además, Gobernanza asume la responsabilidad de verificar, ciclo a ciclo, que los tres frentes —Gobernanza, Entorno Persistente (EP) y OCP MCP— satisfacen los requisitos de apertura, comunicación prioritaria, procesamiento autorizado, documentación de cierre y read-back.

## Alcance de la responsabilidad de Gobernanza

Gobernanza es responsable de comprobar y documentar el cumplimiento de la DTC en cada uno de sus ciclos. La comprobación incluye su propio frente y los ciclos observables de EP y OCP MCP desde la revisión anterior. No existe vigilancia continua entre turnos ni trabajo en segundo plano. Si no se puede demostrar que un frente tuvo ciclo, se registra SIN_CICLO_OBSERVADO; nunca se presume cumplimiento. La responsabilidad de verificar no transfiere la ejecución, control, autorización ni titularidad de los otros frentes.

## Contrato de cumplimiento por frente

1. **Apertura:** después de su preflight obligatorio, leer las comunicaciones nuevas del modelo central/Gobernanza y el registro de tareas provisional vigente; responder la comunicación pendiente al inicio del ciclo, antes de otra tarea.
2. **Procesamiento:** continuar el trabajo propio dentro del ámbito y autorización vigentes; atender primero la respuesta/solicitud recibida; conservar serialidad y evitar rondas redundantes.
3. **Cierre:** después de procesar la salida, documentar novedades, hitos/tareas/estados, evidencia, decisiones, bloqueos, siguiente acción y pronóstico en el objeto de comunicación y OCP/núcleo; actualizar el índice de tareas cuando proceda; verificar read-back.
4. **Persistencia:** usar los objetos existentes; no crear un segundo OCP, control, sesión o folio; no confundir publicación con lectura ni reporte con verificación.

## Regla de verificación de Gobernanza

Para cada frente, registrar por separado estado y evidencia para: (a) identidad/fuente/control y ciclo observable; (b) comunicación nueva leída; (c) respuesta inicial registrada antes del trabajo sustantivo; (d) procesamiento dentro de su alcance; (e) novedades documentadas al cierre; (f) OCP/núcleo y tareas provisionales actualizados cuando corresponda; (g) lectura de vuelta de los cambios declarados.

Estados permitidos: `CUMPLE_VERIFICADO`, `CUMPLE_PARCIAL`, `NO_CUMPLE`, `NO_VERIFICABLE`, `SIN_CICLO_OBSERVADO`. Si falta evidencia, no elevar el estado. Cada brecha debe identificar requisito, evidencia faltante, frente responsable, corrección requerida y estado de la comunicación. La verificación se hace en el siguiente ciclo real de Gobernanza.

## Materialización de esta decisión

- GOV-TASK-011 se renombra funcionalmente como DTC, sin cambiar su ID local.
- GOBERNANZA.md y PENDIENTES.md incorporan la responsabilidad recurrente de verificación trilateral.
- El índice de tareas provisionales de Gobernanza identifica GOV-TASK-011 como DTC.
- El objeto EP en `docs/metacanon-objetos-20261011` recibe un addendum que denomina DTC la dinámica y precisa que Gobernanza verifica, mientras EP ejecuta/evidencia su propia compuerta.
- El objeto de coordinación del sprint OCP MCP en `main` recibe el addendum equivalente.

## Estado al constituir la DTC

- Gobernanza: la responsabilidad de verificación quedó incorporada documentalmente en su OCP y GOV-TASK-011. La comprobación recurrente comenzará en cada ciclo posterior.
- EP: el objeto de comunicación contiene el addendum DTC y se leyó de vuelta. Respuesta inicial, instalación de compuerta propia y prueba de ciclo: PENDIENTES.
- OCP MCP: el objeto de coordinación contiene el addendum DTC y se leyó de vuelta. Respuesta inicial, instalación de compuerta propia y prueba de ciclo: PENDIENTES.
- No se modificaron controles de responsabilidad de EP u OCP MCP, sus hosts o código, DUG, GOW, IPZ nativa ni FOL1.

## Referencias

- [Tarea GOV-TASK-011 — DTC](https://github.com/SeryMente/metodologia/blob/main/frentes/gobernanza/%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-011%20-%20Coordinaci%C3%B3n%20bilateral%20recurrente/README.md)
- [DTC / comunicación EP](https://github.com/SeryMente/metodologia/blob/docs/metacanon-objetos-20261011/frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md)
- [DTC / coordinación OCP MCP](../../mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md)
- [Núcleo Gobernanza](../GOBERNANZA.md) · [Pendientes](../PENDIENTES.md)

---

## Auditoría de integridad y eficacia · 2026-10-31

La DTC queda reducida a una regla repetible: **una entrada por ciclo en el objeto de comunicación existente**. Apertura: ciclo + cursor (rama/revisión/blob) + respuesta inicial o `SIN_NOVEDAD`. Cierre: delta o `SIN_NOVEDAD`, tareas/estados, bloqueos, siguiente acción y evidencia. Después, read-back. Si falta cualquiera de esos tramos, el ciclo no se declara completo. No se crean canales, bitácoras ni estados paralelos.

**Resultado observado en este ciclo:**

- **Gobernanza — `CUMPLE_VERIFICADO`:** preflight, lectura de los dos objetos y registros de tareas, actualización de la DTC propia, persistencia y read-back de los artefactos de Gobernanza.
- **EP — `CUMPLE_PARCIAL`:** OEP `main` v0.3.20 / VCU-EP-v22 (blob `217218c48d79818451cd2cdc1cce98a94a6f122d`) y registro provisional `main` (blob `934000b93de7e933d893c0055cabc4647dea57be`) contienen compuertas. El objeto de comunicación está solo en `docs/metacanon-objetos-20261011` (nuevo blob `aeb7cd06c230c165e3d8892ba0572904a898806f`); la ruta equivalente en `main` devuelve NOT_FOUND. El addendum DTC aún no tiene respuesta específica. Reconciliación requerida por EP.
- **MCP-OCP — `CUMPLE_PARCIAL`:** control `owned`, generación 3; núcleo `main` (blob `c823be24d4759d2a9795ed68350974b53810c68b`) con registro §8.1 y compuerta §10.1; respuesta inicial DTC en §19. Su objeto `main` tiene el nuevo blob `2780c4f1ac246e63c44dc08db1931a86234ea3e5`; el cierre/read-back del ciclo de §19 sigue pendiente.

**Automatización:** semiautomática por cursor y compuerta obligatoria. No se verificó un mecanismo de escritura automática ni vigilancia continua entre ciclos; no se declara automatización plena.

**Límites:** no se modificaron DUG, GOW, IPZ nativa, ART-025/027, controles EP/OCP, host ni código. FOL1 continúa preparado e inactivo.

---

## Revalidación DTC · actualización de cursores y estados

La revisión posterior encontró que la fotografía anterior estaba desactualizada para MCP-OCP: el frente persistió el procesamiento y cierre de su ciclo en §20 y marcó `VERIFICADO_READBACK`. El objeto vigente en `main` es blob `f05cd5762b5f0366714096d6de8c435581dcadd8`; por tanto MCP-OCP queda `CUMPLE_VERIFICADO` para ese ciclo local. Su núcleo vigente, blob `cd73b8d141dd401360d6736b859140876ba96738`, aún contiene texto previo que dice que el cierre §20 está pendiente; requiere reconciliación por MCP-OCP.

EP sí tiene compuerta en OEP §90 (blob `217218c48d79818451cd2cdc1cce98a94a6f122d`) e índice de tareas en `main` (blob `934000b93de7e933d893c0055cabc4647dea57be`). El mensaje bilateral original en su objeto de rama documental incluye respuesta, procesamiento y read-back. Sin embargo, el objeto no existe en `main` y el addendum DTC carece de respuesta específica. Estado `CUMPLE_PARCIAL`; reconciliación y acuse corresponden a EP.

La persistencia ante hilo nuevo queda exigida por el cursor del objeto: preflight → leer el último cursor → abrir entrada en el mismo objeto → procesar → completar cierre → read-back. Reanudar trabajo en hilo nuevo inicia un ciclo nuevo, no una historia nueva. No se crea un segundo canal. La automatización sigue semiautomática; no se verificó un disparador capaz de forzar escrituras ni vigilancia entre ciclos.

No se modificaron objetos, controles, núcleo ni host de EP/MCP-OCP; esta revalidación corrige únicamente la documentación de Gobernanza.