# Replicación de uso MCP Jules entre frentes v1.0

## Principio de integración
Los frentes no necesitan servidores MCP propios. La familia de herramientas se expone en el servidor único de Khora; cada OCP conserva propósito, criterios, prompts, estado, control de responsabilidad y crónica. Se replica el patrón de uso y la configuración mínima del frente, no la infraestructura, las claves ni los controles.

## Prerrequisitos de cliente

1. El cliente objetivo es una cuenta personal ChatGPT Free que instala el plugin MCP Jules público desde el directorio oficial; probar en la cuenta y región reales.
2. El plugin debe estar aprobado/publicado por OpenAI y conectado al servidor HTTPS central de KHORA en /api/mcp. Los frentes no despliegan servidores MCP propios.
3. Cada usuario completa OAuth 2.1 y recibe permisos únicamente para sus fuentes Jules, repositorios, ramas y acciones autorizadas.
4. Seleccionar/mencionar el plugin en cada mensaje que requiera una acción; no garantizar invocación automática en todos los turnos, Agent/Deep Research para escritura ni trabajo en segundo plano.
5. La disponibilidad y capacidades de un plugin individual dependen del plan, región y cuenta. La disponibilidad general del directorio no demuestra escritura en Free; comprobarlo con T23/T26/T27.
6. Al alcanzar límites Free, conservar checkpoint y reanudar en otro turno cuando el servicio lo permita; nunca reintentar un POST ambiguo.
7. Codex queda expresamente excluido. No utilizarlo como cliente, herramienta, canal de pruebas, fallback o requisito.
8. No usar conexión privada de MCP desde un plan de pago como prueba de aceptación de Free ni depender de GPT Actions/GPTs personalizados.

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