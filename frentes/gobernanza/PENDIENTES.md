## Intervención OCPMSP — C-GOBERNANZA-OCPMSP-DECISIONES-01 — 2026-10-31

**Decisiones de diseño aprobadas; implementación bloqueada por titularidad.** OCPMSP se define como motor del OCP existente MCP-METODOLOGIA, no como OCP separado. El control MCP sigue owned, generación 1, con titular distinto y alcance documental. No se ha transferido ni ampliado. Antes de autorizar especificación ejecutable, código, instalación, credenciales y pruebas, se requiere transferencia explícita, nueva generación, ampliación de alcance, compare-and-swap por SHA y read-back.

Se aprueba para diseño el aislamiento cifrado de la segunda capa dentro del DUG canónico; clave local DPAPI fuera de Git/contexto del modelo; metadatos de aplicabilidad explícitos aprobados por Gobernanza; CNP incondicional; 43 clasificaciones; dependencias cerradas con fail-closed; aliases Sink por intento; receptor HTTPS separado y polling degradado; comprobante Ed25519 con cobertura Sink separada; y BLOCKED_OCPMSP sin bypass.

**Pendientes:** transferencia del control MCP; especificación detallada posterior; alineación futura de ART-027; coordinación formal con EP; definición y pruebas del transporte/identidad/ACL/DPAPI/health/backups. No modificar DUG, ART-027, ART-025, IPZ, controles MCP/EP ni recursos externos hasta autorizaciones específicas. MCP-NORMATIVO permanece DESACTIVADO.

Registro: [resolución](entregas/CHATGPT-v0.9/C-GOBERNANZA-OCPMSP-DECISIONES-01-salida-final.md) · [crónica](cronica/C-GOBERNANZA-OCPMSP-DECISIONES-01.md) · [evidencia](evidencias/C-GOBERNANZA-OCPMSP-DECISIONES-01.json).

# Pendientes · Frente Gobernanza

## Estado operativo vigente · lectura de continuidad (2026-10-30)

**Fuente canónica:** DUG v373 · NX-373m; blob `cac4525de77d4f47a8a59c25201968ecf2056b90`. ART-027 contiene la arquitectura de dos capas: 43 MDP para reconocer pertinencia y consulta obligatoria de la norma desarrollada mediante Sink antes de aplicarla. La telemetría aprobada sigue limitada a frecuencia de acceso por alias.

**Auditoría estructural MDP:** 43/43 IDs únicos; 43 MDP humanos y 43 estructurados con coincidencia literal; todos dentro del rango de 11–16 palabras. La validación semántica mediante casos de entrada permanece abierta (GOV-TASK-001).

**Responsabilidad del frente:** generación 7, titular `chatgpt-C-GOBERNANZA-RETOMA-06-SES-20261030-GVC9594230`; control leído de vuelta, blob `c41c3cddc866de999827fc6ae36c23dde400344f`. Las ocho tareas provisionales heredan este control y no poseen sesiones ni folios independientes.

**Estado de tareas:** GOV-TASK-001, GOV-TASK-006, GOV-TASK-007 y GOV-TASK-008 en curso; GOV-TASK-002, 003, 004 y 005 pendientes.

**Pendientes ejecutivos y dependencias:**
- GOV-TASK-008: definir y ejecutar el aislamiento MDP-only y la recuperación individual; el DUG todavía expone los 43 textos desarrollados en `gov-data`.
- GOV-TASK-002/003: Sink, Worker, 43 aliases y prueba privada E2E siguen sin desplegar. Wrangler no está instalado en PC-14 y no hay conector Cloudflare disponible; tampoco se encontró una operación de fork en el conector GitHub. Se requiere acceso autorizado a Cloudflare y una vía aprobada para fork/despliegue; secretos solo en almacenamiento protegido, nunca en Git.
- GOV-TASK-004: `ambitos/tareas/` conserva control leído de vuelta, estado `owned`, titular `chatgpt-C-TAREAS-INICIO-01-SES-20261028-TA6F31C9`, generación 1, blob `b0c19b0c2ce7db13a74243b03183756519f7cfe0`. No modificar ni transferir desde Gobernanza.
- GOV-TASK-005: referencias incompletas P020/P021/P033/P034; preservar los vacíos hasta hallar procedencia y obtener autorización P005 antes de cambiar principios.
- GOV-TASK-006: DUG estructurado declara GOW 2.14/127 términos; banner humano v2.12. Solo 115 nombres estructurados aparecen literalmente en el texto humano; 12 entradas están ausentes. El JSON auxiliar describe v2.11 y es derivado. INICIO.md, bajo Metacanon gen6, conserva la telemetría antigua de ART-027 y el conteo FOL1 25/22/3 frente al maestro 26/23/3. Gobernanza no modifica el DUG/GOW sin decisión P005 ni el INICIO.md ajeno.
- GOV-TASK-007: v0.7 (2.467 caracteres) cotejada con v0.8 (1.488); v0.8 no conserva todos los estados ni el detalle de eficiencia. Borrador v0.9 de 1.478 caracteres preparado solo en conversación. IPZ nativa sin modificación/verificación; FOL1, generación 3, 26 OCP conocidos, cero asignaciones y contadores en cero. No activar ni escribir el campo nativo sin las compuertas y autorización correspondientes.

**Límites confirmados:** Sink no desplegado; cero aliases activos y cero telemetría real. No se ha aplicado cambio normativo al DUG/GOW, ART-025, IPZ ni `ambitos/tareas/` en esta reconciliación.

Registro funcional de origen: [C-GOBERNANZA-MDP-OCP-01 · crónica](cronica/C-GOBERNANZA-MDP-OCP-01.md) · [evidencia](evidencias/C-GOBERNANZA-MDP-OCP-01.json) · [DUG v373 · ART-027](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027) · [ocho tareas provisionales](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/README.md)

---


## Estado histórico · C-GOBERNANZA-MDP-OCP-01 · 2026-10-30

**Persistido y releído:** DUG v371 · NX-371m; 43 principios, 20 anexos; ART-027 contiene 43 MDP de 11–16 palabras. El MDP orienta significado y activación, pero es insuficiente para aplicar el principio. Cuando exista pertinencia, la consulta de la norma desarrollada por Sink es obligatoria. La telemetría inicial mide solo frecuencia de acceso por alias; no existe medición de aplicación ni registro `principle_usage` por ciclo.

**OCP provisionales:** [registro de siete tareas](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/README.md), cada una con núcleo propio y responsabilidad heredada del OCP Gobernanza. No se ha creado ni canonizado el ámbito funcional Tareas.

**Pendientes ejecutivos:** validar los MDP; desplegar Sink y crear aliases p001–p043; probar la consulta privada Sink→GitHub; concluir la incubación de Tareas; resolver las referencias incompletas P020/P021/P033/P034 con autorización P005; reconciliar divergencias documentales de Gobernanza; y reconciliar IPZ/FOL1.

**Límites:** Sink y Cloudflare no desplegados; cero aliases activos y cero telemetría real. `ambitos/tareas/` sigue en incubación bajo titularidad distinta (chatgpt-C-TAREAS-INICIO-01-SES-20261028-TA6F31C9, generación 1); no se modificó ni transfirió. FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`. ART-025 y la IPZ nativa/candidata permanecen intactos.

Registro: [crónica](C-GOBERNANZA-MDP-OCP-01.md) · [evidencia](evidencias/C-GOBERNANZA-MDP-OCP-01.json) · [DUG v371 · ART-027](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027).


## Estado histórico supersedido · C-GOBERNANZA-PRINCIPIOS-DOS-CAPAS-01 · 2026-10-30

**Persistido y releído:** DUG v370 · NX-370m; 43 principios, 20 anexos; ART-027 creado. El inventario de dos capas contiene 43 IDs/nombres/abstracciones y 43 aliases Sink previstos (p001–p043).

**No desplegado:** no existen todavía una instancia Sink verificada ni 43 enlaces activos. Pendientes: fork de Sink; Cloudflare Worker con D1/DB, KV/KV y Analytics Engine/ANALYTICS; variables de despliegue; secretos protegidos; API REST y creación idempotente de aliases; resolución privada autenticada de principios; extensión real de registros de ciclo ART-024; agregador de aplicaciones; pruebas E2E y negativas.

**Bloqueos de acceso:** esta sesión no dispone de conector/cuenta Cloudflare ni de credenciales; el conector GitHub actual no ofrece create_fork. La ruta prevista conserva el DUG privado: el redirect público Sink apunta a GitHub privado y el modelo recupera el texto con el conector GitHub autenticado. Esa secuencia E2E aún no se ha probado; si no permite extraer el fragmento Pxxx o leer la fuente, evaluar REST Sink autenticado y después un resolvedor privado. No publicar el repositorio ni insertar credenciales en URLs/Git como atajo.

**Telemetría:** Sink contará visitas/consultas (potencialmente aproximadas o muestreadas); las aplicaciones se contarán por `applied[]` en cada registro de ciclo, no por clics. ART-027 incluye el destino GitHub privado por fragmento Pxxx y recuperación autenticada vía el conector GitHub, todavía sin prueba E2E. El esquema `principle_usage` está definido en ART-027; su materialización en el registro operativo y agregación aún no se han probado. Las abstracciones de P020, P021, P033 y P034 no deben corregir por inferencia referencias incompletas de sus textos canónicos.

**Límites:** sin aliases creados, despliegue ni eventos de telemetría reales. El conector GitHub autenticado está disponible, pero no se ejecutó la secuencia E2E de abrir alias Sink, recuperar el fragmento Pxxx y leer el principio privado. El ancla se usa como selector del ID estructurado; no depende del renderizado visual de la tarjeta. FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, sin folio para este evento. ART-025 y la IPZ nativa/candidata permanecen intactos.

Registro: [crónica](cronica/C-GOBERNANZA-PRINCIPIOS-DOS-CAPAS-01.md) · [evidencia](evidencias/C-GOBERNANZA-PRINCIPIOS-DOS-CAPAS-01.json) · [DUG v370 · ART-027](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027).


## Estado histórico · C-GOBERNANZA-CNP-CATEGORIA-A-01 · 2026-10-30

**Persistido y releído:** DUG v368 · NX-368m; 43 principios, 19 anexos; GOW 2.14. La categoría A identifica por sí sola la pertenencia al CNP; se eliminaron los ordinales CNP-01…CNP-05 y los campos `cnp_id`. Se conservan los cinco principios P001/P004/P005/P038/P043 y sus decimales relativos A · 0.9/0.8/0.7/0.6/0.5. Sin identificador ordinal adicional.

**IPZ v0.8 · NO CONFORME COMO SUSTITUCIÓN ÍNTEGRA:** cotejada contra v0.7 (2.467 caracteres), v0.8 (1.488) omite los seis estados de autorización/ejecución, la advertencia de que edad IPZ no demuestra instalación, «Muestra solo» y parte de las instrucciones de eficiencia detalladas. No instalar v0.8 como reemplazo íntegro. La IPZ nativa sigue sin modificarse ni verificarse.

**Límites:** SHA/read-back exactos del DUG v367, 43 principios, 19 anexos, cinco miembros CNP y cero campos ordinales. No se ejecutó renderizado de navegador ni auditoría dinámica de enlaces. FOL1 sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, sin asignaciones ni folios para este evento.

Registro: [crónica](cronica/C-GOBERNANZA-CNP-CATEGORIA-A-01.md) · [evidencia](evidencias/C-GOBERNANZA-CNP-CATEGORIA-A-01.json) · [DUG v368](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html).

## Estado histórico · C-GOBERNANZA-CNP-01 / C-GOBERNANZA-IPZ-CNP-01 · 2026-10-30

**Estado del evento anterior, supersedido por la actualización de categoría A:** DUG v366 · NX-366m; 43 principios, 19 anexos; Metacanon 1.26; GOW 2.13. El CNP incluye P001/P004/P005/P038/P043 con ponderaciones A · 0.9/0.8/0.7/0.6/0.5. P043 se denomina Principio Anti-Ineficiencia (PAI) y remite a ART-026. ART-025 refuerza la consideración expresa del CNP en cada turno y mantiene la obligación de aplicar el DUG completo.

**IPZ:** candidata [v0.8](entregas/CHATGPT-v0.8/IPZ-CAMPO-CHATGPT-v0.8-PROPUESTA.txt) creada y leída de vuelta: 1.488/1.500 caracteres, pero el cotejo contra v0.7 detectó pérdida de contenido. No instalar como sustitución íntegra. El campo nativo no fue modificado ni verificado; v0.7 se conserva como antecedente.

**Límites de verificación:** JSON embebido parseado; SHA/read-back exactos de DUG v365, DUG v366 y candidata v0.8; no se ejecutó renderizado de navegador ni auditoría dinámica completa de anclas/retornos. FOL1 continúa `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, sin asignaciones y sin folios asignados a estos eventos. La ponderación y aplicación de PAI quedan abiertas a calibración empírica.

Registro: [crónica](cronica/C-GOBERNANZA-CNP-01.md) · [evidencia](evidencias/C-GOBERNANZA-CNP-01.json) · [DUG v368](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html) · [IPZ v0.8](entregas/CHATGPT-v0.8/IPZ-CAMPO-CHATGPT-v0.8-PROPUESTA.txt).

## Estado histórico · C-GOBERNANZA-FOLIACION-SECUENCIAL-01 · 2026-10-30

**Persistido y releído:** DUG v364 · NX-364m; P042; ART-024; Metacanon 1.26; GOW 2.12/125 términos; 42 principios y 18 anexos. FOL1 maestro/schema/registro A/B v1.1 y guía v1.1 existen en `ambitos/gestion-conversacional/`.

**FOL1:** `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, generación 2, contadores en cero, sin asignaciones. El inventario incluye 25 contextos OCP conocidos, 22 elegibles y tres con asignación bloqueada; cinco contextos adicionales permanecen sin clasificación/admisión. Cobertura no exhaustiva. Los folios heredados C-/E/S no se renumeran. Metacanon §22/§37.2/§37.4 fija únicamente IPZ y DUG como indicadores compactos de salida ChatGPT; ART-024 permite extender folios OCP tardíos sin duplicar el folio global.

**Pendientes para el corte:** la candidata IPZ v0.8 fue creada después de materializar CNP/PAI y ART-025, pero el cotejo contra v0.7 confirmó que omite contenido sustantivo. Antes de instalarla debe prepararse una revisión que reincorpore las garantías omitidas dentro del límite de 1.500 caracteres; solo después procede la instalación observable y la evaluación del corte FOL1. La instalación nativa no es verificable por las herramientas actuales.

**Pruebas pendientes:** validación completa JSON Schema 2020-12 con validador independiente; prueba de idempotencia y colisión por concurrencia; prueba real de asignación global y por todos los OCP aplicables en una conversación nueva; ampliación del catálogo cuando se resuelvan los contextos bloqueados o aparezcan nuevos OCP; verificación de que cada salida aplica los dos indicadores de frescura d.h.m. Sin estas pruebas no se declara captura automática, exclusividad de servidor ni cobertura organizacional exhaustiva.

## Control de aceptación FOL1

- **GOV-FOL1-CUTOVER-01 · PREPARADO_PENDIENTE_ACTIVACION_IPZ.** IPZ v0.8 candidata leída de vuelta, pero NO CONFORME como sustitución íntegra de v0.7; requiere reconciliación de contenido antes de instalarla, probarla en una conversación nueva y actualizar el maestro con SHA/read-back. Hasta entonces no asignar FOL1. Hasta entonces no asignar FOL1 ni ciclos naturales nuevos.
- **GOV-FOL1-CATALOG-01 · ABIERTO.** Cobertura `KNOWN_INVENTORY_ONLY`. Resolver controles de Blog personal, EP y Tareas automáticas; conciliación de rama OCP EP; clasificación/control de Etica y sprint GDP; identificar y revisar nuevos repositorios/OCP fuera del inventario accesible. Mantener Tareas dentro de Gobernanza y `frentes/metodologia/` como alias, no OCP.
- **GOV-FOL1-E2E-01 · ABIERTO.** Validar primera asignación conversación/ciclo/A/B y todos los OCP aplicables; idempotencia; colisión concurrente por SHA; relectura exacta; cancelación sin reutilización; y retorno del folio al ciclo/registro.
- **GOV-FOL1-SCHEMA-01 · PARCIAL.** El esquema A/B v1.1 fue corregido para separar folio global de identificador de registro, distinguir A/B y validar estados FOL1/legado, permitir `cycle_number=null` cuando el histórico no es recuperable y exigir folio heredado solo en `LEGACY_PRE_CUTOVER`. El JSON parsea; falta ejecutar validador independiente JSON Schema 2020-12 y pruebas negativas, además de comprobar semánticamente la correspondencia completa entre `ocp_refs` y los mapas de folios.
- **GOV-FOL1-RENDER-01 · PARCIAL.** DUG v366 `gov-data` parsea y el contador de auditoría compara con el total declarado de principios (43); falta renderizado de navegador y auditoría dinámica de anclas/enlaces/retornos.
- **GOV-FOL1-OUTPUT-01 · ABIERTO.** Verificar en la conversación nueva que cada salida de ChatGPT emite únicamente IPZ y DUG con versión y antigüedad `d.h.m`, tomando el último commit del archivo exacto. No declarar actualizada la configuración nativa IPZ sin lectura observable.

---

## Estado histórico · Estado operativo actualizado · C-GOBERNANZA-AT-ENDURECIMIENTO-01 · 2026-10-29

**Corte vigente:** DUG v362 · NX-362m, blob `b7593409c428e209d35f53a5f13501652208d949`; Metacanon 1.24; GOW 2.11 con 122 términos; taxonomía estructural 1.3; 41 principios y 18 anexos jerarquizados. AT v1.1 endurecida: vector literal como fuente de verdad de intención/requisito, doble enlace, recuperación de dictados, convergencia de persistencia, compatibilidad futura LISA, protocolo por ciclo y pruebas falsables. DUG/GOW aún requieren autorización P005 para alinear ART-020/024. Tareas es trabajo en desarrollo dentro del frente Gobernanza, no un frente independiente.



**Titularidad de Gobernanza según lectura de vuelta:** chatgpt-C-GOBERNANZA-RETOMA-05-SES-20261030-GV89CFA5D5, sesión SES-20261030-GV89CFA5D5, generación 6; control blob `6c6ba034382a8350e27f7bbe3d0dc50d87c7d81`; evento C-GOBERNANZA-RETOMA-05. Se conserva el historial de generaciones y el traspaso se aplicó por comparación del SHA del control seguido de lectura de vuelta. La prueba de renderizado/auditoría dinámica completa del DUG no forma parte de este ciclo.



**Continuidad predecesora · C-GOBERNANZA-CONTINUIDAD-03:** el usuario aportó un fragmento histórico sobre DUG v353/v354/v355, P041/ART-014, ART-015 a ART-022 y equivalencias de Ámbito. Fuente vigente confirmada: DUG v358 · NX-358m, Metacanon 1.23, GOW 2.7. Se materializó una síntesis y un índice con procedencia; el texto completo pegado no se declara archivado literalmente porque no se dispone de una exportación nativa. Véase [crónica](cronica/C-GOBERNANZA-CONTINUIDAD-03.md), [evidencia](evidencias/C-GOBERNANZA-CONTINUIDAD-03.json), [salida](entregas/CHATGPT-v0.3/C-GOBERNANZA-CONTINUIDAD-03-salida-final.md) y [índice](conversaciones/C-GOBERNANZA-CONTINUIDAD-03-fragmento-predecesor.jsonl).

Los estados iniciales correspondían a la lectura de Samantha v345. Su redacción anterior permanece en el historial Git de este archivo; los puntos siguientes expresan el estado vigente observado.

1. **GOV-JSON-01 · CERRADO para DUG v354.** El bloque `gov-data` del blob `695d83ea6913ab3962a87e49b008c366f512e34e` pasa `JSON.parse` y contiene 41 principios y 16 anexos. Esto cierra el defecto histórico de parseo observado en v345; no certifica ejecución en navegador ni toda la integridad funcional.
2. **GOV-ART-01 · CERRADO respecto a la identidad del anexo.** ART-014 existe en el DUG v354 como “Sistema de Persistencia Documental de Frentes (SPDF)” y contiene las reglas de captura, custodia y recuperación. La colisión histórica con ART-012/ART-013 queda resuelta. P041 y ART-014 se articularon en v353 conforme al alcance solicitado, sin crear un principio o anexo adicional.
3. **GOV-NAV-01 · CERRADO en los tres puntos de entrada inspeccionados.** Se actualizaron y releyeron `INICIO.md`, `frentes/metacanon/README.md` e `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt`; los enlaces activos ahora dirigen al DUG HTML y sus anclas integradas. El cierre corresponde a esos archivos, no a una auditoría global del repositorio.
4. **GOV-RDC-01 · ABIERTO.** Conservar el comando PowerShell original de RDC y validar sintaxis/función antes de declarar que está listo. No ejecutar el comando por el mero hecho de documentarlo; cualquier corrección candidata debe quedar separada del literal.
5. **GOV-IPZ-01 · PARCIAL.** El archivo IPZ fue actualizado y leído de vuelta (1492 caracteres), con enlace directo a ART-014 y la regla de manejo predeterminado de adjuntos. Las herramientas no exponen escritura y lectura del campo nativo de Instrucciones Personalizadas; su instalación permanece NO VERIFICADA.
6. **GOV-LINK-01 · PARCIAL / ABIERTO.** Se comprobaron el parseo JSON de v354, la compilación sintáctica aislada del JavaScript, cero IDs estáticos duplicados, las definiciones de ancla para P041/ART-014 y los registros `gow-spdf`, `gow-spd` y `gow-dug`. No se ejecutó el renderizador ni la auditoría dinámica de enlaces internos y retornos; la auditoría funcional integral sigue abierta.
7. **GOV-SPDF-E2E-01 · BLOQUEADO por insumo no disponible.** No hay un archivo adjunto real en esta conversación que pueda capturarse preservando los bytes/contenido originales. No se fabricó un archivo de prueba ni se simuló captura. La prueba completa —captura real, escritura en OCP, manifiesto, cotejo y recuperación por otra instancia autorizada— queda pendiente hasta disponer de un original real y de un segundo lector autorizado verificable.

## Restricciones heredadas

- El único documento normativo es `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`; este OCP registra estado operativo y no es una fuente normativa paralela.
- No alterar contenido normativo sustantivo de Samantha ni el GOW sin autorización expresa.
- No crear anexos ni cambiar IDs en presencia de colisiones sin resolverlas.
- No ejecutar ni consultar GitHub Actions/workflows.
- No afirmar renderizado de navegador si no se prueba.
- No afirmar que el campo nativo de IPZ está actualizado sin escritura y verificación reales.
- El OCP de Metacanon permanece en `frentes/metacanon/`.


8. **GOV-TAX-01 · PERSISTIDO Y RELEÍDO.** GOW v2.4 incorpora “Ser y Mente”, “S y M” y “Taxonomía estructural de S y M” equivalente a “Taxonomía estructural”. ART-015 a ART-022 documentan mapa global, cuenta, organización, repositorio, FT, ámbito funcional, estructura interna de FT y ámbito SPDF. ART-014 se declara hijo nivel 3 de ART-022. El índice/anexos/auditor se adaptaron para jerarquía anidada; verificación dinámica de navegador pendiente.
9. **GOV-LINK-02 · PARCIAL.** Se parseó JSON y se compiló el JavaScript operativo aislado; cero IDs estáticos duplicados. No se afirma que todos los enlaces cruzados o retornos sean correctos hasta ejecutar el renderizador/auditoría dinámica en navegador.
10. **GOV-SPDF-E2E-01 · SIGUE BLOQUEADO.** No hay original adjunto disponible que preservar en este ciclo; no se fabricó documento de prueba. La prueba real de captura, manifiesto, read-back y recuperación por segunda instancia queda pendiente.
11. **GOV-NOTION-01 · NO VERIFICADO.** El metadato local apunta al DUG v358/GOW v2.7, blob `89a28e4d05f5baab9c4b86abdb9fbfc532690c75`. El espejo de Notion no se actualizó ni se leyó de vuelta; no existe sincronización perpetua comprobada.


12. **GOV-GOW-02 · PERSISTIDO Y RELEÍDO.** El GOW v2.5 añade “Ámbito”, “Ámbito de frente de trabajo” y “Ámbito de OCP” como expresiones operativamente intercambiables cuando nombran el mismo alcance. La entrada genérica remite a las dos variantes; cada definición aclara que el calificador no crea un FT/OCP ni cambia por sí solo la ubicación o titularidad. DUG v355 · NX-355m, blob `aea6628f3e3b117468ef70a8655ebfac124a522d`.
13. **GOV-LINK-03 · PARCIAL.** JSON parseado y JavaScript operativo compilado por sintaxis; la auditoría dinámica de navegador/enlaces todavía no se ejecutó.

14. **GOV-SCOPE-HIERARCHY-01 · SUPERSEDIDO / REVERTIDO.** La decisión del evento C-GOBERNANZA-CONTEXTO-GESTION-CONVERSACIONAL-01 que definía Contexto como ámbito y Gestión conversacional como su hijo fue cancelada por `C-GOBERNANZA-OCP-UBICUO-REVERSA-CONTEXTO-01`. Se conserva el registro histórico y su evidencia, pero esa jerarquía ya no está vigente; la estructura canónica actual es Persistencia documental y Gestión conversacional al mismo nivel. DUG v357 · NX-357m.

15. **GOV-OCP-UBICUO-01 · PERSISTIDO Y RELEÍDO.** Se define OCP como objeto canónico de persistencia de cada unidad de su nivel taxonómico; la Metodología en sentido general y abstracto es el OCP raíz. OCP no es un nivel adicional y no implica una carpeta/repositorio físico exclusivo. GOW v2.7 incorpora campo `definition` separado de aliases/equivalencias, añade las entradas OCP y Persistencia documental y deja Contexto fuera de la taxonomía funcional vigente. Se permite definir subámbitos de nivel 2..N en el futuro, sin instanciarlos por simetría. Lectura de vuelta exacta, JSON parseado, JS compilado por sintaxis aislada; renderizado dinámico y enlaces pendientes.

16. **GOV-VERSION-REF-01 · PERSISTIDO Y RELEÍDO.** Se corrigió una referencia actual interna en el resumen humano de Metacanon que aún citaba Gobierno general v356 · NX-356m, dejándola alineada con Gobierno general v358 · NX-358m. No cambia la semántica de Metacanon 1.23, GOW 2.7, taxonomía 1.2 ni los dos ámbitos funcionales actuales. DUG blob `89a28e4d05f5baab9c4b86abdb9fbfc532690c75`; lectura de vuelta exacta, JSON válido y JS compilado sintácticamente de forma aislada. Renderizado del navegador y auditoría dinámica de enlaces pendientes.


17. **GOV-LINK-04 · COMPROBACIÓN ESTÁTICA PARCIAL · C-GOBERNANZA-RETOMA-02.** DUG v358 · NX-358m, blob 89a28e4d05f5baab9c4b86abdb9fbfc532690c75: 27 atributos id, cero duplicados; 16 enlaces locales #..., siete destinos únicos, cero destinos estáticos ausentes en la capa HTML con bloques script excluidos. El chequeo no abarca renderizado ni enlaces generados en runtime; GOV-LINK-01/02/03 continúan abiertos para auditoría dinámica.


18. **GOV-TAREAS-01 · ABIERTO · 2026-10-28.** Se inauguró [Tareas v1.0](../../ambitos/tareas/README.md) como diseño en incubación. Al abrir el ámbito se observó DUG v358; el corte normativo vigente ahora es **v359 · NX-359m**. Los ámbitos funcionales transversales canónicos siguen siendo Persistencia documental y Gestión conversacional; Propósito se canonizó aparte como elemento conceptual asociado al alcance de un FT. Véanse [diseño](../../ambitos/tareas/DISEÑO-TAREAS-v1.0.md), [instrucciones](../../ambitos/tareas/INSTRUCCIONES-TAREAS-v1.0.md), [texto candidato IPZ](../../ambitos/tareas/IPZ-TAREAS-CANDIDATO.txt), [estándar común de tarea v0.1](../../ambitos/tareas/ESTANDAR-COMUN-DE-TAREA-v0.1.md) y [esquema JSON candidato](../../ambitos/tareas/ESQUEMA-TAREA-COMUN-v0.1.json). DUG/GOW no autorizan aún canonizar Tareas. El campo nativo de IPZ no se ha escrito ni releído; no hay prueba de tarea real end-to-end ni integración implementada.


19. **GOV-TAX-CONCEPTUAL-INFRA-01 · PERSISTIDO Y RELEÍDO · C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01.** DUG v359 · NX-359m, blob `b2ff2845a5a99dc4ce3cafafc4f8e43607d48145`. Se conserva Ámbitos como categoría de la taxonomía conceptual y se documenta por separado la cadena de infraestructura. La categoría no obliga a un directorio `ambitos/` en cada OCP de repositorio. Propósito se incorpora como elemento conceptual canónico: enunciado compacto que define el alcance de un FT, materializable como archivo de texto o sección de un documento raíz. Los dos ámbitos funcionales transversales siguen siendo Persistencia documental y Gestión conversacional; Tareas no se canoniza. DUG y datos derivados leídos de vuelta, JSON válido, JavaScript sintácticamente compilable en aislamiento y cero IDs estáticos duplicados. Renderizado y auditoría dinámica permanecen pendientes.


20. **GOV-TASK-CONTRACT-01 · ABIERTO · C-TAREAS-ESTANDAR-REUTILIZABLE-01 → C-TAREAS-ESTANDAR-MINIMO-02.** La propuesta inicial v0.1 añadió más campos y estados de los necesarios sin evidencia de universalidad. Por instrucción del operador se redujo a [estándar mínimo v0.2](../../ambitos/tareas/ESTANDAR-COMUN-DE-TAREA-v0.2.md): identidad, enunciado, referencia al origen y estado; ámbito solo si el contexto no basta. El [esquema JSON v0.2](../../ambitos/tareas/ESQUEMA-TAREA-COMUN-v0.2.json) solo pasó `JSON.parse`; no se ejecutó un validador completo JSON Schema 2020-12 ni pruebas end-to-end. Tareas y el estándar siguen sin canonizar. Véase [crónica](../../ambitos/tareas/cronica/C-TAREAS-ESTANDAR-MINIMO-02.md) y [evidencia](../../ambitos/tareas/evidencias/C-TAREAS-ESTANDAR-MINIMO-02.json).


21. **GOV-AT-01 · AT v1.1 ENDURECIDA · C-GOBERNANZA-AT-ENDURECIMIENTO-01.** [AT v1.1](entregas/CHATGPT-v0.8/AT-v1.1.md) conserva v1.0 como antecedente y hace operativas las exigencias del operador: fuente verbatim como verdad de intención/requisito, extracto exacto, interpretación separada, umbral de actuación ante ambigüedad, cobertura de impacto, enlaces de ida/retorno, recuperación previa de dictados, convergencia con Persistencia documental/Registro conversacional y compatibilidad futura LISA sin simular L0. [Esquema v1.1](entregas/CHATGPT-v0.8/ESQUEMA-VECTORES-SEMANTICOS-AT-v1.1.json) define el contrato de datos validable. Pruebas estructurales y lectura de vuelta de este ciclo completadas: seis vectores exactos, esquema parseado y comprobaciones de ida/retorno aprobadas. Sigue pendiente una prueba ampliada de propagación que afecte más de un OCP/destino. DUG v362, ART-020/024 y GOW no se modificaron; alineación normativa pendiente de autorización P005. Véanse [crónica](cronica/C-GOBERNANZA-AT-ENDURECIMIENTO-01.md), [evidencia](evidencias/C-GOBERNANZA-AT-ENDURECIMIENTO-01.json) y [diálogo](conversaciones/C-GOBERNANZA-AT-ENDURECIMIENTO-01-dialogo.jsonl).

22. **GOV-GC-01 · CERRADO PARA EL ALCANCE NORMATIVO Y OPERATIVO v1.0 · C-GOBERNANZA-GESTION-CONVERSACIONAL-01.** DUG v360 · NX-360m incorpora ART-024 como hijo documental de ART-020 para normar Registro conversacional y Trazabilidad semántica como componentes internos de Gestión conversacional; GOW v2.9 incluye ambos términos. No se añade principio, no cambia Metacanon 1.24 ni taxonomía 1.3, y los dos ámbitos funcionales siguen siendo Persistencia documental y Gestión conversacional. Materialización inicial: `ambitos/gestion-conversacional/`; tabla de conversaciones, pareja E/S, trazas de instrucciones y extractos verbatim históricos con procedencia y clasificación. Los esquemas y JSONL pasaron parseo; la pareja E/S coincide con el mensaje de usuario y la salida final guardada; la lectura de vuelta está registrada en la evidencia del ciclo. No se prueba captura automática, sincronización entre plataformas ni instalación nativa de IPZ. El archivo candidato IPZ del OCP Metacanon no fue modificado porque ese frente tiene otra titularidad activa. En ese ciclo GOV-AT-01 permanecía abierto; se cerró posteriormente mediante C-GOBERNANZA-AT-V1-01.

**GOV-IPZ-GOW-03 · CERRADO PARA REVISIÓN DOCUMENTAL · C-GOBERNANZA-IPZ-GOW-VERIFICACION-01.** GOW v2.11: 122/122 términos con definición y ancla; definición canónica ≤3 oraciones observadas y ninguna supera la guía de 40 palabras; contrato explícito de 1–4 oraciones, lenguaje práctico y separación de notas/campos. §ARR tiene 21 términos esenciales y todos resuelven. §SUM/§EI expresan el propósito ampliado del GOW. ART-025 declara propósito, secuencia, límites, prioridades de espacio y aceptación de IPZ, en correspondencia con las instrucciones verbatim de esta conversación. El candidato IPZ v0.5 tiene 1362 unidades UTF-16. No se declara activación o sincronización.
**GOV-IPZ-GOW-03 · CERRADO PARA REVISIÓN DOCUMENTAL · C-GOBERNANZA-IPZ-GOW-VERIFICACION-01.** GOW v2.11: 122/122 términos con definición y ancla; definición canónica ≤3 oraciones observadas y ninguna supera la guía de 40 palabras; contrato explícito de 1–4 oraciones, lenguaje práctico y separación de notas/campos. §ARR tiene 21 términos esenciales y todos resuelven. §SUM/§EI expresan el propósito ampliado del GOW. ART-025 declara propósito, secuencia, límites, prioridades de espacio y aceptación de IPZ, en correspondencia con las instrucciones verbatim de esta conversación. El candidato IPZ v0.5 tiene 1362 unidades UTF-16. No se declara activación o sincronización.


23. **GOV-DUG-AT-SEMANTICA-01 · PENDIENTE DE AUTORIZACIÓN P005.** Propuesta acotada: modificar ART-020/024 y únicamente las entradas GOW afectadas para mantener Registro conversacional dentro de Gestión conversacional y clasificar Trazabilidad semántica como capacidad fundamental de AT; añadir enlaces bidireccionales entre vectores, principios, anexos, OCP, cambios y evidencias. No crear un nuevo principio ni un nuevo ámbito funcional. No escribir el DUG hasta obtener confirmación activa y explícita del operador.


24. **GOV-AT-TRACE-E2E-01 · PENDIENTE DE VALIDACIÓN AMPLIADA.** AT v1.1 y su esquema v1.1 se diseñaron y se aplicarán en ciclos reales. La verificación de este ciclo comprobará parseo, exactitud verbatim y enlaces directos/inversos de los registros creados; una prueba adicional deberá recorrer un cambio sustantivo que afecte más de un OCP/destino y verificar los resultados sin modificar el DUG fuera de autorización.


## Objetivo rector actualizado · Gobernanza 1.0 · 2026-10-31

La instrucción del operador establece como resultado una primera versión funcional de Gobernanza integrada con IPZ y OCP MCP. El IPZ tendrá un límite estricto de 1.500 caracteres y dirigirá mediante enlaces Sync acortados, en este orden, al GOW/§ARR y al DUG. El espacio restante reforzará una compuerta obligatoria: el modelo no inicia trabajo sustantivo sin asignación explícita de frente y verificación de titularidad/exclusividad conforme al protocolo vigente. La conversación no admite desvíos a consultas ajenas al frente asignado.

El folio global de ciclo —distinto del folio de conversación— será el identificador contextual presentado a OCP MCP. El servidor debe devolver el inventario de 43 principios con nombre canónico «Principio DI · [denominación atómica de 1–3 términos]» y MDP breves: suficientes para reconocer significado y pertinencia, insuficientes para aplicar la norma completa. El modelo considera todos los principios, selecciona los aplicables al ciclo y comunica la selección. OCP MCP devuelve enlaces Sync individuales a los textos desarrollados; cada acceso genera telemetría de frecuencia. El modelo consulta los textos, comprueba suficiencia y solicita principios adicionales si procede. OCP MCP emite un hash verificable del paquete de enlaces, que se incorpora a la salida del ciclo.

La telemetría mide frecuencia de acceso, no aplicación; no habilita descartar principios automáticamente. El hash debe cubrir el paquete exacto entregado. OCP MCP debe validar y vincular el folio de ciclo con la sesión autorizada; no se presume que el folio por sí solo sea una credencial criptográfica.

### Responsabilidades por frente

- Gobernanza: IPZ, admisión normativa, contrato de selección, nomenclatura/MDP, DUG único, telemetría y criterios de aceptación.
- OCP MCP: capacidades y contratos del servidor para validar ciclo/sesión, servir el inventario, recibir selección, entregar enlaces Sync individuales, registrar frecuencia y emitir hash. Debe presentar brechas entre 0.1.0 y estos requisitos.
- EP: instalación/operación local, cliente MCP, RDC, persistencia y restauración. No se administran aquí sus tareas ni objetos.
- Gobernanza 1.0: resolver los elementos satélite alrededor del DUG, preservando procedencia e historia.

El diseño anterior de Sink/Cloudflare queda en revisión. No desplegar ni declarar equivalencia con Sync hasta que se confirme el mecanismo técnico y su contrato con OCP MCP.

GOV-TASK-010 fue creado para la admisión obligatoria y titularidad exclusiva. La matriz de reorientación está en el índice de tareas provisionales. GOV-TASK-007 es el bloque crítico de IPZ/FOL1; GOV-TASK-002/003/008 requieren reconciliar el diseño histórico Sink con Sync/OCP MCP; GOV-TASK-004 y GOV-TASK-005 no bloquean el MVP inmediato.

No se modifica por este registro el DUG, ART-025, ART-027, IPZ nativo ni los controles de OCP MCP/EP. La instrucción se materializa primero como alcance provisional y contrato de coordinación.
