# Ser y Mente · Metodología

**Empieza por [INICIO.md](INICIO.md).** Este README es un índice humano, no una fuente normativa ni un estado operativo alternativo.

La fuente documental preponderante es este repositorio privado, rama `main`. Ante una divergencia, prevalece la revisión de `main` verificada. Las copias locales, las memorias, las instrucciones personalizadas y otras plataformas son espejos subordinados.

## Gobierno canónico

- [INICIO.md](INICIO.md) — orden de adquisición y arranque del trabajo.
- [DUG integrado · Samantha (Sam)](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P001) — v363 · NX-363m; verifica siempre la revisión viva de `main`.
- [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) — v1.25; fuente única dentro del DUG.
- [GOW integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#glosario) — v2.12, 125 términos con definición estructurada; incluye §ARR como vocabulario inicial para ChatGPT y no es autoridad de gobernanza.
- [Gobierno general y precedencia](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html).

## Método transversal y continuidad

- [Metodología operativa](METODOLOGIA.md) y [lineamientos](LINEAMIENTOS.md).
- [Prompt universal de reinstanciación](PROMPT-UNIVERSAL-REINSTANTANCIACION.md) — puerta de arranque para cualquier FT/FDT.
- [Bootstrap de contexto global](BOOTSTRAP-CONTEXTO-GLOBAL.md) — procedimiento vigente de continuidad y verificación.
- [Ancla metodológica](ANCLA.md).
- [Especificación de evidencia normativa por ciclo](ESPECIFICACION-EVIDENCIA-NORMATIVA-POR-CICLO.md).
- [Formato de registro de verificación](FORMATO-REGISTRO-VERIFICACION-CICLO.md) y [su esquema JSON](FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json).
- [Estado RDC activo](ESTADO-RDC-ACTIVO.md) y [historial RDC](HISTORIAL-RDC.md).
- [Glosario de compatibilidad](GLOSARIO-OPERATIVO.md) — solo puntero; el GOW canónico está en `gobernanza/`.

- **Foliación FOL1:** contrato en [P042](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042) y [ART-024](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024); [registro maestro](ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json), [esquema maestro](ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json) y [guía A/B](ambitos/gestion-conversacional/REGISTRO-CONVERSACIONAL-v1.1.md). Estado: PREPARADO, no ACTIVO, pendiente de preparar la nueva IPZ y ejecutar el corte en una conversación nueva.

## Cánones y anexos por ámbito

Consulta estos documentos cuando la tarea pertenezca a su ámbito; no es necesario cargar todos para cualquier trabajo.

**Entorno persistente y laboratorios:** [canon transversal](CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md), [registro histórico EP/WP-LAB](ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md), [especificación EP/Cybernet/WP-LAB/OGP](ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md), [contexto de ejecución y salida de ciclo](ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md).

**Gobernanza y gates:** [gate de contexto fail-closed](ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md), [gate de Thinking para ChatGPT](ANEXO-GATE-THINKING-CHATGPT.md), [estado global RDC](ANEXO-GOBERNANZA-ESTADO-GLOBAL-RDC.md), [normalización terminológica](ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md), [dashboard IGP](ANEXO-DASHBOARD-IGP-SINCRONIZACION.md).

**Procedimientos operativos:** [Vercel y continuidad local](ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md), [arranque CLI y clonado](ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md), [reinstanciación RDC](ANEXO-PROCEDIMIENTO-REINSTANTIACION-RDC.md), [sincronización audio/transcripción](ANEXO-PROCEDIMIENTO-SINCRONIZACION-AUDIO-TRANSCRIPCION-VIVO.md), [liberación de desempeño en Cybercafé](ANEXO-PROCESO-LIBERACION-DESEMPENO-CIBERCAFE.md).

## Código, frentes y entregables

- [Scripts](scripts/) y [validaciones automáticas](.github/workflows/).
- [Frentes de trabajo y sus OCP](frentes/).
- [Registro de equipos Cybercafé](CIBERCAFE/).
- [Entregables](ENTREGABLES/); los análisis de principios anteriores están archivados en [principios-historicos](ENTREGABLES/principios-historicos/).
- Las revisiones históricas de Metacanon están en [frentes/metacanon/antecedentes/revisiones](frentes/metacanon/antecedentes/revisiones/), fuera del arranque rutinario.

## Compatibilidad histórica

- [SI-METACOGNITIVO.md](SI-METACOGNITIVO.md) conserva temporalmente el texto legado completo con banner **GOBIERNO GENERAL SUPERSEDIDO** porque KHORA aún lo consume en `CANONICAL_SI_PATH`; no es el gobierno general vigente de Metodología. Su [puntero de archivo](gobernanza/antecedentes/SI-METACOGNITIVO-v1.6.21-historico.md) conserva esa distinción. No retirar esta compatibilidad hasta migrar y probar KHORA.
- [CONTINUIDAD-ENTRE-CONVERSACIONES.md](CONTINUIDAD-ENTRE-CONVERSACIONES.md) es un puntero a una guía anterior. Para arrancar cualquier conversación de trabajo, usa `INICIO.md`, `PROMPT-UNIVERSAL-REINSTANTANCIACION.md` y `BOOTSTRAP-CONTEXTO-GLOBAL.md`. La instalación de la IPZ nativa se verifica aparte; el repositorio no demuestra por sí solo su aplicación.

Las conversaciones originales, crónicas, evidencias y entregas versionadas de cada frente se conservan bajo sus carpetas correspondientes. Sus contenidos históricos no deben cargarse todos por defecto ni convertirse en normas solo por existir.

## Arquitectura multi-repositorio

El nombre operativo del frente es **Metacanon**; el repositorio conserva su nombre `SeryMente/metodologia` porque repositorio y frente son identidades distintas. La taxonomía y el corte de repositorios/OCP observados se registran en [INVENTARIO-REPOSITORIOS-Y-FRENTES.md](INVENTARIO-REPOSITORIOS-Y-FRENTES.md); el estándar vigente está en [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) (§51). Los OCP históricos de otros frentes conservan sus rutas declaradas.
