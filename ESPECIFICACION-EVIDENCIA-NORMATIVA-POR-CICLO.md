# Especificación de Evidencia Normativa por Ciclo

**Estado:** PROPUESTA DE DISEÑO  
**Versión:** v0.1.0 — Evidencia Normativa por Ciclo  
**Fecha:** 2026-10-06  
**Ámbito:** mecanismo para obtener evidencia verificable de que cada ciclo fue ejecutado bajo la totalidad del Sistema de Instrucciones Metacognitivas (SI) vigente al inicio del ciclo.  
**Relación con el SI:** este documento no modifica ni canoniza principios del SI. Especifica un mecanismo que puede adoptarse posteriormente.

---

## 1. Propósito

Para cada ciclo, el mecanismo debe permitir comprobar objetivamente:

1. qué versión exacta del SI lo gobernó al inicio;
2. qué totalidad de principios canónicos existía en esa versión;
3. que cada principio fue sometido a evaluación;
4. qué aplicación, no aplicabilidad o conflicto se registró para cada principio;
5. que la evidencia pertenece al ciclo, sus entradas y su resultado;
6. que la evidencia no fue alterada después del sellado;
7. que un verificador externo puede reproducir el veredicto;
8. que un rechazo puede revalidarse sin borrar el historial.

Debe funcionar con cualquier número futuro de principios.

## 2. Límite epistemológico

No es demostrable desde fuera que el modelo haya tenido un estado mental interno denominado “lectura” de un principio.

La propiedad verificable será:

> El ciclo fue vinculado a una instantánea exacta del SI, cubrió formalmente la totalidad de sus principios y produjo evidencia estructurada de aplicación o no aplicabilidad, posteriormente validada por un verificador externo.

La integridad y completitud estructural son deterministas. La validez semántica profunda de una aplicación puede auditarse por muestreo, fuera del camino rápido.

## 3. Principios de diseño del mecanismo

### 3.1 Completitud dinámica
No existe una lista fija de principios en el verificador. La totalidad esperada se obtiene del SI canónico asociado al ciclo.

### 3.2 Snapshot histórico
El snapshot se crea al iniciar el ciclo. Un cambio posterior del SI no modifica retroactivamente el régimen del ciclo.

### 3.3 Verificación externa
El componente que genera la evidencia no es quien determina el veredicto.

### 3.4 Integridad
Los elementos críticos se identifican mediante SHA-256 y quedan vinculados.

### 3.5 Trazabilidad
La evidencia debe quedar vinculada a ciclo, entrada, snapshot y resultado.

### 3.6 Reproducibilidad
La validación estructural debe producir el mismo resultado ante los mismos datos.

### 3.7 Eficiencia
La comprobación ordinaria no debe provocar una segunda inferencia pesada del modelo. El objetivo es <= 5 s de procesamiento de verificación, excluyendo latencia externa no controlable.

### 3.8 Evolución
El protocolo no depende de P019–P027 ni de ningún número fijo de principios.

## 4. Arquitectura

~~~text
SI CANÓNICO
    ↓
SNAPSHOT + MANIFEST
    ↓
CICLO CHATGPT
    ├─ tarea
    ├─ decisiones
    ├─ resultado
    └─ vector normativo A/N/C
    ↓
CYCLE RECEIPT
    ↓
KHORA
    ├─ VERIFIED
    ├─ INVALID
    └─ INCOMPLETE
    ↓
GATE DE CIERRE + HISTORIAL
~~~

Responsabilidades:

- **SI:** autoridad normativa.
- **Snapshot/Manifest:** identidad exacta del régimen aplicable.
- **ChatGPT:** ejecución y generación de evidencia compacta.
- **Receipt:** transporte de evidencia.
- **KHORA:** verificación y autorización del cierre.
- **Registro histórico:** conservación de intentos y veredictos.

## 5. Snapshot normativo

Se crea al inicio, antes de la ejecución sustantiva.

Contenido mínimo:

~~~json
{
  "si_version": "v1.0.0",
  "si_source": "https://raw.githubusercontent.com/SeryMente/metodologia/main/SI-METACOGNITIVO.md",
  "si_git_blob_sha": "...",
  "si_sha256": "...",
  "manifest_sha256": "..."
}
~~~

Se distinguen:

- si_git_blob_sha: identidad del blob Git, cuando esté disponible.
- si_sha256: SHA-256 del contenido canónico exacto recuperado.
- manifest_sha256: SHA-256 del manifest canónico.

El Git blob SHA no sustituye al SHA-256.

## 6. Manifest dinámico

El manifest representa la totalidad de los principios canónicos del snapshot.

Cada entrada contiene, como mínimo:

- folio;
- nombre;
- preponderancia;
- estado;
- hash del bloque canónico del principio.

El orden debe ser determinista: folio ascendente, sin duplicados ni vacíos.

El manifest se serializa de forma canónica y se hashea con SHA-256.

Cualquier modificación material de la totalidad o identidad de los principios debe producir otro manifest_sha256.

## 7. Vector de aplicación normativa

Debe existir exactamente una entrada por cada folio del manifest.

Estados permitidos:

- A = APLICADO
- N = NO_APLICABLE
- C = CONFLICTO_RESUELTO

Ejemplo compacto:

~~~text
P019=A:D1
P020=N:R3
P021=A:D1
P022=C:D2
P023=N:R3
...
~~~

### 7.1 Anchor

Todo A o C necesita un anchor hacia una parte concreta del ciclo relacionada con la decisión, acción, restricción o resultado.

Ejemplo:

~~~text
D1 = decisión 1
D2 = decisión 2
O1 = resultado 1
I1 = entrada 1
~~~

El anchor evita que A o C sean una etiqueta sin referencia contextual.

### 7.2 No aplicabilidad

Todo N necesita un reason_code breve y normalizado.

El catálogo de reason codes debe ser pequeño, cerrado y versionado.

## 8. Cobertura obligatoria

Si el manifest contiene N principios, KHORA debe comprobar:

~~~text
esperados = N
evaluados = N
faltantes = 0
duplicados = 0
desconocidos = 0
cobertura = 100%
~~~

La cobertura se calcula por identidad de folio.

Falla si:

- falta un principio;
- hay duplicados;
- aparece un folio desconocido;
- existe un estado inválido;
- A/C no tienen anchor;
- N no tiene reason_code.

No se permite declarar cobertura completa manualmente.

## 9. Identidad y trazabilidad del ciclo

Cada ciclo usa su folio metodológico permanente:

~~~text
PROYECTO / CONV-XX / CXXX
~~~

El receipt vincula:

- cycle_id;
- attempt;
- input_sha256;
- snapshot;
- vector normativo;
- output_sha256;
- evidence_sha256;
- nonce.

El input_sha256 representa la forma canónica del conjunto de entradas relevantes.

El output_sha256 representa la forma canónica del resultado que se pretende cerrar.

El evidence_sha256 representa la forma canónica del paquete normativo.

## 10. Nonce e intentos

Cada intento tiene un nonce propio. Debe ser suficientemente único y formar parte del cálculo del evidence_sha256.

El nonce evita la reutilización silenciosa de una evidencia de otro intento.

Un rechazo nunca se corrige sobrescribiendo:

~~~text
C031 / attempt 1 → INVALID
C031 / attempt 2 → INVALID
C031 / attempt 3 → VERIFIED
~~~

Todos los intentos permanecen auditables.

## 11. Cycle Receipt

Esquema mínimo:

~~~json
{
  "protocol": "NORM-CHECK",
  "protocol_version": "v0.1.0",
  "cycle": {
    "id": "PROYECTO/CONV-XX/CXXX",
    "attempt": 1
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
  "created_at": "2026-10-06T00:00:00Z"
}
~~~

El receipt debe ser compacto. No contiene el razonamiento completo del modelo.

## 12. Canonicalización

Para que los hashes sean reproducibles, el protocolo debe fijar una representación canónica:

- UTF-8;
- saltos de línea LF;
- JSON con claves ordenadas;
- arrays en orden definido;
- números con representación estable;
- ausencia/presencia de campos opcionales con semántica definida;
- sin espacios variables que alteren la identidad.

La canonicalización forma parte de la versión del protocolo.

## 13. Verificación de KHORA

Secuencia mínima:

~~~text
1. Validar esquema.
2. Identificar cycle_id y attempt.
3. Resolver SI/version y hashes.
4. Obtener manifest correspondiente, usando cache por si_sha256.
5. Comparar manifest contra vector.
6. Detectar faltantes, duplicados y desconocidos.
7. Validar estados, anchors y reason codes.
8. Recalcular evidence_sha256.
9. Verificar input/output hashes cuando estén disponibles.
10. Verificar nonce y unicidad del intento.
11. Emitir veredicto.
~~~

Respuesta mínima:

~~~json
{
  "status": "VERIFIED",
  "cycle": "PROYECTO/CONV-XX/CXXX",
  "attempt": 1,
  "coverage": {
    "expected": 9,
    "evaluated": 9,
    "missing": 0,
    "duplicates": 0,
    "unknown": 0,
    "percent": 100
  },
  "integrity": "PASS"
}
~~~

Un SI futuro con 47 principios producirá expected = 47 automáticamente.

## 14. Veredictos y gate de cierre

Estados mínimos:

| Estado | Significado |
|---|---|
| OPEN | ciclo en ejecución |
| INCOMPLETE | falta cobertura requerida |
| INVALID | evidencia o integridad inválida |
| VERIFIED | verificación satisfactoria |
| CLOSED | ciclo cerrado después de VERIFIED |

Flujo:

~~~text
OPEN
  ↓
RECEIPT
  ↓
KHORA
  ├─ INVALID / INCOMPLETE → OPEN
  └─ VERIFIED → CLOSED
~~~

El modelo no convierte por sí mismo una salida en cierre normativo.

## 15. Anclaje del veredicto

KHORA debe registrar como mínimo:

- cycle_id;
- attempt;
- SI version;
- SI SHA-256;
- manifest SHA-256;
- evidence SHA-256;
- verdict;
- timestamp;
- versión del verificador.

El registro debe permitir recalcular posteriormente la evidencia.

El hash detecta modificaciones; el registro histórico impide sustituir silenciosamente la evidencia ya verificada.

## 16. Auditoría semántica opcional

La auditoría profunda no forma parte del fast path obligatorio.

Puede ejecutarse por:

- muestreo aleatorio;
- demanda explícita;
- anomalías;
- tasas elevadas de rechazo;
- cambios mayores del SI.

Puede seleccionar principios concretos y solicitar evidencia contextual adicional.

Esta capa aumenta la confianza semántica, pero no debe bloquear la verificación estructural ordinaria.

## 17. Rendimiento e implementación eficiente

KHORA debe cachear el manifest por SI SHA-256.

La verificación normal debe ser aproximadamente O(N) mediante índices por folio.

No debe:

- releer y reanalizar innecesariamente un SI sin cambios;
- ejecutar una segunda inferencia completa del modelo;
- comparar todos los principios contra todos los demás;
- almacenar razonamiento innecesario.

El camino rápido se limita a parseo, lookup, comparación de conjuntos, validación, hashing y veredicto.

## 18. Evolución del SI

Ejemplo:

~~~text
C001 → SI v1.0.0 → 9 principios
C002 → SI v1.0.1 → 10 principios
C003 → SI v1.1.0 → 14 principios
~~~

Cada ciclo conserva su snapshot original.

No existe ninguna constante equivalente a “9 principios”.

## 19. Criterios de rechazo

KHORA debe producir INVALID o INCOMPLETE cuando exista:

- SI no resoluble;
- hash de SI incorrecto;
- manifest incorrecto;
- principio faltante;
- principio duplicado;
- folio desconocido;
- estado inválido;
- anchor o reason_code faltante;
- evidence_sha256 incorrecto;
- nonce inválido o reutilizado;
- estructura no canónica;
- intento incompatible con el historial.

Los motivos deben usar códigos breves y estables.

## 20. Criterio de éxito

Para cualquier ciclo C, la implementación es conforme cuando:

1. puede reconstruir el SI exacto que gobernó el inicio de C;
2. obtiene dinámicamente la totalidad de sus principios;
3. existe exactamente una evaluación por principio;
4. la evidencia está vinculada a C, sus entradas, resultado y snapshot;
5. KHORA reproduce el veredicto independientemente;
6. no puede cerrarse un ciclo con evidencia incompleta o inválida;
7. ningún intento anterior desaparece al corregir;
8. la comprobación normal cumple el objetivo de baja latencia.

## 21. Estado de adopción

Esta especificación es un diseño persistido y no constituye por sí misma una modificación del SI canónico.

No altera folios, nombres, preponderancias ni estados de SI-METACOGNITIVO.md.

Su adopción obligatoria requiere una decisión normativa posterior y la actualización versionada de los artefactos canónicos correspondientes.
