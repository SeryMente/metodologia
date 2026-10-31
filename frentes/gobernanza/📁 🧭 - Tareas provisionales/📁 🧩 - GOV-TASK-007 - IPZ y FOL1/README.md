# 📝 GOV-TASK-007 · Reconciliar IPZ y cerrar el corte FOL1

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-007`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Preparar una nueva IPZ que conserve las salvaguardas verificadas de v0.7 e integre el estado vigente, comprobar su límite y contenido, y después realizar la instalación observable y el corte FOL1 conforme a sus compuertas.

## Referencia de origen

frentes/gobernanza/PENDIENTES.md; INICIO.md; ART-025; registro maestro FOL1.

## Dependencias y límites

IPZ v0.8 no es sustitución íntegra: tiene 1.488 caracteres, pero omite la lista explícita de estados de autorización/ejecución y parte del contrato de eficiencia temporal presente en v0.7 (2.467 caracteres). FOL1 permanece PREPARADO_PENDIENTE_ACTIVACION_IPZ. No modificar campo nativo sin capacidad observable y read-back.

## Siguiente actuación

Cotejar v0.7 frente a v0.8 y ART-025/ART-027, preparar una versión completa dentro del límite de 1.500 caracteres y verificar su instalación antes de activar FOL1.

## Conciliación efectuada · 2026-10-30

- **v0.7:** 2.467 caracteres; conserva los estados propuesto/autorizado/intentado/ejecutado/verificado/aceptado, A/B literal y trazable, UUIDv7 local distinto del ID nativo, protección de rutas/control, GOW y MCP normativo desactivado, y el contrato temporal detallado.
- **v0.8:** 1.488 caracteres; añade CNP y PAI, pero no mantiene la distinción explícita de los seis estados ni buena parte del detalle de eficiencia de v0.7. No instalar como reemplazo íntegro.
- **v0.9:** borrador conversacional de 1.478 caracteres preparado para revisión. No se guardó como candidato en Git ni se escribió en instrucciones nativas.
- **FOL1:** registro maestro leído de vuelta desde `main`, blob `b93cbef77f2fa1a6e4290ae8177e957a1616e47b`; estado `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, generación 3, 26 OCP conocidos, cero asignaciones, contadores globales en cero y cobertura `KNOWN_INVENTORY_ONLY`.

**Bloqueo de cierre:** la instalación de IPZ exige acceso a la configuración nativa, escritura autorizada y lectura de vuelta observable. FOL1 no se activa antes de comprobar esa instalación y efectuar el corte conforme a sus compuertas. En esta sesión no se ejecutó escritura nativa ni se asignaron folios.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
