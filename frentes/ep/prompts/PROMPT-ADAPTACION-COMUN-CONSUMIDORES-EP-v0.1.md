# PROMPT COMPARTIDO — ADAPTACIÓN DE HARMONIA Y SIGNAL INTERPRETER A LA PERSISTENCIA DE EP

**Estado:** borrador de alineación operativa v0.1 · no es todavía el contrato técnico ni una autorización de cambios de código.  
**Destinatarios:** modelo/agente responsable de KHORA/HARMONIA y modelo/agente responsable de Signal Interpreter.  
**Emisor:** frente Entorno Persistente (EP).  
**Ámbito de almacenamiento remoto:** exclusivamente el bucket Backblaze B2 `OCP-MCP`, bajo la arquitectura y el servicio que EP publique. No usar `OCP-MSP` ni `metodologia-ep-persistencia` como destinos de EP.

## 1. Decisión de responsabilidad

EP es el responsable de diseñar, mantener, documentar y operar la arquitectura común de persistencia del entorno. EP define el contrato versionado, el servicio de acceso, la seguridad, los mecanismos de sincronización, la integridad, la recuperación, los identificadores y la documentación de incorporación.

HARMONIA y Signal Interpreter son consumidores. Ambos deben adaptarse a la interfaz que EP publique. Ninguno define unilateralmente el almacenamiento remoto común, impone a EP su estructura local ni construye una segunda infraestructura remota para sustituir a EP.

Los dos consumidores pueden mantener estructuras locales distintas. No se exige unificar carpetas, bases, índices, formatos internos ni su arquitectura de captura. La convergencia ocurre en el límite de integración: cada consumidor tendrá un adaptador hacia el contrato de EP.

## 2. Qué permanece bajo control de cada consumidor

Cada proyecto sigue siendo responsable de su extensión, captura de eventos, semántica de producto, sanitización previa, identidad de origen y persistencia local inmediata. La persistencia local existente no se elimina, reemplaza ni reestructura por este prompt.

- **HARMONIA/KHORA:** conservar su colector local, sus JSONL, índice, fingerprints y su modelo de eventos mientras EP no publique una ruta de migración probada y autorizada. El colector local no se convertirá automáticamente en el backend remoto compartido.
- **Signal Interpreter:** conservar IndexedDB, la cola local, los batches y su paquete de observabilidad actual mientras EP no publique una ruta de migración probada y autorizada. No introducir un servicio local residente ni depender de localhost para su runtime de observabilidad.
- **Ambos:** mantener separados los datos por proyecto, repositorio, consumidor y sesión; conservar la procedencia original y el vínculo entre los registros internos y el identificador que EP asigne al artefacto/evento común.

## 3. Regla de integración

La interfaz de EP será la única frontera de integración remota común. EP publicará la especificación y sus versiones antes de exigir una modificación de producción en cualquiera de los consumidores.

Cada consumidor deberá incorporar un adaptador delgado que:

1. lea desde su estructura local actual;
2. traduzca al contrato común de EP sin destruir ni reescribir la fuente original;
3. envíe mediante el cliente/API/SDK oficial de EP;
4. gestione cola pendiente, reintentos y respuesta del servicio según el contrato publicado;
5. recupere y verifique los datos remotos por medio de EP, sin acceso directo al bucket;
6. permita correlacionar cada objeto remoto con su evento, batch o sesión local de origen.

**No inventar endpoints, rutas, nombres de campos, tokens, SDK, credenciales ni formatos que EP todavía no haya publicado.** Hasta que exista contrato implementado, versionado, disponible y probado, el trabajo de cada consumidor es de descubrimiento, mapeo y preparación del adaptador, no de conexión ficticia ni de sustitución de sus mecanismos actuales.

## 4. Local-first y garantías de entrega

El registro local ocurre antes de cualquier intento remoto. La indisponibilidad de EP, de red o de Backblaze no debe impedir la captura local.

No marcar un evento como sincronizado antes de recibir la confirmación definida por el contrato de EP. Conservar los elementos pendientes ante fallo, rate limit, timeout, autenticación inválida o respuesta ambigua. Usar idempotencia y reintentos únicamente según el contrato publicado. No eliminar la copia local por el simple hecho de que un PUT o una petición HTTP haya sido aceptada: retención, confirmación de integridad y eliminación requieren una política explícita.

## 5. Seguridad, privacidad e aislamiento

- Ninguna extensión, repositorio consumidor, modelo o agente consumidor recibe una Application Key de Backblaze.
- Ningún secreto B2 se guarda en código, archivos versionados, manifiestos de observabilidad, prompts ni almacenamiento del navegador.
- Las credenciales de consumidor, cuando EP las publique, serán emitidas y limitadas por EP; un consumidor no puede ampliar su propio alcance.
- Mantener aislamiento por proyecto y repositorio. Un consumidor no puede enumerar, leer ni modificar datos de otro.
- Aplicar minimización de datos y las reglas de privacidad propias de cada consumidor. No enviar contraseñas, cookies, cabeceras de autorización, tokens, TOTP, secretos, audio crudo, transcripciones crudas, cuerpos HTTP ni contenido privado que el contrato no admita.
- No degradar el funcionamiento seguro para conseguir conectividad. Un error de autenticación, aislamiento, integridad o autorización debe fallar de forma cerrada.

## 6. Compatibilidad y evolución

Los esquemas internos existentes pueden seguir evolucionando de forma independiente. El adaptador es responsable del mapeo entre la versión local y la versión explícita del contrato EP. Los cambios incompatibles del contrato común serán versionados por EP. Ningún consumidor modifica silenciosamente el significado de un campo común ni publica una variante local como si fuera la especificación central.

No efectuar una migración masiva de históricos hasta que EP publique el plan, sus reglas de selección, deduplicación, procedencia, verificación, rollback y aceptación. Preservar los históricos y sus hashes.

## 7. Trabajo solicitado a cada consumidor ahora

Sin modificar producto ni apagar mecanismos existentes, entregar a EP un informe breve pero verificable que incluya:

1. commit/branch de la fuente examinada;
2. ubicación y tecnología reales de la persistencia local;
3. esquema de eventos, batches, sesiones e índices que produce;
4. mecanismo actual de entrega, ACK, idempotencia, retry y retención;
5. límites de tamaño, cuotas, frecuencia y dependencias externas;
6. controles actuales de privacidad, autenticación y aislamiento;
7. inventario de datos históricos y forma de enumerarlos;
8. huecos para adaptarse al contrato EP;
9. propuesta de adaptador mínimo, no invasivo, con mapping de campos;
10. pruebas necesarias para demostrar que la captura local sigue funcionando sin red y que la sincronización posterior no duplica ni pierde datos.

Distinguir en el informe: implementado y observado en código; documentado pero no comprobado; ejecutado con evidencia; reportado históricamente; propuesto; y desconocido. No presentar código presente como prueba de que se ejecuta en producción.

## 8. Límites de este prompt

Este texto alinea responsabilidades y dirección de adaptación; no es aún la especificación API/OpenAPI de EP, no concede acceso a sistemas, no autoriza cambios de esquema, migración de datos, publicación, despliegue, rotación de secretos ni eliminación de los mecanismos actuales.

Las decisiones de arquitectura de alto nivel y seguridad se cerrarán en EP conforme a la compuerta de Gobernanza y a la revisión presencial requerida. Una vez que EP publique un contrato probado, los dos consumidores recibirán la misma versión y adaptarán sus clientes independientemente, sin necesidad de hacer equivalentes sus estructuras locales.

## 9. Resultado esperado

Un único proveedor de persistencia remoto, diseñado y mantenido por EP; dos consumidores con persistencias locales diferentes; dos adaptadores pequeños que dependen del contrato EP; procedencia e integridad preservadas; ningún acceso B2 directo desde los consumidores; y una ruta de incorporación reproducible para futuros proyectos.
