# EP-TASK-003 · Mapa integral de la construcción de Entorno Persistente y delta de aprovechamiento

**Naturaleza:** tarea provisional vinculada al frente EP; no crea un frente, OCP, titularidad, sesión ni folio global propio.  
**Estado:** `en_curso` — inventario documental iniciado; mapa integral y delta aún no completos.  
**Identificador:** `EP-TASK-003` (local al registro provisional).  
**Responsabilidad de seguimiento:** frente EP, bajo su OEP.  
**Origen:** instrucción directa del operador en esta conversación, 2026-10-31.  
**OCP padre:** [OEP](../../OEP.md).

## 1. Enunciado

Construir un mapa exhaustivo y recuperable de todo lo que se ha diseñado, construido, documentado, probado, desplegado o preparado dentro del ámbito Entorno Persistente, aunque actualmente no se utilice. El mapa debe incluir arquitectura, código, servicios, extensiones, contratos, APIs, MCP, bases de datos, almacenamiento local y remoto, colectores, SDK/clientes, scripts, paquetes, pruebas, artefactos, procesos de sincronización, recuperación, observabilidad y documentación. Después debe cotejarse ese inventario con las necesidades urgentes y con los consumidores que realmente utilizarán la persistencia de EP, para calcular el delta entre lo ya construido y utilizado, lo construido pero no usado, lo parcialmente aprovechable, lo duplicado, lo obsoleto y lo que todavía falta. El análisis de rescate, simplificación o descarte de componentes de baja prioridad queda expresamente diferido hasta que las urgencias estén resueltas; nada se borra ni se abandona por inferencia.

## 2. Objetivos y entregables

### 2.1 Mapa de construcción «as-built»

Un catálogo único, con referencias a fuentes exactas, que identifique por componente:

- nombre, función, alcance y proyecto/repositorio;
- fuente canónica, branch/ref, commit y rutas;
- blob SHA y SHA-256 cuando sea posible;
- estado: observado en fuente actual, reportado históricamente, ejecutado con evidencia, desplegado, en uso, parcialmente construido, sin uso demostrado, sustituido o desconocido;
- dependencias y fronteras de seguridad;
- contrato/interfaz y consumidores;
- datos que produce/recibe y su persistencia;
- pruebas existentes y qué prueban exactamente;
- resultado actual de disponibilidad y uso real (no inferir por presencia de código);
- restricciones, bloqueos y riesgos de recuperación.

### 2.2 Matriz de utilización

Para cada elemento, clasificarlo como:

- usado actualmente y necesario;
- usado parcialmente;
- construido pero no utilizado;
- preparado pero nunca integrado;
- antecedente sustituido o descontinuado;
- duplicado de otra capacidad;
- pendiente de verificación.

### 2.3 Cotejo con urgencias y delta

Comparar el mapa con la ruta urgente vigente de EP:

1. fijar la arquitectura común de persistencia bajo responsabilidad de EP y su compuerta de aprobación;
2. dejar operativo el recurso B2 correcto: exclusivamente `OCP-MSP`; conservarlo como destino y verificar el estado real de acceso;
3. retirar `metodologia-ep-persistencia` únicamente después de identificar inequívocamente el bucket y confirmar que no contiene datos que deban preservarse;
4. implementar la interfaz común versionada de EP, sus mecanismos de autenticación/autorización, lectura/escritura, integridad y recuperación;
5. construir el cliente/adaptador reusable de EP;
6. incorporar HARMONIA y Signal Interpreter mediante adaptadores propios, respetando sus estructuras locales diferentes;
7. demostrar sincronización, aislamiento, idempotencia, read-back SHA-256 y restauración.

El mapa debe producir un delta accionable: capacidad que existe y puede reutilizarse, capacidad que requiere adaptación, capacidad duplicada o ya sustituida, y capacidad ausente. No presuponer el stack definitivo: documentar el hecho construido y separar la propuesta de integración.

## 3. Perímetro inicial de búsqueda

El inventario debe cubrir, como mínimo:

- OEP, hitos EP-H01–EP-H06, tareas provisionales, prompts de asistencia/constructor, originales, revisiones, manifiestos, evidencia y entregables del repositorio `SeryMente/metodologia`;
- arquitectura normativa y código del Entorno Persistente Medio en `SeryMente/khora`, incluidos bootstrap, VHDX/BitLocker, workspace, identidad/OIDC, tokens, sesiones, logs, Neon, APIs, MCP, continuidad multi-repositorio, cleanup/hombre muerto, UI, herramientas, migraciones SQL, scripts y pruebas;
- HARMONIA dentro de KHORA: extensión, colector, JSONL, índice, catálogo, fingerprints, token/seguridad local, sincronización de código, Cora/Neon, OCP y pruebas;
- Signal Interpreter: extensión, IndexedDB, outbox/cola, batches, relay Vercel, GitHub Actions, paquete `observations/`, manifests, snapshots, deltas, call reports, auditorías, scripts y documentación;
- Backblaze B2: cuenta/región/buckets/keys/permisos/prefijos, custodia, clientes y cualquier integración existente, distinguiendo lo reportado de lo observado;
- entregables históricos, prototipos y componentes que no se encuentran enlazados desde el camino actual.

Este perímetro se ampliará solo cuando una fuente examinada indique una dependencia adicional. No tratar un directorio ausente en una rama como prueba de que no existe en otra.

## 4. Método

1. Resolver y registrar fuente, rama, commit, blob y fecha de revisión.
2. Construir el inventario por repositorio y por subsistema, no solo por nombre de archivo.
3. Relacionar documentos con implementación y pruebas; marcar divergencias y versiones.
4. Distinguir el estado de código de su despliegue y uso efectivo.
5. Marcar componentes sin fuente actual como `fuente no recuperada`, no como inexistentes.
6. Construir una matriz de trazabilidad: requisito urgente → capacidad existente → evidencia → brecha → adaptación pendiente → prueba de aceptación.
7. Calcular delta de reutilización: ya aprovechable, aprovechable con adaptación, duplicado/solapado, no utilizado, sustituido y faltante.
8. Entregar hallazgos con enlaces/paths y evidencia suficiente para reanudar el trabajo desde otra conversación.
9. Mantener un único catálogo/índice dentro de los objetos canónicos EP; no crear un tablero paralelo.

## 5. Límites

- La sesión local anterior y sus credenciales no están disponibles en esta ubicación. No asumir acceso a la máquina, perfil Windows, DPAPI, archivos locales ni servicios iniciados allí.
- No solicitar ni publicar secretos. No copiar credenciales de B2 a consumidores.
- No borrar buckets, archivos, paquetes, ramas, servicios o código durante el inventario.
- La autorización para retirar el bucket sobrante se registrará en EP-TASK-002, pero solo se ejecutará tras autenticación y verificación de identidad del bucket/datos.
- No modificar código de los consumidores ni apagar sus mecanismos actuales en la fase de inventario.
- La revisión de salvamento/descarte de lo no usado es fase posterior, condicionada a que se resuelvan las urgencias y a decisión/aceptación del operador.
- Las decisiones de arquitectura de alto nivel y seguridad pasan por la compuerta de Gobernanza aplicable; este mapa no las aprueba por anticipado.

## 6. Criterio de cierre de esta tarea

La fase de inventario/delta se cierra cuando:

- las fuentes y superficies definidas han sido recorridas o sus límites se han documentado;
- el catálogo distingue «construido», «desplegado», «en uso», «sin uso demostrado» y «desconocido»;
- los componentes tienen referencias de versión/commit/blob/path y evidencia disponible;
- los requisitos urgentes están cotejados con capacidades existentes;
- el delta de reutilización, adaptación, duplicidad y carencia está calculado;
- los bloqueos de acceso local/B2 se muestran como no verificados;
- la lectura de vuelta de los artefactos del mapa se ha verificado.

La evaluación de salvamento, simplificación o descarte de los componentes no utilizados **no forma parte de este cierre**: queda en reserva para después de las urgencias.

## 7. Primera entrada de crónica · 2026-10-31

**Estado inicial:** tarea en curso; inventario global no terminado.

**Fuentes observadas en este ciclo:**

- `SeryMente/metodologia/main`: OEP v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`; revisión del núcleo y §§76–90 en proceso. DUG Samantha v373 / NX-373m; Metacanon 1.26; GOW 2.14 y §ARR adquiridos en `main`.
- `SeryMente/khora/main`: `ep-medio-architectura.md` v1.0.4, blob `382e4a929a984a96926fd6f9080f80bedd109a0b`; especificación del medio con VHDX/BitLocker, OIDC, JWT de sesión, GitHub/Vercel, Neon y bitácora remota encadenada; `EP-ARCHITECTURE.md` es redirección de compatibilidad.
- HARMONIA en `SeryMente/khora/main`: `apps/harmonia-observability/collector/server.js`, blob `34b98945da3db4604e62a3c9baa367ce024a0a5c`, y `extension/service-worker.js`, blob `49d65381accdc33ce501eca6c4b5f2dd47a014b2`; existe colector local en 127.0.0.1:47321 con raíz local, JSONL/índice/fingerprints y eventos `harmonia.event.v1`. El objeto canónico HARMONIA es v0.39, blob `4c55a0942ba08274caadf1af11f4ea81de0dfed7`; la persistencia provisional anonimizada hacia Cora/Neon continúa con pruebas POST/GET/idempotencia no ejecutadas según §44; el NCL es auxiliar opt-in y desconectado por defecto según §45.
- `SeryMente/signal-interpreter/main`: arquitectura de observabilidad v2, blob `8a492f763c17bc15920f02614c37a15c30dc8a66`; relay Vercel → GitHub API → inbox → GitHub Actions → paquete de observabilidad. Contrato de paquete v1, blob `caedf6d6f1d21e6c085a68d9784a5543cf6d590e`; protocolo de delta v1, blob `8a7d33fd6a0e4e40fab059256d8ac1b9bf3fd758`; manifiesto actual blob `34c23121f60c2420c5994e893bd91fc535581d97`, total reportado por el propio manifiesto 10,659 batches, 1,918 observations, 1,897 deltas, 14 identities, extension 0.10.36, manifest generatedAt 2026-10-31T20:58:25.342Z y lastSequence 7965. Estos contadores son contenido del manifiesto leído; no son una medición independiente de cada batch.
- Tareas provisionales en `SeryMente/metodologia/main`: EP-TASK-001 pendiente (NCL) y EP-TASK-002 en curso (OCP MCP/B2), índice blob `74aceb5fef4814011ebdd393a36e1191469ea328`; no hay EP-TASK-003 hasta materializar esta entrada.

**Primer delta observado:** el medio EP ya incluye persistencia local cifrada y bitácora remota Neon con hash chaining para sesiones de entorno; HARMONIA y Signal Interpreter tienen subsistemas de observabilidad autónomos y muy diferentes; Signal Interpreter ya persiste su paquete remoto en GitHub mediante Vercel, HARMONIA tiene colector local y evidencia histórica Cora/Neon pero su prueba real de escritura/lectura/idempotencia sigue pendiente. Backblaze aparece como tarea de persistencia provisional, sin integración central demostrada. Por tanto, no se debe tratar Backblaze como si fuera la primera o única persistencia ya construida; el reto es definir qué responsabilidad nueva cubre EP y cómo incorpora sin duplicar Neon/Historial GitHub ni eliminar la persistencia local.

**No observado/no verificado:** estado actual de host/local y cualquier clave DPAPI; estado actual de login de B2; buckets y keys en cuenta B2; conexión de HARMONIA en un host vivo; sesiones Vercel actuales; uso/aceptación de producción por cada consumidor; restauración real multiubicación; inventario exhaustivo de Khora, MCP y artefactos históricos.

**Siguiente acción:** ampliar el mapa por árbol de KHORA y Signal Interpreter, completar la reconciliación de EP-TASK-002 con la orden OCP-MSP, crear el prompt común no normativo para los consumidores y calcular el delta provisional frente a los requisitos urgentes. No se descarta ni modifica componente alguno.
