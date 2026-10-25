# C-MCP-JULES-001 · creación del frente MCP Jules

**Fecha real del ciclo:** 2026-10-25.  
**Rol:** asistente que documenta e implementa el frente.  
**OCP:** `frentes/mcp-jules/`.  
**Folio:** SES-20261025-6F8A2C9D; generación 1 del control nuevo.  
**Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**Tipo de evidencia:** lectura directa de la rama main mediante el conector GitHub y consulta web de documentación oficial; no ejecución de código ni acceso a credenciales de Jules.

## Objetivo e instrucción

El operador autorizó construir un frente independiente dentro de Metacanon para habilitar comunicación entre ChatGPT y Jules: entrega de prompts, recuperación de solicitudes de retroalimentación, respuestas en la misma sesión y evaluación de automatización replicable para otros frentes. Aprobó ampliar el MCP existente de Khora con scopes `jules:read` y `jules:write`, mantener la credencial en el servidor y forzar aprobación del plan por defecto.

## Lecturas y hallazgos

- Metacanon §46 y §51 prescriben un OCP como carpeta autónoma, un único núcleo operativo y control individual. El nuevo OCP es `frentes/mcp-jules/`; no se altera el control de `frentes/metacanon/`.
- Metacanon main observada: tree SHA `34131d811a63ca7b0450bc05bcca7df89726cc0e`. El control del frente padre tenía titular/folio activo `SES-20261022-5E7C91A4`, generación 4; esta tarea no transfiere esa titularidad.
- Se inspeccionaron árboles de nueve repositorios accesibles y los controles presentes de Metacanon, Acceso, Dictado de voz, Harmonia, Signal Interpreter y Repertorio de canto personal. El candidato SES-20261025-6F8A2C9D no apareció en esos controles. Esto no demuestra unicidad fuera de las fuentes accesibles.
- Khora ya mantiene un adaptador Jules en `khora-web/lib/jules/client.ts` para listar fuentes/sesiones, consultar sesiones/actividades, crear sesión, enviar mensajes y aprobar planes. El disparador existente crea sesiones con `requirePlanApproval: false`; el nuevo MCP debe forzar verdadero, no heredar ese default inseguro.
- Khora ya tiene un único servidor MCP remoto con autenticación, scopes y puerta normativa. Se amplía ese servidor, no se crea un segundo.
- La API oficial Jules `v1alpha` es experimental; expone sesiones, actividades, mensajes, aprobación de plan y fuentes.
- No se encontró un método webhook en el catálogo REST consultado. Automatización continua viable: sondeo programado persistente con checkpoint/deduplicación y reanudación. La conversación de ChatGPT por sí sola no garantiza ejecución en segundo plano.

## Acciones efectuadas

- Se creó la rama documental `feat/ft-mcp-jules-20261025`.
- Se preparó el OCP independiente con núcleo, README, control, investigación, aceptación, prompts y esta crónica.
- La rama de implementación se creó como `feat/mcp-jules-tools-20261025`; la implementación permanece pendiente de completar en este punto de la crónica inicial.
- No se modificó la fuente de gobernanza Samantha/Metacanon/GOW.
- No se consultó ni expuso ningún secreto.
- No se desplegó ni se afirmó una prueba real contra Jules.

## Resultado, límites y siguiente paso

El alcance y criterios de aceptación están definidos. La primera acción de implementación es añadir las siete herramientas MCP y propagar los scopes por autenticación, metadatos, interfaz y pruebas de Khora. Después, ejecutar pruebas reales disponibles, leer de vuelta, abrir PR, comprobar CI y separar claramente el estado de merge del despliegue. Actualizar esta crónica con una entrada posterior, sin sobrescribir este historial.

