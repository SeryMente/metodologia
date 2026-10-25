# C-MCP-JULES-002 · implementación candidata del MVP

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-4A91D70C.  
**Folio de sesión / control del frente:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** `frentes/mcp-jules/`.  
**Rama documental:** `feat/ft-mcp-jules-20261025`.  
**Rama de implementación:** `SeryMente/khora:feat/mcp-jules-tools-20261025`.

## Objetivo

Materializar las herramientas de interacción con Jules acordadas en el ciclo de creación, integrar los scopes aislados al servidor MCP actual y preparar replicación de la interfaz común en los demás frentes. No crear un segundo servidor ni alterar la titularidad del frente Metacanon padre.

## Implementación candidata registrada

En la rama de implementación se editaron los archivos siguientes:

- `khora-web/lib/jules/client.ts`: tipado de creación de sesión con prompt; paginación de fuentes/actividades; normalización de IDs de sesión; envío de mensaje y aprobación de plan usando la API existente.
- `khora-web/app/api/mcp/route.ts`: siete herramientas `jules_*` registradas en el servidor único; comprobación de `jules:read`/`jules:write`; ciclo normativo existente conservado; creación de sesión fuerza `requirePlanApproval=true`; errores externos saneados, sin devolver el cuerpo privado del proveedor.
- `khora-web/lib/server/mcp-tool-contract.ts`: permisos por herramienta; cuatro herramientas de lectura y tres de escritura.
- `khora-web/lib/server/mcp-manual-token.ts`, `khora-web/lib/server/mcp-config.ts`, las rutas OAuth y la pantalla Control MCP: los dos nuevos scopes están disponibles explícitamente; no están seleccionados por defecto al emitir token manual.
- `khora-web/docs/normative-check.md`: catálogo de 24 herramientas, permisos y límites de automatización.
- Fixtures y pruebas de contrato, metadatos OAuth y tokens manuales: actualizados para el catálogo ampliado y control de privilegio mínimo.

Herramientas nuevas: `jules_list_sources`, `jules_list_sessions`, `jules_get_session`, `jules_list_activities`, `jules_create_session`, `jules_send_message`, `jules_approve_plan`.

Se verificó por lectura de archivos en la rama que el catálogo MCP y la tabla documental incluyen 24 herramientas, y que las pruebas referencian el total esperado. Esto es una comprobación estática de contenido, **no** ejecución de las pruebas.

## Evidencia disponible

- Fuentes: main de Khora anterior al cambio, rama creada para el trabajo.
- Lectura de vuelta: cada edición por GitHub devolvió SHA de contenido/commit; las lecturas posteriores confirmaron los cambios clave en código y pruebas.
- Versión de servidor MCP anunciada en la rama: 1.4.0.
- Pruebas automáticas: **NO EJECUTADAS** desde un entorno de código en este ciclo. CI no se atribuye hasta que una ejecución real informe resultado.
- Acceso a Jules: **NO VERIFICADO**. La variable `JULES_API_KEY` no se leyó ni se reveló.
- Despliegue: **NO VERIFICADO**.
- Conexión desde ChatGPT y operación con una cuenta real: **NO VERIFICADAS**.
- Merge a `main`: **NO REALIZADO**.

## Seguridad y límites

Las herramientas de escritura tienen scope `jules:write` y se registran separadas de lectura; toda herramienta sustantiva sigue exigiendo el ciclo normativo de Khora. La herramienta de creación no acepta un parámetro que desactive la aprobación del plan. El envío de mensaje no se presenta como respuesta final del agente. No hay trabajador de sondeo continuo en esta rama; el seguimiento persistente requiere infraestructura externa con cursor durable, deduplicación y mecanismo de parada.

No se modificó la fuente canónica Samantha/Metacanon/GOW ni el control del OCP padre. La guía de replicación se guarda en `replicacion/GUIA-REPLICACION-FRENTES.md` y referencia el servidor central, sin duplicar claves, servicios ni controles.

## Siguiente paso y condición de cierre

1. Abrir PR de implementación para activar las verificaciones CI disponibles.
2. Corregir los fallos reales que reporten las pruebas; no sustituir output de CI por inspección estática.
3. Abrir PR documental para el OCP y el inventario, leer de vuelta sus checks y mantener separados los estados de merge y despliegue.
4. Con credencial ya configurada por el operador en el entorno de servidor autorizado, probar listar fuentes, crear sesión con plan pendiente, consultar actividades, aprobar el plan revisado, enviar respuesta y volver a consultar actividades.
5. Solo después del resultado real de esa secuencia, declarar el MVP remoto utilizable. El sondeo periódico sigue siendo una extensión distinta y opcional.

