# 📝 Registro de tareas provisionales del frente Gobernanza

**Estado:** materialización operativa provisional; no constituye el ámbito funcional Tareas ni lo canoniza.  
**Contenedor:** `frentes/gobernanza/📁 🧭 - Tareas provisionales/`  
**OCP padre y fuente de responsabilidad:** `frentes/gobernanza/`  
**Control heredado:** [CONTROL-RESPONSABILIDAD.json](../CONTROL-RESPONSABILIDAD.json), titular de Gobernanza, generación 6.  
**Evento de creación:** C-GOBERNANZA-MDP-OCP-01 · 2026-10-30.  
**Fuente normativa:** [DUG v371 · NX-371m](../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html).

## Naturaleza y límites

Este contenedor agrupa ocho objetos provisionales de persistencia de tarea, cada uno con su directorio y núcleo propio. No son frentes independientes ni unidades de una taxonomía ya aprobada. La responsabilidad, sesión y autorización se heredan del OCP padre; no se crean controles, sesiones ni folios independientes para cada tarea.

El núcleo de cada objeto conserva identificador local, enunciado, referencia recuperable al origen y estado. El patrón se inspira en el diseño mínimo de Tareas v0.2, pero no declara ratificado ese estándar ni adopta como vigente el candidato v1.0. Cada ID `GOV-TASK-###` es estable dentro de este registro; no se afirma unicidad global.

**Separación respecto del ámbito Tareas:** el directorio existente `ambitos/tareas/` sigue en incubación y no está canonizado en el DUG. Su control conserva como titular `chatgpt-C-TAREAS-INICIO-01-SES-20261028-TA6F31C9`, generación 1. No se ha transferido ni modificado. GOV-TASK-004 registra la continuación pendiente cuando se resuelva esa titularidad. GOV-TASK-008 registra la necesidad de aislar técnicamente la norma desarrollada detrás de Sink, pues el DUG actual aún contiene todo el texto en `gov-data`.

## Registro ejecutivo

| ID local | Estado | Tarea | Núcleo |
|---|---|---|---|
| GOV-TASK-001 | pendiente | Validación de microdescriptores de pertinencia | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-001%20-%20Validaci%C3%B3n%20de%20MDP/README.md) |
| GOV-TASK-002 | pendiente | Despliegue de Sink y telemetría de frecuencia | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-002%20-%20Despliegue%20Sink%20y%20frecuencia/README.md) |
| GOV-TASK-003 | pendiente | Prueba de consulta privada Sink → GitHub | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-003%20-%20Consulta%20privada%20E2E/README.md) |
| GOV-TASK-004 | pendiente | Concluir la incubación y decidir el ámbito Tareas | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-004%20-%20Incubaci%C3%B3n%20del%20%C3%A1mbito%20Tareas/README.md) |
| GOV-TASK-005 | pendiente | Resolver referencias incompletas P020/P021/P033/P034 | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-005%20-%20Integridad%20de%20principios/README.md) |
| GOV-TASK-006 | pendiente | Reconciliar divergencias documentales de Gobernanza | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-006%20-%20Reconciliaci%C3%B3n%20documental/README.md) |
| GOV-TASK-007 | pendiente | Reconciliar IPZ y cerrar el corte FOL1 | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md) |
| GOV-TASK-008 | pendiente | Aislar técnicamente la norma desarrollada detrás de Sink | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-008%20-%20Aislamiento%20de%20capa%20desarrollada/README.md) |

## Regla de mantenimiento

1. Cada tarea conserva enunciado fiel, referencia al origen y estado observado.
2. Se usan provisionalmente `pendiente`, `en_curso`, `completada` y `cancelada`.
3. No se añaden prioridad, fechas límite, responsables o dependencias como campos universales por anticipación.
4. La responsabilidad de cada objeto hereda el control del OCP Gobernanza; no se crean sesiones independientes.
5. La existencia de estos registros no autoriza canonizar Tareas, modificar `ambitos/tareas/` ni crear integraciones externas.
6. El cierre de una tarea exige atender su enunciado y recuperar evidencia de la fuente canónica pertinente.

## Referencias

- [DUG v371 · ART-027](../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027)
- [Núcleo Gobernanza](../GOBERNANZA.md)
- [Pendientes Gobernanza](../PENDIENTES.md)
- [Crónica de creación](../cronica/C-GOBERNANZA-MDP-OCP-01.md)
- [Evidencia](../evidencias/C-GOBERNANZA-MDP-OCP-01.json)
