# 📝 Registro de tareas provisionales del frente Gobernanza

**Estado:** materialización operativa provisional; no constituye el ámbito funcional Tareas ni lo canoniza.  
**Contenedor:** `frentes/gobernanza/📁 🧭 - Tareas provisionales/`  
**OCP padre y fuente de responsabilidad:** `frentes/gobernanza/`  
**Control heredado:** [CONTROL-RESPONSABILIDAD.json](../CONTROL-RESPONSABILIDAD.json), titular de Gobernanza, generación 9; blob leído de vuelta `7e88662aefce286682e13fef9165757ea2d68908`.
**Evento de creación:** C-GOBERNANZA-MDP-OCP-01 · 2026-10-30.  
**Fuente normativa vigente:** [DUG v373 · NX-373m](../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html). La arquitectura MDP se originó en v371 y se leyó de vuelta en v373.

## Naturaleza y límites

Este contenedor agrupa once objetos provisionales de persistencia de tarea, cada uno con su directorio y núcleo propio. No son frentes independientes ni unidades de una taxonomía ya aprobada. La responsabilidad, sesión y autorización se heredan del OCP padre; no se crean controles, sesiones ni folios independientes para cada tarea.

El núcleo de cada objeto conserva identificador local, enunciado, referencia recuperable al origen y estado. El patrón se inspira en el diseño mínimo de Tareas v0.2, pero no declara ratificado ese estándar ni adopta como vigente el candidato v1.0. Cada ID `GOV-TASK-###` es estable dentro de este registro; no se afirma unicidad global.

**Separación respecto del ámbito Tareas:** el directorio existente `ambitos/tareas/` sigue en incubación y no está canonizado en el DUG. Su control conserva como titular `chatgpt-C-TAREAS-INICIO-01-SES-20261028-TA6F31C9`, generación 1. No se ha transferido ni modificado. GOV-TASK-004 registra la continuación pendiente cuando se resuelva esa titularidad. GOV-TASK-008 registra la necesidad de aislar técnicamente la norma desarrollada detrás de Sink, pues el DUG actual aún contiene todo el texto en `gov-data`.

## Registro ejecutivo

| ID local | Estado | Tarea | Núcleo |
|---|---|---|---|
| GOV-TASK-001 | en_curso | Validación de microdescriptores de pertinencia | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-001%20-%20Validaci%C3%B3n%20de%20MDP/README.md) |
| GOV-TASK-002 | cancelada | Despliegue Sink/Cloudflare (antecedente supersedido) | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-002%20-%20Despliegue%20Sink%20y%20frecuencia/README.md) |
| GOV-TASK-003 | pendiente | Prueba E2E de OCP MCP/Sync | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-003%20-%20Consulta%20privada%20E2E/README.md) |
| GOV-TASK-004 | pendiente | Concluir la incubación y decidir el ámbito Tareas | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-004%20-%20Incubaci%C3%B3n%20del%20%C3%A1mbito%20Tareas/README.md) |
| GOV-TASK-005 | pendiente | Resolver referencias incompletas P020/P021/P033/P034 | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-005%20-%20Integridad%20de%20principios/README.md) |
| GOV-TASK-006 | en_curso | Reconciliar divergencias documentales de Gobernanza | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-006%20-%20Reconciliaci%C3%B3n%20documental/README.md) |
| GOV-TASK-007 | en_curso | Reconciliar IPZ y cerrar el corte FOL1 | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md) |
| GOV-TASK-008 | en_curso | Catálogo, selección y recuperación individual mediante OCP MCP/Sync | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-008%20-%20Aislamiento%20de%20capa%20desarrollada/README.md) |
| GOV-TASK-009 | en_curso | Revisar el GOW y mantener visible su vocabulario inicial esencial | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-009%20-%20Revisi%C3%B3n%20del%20glosario%20operativo/README.md) |
| GOV-TASK-010 | en_curso | Admisión obligatoria y titularidad exclusiva de conversaciones | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-010%20-%20Admisión%20y%20titularidad%20de%20conversaciones/README.md) |
| GOV-TASK-011 | en_curso | Coordinación bilateral recurrente con EP y OCP MCP | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20GOV-TASK-011%20-%20Coordinación%20bilateral%20recurrente/README.md) |

## Estado histórico de continuidad · 2026-10-30

GOV-TASK-001, GOV-TASK-006, GOV-TASK-007 y GOV-TASK-008 se encuentran `en_curso`; GOV-TASK-002/003/004/005 permanecen `pendiente`. El cambio de estado no crea controles, sesiones ni folios propios. La discrepancia GOW 2.12/2.14 y la falta de acceso Cloudflare están registradas en [Pendientes](../PENDIENTES.md).

## Regla de mantenimiento

1. Cada tarea conserva enunciado fiel, referencia al origen y estado observado.
2. Se usan provisionalmente `pendiente`, `en_curso`, `completada` y `cancelada`.
3. No se añaden prioridad, fechas límite, responsables o dependencias como campos universales por anticipación.
4. La responsabilidad de cada objeto hereda el control del OCP Gobernanza; no se crean sesiones independientes.
5. La existencia de estos registros no autoriza canonizar Tareas, modificar `ambitos/tareas/` ni crear integraciones externas.
6. El cierre de una tarea exige atender su enunciado y recuperar evidencia de la fuente canónica pertinente.
7. GOV-TASK-011 es una tarea recurrente: en cada ciclo leer el registro de tareas y el objeto bilateral de EP y OCP MCP, dejar mensaje o SIN_NOVEDAD en ambos y verificar respuestas/read-back sin inferir recepción.

## Referencias

- [DUG v373 · ART-027](../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027)
- [Núcleo Gobernanza](../GOBERNANZA.md)
- [Pendientes Gobernanza](../PENDIENTES.md)
- [Crónica de creación](../cronica/C-GOBERNANZA-MDP-OCP-01.md)
- [Evidencia](../evidencias/C-GOBERNANZA-MDP-OCP-01.json)


## Reorientación del objetivo · 2026-10-31

Objetivo rector: primera versión funcional de Gobernanza integrada con IPZ y OCP MCP. El IPZ tendrá un máximo de 1.500 caracteres y dos referencias Sync acortadas, en este orden: GOW/§ARR y DUG. Después reforzará la admisión obligatoria: no iniciar trabajo sustantivo sin frente explícitamente asignado y titularidad/exclusividad verificadas por el protocolo vigente.

Cada ciclo —no cada conversación— se identifica con su folio global. El modelo consulta en OCP MCP el inventario de 43 principios, considera todos, selecciona los pertinentes y comunica la selección. Los principios se nombran con el patrón «Principio DI · [denominación atómica de 1–3 términos]». El MDP permite reconocer significado y pertinencia, pero no aplicar la norma completa. OCP MCP entrega enlaces Sync individuales a las versiones desarrolladas; cada acceso alimenta telemetría de frecuencia. El modelo verifica suficiencia y solicita principios adicionales cuando sea necesario. OCP MCP genera el hash del paquete de enlaces y el modelo lo incluye en la salida del ciclo.

### Reorientación de los objetos existentes

- GOV-TASK-001: conservar; validar semánticamente los 43 MDP.
- GOV-TASK-002: diseño histórico Sink/Cloudflare en revisión; no desplegar por inercia. Reconciliar con enlaces Sync y OCP MCP.
- GOV-TASK-003: redefinir su E2E como consulta individual privada mediante OCP MCP/Sync.
- GOV-TASK-004: diferir; el ámbito Tareas no bloquea el MVP y tiene titularidad separada.
- GOV-TASK-005: mantenimiento diferido; no reconstruir referencias por inferencia.
- GOV-TASK-006: ampliar a reconciliación documental y resolución de elementos satélite para Gobernanza 1.0.
- GOV-TASK-007: prioridad crítica; IPZ de dos referencias más compuerta de admisión, límite 1.500 caracteres, instalación verificable y FOL1 posterior.
- GOV-TASK-008: mantener el aislamiento de la norma desarrollada, alineado con OCP MCP; un ancla del HTML no equivale a entrega individual.
- GOV-TASK-009: conservar y priorizar §ARR/GOW como primera referencia del IPZ.
- GOV-TASK-010: nueva tarea de admisión y titularidad exclusiva.

Gobernanza define el contrato normativo y los criterios de aceptación; OCP MCP implementa capacidades del servidor dentro de su propio OCP/control; EP administra entorno, instalación, RDC y persistencia. No se transfieren responsabilidades entre frentes por inferencia.

La telemetría aprobada aquí mide frecuencia de acceso, no aplicación, y no autoriza descartar principios automáticamente. El hash debe corresponder al paquete exacto emitido. El folio de ciclo es el identificador contextual exigido, pero OCP MCP debe verificar su vínculo con la sesión autorizada; no se presume que un folio predecible sea por sí solo una credencial criptográfica.

El cierre del frente exige IPZ instalado y verificado, admisión efectiva, protocolo de ciclo operativo, consulta/selección/Sync/telemetría/hash E2E y resolución de satélites del DUG para 1.0.


## Estado rector vigente · C-GOBERNANZA-VECTOR-SEMANTICO-01 · 2026-10-31

El registro queda actualizado a once objetos provisionales. GOV-TASK-011 exige leer y responder la comunicación EP/OCP al inicio de cada ciclo y documentar las novedades al cierre; los dos objetos bilaterales están publicados con respuesta pendiente. GOV-TASK-010 ya existe y se incorpora al índice; no se crea tarea duplicada. GOV-TASK-009 pasa a `en_curso` por su dependencia directa con el primer enlace IPZ (§ARR/GOW). GOV-TASK-002 queda `cancelada` como despliegue Sink/Cloudflare activo, preservado únicamente como antecedente; GOV-TASK-003 continúa pendiente como aceptación E2E de OCP MCP/Sync. Las tareas 004 y 005 siguen diferidas. La responsabilidad de las once tareas continúa heredada del OCP Gobernanza, generación 9; ninguna tiene control ni folio propio.

Fuente rectora: [dictado](../conversaciones/C-GOBERNANZA-VECTOR-SEMANTICO-01-dialogo.jsonl) · [crónica](../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md) · [evidencia](../evidencias/C-GOBERNANZA-VECTOR-SEMANTICO-01.json).
