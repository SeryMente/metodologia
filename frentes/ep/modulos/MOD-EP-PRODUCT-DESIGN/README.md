# MOD-EP-PRODUCT-DESIGN — Diseño de producto asistido por BMAD

## Identidad y subordinación

- **Tipo:** módulo funcional interno de Entorno Persistente (EP); subfrente funcional, no FT independiente.
- **FT padre:** Entorno Persistente (EP).
- **OCP y fuente de estado:** `frentes/ep/OEP.md`.
- **Ruta canónica del módulo:** `frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/`.
- **Estado inicial:** INICIALIZADO; alcance de producto concreto pendiente de incorporar su fuente primaria.
- **Gobierno:** hereda íntegramente del FT EP. No crea OCP, núcleo operativo, control de responsabilidad, titularidad, sesión, generación ni folio global propios.

## Propósito derivado

Convertir las necesidades, fuentes y decisiones del operador en una definición de producto verificable y en artefactos de diseño —brief, requisitos, experiencia de usuario, interfaz y prototipos— mediante un proceso asistido por BMAD, conservando en este módulo la documentación, los entregables y la evidencia de diseño.

Esta formulación es el propósito funcional inicial del módulo; no se presenta como dictado literal del operador ni como definición cerrada de un producto específico.

## Alcance funcional

Este módulo organiza, cuando el producto y sus fuentes estén definidos:

1. **Descubrimiento y encuadre:** problema, contexto, usuarios, necesidades, objetivos, restricciones y supuestos.
2. **Definición de producto:** product brief, alcance, propuesta de valor, requisitos funcionales/no funcionales, historias y criterios de aceptación.
3. **Diseño de experiencia:** arquitectura de información, escenarios, recorridos, flujos, estados, contenido y comportamiento.
4. **Diseño de interfaz:** estructura visual, componentes, patrones, sistema de diseño y especificaciones de interacción.
5. **Prototipado:** wireframes, prototipos visuales o interactivos y pruebas de concepto estrictamente vinculadas al diseño.
6. **Validación y transferencia:** revisión contra requisitos, pruebas de usabilidad cuando proceda, hallazgos, decisiones y handoff verificable a implementación.

El tipo y fidelidad del prototipo se declararán explícitamente: conceptual, visual, navegable, funcional o técnico. La existencia de un prototipo no se presentará como MVP, producto terminado ni release aceptada.

## Límites e interfaces

- **MOD-EP-BMAD** proporciona la instalación y los recursos BMAD. Este módulo consume esa capacidad; no reinstala ni mantiene BMAD.
- **MOD-EP-OPENCODE** proporciona el entorno de ejecución/integración de OpenCode. No se duplican aquí sus binarios, configuración, credenciales ni lanzadores.
- EP Vault, Chrome y demás módulos conservan sus responsabilidades propias.
- La implementación de producción, el despliegue y la operación del producto no se asumen dentro de este módulo: se asignarán al repositorio o módulo correspondiente cuando el producto y su arquitectura estén definidos.
- Este módulo no amplía permisos de EP ni autoriza el uso de secretos, servicios o recursos externos.

La integración BMAD–OpenCode–Groq cuenta con pruebas E2E acotadas registradas en OEP §142.12 y §142.15. Eso acredita las pruebas descritas, no la aceptación integral de EP ni la disponibilidad autónoma de credenciales: OEP §142.16 mantiene pendiente la recuperación/persistencia de credenciales y §142.17 mantiene pendientes la continuidad multi-terminal y la auditoría integral de confinamiento.

## Persistencia documental

La documentación de diseño, fuentes recibidas, decisiones, requisitos, prototipos, pruebas y entregables propios de Product Design se conservarán bajo esta ruta del módulo. El OEP padre conservará únicamente la vista integrada, las interfaces, el estado y la continuidad del módulo; no se crearán núcleos ni controles paralelos.

No se crearán subdirectorios vacíos por simetría. La estructura interna se materializará conforme aparezcan fuentes y artefactos reales. Los originales se conservarán diferenciados de derivados y se enlazarán con su procedencia y verificación.

**Ubicación inicial canónica:** este módulo se crea en `SeryMente/metodologia/main`. La materialización de una copia en el workspace local de RDC queda diferida: la carpeta local `SeryMente\Metodologia` no presentó metadatos Git verificables y el OEP no acredita todavía el montaje protegido de ese workspace. No se usará una copia local no verificada como fuente canónica ni como ubicación de datos sensibles.

## Criterios de aceptación del módulo

El módulo podrá declararse funcionalmente aceptado cuando:

- el producto, problema, usuarios y objetivos estén identificados a partir de fuentes trazables;
- alcance, exclusiones, requisitos y criterios de aceptación estén revisados;
- flujos y experiencia estén especificados con suficiente detalle para el nivel de prototipo acordado;
- el prototipo tenga una clasificación explícita y sus comportamientos se verifiquen contra los requisitos aplicables;
- hallazgos, decisiones, cambios y evidencia estén conservados y leídos de vuelta;
- la transferencia a implementación identifique dependencias, interfaces y pendientes sin afirmar que el producto está terminado.

La aceptación de un entregable individual no equivale a la aceptación del módulo ni de EP.

## Primera actividad pendiente

Incorporar y revisar el documento general de implementación anunciado por el operador. El documento no está disponible como adjunto en esta conversación; su contenido y clasificación no se presuponen. Al recibirlo:

1. conservar el original y registrar su procedencia/integridad;
2. determinar si describe un prototipo conceptual, visual, navegable, funcional, una prueba de concepto, un MVP o una implementación de producción;
3. separar capacidades demostradas, afirmaciones, supuestos, brechas y decisiones;
4. derivar de la evidencia el brief, requisitos y siguiente artefacto de diseño.

## Base metodológica

- DUG canónico de Metodología, v393 · NX-393m: ART-015, ART-019, ART-021 y ART-029.
- OEP de EP, especialmente §§137, 141 y 142.
- Un módulo funcional hereda el gobierno del FT padre y no constituye por sí mismo un OCP independiente.

