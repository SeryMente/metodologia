# Inicio del espacio de trabajo Ser y Mente

Punto de entrada del repositorio; no es una fuente normativa.

**Documento Único de Gobernanza:** [DUG · Samantha v368 · NX-368m](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html). Integra 43 principios, 19 anexos jerarquizados, Metacanon 1.26, GOW 2.14 con 127 términos definidos e indexados, §ARR con el vocabulario inicial de ChatGPT, taxonomía estructural 1.3, navegación y representación estructurada. Fuente y contadores releídos en `main` el 2026-10-30.

La sección humana gobierna la representación estructurada incorporada en el mismo archivo. No hay documentos normativos paralelos ni sincronización automática implícita con Notion, instrucciones personalizadas, memorias o copias locales. La rama `main` de `SeryMente/metodologia` es la fuente documental; si no puede leerse, declara `METODOLOGÍA NO VERIFICADA`. Las políticas obligatorias, los permisos reales y las autorizaciones aplicables conservan precedencia.

## Arquitectura de repositorios y frentes

Consulta el [DUG · Taxonomía estructural de S y M](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015) y el [inventario multi-repositorio](INVENTARIO-REPOSITORIOS-Y-FRENTES.md) para localizar los OCP conocidos y clasificar recursos por alcance. El inventario declara explícitamente qué repositorios pudieron leerse; no presume cobertura global fuera de ese inventario accesible.

La taxonomía separa el plano conceptual del arreglo de infraestructura. **Ámbitos** es una categoría conceptual, no un directorio obligatorio. Los ámbitos funcionales transversales canónicos al mismo nivel son [Persistencia documental](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-persistencia-documental) y [Gestión conversacional](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-gestion-conversacional). Gestión conversacional se articula mediante los módulos [Registro conversacional y Trazabilidad semántica](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), con materialización operativa provisional en [ambitos/gestion-conversacional/](ambitos/gestion-conversacional/README.md); [Propósito](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#gow-proposito-de-frente) es un elemento conceptual canónico asociado al alcance de un FT. Puede materializarse como archivo de texto o sección de documento raíz. No se exige `ambitos/` por repositorio OCP. La Metodología abstracta es el OCP raíz; cada OCP se materializa según necesidad y recuperabilidad.

El histórico **Contexto → Gestión conversacional** está supersedido y revertido; no es la taxonomía vigente. [ART-015](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015) separa el mapa conceptual de la infraestructura, y [ART-020](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-020) distingue los ámbitos funcionales de los elementos conceptuales asociados.

## Pendientes destacados

- Portabilidad operativa: revisar referencias Notion todavía presentes y probar retoma real en otra conversación/plataforma. No certificada por esta migración.
- Sincronización perpetua aplicación → repositorio: requerida; mecanismo automático aún pendiente. La copia del metaprompt de este ciclo es puntual y verificada por contenido.
- Seguridad/cifrado: alta importancia, diferidos expresamente por urgencia; siguen vigentes privacidad y prohibición de secretos en Git.
- Sesión PRIUS: conservada, no activada; revisión y adaptación diferidas.

El gobierno general anterior de `SI-METACOGNITIVO.md` es histórico. Los procedimientos técnicos existentes no imponen una herramienta o proveedor a todo frente: se consultan cuando la tarea los necesita y sus permisos lo permiten.

## Continuidad entre conversaciones

El contrato de foliación FOL1 está preparado, todavía no activo, en el OCP [Gestión conversacional](ambitos/gestion-conversacional/README.md): [registro maestro global y por OCP](ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json), [esquema del maestro](ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json), [esquema A/B v1.1](ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json) y [guía operativa v1.1](ambitos/gestion-conversacional/REGISTRO-CONVERSACIONAL-v1.1.md). FOL1 comienza después de preparar la nueva IPZ y abrir una conversación nueva; no renumera registros históricos. La cobertura del maestro es el inventario OCP conocido, no una certificación de exhaustividad de toda la organización.

Para el corte FOL1, la candidata más reciente es la [IPZ v0.8 de Gobernanza](frentes/gobernanza/entregas/CHATGPT-v0.8/IPZ-CAMPO-CHATGPT-v0.8-PROPUESTA.txt), pero el cotejo contra [v0.7](frentes/gobernanza/entregas/CHATGPT-v0.8/IPZ-CAMPO-CHATGPT-v0.7-PROPUESTA.txt) confirmó que omite salvaguardas y detalle operativo; no instalar como sustitución íntegra. Debe prepararse una nueva revisión que conserve lo esencial de ambas dentro del límite de 1.500 caracteres. La [IPZ candidata v0.5 de Metacanon](frentes/metacanon/entregas/CHATGPT-v0.5/IPZ-CAMPO-CHATGPT.txt) es un antecedente documental distinto. El propósito y contrato de la IPZ están canonizados en [ART-025](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-025). Ninguna candidata se declara instalada en el campo nativo.

## Foliación secuencial FOL1 · estado preparado

[P042](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042) y [ART-024](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024) establecen folios globales y por cada OCP aplicable para conversación (`CV`), ciclo (`CY`) y los registros A/B. El ciclo conserva además su número natural local dentro de la conversación. La asignación única reside en [REGISTRO-MAESTRO-FOLIACION.json](ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json); el [esquema maestro](ambitos/gestion-conversacional/ESQUEMA-FOLIACION-MAESTRA-v1.0.json) y el [esquema A/B](ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json) definen los datos.

**FOL1 está PREPARADO, no ACTIVO.** Sus contadores comienzan en cero; no se emiten folios nuevos ni se renumeran los registros históricos hasta instalar/verificar la IPZ y ejecutar el corte autorizado en una conversación nueva. El catálogo contiene 25 contextos conocidos, 22 elegibles y tres bloqueados; cinco candidatos siguen sin clasificación/admisión. Cobertura `KNOWN_INVENTORY_ONLY`, no exhaustiva. La asignación exige lectura del maestro, escritura condicionada a SHA y lectura de vuelta; es serialización cooperativa, no bloqueo de servidor.

## Vía portable ejecutable · kit 0.1.2

Herramientas y lectura de arranque en `frentes/metacanon/kit/0.1.2/README.md`; reglas normativas en [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) y estado operativo en el registro del frente. Usar el prompt universal y el recibo breve; los paquetes transportados conservan revisión/cobertura y declaran frescura desconocida sin cotejo. No sustituyen el canon ni certifican comprensión semántica.

## Revisión integral1.10

Las dieciséis categorías son ejes de auditoría, no sustituyen el molde de trece bloques. Aplicar el criterio de revisión correspondiente en [Metacanon integrado](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) y distinguir revisión cerrada de aceptación funcional abierta. Informe y delta: frentes/metacanon/revisiones/C-METODOLOGIA-REVISION-INTEGRAL-10.md.

## Refresco de la fuente · ciclo10

Aplicar §37 en cada ciclo activo: comprobar versión/huella y commit de la ruta central por un medio real; recuperar/adoptar solo delta compatible ya autorizado. En ChatGPT, mostrar IPZ y DUG con versión y antigüedad d.h.m desde el último commit de cada archivo exacto, conforme a §37.4. Sin acceso/reloj/origen: vigencia o edad NO VERIFICADA. No fingir refresco entre turnos o de instrucciones nativas.

## Responsabilidad exclusiva · método1.14§§38/42

La migración no transfiere el frente por sí sola. Verificar CONTROL-RESPONSABILIDAD.json autoritativo: segundo hilo, copia offline o propiedad incierta ⇒ solo lectura/análisis y propuestas NO APLICADAS, sin asumir responsabilidad ni escribir el canon. No vence por interrupción. Transferir explícitamente a hilo/instancia identificados mediante comparación y sustitución atómicas; nunca sobrescribir el control con push genérico. La biblioteca ensaya el control, no impone un cerrojo a herramientas que lo eludan; esa limitación debe declararse. Refresco y propiedad son compuertas independientes.
