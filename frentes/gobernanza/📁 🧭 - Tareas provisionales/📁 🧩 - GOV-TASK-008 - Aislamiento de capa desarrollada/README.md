# 📝 GOV-TASK-008 · Aislamiento de la capa desarrollada detrás de Sink

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-008`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Diseñar y probar una arquitectura en la que el modelo reciba como vista inicial únicamente el ID, nombre canónico y MDP, y recupere la norma desarrollada individualmente por la ruta Sink, sin publicar el repositorio ni duplicar la fuente normativa.

## Referencia de origen

DUG v373 · ART-027 · secciones 1, 3, 4 y 7; estrategia originada en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límite observado

El DUG actual conserva los textos desarrollados dentro del mismo HTML y de su proyección `gov-data`. El alias Sink previsto redirige a ese mismo archivo con el fragmento Pxxx; la obligación de consulta Sink es normativa/procedimental, pero no constituye por sí sola una barrera técnica que impida abrir el archivo completo por otra vía.

No publicar `SeryMente/metodologia`, no duplicar silenciosamente los textos y no alterar la autoridad canónica sin una decisión de arquitectura y las autorizaciones aplicables.

## Siguiente actuación

Evaluar una separación de la vista modelo-facing MDP y un resolvedor privado/autenticado que devuelva solo el principio solicitado, o una extracción por principio equivalente que preserve la fuente canónica y la trazabilidad de versión. Probar que el flujo habitual no presenta los 43 textos desarrollados en el primer acceso.

## Evaluación técnica preliminar

### Requisito de aislamiento

El alias no debe redirigir al HTML completo ni a un fragmento del mismo archivo: el documento contiene los 43 textos desarrollados en `gov-data`. La consulta por ancla `#Pxxx` selecciona visualmente un principio, pero no restringe el contenido que el modelo puede recuperar.

### Diseño candidato sin duplicar la fuente normativa

1. **Primera capa:** servir una proyección MDP-only generada desde el DUG vigente. Campos permitidos: `id`, `title`, `microdescriptor`, `dug_version`, `dug_signature` y `source_blob_sha`. Debe excluir `normative_text` y `content_markdown`. La proyección es derivada, nunca autoridad.
2. **Alias individual:** cada `p001`…`p043` resuelve a una ruta de extracción, no a `blob/main/...#Pxxx`.
3. **Resolvedor:** un Worker obtiene el DUG privado con credencial de lectura almacenada exclusivamente como secreto; valida revisión y extrae por ID exactamente un objeto de `principles[]`. Responde solo ese principio junto con versión, firma y SHA del blob fuente. Ante ID inexistente, credencial inválida o fuente no verificable, falla cerrado y no devuelve el conjunto completo.
4. **Telemetría:** contar accesos por alias; no inferir lectura efectiva ni aplicación. Mantener excluidos los contadores de aplicación.

### Bloqueo de autenticación y exposición

- Un Worker público devolvería el principio solicitado individualmente, pero permitiría a cualquier visitante recorrer los 43 aliases. Mantendría privado el repositorio, no el texto de cada principio.
- Un Worker protegido por Cloudflare Access preservaría una barrera de acceso, pero el flujo disponible de apertura no permite adjuntar encabezados de autenticación al resolvedor. El conector GitHub sí autentica, pero al leer el HTML canónico expone el archivo completo y no satisface aislamiento.
- La sesión no dispone de integración Cloudflare; PC-14 está en línea, pero Wrangler no está instalado. No se instalará ni desplegará infraestructura ni se manipularán secretos sin la vía de autorización y acceso correspondiente.
- No crear copias por principio como sustitutos normativos. Si se propone una proyección estática, debe ser regenerable, derivada y cotejada contra el SHA del DUG en cada versión.

### Decisión pendiente

Para completar el flujo hay que escoger un límite de autenticación compatible con el canal que usará el modelo: **(A)** permitir exposición pública individual de cada texto a través de Sink, manteniendo privado el repositorio; o **(B)** proporcionar una integración autenticada capaz de invocar el resolvedor privado con credenciales fuera del prompt y de las URLs. No se considera equivalente redirigir a GitHub privado con ancla.

### Siguiente actuación

Implementar la opción aprobada, después de contar con acceso Cloudflare o con el canal autenticado alternativo; crear un alias piloto y ejecutar pruebas positivas y negativas antes de generar los 43.

## Criterio de cierre

La capa de inicio expone únicamente ID/nombre/MDP; la apertura del alias recupera solo el texto desarrollado del principio correspondiente; el DUG sigue siendo la fuente canónica; GitHub permanece privado; y la lectura de vuelta verifica ID, versión y contenido.
