# Ideas pendientes · frente de metodología

Registro de trabajo, no sustituto del estado canónico ni de las conversaciones originales. Las decisiones aquí recogidas no se presentan como implementaciones. La prioridad sigue urgencia e impacto; no se altera una prioridad acordada sin indicación del operador.

## Mandato vigente

Primero lo urgente y después la mejora continua. Conservar las notas de lo que dice el operador y poder mostrar las ideas pendientes cuando lo solicite. No declarar conservación íntegra si falta verificar la cobertura de los originales.

## Urgente

- **CONT-01 · Parcial, banco mecánico verificado y prueba semántica pendiente:** ensayar en un entorno virtual la continuidad de contexto entre conversaciones; iterar sobre los fallos observados. Distinguir pruebas de archivos y recuperación de estado de pruebas semánticas con modelos independientes. No prometer perfección universal.
- **CONT-02 · Disparador preparado, validación semántica pendiente:** consolidar un prompt universal de reinstanciación que recupere el frente desde la revisión persistida, sin depender de la memoria del chat anterior. Debe cubrir cortes imprevistos y conversaciones limitadas, no solo traspasos planificados.
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
- GOW v2.0: términos FT/FDT, OCP, folio SES e IPZ añadidos; corrección de la referencia activa a Metacanon v1.17 guardada en main. El espejo Notion v2.0 se verificó antes de esta corrección puntual; la última modificación todavía no tiene lectura de vuelta.
- BCR: sección nueva de retoma FT/OCP/SES añadida y leída de vuelta; blob `82c4c2c03bcdde5c63a8766f8fe2a40bc4be0f0a`.
- Control de Metodología: folio operativo `SES-20261021-C4D81A7F` guardado/read-back con generación 2. Búsqueda de colisión limitada al repo accesible; unicidad en toda la organización no verificada.
- IPZ: texto de 1208 caracteres preparado en `/mnt/data/IPZ-CAMPO-CHATGPT.txt`. Ajuste nativo de ChatGPT aún requiere pegado explícito y posterior comprobación.

### Pendiente de cierre y no declarar completado

- **Cerrado:** §9 de Metacanon se actualizó y leyó de vuelta para reflejar el BCR guardado y el estado pendiente de IPZ nativo.
- **Cerrado:** recibos fuente de Sam v337/GOW v2.0 actualizados a los últimos blobs de main.
- Propagar la última corrección textual del GOW al espejo Notion y releerla; en este momento el main prevalece.
- Pegar el IPZ en configuración de ChatGPT y confirmar su contenido real.
- Prueba semántica con otro modelo/hilo y sincronización perpetua: pendientes; el MCP normativo permanece desactivado.

