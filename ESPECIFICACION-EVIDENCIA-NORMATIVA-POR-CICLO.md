# Especificación Completa de Evidencia Normativa por Turno

**Estado:** PROPUESTA DE DISEÑO AMPLIADA  
**Versión:** v0.2.0 — Evidencia Normativa por Turno  
**Fecha:** 2026-10-06  
**Ámbito:** mecanismo para obtener evidencia externa, reproducible y auditable de que cada turno elegible de ejecución de ChatGPT fue gobernado por la totalidad del Sistema de Instrucciones Metacognitivas (SI) vigente al inicio del turno.  
**Relación con el SI:** este documento especifica un mecanismo de aplicación y verificación. No modifica ni canoniza principios del SI por sí mismo.

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
    ┌───────────────┐
    │ ADAPTADOR MCP │
    │ ChatGPT → KHORA
    └───────┬───────┘
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
- **Adaptador MCP:** puente máquina entre ChatGPT y KHORA.
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
| Transporte | MCP para la integración con el modelo; REST de KHORA como backend |
| Persistencia | KHORA/Neon |
| Cierre | solo tras VERIFIED |
| Rechazo | no sobrescribir; nuevo attempt |
| Fast path | estructural, determinista, O(N) |
| Auditoría semántica | selectiva/asíncrona |
| Seguridad | credencial servidor-a-servidor; nunca en navegador |

---

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
        "version": "v1.0.0",
        "git_blob_sha": "...",
        "sha256": "...",
        "manifest_sha256": "...",
        "principles": []
      },
      "verifier": {
        "protocol": "NORM-CHECK",
        "protocol_version": "v0.2.0",
        "verifier_version": "norm-check/0.2.0"
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
    SNAPSHOT v1.0.0
      ↓
    SI v1.0.1 publicado posteriormente
      ↓
    T42 sigue usando v1.0.0
    T43 puede usar v1.0.1

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

    expected = 9

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

## 13. Receipt v0.2.0

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
        "version": "v1.0.0",
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
      "created_at": "2026-10-06T19:30:05.000Z"
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

La garantía fuerte de «ningún turno sin verificación» exige un runtime de ejecución controlado o una integración de plataforma con tool-calling obligatorio.

---

## 20. Integración ChatGPT → KHORA

Se define un adaptador MCP dedicado:

    ChatGPT
      ↕
    norm_open_turn
    norm_verify_turn
      ↕
    KHORA API

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
        "expected": 9,
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
    OPEN TURN
      ↓
    usar snapshot recibido
      ↓
    resolver la tarea
      ↓
    preparar vector normativo
      ↓
    VERIFY TURN
      ↓
    si VERIFIED → emitir resultado
    si no → no declarar cierre normativo

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
- nunca navegador;
- nunca incluida en el receipt;
- rotación periódica;
- comparación en tiempo constante.

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

Repositorio:

https://github.com/SeryMente/khora

Proyecto Vercel:

khora-web

---

## 41. Lo que falta para v0.2.0 operativo

### Fase A — Contrato de turno

Implementar:

- turns;
- turn_token;
- turn/open;
- turn/verify;
- transición OPEN → VERIFIED → CLOSED.

URL canónica:

https://github.com/SeryMente/khora/tree/main/khora-web

### Fase B — Parser robusto del SI

Eliminar dependencia de «## 4. Principios fundamentales».

Definir contrato machine-readable o fallback por folio/estado.

URL canónica:

https://github.com/SeryMente/metodologia/blob/main/SI-METACOGNITIVO.md

### Fase C — Adaptador MCP

Crear el puente:

    ChatGPT
      ↕
    norm_open_turn
    norm_verify_turn
      ↕
    KHORA

El adaptador nunca entrega KHORA_API_KEY al modelo.

URL canónica:

https://github.com/SeryMente/khora

### Fase D — Activación del flujo por turno

Actualizar el mecanismo de carga/operación del SI para que el flujo por turno sea obligatorio dentro de la integración elegida.

No se modifica el SI canónico hasta que la implementación haya pasado las pruebas de A–C.

URL canónica:

https://github.com/SeryMente/metodologia/blob/main/SI-METACOGNITIVO.md

### Fase E — Binding fuerte

Cuando exista un runtime controlado, mover input/output hashing desde el modelo al adaptador/runtime.

URL canónica:

https://github.com/SeryMente/khora

### Fase F — Gate

Hacer que el runtime controlado no pueda cerrar un turno sin VERIFIED.

URL canónica:

https://github.com/SeryMente/khora

### Fase G — Auditoría semántica

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

### SI

No se modifica en esta especificación.

La adopción del mecanismo como obligación normativa requiere una actualización separada y versionada de:

- SI-METACOGNITIVO.md;
- cargador;
- reglas de operación.

No se debe confundir:

    especificación de implementación
    ≠
    canonización del SI

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

**PROPUESTA DE DISEÑO AMPLIADA · v0.2.0**

Esta especificación consolida el diseño completo necesario para pasar de:

    KHORA puede verificar receipts

a:

    cada turno verificable
    → abre snapshot
    → genera evidencia
    → KHORA verifica
    → obtiene VERIFIED
    → queda auditable

La implementación actual de KHORA es una base funcional, no todavía la garantía de verificación automática de cada turno.

La siguiente entrega técnica debe implementar las fases A–F en ese orden antes de declarar cerrada la comprobación por turno.
