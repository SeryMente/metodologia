# Especificación Completa de Evidencia Normativa por Turno

**Estado:** ESPECIFICACIÓN OPERATIVA
**Versión:** v0.7.0 — Gate Thinking + Formato Obligatorio + Liberación Verificada  
**Fecha:** 2026-10-07  
**Ámbito:** mecanismo para obtener evidencia externa, reproducible y auditable de que cada turno elegible de ejecución de ChatGPT fue gobernado por la totalidad del Sistema de Instrucciones Metacognitivas (SI) vigente al inicio del turno.  
**Relación con el SI:** este documento especifica un mecanismo de aplicación y verificación. El SI v1.6.0 canoniza P028 · Trazabilidad Normativa, P029 · Identidad y Vigencia Canónica, P030 · Fidelidad Terminológica Canónica, P031 · Normalización de Transcripción y P032 · Contexto Operativo Verificado; este documento desarrolla su aplicación sin añadir mecanismos al nivel de principio.

**Fuente normativa canónica:**  
https://github.com/SeryMente/metodologia/blob/main/SI-METACOGNITIVO.md

**Implementación de verificador existente:**  
https://github.com/SeryMente/khora/blob/main/khora-web/lib/server/norm-check.ts

---

## 1. Propósito

El mecanismo debe permitir comprobar, para cada turno verificable:

1. qué versión exacta del SI gobernó el turno al inicio;
2. qué totalidad de principios canónicos existía en esa versión;
3. que cada principio fue sometido a evaluación;
4. qué aplicación, no aplicabilidad o conflicto se registró para cada principio;
5. que la evidencia pertenece al turno y a su resultado;
6. que la evidencia no fue alterada después del sellado;
7. que un verificador externo puede reproducir el veredicto;
8. que una corrección no elimina intentos anteriores;
9. que la comprobación ordinaria es compacta y de baja latencia;
10. que la misma arquitectura sigue funcionando aunque el SI evolucione y cambie el número de principios.

---

## 2. Límite epistemológico

No es demostrable externamente que el modelo haya tenido un estado interno denominado «lectura» o «consideración mental» de un principio.

La propiedad que el sistema sí puede certificar es:

> El turno fue vinculado a una instantánea exacta del SI; la totalidad de sus principios fue evaluada formalmente; la evidencia quedó vinculada al turno; KHORA verificó su integridad y completitud; y el veredicto puede reproducirse posteriormente.

Por tanto:

- **Evidencia estructural** = determinista.
- **Integridad criptográfica** = determinista.
- **Completitud del catálogo** = determinista.
- **Validez semántica profunda de una aplicación** = evidencia adicional, no reducible a una etiqueta autodeclarada.

---

## 3. Unidad de verificación

### 3.1 Turno

Un **turno** es una unidad de entrada del usuario → ejecución del modelo → resultado del modelo que deba quedar sujeta a comprobación.

### 3.2 Ciclo

En esta especificación, cada turno verificable constituye un **ciclo normativo**.

Esto elimina una ambigüedad de versiones anteriores: no existe una comprobación por «proyecto» separada del turno para el fast path. El turno es la unidad mínima auditable.

### 3.3 Identidad

Cada turno debe tener:

- conversation_id: identificador externo y opaco administrado por el adaptador;
- turn_number: secuencia monotónica dentro de la conversación;
- cycle_id: combinación canónica de ambos;
- attempt: intento de verificación del mismo turno.

Formato recomendado:

    cycle_id = <conversation_id>/T<turn_number>

No se debe depender de identificadores internos no garantizados por la interfaz de ChatGPT.

---

## 4. Arquitectura completa

    SI CANÓNICO
         │
    version + blob + sha
         │
         ▼
    ┌───────────────┐
    │     KHORA     │
    │  NORM CHECK   │
    └───────┬───────┘
            │
       OPEN TURN
            │
            ▼
    ┌──────────────────────────┐
    │ MCP CANÓNICO MULTIUSO    │
    │ /api/mcp                 │
    │                          │
    │ volcados · runtime       │
    │ gobernanza · demás Cora  │
    └──────────┬───────────────┘
            │
       snapshot + nonce
            │
            ▼
       CICLO CHATGPT
            │
     ┌──────┴──────┐
     │             │
  ejecución     evidencia
     │             │
     └──────┬──────┘
            ▼
        VERIFY TURN
            │
            ▼
        ┌───────┐
        │ KHORA │
        └───┬───┘
            │
      ┌─────┴────────┐
      ▼              ▼
   VERIFIED      INVALID/
                  INCOMPLETE
      │
      ▼
  TURNO VALIDADO
      │
      ▼
  REGISTRO HISTÓRICO

Responsabilidades:

- **SI:** autoridad normativa.
- **KHORA:** autoridad de verificación.
- **MCP canónico:** una única puerta de entrada de Cora/KHORA para todas las plataformas; las capacidades se separan mediante herramientas y scopes.
- **ChatGPT:** ejecución de la tarea y producción de evidencia compacta.
- **Registro:** memoria auditable de aperturas, intentos y veredictos.
- **UI KHORA:** observabilidad humana; no participa en el juicio normativo.

---

## 5. Decisiones de arquitectura cerradas

Se adoptan las siguientes decisiones para esta versión:

| Decisión | Regla |
|---|---|
| Unidad | 1 turno verificable = 1 ciclo normativo |
| Fuente normativa | SeryMente/metodologia/SI-METACOGNITIVO.md |
| Identidad normativa | versión + Git blob SHA + SHA-256 + manifest SHA-256 |
| Catálogo | dinámico; nunca codificado como «9 principios» |
| Apertura | el servidor crea snapshot y nonce |
| Aplicación | vector A/N/C por principio |
| Evidencia | anchors para A/C; reason_code para N |
| Integridad | SHA-256 + canonicalización |
| Transporte | Un único recurso MCP `/api/mcp`; REST solo como backend/compatibilidad |
| Persistencia | KHORA/Neon |
| Cierre | solo tras VERIFIED |
| Rechazo | no sobrescribir; nuevo attempt |
| Fast path | estructural, determinista, O(N) |
| Auditoría semántica | selectiva/asíncrona |
| Seguridad | OAuth por cliente o Bearer manual gestionado por KHORA; secretos no persistidos en claro |

---

## 5.1 Regla de cardinalidad MCP

Existe **un único recurso MCP canónico** para Cora/KHORA: `/api/mcp`.

Todas las capacidades actuales y futuras se publican dentro de ese recurso. No se crean MCP separados para gobernanza, volcados, runtime, memoria u otras funciones.

Los clientes de distintas plataformas pueden utilizar el mismo recurso mediante OAuth o mediante un Bearer Token manual emitido por KHORA. La autorización se expresa mediante scopes mínimos:

- `volcados:read` — volcados y revisión;
- `runtime:read` — observabilidad;
- `norm:turn` — apertura y verificación normativa.

El mismo recurso `/api/mcp` admite dos métodos de autenticación: OAuth 2.0 para clientes que soportan descubrimiento/autorización y un Bearer Token manual generado por KHORA para plataformas que permiten introducir una credencial estática. El token manual es opaco, de alta entropía, limitado por scopes, con caducidad y revocación individual; KHORA conserva únicamente su hash. La revocación global por generación invalida tanto OAuth como los Bearer manuales.

Añadir una capacidad no crea otra puerta de entrada; añade una herramienta y, solo cuando sea necesario, un scope.

## 6. Apertura del turno

La comprobación debe comenzar con una operación explícita de apertura.

### 6.1 Operación

    POST /api/norm-check/turn/open
    X-KHORA-KEY: <server-secret>
    Content-Type: application/json

Solicitud mínima:

    {
      "conversation_id": "cv_8f5a...",
      "turn_number": 42
    }

### 6.2 Respuesta

    {
      "ok": true,
      "turn": {
        "cycle_id": "cv_8f5a.../T42",
        "turn_number": 42,
        "attempt": 1,
        "turn_token": "opaque-server-token",
        "nonce": "random-128-bit-or-more",
        "opened_at": "2026-10-06T19:30:00.000Z"
      },
      "snapshot": {
        "version": "v1.2.0",
        "version_name": "Identidad Versionada y Vigencia Canónica",
        "last_updated_at": "2026-10-06T16:42:13-06:00",
        "git_blob_sha": "...",
        "sha256": "...",
        "manifest_sha256": "...",
        "principles": []
      },
      "verifier": {
        "protocol": "NORM-CHECK",
        "protocol_version": "v0.4.0",
        "verifier_version": "norm-check/0.3.0"
      }
    }

### 6.3 Regla

La apertura debe ocurrir antes de la ejecución sustantiva del turno.

Un cambio del SI posterior a la apertura no altera el snapshot del turno abierto.

---

## 7. Snapshot normativo

El snapshot es la instantánea histórica del régimen normativo.

Debe contener como mínimo:

- versión;
- URL canónica;
- Git blob SHA;
- SHA-256 del contenido;
- manifest SHA-256;
- catálogo completo de principios canónicos.

El Git blob SHA y el SHA-256 son identificadores distintos y ambos deben conservarse.

### 7.1 Inmutabilidad

Una vez abierto el turno:

    TURN T42
      ↓
    SNAPSHOT v1.2.0
      ↓
    SI v1.3.0 publicado posteriormente
      ↓
    T42 sigue usando v1.1.0
    T43 puede usar v1.2.0

---

## 8. Manifest dinámico

El verificador nunca debe contener una lista fija de folios.

El manifest se deriva de la fuente normativa exacta del snapshot.

Cada principio debe incluir:

- folio;
- name;
- preponderance;
- state;
- SHA-256 del bloque canónico del principio.

El orden del manifest es determinista.

### 8.1 Regla de evolución

Si el SI pasa de 9 a 47 principios, el protocolo cambia de:

    expected = 10

a:

    expected = 47

sin cambios en el código de negocio de KHORA.

---

## 9. Robustez del parser del SI

La implementación actual del verificador identifica los principios a partir de la sección «## 4. Principios fundamentales».

Eso funciona con el SI actual, pero es demasiado dependiente de la numeración estructural del documento.

Para completar la solución evolutiva, la siguiente iteración debe desacoplar la extracción de principios de la numeración de secciones.

Orden de preferencia:

1. **Contrato machine-readable estable dentro del SI**, versionado junto con el SI.
2. **Fallback estructural por folio + estado CANÓNICO**, sin depender del número de sección.
3. Rechazo si el parser encuentra ambigüedad o principios canónicos inconsistentes.

No se deben inferir principios desde texto narrativo fuera del régimen canónico.

---

## 10. Vector de aplicación

Por cada folio del manifest debe existir exactamente una evaluación.

Estados:

- A = APLICADO.
- N = NO_APLICABLE.
- C = CONFLICTO_RESUELTO.

Ejemplo:

    P019=A:D1
    P020=A:D1
    P021=N:R3
    P022=C:D2
    P023=A:D2
    ...

### 10.1 Anchor

Todo A y C necesita un anchor.

El anchor apunta a una unidad mínima del turno:

    D1 = decisión 1
    D2 = decisión 2
    O1 = resultado 1
    I1 = entrada relevante 1

### 10.2 No aplicabilidad

Todo N necesita un reason_code.

El catálogo de códigos debe ser:

- pequeño;
- cerrado;
- versionado;
- independiente del lenguaje narrativo.

---

## 11. Evidencia contextual

La evidencia debe ser suficiente para identificar por qué una evaluación fue emitida, pero no debe almacenar el razonamiento completo.

Formato recomendado:

    {
      "folio": "P027",
      "status": "A",
      "anchor": "D1"
    }

La evidencia contextual extendida se conserva únicamente cuando:

- la auditoría lo solicita;
- existe anomalía;
- se ejecuta un challenge;
- se requiere revisión humana.

---

## 12. Binding del turno

Este es el hueco principal que la implementación actual aún no cierra por completo.

Debe vincularse:

    INPUT REAL
       ↓
    INPUT_SHA256
       ↓
    TURN
       ↓
    SNAPSHOT
       ↓
    EJECUCIÓN
       ↓
    OUTPUT REAL
       ↓
    OUTPUT_SHA256
       ↓
    NORMATIVE VECTOR
       ↓
    EVIDENCE_SHA256
       ↓
    KHORA VERDICT

### 12.1 Modo fuerte

En un runtime controlado, el adaptador recibe el contenido real de entrada y salida y calcula:

- input_sha256;
- output_sha256.

Esto permite que KHORA valide hashes desde datos efectivos y no desde declaraciones del modelo.

### 12.2 Modo MCP nativo

En una integración MCP directa con ChatGPT, KHORA recibe únicamente los datos que el modelo le entregue como argumentos de herramienta.

En ese escenario:

- la integridad criptográfica del paquete sí es verificable;
- la correspondencia con el contenido oculto de la conversación no es demostrable independientemente;
- la fidelidad del binding depende del runtime/integración.

Por tanto, la especificación distingue explícitamente:

**Nivel E1 — evidencia estructural:** MCP directo + receipt completo.  
**Nivel E2 — binding fuerte:** runtime controlado que puede observar entrada/salida efectivas.

E1 no debe presentarse como equivalente a E2.

---

## 13. Receipt v0.4.0

Esquema recomendado:

    {
      "protocol": "NORM-CHECK",
      "protocol_version": "v0.2.0",
      "turn": {
        "cycle_id": "cv_8f5a.../T42",
        "conversation_id": "cv_8f5a...",
        "turn_number": 42,
        "attempt": 1,
        "turn_token": "opaque-server-token"
      },
      "si": {
        "version": "v1.2.0",
        "git_blob_sha": "...",
        "sha256": "...",
        "manifest_sha256": "..."
      },
      "input_sha256": "...",
      "nonce": "...",
      "principles": [
        {"folio": "P019", "status": "A", "anchor": "D1"},
        {"folio": "P020", "status": "N", "reason_code": "R3"}
      ],
      "output_sha256": "...",
      "evidence_sha256": "...",
      "created_at": "2026-10-06T19:30:05.000Z",
      "runtime": {
        "platform": "ChatGPT",
        "reasoning_mode": "THINKING",
        "output_format_version": "v1.7.0"
      }
    }

---

## 14. Canonicalización

La versión del protocolo debe fijar una única forma de obtener hashes reproducibles.

Requisitos:

- UTF-8;
- saltos LF;
- JSON canónico;
- claves ordenadas;
- arrays en orden determinista;
- números con representación estable;
- valores opcionales con semántica explícita;
- sin campos ignorados ambiguos.

La implementación recomendada es adoptar un algoritmo formal de JSON canónico en vez de depender de JSON.stringify() como contrato intercambiable entre lenguajes.

La regla es:

> misma evidencia lógica → mismos bytes canónicos → mismo SHA-256.

---

## 15. Hashes

Deben coexistir:

### 15.1 SI SHA

Hash del contenido normativo exacto.

### 15.2 Manifest SHA

Hash del manifest canónico.

### 15.3 Input SHA

Hash de la entrada efectiva.

### 15.4 Output SHA

Hash del resultado efectivo.

### 15.5 Evidence SHA

Hash del paquete normativo canónico.

Todos deben recalcularse durante la verificación.

---

## 16. Nonce y token de turno

La apertura crea:

- nonce: valor aleatorio único del turno;
- turn_token: referencia opaca al estado abierto.

El nonce participa en evidence_sha256.

El turn_token impide presentar un receipt a KHORA sin una apertura previa correspondiente.

El token debe expirar si el turno se abandona y no debe reutilizarse en otro turno.

---

## 17. Verificación

La operación final recomendada:

    POST /api/norm-check/turn/verify
    X-KHORA-KEY: <server-secret>
    Content-Type: application/json

Secuencia:

1. validar autenticación;
2. validar token de turno;
3. identificar ciclo e intento;
4. recuperar snapshot abierto;
5. verificar versión y hashes del SI;
6. recuperar manifest cacheado por SHA;
7. comparar totalidad de folios;
8. detectar faltantes;
9. detectar duplicados;
10. detectar desconocidos;
11. validar A/N/C;
12. validar anchors/reason codes;
13. recomputar hashes;
14. validar nonce;
15. validar intento contra historial;
16. emitir veredicto;
17. persistir el intento;
18. cerrar el ciclo solo si VERIFIED.

---

## 18. Veredictos

### 18.1 Estados normativos

| Estado | Significado |
|---|---|
| OPEN | turno iniciado y aún no validado |
| INCOMPLETE | falta cobertura requerida |
| INVALID | evidencia o integridad inválida |
| VERIFIED | verificación estructural satisfactoria |
| CLOSED | ciclo cerrado después de VERIFIED |

### 18.2 Estados de disponibilidad

La disponibilidad del servicio no debe confundirse con el juicio normativo.

Por ejemplo:

    HTTP 503
    TRANSPORT = UNAVAILABLE
    NORMATIVE_STATUS = NO_VERDICT

Nunca debe traducirse automáticamente a VERIFIED.

---

## 19.1 Gate de contexto operativo

El ciclo normativo debe satisfacer tambien el gate definido en ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md antes de ser considerado APTO.

Precondicion:

    CONTEXTO_GLOBAL_LEIDO
      AND RDC_ESTADO_DETERMINADO
      AND PERFIL_UBICACION_RESUELTO
      AND CONTEXTO_OPERATIVO_VERIFICADO

Cuando RDC sea requerido y cualquiera de esas condiciones de contexto no pueda demostrarse, el ciclo no puede avanzar a ejecución sustantiva ni a CLOSED. El estado BLOQUEADO no impide la interacción conversacional necesaria para resolver la condición. La identidad efectiva de Windows solo es una precondición adicional cuando la operación concreta la requiere.

Una deteccion de herramienta fallida es TRANSPORT/DETECTION FAILURE, no evidencia de RDC inactivo.

Si el sistema no puede determinar ACTIVA o INACTIVA, debe preguntar al usuario si RDC es requisito del ciclo. La respuesta NO produce NO-REQUERIDO; la respuesta SI mantiene el ciclo bloqueado hasta establecer y verificar la sesion. Durante BLOQUEADO, el modelo sigue disponible para recibir la información mínima y verificar la solución.

El registro de salida debe vincular el verdict normativo con CONTEXTO-VERIFICACION para permitir reconstruir qué contexto operativo estaba vigente al inicio del ciclo.
## 18.4 Gate de Thinking y formato

Todo turno sujeto a la metodología debe presentar y hacer verificar el contrato runtime:

`platform=ChatGPT` + `reasoning_mode=THINKING` + `output_format_version=v1.7.0`.

El modelo debe resolver la secuencia normativa durante el razonamiento del turno. Un receipt sin ese runtime, con `reasoning_mode=INSTANT`, con estado no verificable o con otra versión de formato es `INVALID` y no puede alcanzar `VERIFIED`.

El atestado de Thinking es obligatorio porque la integración puede no exponer al servidor una metadata independiente del selector visual. La falta de esa señal no se convierte en evidencia por inferencia.

La salida visible del turno es parte del contrato obligatorio. En un runtime controlado, el adaptador debe validar el texto efectivo contra `v1.7.0` antes de permitir `RELEASE`. En MCP nativo, el receipt demuestra el contrato declarado por la integración, no constituye por sí solo una prueba independiente del texto final publicado.

Todo turno sujeto a la metodología debe presentar el contrato runtime:

`platform=ChatGPT` + `reasoning_mode=THINKING` + `output_format_version=v1.7.0`.

El modelo debe resolver la secuencia normativa durante el razonamiento del turno. Un receipt sin ese runtime, con `reasoning_mode=INSTANT` o con otra versión de formato es `INVALID` y no puede alcanzar `VERIFIED`.

El dato de modo Thinking es un atestado protocolario obligatorio porque la metadata MCP pública documentada actualmente no expone el selector de modelo/modo al servidor. El sistema no debe presentarlo como evidencia independiente de la interfaz.

## 18.5 Gate de liberación de respuesta
La verificación `VERIFIED` no basta por sí sola para autorizar la emisión de una respuesta en un runtime controlado. Después de `VERIFY`, el runtime debe solicitar `khora_norm_release_turn`.

KHORA solo emite `VERIFIED_RELEASE` cuando:
1. el turno está `CLOSED`;
2. existe un receipt `VERIFIED` para el intento vigente;
3. el token de turno sigue siendo válido;
4. `output_sha256` y `evidence_sha256` proceden del receipt verificado.

El runtime de control debe comprobar que el hash de la respuesta que va a publicar coincide con `output_sha256` del release. Un mismatch invalida la publicación.

Esto convierte el release en una autorización criptográficamente vinculada al resultado verificado, pero solo es un gate técnico si el runtime controla efectivamente la salida hacia el usuario.

La interfaz nativa de ChatGPT no expone un mecanismo para que una app MCP intercepte técnicamente todos los mensajes antes de su publicación. La garantía técnica absoluta de publicación requiere un runtime/adaptador que controle la emisión de la respuesta.

## 19. Gate de cierre

El cierre debe ser una transición controlada:

    OPEN
      ↓
    VERIFY
      ├─ INVALID / INCOMPLETE / UNAVAILABLE → NO CERRADO
      └─ VERIFIED → CLOSED

La aplicación o runtime que controle el turno debe usar VERIFIED como condición de cierre.

### 19.1 Diferencia entre ChatGPT nativo y runtime controlado

En un runtime controlado, el gate puede ser técnico.

En la interfaz nativa de ChatGPT, la ejecución obligatoria de una herramienta depende de las capacidades reales de la integración MCP y de las instrucciones aplicadas al modelo.

Por ello:

> La especificación no debe afirmar que un modelo de chat nativo puede ser técnicamente obligado a invocar una herramienta si la plataforma no ofrece ese mecanismo.

La garantía fuerte de «ningún turno sin verificación» exige, además del acceso MCP, un runtime o política de plataforma que pueda exigir la llamada normativa. El MCP aporta el canal y el control de autorización; no convierte por sí mismo una herramienta opcional en una condición técnica obligatoria.

---

## 20. Integración ChatGPT → KHORA

No se define un MCP dedicado para gobernanza. Las herramientas normativas viven dentro del mismo recurso MCP canónico:

    Plataforma
      ↕
    /api/mcp
      ├─ herramientas de Cora/KHORA
      ├─ volcados
      ├─ runtime
      └─ gobernanza normativa API

### 20.1 Herramienta norm_open_turn

Entrada:

    {
      "conversation_id": "...",
      "turn_number": 42
    }

Salida:

- cycle_id;
- attempt;
- turn_token;
- nonce;
- snapshot;
- manifest;
- versión del verificador.

### 20.2 Herramienta norm_verify_turn

Entrada:

    {
      "turn_token": "...",
      "receipt": {}
    }

Salida:

    {
      "status": "VERIFIED",
      "cycle_id": "...",
      "attempt": 1,
      "coverage": {
        "expected": 10,
        "evaluated": 9,
        "missing": 0,
        "duplicates": 0,
        "unknown": 0,
        "percent": 100
      },
      "integrity": "PASS",
      "semantic_assurance": "NOT_SAMPLED"
    }

---

## 21. Política de ejecución del modelo

El cargador del SI debe adoptar una política operacional equivalente a:

    INICIO DEL TURNO
      ↓
    verificar THINKING
      ↓
    HEALTH MCP
      ↓
    OPEN TURN
      ↓
    usar snapshot recibido
      ↓
    resolver la tarea dentro del razonamiento
      ↓
    preparar vector normativo + contrato de salida
      ↓
    VERIFY TURN
      ↓
    RELEASE
      ↓
    emitir resultado con v1.7.0
    
    Si cualquier gate falla → BLOQUEADO / PENDIENTE → no declarar cierre normativo

La instrucción operativa no debe pedir al modelo que reproduzca todos los principios en la respuesta visible.

El vector viaja por la interfaz máquina.

---

## 22. Eficiencia

El objetivo operativo es:

> **La verificación normativa externa no debe consumir más de 5 s de procesamiento atribuible al mecanismo.**

No se garantiza la latencia de:

- generación del modelo;
- disponibilidad de internet;
- plataforma ChatGPT;
- GitHub;
- Vercel;
- congestión de red.

### 22.1 Fast path

El fast path debe ser:

    token lookup
    + snapshot lookup
    + manifest cache hit
    + set/index comparisons
    + state validation
    + hash recomputation
    + persist
    + verdict

Complejidad:

    O(N)

donde N = cantidad de principios del snapshot.

### 22.2 Cachés

Se debe cachear:

- manifest por si_sha256;
- blob del SI por Git blob SHA;
- metadatos del verificador.

Cuando cambia el SI, se genera una nueva clave de cache.

---

## 23. Persistencia

Se recomienda separar:

### normative_turns

Una fila por turno abierto.

Campos principales:

- cycle_id;
- conversation_id;
- turn_number;
- status;
- turn_token_hash;
- nonce;
- si_version;
- si_git_blob_sha;
- si_sha256;
- manifest_sha256;
- input_sha256;
- output_sha256;
- opened_at;
- closed_at;
- verified_attempt.

### normative_receipts

Una fila por intento.

Campos principales:

- cycle_id;
- attempt;
- receipt;
- evidence_sha256;
- status;
- integrity;
- reasons;
- verifier_version;
- created_at.

Restricciones:

    UNIQUE(cycle_id, attempt)
    UNIQUE(nonce)

---

## 24. Reintentos

Nunca se sobrescribe un intento.

Ejemplo:

    T42 / attempt 1 → INVALID
    T42 / attempt 2 → INVALID
    T42 / attempt 3 → VERIFIED

El historial debe permanecer intacto.

### 24.1 Error de evidencia

Puede corregirse el receipt y crear nuevo attempt.

### 24.2 Error de ejecución

Debe reabrirse/retrabajarse el turno y producir nueva evidencia.

KHORA debe indicar el tipo de fallo mediante reason_code.

---

## 25. Replay y ataques de reutilización

KHORA debe rechazar:

- turn_token reutilizado después del cierre;
- nonce reutilizado;
- attempt duplicado;
- receipt de otro cycle_id;
- snapshot no correspondiente;
- evidencia cuyo hash no coincide.

El sistema debe diferenciar:

    replay del mismo intento
    revalidación legítima
    nuevo intento
    nuevo turno

---

## 26. Seguridad

### 26.1 Credenciales

KHORA_API_KEY:

- solo servidor;
- nunca entregada al modelo;
- nunca incluida en el receipt;
- rotación periódica;
- comparación en tiempo constante.

Bearer manual MCP:

- generado exclusivamente tras autenticación de operador;
- 256 bits de entropía aleatoria antes del prefijo de presentación;
- almacenado únicamente como SHA-256;
- limitado por scopes y recurso MCP;
- expiración obligatoria;
- revocación individual y global por generación;
- mostrado en claro una sola vez en la consola de KHORA.

### 26.2 MCP

El adaptador MCP debe mantener la credencial de KHORA fuera del contexto visible del modelo.

### 26.3 Logs

No registrar por defecto:

- contenido completo del usuario;
- contenido completo de la respuesta;
- secretos.

Registrar:

- cycle_id;
- hashes;
- versión;
- estado;
- razón;
- latencia;
- request id.

### 26.4 Límites

Debe existir:

- límite máximo de receipt;
- rate limiting;
- protección contra replay;
- timeout;
- validación estricta del JSON.

---

## 27. Privacidad

E1 y E2 deben diferenciarse también en privacidad.

### E1

El modelo entrega hashes y evidencia compacta.

Ventaja: menor exposición.

Limitación: binding menos fuerte.

### E2

El runtime controlado puede enviar contenido o fragmentos necesarios para recalcular hashes/anchors.

Ventaja: mayor verificabilidad.

Limitación: mayor superficie de datos.

La política debe minimizar el contenido persistido.

---

## 28. Auditoría semántica

No forma parte del fast path obligatorio.

Puede ejecutarse:

- 1 de cada K turnos;
- selección pseudoaleatoria;
- ante anomalías;
- ante cambios mayores del SI;
- ante tasas elevadas de INVALID;
- bajo auditoría humana.

### 28.1 Challenge

Un challenge puede seleccionar un principio y pedir evidencia contextual específica.

Ejemplo:

    CHALLENGE:
    principio = P024
    nonce = ...
    pregunta = ...
    respuesta = ...
    resultado = PASS

### 28.2 Resultado

Se conserva por separado:

    VERIFIED
    semantic_assurance = NOT_SAMPLED

o:

    VERIFIED
    semantic_assurance = PASS

Nunca se debe confundir VERIFIED estructural con «prueba matemática de que el modelo pensó el principio».

---

## 29. Interfaz KHORA

La interfaz existente:

    Sistema → Otros → Evidencia normativa

debe evolucionar para mostrar:

- estado actual del verificador;
- SI versionado;
- ciclos abiertos;
- turnos verificados;
- turnos sin veredicto;
- cobertura;
- integridad;
- semantic assurance;
- intentos;
- razones;
- latencia;
- detalle del receipt.

La UI es una consola de auditoría, no el motor de verificación.

---

## 30. API pública de KHORA

Se conservan las rutas existentes para compatibilidad:

    GET  /api/norm-check?mode=snapshot
    GET  /api/norm-check
    POST /api/norm-check

y se añaden:

    POST /api/norm-check/turn/open
    POST /api/norm-check/turn/verify
    GET  /api/norm-check/turn/<cycle_id>

Las rutas antiguas deben quedar explícitamente marcadas como compatibilidad/manuales.

Las rutas nuevas son el contrato operativo del flujo por turno.

---

## 31. Compatibilidad hacia atrás

Los receipts v0.1.0 existentes no deben romperse.

Regla:

    v0.1.0 receipt
          ↓
    verificador compatible
          ↓
    histórico legible

pero:

    v0.2.0 turn verification
          ↓
    requiere apertura del turno
          ↓
    requiere turn_token

Los intentos antiguos no deben presentarse como equivalentes a la verificación por turno v0.2.0.

---

## 32. Observabilidad

La observabilidad del verificador forma parte de la observabilidad general de Cora y no debe depender exclusivamente de los logs propios de la ruta normativa.

Debe existir una observación transversal en cada frontera HTTP del servicio web y en los bridges que prestan capacidades a agentes externos. Como mínimo se registra servicio, operación, ruta, método, correlación, resultado, código de estado, duración y razón de fallo, sin almacenar payloads, prompts, respuestas completas, secretos ni tokens.

Las llamadas MCP se observan tanto a nivel de request como a nivel de tool call. El gate normativo registra explícitamente aperturas, verificaciones y rechazos por ausencia o invalidez de `turn_token`.

El bridge FastAPI conserva el mismo `correlation_id` y remite su resultado al almacén durable de eventos. Las dependencias externas críticas, como Jules, registran éxito/fallo terminal y latencia.

Métricas mínimas:

- norm_check_open_latency_ms;
- norm_check_verify_latency_ms;
- norm_check_verified_total;
- norm_check_invalid_total;
- norm_check_incomplete_total;
- norm_check_unavailable_total;
- norm_check_manifest_cache_hit_ratio;
- norm_check_receipt_bytes;
- norm_check_principles_expected;
- norm_check_principles_evaluated;
- norm_check_semantic_sample_total.

Objetivos operativos:

- verify p95 < 2 s en condiciones normales;
- margen suficiente para mantener el objetivo global < 5 s del mecanismo externo;
- O(N) para el catálogo;
- cache hit alto para una misma versión del SI.

Los objetivos son metas operativas, no garantías de red.

---

## 33. Telemetría y trazabilidad

Cada operación debe tener:

- request_id;
- cycle_id;
- attempt;
- verifier_version;
- timestamp;
- duración.

Esto permite reconstruir:

    OPEN
     ↓
    VERIFY
     ↓
    DB INSERT
     ↓
    VERDICT

sin almacenar contenido sensible innecesario.

---

## 34. Pruebas unitarias

Debe existir cobertura para:

### Catálogo

- 0 principios → rechazo;
- 1 principio → correcto;
- N principios → correcto;
- cambio de N a M → correcto;
- folios no ordenados → normalización;
- folio duplicado → rechazo;
- principio no canónico → exclusión;
- parser ambiguo → rechazo.

### Receipt

- JSON inválido;
- campo faltante;
- estado inválido;
- anchor faltante;
- reason code faltante;
- hashes inválidos;
- nonce inválido;
- token inválido.

### Integridad

- SI hash alterado;
- manifest alterado;
- evidence hash alterado;
- output hash alterado;
- input hash alterado.

### Historial

- attempt duplicado;
- nuevo attempt válido;
- replay;
- cierre doble.

---

## 35. Pruebas de integración

Deben cubrir:

1. abrir turno;
2. recibir snapshot;
3. generar receipt;
4. verificar receipt;
5. persistir;
6. consultar historial;
7. cerrar ciclo;
8. reintentar tras INVALID;
9. detectar SI cambiado;
10. recuperar snapshot histórico;
11. invalidar replay;
12. comprobar latencia.

---

## 36. Pruebas end-to-end

La prueba E2E mínima debe reproducir:

    ChatGPT/MCP
       ↓
    OPEN
       ↓
    SNAPSHOT
       ↓
    VERIFY
       ↓
    KHORA
       ↓
    Neon
       ↓
    UI / historial

Debe probarse en producción controlada sobre:

- khora-web.vercel.app;
- proyecto Vercel khora-web;
- repositorio SeryMente/khora;
- SI SeryMente/metodologia.

---

## 37. Criterios de rechazo

Debe producirse INCOMPLETE o INVALID cuando exista:

- snapshot inexistente;
- SI no resoluble;
- hash incorrecto;
- manifest incorrecto;
- principio faltante;
- principio duplicado;
- folio desconocido;
- estado inválido;
- anchor inválido;
- reason code inválido;
- evidence SHA incorrecto;
- nonce inválido;
- token inválido;
- attempt incompatible;
- estructura no canónica;
- replay.

Un error de infraestructura debe producir estado de disponibilidad separado y nunca debe convertirse en VERIFIED.

---

## 38. Criterio de éxito de un turno

Para un turno T:

    SUCCESS(T) =
      OPEN_OK
      AND SNAPSHOT_PINNED
      AND FULL_CATALOG_EVALUATED
      AND RECEIPT_INTEGRAL
      AND VERIFIED

Para el binding fuerte:

    STRONG_SUCCESS(T) =
      SUCCESS(T)
      AND INPUT_BOUND
      AND OUTPUT_BOUND

---

## 39. Criterio de éxito del sistema

La implementación está completa cuando:

1. todo turno elegible puede abrir un ciclo normativo;
2. KHORA crea el snapshot;
3. el snapshot representa el SI exacto del inicio;
4. el catálogo es dinámico;
5. cada principio recibe una evaluación;
6. la evidencia queda vinculada al ciclo;
7. KHORA reproduce el veredicto;
8. los intentos no se sobrescriben;
9. el cierre depende de VERIFIED;
10. el fast path mantiene baja latencia;
11. el sistema conserva historial;
12. las auditorías semánticas pueden operar sin bloquear el fast path;
13. el mecanismo funciona con cualquier evolución futura del SI.

---

## 40. Lo que ya existe en KHORA

Estado observado en main al 2026-10-06:

- khora-web/lib/server/norm-check.ts ✅
- khora-web/app/api/norm-check/route.ts ✅
- khora-web/app/sistema/otros/page.tsx ✅
- khora-web/app/components/os/SystemBar.tsx ✅
- khora-web/docs/normative-check.md ✅
- persistencia normative_receipts ✅
- snapshot dinámico ✅
- manifest dinámico ✅
- cobertura A/N/C ✅
- hashing ✅
- historial de intentos ✅
- producción Vercel ✅
- SI v1.2.0 con P028 · Trazabilidad Normativa y P029 · Identidad y Vigencia Canónica ✅
- observabilidad transversal de fronteras de servicio ✅
- bridge FastAPI correlacionado ✅
- MCP request + tool-call observability ✅
- dependencias externas Jules observadas ✅
- registro de salida `cycle-verification/v1` ✅
- `verification_record` en el flujo MCP ✅

Repositorio:

https://github.com/SeryMente/khora

Proyecto Vercel:

khora-web

---

## 41. Lo que queda fuera de este cierre

### Parser robusto del SI

Eliminar dependencia de «## 4. Principios fundamentales».

Definir contrato machine-readable o fallback por folio/estado.

URL canónica:

https://github.com/SeryMente/metodologia/blob/main/SI-METACOGNITIVO.md

### Binding fuerte

Cuando exista un runtime controlado, mover input/output hashing desde el modelo al adaptador/runtime.

URL canónica:

https://github.com/SeryMente/khora

### Gate fuerte de runtime

Hacer que el runtime controlado no pueda cerrar un turno sin VERIFIED.

URL canónica:

https://github.com/SeryMente/khora

### Auditoría semántica

Añadir challenge selectivo y semantic_assurance.

URL canónica:

https://github.com/SeryMente/khora

---

## 42. Secuencia de implementación recomendada

Orden estricto:

    1. estabilizar contrato de turno
            ↓
    2. implementar OPEN
            ↓
    3. implementar token + nonce
            ↓
    4. separar turnos de receipts
            ↓
    5. implementar VERIFY v0.2.0
            ↓
    6. endurecer parser de SI
            ↓
    7. implementar MCP adapter
            ↓
    8. integrar política de operación
            ↓
    9. implementar gate en runtime controlado
            ↓
    10. E2E
            ↓
    11. benchmark
            ↓
    12. auditoría semántica selectiva
            ↓
    13. adopción normativa en SI

No se debe empezar por la auditoría semántica antes de cerrar el contrato estructural.

---

## 43. Cambios de versión

### NORM-CHECK

v0.1.0 → v0.2.0

Motivo:

- pasa de comprobación de receipt aislado;
- a ciclo de turno con apertura, token, snapshot sellado y cierre.

El registro de salida `cycle-verification/v1` es una proyección del receipt y no cambia el protocolo de persistencia v0.2.0.

### SI

v1.0.0 → v1.1.0

Motivo:

- canoniza P028 · Trazabilidad Normativa.

La implementación desarrolla P028 sin introducir dependencias de MCP, tokens, UI o proveedor dentro del principio.

v1.1.0 → v1.2.0

Motivo:

- canoniza P029 · Identidad y Vigencia Canónica;
- exige nombre específico de versión y última modificación canónica;
- establece su representación obligatoria en la salida del SI.

La implementación desarrolla P029 sin introducir dependencias de MCP, tokens, UI o proveedor dentro del principio.

---

## 44. Plan de aceptación

La implementación solo se declara completa cuando una prueba automática pueda demostrar:

    TURN OPEN
      ↓
    SI vX.Y.Z
      ↓
    N principios
      ↓
    N evaluaciones
      ↓
    receipt
      ↓
    KHORA
      ↓
    VERIFIED
      ↓
    CLOSED

y una segunda prueba pueda demostrar:

    modificar receipt
      ↓
    KHORA
      ↓
    INVALID

y una tercera:

    reintentar correctamente
      ↓
    nuevo attempt
      ↓
    VERIFIED
      ↓
    historial conserva attempt anterior

y una cuarta:

    cambiar SI después de OPEN
      ↓
    turno original conserva snapshot histórico

---

## 45. Resultado esperado

El sistema final debe permitir una afirmación técnicamente defendible:

> Este turno fue ejecutado bajo una instantánea específica del SI, la totalidad de principios de esa instantánea fue sometida al protocolo de evaluación, la evidencia fue sellada y KHORA emitió un veredicto reproducible.

No debe afirmarse:

> «Se demostró que el modelo pensó internamente en todos los principios.»

La primera afirmación es auditable. La segunda no.

---

## 46. Estado de esta especificación

**ESPECIFICACIÓN OPERATIVA · v0.4.0**

Esta especificación consolida el contrato para registrar la verificación ciclo a ciclo:

    cada turno verificable
    → abre snapshot
    → genera evidencia
    → KHORA verifica
    → produce verification_record
    → conserva historial
    → cierra solo con VERIFIED

El alcance de P028 y P029 queda implementado en KHORA y desplegado en producción. Las capacidades adicionales de binding fuerte, gate de runtime controlado, parser machine-readable y auditoría semántica permanecen fuera de este cierre.
