# GOV-TASK-014 — Integración y aceptación de persistencia Backblaze para Metodología y OCP

**Estado:** en_curso · **Tipo:** tarea integradora propia de Gobernanza · **Responsabilidad:** heredada del OCP Gobernanza, generación 11. No crea FT, OCP, control, sesión ni folio independiente.

## 1. Objetivo

Integrar en el OCP general del sprint la dependencia técnica EP-TASK-002 para habilitar persistencia remota complementaria de los artefactos elegibles de Metodología y OCP en Backblaze B2, con recuperación verificable entre ubicaciones. Gobernanza define el resultado integrado, las fronteras entre fuentes canónicas, los criterios de aceptación y las decisiones que requieren al operador; EP conserva y ejecuta la implementación de entorno/persistencia en su OEP. Esta tarea no duplica EP-TASK-002 ni transfiere a Gobernanza la autoridad técnica de EP.

## 2. Fuente técnica y trazabilidad

- **Frente ejecutor:** Entorno Persistente, OCP `frentes/ep/`.
- **Tarea técnica fuente:** [EP-TASK-002 — Persistencia provisional con Backblaze B2](../../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md).
- **OEP:** [Objeto Canónico de Persistencia de Entorno](../../../ep/OEP.md).
- **Comunicación DTC EP:** [COORDINACION-GOBERNANZA-EP-v0.1.md](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md).
- **Repositorio canónico de Metodología:** `SeryMente/metodologia/main`; GitHub permanece fuente canónica de documentos, gobierno, tareas y código versionado.
- **Objeto MCP-OCP:** `frentes/mcp-metodologia/`; conserva su propio OCP y control. La persistencia B2 no sustituye ni altera ese OCP.

## 3. Alcance integrado

1. Precisar con EP qué artefactos de Metodología/OCP deben tener copia recuperable en B2 y cuáles deben permanecer únicamente en sus fuentes canónicas.
2. Mantener GitHub como autoridad de versiones y procedencia. B2 es una copia complementaria de persistencia/recuperación; no es un segundo repositorio canónico, no sustituye Git y no se convierte en almacén de autorización, control, folios o bitácoras.
3. Reconciliar los artefactos de OCP elegibles con sus propietarios: OEP y documentación EP; documentación y artefactos de MCP-OCP; documentos de Gobernanza. No copiar secretos, credenciales, tokens, perfiles autenticados ni datos excluidos por EP.
4. Verificar que el destino configurado sea únicamente el bucket `OCP-MCP`; el prefijo históricamente reportado para EP es `ep-ocp/`, sujeto a verificación autenticada de cuenta, región, bucket, key y permisos.
5. Mantener como destinos inválidos `OCP-MSP` y `metodologia-ep-persistencia`. La eliminación de este último figura autorizada en el historial de EP, pero no se considera ejecutada: EP debe verificar cuenta, identidad y contenido antes de actuar.
6. Obtener evidencia de carga de muestra no sensible, lectura de vuelta, SHA-256, restauración aislada y verificación funcional en una segunda ubicación, bajo las autorizaciones y compuertas de EP.
7. Integrar el resultado en el checklist del sprint, separando diseño, preparación local, autenticación, operación remota, sincronización, restauración y aceptación.

## 4. Estado de entrada observado

**Fuente EP-TASK-002, blob leído:** `eefd01300376dab55593e2a35196f7eaf66fc350`.

- Tarea EP-TASK-002: `en_curso`.
- Backblaze CLI v5.0.2 descargada e instalada localmente en PC-8; SHA-256 del ejecutable verificado: `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`.
- Comandos `version`, `--help`, `sync --help`, `bucket get --help` y `bucket list --help`: exit code 0, según recibo persistido de EP.
- `account get`: exit code 1; estado clasificado por EP como `NOT_AUTHORIZED_OR_NO_CACHED_SESSION`.
- Autenticación B2, cuenta/región, existencia/privacidad del bucket, key, prefijo y permisos efectivos: no verificados.
- No hay evidencia de listado de buckets, carga, descarga, sincronización, borrado, SHA remoto ni restauración. No se declara ninguna operación remota ejecutada.
- EP registra que P012/P013 requieren revisión presencial del operador antes de construir el motor, contactar la cuenta B2 o realizar operaciones remotas. La instalación local del CLI no supera esa compuerta.
- EP ya documentó que GitHub `SeryMente/metodologia/main` es la fuente canónica y que B2 debe ser persistencia complementaria, no un segundo núcleo de OEP/tareas/autorización/bitácora.

**Estado de verdad:** CLI local instalada/verificada según evidencia de EP; cuenta B2 y operaciones remotas no verificadas/no ejecutadas. La tarea integradora de Gobernanza no certifica los resultados técnicos de EP.

## 5. Criterios de aceptación integrados

- [ ] Operador revisa y decide presencialmente el perímetro de datos, arquitectura, custodia de credenciales y flujo de recuperación exigido por P012/P013.
- [ ] EP verifica de forma autenticada cuenta/región, bucket privado `OCP-MCP`, key/prefijo `ep-ocp/` y permisos mínimos, sin revelar secretos.
- [ ] EP inspecciona el bucket erróneo `metodologia-ep-persistencia`; solo lo elimina si identidad, nombre y contenido se verifican y se preserva cualquier dato que deba conservarse.
- [ ] EP define manifiesto de artefactos elegibles y exclusiones, con rutas lógicas estables; GitHub sigue siendo fuente canónica de los archivos versionados.
- [ ] Una muestra sintética/no sensible se carga en prefijo autorizado y se verifica por lectura de vuelta, conteos, tamaños y SHA-256.
- [ ] Se demuestra restauración aislada en una segunda ubicación sin sobrescritura destructiva y con hashes coincidentes.
- [ ] Se demuestra sincronización idempotente, recuperación ante interrupción y detección/preservación de conflictos, conforme al alcance MVP de EP.
- [ ] EP actualiza EP-TASK-002/OEP y su objeto DTC con evidencia, limitaciones, commits/blobs, hashes y read-back.
- [ ] Gobernanza verifica la evidencia fuente y actualiza el estado integrado sin duplicar el detalle técnico.
- [ ] El operador acepta expresamente el resultado integrado.

## 6. Dependencias, límites y decisiones

- EP es responsable de la implementación, credenciales, CLI, host, bucket, transferencias, restauración y evidencia técnica, bajo su control y compuertas.
- Gobernanza es responsable de integrar la dependencia, fijar criterios de aceptación del sprint, revisar la trazabilidad y elevar decisiones al operador.
- MCP-OCP conserva la autoridad técnica de su servidor, código, pruebas y empaquetado. La persistencia B2 no autoriza a Gobernanza o EP a modificar su OCP/control/código.
- No crear un bucket alternativo, un segundo OCP, un mirror canónico independiente ni una bitácora paralela.
- No imprimir, almacenar en Git ni enviar al chat claves, tokens, contraseñas o secretos.
- No ejecutar `--delete`, cambios lifecycle, cambios ACL o transferencias masivas sin compuerta y autorización específica.
- La disponibilidad de un CLI o la presencia de variables en otro proyecto no demuestra que B2 esté autenticado, configurado o operativo para Metodología.
- El estado de esta tarea no se completa por el cierre de un ciclo DTC ni por la instalación del CLI; requiere todos los criterios de aceptación aplicables.

## 7. Comunicación y actualización por ciclo

La comunicación de Gobernanza con EP se mantiene exclusivamente en el objeto existente `COORDINACION-GOBERNANZA-EP-v0.1.md`. En cada ciclo real de cualquiera de los frentes:

1. Leer el último cursor del objeto y responder en la misma entrada antes de otro trabajo sustantivo.
2. Permitir intercambios múltiples dentro del mismo ciclo mediante sondeo adaptativo en hitos, decisiones, antes de escribir, tras tramos largos y antes del cierre; no imponer temporizador fijo.
3. Registrar solo novedades materiales: emisor, cursor/blob, delta, respuesta/acción, estado y pendiente.
4. Antes de cada escritura, releer la revisión y comprobar SHA; serializar escrituras y reconciliar ante cambios concurrentes.
5. Cerrar el ciclo una sola vez, tras atender mensajes pendientes, documentar resultados y comprobar read-back.

La comunicación con MCP-OCP permanece en su objeto existente `COORDINACION-SPRINT-OCP-MCP-v0.1.md`, sin trasladar instrucciones EP ni abrir canales alternativos. La coordinación no afirma recepción/aplicación hasta que el mensaje figure y sea respondido en ese objeto.

## 8. Estado y siguiente acción

**Estado actual:** `EN_CURSO`; dependencia identificada y ahora enlazada al OCP general del sprint. No se declara autenticación B2, carga, sincronización ni restauración.

**Siguiente acción material:** Gobernanza registra esta integración en el objeto DTC EP existente; EP continúa en EP-TASK-002 y espera la revisión presencial/decisión del operador antes de cualquier operación remota. Una vez habilitada la compuerta, EP ejecuta el preflight autenticado de solo lectura y la prueba sintética aislada.

**Cierre:** solo cuando la evidencia de EP satisfaga los criterios anteriores, Gobernanza haga read-back de las fuentes y el operador acepte el resultado integrado.

**Vigencia:** tarea provisional del sprint actual; no canoniza un estándar general ni modifica el DUG.
