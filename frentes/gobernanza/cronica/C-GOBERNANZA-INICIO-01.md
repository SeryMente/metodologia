# Crónica · C-GOBERNANZA-INICIO-01

**Fecha local:** 2026-10-28 (America/Mexico_City).  
**Folio del ciclo:** `C-20261028-4B81D65C`. La unicidad se comprobó dentro del alcance accesible; no se afirma unicidad global.  
**Frente nuevo:** Gobernanza.  
**OCP nuevo:** `frentes/gobernanza/`.  
**Frente preservado:** Metacanon, `frentes/metacanon/`, generación 5, sesión `SES-20261028-8D7A31C2`.  
**Fuente normativa adquirida:** `SeryMente/metodologia/main`, `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, título **Gobernanza única Samantha v345**, blob SHA `4d4d4f7077d58ed48d12bc856bc81ec414fe8733`.

## Instrucciones del operador

El operador primero pidió renombrar el frente existente a Gobernanza. Después corrigió expresamente la instrucción: conservar el nombre del frente Metacanon e inaugurar un frente independiente Gobernanza para trabajar, por ahora, sobre el documento único de gobernanza. Se conserva el dictado íntegro en [el diálogo JSONL](../conversaciones/C-GOBERNANZA-INICIO-01-dialogo.jsonl).

## Corrección de estado

Una escritura inicial incorrecta cambió temporalmente el campo `front` del control de Metacanon a `gobernanza` (commit `60aca686c427422d06ee8287664a69def127d5a2`). Tras la corrección del operador, el control se devolvió a `front: metacanon`, conservando la titularidad M27, generación 5, el historial del cambio y su corrección. El cambio correctivo se publicó en el commit `bd7fa3a1f6ab5285c44018c72a3b02cb4553bb0b`; lectura de vuelta del control: blob `0eaf612b01de0ae630b7a4775849be455ebda6c8`. No se movió ni renombró ninguna ruta del OCP de Metacanon.

## Apertura del frente separado

Se creó `frentes/gobernanza/` y se le asignó un control autoritativo propio:
- Evento: `C-GOBERNANZA-INICIO-01`.
- Ciclo: `C-20261028-4B81D65C`.
- Sesión operativa: `SES-20261028-3F2B7A91`, generación 1.
- Alias: `chatgpt-C-GOBERNANZA-INICIO-01-SES-20261028-3F2B7A91` (no es un ID nativo de conversación).
- Control leído de vuelta: blob `826574e7cf1d346960e0a48f33bb396588f307e2`.
- Núcleo operativo leído de vuelta: blob `229199c7566318fcd9cfe3ddffda5c2aa7c8766f`.
- README leído de vuelta: blob `ef9bdf72ee12d4bf5e9facddba4fb0957161e3b0`.
- Pendientes leídos de vuelta: blob `8a8f16fbd77fdb8f4503627544612a7635a42bb7`.
- Diálogo literal leído de vuelta: blob `8fd3ff8e314aadede2913380ac4c15084d5fc4ba`.

Las búsquedas exactas de evento, ciclo y folio devolvieron cero antes de asignar. El árbol recursivo de `main` no mostraba previamente la ruta `frentes/gobernanza/`.

## Estado técnico observado

El documento único canónico v345 no se modificó en este ciclo. La extracción del bloque `gov-data` falla en `JSON.parse` con un carácter de control en el interior de un literal de cadena; el contexto incluye una secuencia `<script>` y código del renderizador dentro del contenido asociado a `ART-013`. No se certifica la causa raíz completa ni una reparación. Los cuatro bloques JavaScript aislados evaluados con `new Function` pasaron sintaxis, pero no se comprobó renderizado real en navegador.

`ART-012` ya existe para la matriz de persistencia y `ART-013` ya existe para el comando RDC Cyber. El número del nuevo anexo RDC está pendiente: no se duplicaron IDs ni se modificó el HTML. La escritura nativa del campo IPZ no está disponible entre las herramientas de configuración expuestas; la instalación debe seguir declarada pendiente hasta lectura de vuelta real.

## Límites de ejecución

No se ejecutaron ni consultaron GitHub Actions/workflows. No se activó MCP normativo. El dispositivo exacto `PC-8`, ID `364d99aa-c0c7-480a-91ef-8cccae02c6c2`, apareció Online en la lista de dispositivos RDC, pero no se operó el equipo ni se ejecutó el comando de handoff. La comprobación de enlaces v345 sigue pendiente.

## Continuidad

La siguiente acción es analizar y reparar el bloque de datos del HTML con comparación frente a v344, preservando contenido y resolviendo primero la colisión de anexos antes de añadir el handoff RDC. Después se actualizan solo los índices y enlaces autorizados, se valida la integridad, y se prepara el texto IPZ sin afirmar instalación nativa.
