# 📝 GOV-TASK-008 · Aislamiento de la capa desarrollada detrás de Sink

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-008`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Diseñar y probar una arquitectura en la que el modelo reciba como vista inicial únicamente el ID, nombre canónico y MDP, y recupere la norma desarrollada individualmente por la ruta Sink, sin publicar el repositorio ni duplicar la fuente normativa.

## Referencia de origen

DUG v371 · ART-027 · secciones 1, 3, 4 y 7; instrucción del operador en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límite observado

El DUG actual conserva los textos desarrollados dentro del mismo HTML y de su proyección `gov-data`. El alias Sink previsto redirige a ese mismo archivo con el fragmento Pxxx; la obligación de consulta Sink es normativa/procedimental, pero no constituye por sí sola una barrera técnica que impida abrir el archivo completo por otra vía.

No publicar `SeryMente/metodologia`, no duplicar silenciosamente los textos y no alterar la autoridad canónica sin una decisión de arquitectura y las autorizaciones aplicables.

## Siguiente actuación

Evaluar una separación de la vista modelo-facing MDP y un resolvedor privado/autenticado que devuelva solo el principio solicitado, o una extracción por principio equivalente que preserve la fuente canónica y la trazabilidad de versión. Probar que el flujo habitual no presenta los 43 textos desarrollados en el primer acceso.

## Criterio de cierre

La capa de inicio expone únicamente ID/nombre/MDP; la apertura del alias recupera solo el texto desarrollado del principio correspondiente; el DUG sigue siendo la fuente canónica; GitHub permanece privado; y la lectura de vuelta verifica ID, versión y contenido.
