> **Regla operativa vigente (C-GOBERNANZA-STREAMLINE-RESPONSABILIDAD-FOLIACION-20261111-01; registro ESPACIO: C-KHORA-ESPACIO-APERTURA-20261115-FCAE05C8):** DUG Samantha v399/NX-399m · Metacanon 1.31 · GOW 2.25. Instrucción explícita frente + actuación = autorización suficiente; «asume/retoma» releva al titular anterior. Corresponsabilidad solo por petición expresa. Folios/UUID/alias/generación son metadatos, no permisos ni bloqueos. Un registro A/B consolidado por cambio sustantivo; FOL1 PREPARADO/NO ACTIVO; Sink preferente con fallback exacto del DUG; sin medición temporal. No modificar IPZ.

# Inicio del espacio de trabajo Ser y Mente

Punto de entrada del repositorio; no es una fuente normativa.

**Documento Único de Gobernanza:** [DUG · Samantha v399 · NX-399m](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html). Integra 45 principios, anexos jerarquizados, Metacanon 1.31, GOW 2.25, §ARR con el vocabulario inicial, taxonomía estructural y representación estructurada. La fuente normativa vigente es el HTML canónico de `main`; sus hashes y revisión exacta se comprueban en el historial Git y mediante lectura de vuelta. Este punto de entrada no sustituye la lectura del documento canónico.

La sección humana gobierna la representación estructurada incorporada en el mismo archivo. No hay documentos normativos paralelos ni sincronización automática implícita con Notion, instrucciones personalizadas, memorias o copias locales. La rama `main` de `SeryMente/metodologia` es la fuente documental; si no puede leerse, declara `METODOLOGÍA NO VERIFICADA`. Las políticas obligatorias, los permisos reales y las autorizaciones aplicables conservan precedencia.

## MDP y tareas provisionales de Gobernanza

[DUG · ART-027](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027) define 43 microdescriptores de pertinencia (MDP). Cuando un principio resulta pertinente, consultar su texto completo: Sink si está disponible; si no, extracción exacta del DUG canónico main. Solo llamadas reales satisfactorias cuentan como telemetría Sink. Gobernanza mantiene ocho [OCP provisionales de tareas](frentes/gobernanza/%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/README.md). Tareas permanece sin canonizar. GOV-TASK-008 registra el aislamiento técnico pendiente de la norma desarrollada.

## Persistencia remota de dos capas

[DUG · ART-028](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-028) establece el hook semántico común EP Consumer Adapter: persistencia local durable primero y réplica EP verificable después. HARMONIA y Signal Interpreter conservan sus almacenes independientes; el destino remoto es OCP-MSP y el contrato de red/SDK de EP debe estar publicado antes de conectar el transporte.

## Arquitectura de repositorios y frentes

Consulta el [DUG · Taxonomía estructural de S y M](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015) y el [inventario multi-repositorio](INVENTARIO-REPOSITORIOS-Y-FRENTES.md) para localizar los OCP conocidos y clasificar recursos por alcance. El inventario declara explícitamente qué repositorios pudieron leerse; no presume cobertura global fuera de ese inventario accesible.

La taxonomía separa el plano conceptual del arreglo de infraestructura. **Ámbitos** es una categoría conceptual, no un directorio obligatorio. Los ámbitos funcionales transversales canónicos al mismo nivel son [Persistencia documental](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-persistencia-documental) y [Gestión conversacional](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-gestion-conversacional). Gestión conversacional se articula mediante los módulos [Registro conversacional y Trazabilidad semántica](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), con materialización operativa provisional en [ambitos/gestion-conversacional/](ambitos/gestion-conversacional/README.md); [Propósito](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-proposito-de-frente) es un elemento conceptual canónico asociado al alcance de un FT. Puede materializarse como archivo de texto o sección de documento raíz. No se exige `ambitos/` por repositorio OCP. La Metodología abstracta es el OCP raíz; cada OCP se materializa según necesidad y recuperabilidad.

El histórico **Contexto → Gestión conversacional** está supersedido y revertido; no es la taxonomía vigente. [ART-015](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015) separa el mapa conceptual de la infraestructura, y [ART-020](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-020) distingue los ámbitos funcionales de los elementos conceptuales asociados.

## Estrategia de dos capas de principios

[DUG · ART-027](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-027) define un catálogo de 45 abstracciones, aliases individuales p001–p045 mediante Sink cuando esté disponible, con respaldo exacto del DUG canónico y telemetría separada de consideración/selección/consulta/aplicación. El documento está materializado en DUG v399. PR #27 contiene una implementación candidata limitada a P004, pero sigue OPEN/DRAFT/DIVERGED; no equivale a instancia instalada ni E2E. La herramienta observada estáticamente es sink_principle con principle_id=P004. No se acredita runtime, instalación EP ni respuesta visible desde IPZ. La telemetría sigue contando únicamente recuperaciones satisfactorias.

## Pendientes destacados

- Portabilidad operativa: revisar referencias Notion todavía presentes y probar retoma real en otra conversación/plataforma. No certificada por esta migración.
- Sincronización perpetua aplicación → repositorio: requerida; mecanismo automático aún pendiente. La copia del metaprompt de este ciclo es puntual y verificada por contenido.
- Seguridad/cifrado: alta importancia, diferidos expresamente por urgencia; siguen vigentes privacidad y prohibición de secretos en Git.
- Sesión PRIUS: conservada, no activada; revisión y adaptación diferidas.

El gobierno general anterior de `SI-METACOGNITIVO.md` es histórico. Los procedimientos técnicos existentes no imponen una herramienta o proveedor a todo frente: se consultan cuando la tarea los necesita y sus permisos lo permiten.

## Continuidad entre conversaciones

El contrato de foliación FOL1 está preparado, todavía no activo, en el OCP [Gestión conversacional](ambitos/gestion-conversacional/README.md): [registro maestro global y por OCP](ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json), [esquema del maestro](ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json), [esquema A/B v1.1](ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json) y [guía operativa v1.1](ambitos/gestion-conversacional/REGISTRO-CONVERSACIONAL-v1.1.md). FOL1 comienza después de preparar la nueva IPZ y abrir una conversación nueva; no renumera registros históricos. La cobertura del maestro es el inventario OCP conocido, no una certificación de exhaustividad de toda la organización.

Para el corte FOL1, la candidata documental vigente es la [IPZ v0.9 de Gobernanza](frentes/gobernanza/entregas/CHATGPT-v0.9/IPZ-CAMPO-CHATGPT-v0.9-PROPUESTA.txt): 1.479 UTF-16 con LF (1.496 con CRLF), SHA-256 UTF-8/LF ea0001b962cea9e59ef7f0ed5bd1a47e82a147eb09ea4eed077bc75cc8f20aa3. Conserva las salvaguardas identificadas de v0.7; v0.8 sigue siendo antecedente parcial. No está escrita en el campo nativo ni leída de vuelta. FOL1 permanece PREPARADO/NO ACTIVO hasta superar su gate. La candidata v0.5 de Metacanon es un antecedente distinto; el contrato IPZ está en [ART-025](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-025).

## Foliación secuencial FOL1 · estado preparado

[P042](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042) y [ART-024](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024) establecen folios globales y por cada OCP aplicable para conversación (`CV`), ciclo (`CY`) y los registros A/B. El ciclo conserva además su número natural local dentro de la conversación. La asignación única reside en [REGISTRO-MAESTRO-FOLIACION.json](ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json); el [esquema maestro](ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json) y el [esquema A/B](ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json) definen los datos.

**FOL1 está PREPARADO, no ACTIVO.** Sus contadores comienzan en cero; no se emiten folios nuevos ni se renumeran los registros históricos hasta instalar/verificar la IPZ y ejecutar el corte autorizado en una conversación nueva. El catálogo contiene 25 contextos conocidos, 22 elegibles y tres bloqueados; cinco candidatos siguen sin clasificación/admisión. Cobertura `KNOWN_INVENTORY_ONLY`, no exhaustiva. La asignación exige lectura del maestro, escritura condicionada a SHA y lectura de vuelta; es serialización cooperativa, no bloqueo de servidor.

## Vía portable ejecutable · kit 0.1.2

Herramientas y lectura de arranque en `frentes/metacanon/kit/0.1.2/README.md`; reglas normativas en [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) y estado operativo en el registro del frente. Usar el prompt universal y el recibo breve; los paquetes transportados conservan revisión/cobertura y declaran frescura desconocida sin cotejo. No sustituyen el canon ni certifican comprensión semántica.

## Revisión integral1.10

Las dieciséis categorías son ejes de auditoría, no sustituyen el molde de trece bloques. Aplicar el criterio de revisión correspondiente en [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) y distinguir revisión cerrada de aceptación funcional abierta. Informe y delta: frentes/metacanon/revisiones/C-METODOLOGIA-REVISION-INTEGRAL-10.md.

## Refresco de la fuente · ciclo10

Adquirir el DUG una vez al iniciar/retomar un frente y reutilizarlo por revisión/huella durante el ciclo. Consultar de nuevo solo ante indicio de cambio o antes de escribir al canon. No calcular antigüedad ni d.h.m. No fingir refresco entre turnos o de instrucciones nativas.

## Responsabilidad explícita · método1.14 §§38/42

El control del frente se consulta para conocer ruta, estado y procedencia, no para pedir permiso a una sesión anterior. Conforme a P037, una instrucción expresa del operador que identifica el frente y la actuación/alcance constituye autorización suficiente para trabajar, sustituir titularidad primaria o relevar el asiento corresponsable dentro de ese alcance; no pedir una segunda aprobación, conformidad del titular previo ni datos técnicos que el operador no controla. Las generaciones, folios SES, alias, UUID locales y nombres de instancia son metadatos de procedencia, no permisos, vetos ni bloqueos de trabajo autorizado. Mantener un solo escritor activo por defecto; conservar dos asientos solo cuando exista instrucción expresa de corresponsabilidad. Si el cambio de responsabilidad modifica el control, escribir sobre el SHA leído, reconciliar cualquier conflicto mediante nueva lectura y reaplicación, y verificar por read-back. Una colisión de registro afecta únicamente la escritura concurrente concreta; no detiene trabajo independiente autorizado. Los permisos efectivos de plataforma, seguridad, privacidad y credenciales siguen siendo compuertas reales. FOL1 continúa independiente y su ausencia no bloquea la conversación ni el trabajo autorizado.
