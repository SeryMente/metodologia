# Sprint general · Product Design con BMAD y CIS

**Revisión:** aprobado para ejecución en TestMode · 2026-11-15
**Estado del documento:** APROBADO PARA EJECUCIÓN · ajustes de DAG, TestMode y auditoría memlog incorporados
**Estado de ejecución:** TP-02A → TP-01 → TP-03 autorizados en workspace sintético; TP-02B bloqueado hasta EP-C0.1..C0.4; commit/push no autorizados
**Versión de producto objeto del sprint:** V1.0 · seis perfiles de agente
**Módulo:** MOD-EP-PRODUCT-DESIGN · subordinado al frente Entorno Persistente (EP)
**Tareas EP existentes:** EP-TASK-009 (TP-01) y EP-TASK-010 (TP-02). TP-03 no recibe un ID EP-TASK nuevo.

> Esta revisión sustituye como diseño vigente las afirmaciones anteriores que presentaban pruebas conversacionales sintéticas como aceptación de agentes, describían persistencia como transacción completa o atribuían al motor funciones que no implementa. Las pruebas sintéticas previas se conservan como antecedentes. La aprobación autoriza únicamente el ciclo de ejecución en TestMode descrito en §§8, 10, 11 y 18; no habilita escritura productiva, EP Vault, TP-02B, commit ni push.

---

## 1. Resultado que debe entregar V1.0

V1.0 será una capacidad operable desde una conversación ordinaria de ChatGPT, conectada mediante RDC con los archivos locales autorizados, capaz de:

1. Activar cualquiera de los seis perfiles: Carson, Maya, Dr. Quinn, Victor, Sophia y Caravaggio.
2. Consultar las fuentes locales pertinentes al agente. Para Carson, consultar dinámicamente el catálogo BMAD 6.12.4 instalado en el host.
3. Conducir una sesión real, producir ciclos de ideación con autoría y procedencia explícitas y generar el JSON contractual del almacén.
4. Invocar realmente el CLI PowerShell mediante RDC y guardar proyectos, sesiones y ciclos en el workspace EP que haya sido verificado.
5. Consultar, verificar, buscar y recuperar versiones persistidas; reconstruir el contexto de una sesión desde ShowSession.
6. Demostrar que el ciclo quedó persistido mediante Verify y lectura de vuelta. La salida del modelo, la existencia del prompt o el código ejecutado no equivalen a persistencia.

**Significado de “agente” en esta arquitectura:** cada perfil es una configuración conversacional que ChatGPT aplica usando fuentes locales y herramientas RDC. No se afirma que ChatGPT instale o ejecute un runtime CIS nativo, subagentes CIS independientes ni un modelo distinto por perfil. La ejecución se acredita por el comportamiento observado del perfil real, las consultas locales, los comandos RDC efectivamente ejecutados y los registros leídos de vuelta.

## 2. Decisiones de alcance

| Decisión | Estado | Aplicación |
|---|---|---|
| ChatGPT en conversación ordinaria es la interfaz principal. | CONFIRMADA | Sin portal, dashboard ni selector propio como requisito. |
| V1.0 comprende los seis agentes CIS. | CONFIRMADA | Carson en TP-01; cinco perfiles restantes en TP-03. |
| ChatGPT + RDC es el circuito de ejecución. | CONFIRMADA | ChatGPT conduce; RDC consulta fuentes y ejecuta el CLI local. |
| BMAD Core 6.12.4 es el motor de Brainstorming de Carson. | CONFIRMADA COMO FUENTE LOCAL | Debe comprobarse dinámicamente en cada sesión aceptada; no basta citar el número de versión. |
| Guardado por ciclo, no por carácter. | CONFIRMADA | Preservar contenido significativo íntegro, autoría y procedencia. |
| Proyecto auto-nombrado y etiquetado cuando el operador no lo nombra. | CONFIRMADA | Título derivado de tema y fecha. |
| Biblioteca FTS5 con filtros esenciales. | CONFIRMADA | Filtros: proyecto, etiqueta, madurez y agente. |
| Restauración de versión y reanudación de sesión. | CONFIRMADA | RestoreVersion crea un ciclo nuevo; ShowSession entrega el contexto persistido para reanudar. |
| Superpowers. | SOLO REFERENCIA | No se instala, ejecuta ni integra como herramienta. |
| Brain Selector y Keepsake. | DIFERIDOS | Fuera de V1.0; no son puertas de aceptación. |
| Prótesis Cognitiva y cognición visoespacial. | DIFERIDAS | No se implementan ni desglosan en este sprint. |
| Grafo de relaciones entre proyectos y Save As. | FUERA DE V1.0 | No se diseñan ni se reclaman como capacidad. |
| Runtime CIS nativo. | FUERA DE LA ARQUITECTURA ACTUAL | No se requiere ni se afirma. Los perfiles conversacionales sí deben demostrar ejecución real en ChatGPT + RDC. |

No se añade una interfaz, base de datos relacional de proyectos, servicio web, API local, listener, sincronización automática de conversaciones ni función no solicitada para completar este resultado.

## 3. Contrato de requisitos R#

Los requisitos siguientes son acumulativos. Un requisito queda aceptado solo con evidencia de ejecución reproducible y lectura de vuelta, no por estar descrito o por tener una prueba textual.

| ID | Requisito verificable | Criterio de aceptación / evidencia |
|---|---|---|
| R-01 | Interfaz ChatGPT + RDC | Desde una conversación normal se activa un perfil, se consulta su fuente local, se produce una salida contractual, se invoca el CLI mediante RDC y se recupera el resultado. Sin intervención manual para copiar/reconstruir el JSON entre etapas. |
| R-02 | Contrato común de los seis perfiles | Cada uno de los seis archivos de prompts contiene: fuentes y versión fijadas; parámetros exactos del wrapper; JSON estricto para Initialize, SaveCycle, ShowSession y Verify; enums exactos; tratamiento de errores; secuencia de read-back; prohibición de declarar guardado sin confirmación. |
| R-03 | Catálogo dinámico de Carson | Carson consulta por RDC el brain.py instalado: categories y después list/show de las técnicas elegidas. Registra las técnicas realmente devueltas por el catálogo, no nombres recordados ni una lista escrita en el prompt. |
| R-04 | Exclusión efectiva de memlog | En cada E2E de agente se ejecuta una auditoría negativa automatizada: cero invocaciones de memlog.py y cero eventos de creación, escritura, renombrado o eliminación de archivos .memlog.md en los roots monitorizados. El test falla ante cualquier evento. Una instrucción textual aislada no satisface R-04. |
| R-05 | Proyecto y sesión | Initialize crea un proyecto auto-nombrado cuando falta project_title, con origen del nombre y tags esenciales; crea una sesión asociada al agente, motor y modo. |
| R-06 | Ciclos completos e inmutables | SaveCycle conserva el texto íntegro de las ideas, autoría, madurez, técnicas, preguntas y decisiones. Repetir el mismo payload es idempotente; una corrección genera revisión nueva, no sobrescribe la versión anterior. |
| R-07 | Formato físico de ciclos | Los ciclos se materializan con el patrón exacto NNNNNN-rNNN.json; ejemplo: 000001-r001.json. La ruta y el nombre devueltos coinciden con el archivo real. |
| R-08 | Concurrencia y lock | Se adquiere .product-design-writer.lock antes de leer revisiones, determinar el siguiente número/revisión o modificar manifiestos/índice. No hay dos escritores que puedan decidir simultáneamente la misma revisión. |
| R-09 | Lock huérfano | El lock registra propietario, PID, identidad de terminal, hora UTC y datos suficientes para detectar reutilización de PID. La recuperación solo procede cuando el propietario se demuestra terminado y el lock supera el TTL. TTL por sí solo nunca permite robar un lock de proceso vivo o de estado indeterminado. |
| R-10 | Consistencia JSON ↔ SQLite/FTS5 | Los JSON son fuente canónica; el índice es derivado. Una operación no devuelve ok=true hasta confirmar consistencia de fuentes, metadatos e índice. Un fallo intermedio devuelve error/no aceptación y deja estado recuperable, nunca un éxito falso. |
| R-11 | Verify completo | Verify comprueba hashes y relaciones de todos los JSON, paridad exacta con las filas de metadatos e índices FTS5, ausencia de journal pendiente e incluye PRAGMA integrity_check con resultado ok. |
| R-12 | Búsqueda y filtros esenciales | Search permite consulta FTS5 más filtros exactos project, tag, maturity y agent. Los filtros se combinan y el resultado identifica proyecto, sesión, ciclo y versión. |
| R-13 | Restauración y reanudación | RestoreVersion conserva todas las versiones previas y crea un ciclo de restauración nuevo enlazado a la versión origen. ShowSession entrega proyecto, sesión y ciclos verificados, en orden, con todo el contenido necesario para reanudar en ChatGPT. |
| R-14 | Wrapper resistente | Invoke-ProductDesignStore.ps1 valida la entrada, separa stdout/stderr sin bloqueo, aplica timeout, termina el proceso hijo y sus descendientes si vence, devuelve un único JSON contractual y códigos de salida inequívocos. |
| R-15 | Workspace EP protegido | En producción no se acepta una compuerta booleana autodeclarada. El wrapper exige una comprobación verificable provista por EP que acredite montaje, bóveda, ruta, identidad de terminal, permisos y read-back. |
| R-16 | Backup/restore específico | El mecanismo EP de backup incluye expresamente MOD-EP-PRODUCT-DESIGN/data/<TerminalId>/brainstorming. Se verifica carga, lectura de vuelta, hash y restauración en staging; los recibos de otros snapshots no sustituyen esta prueba. |
| R-17 | Sincronización de repositorio | El clon de retoma, origin/main y la carpeta canónica SeryMente\Metodologia se mantienen separados. Toda promoción requiere aprobación, publicación autorizada, sincronización por el mecanismo EP confirmado y cotejo SHA/read-back de los tres estados. |
| R-18 | Aceptación de agentes sin simulación | Cada uno de los seis perfiles completa al menos un flujo E2E real ChatGPT + RDC + fuentes + CLI + Verify + ShowSession + auditoría negativa memlog. Escenarios de texto guardados previamente no cuentan. |

**Perfiles contractuales y engine obligatorio:**

| Archivo | agent | engine |
|---|---|---|
| prompts/CARSON-CHAT.md | Carson | bmad-brainstorming |
| prompts/MAYA-CHAT.md | Maya | bmad-cis-design-thinking |
| prompts/DR-QUINN-CHAT.md | Dr. Quinn | bmad-cis-problem-solving |
| prompts/VICTOR-CHAT.md | Victor | bmad-cis-innovation-strategy |
| prompts/SOPHIA-CHAT.md | Sophia | bmad-cis-storytelling |
| prompts/CARAVAGGIO-CHAT.md | Caravaggio | bmad-cis-agent-presentation-master |

Los seis perfiles comparten los mismos comandos, parámetros y schemas de persistencia. El valor mode describe el modo común de interacción almacenado; para los perfiles CIS distintos de Carson se usa creative_partner como valor neutro de colaboración, sin imponerles las tres reglas de stance específicas de BMAD Brainstorming. Cada perfil debe construir el JSON, invocar el CLI por RDC y comprobar la salida; no puede limitarse a describir cómo lo haría.
### 3.1 Enums y formatos obligatorios

No se traducen ni se aceptan alias para los valores de persistencia:

- madurez: draft | developing | mature
- modo: facilitator | creative_partner | ideate_for_me
- estado de sesión: active | paused | completed
- fase pública del ciclo: divergence | convergence | synthesis | pause | completed
- autoría: operator o uno de los seis nombres de agente registrados en Initialize
- archivo: NNNNNN-rNNN.json

El ciclo interno de restauración puede marcar stage=restore; ese valor lo asigna RestoreVersion, no el agente en un SaveCycle ordinario.

### 3.2 Contrato JSON estricto de Initialize

Objeto JSON; UTF-8; raíz object; additionalProperties=false.

~~~~json
{
  "topic": "string no vacío",
  "goal": "string; puede ser vacío si no se aportó objetivo separado",
  "agent": "Carson | Maya | Dr. Quinn | Victor | Sophia | Caravaggio",
  "engine": "bmad-brainstorming (Carson) | bmad-cis-design-thinking (Maya) | bmad-cis-problem-solving (Dr. Quinn) | bmad-cis-innovation-strategy (Victor) | bmad-cis-storytelling (Sophia) | bmad-cis-agent-presentation-master (Caravaggio)",
  "mode": "facilitator | creative_partner | ideate_for_me",
  "project_title": "string opcional; omitir para auto-nombre",
  "maturity": "draft | developing | mature",
  "tags": ["string"]
}
~~~~

Campos obligatorios: topic, agent, engine y mode. goal puede omitirse y se normaliza a cadena vacía; project_title y tags son opcionales; maturity toma draft por defecto. El perfil debe enviar agent y engine explícitamente: no se permite depender de que el motor asigne Carson por defecto.

Salida de éxito estricta:

~~~~json
{
  "ok": true,
  "project_id": "UUIDv7",
  "session_id": "UUIDv7",
  "project_title": "string",
  "title_origin": "operator | automatic",
  "tags": ["string"],
  "workspace_root": "ruta validada"
}
~~~~

### 3.3 Contrato JSON estricto de SaveCycle

Raíz object; additionalProperties=false. Todos los campos indicados son obligatorios, aunque las colecciones puedan estar vacías.

~~~~json
{
  "project_id": "UUID del proyecto devuelto por Initialize",
  "session_id": "UUID de la sesión devuelto por Initialize",
  "cycle_number": 1,
  "stage": "divergence | convergence | synthesis | pause | completed",
  "mode": "facilitator | creative_partner | ideate_for_me",
  "techniques": ["nombre exacto devuelto por la fuente"],
  "items": [
    {
      "item_id": "string opcional; el motor lo deriva si se omite",
      "type": "idea | insight | question | decision | direction | technique",
      "full_text": "contenido íntegro y no resumido",
      "author": "operator | Carson | Maya | Dr. Quinn | Victor | Sophia | Caravaggio",
      "maturity": "draft | developing | mature",
      "reusable": false,
      "provenance": {
        "source": "ChatGPT conversation",
        "technique": "nombre de técnica o vacío",
        "notes": "procedencia adicional no sensible"
      }
    }
  ],
  "open_questions": ["string"],
  "decisions": ["string"],
  "links_to_previous": ["cycle_id o version_id"],
  "tags": ["string"],
  "maturity": "draft | developing | mature",
  "session_status": "active | paused | completed"
}
~~~~

Se rechazan tipos incorrectos, enums inválidos, cadenas vacías en full_text, cycle_number menor que 1, IDs desconocidos y propiedades no declaradas. La normalización no puede cambiar el significado ni omitir aportaciones. El modo, agente y motor se recuperan y contrastan con la sesión; no pueden contradecirla.

Salida de éxito estricta, tanto para creación como para repetición idempotente:

~~~~json
{
  "ok": true,
  "idempotent": false,
  "cycle_id": "UUIDv7",
  "version_id": "UUIDv7",
  "cycle_number": 1,
  "revision": 1,
  "sha256": "64 caracteres hex",
  "file": "projects/<project-id>/sessions/<session-id>/cycles/000001-r001.json",
  "index_updated": true
}
~~~~

En una repetición idéntica, idempotent=true y se devuelven los mismos cycle_id, version_id, revision, sha256 y file. index_updated solo puede ser true tras verificar el índice.

### 3.4 Contrato JSON estricto de ShowSession

Entrada:

~~~~json
{
  "session_id": "UUID de sesión"
}
~~~~

Salida de éxito:

~~~~json
{
  "ok": true,
  "project": {
    "project_id": "UUIDv7",
    "title": "string",
    "title_origin": "operator | automatic",
    "created_at": "ISO-8601",
    "updated_at": "ISO-8601",
    "tags": ["string"],
    "status": "active",
    "latest_version": "UUIDv7 o null"
  },
  "session": {
    "session_id": "UUIDv7",
    "project_id": "UUIDv7",
    "topic": "string",
    "goal": "string",
    "agent": "Carson | Maya | Dr. Quinn | Victor | Sophia | Caravaggio",
    "engine": "bmad-brainstorming | bmad-cis-design-thinking | bmad-cis-problem-solving | bmad-cis-innovation-strategy | bmad-cis-storytelling | bmad-cis-agent-presentation-master",
    "mode": "facilitator | creative_partner | ideate_for_me",
    "status": "active | paused | completed",
    "created_at": "ISO-8601",
    "updated_at": "ISO-8601",
    "last_saved_cycle": 1,
    "last_saved_version": "UUIDv7 o null",
    "tags": ["string"]
  },
  "cycles": [
    {
      "record_type": "product-design-cycle",
      "cycle_id": "UUIDv7",
      "version_id": "UUIDv7",
      "project_id": "UUIDv7",
      "session_id": "UUIDv7",
      "cycle_number": 1,
      "revision": 1,
      "stage": "divergence | convergence | synthesis | pause | completed | restore",
      "mode": "facilitator | creative_partner | ideate_for_me",
      "agent": "nombre exacto del agente de la sesión",
      "engine": "uno de los seis engine exactos de la matriz de perfiles",
      "techniques": ["string"],
      "items": [
        {
          "item_id": "string",
          "type": "idea | insight | question | decision | direction | technique",
          "full_text": "string íntegro",
          "author": "operator | Carson | Maya | Dr. Quinn | Victor | Sophia | Caravaggio",
          "maturity": "draft | developing | mature",
          "reusable": false,
          "provenance": { "source": "string", "technique": "string", "notes": "string" }
        }
      ],
      "open_questions": ["string"],
      "decisions": ["string"],
      "links_to_previous": ["string"],
      "tags": ["string"],
      "maturity": "draft | developing | mature",
      "restored_from_version_id": "UUIDv7 o null",
      "saved_at": "ISO-8601",
      "idempotency_sha256": "64 caracteres hex",
      "integrity": {
        "algorithm": "sha256",
        "sha256": "64 caracteres hex"
      },
      "file": "projects/<project-id>/sessions/<session-id>/cycles/000001-r001.json"
    }
  ]
}
~~~~

Todos los campos mostrados son obligatorios; los campos declarados como null admiten únicamente null o el tipo indicado. additionalProperties=false se aplica a la raíz, project, session, cada cycle, cada item y provenance. ShowSession valida hashes antes de presentar la sesión como reanudable. Si un ciclo no verifica, no lo presenta como íntegro ni continúa silenciosamente.

**Reanudación:** el perfil carga el resultado verificado de ShowSession como contexto de la sesión, identifica el último ciclo válido y continúa desde él. ShowSession no promete restaurar memoria interna de ChatGPT; entrega los datos persistidos necesarios para reconstruir el contexto conversacional.

### 3.5 Contrato JSON estricto de Verify

Entrada: objeto vacío {}.

Salida:

~~~~json
{
  "ok": true,
  "source_cycles": 1,
  "index_entries": 1,
  "issues": [],
  "sqlite_integrity": "ok",
  "source_index_consistent": true,
  "pending_recovery": false,
  "database": "library/library.sqlite"
}
~~~~

ok=true exige simultáneamente: hashes fuente válidos; correspondencia exacta JSON ↔ metadatos SQLite ↔ FTS5; PRAGMA integrity_check = ok; cero inconsistencias; cero journal de recuperación pendiente. Cualquier incumplimiento produce ok=false, lista de issues y código de salida distinto de cero.

### 3.6 Search y operaciones de recuperación

Search recibe:

~~~~json
{
  "query": "texto de búsqueda",
  "limit": 20,
  "project_id": "UUID opcional",
  "tag": "etiqueta exacta opcional",
  "maturity": "draft | developing | mature opcional",
  "agent": "Carson | Maya | Dr. Quinn | Victor | Sophia | Caravaggio opcional"
}
~~~~

Search combina FTS5 y los filtros proporcionados. No amplía V1.0 con filtros no listados.

RestoreVersion recibe {"version_id":"UUID"} y crea una nueva entrada de ciclo; no modifica ni elimina la versión fuente. ListProjects recibe {}. RebuildIndex recibe {}. Estas operaciones comparten validación, locking, rutas y códigos de error del contrato general.

## 4. Contrato operativo ChatGPT + RDC

### 4.1 Parámetros del CLI

La interfaz objetivo del wrapper queda fijada así:

| Parámetro | Obligatorio | Uso |
|---|---:|---|
| -Operation | Sí | Initialize, SaveCycle, Search, RebuildIndex, Verify, RestoreVersion, ListProjects o ShowSession. |
| -WorkspaceRoot | Sí | Raíz validada del almacén brainstorming. |
| -TerminalId | Sí | Identidad de terminal obtenida/contrastada mediante EP, no elegida libremente por el perfil. |
| -PayloadJson | Sí | JSON UTF-8 de la operación; usar {} para operaciones sin campos. |
| -TimeoutSeconds | No | Timeout explícito; valor predeterminado de diseño: 30 segundos. |
| -TestMode | Solo pruebas | Limita el workspace a raíces sintéticas permitidas. Nunca se usa para aceptar TP-01, TP-03 o Nivel B. |

Se elimina del contrato de producción el switch -ProtectedWorkspaceVerified. No se sustituye por otro booleano autodeclarado. La validación productiva se ejecuta dentro del flujo del wrapper contra el contrato verificable que EP entregue.

### 4.2 Forma de invocación desde cada perfil

Cada perfil construye el JSON y lo envía al mismo punto de entrada por RDC; no pide al operador copiar manualmente objetos ni ejecutar los comandos.

~~~~powershell
$store = "<ruta-del-modulo>\tools\Invoke-ProductDesignStore.ps1"
$payloadJson = $initializePayload | ConvertTo-Json -Depth 30 -Compress
& $store -Operation Initialize -WorkspaceRoot $WorkspaceRoot -TerminalId $TerminalId -PayloadJson $payloadJson -TimeoutSeconds 30
~~~~

Tras leer project_id y session_id de la salida real de Initialize, el perfil genera el payload SaveCycle y ejecuta:

~~~~powershell
$payloadJson = $saveCyclePayload | ConvertTo-Json -Depth 30 -Compress
& $store -Operation SaveCycle -WorkspaceRoot $WorkspaceRoot -TerminalId $TerminalId -PayloadJson $payloadJson -TimeoutSeconds 30
~~~~

Después ejecuta, sin alterar la ruta ni la identidad:

~~~~powershell
& $store -Operation ShowSession -WorkspaceRoot $WorkspaceRoot -TerminalId $TerminalId -PayloadJson $showSessionJson -TimeoutSeconds 30
& $store -Operation Verify -WorkspaceRoot $WorkspaceRoot -TerminalId $TerminalId -PayloadJson '{}' -TimeoutSeconds 30
~~~~

El comando es una especificación de interfaz para la versión corregida del wrapper; no afirma que el código actual ya implemente TimeoutSeconds, los JSON estrictos ni el preflight EP. En TestMode se añade -TestMode y se usa exclusivamente una raíz sintética autorizada. En producción no se pasa -TestMode ni -ProtectedWorkspaceVerified.

### 4.3 Reglas del ciclo de agente

1. El perfil identifica agente, motor y modo antes de Initialize.
2. El perfil consulta las fuentes que correspondan. Carson no puede recomendar técnicas antes de consultar el catálogo instalado.
3. El perfil conserva todas las ideas con texto íntegro, autoría y madurez.
4. Al finalizar una tanda, transición, pausa o cierre, construye el payload SaveCycle con las ideas y decisiones desde el último ciclo.
5. Ejecuta SaveCycle mediante RDC y evalúa exit code y JSON de resultado.
6. Solo anuncia guardado confirmado si SaveCycle devuelve ok=true, index_updated=true y file verificable.
7. Ejecuta ShowSession y Verify; compara IDs, ciclo, revisión, SHA y contenido de lectura de vuelta.
8. Si cualquiera de las verificaciones falla, informa NO CONFIRMADO / ERROR; no afirma que el ciclo esté guardado ni inicia silenciosamente un ciclo posterior.
9. Una reanudación ejecuta ShowSession, verifica el contenido devuelto y recupera el último ciclo válido antes de continuar.

## 5. Carson y catálogo BMAD 6.12.4

La ruta local previamente observada es:

~~~~text
C:\Users\fila4\Desktop\SeryMente\Metodologia\frentes\ep\modulos\MOD-EP-BMAD\app\node_modules\bmad-method
~~~~

El perfil Carson debe comprobar en tiempo de ejecución la versión instalada y la existencia de SKILL.md, brain.py y assets\brain-methods.csv. No basta con incorporar al prompt el dato histórico de 108 técnicas.

Secuencia RDC obligatoria:

1. Consultar el mapa del catálogo:

~~~~powershell
py -3 -B "<bmad-root>\src\core-skills\bmad-brainstorming\scripts\brain.py" categories
~~~~

2. Elegida la categoría, consultar sus técnicas reales:

~~~~powershell
py -3 -B "<bmad-root>\src\core-skills\bmad-brainstorming\scripts\brain.py" --file "<bmad-root>\src\core-skills\bmad-brainstorming\assets\brain-methods.csv" list --category "<category-slug>"
~~~~

3. Para cada técnica seleccionada, cargar la descripción completa y su detalle disponible:

~~~~powershell
py -3 -B "<bmad-root>\src\core-skills\bmad-brainstorming\scripts\brain.py" --file "<bmad-root>\src\core-skills\bmad-brainstorming\assets\brain-methods.csv" show "<exact-technique-name>"
~~~~

RDC debe devolver resultados observables. Carson elige técnicas solo entre esos resultados; no fabrica nombres ni descripciones. La evidencia de sesión conserva versión de paquete, SHA-256 del CSV, categorías consultadas, nombres exactos y salida relevante de list/show. La consulta del catálogo se ejecuta desde el host local; no se simula su contenido desde el prompt.

Para Maya, Dr. Quinn, Victor, Sophia y Caravaggio, TP-03 fija las fuentes locales del commit CIS de referencia y exige volver a comprobar existencia, contenido y SHA antes de aceptar cada perfil. No se reclama runtime nativo.

## 6. Memlog: exclusión y prueba negativa

El override textual MEMLOG_READ/WRITE/RESUME=DISABLED se conserva como instrucción de perfil, pero no es por sí mismo un control técnico.

La prueba automatizada de cada E2E debe:

- Monitorizar el inicio de procesos durante todo el ciclo y detectar la invocación de memlog.py en argumentos de py.exe/python.exe, sin depender del nombre visible del proceso.
- Monitorizar eventos de sistema de archivos sobre todos los roots pertinentes de la sesión: workspace de proyecto, output_folder y raíz de proyecto BMAD efectivamente configurados.
- Fallar ante creación, escritura, renombrado o eliminación de cualquier *.memlog.md.
- Ejecutar una búsqueda final de *.memlog.md en esos mismos roots.
- Conservar un reporte con roots monitorizados, ventana temporal, eventos de proceso, eventos de archivos y resultado.

Criterio PASS: cero ejecuciones de memlog.py, cero eventos de escritura sobre .memlog.md y cero archivos .memlog.md residuales. Una búsqueda final vacía, sin monitorización durante el ciclo, no acredita ausencia de escrituras transitorias. Si el entorno no permite observar los eventos requeridos, la prueba queda NO VERIFICADA, no PASS.

No se modifica ni se elimina el paquete BMAD instalado para obtener este resultado. La compatibilidad y el mecanismo de prevención efectivo deberán quedar resueltos antes de aceptar TP-01.

## 7. Modelo de persistencia V1.0

### 7.1 Fuente canónica y estructura

Los JSON son la fuente canónica. SQLite/FTS5 es un índice local derivado, reconstruible desde ellos.

~~~~text
<workspace-protegido>\projects\<project-id>\project.json
<workspace-protegido>\projects\<project-id>\sessions\<session-id>\session.json
<workspace-protegido>\projects\<project-id>\sessions\<session-id>\cycles\000001-r001.json
<workspace-protegido>\library\library.sqlite
<workspace-protegido>\.product-design-writer.lock
~~~~

La ruta anterior es una estructura lógica. Su ruta física montada y autorizada la determinará EP; no se presupone que empiece en C:\, W:\ o una carpeta SeryMente sin evidencia del montaje.

### 7.2 Índice mínimo

El índice utiliza:

- Tabla metadata por versión/ciclo: version_id, project_id, session_id, cycle_id, agent, maturity, tags y hash fuente.
- Tabla FTS5 de texto: IDs no indexados más project_title, topic, goal, contenido íntegro y tags.
- Una fila metadata y una fila FTS5 por ciclo/revisión.

No se crea un grafo entre proyectos ni una capa relacional de Save As. La tabla metadata existe para filtros exactos y cotejo de consistencia, no para introducir una arquitectura de relaciones.

### 7.3 Atomicidad y recuperación

1. Validar JSON, IDs, enums, ruta y estado de sesión.
2. Adquirir .product-design-writer.lock antes de consultar ciclos existentes, revisiones, manifiestos o elegir el siguiente número.
3. Bajo el lock, comprobar colisiones e idempotencia.
4. Escribir un journal de operación recuperable antes del cambio multicomponente.
5. Promover archivos JSON mediante staging local, flush/fsync y reemplazo atómico.
6. Actualizar metadata y FTS5 en una transacción SQLite.
7. Verificar hashes fuente, fila metadata y fila FTS5 contra el mismo ciclo.
8. Retirar journal y liberar lock solo al confirmar consistencia.
9. Si falla una fase, no devolver ok=true. Mantener información suficiente para una recuperación idempotente; Verify debe detectar el journal y el estado parcial.
10. RebuildIndex reconstruye metadata y FTS5 únicamente desde JSON verificados.

La fuente canónica no se sustituye por el índice. Un índice desactualizado bloquea la aceptación del guardado hasta reconstrucción y verificación; nunca se marca index_updated=true por el mero hecho de haber intentado el INSERT.

### 7.4 Lock y concurrencia

El lock conserva PID, hora UTC de creación, identificador de terminal, identidad Windows y marca de inicio del proceso. El motor adquiere el lock antes de leer las revisiones. Las pruebas incluyen dos o más escritores concurrentes sobre el mismo ciclo y sobre ciclos distintos, guardados idénticos, revisiones divergentes y muerte de proceso.

El TTL inicial de diseño es 600 segundos. Solo habilita la evaluación de obsolescencia; no autoriza por sí solo a eliminar el lock. Se recupera automáticamente únicamente si se demuestra que el proceso propietario terminó y que el PID no fue reutilizado. Si no puede demostrarse, se falla cerrado y se requiere recuperación controlada.

### 7.5 Verify e integridad SQLite

Verify ejecuta PRAGMA integrity_check y exige el resultado exacto ok. Además:

- Recorre todas las rutas fuente aplicando la validación uniforme.
- Verifica SHA-256 de project.json, session.json y ciclos.
- Compara todos los ciclos y revisiones fuente con metadata.
- Compara metadata con FTS5, incluidos IDs, texto y tags.
- Verifica conteos, duplicados, referencias a proyecto/sesión y journal pendiente.
- Reporta las discrepancias y no oculta errores de lectura o de índice.

### 7.6 Rutas y symlinks

Toda operación de creación, lectura, enumeración, reemplazo, borrado temporal o reconstrucción pasa por la misma función de canonicalización y containment. Se rechazan symlinks, junctions, reparse points y cualquier ruta que escape del workspace. La verificación se aplica también a cada elemento devuelto por glob/listado y al archivo temporal, no solo a la raíz. Las operaciones críticas revalidan la ruta antes de abrir/escribir para reducir condiciones TOCTOU.

### 7.7 Wrapper PowerShell

El wrapper debe:

- Validar parámetros y JSON antes de iniciar Python.
- Lanzar el proceso con stdin/stdout/stderr redirigidos.
- Consumir stdout y stderr asíncronamente; nunca hacer ReadToEnd secuencial con ambos pipes redirigidos.
- Aplicar TimeoutSeconds, esperar la salida final y al vencer terminar el proceso y su árbol de descendientes.
- No aceptar resultado parcial como éxito.
- Emitir una sola respuesta JSON en stdout; diagnósticos a stderr.
- Propagar códigos de salida y mensajes de error estables.
- No exponer secretos en argumentos, salida o logs.

## 8. Tabla de TP-# pendientes y correctivas

No se crean IDs EP-TASK adicionales. TP-01 y TP-02 siguen vinculados a EP-TASK-009 y EP-TASK-010; TP-03 conserva su condición de bloque de trabajo sin ID EP-TASK asignado.

| TP | Alcance corregido | Estado tras auditoría | Dependencias | DoD obligatorio |
|---|---|---|---|---|
| TP-01 · Carson / Oleada 1 | Corregir CARSON-CHAT.md para el contrato R#; consulta dinámica BMAD por RDC; persistencia por ciclo en TestMode; auditoría negativa memlog. | PASS · E2E TestMode 3/3 modos Carson (facilitator, creative_partner, ideate_for_me); no depende de EP-C0 ni de TP-02B. BMAD 6.12.4 consultado dinámicamente. | TP-02A PASS; BMAD 6.12.4 instalado y consultable; auditor FileSystemWatcher activo. | Carson completa sesión real en ChatGPT; consulta categories/list/show por RDC; genera JSON estricto; ejecuta Initialize + SaveCycle + ShowSession + Verify vía wrapper con -TestMode; SHA y read-back coincidentes; snapshot antes/después y cero eventos memlog. Los tres modos se ejercitan en sesiones efectivas. |
| TP-02A · Nivel A | Endurecer motor Python stdlib y wrapper PowerShell nativo; schemas; lock y TTL; journal/recuperación; paridad JSON/SQLite/FTS5; filtros; restore; reanudación y timeout. | PASS · 14/14 pruebas unitarias/integración sintética; concurrencia, fallo intermedio/recuperación, locks y timeout incluidos. | Diseño aprobado; raíz sintética aislada bajo %TEMP%\_ep_product_design_synthetic. | Suite sintética PASS; concurrencia multiproceso sin colisiones; lock vivo no recuperado y huérfano vencido recuperable; inyección de fallo intermedio sin falso ok y recuperación PASS; timeout mata árbol hijo; stdout/stderr simultáneos; PRAGMA integrity_check y FTS5 integrity-check; filtros project/tag/maturity/agent; RestoreVersion y ShowSession. |
| TP-02B · Nivel B | Integrar el almacén con workspace real protegido y contrato EP; verificar identidad y ruta montada; incorporar Product Design al backup/restore EP. | BLOQUEADO POR EP · no se usa -ProtectedWorkspaceVerified ni preflight autodeclarado. | EP-C0.1..C0.4: ruta Cryptomator, verificador, TerminalId/identidad y cobertura backup/restore aceptados; autorización expresa para escritura productiva. | Preflight EP verifica montaje, bóveda, raíz, SID, TerminalId, RDC device y ACL; escritura/read-back de fixture autorizado; backup B2 del directorio Product Design; download a staging; SHA cotejado; restore probado sin sobrescribir la fuente. |
| TP-03 · cinco agentes / Oleada 2 | Corregir MAYA, DR-QUINN, VICTOR, SOPHIA y CARAVAGGIO para el contrato común; fijar fuentes CIS; integrar los cinco al mismo CLI y recuperación. | PASS · E2E TestMode 5/5 perfiles CIS adaptados (Maya, Dr. Quinn, Victor, Sophia, Caravaggio); no depende de EP-C0 ni de TP-02B. No se afirma runtime CIS nativo. | TP-02A PASS; TP-01 Carson E2E PASS; fuentes CIS locales de los cinco agentes verificadas. | Una sesión E2E real ChatGPT + RDC + wrapper -TestMode por perfil; fuente local/hash verificados; JSON estricto; Initialize + SaveCycle + ShowSession + Verify reales; SHA/read-back; registro de comandos y auditoría FileSystemWatcher + snapshot antes/después con cero eventos memlog. |

### 8.1 Secuencia interna de TP-03

Orden de ejecución: TP-02A PASS → TP-01 Carson E2E PASS → TP-03: Maya → Dr. Quinn → Victor → Sophia → Caravaggio. Cada perfil se acepta por su propio E2E; el PASS de otro perfil no se hereda. Los seis flujos se ejecutan con el wrapper real en -TestMode y workspace sintético, sin esperar EP-C0 ni TP-02B. Caravaggio se evalúa contra las capacidades publicadas y verificadas en su fuente local; no se le exige generar PPTX ni ejecutar workflows no publicados/instalados. No se acepta un plan textual pregrabado como prueba de Caravaggio.

### 8.2 Evidencia mínima por perfil

Cada E2E conserva: perfil y versión/hash; fuente local y revisión; comandos RDC realmente ejecutados y salidas sin secretos; payloads JSON y validación de schema; IDs devueltos; ruta relativa y nombre real del ciclo; SHA-256; salida de ShowSession; salida de Verify; snapshot memlog previo y posterior; eventos de FileSystemWatcher; resultado y límites. FileSystemWatcher se configura con System.IO.FileSystemWatcher sobre los roots pertinentes, Filter=*.memlog.md e IncludeSubdirectories=true; el auditor registra Changed/Created/Deleted/Renamed/Error durante la ventana completa. El log de comandos RDC se anexa al expediente E2E. PASS exige cero eventos y cero diferencias de snapshot. Si un root no puede monitorizarse o el watcher reporta Error/overflow, el resultado es NO VERIFICADO.

### 8.3 Resultado del ciclo autorizado · 2026-11-15

- **TP-02A:** PASS, 14/14 pruebas. Incluye cuatro escritores concurrentes (revisiones 1–4), fallo inyectado tras escritura del ciclo sin falso éxito y recuperación por journal, lock de proceso vivo no recuperado, lock huérfano vencido recuperado, `RestoreVersion`, filtros, desalineación FTS5 detectada/reconstruida, y timeout de 1 s que termina el árbol Python.
- **TP-01:** PASS en TestMode, Carson 3/3 modos. BMAD 6.12.4: consulta dinámica de 13 categorías/108 técnicas, lista de 8 técnicas de `collaborative` y `show Random Stimulation` (1 resultado). Cada modo completó Initialize, SaveCycle, ShowSession y Verify.
- **TP-03:** PASS en TestMode, 5/5 perfiles adaptados; Maya, Dr. Quinn, Victor, Sophia y Caravaggio completaron la cadena. Cada archivo de perfil se hasheó. Este resultado prueba la integración de perfiles conversacionales locales con el wrapper y el almacén; **no** certifica un runtime CIS nativo instalado.
- **Consolidado:** 6 perfiles, 8 sesiones, 8 ciclos, 8 SHA de ciclo iguales a su read-back, 8/8 verificaciones SQLite/FTS5 con `integrity_check=ok` y cero journals pendientes.
- **R-04 memlog:** PASS. FileSystemWatcher activo en tres roots durante toda la ventana E2E; snapshot previo/posterior completo, 0 archivos `*.memlog.md`, 0 eventos, 0 diferencias y 0 errores/overflow del watcher.
- **TP-02B:** continúa BLOQUEADA hasta aceptar EP-C0.1..C0.4 y autorización específica de transición productiva. Los resultados anteriores son exclusivamente TestMode.
- **R-17:** PASS · la ruta canónica no es junction en esta instancia; 23 archivos del módulo se sincronizaron desde el checkout por SHA-256 exacto. Se preservaron sin cambios las carpetas canónicas existentes `app`, `launchers` y `logs`; no se modificaron otros archivos del frente EP.

## 9. Dependencia previa con EP · TP-02B

EP debe entregar un contrato operativo verificable antes de activar la ruta productiva.

### EP-C0.1 Ruta física y Cryptomator

EP identifica y confirma:

- Ruta real del montaje desbloqueado de Cryptomator en la identidad Windows autorizada.
- Identidad de la bóveda y raíz física correspondiente.
- Ruta lógica dentro de esa bóveda para MOD-EP-PRODUCT-DESIGN/data/<TerminalId>/brainstorming.
- Comprobación de que el workspace resuelto está dentro del montaje autorizado y no en una carpeta homónima, copia temporal o raíz no cifrada.
- Tratamiento de desconexión, bloqueo, desmontaje y cambio de letra/ruta.

No se presupone W:\ ni la ruta lógica histórica como montaje físico aceptado. El estado observado durante la auditoría mostró W:\ sin el workspace Product Design; debe revalidarse en la sesión de desbloqueo y por el procedimiento oficial de EP.

### EP-C0.2 Verificador de workspace protegido

EP especifica un punto de verificación invocable y su resultado estructurado. El verificador debe acreditar al menos: vault/mount ID; estado desbloqueado; ruta física y raíz lógica; containment de la ruta Product Design; identidad Windows/SID; correspondencia con la terminal RDC autorizada; ACL esperadas; capacidad de crear, leer de vuelta y retirar un canary sintético en la ubicación autorizada.

El wrapper consume ese resultado y vuelve a comprobar la ruta efectiva. No acepta un switch, variable, parámetro o JSON que el mismo agente se limite a declarar como “verificado”. EP conserva la autoridad sobre sus identidades y mecanismos; Product Design no inventa nombres de comandos ni suplanta un contrato EP inexistente.

### EP-C0.3 Identidad estable de terminal

EP define TerminalId como identidad de terminal física/lógica registrada y lo vincula a:

- RDC device UUID.
- Identidad Windows/SID que realiza las operaciones.
- Ubicación/perfil general, mantenido como dato separado.
- Raíz Product Design autorizada.

El hostname o nombre del cibercafé no es identidad de terminal. El agente no asigna TerminalId por inferencia ni reutiliza el ID de otro equipo.

### EP-C0.4 Cobertura de backup/restore B2

EP determina cómo incluir en su mecanismo existente el directorio:

~~~~text
MOD-EP-PRODUCT-DESIGN\data\<TerminalId>\brainstorming\
~~~~

La aceptación requiere un snapshot que contenga efectivamente esa ruta y registros de Product Design, un upload verificado, descarga independiente, SHA-256 de retorno y restauración en staging con Verify PASS y ShowSession utilizable. Los recibos EP R2/R4 y el ciphertext de la bóveda registrados el 2026-11-10 no contienen este almacén; no cuentan como cobertura de Product Design.

No se crea un backup paralelo ni se añade otro proveedor. Se reutiliza el mecanismo EP aceptado, una vez que EP determine su ruta y operación exactas.

### EP-C0.5 Estado de bloqueo

Hasta que EP-C0.1 a EP-C0.4 estén aceptados, TP-02B no puede pasar a producción. Esto no bloquea los E2E funcionales de TP-01 ni TP-03: ambos se ejecutan ahora en -TestMode contra un workspace sintético y pueden obtener PASS de validación conversacional/técnica aislada. Ese PASS no acepta persistencia productiva ni cierra V1.0. No se escriben ideaciones reales en Desktop, AppData, el clon Git o una carpeta canónica no verificada; los únicos registros de prueba viven bajo %TEMP%\_ep_product_design_synthetic.

## 10. DAG de dependencias

~~~~text
                    APROBACIÓN DEL SPRINT
                              |
                        TP-02A · NIVEL A
                   hardening + suite TestMode
                              |
                        TP-01 · CARSON
                BMAD dinámico + CLI TestMode
                              |
                    CONTRATO COMÚN ACEPTADO
                              |
                        TP-03 · CIS x5
                 Maya → Quinn → Victor → Sophia → Caravaggio
                              |
                 GATE E2E SINTÉTICO · 6/6
                              |
              RESULTADOS + SHA + READ-BACK + MEMLOG
                              |
             CIERRE DE EJECUCIÓN TESTMODE

       EP-C0.1..C0.4 ──────────────┐
              |                    |
              v                    |
       TP-02B · NIVEL B             |
       preflight real + backup     |
              |                    |
              +────────────────────┘
                   GATE PRODUCTIVO V1.0
                   (no se ejecuta ahora)

Commit/push: NO AUTORIZADOS en este ciclo
~~~~

La ruta crítica de esta autorización es estrictamente secuencial: TP-02A → TP-01 → TP-03, usando siempre -TestMode y el workspace sintético permitido. TP-01 y TP-03 no dependen de EP-C0 ni de TP-02B para ejecutar ni validar sus E2E aislados. EP-C0.1..C0.4 avanza por separado; TP-02B solo se activa cuando esos cuatro entregables estén aceptados y el operador autorice la transición productiva. El PASS de TestMode no se confunde con persistencia productiva ni con el cierre de V1.0.

## 11. Ruta crítica

1. Ejecutar TP-02A en aislamiento TestMode: corregir lock, recuperación, consistencia JSON/SQLite/FTS5, Verify, filtros, restauración, rutas y wrapper; pasar pruebas reales de concurrencia, fallo intermedio y timeout.
2. Ejecutar TP-01 inmediatamente después: Carson consulta BMAD dinámicamente por RDC y completa Initialize + SaveCycle + ShowSession + Verify en TestMode; auditar memlog durante el ciclo.
3. Ejecutar TP-03 inmediatamente después: Maya, Dr. Quinn, Victor, Sophia y Caravaggio, secuencialmente, cada uno con su fuente verificada y E2E real en TestMode.
4. Consolidar el gate E2E aislado 6/6: schemas, IDs, ciclos, revisiones, SHA/read-back, Verify, filtros, y auditoría memlog sin eventos.
5. En paralelo independiente, EP entrega EP-C0.1 a EP-C0.4: ruta Cryptomator, verificador, identidad TerminalId y cobertura específica backup/restore.
6. Mantener TP-02B bloqueada hasta la aceptación de EP-C0.1..C0.4 y una autorización específica de transición productiva; no usar el switch ProtectedWorkspaceVerified ni sustituir el preflight por una declaración.
7. Entregar los resultados reales del ciclo TestMode para evaluación. No declarar V1.0 productiva terminada por los PASS sintéticos.
8. Commit y push quedan expresamente fuera de esta autorización y requieren instrucción posterior.

## 12. Bloqueantes anticipados

| ID | Bloqueante | Estado observado / riesgo | Condición para desbloquear |
|---|---|---|---|
| B-01 | Ruta física Cryptomator | No hay una ruta montada de Product Design aceptada; W:\ no mostraba el workspace durante la auditoría. | EP identifica y prueba montaje, vault ID y raíz física. |
| B-02 | Verificación protegida | El código actual confía en -ProtectedWorkspaceVerified, un switch autodeclarado. | EP proporciona verificador estructurado y el wrapper lo consume; el switch se elimina. |
| B-03 | Identidad terminal | TerminalId se recibe como texto y no se contrasta con identidad de dispositivo/sesión. | EP vincula TerminalId, RDC UUID, SID y raíz autorizada. |
| B-04 | Backup Product Design | Los recibos R2/R4 revisados no incluyen MOD-EP-PRODUCT-DESIGN ni su almacén de brainstorming. | Snapshot, upload, read-back, SHA y restore específicos PASS. |
| B-05 | Agentes no conectados | Los seis prompts no ejecutan actualmente el ciclo del CLI. | Contrato común y seis E2E individuales PASS. |
| B-06 | BMAD dinámico | El catálogo 6.12.4 existe y brain.py categories se ejecutó, pero Carson aún no acredita categories/list/show dentro de un E2E. | Consulta dinámica registrada y vinculada a la sesión persistida. |
| B-07 | Memlog | El SKILL upstream contiene instrucciones memlog; el override de texto no bloquea por sí solo ejecución/escritura. | Auditoría de proceso y filesystem integrada; cero eventos en todos los E2E. |
| B-08 | Consistencia de almacenamiento | El motor actual puede guardar JSON y devolver ok=true aunque el índice falle; no tiene verificación SQLite integral. | Journal/recovery, transacción de índice, Verify ampliado y fault-injection PASS. |
| B-09 | Concurrencia y locks | Revisión/idempotencia se consulta antes de adquirir el lock; lock obsoleto sin recuperación verificada. | Lock previo a lectura, TTL seguro y pruebas concurrentes PASS. |
| B-10 | Canonización del archivo | El clon de retoma es checkout Git; SeryMente\Metodologia es una carpeta sin .git observada. No se acreditó el mecanismo de sincronización. | EP identifica mecanismo de sync y se coteja SHA/read-back en ambos destinos y origin/main. |

## 13. Sincronización: clon de retoma → origin/main → carpeta canónica

La observación de esta auditoría distingue:

- Clon Git de trabajo: C:\Users\fila4\Desktop\SeryMente\Metodologia-EP-RETOMA-20261114. Tiene .git, rama main y origin/main. El HEAD consultado fue c3205f2639696c973e7fa0030fdc7ff1e85a63c9.
- Carpeta canónica local: C:\Users\fila4\Desktop\SeryMente\Metodologia. No se encontró .git en esa raíz. Se trata como carpeta sincronizada/materializada, no como checkout en el que se pueda ejecutar git pull.
- origin/main es el remoto Git; no se presupone que la carpeta canónica se actualice automáticamente ni se inventa el servicio que lo haría.

Flujo obligatorio después de aprobación expresa:

1. Mantener el trabajo documental en el clon de retoma; revisar el diff únicamente del Sprint y su SHA-256. No tocar la carpeta canónica durante la fase de evaluación.
2. Recibir aprobación expresa del operador para promover. Esa aprobación no se presume de una revisión favorable.
3. Seguir el mecanismo de commit/push aprobado hacia origin/main; no hacer commit ni push por esta revisión.
4. EP identifica/ejecuta el mecanismo real que materializa origin/main en SeryMente\Metodologia. No copiar manualmente ni ejecutar git pull en una carpeta que no tiene .git.
5. Leer de vuelta el Sprint en el clon, obtener el contenido de origin/main y leer el archivo recibido en la carpeta canónica.
6. Calcular SHA-256 en los tres destinos y exigir coincidencia exacta; además comprobar que el archivo canónico corresponde al blob de main.
7. Si el mecanismo de sync no está identificado, no hay read-back o los hashes difieren, detener la promoción y registrar NO SINCRONIZADO.

## 14. Criterios de aceptación de V1.0

V1.0 solo se acepta cuando se cumplen todos los siguientes gates:

- G1 — Contrato: los seis perfiles respetan las entradas/salidas JSON y el CLI definidos aquí.
- G2 — Carson/BMAD: una sesión real consulta categories/list/show por RDC y usa las técnicas devueltas.
- G3 — TP-02A: motor y wrapper pasan schema, rutas, locks, concurrencia, crash-recovery, índice, filtros, restore y Verify.
- G4 — EP/TP-02B: workspace y terminal verificados mediante EP; backup y restore incluyen Product Design.
- G5 — Memlog: cada E2E acredita cero invocaciones y cero escrituras .memlog.md mediante monitorización durante el ciclo.
- G6 — Agentes: Carson y los otros cinco completan cada uno al menos un flujo E2E real.
- G7 — Persistencia: cada perfil ejecuta Initialize, SaveCycle, ShowSession y Verify; SHA y contenido de lectura de vuelta coinciden.
- G8 — Funciones V1.0: búsqueda por texto y filtros project/tag/maturity/agent; RestoreVersion conserva la fuente; ShowSession permite reanudar.
- G9 — Integridad: no hay locks activos abandonados, journal pendiente, índice divergente, ruta fuera del workspace ni errores de integridad SQLite.
- G10 — Promoción: la versión aceptada se sincroniza desde origin/main hasta la carpeta canónica con SHA/read-back coincidente, después de autorización expresa.

Un gate pendiente, no observado o basado solo en escenario de texto se declara PENDIENTE/NO VERIFICADO. No se convierte en PASS por la aprobación de un gate anterior.

## 15. No alcance y requisitos retirados de V1.0

Quedan expresamente fuera de este Sprint:

- Grafo relacional entre proyectos, referencias multi-proyecto y reutilización transversal como entidad compartida.
- Save As y creación de proyectos derivados.
- Portal, dashboard, Brain Selector y Keepsake HTML.
- Runtime CIS nativo o despliegue de agentes como procesos/subagentes.
- Generación automática de PPTX/artefactos de Caravaggio no presentes en sus capacidades locales verificadas.
- Integración con Prótesis Cognitiva y cognición visoespacial.
- Integración operativa de Superpowers.

No se deben mantener como capacidades, pantallas, tablas, filtros o criterios de aceptación de V1.0. Su eventual reconsideración requiere instrucción y alcance posteriores.

## 16. Evidencia anterior y estado corregido

Los siguientes resultados se conservan, pero su alcance se limita:

- TP-01: F-01, CP-01 e I-01 son transcripciones sintéticas manuales. Acreditan únicamente que se redactaron ejemplos de comportamiento. No aceptan Carson ni un modo de producto.
- TP-02: las 12 pruebas sintéticas PASS acreditan el comportamiento de los casos existentes del código anterior en el entorno de prueba. No acreditan concurrencia, crash-recovery, consistencia estricta del índice, workspace protegido, backup ni restore Product Design.
- TP-03: los cinco escenarios sintéticos son documentación de evaluación. No aceptan ninguno de los cinco agentes.
- BMAD: se comprobó en RDC que bmad-method local era 6.12.4 y brain.py categories devolvió 13 categorías con conteos que sumaban 108 técnicas. Esto no demuestra todavía que Carson haga la consulta durante una sesión real.
- EP/B2: existen recibos de snapshots EP R2/R4 y ciphertext con SHA/read-back reportados. No incluyen el almacén Product Design y no satisfacen TP-02B.

La evidencia de cada reejecución correctiva se vincula a código/hash, terminal, identidad, ruta, comandos, salida, SHA, read-back y resultado. Se distingue prueba unitaria sintética de aceptación de producto real.

## 17. Fuentes y procedencia

- SRC-PD-20261113-IDEACION-03: instrucción del operador sobre Carson chat-first, guardado por ciclo, auto-nombre, borradores y biblioteca.
- SRC-PD-20261113-ALCANCE-02: chat como interfaz suficiente; Brain Selector y Keepsake no deben introducir trabajo adicional para el operador.
- SRC-PD-20261113-CORRECCION-01: Superpowers solo como referencia; estructura de tareas y rigurosidad esperada.
- Rectificación del operador del 2026-11-14: V1.0 comprende seis agentes; Carson TP-01 y los cinco restantes TP-03.
- BMAD Core local: paquete 6.12.4; skill bmad-brainstorming y scripts/brain.py.
- CIS: commit de referencia 658e71030be808181c1031f5461ee3613e7ff530. Debe revalidarse el contenido local de cada perfil antes de su E2E.
- EP: OEP y tareas vigentes EP-TASK-002 y EP-TASK-004 son las fuentes para backup, bóveda, identidad y seguridad. No se crea un objeto EP ni una autoridad paralela desde Product Design.

---

## 18. Estado de autorización de esta revisión

**Entregable de este turno:** exclusivamente esta revisión del Sprint.

**Permitido por esta instrucción:** corregir y materializar este documento de diseño en el clon de retoma para su evaluación.

**No autorizado en esta fase:** modificar perfiles, código Python, wrapper PowerShell, pruebas, READMEs de tareas, índices EP, OEP, controles, bóveda, Cryptomator, configuración de backup, ni archivos de la carpeta canónica; ejecutar pruebas de agentes o persistencia real; commit; push; sincronización/promoción.

**Estado de cierre:** PENDIENTE DE EVALUACIÓN DEL OPERADOR. La autorización para implementar el código se solicitará únicamente después de aceptar esta revisión.
