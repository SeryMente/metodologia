# Replicación de uso MCP Jules entre frentes v1.0

## Principio de integración
Los frentes no necesitan servidores MCP propios. La familia de herramientas se expone en el servidor único de Khora; cada OCP conserva propósito, criterios, prompts, estado, control de responsabilidad y crónica. Se replica el patrón de uso y la configuración mínima del frente, no la infraestructura, las claves ni los controles.

## Prerrequisitos de cliente
1. Usar un cliente/espacio de trabajo ChatGPT que permita aplicaciones MCP personalizadas con escritura. La documentación consultada lista esa capacidad para Business y Enterprise/Edu; no se presume que cualquier plan personal la tenga.
2. La conexión debe apuntar al servidor remoto HTTPS/túnel seguro admitido y usar autenticación configurada.
3. La app debe seleccionarse/mencionarse en el mensaje que necesita acciones; la selección no garantiza invocación automática en mensajes futuros.
4. No considerar Agent mode ni Deep Research como sustitutos de la sesión conversacional normal para el ciclo de escritura. No se promete operación persistente de fondo.

## Para adoptar un frente
1. Leer el gobierno canónico y el OCP propio; comprobar control y autorización de ese frente.
2. Solicitar solo `jules:read` y/o `jules:write` según necesidad, además del ciclo normativo existente. No añadir scopes Jules al token por defecto.
3. Confirmar que el repositorio aparece en fuentes Jules y que la rama existe. El servidor debe revalidar source/branch al crear sesión.
4. Incluir en el prompt OCP, versión, alcance, pruebas, exclusiones y cláusula NO SIMULACIÓN.
5. Crear sesión con aprobación del plan forzada y `AUTO_CREATE_PR`; revisar el plan y esperar confirmación explícita antes de aprobar. Un PR no equivale a merge.
6. Continuar en el mismo session ID: leer actividades paginadas con `pageToken`, responder feedback verificado y reconsultar tras cada POST.
7. No reintentar escrituras ambiguas; consultar estado/actividad y registrar el bloqueo/decisión.
8. Guardar IDs, estado, última actividad/cursor, evidencia y resultados en el OCP del frente solicitante; no crear un control de responsabilidad paralelo.
9. Si se requiere sondeo cuando ChatGPT no está activo, planificar un trabajador externo como versión posterior, con checkpoint, deduplicación, backoff, límites, logging saneado, apagado y revisión humana. No incluirlo implícitamente en v1.0.