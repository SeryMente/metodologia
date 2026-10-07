# Especificación Completa de Evidencia Normativa por Turno

**Estado:** ESPECIFICACIÓN OPERATIVA
**Versión:** v0.7.2 — Verificación Adaptativa + HUD Compacto + Liberación Verificada  
**Fecha:** 2026-10-07  
**Ámbito:** mecanismo para obtener evidencia externa, reproducible y auditable de que cada turno elegible de ejecución de ChatGPT fue gobernado por la totalidad del Sistema de Instrucciones Metacognitivas (SI) vigente al inicio del turno.  
**Relación con el SI:** este documento especifica un mecanismo de aplicación y verificación. El SI v1.6.1 canoniza P028 · Trazabilidad Normativa, P029 · Identidad y Vigencia Canónica, P030 · Fidelidad Terminológica Canónica, P031 · Normalización de Transcripción y P032 · Contexto Operativo Verificado; este documento desarrolla su aplicación sin añadir mecanismos al nivel de principio.

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
        "output_format_version": "v1.7.1"
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

## 18.3 Disponibilidad adaptativa del verificador

La verificación externa depende de que el MCP canónico de KHORA sea accesible en el turno. Esta disponibilidad es independiente del modo de razonamiento del modelo.

Estados de `K` en la salida:

- `K: ✓` = KHORA accesible y secuencia normativa verificada/liberada.
- `K: OFF` = KHORA no accesible o fuera de servicio; no existe veredicto externo y la salida continúa.
- `K: ?` = estado de disponibilidad o resultado no determinable.
- `K: !` = acceso intentado pero fallido, no autorizado o verificación rechazada.

`reasoning_mode` es metadato de runtime. No certifica el razonamiento interno del modelo y no transforma la indisponibilidad de KHORA en un bloqueo conversacional.

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

Thinking es la ventana preferente para ejecutar la cascada normativa antes de la salida cuando la plataforma la expone. No es una precondición para producir respuesta ni una prueba del razonamiento interno.

El receipt conserva `platform=ChatGPT`, el `reasoning_mode` observado (`THINKING|INSTANT|UNKNOWN|UNAVAILABLE`) y `output_format_version=v1.7.2`. La ausencia de señal de razonamiento no invalida el receipt por sí misma.

Cuando KHORA está disponible, el flujo intenta `HEALTH → OPEN → CASCADA → VERIFY → RELEASE`. Cuando no está disponible, el turno continúa con el contrato visible y declara `K: OFF`, sin atribuir verificación externa.
