# OCP2.0 · Objeto Canónico de Persistencia

**Identidad:** OCP2.0  
**Versión del núcleo:** OCP2.0-v0.1.0  
**Repositorio:** SeryMente/metodologia · rama `main`  
**Ruta OCP:** `frentes/ocp-2-0/`  
**Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json)  
**Propósito original:** [C-LOOP-001](conversaciones/C-LOOP-001-dialogo.jsonl)  
**Estado:** FT creado; definición inicial y alcance documentados. El motor de ejecución recurrente aún no está implementado.

---

## 1. Control e identidad

- Nombre del FT: **OCP2.0**.
- Identidad canónica: `OCP2.0`; slug: `ocp-2-0`.
- OCP único: `frentes/ocp-2-0/`.
- Núcleo operativo único: `OCP2.0.md`.
- Control de responsabilidad: `CONTROL-RESPONSABILIDAD.json`.
- Titular operativo inicial: `chatgpt-loop-01a1cb67-173a-785c-a7c4-98c377ce1960` (alias operacional; ID nativo de ChatGPT no expuesto).
- UUIDv7 local: `01a1cb67-173a-785c-a7c4-98c377ce1960`.
- Generación: 1.
- FOL1: PREPARADO / NO ACTIVO. No se asignan folios CV, CY, A ni B.
- No hay corresponsable registrado.
- Evento de creación: `C-LOOP-INICIO-01`.

## 2. LEER PRIMERO

Antes de cada ciclo sustantivo:

1. Adquirir `INICIO.md`, el DUG integrado y el GOW desde `SeryMente/metodologia/main`; la revisión viva prevalece sobre copias o memorias.
2. Aplicar la cascada de Sam y los principios pertinentes; revisar GOW al inicio y cierre. MCP normativo permanece DESACTIVADO.
3. Leer este núcleo, el control vigente, el propósito original, la última crónica y la evidencia necesaria para la acción. Para C-LOOP-003, el original íntegro vive en `conversaciones/C-LOOP-003-entrada-verbatim.txt`; la interpretación nunca lo sustituye.
4. Para actuar sobre otro FT, adquirir su propio OCP y autorización. Loop no hereda ni sustituye controles ajenos.
5. Distinguir propuesta, autorización, intento, ejecución, verificación y aceptación. No declarar resultados no observados.

## 3. Referencia metodológica

- DUG: Samantha v388 · NX-388m.
- Fuente única: [Metaprompt Canónico de Samantha](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html).
- Identidad y estructura de FT: ART-015/019/020/021; Metacanon §§27, 29, 39, 42 y 46–48.
- Registro literal y trazabilidad: ART-024; custodia documental: ART-014/022.
- Blob SHA del DUG adquirido al crear este FT: `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- La vigencia debe refrescarse contra `main` en cada ciclo; los datos de esta sección son el corte de creación, no una garantía de frescura perpetua.

## 4. Propósito y alcance

### 4.1 Dictado original del operador

Los dictados constitutivos están preservados literalmente, sin normalización, en [conversaciones/C-LOOP-001-dialogo.jsonl](conversaciones/C-LOOP-001-dialogo.jsonl), registros 1 y 2.

### 4.2 Lectura operativa separada

Diseñar y desarrollar un mecanismo reutilizable de desarrollo semiautomatizado que utilice instrucciones verbatim, propósito y alcance declarados, observabilidad e intervenciones del operador para seleccionar y ejecutar acciones de mejora autorizadas, verificar sus resultados y repetir el proceso mientras exista una brecha medible respecto del objetivo.

La aspiración de perfeccionamiento potencialmente indefinido no elimina los límites: cada iteración debe tener alcance, autorización, presupuesto/condiciones de parada, verificación y persistencia. Ningún agente puede convertir su propia propuesta en autorización ni darse por cumplido sin evidencia.

### 4.3 Incluye

- Modelo de ciclo recurrente: adquirir contexto → observar → comparar contra propósito → identificar brecha → seleccionar acción → pasar gates → ejecutar → verificar → persistir → decidir si continuar o detener.
- Contrato para recibir instrucciones verbatim y mantener separada su lectura operativa.
- Adaptadores de observabilidad específicos por proyecto, sin asumir que todos los frentes comparten telemetría o permisos.
- Selección de tareas y experimentos con prioridad por reducción de incertidumbre, impacto y rendimiento medible.
- Verificación técnica y funcional, comparación contra baseline, regresión, procedencia y lectura de vuelta.
- Mecanismo de parada cuando se alcance aceptación, no exista mejora demostrable, falte evidencia, se agote el presupuesto o aparezca una compuerta humana/seguridad.

### 4.4 Excluye por ahora

- Modificar automáticamente el DUG, GOW, IPZ u otras normas.
- Transferir titularidad, permisos o autoridad de otros FT.
- Automatizar plataformas web o interfaces de terceros para sortear sus límites.
- Acceder a credenciales, secretos, APIs de pago o servicios externos sin autorización y gates específicos.
- Declarar que el modelo se autoentrena o modifica sus pesos: el alcance inicial es optimizar el proceso, contexto, herramientas y artefactos de desarrollo.
- Ejecutar cambios irreversibles o fuera del workspace/proyecto expresamente autorizado.

## 5. Roles y colaboración

- **Operador:** dicta y modifica el propósito, instrucciones, restricciones y prioridades; emite autorizaciones exigidas; acepta entregables y resultados de producto.
- **Coordinador agéntico:** adquiere contexto, interpreta instrucciones, consulta observabilidad, descompone objetivos, selecciona la siguiente tarea permitida y exige evidencia.
- **Ejecutor:** herramienta/modelo con capacidad de código o terminal, limitado al workspace, permisos, sandbox y aprobación aplicables. El ejecutor no redefine el propósito.
- **Instrumentos de observabilidad:** adaptadores y telemetría específicos del proyecto. Son fuentes de datos, no autoridades.
- **Verificador:** pruebas deterministas, diff, análisis de regresiones y lecturas de vuelta. Un modelo puede sugerir; no sustituye la prueba.

## 6. Autoridad

Precedencia: políticas y límites obligatorios → DUG y controles canónicos → autorización del operador → instrucciones verbatim y propósito del FT → núcleo/backlog → propuestas técnicas.

OCP2.0 coordina el método de mejora; no adquiere autoridad sobre el código, datos, credenciales o controles de otros FT. Cada acción sobre Harmonia, Signal Interpreter u otro proyecto debe seguir el OCP, control y autorización de ese proyecto.

No se modifican las normas generales desde este FT. Toda propuesta transversal se remite a Metacanon/Gobernanza para su procedimiento correspondiente.

## 7. Perfil de entorno

- Repositorio canónico: `SeryMente/metodologia`, rama `main`.
- OCP: `frentes/ocp-2-0/`.
- Persistencia principal: Git; los originales se conservan en este OCP.
- Herramientas y hosts se seleccionan por proyecto y por ciclo; no se presupone una conexión RDC, CLI, API o agente específico.
- Secretos y credenciales nunca se persisten en Git.
- FOL1 está PREPARADO / NO ACTIVO en el corte de creación.

## 8. Estado vivo

**Estado del frente:** inaugurado en `main` mediante `C-LOOP-INICIO-01`; OCP, núcleo y control único existentes. C-LOOP-003 amplía el contexto del mismo frente, no crea un FT paralelo.

**Corte actual:** fuente literal C-LOOP-003 preservada y cotejada; análisis externo Groq/GPT-OSS 120B completado con continuación válida; crónica editorial filtrada persistida. La revisión externa es insumo analítico, no canon ratificado.

Materializado:
- Núcleo de 13 bloques, control inicial y UUIDv7 local.
- Propósito y autorización de creación originales preservados.
- C-LOOP-002: reconstrucción previa y revisión GPT-OSS basada en un mapa estructurado, no en el dictado íntegro.
- C-LOOP-003: fuente literal, procedencia, evidencia, respuestas Groq/GPT-OSS y reconstrucción causal crítica.
- SHA-256 del original y lectura de vuelta verificados en EP local y GitHub `main`.
- Distinción editorial de roles: OCP, EP, LISA, RAP, PRIUS, observador núcleo/adaptadores, Loop y orquestación multiagente.

Pendiente:
- Recuperar y verificar LISA 2.0 y Canon PRIUS desde Notion; no fueron consultados en este ciclo.
- Benchmark externo de CrewAI y alternativas, y de referentes de calidad (incluido Superpowers); no se realizó aquí.
- Aclarar el problema técnico concreto pendiente de CrewAI y definir el piloto RAP entre modelos distintos.
- Formalizar el contrato técnico del Loop, interfaces, autorización por acción y condiciones de parada.
- Definir y probar observador núcleo y adaptadores por proyecto/frente, a partir de una línea de base.
- Diseñar el vector objetivo visible y su procedencia canónica.
- Delimitar el overhaul OCP y el workspace administrativo tipo Notion sin confundirlos con EP.
- Preparar después el taller y el repositorio correspondiente; no se creó ni se consultó Gmail.

## 9. Aceptación y viabilidad

Los siguientes criterios son **propuesta inicial de diseño**, no aceptación ratificada ni implementación:

1. El loop adquiere propósito, instrucciones verbatim, restricciones y estado actual de un proyecto sin confundir fuentes ni perder procedencia.
2. Cada decisión de mejora cita evidencia observable y se vincula con una brecha concreta respecto del objetivo.
3. La acción seleccionada es mínima, acotada, autorizada y reversible cuando sea posible.
4. Las pruebas se ejecutan fuera de la interfaz de producción y producen resultados reproducibles.
5. El cambio se compara contra baseline e incluye revisión de regresión.
6. El ciclo persiste instrucción, decisión, acción, pruebas, resultado y hashes/read-back.
7. Existe una condición explícita de continuar/detener; la recursividad no es infinita por defecto ni puede eludir gates.
8. Se mide rendimiento neto: tiempo, iteraciones, intervención humana, tasa de acierto, regresiones y coste cuando corresponda.
9. La aceptación exige evidencia externa al propio juicio del modelo; no se aprueba a sí mismo.

Viabilidad actual: **documental/arquitectónica viable; implementación aún no evaluada**. El prototipo deberá empezar con un solo proyecto y operaciones locales reversibles.

## 10. Formato de ciclo

Ciclo de diseño previsto:

1. **Acquire:** refrescar DUG/GOW, propósito, instrucciones y OCP del proyecto activo.
2. **Observe:** recuperar telemetría y estado real de código/pruebas.
3. **Diagnose:** identificar brecha y causas sustentadas por evidencia; marcar incertidumbre.
4. **Plan:** seleccionar una acción mínima y su prueba discriminante.
5. **Gate:** comprobar autoridad, permisos, alcance, privacidad, coste y reversibilidad.
6. **Act:** ejecutar únicamente el cambio autorizado.
7. **Verify:** ejecutar pruebas y comparar contra baseline; no aceptar una hipótesis sin resultado.
8. **Persist:** registrar originales, decisión, diff/resultado, evidencia y lectura de vuelta.
9. **Continue/Stop:** repetir solo si la mejora esperada sigue siendo material y las compuertas siguen abiertas.

Cada ciclo debe distinguir:
- Entrada verbatim y su procedencia.
- Propósito/versión de instrucciones aplicado.
- Evidencia de observabilidad usada.
- Intervención del operador y autorización cuando corresponda.
- Acción propuesta y estado de autorización.
- Resultado de ejecución y pruebas.
- Resultado aceptado o pendiente.
- Condición que habilita la siguiente iteración o detiene el loop.

## 11. Crónica y fuentes

- Conversación de creación y propósito: [C-LOOP-001-dialogo.jsonl](conversaciones/C-LOOP-001-dialogo.jsonl).
- Crónica inicial: [C-LOOP-001.md](cronica/C-LOOP-001.md).
- Evidencia de creación: [C-LOOP-001.json](evidencias/C-LOOP-001.json).
- DUG en el corte: [Samantha v388 · NX-388m](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html).
- Inventario: [INVENTARIO-REPOSITORIOS-Y-FRENTES.md](../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md).
- Los frentes Harmonia y Signal Interpreter son posibles proyectos consumidores, no subfrentes ni subordinados de Loop. Su estado debe leerse desde sus propios OCP.

## 12. Reinstanciación

Al retomar Loop:
1. Leer DUG y GOW vivos desde `main`.
2. Verificar el único `CONTROL-RESPONSABILIDAD.json`, titular, generación y UUIDv7 local.
3. Leer este núcleo y la última crónica/evidencia.
4. Releer el propósito literal en el archivo de diálogo; no reconstruirlo desde resúmenes.
5. Consultar los OCP de los proyectos sobre los que se pretenda actuar; nunca asumir permisos desde Loop.
6. Continuar desde el último checkpoint realmente persistido. Si no existe evidencia o lectura de vuelta, marcar pendiente.

## 13. Persistencia y revisión

- Fuente canónica: `SeryMente/metodologia/main/frentes/ocp-2-0/`.
- Un solo núcleo operativo y un solo control de responsabilidad.
- Originales literales separados de interpretaciones y crónica.
- Cada ciclo sustantivo añade crónica y evidencia; no reescribe historia para aparentar continuidad.
- Las mutaciones se verifican con SHA/read-back y se declaran por estado.
- No se almacenan secretos, prompts/respuestas de terceros ni datos privados que no sean necesarios.
- No se presume sincronización automática fuera de la persistencia efectivamente comprobada.
- Revisar el núcleo cuando cambien propósito, autoridad, alcance, criterios o arquitectura y conservar la revisión anterior.

---

**Corte de creación:** 2026-11-11.  
**DUG adquirido:** Samantha v388 · NX-388m · blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.  
**Estado de ejecución:** creado en `main`; los requisitos del motor siguen pendientes.


## 14. Entrada C-LOOP-002 · contexto y requisitos de diseño

El 2026-11-11 el operador entregó una entrada extensa para reconstruir la progresión narrativa de sus necesidades y documentarla en este frente. La interpretación estructurada, sus requisitos candidatos, secuencia de trabajo e incógnitas están en [C-LOOP-002 · Reconstrucción narrativa y requisitos de diseño](cronica/C-LOOP-002-analisis-y-reconstruccion.md).

- Procedencia y mapa de reconstrucción: [conversaciones/C-LOOP-002-dialogo.jsonl](conversaciones/C-LOOP-002-dialogo.jsonl).
- Evidencia y estado de validación: [evidencias/C-LOOP-002.json](evidencias/C-LOOP-002.json).
- Se agrupan OCP, LISA, RAP, PRIUS, entorno persistente, observador núcleo, adaptadores de observabilidad, objetivo visible y orquestación multiagente. Sus responsabilidades se delimitan por separado en la crónica §12.
- Prioridad táctica reportada: piloto RAP + CrewAI/alternativa y definición del taller multiagente; el benchmarking y la implementación siguen pendientes.
- La revisión secundaria con GPT-OSS 120B vía Groq se ejecutó usando la bóveda EP; la respuesta se conserva en [evidencias/C-LOOP-002-GPT-OSS-120B-review.md](evidencias/C-LOOP-002-GPT-OSS-120B-review.md). Se utilizó un mapa estructurado, no el dictado verbatim completo; la crítica y las correcciones están en la crónica §12. La clave no se expuso ni se guardó.
- Los requisitos de la crónica son una interpretación de trabajo, no un canon ratificado. El motor de OCP2.0 permanece sin implementar.

## 15. Entrada C-LOOP-003 · fuente literal y análisis externo completados

El operador aportó el archivo `Texto pegado(20261111-194556).txt`. Se conserva sin normalización ni reordenación en [conversaciones/C-LOOP-003-entrada-verbatim.txt](conversaciones/C-LOOP-003-entrada-verbatim.txt), con su procedencia en [conversaciones/C-LOOP-003-dialogo.jsonl](conversaciones/C-LOOP-003-dialogo.jsonl).

- Fuente: 60 líneas, 65.884 caracteres; SHA-256 `E25E047B54E8313B3D08E8A8C0CBA11D0D5C792D642206AE8D14B4D654A78531`; GitHub Blob SHA `b1aec0118f1a5aa2fe03d64ed0528533be02d1db`.
- Crónica del estado inicial de custodia: [C-LOOP-003-checkpoint.md](cronica/C-LOOP-003-checkpoint.md).
- Reconstrucción narrativa y requisitos: [C-LOOP-003-analisis-y-secuencia-causal.md](cronica/C-LOOP-003-analisis-y-secuencia-causal.md).
- Revisión cruda GPT-OSS 120B vía Groq y continuación: [C-LOOP-003-GPT-OSS-120B-review.md](evidencias/C-LOOP-003-GPT-OSS-120B-review.md).
- Evidencia y metadatos de ejecución/read-back: [C-LOOP-003.json](evidencias/C-LOOP-003.json).
- La fuente termina truncada en «...los modelos de frontera son muchísimo...». No se completa.
- Groq recibió el original literal completo (SHA-256 indicado arriba). La primera respuesta alcanzó el límite de tokens; una continuación intermedia no resultó utilizable; la tercera llamada completó H-L. Las limitaciones y las correcciones críticas están registradas en la evidencia y en la crónica editorial.
- La salida GPT-OSS contiene hipótesis y errores; no se adopta sin filtro. La crónica distingue requisitos expresos, inferencias y propuestas pendientes.
- No se modificó el control de responsabilidad ni se asignaron folios globales. FOL1 sigue PREPARADO/NO ACTIVO.



## 16. Renombramiento y continuidad de la fuente

El frente fue renombrado de **Loop** a **OCP2.0**. La ruta canónica vigente es `frentes/ocp-2-0/`; la ruta anterior `frentes/loop/` queda como antecedente de migración y no debe recrearse. El núcleo único es `OCP2.0.md`. Los identificadores históricos `C-LOOP-*` y el contenido verbatim se conservan sin renumeración ni reescritura. La segmentación C-LOOP-003 es derivada literal vinculada a la fuente original. La titularidad, UUIDv7 local y generación se conservan; no hubo transferencia de responsabilidad.


## 17. Registro de continuidad conversacional · 2026-11-11

El operador pidió conservar el intercambio completo suministrado en esta conversación. La transcripción se registró en [CONTINUIDAD-20261111.md](conversaciones/CONTINUIDAD-20261111.md), con UUIDv7 local `01a1cc8f-15e0-7906-9ebf-3a0af14800e0`. Se conserva el texto tal como fue aportado, sin corregir los errores de transcripción ni alterar los identificadores históricos. Las afirmaciones de respuestas anteriores se preservan como parte del historial visible y no se consideran verificaciones técnicas nuevas por el solo hecho de estar transcritas. Este registro no altera el control de responsabilidad ni la generación del frente.

## 18. Registro de continuidad conversacional · 2026-11-12

El operador solicitó persistir el tramo reciente de conversación sobre Superpowers y WORKSPACE, preservar el contexto para una continuación seamless y repetir la salida del modelo correspondiente al último ciclo anterior a la captura.

- Registro: [ChatGPT-OCP20-20261112-1140.md](conversaciones/ChatGPT-OCP20-20261112-1140.md).
- UUIDv7 local del registro: `01a1d0d7-6720-7276-b37a-ef4e7374eb94`.
- El registro conserva las entradas y salidas visibles del tramo, distingue la transcripción de la ficha de continuidad y reproduce íntegramente la salida del último ciclo anterior.
- Decisión expresa preservada: WORKSPACE será el primer elemento a trabajar; el orden lo determina el operador.
- Método solicitado: dinámica completa de Superpowers; el brainstorming de WORKSPACE está iniciado, pero aún no se ha desarrollado ni se ha respondido la pregunta inicial.
- No se declara aprobado el propósito, la arquitectura o el stack de WORKSPACE; tampoco existe diseño o plan aprobado.
- La mutación del registro y los enlaces se verifica con los SHA y la lectura de vuelta del propio repositorio.
- El control de responsabilidad no se modifica; titularidad y generación 1 se conservan; FOL1 continúa PREPARADO/NO ACTIVO y no se asignan folios globales.

