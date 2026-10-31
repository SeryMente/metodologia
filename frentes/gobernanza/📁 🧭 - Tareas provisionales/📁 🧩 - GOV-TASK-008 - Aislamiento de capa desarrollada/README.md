# 📝 GOV-TASK-008 · Catálogo, selección y recuperación individual mediante OCP MCP/Sync

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-008`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Definir y aceptar la semántica de dos capas del flujo OCP MCP: inventario inicial de los 43 principios con ID, nombre de vista `Principio DI · [1–3 términos]` y MDP acotado; selección de los pertinentes por ciclo; enlace Sync individual al texto desarrollado; telemetría de frecuencia por enlace; evaluación de suficiencia y reconsulta de principios adicionales; y hash del paquete exacto de URLs. Mantener el DUG como fuente normativa única y no exponer los 43 textos desarrollados en el inventario inicial.

## Referencia de origen

DUG v373 · ART-027 · secciones 1, 3, 4 y 7; estrategia originada en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límite observado

El DUG actual conserva los textos desarrollados dentro del mismo HTML y de su proyección `gov-data`. El alias Sink previsto redirige a ese mismo archivo con el fragmento Pxxx; la obligación de consulta Sink es normativa/procedimental, pero no constituye por sí sola una barrera técnica que impida abrir el archivo completo por otra vía.

No publicar `SeryMente/metodologia`, no duplicar silenciosamente los textos y no alterar la autoridad canónica sin una decisión de arquitectura y las autorizaciones aplicables.

## Siguiente actuación

Cotejar el código y release 0.1.0 con cada etapa del vector rector; especificar exclusivamente las brechas restantes para OCP MCP. Separar los requisitos de aceptación de Gobernanza de la implementación del servidor y de la instalación/host que corresponde a EP. No desplegar Sink por inercia.

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


## Revisión de alcance · instrucción del operador · 2026-10-31

El requisito de aislamiento se mantiene, pero el diseño de entrega debe coordinarse con OCP MCP y no presuponer Sink/Cloudflare. El modelo recibe el inventario acotado de 43 principios, comunica cuáles aplican al ciclo y obtiene mediante OCP MCP enlaces Sync individuales a las versiones desarrolladas. Cada enlace debe resolver un único principio y conservar versión/firma/SHA de la fuente; no debe exponer los 43 textos desarrollados en la respuesta inicial.

El MDP debe permitir comprender el significado y reconocer pertinencia, pero no sustituir la lectura del principio completo. La fuente normativa sigue siendo el DUG único; cualquier proyección o extracción es derivada, verificable y no adquiere autoridad independiente. La telemetría de esta tarea se limita a frecuencia de acceso.


## Brecha del producto OCP MCP 0.1.0 · verificación documental · 2026-10-31

Las propuestas Worker/Sink/Cloudflare descritas en las secciones precedentes son antecedentes de diseño. Quedan supersedidas como camino de implementación del MVP actual por el requisito Sync servido por OCP MCP; no constituyen autorización de despliegue ni decisión de reactivar Sink.

La rama `build/ocp-mcp-mvp-0.1.0` acredita código persistido, 31 pruebas unitarias y 29 de integración aprobadas; el recibo declara `BUILT_AND_TESTED_NOT_INSTALLED`. Por ello no afirmar instalación ni aceptación E2E. El producto contiene cifrado de fuentes/snapshots AES-256-GCM con DPAPI CurrentUser, importación con commit/blob/SHA-256 y snapshot transaccional BLOB/SQLite con eventos/recibos.

Brechas frente al vector que deben resolverse en OCP MCP:
1. Los metadatos `applicability`, `activation_conditions`, `mandatory` y `dependencies` faltan; selección/snapshot devuelve `BLOCKED_OCPMSP`.
2. El catálogo ofrece 43 IDs/títulos/MDP, pero aún no la etiqueta visible compacta `Principio DI` ni demuestra el mapeo de una a tres palabras hacia título/ID canónicos.
3. No se observan enlaces Sync individuales a textos desarrollados ni herramienta de ampliación individual.
4. No se demuestra telemetría de frecuencia disparada por apertura de cada enlace Sync individual.
5. `selection_sha256` cubre la lista de IDs seleccionados; no demuestra hash del paquete exacto y ordenado de URLs Sync.
6. No se demuestra aceptación del folio global de ciclo y verificación de su vínculo con la sesión autorizada.
7. El manifiesto inicial observado contiene DUG y núcleo OCP, no §ARR/GOW; la frescura frente a `main` figura `NOT_CHECKED_AGAINST_MAIN`.

El código/resolución del servidor corresponde a OCP MCP dentro de su autorización; instalación/host y lectura de vuelta corresponden a EP. Gobernanza define el contrato y verifica aceptación. No abrir una nueva solicitud OCP mientras siga sin recibirse y analizarse la última respuesta registrada en el protocolo bilateral. No reinstalar Sink/Cloudflare por inercia. Trazabilidad: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).
