# Núcleo operativo · Gobernanza

**Frente:** Gobernanza.  
**Repositorio:** `SeryMente/metodologia`.  
**OCP:** `frentes/gobernanza/`.  
**Evento de apertura:** `C-GOBERNANZA-INICIO-01`.  
**Último ciclo con folio legado:** `C-20261029-5510927B` · `C-GOBERNANZA-AT-ENDURECIMIENTO-01`. **Evento más reciente (pre-corte):** `C-GOBERNANZA-FOLIACION-SECUENCIAL-01`; FOL1 preparado, sin número de ciclo ni folio asignado. **Evento de control:** `C-GOBERNANZA-RETOMA-04`.  
**Sesión inicial (histórica):** `SES-20261028-3F2B7A91`, generación 1.
**Titular actual según control:** `chatgpt-C-GOBERNANZA-RETOMA-04-SES-20261029-GV5KGJY8U5J` (alias operativo, no ID nativo).
**Instancia actual según control:** `chatgpt-gobernanza-retoma-2026-10-29-GV5KGJY8U5J`.
**Sesión actual según control:** `SES-20261029-GV5KGJY8U5J`, generación 5; ciclo `C-20261029-01A18A7F`.
**Control actual leído de vuelta:** blob `4768d6db0a620652f753262b6250c8cb4b891ca9`; evento `C-GOBERNANZA-RETOMA-04`.

## Evento más reciente · C-GOBERNANZA-FOLIACION-SECUENCIAL-01 · 2026-10-30 (pre-corte FOL1)

Por instrucción expresa del operador se incorporó **P042 · Foliación Global y por OCP**, se amplió **ART-024** con el contrato de conversación/ciclo/A/B y asignación central, y se actualizaron Metacanon a **1.25** y GOW a **2.12**. La fuente canónica fue leída de vuelta: DUG v363 · NX-363m, 42 principios, 18 anexos y 125 términos GOW.

La materialización FOL1 contiene el [registro maestro](../../ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json), el [esquema maestro](../../ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json), el [esquema A/B v1.1](../../ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json) y la [guía operativa v1.1](../../ambitos/gestion-conversacional/REGISTRO-CONVERSACIONAL-v1.1.md). El catálogo contiene 23 contextos OCP conocidos: 20 elegibles y tres bloqueados; otros cinco candidatos no se admiten todavía por identidad/clasificación pendiente. La cobertura se declara `KNOWN_INVENTORY_ONLY`.

**Estado:** FOL1 `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; generación 0; contadores globales y por OCP en cero; asignaciones vacías. No se renumeran folios históricos. La IPZ no se ha modificado y ART-025 permanece intacto. La activación queda condicionada a la preparación de la nueva IPZ y al corte en una conversación nueva.

**Límites:** el maestro central y compare/read-back por SHA ofrecen serialización cooperativa, no bloqueo de servidor; el alcance OCP es el inventario conocido, no una prueba exhaustiva de todos los contextos organizacionales. No se ha ejecutado todavía una prueba de concurrencia real ni validación completa con un motor JSON Schema externo.

Evidencia técnica: [DUG](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042) · [registro maestro](../../ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json) · [guía](../../ambitos/gestion-conversacional/REGISTRO-CONVERSACIONAL-v1.1.md).

## Ciclo histórico · C-GOBERNANZA-AT-ENDURECIMIENTO-01 · 2026-10-29

Por instrucción del operador, se endureció la definición operativa de AT, preservando AT v1.0 como antecedente. **AT v1.1** incorpora el contrato verificable del vector semántico como fuente de verdad de intención/requisito, la separación entre original/vector/interpretación, reglas para incertidumbre, enlaces en ambos sentidos, recuperación prioritaria de dictados ya persistidos, convergencia separada con Persistencia documental y Registro conversacional, compatibilidad futura LISA, protocolo obligatorio por ciclo y pruebas falsables.

Se creó el [esquema de vectores semánticos AT v1.1](entregas/CHATGPT-v0.8/ESQUEMA-VECTORES-SEMANTICOS-AT-v1.1.json), que exige referencias de fuente, ciclo, interpretación, destinos, impactos, resultados, retorno, autorización, estado LISA y verificación. La solicitud literal se conservó como `SRC-C-20261029-5510927B-USER` y se enlazó a los vectores del dictado anterior `SRC-C-20261030-9D7E31A2-USER`.

La implementación mantiene separadas tres responsabilidades: Persistencia documental custodia originales/derivados; Registro conversacional conserva pares E/S; AT consume esas fuentes y propaga cambios desde vectores semánticos. La relación de cada vector con sus resultados y el retorno desde cada resultado se comprobó en ambos sentidos en este ciclo: seis vectores literales, seis resultados consultables por retorno y pareja E/S releída.

**Compuerta normativa:** DUG v362 ART-020/024 aún clasifican Trazabilidad semántica dentro de Gestión conversacional. AT v1.1 fija la definición operativa objetivo, pero no altera ART-020/024 ni el GOW. La alineación normativa permanece pendiente de autorización expresa P005. El canon LISA no se modificó; la integración completa LISA/FIAT/LSV/MAT sigue pendiente.

**Límites operativos:** el esquema/registro v1.1 no crea un motor autónomo ni captura automática. Este ciclo se registró manualmente y quedó persistido tras lectura de vuelta.

Evidencia: [crónica](cronica/C-GOBERNANZA-AT-ENDURECIMIENTO-01.md) · [evidencia](evidencias/C-GOBERNANZA-AT-ENDURECIMIENTO-01.json) · [AT v1.1](entregas/CHATGPT-v0.8/AT-v1.1.md) · [esquema](entregas/CHATGPT-v0.8/ESQUEMA-VECTORES-SEMANTICOS-AT-v1.1.json) · [diálogo](conversaciones/C-GOBERNANZA-AT-ENDURECIMIENTO-01-dialogo.jsonl).

## Ciclo previo · C-GOBERNANZA-ARTICULACION-REGISTRO-01 · 2026-10-30

El operador confirmó que **Gobernanza es el frente responsable** y que Tareas es trabajo/ámbito en desarrollo dentro de ese frente, no un frente independiente. No se requiere transferencia de titularidad de Tareas.

Se revisó AT v1.0 para incorporar la **trazabilidad semántica como capacidad fundamental de AT**: los vectores semánticos son segmentos verbatim de las entradas del operador y deben enlazar bidireccionalmente con reglas/principios, anexos, OCP, cambios, pruebas y resultados. Persistencia documental custodia documentos originales/derivados; Registro conversacional conserva los ciclos literales E/S y sus metadatos; AT usa esos registros como fuentes para justificar la propagación. La relación entre los tres componentes es de convergencia y enlace, no de fusión.

AT v1.0 también establece compatibilidad futura con LISA: vector literal como origen y referencia a L0→REQ→ACR cuando aplique, sin que el modelo invente o ratifique L0. La integración completa de LISA sigue pendiente.

**Conflicto normativo identificado:** DUG v362 ART-020/024 todavía clasifica Trazabilidad semántica como módulo interno de Gestión conversacional. La definición operativa revisada propone reclasificarla como capacidad de AT y mantener Registro conversacional en Gestión conversacional. No se modificó DUG/GOW: P005 exige autorización explícita previa y el control activo excluye enmiendas sustantivas no autorizadas.

**Persistencia:** se guardó el dictado íntegro como `SRC-C-20261030-9D7E31A2-USER`, ciclo `C-20261030-9D7E31A2`, UUIDv7 local `01a18a1b-3000-7b4c-892a-8d31e5f6a7b8`; pareja E/S, registro maestro y trazas semánticas añadidos. La captura fue manual y leída de vuelta; IPZA no prueba ni activa captura automática.

Evidencia: [crónica](cronica/C-GOBERNANZA-ARTICULACION-REGISTRO-01.md) · [evidencia](evidencias/C-GOBERNANZA-ARTICULACION-REGISTRO-01.json) · [AT v1.0 revisada](entregas/CHATGPT-v0.8/AT-v1.0.md) · [salida](entregas/CHATGPT-v0.8/C-GOBERNANZA-ARTICULACION-REGISTRO-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-ARTICULACION-REGISTRO-01-dialogo.jsonl).

## Ciclo previo · C-GOBERNANZA-AT-V1-01 · 2026-10-29

Se cerró la definición operativa de **Articulación Trazable (AT) v1.0** para el alcance precisado por el operador: articular cambios conceptuales/metodológicos longitudinalmente a través de los niveles OCP, el sistema de gobierno del DUG, el orden de principios, la jerarquía subordinada de anexos y los destinos que realmente dependan del cambio. AT no se amplía a un sistema universal de gestión de cambios.

La definición establece un solo mecanismo integrado con etapas internas: adquirir origen/autoridad; clasificar nivel; trazar destinos afectados y no afectados; comprobar autorización por destino; realizar en orden de dependencia; verificar y registrar por lectura de vuelta. Se distingue la jerarquía conceptual OCP, la jerarquía documental de anexos y la materialización física. Los principios siguen siendo el único elemento de gobierno directo; los anexos no adquieren autoridad independiente. AT es responsable de realizar lo autorizado, pero no se autoautoriza ni elude restricciones.

No se justificó crear submódulos para v1.0: las funciones comparten origen, mapa de dependencias, compuertas y registro. La descomposición se difiere hasta que el uso real demuestre responsabilidades o contratos independientes.

**Validación:** (1) walkthrough retrospectivo positivo con el cambio de taxonomía/Propósito de C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01; (2) walkthrough negativo con Tareas, que continúa en incubación y no puede promoverse al canon por la sola existencia de carpeta/diseño/estándar local. Son pruebas de escritorio basadas en antecedentes y fuente vigente, no ejecución automatizada de AT.

**Estado:** AT v1.0 cerrada como definición operativa propuesta, no canonizada. DUG v362, Metacanon 1.24, GOW 2.11, Canon LISA y el OCP Tareas no se modificaron.

Evidencia: [crónica](cronica/C-GOBERNANZA-AT-V1-01.md) · [evidencia](evidencias/C-GOBERNANZA-AT-V1-01.json) · [definición](entregas/CHATGPT-v0.8/AT-v1.0.md) · [salida](entregas/CHATGPT-v0.8/C-GOBERNANZA-AT-V1-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-AT-V1-01-dialogo.jsonl).

## Ciclo previo · C-GOBERNANZA-IPZ-GOW-VERIFICACION-01 · 2026-10-29

Se verificó la finalización documental de la especificación de entrada de ChatGPT sin reescribir una canonización ya persistida. Fuente canónica leída de vuelta desde `main`: DUG v362 · NX-362m, blob `b7593409c428e209d35f53a5f13501652208d949`, 41 principios, 18 anexos, Metacanon 1.24 y GOW 2.11.

Auditoría GOW: 122 términos; 122 definiciones y anclas presentes; ninguna entrada sin definición/ancla; longitud máxima observada 308 caracteres; máximo tres oraciones; ninguna definición rebasa la guía de 40 palabras. El contrato de definición establece un párrafo de una a cuatro oraciones, lenguaje sencillo, práctico y directo, hasta 40 palabras como guía, separando alias, equivalencias, alcance, procedencia y notas.

§ARR contiene 21 términos esenciales; todos resuelven a entradas canónicas existentes. Su configuración exige lectura antes de interpretar el resto de las instrucciones personalizadas y limita la adquisición inicial a lo indispensable. §SUM y §EI describen el propósito ampliado del GOW: fijar significados, abreviaturas, equivalencias y asociaciones autorizadas de transcripción, y ofrecer vocabulario inicial para comprender el sistema. El GOW no gobierna ni concede permisos.

ART-025 ya canoniza el propósito y el contrato de la IPZ: acceso compacto, primero vocabulario, después DUG y principios en su orden; anexos solo por remisión de los principios; refuerzo selectivo sin activar capacidades ni crear autoridad paralela. El candidato IPZ v0.5 se leyó desde `main`, blob `281f20daad92284fe29151372e83114a037f83f5`, 1362 unidades UTF-16. No se verificó su instalación en el campo nativo de ChatGPT.

No se modificó DUG/GOW en este ciclo: el contrato ya se encontraba canonizado en el evento `C-GOBERNANZA-IPZ-GOW-BOOTSTRAP-01`. Se actualizan este núcleo, el índice y los pendientes para reflejar las fuentes y el control vigentes. La prueba funcional en una conversación nueva sigue pendiente porque no puede acreditarse desde esta lectura documental.

Evidencia: [crónica](cronica/C-GOBERNANZA-IPZ-GOW-VERIFICACION-01.md) · [evidencia](evidencias/C-GOBERNANZA-IPZ-GOW-VERIFICACION-01.json) · [salida](entregas/CHATGPT-v0.7/C-GOBERNANZA-IPZ-GOW-VERIFICACION-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-IPZ-GOW-VERIFICACION-01-dialogo.jsonl).

## Ciclo previo · C-GOBERNANZA-GESTION-CONVERSACIONAL-01 · 2026-10-29

Gestión conversacional queda normada en el DUG v360 · NX-360m mediante ART-024, hijo documental de ART-020, con dos componentes internos: Registro conversacional y Trazabilidad semántica. El GOW es v2.9 con 111 términos; no se añaden principios, no cambia Metacanon 1.24 y no se crean subámbitos taxonómicos. La materialización inicial está en [ambitos/gestion-conversacional/](../../ambitos/gestion-conversacional/README.md). La prueba de uso registra una pareja E/S, un UUIDv7 local estable, folio y referencias de repositorio/frente, además de etiquetas de trazabilidad y extractos verbatim históricos con procedencia. Captura automática y el campo nativo IPZ no se declaran instalados.

Evidencia del ciclo: [crónica](cronica/C-GOBERNANZA-GESTION-CONVERSACIONAL-01.md) · [evidencia](evidencias/C-GOBERNANZA-GESTION-CONVERSACIONAL-01.json) · [salida](entregas/CHATGPT-v0.6/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-dialogo.jsonl).

## Ciclo anterior · C-GOBERNANZA-LISA-ARTICULACION-01 · 2026-10-29

**Persistencia documental.** Los originales históricos [Athanor / Lisa Hub v0.9.43](documentos/originales/AthanorJue20260319-normativo_v0943.html) y [LISA · Explicación Consolidada v1.0](<documentos/originales/LISA-Explicacion-Consolidada-v1.0%20%281%29.pdf>) viven en el OCP bajo documentos/originales/. Manifiesto: [MANIFIESTO-DOCUMENTAL.json](documentos/MANIFIESTO-DOCUMENTAL.json). Commit inicial de originales: 70dd52c716e01676f33eff234db31a1100cbe90f; la lectura de vuelta comparó exactamente el Base64 de ambos archivos fuente contra la respuesta de GitHub.

**Compatibilidad LISA ↔ AT.** Se revisó el Canon LISA v1.2 y las dependencias relevantes en Notion. Dictamen: compatible por composición; LISA conserva la raíz de intención y la cadena L0→REQ→L2→RE→ACR→COD; la AT propuesta puede ocuparse del análisis transversal de impacto, delimitación de componentes afectados/no afectados, autorización, cambio mínimo y verificación. La AT no está ratificada, no tiene nombre expandido canonizado y no se añadió un L0 por inferencia del modelo.

**Estado de autorización.** No hubo cambio al DUG v359 · NX-359m, Metacanon 1.24 ni GOW 2.8, tampoco a Canon LISA, FIAT, Convención de Código Firmado, PCA o Notion. La especificación LISA v1.2 está ratificada en Notion; la integración LISA/LSV/MAT en Cora OS v1.0 sigue sujeta a los candados del [Anclaje LISA ↔ Cora OS](https://app.notion.com/p/386a4187824182a1ae9201e95cc592ce). La consulta disponible a Notion devuelve cortes fechados el 2026-10-20; no se certifican cambios posteriores.

Evidencia del ciclo: [crónica](cronica/C-GOBERNANZA-LISA-ARTICULACION-01.md) · [evidencia](evidencias/C-GOBERNANZA-LISA-ARTICULACION-01.json) · [salida](entregas/CHATGPT-v0.5/C-GOBERNANZA-LISA-ARTICULACION-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-LISA-ARTICULACION-01-dialogo.jsonl).

## Ciclo anterior · C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01 · 2026-10-28

Fuente canónica leída de vuelta desde `main`: [DUG v359 · NX-359m](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), blob `b2ff2845a5a99dc4ce3cafafc4f8e43607d48145`, commit `1377e697cfe7d18b7558ab1eab46e0154e16426d`. Metacanon 1.24; GOW 2.8 con 109 términos; 41 principios; 16 anexos; taxonomía estructural 1.3.

La taxonomía mantiene **Ámbitos** como categoría conceptual diferenciada de la infraestructura GitHub. Se canoniza **Propósito** como elemento conceptual declarativo asociado al alcance de un FT, materializable como archivo compacto o sección de un documento raíz, sin directorio obligatorio. Los ámbitos funcionales transversales canónicos siguen siendo Persistencia documental y Gestión conversacional. La taxonomía no exige un directorio `ambitos/` en cada repositorio OCP.

El ajuste se registró en ART-015, ART-019, ART-020, ART-021, Metacanon §§46/51, la taxonomía estructurada y GOW. DUG/GOW se actualizaron con la autorización expresa del operador limitada a este cambio. No se añadió un principio ni un anexo, y Tareas continúa en incubación, sin canonización. Se parseó el JSON incrustado; la compilación sintáctica aislada del JavaScript pasó; se detectaron 27 IDs estáticos y cero duplicados. No se ejecutó el navegador/renderizado ni la auditoría dinámica completa.

Evidencia del ciclo: [crónica](cronica/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01.md) · [evidencia](evidencias/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01.json) · [salida](entregas/CHATGPT-v0.4/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01-salida-final.md) · [diálogo](conversaciones/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01-dialogo.jsonl).

## Ámbito funcional propuesto · Tareas v1.0 · 2026-10-28

El operador instruyó inaugurar Tareas y luego reducir sus diseños a la mínima expresión con apego literal a la fuente. La fuente canónica vigente es **DUG v359 · NX-359m**. Tareas sigue en incubación y no está canonizado. Persistencia documental y Gestión conversacional siguen siendo los ámbitos funcionales transversales canónicos; Propósito es un elemento conceptual declarativo asociado al alcance de un FT. La ubicación [ambitos/tareas/](../../ambitos/tareas/README.md) es provisional, no una regla taxonómica general. El estándar común de tarea vigente como candidato es [v0.2 mínimo](../../ambitos/tareas/ESTANDAR-COMUN-DE-TAREA-v0.2.md), con su [esquema JSON](../../ambitos/tareas/ESQUEMA-TAREA-COMUN-v0.2.json); v0.1 se conserva como antecedente histórico. Véanse la [crónica del recorte](../../ambitos/tareas/cronica/C-TAREAS-ESTANDAR-MINIMO-02.md) y la [evidencia](../../ambitos/tareas/evidencias/C-TAREAS-ESTANDAR-MINIMO-02.json). Antes de canonizar Tareas debe demostrarse que añade una capacidad necesaria.

## Estado de transferencia · C-GOBERNANZA-RETOMA-02 · 2026-10-28 (histórico)

La titularidad de Gobernanza se transfirió mediante compare-and-swap por SHA y lectura de vuelta: generación 2 → 3. DUG vigente v358 · NX-358m, Metacanon 1.23, GOW 2.7; fuente blob 89a28e4d05f5baab9c4b86abdb9fbfc532690c75. El chequeo estático de la capa HTML fuera de los scripts encontró 27 IDs, cero duplicados y cero destinos de fragmento ausentes. No es una prueba de navegador ni cierra la auditoría dinámica.

El último ciclo previo tiene crónica y evidencia, pero no se localizó su salida final dedicada; la única salida final antigua corresponde a la apertura v345 y no se presenta como la más reciente. Véase [crónica de retoma](cronica/C-GOBERNANZA-RETOMA-02.md), [evidencia](evidencias/C-GOBERNANZA-RETOMA-02.json), [salida](entregas/CHATGPT-v0.3/C-GOBERNANZA-RETOMA-02-salida-final.md) y [diálogo disponible](conversaciones/C-GOBERNANZA-RETOMA-02-dialogo.jsonl).

## Continuidad del predecesor · C-GOBERNANZA-CONTINUIDAD-03 · 2026-10-28

El operador remitió un fragmento extenso de una conversación anterior que documenta los hitos históricos DUG v353, v354 y v355 relativos a P041/ART-014, la taxonomía estructural de S y M, los anexos ART-015 a ART-022 y las equivalencias del GOW para Ámbito. El estado normativo actual se adquiere desde el DUG v358 · NX-358m, blob 89a28e4d05f5baab9c4b86abdb9fbfc532690c75; no se infieren pruebas actuales del resumen histórico.

La conversación fue pegada dentro de un único mensaje y no se dispone de exportación nativa ni ID de mensaje. Se guarda un índice/síntesis con procedencia y se declara expresamente que el fragmento completo no se ha archivado literalmente. Véase [crónica](cronica/C-GOBERNANZA-CONTINUIDAD-03.md), [evidencia](evidencias/C-GOBERNANZA-CONTINUIDAD-03.json), [salida](entregas/CHATGPT-v0.3/C-GOBERNANZA-CONTINUIDAD-03-salida-final.md) e [índice del fragmento](conversaciones/C-GOBERNANZA-CONTINUIDAD-03-fragmento-predecesor.jsonl).

## Propósito y límite

Este frente separado se ocupa inicialmente del mantenimiento operativo, integridad, navegación y verificación del documento único de gobernanza:

[`gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html)

El OCP previo `frentes/metacanon/` mantiene su nombre y su control. **Metacanon** sigue nombrando el método (v1.23, integrado en el DUG vigente); **Gobernanza** es el nuevo nombre de este frente separado. Este núcleo registra estado de trabajo y no duplica las normas del HTML ni constituye una fuente normativa paralela.

## Fuente canónica observada al abrir el frente · registro histórico

- Documento: **Gobernanza única Samantha v345**.
- Blob SHA observado en `main`: `4d4d4f7077d58ed48d12bc856bc81ec414fe8733`.
- Rama: `main`.
- Integridad del JSON incrustado: **FAIL** en la comprobación directa de `JSON.parse`; error inicial comunicado en la posición 97306.
- Integridad del JavaScript: las cuatro extracciones de bloques de script comprobadas pasaron `new Function` en una prueba local de sintaxis; esto no constituye validación de ejecución o renderizado en navegador.
- La causa material no debe reducirse a escapar un carácter aislado: el contenido recuperado del JSON contiene una etiqueta `<script>` y código del renderizador dentro del bloque de texto asociado a `ART-013`, compatible con una rotura del límite del bloque de datos y con saltos de línea sin escapar.
- No se ha escrito ni reparado aún el HTML de gobernanza en este ciclo.

## Alcance de trabajo recibido

1. Reparar mínimamente el JSON/JavaScript de la gobernanza única sin perder ni reinterpretar el contenido humano.
2. Verificar directamente las secciones, anexos, IDs, enlaces de navegación y retornos después de la reparación.
3. Incorporar el handoff de RDC únicamente después de resolver la colisión de identificadores existentes; no duplicar ni renumerar IDs silenciosamente.
4. Corregir referencias de navegación obsoletas desde los puntos de entrada que correspondan.
5. Preparar el texto de IPZ con enlace directo al anexo vigente y declarar explícitamente que la instalación nativa queda pendiente si las herramientas no la permiten.

## Límites

- No modificar contenido normativo sustantivo de Samantha ni el GOW por iniciativa propia.
- No crear documentos normativos paralelos; la fuente normativa única sigue siendo el HTML canónico.
- No ejecutar workflows de GitHub Actions ni consultar sus resultados.
- No ejecutar el comando RDC por el mero hecho de documentarlo.
- No afirmar que IPZ nativo está actualizado sin una operación real y lectura de vuelta.

## Estado inicial · registro histórico de apertura

**ABIERTO · En preflight.** La creación de este frente y su control de responsabilidad sí se leyeron de vuelta. La corrección del HTML, el anexo RDC y la instalación de IPZ siguen pendientes. Consulte [Pendientes](PENDIENTES.md) y el [control de responsabilidad](CONTROL-RESPONSABILIDAD.json).

## Estado previo a la articulación definitiva · DUG v352 · mismo evento

Responsabilidad transferida y verificada: control de `main` actualizado de generación 1 a 2. El titular receptor es `chatgpt-C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20-SES-20261028-CPD20-1606` (alias operativo no nativo). Blob de control anterior `826574e7cf1d346960e0a48f33bb396588f307e2`, blob de lectura de vuelta `7739102ac4623690a0aeeb470ff989bb27963cce`, commit `0074427119b098b46bf5591243a78cf7e6f83644`.

El DUG vigente leído desde `main` es v352 · NX-352m, blob `94473eccb6fa71303d5908ce678f7efeb191c215`. `gov-data` parsea como JSON; la compilación sintáctica aislada del JavaScript pasa, sin prueba de ejecución en navegador. Estado declarado: 41 principios, 8 anexos, Metacanon v1.21, GOW v2.3 y 99 términos. P041 mide 282 caracteres y ART-014 define el SPDF. Las anclas P041/ART-014 y los destinos de GOW `gow-spdf`, `gow-spd`, `gow-dug` se encuentran definidos en los datos/código integrado; la auditoría dinámica de retornos aún no se ha ejecutado.

Puntos de entrada actualizados y leídos de vuelta: `INICIO.md` blob `5cbb0c93b3c982c2453b6ef9af2b971a2d7710c8`, `frentes/metacanon/README.md` blob `78b93ad639e98cf400ff84523dfbd505171b8d10`, IPZ blob `a220515e8373740084161c93c8ec7557b2d2ec5b` (1479 caracteres). No se verificó instalación del campo nativo de Instrucciones Personalizadas.

La prueba E2E del SPDF no se ejecutó: no hay un archivo adjunto real que preservar en esta conversación; el mensaje no se sustituyó por un archivo fabricado y no se creó un manifiesto vacío. Tampoco está verificada una recuperación por una segunda instancia autorizada.
## Articulación normativa definitiva · DUG v353 · NX-353m · 2026-10-28

El principio mínimo y sus reglas concretas quedaron incorporados en la fuente normativa única. P041 ahora dispone que, en toda conversación responsable de un FT/FDT, cada adjunto es insumo operativo, preservado como original en el OCP autorizado y verificado por lectura de vuelta y cotejo. Texto normativo: 294 caracteres.

ART-014 recibió una nueva sección 2, “Activación por responsabilidad y tratamiento de adjuntos”, que establece: disparador predeterminado; revisión de adjuntos previos todavía accesibles al asumir el frente; resolución del OCP desde nombre canónico/núcleo/README/control; captura del original antes de procesarlo; actualización del manifiesto; lectura de vuelta y cotejo; contrato multiplataforma y límites de herramientas; uso de las Instrucciones Personalizadas de ChatGPT como punto de entrada subordinado, nunca como fuente normativa ni instalación presumida. Las secciones siguientes se renumeraron, sin añadir un anexo ni un principio independiente.

Fuente actual: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `16c93745311a5405166a31b583c2a648fda0d044`; commit `868a8e9db9ede8611c1dc814d5b6a54060dd9269`. JSON parseado y JavaScript comprobado por compilación sintáctica aislada; no se afirma ejecución de navegador.

Metadato GOW alineado al nuevo blob mediante commit `623645f5f814fbe3b1e7c7684479360fe39648dc`. El artefacto IPZ mide 1492 caracteres y referencia directamente ART-014; no se pudo instalar/verificar el campo nativo de Instrucciones Personalizadas. El objeto de persistencia real E2E sigue pendiente porque no hay un adjunto original disponible en esta conversación.


## Actualización taxonómica · C-GOBERNANZA-TAXONOMIA-ESTRUCTURAL-SYM-01 · DUG v354 · NX-354m · 2026-10-28

Por instrucción explícita del operador se actualizó la fuente normativa única `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html` para incorporar la taxonomía estructural de Ser y Mente (S y M), las equivalencias terminológicas del GOW y una jerarquía de anexos con niveles explícitos. La lectura de vuelta confirma DUG v354 · NX-354m, Metacanon 1.22, GOW 2.4, 41 principios, 16 anexos y 102 términos.

- Fuente DUG: blob `695d83ea6913ab3962a87e49b008c366f512e34e`, commit `012eba06f4cd729d9c989862f701a6842aa59a36`.
- Anexos nuevos: ART-015 nivel 1; ART-016 a ART-022 nivel 2; ART-014 queda como nivel 3 bajo ART-022. Los anexos preexistentes ART-007 a ART-013 se preservan como raíces de nivel 1.
- Validación: JSON embebido parseado; compilación sintáctica del JavaScript operativo aislado aprobada; cero IDs duplicados en el HTML estático; 16 marcadores de anexo coinciden con 16 artefactos estructurados.
- No se ejecutó el renderizado ni la auditoría dinámica del navegador. Notion y el campo nativo IPZ no se actualizaron/verificaron; la prueba SPDF E2E con original real continúa pendiente.
- Metacanon §46/§51 y los puntos de entrada/inventario se alinearon con v1.22, S y M y el tratamiento de ámbitos funcionales transversales.


## Equivalencias operativas de ámbito · C-GOBERNANZA-EQUIVALENCIAS-AMBITO-01 · DUG v355 · NX-355m · 2026-10-28

Por instrucción explícita del operador se añadieron al GOW v2.5 tres términos: **Ámbito**, **Ámbito de frente de trabajo** y **Ámbito de OCP**. Se declaran operativamente intercambiables cuando denotan el mismo alcance delimitado; los calificadores precisan contexto pero no crean un FT, un OCP ni una ubicación obligatorios.

Fuente canónica releída: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `aea6628f3e3b117468ef70a8655ebfac124a522d`, commit `a563e6c9a0ac3eb58d31c498af40342fa7a01d0d`. DUG v355 · NX-355m; Metacanon 1.22; GOW 2.5; 41 principios, 16 anexos y 105 términos. El JSON embebido parsea y el JavaScript operativo superó compilación sintáctica aislada; renderizado dinámico en navegador no ejecutado. Los puntos de entrada y los metadatos se actualizaron y leyeron de vuelta. Notion/IPZ y la prueba SPDF E2E permanecen sin verificación.


## Jerarquía funcional Contexto → Gestión conversacional · C-GOBERNANZA-CONTEXTO-GESTION-CONVERSACIONAL-01 · DUG v356 · NX-356m · 2026-10-28

Se incorporó a la taxonomía estructural de Ser y Mente la jerarquía funcional **Contexto (nivel funcional 1) → Gestión conversacional (nivel funcional 2)**. Contexto conserva una definición deliberadamente inicial y abierta. Gestión conversacional abarca identificar, registrar, organizar y recuperar conversaciones de trabajo, así como facilitar la continuidad entre conversaciones o instancias a partir de registros disponibles.

Esta jerarquía funcional es distinta de la jerarquía documental del DUG: **ART-020 sigue siendo un anexo de nivel documental 2, subordinado a ART-015**. La relación de persistencia documental y gestión de tareas con Contexto no se determina en este evento; no se reubican sus reglas ni se crea una carpeta, FT u OCP por simetría.

El GOW sube a v2.6 con 107 términos y la proyección estructurada de la taxonomía a v1.1. Se verificaron lectura de vuelta exacta del DUG, parseo del JSON embebido y compilación sintáctica aislada del JavaScript operativo. **No** se ejecutó renderizado de navegador ni auditoría dinámica de enlaces. Notion no se actualizó ni releyó; la instalación nativa de IPZ continúa sin verificar. No se afirma captura automática, sincronización continua ni conservación íntegra de todas las conversaciones.

**Folio global de ciclo:** C-20261028-869AF58C. **Fuente canónica releída:** `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `c364e179e8e9b6a3d566a8e690dfa1a7cce91798`, commit `706e02a0dc0074e751667de8033d09411fad5ad9`.


## OCP ubicuo y reversión de Contexto · C-GOBERNANZA-OCP-UBICUO-REVERSA-CONTEXTO-01 · DUG v357 · NX-357m · 2026-10-28

Por instrucción expresa del operador, la taxonomía define **OCP como aplicable a cada unidad de su nivel taxonómico**. La Metodología, en sentido general y abstracto, es el OCP raíz; organización, repositorios, frentes, ámbitos y futuros subámbitos son OCP de su propio nivel. OCP no constituye un nivel adicional ni exige por sí mismo una carpeta, repositorio físico, núcleo adicional o sincronización exclusiva. La identidad taxonómica y su materialización física se determinan por separado.

La decisión previa registrada en `C-GOBERNANZA-CONTEXTO-GESTION-CONVERSACIONAL-01` queda **SUPERSEDIDA Y REVERTIDA** en la norma vigente: Contexto ya no es un ámbito funcional independiente y Gestión conversacional ya no depende de Contexto. El historial Git, la crónica y la evidencia del evento anterior se conservan como antecedente histórico; no se borran ni se consideran la definición actual.

Los únicos ámbitos funcionales definidos actualmente son **Persistencia documental** y **Gestión conversacional**, ambos al mismo nivel taxonómico. ART-020 permite que cualquiera se subdivida en subámbitos de nivel 2 o N cuando una necesidad delimitada lo justifique, pero esa capacidad es potencial y no crea subámbitos automáticamente. ART-022 y ART-014 siguen definiendo la estructura y el procedimiento de materialización documental aplicable, sin convertir el ámbito transversal en un directorio adicional por simetría.

El GOW pasa a v2.7 con 108 términos. Se incorpora la entrada **Objeto Canónico de Persistencia (OCP)** y el campo estructurado `definition`, distinto de aliases y equivalencias terminológicas. Metacanon pasa a 1.23 y la taxonomía estructurada a 1.2. DUG v357 conserva 41 principios y 16 anexos.

**Fuente canónica releída:** `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `87627e52a4cd5227b6a011cb4ba87a5289ce836d`, commit `1cf0f767a7771db52a48ac59dd8b51fc914d9620`.

Se validó lectura de vuelta exacta del DUG, parseo de JSON y compilación sintáctica aislada de JavaScript. Los IDs duplicados detectados en el HTML estático y las anclas duplicadas del contenido inspeccionado fueron cero. No se ejecutó renderizado de navegador ni auditoría dinámica de enlaces. Notion no se actualizó ni se releyó; la instalación nativa de IPZ no se verificó. La prueba E2E de persistencia documental con un original real y recuperación por otra instancia autorizada permanece pendiente. GitHub Actions/workflows no se consultaron ni ejecutaron.

**Folio global de ciclo:** `C-20261028-E025C250`. Este núcleo es un registro operativo, no una fuente normativa paralela; la norma vigente permanece en el DUG HTML.


## Corrección de referencia de versión en Metacanon · C-GOBERNANZA-REFERENCIAS-VERSION-01 · DUG v358 · NX-358m · 2026-10-28

En una auditoría final de coherencia se detectó que el resumen inicial humano de Metacanon aún apuntaba a Gobierno general v356 · NX-356m, mientras el DUG vigente ya era v357 · NX-357m. Se corrigió la referencia para que apunte a Gobierno general v358 · NX-358m y se versionó el DUG como v358 · NX-358m. El cambio es de alineación de referencia; **no altera** la semántica de Metacanon 1.23, GOW 2.7 (108 términos), taxonomía 1.2, el sentido ubicuo de OCP ni la lista vigente de ámbitos.

**Fuente canónica releída:** `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `89a28e4d05f5baab9c4b86abdb9fbfc532690c75`, commit `1dd88b177d8782bae5e266310979f5307665d750`.

Se actualizaron de manera puntual los metadatos del GOW, `INICIO.md`, los README de Metacanon y Gobernanza, y los pendientes para apuntar a v358. La lectura de vuelta exacta se comprobó en los archivos modificados. El GOW y la taxonomía no cambiaron de versión.

Validación del DUG: JSON embebido válido; JavaScript operativo compilado sintácticamente de forma aislada; cero IDs duplicados en el HTML estático y cero anclas duplicadas detectadas en el contenido inspeccionado. **No** se ejecutaron renderizado de navegador ni auditoría dinámica completa de enlaces. Notion no se actualizó ni se releyó; IPZ nativo no se verificó; la prueba SPDF E2E sigue pendiente de adjunto original y segunda instancia autorizada. GitHub Actions/workflows no se consultaron ni ejecutaron.

**Folio global del ciclo:** `C-20261028-FA636DB0`. Este registro es operativo; la única fuente normativa permanece en el DUG HTML de `main`.
