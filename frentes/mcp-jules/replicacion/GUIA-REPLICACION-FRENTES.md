# Replicación de uso MCP Jules entre frentes

## Principio de integración
Los frentes no necesitan servidores MCP propios. La herramienta se expone en el servidor único de Khora; cada OCP conserva sus criterios, prompts, estado, control de responsabilidad y crónica. Se replica el patrón de uso y la configuración mínima del frente, no la infraestructura, claves ni controles.

## Para adoptar un frente
1. Leer el gobierno canónico y el OCP propio.
2. Referenciar el endpoint MCP central autorizado y solicitar solo `jules:read` y/o `jules:write` según las funciones necesarias, además del ciclo normativo existente.
3. Confirmar que el repositorio destino aparece en fuentes Jules; no suponer que todos los repositorios GitHub están conectados.
4. Incluir en el prompt el OCP de ese frente, versión, alcance, pruebas, exclusiones y cláusula NO SIMULACIÓN.
5. Crear sesión con plan approval forzado, revisar el plan, y continuar la comunicación con el mismo session ID.
6. Registrar actividades y mensaje enviado/recibido con evidencia y límites; no crear un control de responsabilidad paralelo.
7. Si se requiere sondeo cuando ChatGPT no está activo, evaluar el trabajador externo como infraestructura compartida, con una sola fuente de checkpoint y política de apagado.

## Condiciones para declarar replicable
- La conexión central y los scopes se verificaron en un cliente real.
- Existe una sesión de prueba por cada tipo de repositorio/permisos relevante.
- El frente puede reconstruir su contexto con su OCP sin leer un estado de otro frente.
- Los mensajes, planes y resultados tienen trazabilidad por sesión y actividad.
- No se comparten secretos por prompts/logs/archivos del OCP.
- Se distingue lo que Jules reporta de lo que el sistema verifica.

No dar por replicado el resultado hasta comprobar la conexión real y la secuencia de aceptación en el frente destino.
