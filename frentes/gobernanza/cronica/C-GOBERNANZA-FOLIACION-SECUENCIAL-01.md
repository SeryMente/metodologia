# Crónica · C-GOBERNANZA-FOLIACION-SECUENCIAL-01

**Fecha de registro:** 2026-10-30.  
**Frente:** Gobernanza.  
**Repositorio:** SeryMente/metodologia.  
**OCP responsable:** frentes/gobernanza/.  
**Control activo:** generación 5, titularidad conservada; control blob observado al inicio del ciclo: 4768d6db0a620652f753262b6250c8cb4b891ca9.  
**Fuente normativa de cierre:** DUG v363 · NX-363m.

## Origen y autorización

El operador solicitó un formato de salida ciclo a ciclo con antigüedad IPZ/DUG en días.horas.minutos y foliación secuencial de conversación, ciclo natural y lados A/B, tanto globalmente para la Metodología como por cada OCP pertinente. Después ordenó expresamente dejar la IPZ para el final y realizar antes las modificaciones necesarias. Esa autorización quedó añadida al control activo del frente, con exclusión expresa de ART-025 y del archivo candidato IPZ durante esta fase.

Las instrucciones visibles se conservaron como tres fuentes verbatim y se vincularon a cuatro vectores AT. Sus folios C- fueron asignados al registrar el historial visible; son identificadores legados, no folios globales FOL1 ni IDs nativos de plataforma. Se generó el UUIDv7 local 01a18d91-e030-7683-a4fa-7391408f989c para este registro; no se presenta como ID nativo de ChatGPT.

## Decisiones de diseño

- Un solo contador global por clase: conversación, ciclo, A y B.
- Contadores independientes para las mismas clases por cada OCP aplicable.
- Número natural de ciclo dentro de cada conversación, separado del folio global y los folios OCP.
- A identifica la entrada literal del operador; B la salida visible final del modelo. A=1 y B=2 dentro del ciclo.
- UUIDv7 local permanece como identidad estable de la conversación; no sustituye ningún folio ni ID nativo.
- El registro maestro reside en el OCP de Gestión conversacional como fuente central de asignaciones; el CSV es solo índice.
- La clave idempotente impide duplicar una asignación; la escritura del maestro se condiciona al blob SHA leído y exige lectura de vuelta.
- FOL1 comienza en cero y queda PREPARADO, no ACTIVO, hasta el corte posterior a la preparación de IPZ. No se asigna FOL1 retroactivamente a ciclos previos.
- Los contextos desconocidos se registran como pendientes; no se inventa su identidad ni su folio OCP.

## Cambios materializados

1. DUG v363: P042 y ampliación de ART-024.
2. Metacanon 1.25: §28 y §37.4.
3. GOW 2.12: 125 términos y vocabulario §ARR ampliado.
4. Esquema del registro maestro y registro FOL1, con 23 contextos conocidos, 20 elegibles, tres contextos bloqueados y cinco candidatos no clasificables.
5. Esquema A/B v1.1 y guía conversacional v1.1, corregidos para distinguir registros FOL1 de registros legados pre-corte.
6. INICIO.md, README.md, núcleo, pendientes e índice del frente Gobernanza actualizados.
7. Registro de conversaciones extendido con campos FOL1 sin asignar para los ciclos legados; FUENTES-VERBATIM y registro de trazabilidad AT ampliados.

## Verificación

- JSON del DUG leído de vuelta y parseado; P042 presente; ART-024 contiene contrato FOL1; 42 principios, 18 anexos y 125 términos GOW.
- ART-025 coincide literalmente con su versión base; no se modificó.
- IPZ candidata v0.5: blob 281f20daad92284fe29151372e83114a037f83f5, sin modificación en este ciclo.
- Maestro FOL1: PREPARADO_PENDIENTE_ACTIVACION_IPZ, generación 0, todos los contadores cero, asignaciones vacías.
- Catálogo: 23 OCP conocidos, 20 elegibles, tres bloqueados; cinco candidatos adicionales en unresolved_contexts; cobertura KNOWN_INVENTORY_ONLY.
- Esquemas del maestro y del ciclo A/B parseados; se comprobaron campos requeridos, patrones, estados y consistencia entre catálogo y contadores. No se usó validador JSON Schema externo completo.
- Fuentes verbatim: tres registros añadidos, texto cotejado contra los extractos.
- Vectores AT: cuatro registros añadidos. Tres requisitos implementados/verificados; el vector de diferimiento de IPZ permanece parcialmente abierto hasta la última fase.
- Registro conversacional: tres ciclos legados numerados localmente 1, 2 y 3 con lados A/B; no se les atribuye folio FOL1.

## Límites y pendientes conservados

La cobertura del maestro depende del inventario conocido en los repositorios accesibles; no acredita todos los repositorios de la organización. La comparación por SHA es cooperativa y no crea bloqueo de servidor. No se realizó una prueba de escritor concurrente, ni una asignación FOL1 real en un chat recién abierto. La configuración nativa de IPZ no es legible/escribible desde las herramientas disponibles. Se preserva esa limitación, sin declarar instalación o activación.

La preparación de la nueva IPZ queda expresamente para el último paso, una vez articulados y materializados los demás componentes.
