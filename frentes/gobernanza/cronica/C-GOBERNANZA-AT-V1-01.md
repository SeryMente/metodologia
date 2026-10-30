# Crónica · C-GOBERNANZA-AT-V1-01

**Fecha:** 2026-10-29  
**Ciclo:** C-20261029-34641998  
**Sesión:** SES-20261029-GV5KGJY8U5J · generación 5  
**OCP:** `frentes/gobernanza/`  
**Fuente normativa adquirida:** DUG v362 · NX-362m · blob `b7593409c428e209d35f53a5f13501652208d949`  
**Estado:** definición operativa AT v1.0 creada y leída de vuelta; sin canonización ni enmienda normativa.

## Encargo y acotación

El operador precisó que AT v1.0 debe resolver únicamente la articulación longitudinal de cambios conceptuales en la metodología: un cambio trabajado desde un ámbito debe reconocer la estructura OCP, el gobierno del DUG, la lista ordenada de principios, la jerarquía subordinada de anexos y los OCP/materializaciones realmente dependientes. No debe ampliarse a todo cambio imaginable ni convertirse en una arquitectura universal.

## Revisión de la fuente

Se cotejó `INICIO.md`, el núcleo, README, pendientes y control del frente Gobernanza, el ciclo histórico LISA/AT y el DUG vigente desde `main`. Se confirmó:
- DUG v362 · NX-362m, 41 principios, 18 anexos, Metacanon 1.24, GOW 2.11 (122 términos), taxonomía 1.3.
- Los principios son el único elemento de gobierno directo; los anexos están subordinados y carecen de autoridad independiente.
- La Metodología abstracta es el OCP raíz; cada unidad taxonómica que corresponda es OCP de su propio nivel. OCP no es un nivel adicional.
- La taxonomía conceptual, la jerarquía documental de anexos y la materialización física son dimensiones distintas.
- Tareas permanece en incubación y no forma parte de la lista canónica de ámbitos funcionales.

## Decisiones de diseño

1. AT v1.0 se acota a cambios conceptuales/metodológicos de Ser y Mente y a su propagación demostrablemente dependiente.
2. Se define un único mecanismo integrado, con etapas de adquisición, clasificación, trazado longitudinal, compuertas por destino, realización en orden de dependencia y verificación.
3. No se crean submódulos: las funciones comparten cambio de origen, mapa de dependencias, autorizaciones y registro. La descomposición solo se reabrirá con evidencia de estados, contratos o responsabilidades realmente independientes.
4. AT realiza los cambios que correspondan, pero no se autoautoriza. Si un destino bloquea, AT respeta la compuerta y registra el bloqueo.
5. No todo cambio local se propaga al DUG; cada destino se incluye por dependencia justificada, no por simetría.
6. LISA, cuando aplique, conserva la intención y cadena de requisitos; no se confunde con los niveles OCP.

## Validación de escritorio

- **Caso positivo retrospectivo:** el cambio de taxonomía/Propósito registrado en `C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01` muestra un recorrido coherente: actualización de ART-015/019/020/021, Metacanon §§46/51, GOW y proyección derivada; no se creó principio ni anexo nuevo. La lectura de vuelta del DUG fue exacta. Esta evidencia es histórica y no prueba ejecución automatizada de AT.
- **Caso negativo actual:** Tareas conserva diseño/artefactos en incubación, mientras DUG v362 mantiene dos ámbitos funcionales canónicos. La carpeta o estándar local no autoriza promover Tareas al DUG/GOW. Sin autorización normativa expresa, esa propagación queda bloqueada; el trabajo local independiente puede continuar según su propio OCP.

Ambos casos son walkthroughs de diseño basados en fuentes persistidas, no pruebas de runtime de AT.

## Resultado y límites

Se creó `entregas/CHATGPT-v0.8/AT-v1.0.md` como definición operativa propuesta y se leyó de vuelta desde `main`. El documento distingue los tipos de destino, el orden de propagación, las autorizaciones y el estado verificable por destino. No se modificaron el DUG, Metacanon, GOW, Canon LISA ni los artefactos del OCP Tareas. No se implementó automatización ni se canonizó AT.

**Cierre:** GOV-AT-01 queda cerrado para definición operativa v1.0 en el alcance solicitado. La siguiente actividad vuelve a Tareas, sujeto a comprobar su propio control de responsabilidad antes de cualquier escritura.

**Artefactos:** [definición AT v1.0](../entregas/CHATGPT-v0.8/AT-v1.0.md) · [evidencia](../evidencias/C-GOBERNANZA-AT-V1-01.json) · [diálogo](../conversaciones/C-GOBERNANZA-AT-V1-01-dialogo.jsonl) · [salida](../entregas/CHATGPT-v0.8/C-GOBERNANZA-AT-V1-01-salida-final.md).
