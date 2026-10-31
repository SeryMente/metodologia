# C-GOBERNANZA-MDP-OCP-01 · Microdescriptores de pertinencia y OCP provisionales

**Fecha:** 2026-10-30. **Estado:** diseño MDP y siete objetos provisionales de tarea materializados.

## Autorización y control

El operador autorizó redefinir ART-027: inventario compuesto por el nombre canónico y un microdescriptor de pertinencia (MDP) deliberadamente insuficiente para aplicar íntegramente el principio; consulta obligatoria de la norma desarrollada mediante Sink antes de aplicar todo principio pertinente; telemetría limitada a frecuencia de consulta. También autorizó crear objetos de persistencia provisionales para las tareas pendientes de Gobernanza, sin canonizar el ámbito Tareas.

La autorización se registró y leyó de vuelta en `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`. Blob SHA leído de vuelta: `f670960bdedf1a4747743b3216cd181722a924ec`. Titular: `chatgpt-C-GOBERNANZA-RETOMA-05-SES-20261030-GV89CFA5D5`, generación 6.

El OCP separado `ambitos/tareas/` conserva otro titular: `chatgpt-C-TAREAS-INICIO-01-SES-20261028-TA6F31C9`, generación 1, estado `owned`. No fue modificado ni transferido. La tarea correspondiente queda registrada como pendiente.

## Cambio canónico

- DUG: **v371 · NX-371m**.
- Commit: `ead12e9441d66656763c1ca5d6c8641f63da3d7a`.
- Blob SHA leído de vuelta: `0412dc9d0ff10d74f69761b0f3307c84b3c586c2`.
- 43 principios; 20 anexos; ART-027 actualizado.
- 43 MDP en el inventario humano y 43 campos `principles[].microdescriptor` en la proyección estructurada.
- Rango verificado: 11–16 palabras por MDP.
- Se preservaron los textos normativos originales de los 43 principios y ART-025.

## Diseño de MDP y uso de las dos capas

Cada MDP contiene significado general y señal contextual de activación. Omite pasos, excepciones, umbrales y detalles suficientes para ejecutar la regla. Cuando el MDP indique pertinencia, el modelo debe abrir el alias Sink y consultar el principio desarrollado vigente antes de aplicarlo. La memoria del modelo, lecturas históricas o el propio MDP no sustituyen esa consulta. Si no puede consultar la versión desarrollada, debe declarar el bloqueo y no aplicar la norma solo desde el MDP.

La telemetría queda limitada a frecuencia de accesos por alias y periodo. No se mide ni registra aplicación, cumplimiento, selección o consideración por ciclo; ART-024 no se amplió para tal fin.

## OCP provisionales de tarea

Se creó el contenedor `frentes/gobernanza/📁 🧭 - Tareas provisionales/` dentro del OCP Gobernanza. Contiene ocho directorios, cada uno con un README núcleo y su enunciado, origen, estado inicial `pendiente`, dependencias y siguiente actuación. Los objetos heredan titularidad y control del OCP padre; no tienen controles, sesiones ni folios independientes.

| ID | Tarea |
|---|---|
| GOV-TASK-001 | Validación de microdescriptores de pertinencia |
| GOV-TASK-002 | Despliegue de Sink y telemetría de frecuencia |
| GOV-TASK-003 | Prueba de consulta privada Sink → GitHub |
| GOV-TASK-004 | Concluir la incubación y decidir el ámbito Tareas |
| GOV-TASK-005 | Resolver referencias incompletas en principios |
| GOV-TASK-006 | Reconciliar divergencias documentales de Gobernanza |
| GOV-TASK-007 | Reconciliar IPZ y cerrar el corte FOL1 |

La materialización es provisional y local a Gobernanza; no declara una entidad taxonómica nueva. Se inspira en el mínimo de tarea en incubación, pero no canoniza su estándar v0.2 ni el candidato v1.0.

## Pendientes y límites

- Sink no está desplegado; no hay aliases activos ni telemetría real.
- Cloudflare, D1/KV, API y pruebas E2E siguen pendientes.
- La lectura privada Sink→GitHub está diseñada pero no probada de extremo a extremo.
- El ámbito Tareas sigue en incubación y no canonizado; su OCP se dejó intacto.
- Las referencias incompletas de P020/P021/P033/P034 siguen pendientes de evidencia y autorización normativa.
- IPZ/FOL1 sigue pendiente; FOL1 está `PREPARADO_PENDIENTE_ACTIVACION_IPZ`.
- ART-025 y el campo nativo IPZ no se modificaron.

## Verificación

Se releyó el DUG v371 y se parseó `gov-data`; se verificaron 43 MDP humanos y estructurados, longitud de 11–16 palabras y exclusión de telemetría de aplicación. Se releyeron los núcleos de los ocho OCP provisionales y el índice de colección. Los archivos de entrada del frente se actualizaron y leyeron de vuelta. No se declara desplegada infraestructura externa.
