# Ideas pendientes · frente Metacanon

Registro de trabajo, no sustituto del estado canónico ni de las conversaciones originales. Las decisiones aquí recogidas no se presentan como implementaciones. La prioridad sigue urgencia e impacto; no se altera una prioridad acordada sin indicación del operador.

## Mandato vigente

Primero lo urgente y después la mejora continua. Conservar las notas de lo que dice el operador y poder mostrar las ideas pendientes cuando lo solicite. No declarar conservación íntegra si falta verificar la cobertura de los originales.

## Urgente

- **CONT-01 · Parcial, banco mecánico verificado y prueba semántica pendiente:** ensayar en un entorno virtual la continuidad de contexto entre conversaciones; iterar sobre los fallos observados. Distinguir pruebas de archivos y recuperación de estado de pruebas semánticas con modelos independientes. No prometer perfección universal.
- **CONT-02 · Implementado documentalmente en el corte 2026-10-29; validación semántica pendiente:** prompt universal restaurado en la raíz, BCR reconciliado con el DUG integrado v360 y artefacto IPZ actualizado a 1.365 caracteres. La instalación de la IPZ nativa y la prueba en una conversación realmente nueva siguen pendientes; no declarar continuidad universal aceptada.
- **GOB-01 · Aplicado y cotejado en v333; conserva 34 principios previos:** añadir al metaprompt de Samantha únicamente lo necesario para dar cabida a los frentes y su continuidad, preservando identidad, dinámica y normas existentes. No equivale a autorización para rehacerlo.
- **PORT-01 · Parcial:** terminar la portabilidad del metacanon. Ya existe el primer bloque documental 1.7 en GitHub; todavía no acredita arranque ligero ni funcionamiento sin acceso a Notion. La dependencia de conectores y el modo de transporte sin conector requieren resolución explícita.
- **CUST-01 · En curso:** mantener entradas del operador y salidas visibles del asistente en la carpeta del frente, con secuencia y límites de conversación, plataforma y modelo. Archivar metadatos solo cuando sean conocidos; no inferir modelo, rol o persona.
- **CUST-02 · Cobertura recuperada de esta sesión directa:** 22 entradas del operador hasta535 y 29 salidas visibles hasta542, con originales e índice verificable. El bloque inicial parcial se conserva como historia. Estas notas siguen siendo síntesis, no sustituyen el diálogo literal; no abarcan otras conversaciones ni mensajes futuros.

## Importantes, sin implementación acreditada

- **SYNC-01 · Requisito ratificado, pendiente:** cada cambio a un documento en una aplicación de espacio de trabajo, como Notion, debe desencadenar la actualización automática de su espejo en el repositorio. Dirección ratificada: aplicación → repositorio. Una copia puntual no acredita sincronización perpetua. Detectar y visibilizar fallos; no prometer infalibilidad.
- **ARQ-01 · Arquitectura ratificada, materialización parcial:** objeto = directorio completo. Un archivo de entrada enruta hacia un núcleo operativo único y otros materiales según necesidad. Evitar cargar un archivo monolítico de aproximadamente 70 000 caracteres. Ventana de contexto y copia de conversaciones son relacionadas, pero distintas.
- **HIST-01 · Requisito ratificado:** historial secuenciado de la conversación general, incluidos cambios de plataforma, conversación y modelo; identidad/rol solo cuando estén asignados. Conservar originales además de la crónica y distinguir resúmenes de originales.
- **DOC-01 · Requisito ratificado:** el frente contiene copias de los documentos producidos en aplicaciones especializadas. GitHub sostiene la persistencia transversal de la organización SeryMente; las aplicaciones son superficies de trabajo, no una dependencia exclusiva.
- **GLOS-01 · Requisito ratificado:** «frente de trabajo» es la denominación corta de «objeto canónico de persistencia de frente de trabajo». Enumerar formalmente sus características generales a partir de la práctica de estas semanas, no inventar complejidad por anticipación.
- **GOB-02 · Parcial:** el metaprompt de Samantha es el gobierno general del repositorio y la organización, como el mismo documento sincronizado, no un gobierno paralelo. El espejo actual v333 se coteja con la fuente; las referencias v332 documentan la migración anterior.
- **SAM-ATOM-01 · Especificación registrada; auditoría pendiente:** revisar los 40 principios vigentes de Sam según Metacanon §50: folio Pnnn sin renumeración, peso 0–1, título «Principio D…», enunciado atómico de hasta 300 caracteres, redundancia, anexos tipificados por definir, alcance por plataforma y enlaces bidireccionales. Sam permanece v339 · NX-339m; no se ha reescrito en el ciclo M23. La auditoría completa y cualquier enmienda siguen pendientes.

## Diferidos explícitamente

- **SEG-01 · Alta importancia, diferido por urgencia:** seguridad de la información, cifrado de documentos y contenido de los frentes. El diferimiento NO autoriza publicar secretos, abrir repositorios ni eliminar controles existentes.
- **PRIUS-01 · Diferido hasta que no haya urgencias:** revisar la capa 2, Canon Sesión PRIUS, y decidir cómo utilizarla. El usuario prevé utilizarla, pero no la ha reactivado. La capa 1 sigue siendo el metaprompt de Samantha.

## Criterio de cierre de una idea

Conservar el identificador y registrar evidencia de implementación, cancelación explícita o sustitución acordada. No retirar pendientes por silencio ni por aparecer mencionados en una norma. Mostrar este registro cuando el operador pida las ideas pendientes.

## Cobertura

Este archivo recoge acuerdos disponibles en el contexto activo y la recapitulación de trabajo. Para las dos instrucciones nuevas conservadas literalmente, véase `conversaciones/C-METODOLOGIA-CONTINUIDAD-02-entradas.json`. No contiene pensamientos privados del modelo. No afirma custodia automática de mensajes futuros ni recuperación completa de conversaciones anteriores.

## Actualización C-METODOLOGIA-CONTINUIDAD-02

- **CONT-01:** banco mecánico ejecutado y reproducible: 33/33 en versión final y repetibilidad. La prueba semántica con otro modelo sigue pendiente; no cerrado integralmente.
- **CONT-02:** prompt universal publicado en la raíz; validación semántica pendiente.
- **GOB-01:** aplicado en fuente Notion v333 · NX-333m y espejo de este ciclo; 34/34 principios anteriores cotejados, uno añadido. No se reescribe la dinámica de Samantha.
- **CUST-02:** recuperado el diálogo directo de esta sesión: 22 entradas del operador hasta535 y 29 mensajes visibles del asistente hasta542. Evidencia en `evidencias/SESION-3ff5-cobertura.json`. Las declaraciones de laguna anteriores se conservan como historia; ya no describen este corte cotejado. No acredita otras sesiones ni captura futura automática.
- **PLAT-01 · Requisito ratificado, parcialmente cubierto:** Notion recibe el metaprompt por configuración; otras plataformas requieren carga explícita. Ambos modos incluidos en el banco mecánico. Detectada carga nativa antigua v330 frente a fuente viva v332 antes de esta edición v333. **Pendiente:** comprobar el ajuste real de personalización y ensayo independiente; no se afirma corregido.
- **CUST-03 · Mandato permanente de este frente:** el chat es donde el operador dice las cosas una vez; conservar sus palabras y respuestas visibles, no solo resúmenes. Verificar cobertura sin exigir redictado. No tratar una simple promesa de custodia como guardado efectivo.
- **GLOS-02 · Decisión ratificada:** «fuentes de trabajo» puede ser error de transcripción de «frentes de trabajo»; normalizar al interpretar y preservar el original literal.

Seguridad/cifrado, sincronización automática, portabilidad completa y Sesión PRIUS siguen en los estados y prioridades ya recogidos; no se cierran por esta actualización. Las listas previas son el registro histórico del arranque; esta actualización determina el estado de las ideas citadas.

- **REV-01 · Pendiente:** revisión general de fidelidad a lo dictado, coherencia, operación y portabilidad; no exigir al operador revisar todo el documento. No confundir el buen resultado previo con arquitectura óptima universal ni dar la razón automáticamente. Fuente: entradas165 y189, respuestas176 y202.

## Conciliación C-METODOLOGIA-RETOMA-05-r1

Esta actualización conserva las listas anteriores como historia. No modifica prioridades ratificadas ni da por implementado lo diseñado.

1. **CUST-03 / CUST-04 · Custodia y estado:** incorporar exportación recibida y mensajes visibles disponibles de la migración; cobertura en evidencias/C-METODOLOGIA-RETOMA-05.json. Las instrucciones posteriores estaban archivadas pero no reflejadas suficientemente en §9; se concilian sin inventar avances.
2. **CONT-02 / SAL-01 · Continuidad y recibo de gobierno:** afinar prompt universal y salida breve que muestre fuente, versión, frescura, aplicación y corte persistido; firma sola no prueba conducta. La retoma con historial adjunto no cuenta como prueba ciega del disparador universal.
3. **TRAZ-01 · Trazabilidad:** recuperar fuentes existentes del marco de especificación y vectores semánticos mencionado por el operador; cadena literal → intención normalizada → criterio aprobado → acción → resultado → evidencia. Diferencia tendiente a cero es meta; métrica semántica y mecanismo aún no están implementados ni validados.
4. **BENCH-01 · Medición versionada:** diseño inicial en pruebas/benchmark/PROTOCOLO-v0.1.md. Casos, indicadores y registros propuestos, no resultados. Conservar modalidad, denominadores, fuentes, versión y evidencia por ejecución. No volver a presentar el banco mecánico histórico como nueva prueba semántica.
5. **LAB-01 · Laboratorio reproducible:** inventariar solo por necesidad y autorización; instalación mediante conexión remota solicitada en el dictado, pero no demostrada por la retoma. La carpeta local llamada Metodologia con otro remoto es reporte histórico, no raíz vigente adquirida; no sobrescribirla.
6. **OBS-01 · Harmonia:** recuperar contrato modular existente y especificar observación de eventos accesibles de ChatGPT (prioridad) y la otra plataforma citada como «Cloud», cuya identificación como Claude debe verificarse en fuentes antes de implementar. No observar razonamiento interno ni atribuir causas comerciales sin evidencia. No elegir nueva arquitectura ni cruzar candados de seguridad por esta nota.
7. **PLAT-01 / GOB-02 · Discrepancia:** espejo GitHub v333 disponible; personalización/página accesible v330; página Notion declarada por el espejo no accesible desde el workspace actual. Vigencia relativa y correspondencia de origen no verificadas. No sobrescribir ni sustituir páginas por deducción.

Se mantienen SYNC-01, SEG-01 y PRIUS-01 en sus estados anteriores. Referencias normativas al antiguo gobierno se interpretan según la precedencia ya ratificada; esta revisión no cambia el metaprompt ni activa protocolos. El próximo paso documental está exclusivamente en §9 del núcleo.

## Conciliación C-METODOLOGIA-IMPLEMENTACION-06-r1

Historial anterior preservado; esta entrada precisa estado sin cambiar prioridades ratificadas.

- CUST-03/04: adjunto completo exacto y cotejo de 30 temas, con anclas literales y huella; se añaden eventos241,244,246,249 y salida final. Cobertura explícita, no captura automática futura.
- CONT-02/SAL-01: prompt universal ampliado de forma mínima con vía de transporte, revisión esperada, no repetición y recibo breve. Kit0.1.0 ejecutable empaqueta y valida el núcleo y produce lectura de arranque. Prueba de comprensión semántica continúa pendiente.
- CONT-01/BENCH-01/LAB-01: laboratorio de CLI con procesos nuevos, resultados por caso, hashes/versiones y ejecución Linux y Windows, más regresión Python histórica ejecutada nuevamente sin alterar la fuente. Los resultados solo cierran controles mecánicos, no continuidad semántica perfecta ni observación del navegador. Evidencia en pruebas/benchmark/ y kit/0.1.0.
- TRAZ-01: LISA v1.2 adquirido y copiado; trazabilidad documental implementada. Vector L0 requiere ratificación/firma, no equivale a embeddings. La matriz no simula L0 firmado ni distancia semántica calculada. Cadena formal hasta código y métrica semántica siguen pendientes.
- ARQ-01/PORT-01: paquete de transporte con lectura operativa derivada literal y archivos completos bajo demanda. Sin duplicar estado vivo ni borrar antecedentes. Separación física integral del metacanon todavía pendiente; no afirmar arranque mínimo perfecto.
- OBS-01: hub histórico Harmonia recuperado; contrato técnico actual no adquirido en este ciclo. Observador ChatGPT NO implementado ni instalado; identificación de «Cloud» no resuelta. Requiere contrato vigente y revisión explícita del alcance de datos/seguridad antes de construcción.
- DOC-01: snapshots puntuales de LISA y Harmonia en fuentes/, no sincronización perpetua.
- PLAT-01/GOB-02: espejo333 intacto; carga nativa330 antigua; correspondencia con fuente actual NO VERIFICADA, no se sobrescriben páginas ni personalización por deducción.
- SYNC-01, SEG-01 y PRIUS-01 mantienen sus estados previos. Repositorio privado no resuelve cifrado. Ningún protocolo PRIUS ni LISA se activa por consultar sus documentos.

Próximo hito de mayor valor: retoma ciega con otro modelo y evaluación contra los originales. No requiere construir antes toda la observabilidad. No hay plazo integral probado para pendientes externos.

## Seguimiento C-METODOLOGIA-VALIDACION-07-r1

- CONT-01/CONT-02/BENCH-01/OBS-01: observar el prompt en laboratorio Y retomas reales hasta perfeccionar su función. Protocolo0.3: fallo→fuente/versión→corrección→regresión→contraste real. No cerrar por PASS mecánico ni contar casos no observados como aprobados.
- Instrucción literal en conversaciones/C-METODOLOGIA-VALIDACION-07-dialogo.jsonl. En este ciclo no se ejecutan nuevas pruebas. La comprensión independiente y casos reales del prompt siguen pendientes de evidencia.
- No se instala observación automática ni se amplía captura. El siguiente hito es la retoma ciega independiente; registrar usos reales cuando ocurran con evidencia accesible. Seguridad/cifrado y Sesión PRIUS siguen diferidos.

## Entrega C-METODOLOGIA-CHATGPT-08-r1

- CHATGPT-01/PORT-01/CONT-02: salida urgente por agotamiento del acceso; entregaChatGPT0.1 para adquirir gobierno, método y estado desde archivos sin conector obligatorio. Empaquetado no equivale a funcionamiento probado en ChatGPT.
- REAL-CHATGPT-01 · Pendiente de observación: primera retoma con el archivo principal; conservar lectura efectiva, respuesta inicial, permisos, incertidumbres y próxima acción. No marcar PASS por autodeclaración del receptor. El evaluador coteja originales; no suministrar toda la historia por rutina para falsear la prueba ciega.
- LAB-01/BENCH-01: última explicación fue diseño, no instalación ni ensayo semántico. Conversación como fuente de casos, copias aisladas para ensayos, receptor independiente y contraste real. Sigue vigente protocolo0.3.
- CUST-03/04: se preservan pregunta y respuesta sobre laboratorio y nueva orden de migración. Sin escritura a GitHub, devolver delta completo NO GUARDADO y conservar la copia de trabajo offline; no fingir sincronía.
- Los demás pendientes y sus prioridades se conservan. Arquitectura por directorio ratificada; SeryMente es workspace general; frente es nombre corto del objeto de persistencia. Gobierno333 no se reescribe. Seguridad/cifrado y Sesión PRIUS permanecen diferidos.

## C-METODOLOGIA-ENDURECIMIENTO-09-r1

- Orden actual: endurecimiento general de emergencia para utilizar el marco como está previsto en otra plataforma. No es cambio de finalidad ni «modo de instrucciones vagas»; la interpretación inicial del modelo fue corregida por el operador.
- Destino reportado por el operador: ChatGPT gratuito actual; identidad técnica, cuotas y capacidad NO VERIFICADAS. No se compensa un fallo del receptor declarando cumplido lo que no hizo.
- PORT-01/CONT-02: entrega0.2 y control operativo§35 implementados documentalmente; verificador con versión real y gobierno completo; integridad/retoma mecánica sometidas a pruebas. La aceptación semántica sigue abierta.
- REAL-CHATGPT-01, ensayo independiente, observador, sincronización, formalización de intención y restantes ideas se conservan con sus estados previos. Seguridad/cifrado y Sesión PRIUS no se activan.

## C-METODOLOGIA-REVISION-INTEGRAL-10-r1

- Revisión de dieciséis categorías y su integración holística: cambios documentales1.10 y kit0.1.2; evidencias en revisiones y pruebas/revision-integral. Categorías no sustituyen molde13.
- Revisión/documentación y pruebas mecánicas separadas de estabilidad operativa: REAL-CHATGPT-01 y receptor independiente siguen abiertos. No cambiar su estado por publicar esta versión.
- Inventario de dependencias/permisos por acción y contrato de cierre incorporados; aligeramiento físico, sincronización, observador, intención formal y demás pendientes previos se conservan. Seguridad/cifrado y Sesión PRIUS diferidos sin activación.

- REFRESCO-01: autodetección por fuente/huella, contrato de adopción y etiqueta temporal incluidos en1.10. Comprobación obligatoria al ejecutar cada ciclo; adaptadores disponibles: GitHub MCP y helperCLI de solo lectura. Garantía universal, vigilancia entre turnos y ejecución forzada en plataformas sin herramientas NO ACREDITADAS. No cerrar ese límite por aprobar fixtures.

## RESPONSABILIDAD-01 · petición del ciclo10

Implementado: regla§38, registro exclusivo creado sin sobrescribir y leído de vuelta; biblioteca y ensayo de transiciones/carrera local. Pendiente: transferencia explícita al hilo destino cuando esté identificado y disponga de verificación; sin ella el receptor queda en lectura/propuestas. No implementado: mediador transaccional y restricción de todas las vías de escritura; requerirían revisión/decisión material. No afirmar protección universal ni usar vencimiento automático.

## C-METODOLOGIA-FUENTE-PRECEDENCIA-15-r1 · 2026-10-21

### Cerrado en este ciclo

- **Fuente preponderante:** Metacanon 1.16 §§43–45 e invariante 21, Sam v336 · NX-336m/P038, y `INICIO.md` establecen que `SeryMente/metodologia/main` es la fuente documental canónica; Notion, instrucciones personalizadas, memorias y copias son espejos subordinados.
- **GOW único:** GOW v1.9 en `gobernanza/GLOSARIO-WORKSPACE.md` conserva los grupos existentes y absorbió 49 bloques terminológicos del glosario raíz v1.3.1, consolidando duplicados y conservando el alcance de entradas RDC/CIBERCAFE/Vercel. El original quedó archivado verbatim; `GLOSARIO-OPERATIVO.md` ahora es un puntero de compatibilidad y el anexo terminológico es subordinado.
- **Sam:** P038 quedó inmediatamente después de P001; P008 dirige al GOW canónico y exige registrar cada convenio ratificado en el mismo ciclo. Sam y GOW fueron escritos en sus páginas espejo de Notion desde `main` y verificados por lectura de vuelta.
- **BCR:** `BOOTSTRAP-CONTEXTO-GLOBAL.md` actualizado para adquirir Sam/Metacanon/GOW desde `main`, revisar el GOW al inicio y al cierre de cada ciclo, aplicar normalización contextual, verificar responsabilidad y persistir evidencia.

### Sigue pendiente y no debe marcarse como hecho

- **SYNC-01 · Sincronización perpetua:** sigue pendiente el mecanismo automático que propagará cada cambio entre plataforma y repositorio. Las escrituras y lecturas de vuelta de este ciclo fueron puntuales.
- **PLAT-01 / personalización nativa:** no se modificaron directamente los ajustes de instrucciones personalizadas de ChatGPT. Este ciclo entrega el texto BCR listo para copiar; sigue pendiente que el operador lo pegue/adopte en los ajustes nativos. No declarar que ya está instalado ni que otros modelos lo obedecen.
- **REAL-CHATGPT-01 / receptor independiente:** permanece pendiente una prueba semántica independiente con otro hilo/modelo, incluida la lectura del estado y la aplicación real de la jerarquía.
- **Seguridad/cifrado y Sesión PRIUS:** continúan diferidos, sin activación por esta actualización.

La revisión por ciclo del GOW sí es obligatoria ahora; no depende del cierre de ninguno de los pendientes anteriores.



## C-METODOLOGIA-REINSTANCIACION-16-r1 · 2026-10-21

### Cerrado y leído de vuelta en main

- Metacanon 1.17 / METACANON-OBJETOS-v1.17: §§46–47 definen OCP como carpeta por FT, folio SES, adjudicación exclusiva por control de responsabilidad y recuperación literal de la última salida visible preservada; §4 define salida obligatoria por ciclo.
- Sam v337 · NX-337m: P039 y P008 actualizados; P008 exige lectura del GOW al inicio y cierre de cada ciclo. Sam se sincronizó a Notion y se leyó de vuelta con firma y pie de 39 principios.
- GOW v2.0: términos FT/FDT, OCP, folio SES e IPZ añadidos; la referencia activa a Metacanon v1.17 se corrigió en main y luego se volvió a escribir y leer de vuelta la página Notion v2.0 (última lectura observada 2026-10-21T21:01:51.961Z). El recibo JSON de GOW conserva una marca de lectura anterior y queda pendiente de refresco.
- BCR: se añadieron enlaces directos a Sam (cascada), Metacanon §4 y GOW, además del flujo FT/OCP/SES y MCP normativo desactivado; blob `26c69035250e857641aea341fb4468a8617c6a07`.
- Control de Metodología: folio operativo `SES-20261021-C4D81A7F` guardado/read-back con generación 2. Búsqueda de colisión limitada al repo accesible; unicidad en toda la organización no verificada.
- IPZ: texto final de 1432 caracteres guardado en `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` y en `/mnt/data/IPZ-CAMPO-CHATGPT.txt`; listo para copiar. Ajuste nativo de ChatGPT aún requiere pegado explícito y posterior comprobación.

### Pendiente de cierre y no declarar completado

- **Cerrado:** §9 de Metacanon se actualizó y leyó de vuelta para reflejar el BCR guardado y el estado pendiente de IPZ nativo.
- **Cerrado:** recibos fuente de Sam v337/GOW v2.0 actualizados a los últimos blobs de main.
- **Cerrado:** página espejo del GOW v2.0 actualizada desde el cuerpo vigente de main y leída de vuelta; se verificaron FT/FDT, OCP, folio SES, IPZ, revisión obligatoria por ciclo y los enlaces al GOW, Metacanon §4 y la cascada de Sam.
- Pegar el IPZ en configuración de ChatGPT y confirmar su contenido real.
- Prueba semántica con otro modelo/hilo y sincronización perpetua: pendientes; el MCP normativo permanece desactivado.

## C-METODOLOGIA-OCP-DISCOVERY-17-r1 · 2026-10-21

### Cerrado y verificado en main

- Metacanon **v1.18 · METACANON-OBJETOS-v1.18**: §48 exige buscar FT por nombre y descubrir OCP a partir de núcleo/README/control en repositorios accesibles. `frentes/<slug>/` es la convención para OCP nuevos; `docs/frentes/<slug>/` y cualquier ruta canónica histórica declarada se conservan sin migración implícita.
- Sam **v338 · NX-338m**: P039 alineado con descubrimiento de OCP; P040 exige registrar el alcance accesible y conservar rutas heredadas. Firma de carga y pie de 40 principios leídos de vuelta.
- GOW **v2.1**: la definición OCP enlaza Metacanon 1.18 y permite rutas heredadas; los términos FT/FDT, SES e IPZ y los tres enlaces directos se verificaron en main y en Notion. Notion se releyó con título v2.1.
- BCR, `INICIO.md`, README de gobernanza, puntero del glosario y anexo terminológico actualizados; todos fueron releídos de vuelta.
- IPZ de compatibilidad: `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt`, **1.451 caracteres**, revisado y leído de vuelta. También escrito en `/mnt/data/IPZ-CAMPO-CHATGPT.txt`.
- Folio de Metodología: `SES-20261021-C4D81A7F`, generación 2, sigue activo. Se comparó contra los cuatro controles de responsabilidad accesibles en tres repositorios; no se encontró duplicado. Harmonia en `SeryMente/khora/docs/frentes/harmonia/` conserva su titular anterior y no fue transferido porque el nombre se usó como ejemplo.

### Sigue pendiente y no debe marcarse completado

- El operador confirmó que el campo nativo IPZ se actualizó con la versión anterior. Como la revisión actual agrega compatibilidad con OCP heredados, debe reemplazarse el contenido por la versión final de 1.451 caracteres y verificarse después del guardado. Esta conexión no expone el campo nativo para escribirlo o releerlo directamente.
- La herramienta expone nueve repositorios bajo el propietario `SeryMente`, pero no devolvió una lista de membresías de organización. La unicidad del folio queda comprobada solo en los cuatro controles leídos; no se afirma unicidad global fuera del alcance accesible.
- Verificación normativa automática por MCP: DESACTIVADA por instrucción expresa. No se ejecutó.
- No hay sincronización perpetua GitHub↔Notion; las propagaciones del ciclo son puntuales y verificadas.
- Prueba semántica en un modelo/hilo independiente pendiente. No se afirma cumplimiento universal por todos los modelos.

## C-METODOLOGIA-AUDITORIA-REQUISITOS-20 · Checklist literal de cumplimiento — auditoría 2026-10-21

**Leyenda:** `VERIFICADO` = existe norma y evidencia de lectura; `PARCIAL` = norma escrita, pero falta prueba o acceso; `PENDIENTE` = depende de una acción externa no verificada.

| ID | Criterio derivado del mandato verbatim | Estado | Evidencia / brecha |
|---|---|---|---|
| R01 | Nueva conversación o conversación refrescada dispara la retoma del FT por nombre | **PARTIAL** | El contenido nativo de IPZ no puede leerse desde estas herramientas; el operador confirmó una versión previa, no la última copia canónica. |
| R02 | SeryMente/metodologia/main prevalece sobre Notion y otras copias | **VERIFIED** | Sam P038; Metacanon §§43-45; INICIO.md |
| R03 | Buscar repositorio correcto y FT por denominación canónica; un repo puede tener FT ilimitados | **PARTIAL** | La conexión expone nueve repositorios del propietario SeryMente, no una lista completa de miembros/repositorios de la organización. La norma limita las afirmaciones al alcance accesible. |
| R04 | GOW define FT/FDT como equivalentes; define OCP e IPZ | **VERIFIED** | GOW v2.2 en main y lectura de vuelta de Notion |
| R05 | IPZ incluye enlace directo al GOW y consulta obligatoria cada ciclo, expresada también en Sam | **VERIFIED_DOCUMENTALLY** | La instalación exacta del IPZ vigente en el campo nativo no es legible por estas herramientas. |
| R06 | OCP como carpeta canónica que contiene necesidades de persistencia de un FT | **VERIFIED** | Metacanon §§46-48; GOW v2.2; rutas heredadas verificadas en Harmonia |
| R07 | Folio por sesión y adjudicación exclusiva del folio al FT; una sesión activa por FT | **PARTIAL** | La regla se documentó y el frente Metodología tiene folio activo, pero no se ejecutó una retoma nueva de un FT distinto como prueba E2E. No hay bloqueo server-side universal. |
| R08 | Adoptar contexto usando los recursos reales del OCP | **PARTIAL** | No se hizo una reinstanciación completa de extremo a extremo de un FT distinto durante esta auditoría. |
| R09 | Recuperar literalmente la última salida persistida del modelo en el primer ciclo | **PARTIAL** | El requisito está normado, pero no se ejecutó una retoma externa con una salida previa verificada que pudiera servir como prueba real. |
| R10 | Adoptar el marco de Metacanon, con evidencia inicial de versión Sam y folio | **PARTIAL** | Esta respuesta presenta la evidencia, pero mensajes previos de esta misma sesión no siempre usaron la salida completa de §4. |
| R11 | Formato de salida §4 obligatorio en cada ciclo | **PARTIAL_HISTORICAL** | El formato está normado; no todas las respuestas anteriores de esta misma sesión cumplieron el esquema completo de diez campos. Esta auditoría sí se estructura conforme a esos diez campos. |
| R12 | IPZ enlaza directamente a Metacanon §4 y a la cascada jerárquica de Sam | **VERIFIED_DOCUMENTALLY** | La coincidencia del campo nativo con el artefacto actual queda pendiente de lectura/confirmación. |
| R13 | MCP normativo desactivado y no afirmar que se utilizó | **VERIFIED** | IPZ; BCR; Metacanon; revisión manual |
| R14 | Entregar IPZ actualizado y dentro del límite de la plataforma | **PARTIAL** | El usuario confirmó antes una revisión de 1432 caracteres. Debe reemplazarse por la versión actual de 1451 y confirmarse guardado. |
| R15 | Funcionamiento fiable al usar otros modelos/plataformas y acceso completo a toda la organización | **PARTIAL_NOT_TESTED** | No se ha realizado prueba semántica en otro modelo/plataforma; las instrucciones no crean permisos ni garantizan inventario global o cerrojo server-side. |

### Conclusión de auditoría

- **Cumplido documentalmente:** precedencia de `main`; definiciones FT/FDT, OCP e IPZ; OCP-folder; enlaces normativos; regla GOW por ciclo y cascada manual de Sam; estado MCP desactivado.
- **Parcial en operación:** búsqueda organizacional completa, adjudicación exclusiva universal, adopción de todo el contexto del OCP y recuperación de la última salida en un primer ciclo real, cumplimiento §4 de todos los mensajes previos, y campo IPZ nativo.
- **Acción operativa pendiente:** sustituir la versión previamente reportada como instalada por la IPZ canónica vigente de **1.451 caracteres** y confirmar guardado. El campo nativo no se puede leer directamente desde esta conexión.

El recuento de caracteres del IPZ aplica al campo que se va a pegar, sin incluir el salto de línea final del archivo. OpenAI indica un límite de 1.500 caracteres para Free/Go y que las instrucciones guardadas se aplican inmediatamente a todos los chats. Referencia oficial: https://help.openai.com/en/articles/8096356-chatgpt-custom-instructions

## C-METODOLOGIA-MIGRACION-HILO-FRESCO-21 · Migración a hilo fresco

- **Estado:** paquete de relevo preparado y registrado en `CONTROL-RESPONSABILIDAD.json` (`handoff_preparation.status=prepared_waiting_for_target_claim`; control blob `3125ea6a222d531f479292b69bd68c34b82f1ee7`). El propietario/folio de origen siguen en generación 2; la transferencia al destino NO está completada hasta el CAS + read-back del hilo fresco.
- **Autorización:** el operador ordenó explícitamente «Actualiza OCP para migrar instancia a hilo fresco y dame el prompt que necesito para reinstanciar». Alcance: una transferencia de Metodología/Metacanon al próximo hilo que use el prompt de este evento; no otros frentes.
- **Origen:** propietario operativo `operator-authorized-transfer:C-METODOLOGIA-COLISION-RESPONSABILIDAD-14`; instancia `chatgpt-metacanon-collision-remediation-2026-10-21`; generación 2; folio `SES-20261021-C4D81A7F`. La identidad es un alias operativo, no ID nativo.
- **Destino:** aún no existe en esta plataforma de control. Debe generar un folio `SES-AAAAMMDD-XXXXXXXX`, comprobar colisiones dentro del alcance accesible, crear alias operativo, transferir por compare-and-swap usando SHA actual y generación observada y validar por lectura de vuelta.
- **Prompt vigente:** `frentes/metacanon/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt`.
- **Checkpoint:** `frentes/metacanon/entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md`.
- **Última salida persistida que el destino debe reproducir literalmente:** `frentes/metacanon/entregas/CHATGPT-v0.3/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md`.
- **Reglas de seguridad del relevo:** no liberar ni reemplazar al titular por iniciar un chat; no declarar transferencia antes del read-back; si cambia el control o falla la escritura, detenerse sin reintentos ciegos; no reutilizar el folio de origen como folio destino.
- **Pendientes de fondo:** IPZ nativo no verificable desde estos conectores; prueba E2E de retoma en hilo nuevo por ejecutar; MCP normativo sigue desactivado; no se afirma inventario global de la organización.



## Checklist basado en verbatim · corte 2026-10-21

Checklist único de consulta rápida para los nueve requisitos literales: [CHECKLIST-VERBATIM-21.md](entregas/CHATGPT-v0.3/CHECKLIST-VERBATIM-21.md). Sustituye como vista operativa actual al cuadro R01–R15 histórico de C-METODOLOGIA-AUDITORIA-REQUISITOS-20; conserva ese cuadro y el evento de migración anteriores como historia, sin reescribirlos.

Estado E2E de este corte: ocho aspectos comprobados en los artefactos/operación de la sesión; el único bloqueo directamente pendiente del verbatim es confirmar en el campo nativo de ChatGPT que el IPZ de 1.451 caracteres esté instalado exactamente. Este conector no permite leer ni escribir ese campo. La cobertura global de repositorios tampoco se afirma más allá de los nueve visibles.


## C-METODOLOGIA-VERBATIM-E2E-22 · estado E2E de cierre · 2026-10-21

**Regla de cobertura:** solo los nueve literales persistidos en `conversaciones/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-dialogo.jsonl` determinan los criterios funcionales. La versión operativa de consulta rápida es [CHECKLIST-VERBATIM-21.md](entregas/CHATGPT-v0.3/CHECKLIST-VERBATIM-21.md); no ampliar el alcance por asociación. El checklist histórico R01–R15 de Auditoría-20 y el relevo preparado quedan como antecedentes, con estados ya supersedidos por el control/read-back M21 y las pruebas M22.

- **Artefactos del OCP para retoma:** [README.md](README.md) (entrada, no segundo estado vivo); [prompt de continuidad reutilizable](entregas/CHATGPT-v0.3/PROMPT-CONTINUIDAD-METODOLOGIA-VERBATIM-E2E-22.txt); [prompt M21 de un solo uso](entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt), marcado consumido; [checkpoint M21](entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md), preparación histórica marcada y no instrucciones vigentes.
- **E2E de artefactos:** [C-METODOLOGIA-VERBATIM-E2E-22.cjs](pruebas/continuidad/C-METODOLOGIA-VERBATIM-E2E-22.cjs), 15 comprobaciones sobre los nueve requisitos y rutas de OCP. Primer corte ejecutado en Windows/Node.js con PASS 15/15 en commit `90730be9eaeb6ceaa5f98ea1090444b36519ef24`. El [informe de evidencia M22](evidencias/C-METODOLOGIA-VERBATIM-E2E-22.json) registra el último corte ejecutado, sus fuentes y hashes; ese informe, no este primer PASS, determina el resultado final del cierre.
- **Regresiones mecánicas reejecutadas en Windows:** continuidad `kit/0.1.0/ensayo-historico.py`, última versión 33/33, repetibilidad true; responsabilidad `kit/0.1.2/ensayo-responsabilidad.cjs`, 18/18; refresco `kit/0.1.2/ensayo-refresco.cjs`, 24/24. No equivalen a comprensión semántica independiente, acceso real al campo de ajustes nativo ni bloqueo server-side.
- **Defectos corregidos por la regresión:** (1) O18 de responsabilidad dependía de Bash y fallaba en Windows; se migró a procesos Node concurrentes con creación exclusiva local, luego pasó 18/18. (2) Los fixtures de continuidad calculaban hashes como UTF-8 pero usaban codificación predeterminada de Windows; se fijó UTF-8/LF explícitos y la versión 2 pasó 33/33. Se conservaron las primeras corridas fallidas como evidencia histórica; no se borraron.
- **Fallas de preparación conservadas:** (1) el primer sparse-checkout mezcló ruta de archivo y directorio; se repitió con patrones válidos de directorio. (2) la primera E2E se bloqueó porque no estaba materializado `frentes/acceso/CONTROL-RESPONSABILIDAD.json`; se amplió el checkout. (3) la segunda E2E dio 12/15 por comparación de mayúsculas y dos expectativas textuales desalineadas con el estado real; las aserciones se corrigieron sin debilitar los criterios y el prompt se hizo explícito sobre el prompt M21 consumido. El primer corte posterior pasó 15/15.
- **Estado de responsabilidad:** sigue generación 3, folio `SES-20261021-6B9E2F41`; CAS/read-back de la transferencia M21 y Metacanon §9 están verificados. El folio no debe reutilizarse. El alcance de búsqueda comprobable es nueve repositorios accesibles; no afirmar unicidad global.
- **Único bloqueo directo del verbatim no resoluble con los conectores actuales:** verificar que el campo nativo de Instrucciones Personalizadas de ChatGPT (IPZ) contiene exactamente el archivo canónico. El archivo `entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` tiene 1.451 caracteres y los tres enlaces directos; el campo nativo no tiene herramienta autorizada de lectura/escritura en esta sesión. No declarar instalación por inferencia. Revisión final de herramientas y alternativas queda registrada en la evidencia M22.
- **Pruebas no equivalentes que siguen abiertas:** aceptación semántica de otro modelo/hilo; cobertura total de organización; exclusión técnica de escritores arbitrarios; lectura/escritura directa de ajustes nativos. Ninguna se marca PASS por el mero éxito mecánico.
- **Persistencia de este cierre:** [evidencia M22](evidencias/C-METODOLOGIA-VERBATIM-E2E-22.json), [diálogo visible M22](conversaciones/C-METODOLOGIA-VERBATIM-E2E-22-dialogo.jsonl), [crónica M22](cronica/C-METODOLOGIA-VERBATIM-E2E-22.md) y [salida final M22](entregas/CHATGPT-v0.3/C-METODOLOGIA-VERBATIM-E2E-22-salida-final.md). No afirmar guardado hasta comprobar read-back de cada archivo.

## C-METODOLOGIA-AUDITORIA-REPOSITORIO-24 · limpieza y riesgos pendientes

**Estado del ciclo:** limpieza estructural aplicada y leída de vuelta; no equivale a auditoría semántica línea por línea de los 300 archivos del repositorio.

- **REPO-01 · Abierto, segunda pasada semántica:** el inventario total de `main` no se truncó. La raíz conserva 30 archivos y seis directorios de primer nivel; 39 enlaces internos del README raíz resuelven. Los documentos de principios y los recibos de versión retirados de la raíz se conservaron bajo rutas históricas en lugar de borrarse. Revisar el contenido por carpeta solo cuando una dependencia o contradicción observable lo justifique.
- **SCHEMA-01 · Material, pendiente antes de modificar el contrato:** `FORMATO-REGISTRO-VERIFICACION-CICLO.md` y `FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json` v1.7.7 conservan `SI CARGADO` y `H1 → SI@H1`. El consumidor real está verificado: en `SeryMente/khora/main`, `khora-web/lib/server/norm-check.ts` (blob `8d8293b0d140ab3b7b6f7e18c4db7e54d3daf4c4`) declara `CANONICAL_SI_PATH = "SI-METACOGNITIVO.md"` y extrae versión/nombre; `khora-web/tests/unit/methodology_contract_sync.test.ts` (blob `599746d007580840909e5a1a561a9d62ce27de0b`) exige igualdad exacta con `khora-web/contracts/FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json` v1.7.7 (blob `232590a1f6339e2517e67038e1b5f7e8bd1638e3`), idéntico al esquema canónico de Metodología. No migrar esos campos ni quitar el SI raíz hasta implementar y probar una migración coordinada en KHORA.
- **CI-01 · Pausado por instrucción expresa del operador:** los fallos históricos de `validate-canonical-bootstrap` y `Validate RDC Governance` permanecen con causa `NO VERIFICADA`. No consultar, sondear ni ejecutar GitHub Actions/workflows hasta nueva autorización; no usarlos como criterio de aceptación ni convertir los estados históricos en PASS.
- **EP-SCRIPTS-01 · Avance parcial M26; invocadores externos no cerrados:** la lectura directa de `scripts/bootstrap-entorno-persistente.ps1` encontró alcance mixto EP/CIBERCAFE: parámetros `-ObserverOnly`, `-WorkRoot`, `-TerminalId`; escritura de estado `CIBERCAFE/<PC-N>`; autocopia desde `$PSCommandPath` a `<WorkRoot>\scripts\bootstrap-entorno-persistente.ps1`; descarga del CLI CIBERCAFE fijado por commit `14756d289f1ddc4c74c6736f5aa021121158541c` y SHA-256 verificado antes de ejecutarlo con `-PrepareOnly`. `scripts/bootstrap-entorno-persistente-ep.ps1` es una variante distinta restringida al perfil elevado Fila4 y a un `WorkRoot` dentro de ese perfil (por defecto `Desktop\EP`). `CIBERCAFE/PC-4/ESTADO.md` declara canónico `scripts/bootstrap-cibercafe-cli.ps1`; el CLI comprueba la ruta exacta `scripts\bootstrap-cibercafe-cli.ps1` dentro de `Desktop\metodologia`. La búsqueda de código conectada no devolvió coincidencias, pero su cobertura/indexación no está demostrada: cero resultados no acredita ausencia de otros consumidores. No mover ni consolidar ninguno; identificar los invocadores restantes antes de resolver propietario o adaptador.
- **DUPLICADOS-01 · Conservados con causa:** `frentes/metacanon/kit/0.1.1/ARRANQUE-PROMPT.txt` y `frentes/metacanon/entregas/CHATGPT-v0.2/PROMPT-ENTRADA.txt` comparten contenido como piezas de paquetes distintos. `pruebas/benchmark/C-METODOLOGIA-IMPLEMENTACION-06-regresion-python.json` y `pruebas/continuidad/resultado.json` son idénticos, pero el segundo es la ruta de resultado que usa el ensayo; ambos se conservaron hasta una reconciliación de consumidores.
- **SAM-ATOM-01 · Continúa pendiente:** auditoría de atomicidad, redundancia y longitud de los 40 principios de Sam, sin editar Sam ni modificar sus pesos sin autorización expresa.

- **SI-KHORA-01 · Dependencia externa confirmada:** `SI-METACOGNITIVO.md` permanece completo en la raíz, bajo su banner `GOBIERNO GENERAL SUPERSEDIDO`, únicamente por compatibilidad. Su ruta de archivo es un puntero. El retiro definitivo requiere migrar KHORA desde `CANONICAL_SI_PATH` hacia una identidad de Sam verificable y probar el contrato/runtime; KHORA no se modifica en esta limpieza.

## Actualización C-METACANON-ARRANQUE-360-01 · 2026-10-29

- **Titularidad:** transferencia del frente Metacanon a la conversación receptora verificada por lectura de vuelta; generación 6, folio `SES-20261029-7F4A9C21`, evento `C-METACANON-ARRANQUE-360-01`. El alias es operativo y no un ID nativo. Control posterior SHA `86f0e4fa59e37976704231290b460cf6dc9252b0`; commit del control `4cb58ba1927d858d2c3cffd5f8376c15fee402c4`.
- **Prompt universal:** el enlace de `INICIO.md` apuntaba a un archivo que no existía en la revisión consultada; el prompt fue creado en la raíz y leído de vuelta, blob `7ef052146416add46260cf9d51eaa34c2fa83caa`.
- **Bootstrap:** referencias a los antiguos archivos Markdown de Sam/Metacanon/GOW se reconciliaron para apuntar al DUG integrado y se añadió la puerta de arranque común con ART-024. Blob `d5e7bca9225fb040d73ebbeca52e36c8637d3afd`.
- **IPZ candidata:** contenido actualizado desde el DUG v360 · NX-360m, con ART-024, la comprobación de responsabilidad y el prompt universal; 1.365 caracteres y lectura de vuelta, blob `7400b5109987bcf81301861b666715bf53636468`. La configuración nativa de ChatGPT no es accesible a estas herramientas: instalación/lectura de vuelta **PENDIENTE**.
- **Prueba de arranque:** revisión mecánica de los archivos en curso; no equivale a prueba semántica en una conversación nueva. CONT-01 y CONT-02 no se cierran integralmente hasta dicha prueba. Sin afirmar sincronización automática ni recepción por otros hilos.
- **AT:** su estado normativo no se modifica por esta transferencia; no se presenta como ratificado por esta ejecución.

## Actualización C-METACANON-AUTOARRANQUE-FT-01 · 2026-10-29

- **CONT-02 · Implementado documentalmente, instalación nativa pendiente:** IPZ v0.4 de 1.266 caracteres creada; el prompt universal y el BCR ahora definen un disparador automático sin prompt repetido ni checklist visible como preámbulo. INICIO y el puntero de continuidad enlazan la nueva versión.
- **Escenarios de cobertura:** matriz práctica de 16 escenarios; chats normales personalizados tienen cobertura prevista, pero Proyectos con instrucciones propias, GPT personalizados, chats temporales sin personalización y plataformas/API externas requieren configuración específica o quedan fuera del alcance nativo. La fuente inaccesible y los conflictos de titularidad fallan de forma segura.
- **No cerrado por documentación:** el campo nativo de ChatGPT todavía no está instalado/verificado desde las herramientas disponibles; falta una prueba semántica con un hilo realmente nuevo que empiece con una petición corriente sin repetir el procedimiento. No declarar arranque global aceptado antes de esa evidencia.
- **AT:** sin cambio de estado normativo en este ciclo.
- Artefactos: `entregas/CHATGPT-v0.4/C-METACANON-AUTOARRANQUE-FT-01-salida-final.md`, `entregas/CHATGPT-v0.4/MATRIZ-ESCENARIOS-INICIO-FT-v0.1.md` y la evidencia del ciclo.
