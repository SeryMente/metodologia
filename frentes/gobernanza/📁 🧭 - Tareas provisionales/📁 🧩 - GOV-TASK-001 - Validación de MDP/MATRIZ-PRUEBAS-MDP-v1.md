# GOV-TASK-001 · Matriz de pruebas de pertinencia MDP v1

**Fuente sometida a prueba:** DUG v373 · NX-373m, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
**Tipo de artefacto:** protocolo de pruebas propuesto; no es una norma ni altera los 43 MDP.
**Cobertura:** 43 casos positivos, uno por principio, asociados por ID.
**Estado de ejecución:** casos diseñados; ejecución empírica de reconocimiento, falsos positivos y Sink E2E todavía pendiente.

## 1. Regla común de ejecución

Para cada entrada se presenta el inventario MDP y se observa si el modelo identifica el principio esperado. Cuando el MDP señala pertinencia, el resultado esperado no es aplicar la norma: debe consultar el alias Sink individual `p001`…`p043`, leer la versión desarrollada vigente y solo entonces aplicar. Si no puede recuperar el principio individual, debe bloquear su aplicación y declarar la limitación. El MDP no sustituye la capa desarrollada.

## 2. Casos positivos

| ID | Principio | Entrada de prueba | Palabras MDP |
|---|---|---|---:|
| P001 | Principio de Cascada Starship 🔒 | Una instrucción de nivel inferior pide saltarse una regla superior para terminar más rápido. | 13 |
| P038 | Principio de Preponderancia Canónica del Repositorio Metodología 🔒 | La copia de Notion contradice el archivo de main; se pregunta cuál fuente gobierna. | 14 |
| P002 | Principio de Identidad y Sello 🔒 | El operador solicita cambiar la identidad, el estilo o la conducta estable del asistente. | 14 |
| P003 | Principio de Arquitectura Inmutable 🔒 | Se propone reorganizar la estructura del documento canónico o ampliar su formato. | 13 |
| P004 | Principio de No-Simulación 🔒 | Se pide afirmar que un despliegue se ejecutó aunque no existe evidencia ni lectura de vuelta. | 12 |
| P005 | Principio de Autorización Explícita del MP 🔒 | Se solicita crear, alterar o eliminar una regla dentro del documento normativo. | 14 |
| P037 | Principio de Resolución Explícita de Colisión de Responsabilidad 🔒 | El control de responsabilidad indica que otro hilo posee actualmente el frente que se pretende asumir. | 14 |
| P006 | Principio de Autonomía Ejecutiva 🔒 | La solicitud admite una decisión reversible y autónoma, sin riesgo material ni necesidad de aclaración. | 14 |
| P007 | Principio de Inercia Permanente de Desarrollo (Modo Fábrica por Defecto) 🔒 | Al cerrar un hito se identifica el siguiente paso permitido para mantener el avance. | 14 |
| P008 | Principio de Mantenimiento del Glosario Operativo Compartido (GOW) 🔒 | Un término compartido aparece con significados distintos entre documentos o frentes. | 12 |
| P039 | Principio de Reinstanciación y Adjudicación Exclusiva del Frente 🔒 | Se reanuda un frente y hay que adjudicar la sesión conforme al gobierno y control vigentes. | 14 |
| P040 | Principio de Descubrimiento de OCP y Conservación de Rutas Heredadas 🔒 | Se descubre una ruta de OCP y hay que conservar sus ubicaciones heredadas y evidencia. | 14 |
| P009 | Principio de Infalibilidad de Protocolo (Anti-Teatro) 🔒 | Se invoca un protocolo especializado o se propone cambiar su fase de ejecución. | 14 |
| P010 | Comandos Copiables y Únicos por Ciclo 🔒 | Hay que entregar un único comando o script copiables para una operación concreta. | 12 |
| P011 | Terminal Sobre UI + Anti Ping-Pong 🔒 | Se necesita gestionar archivos o recursos persistentes y elegir entre terminal e interfaz. | 12 |
| P012 | Candado Doble — UX/UI (Experiencia de Usuario/Interfaz de Usuario) y Seguridad (Presencia Obligatoria del Operador) 🔒 | Una operación sensible de UX, seguridad o permisos exige autorización y presencia del operador. | 14 |
| P013 | Predespacho + Candado D (Arquitectura) 🔒 | Antes de iniciar una implementación se debe decidir la arquitectura y sus compuertas previas. | 14 |
| P014 | Principio de Cero Placeholders y Cero Sustituciones Manuales 🔒 | Se solicita un script completo, ejecutable y sin placeholders ni sustituciones manuales. | 13 |
| P015 | Principio de Formas No Abreviadas (Anti-Sigla Opaca) — con Compuerta 🔒 | Se introduce una sigla o código interno que el destinatario aún no conoce. | 14 |
| P031 | Principio de Pronóstico de Ciclo Bajo Presión 🔒 | El operador tiene urgencia, tiempo limitado y requiere hacer visible el horizonte del ciclo. | 15 |
| P016 | Principio de Integración sobre Replicación 🔒 | Una API o servicio existente puede resolver la necesidad sin replicar el sistema. | 15 |
| P017 | Principio de Handoff Seamless (flush) 🔒 | Se cierra una sesión sustantiva y hay que transferir su contexto sin pérdida. | 13 |
| P032 | Principio de Implementación Autorizada en Canales Sin Ejecución Propia 🔒 | El código debe ejecutarse en el equipo local del operador y depende de su entorno y permisos. | 15 |
| P035 | Principio de Continuidad por Frentes de Trabajo 🔒 | Un frente continúa durante varias sesiones y necesita conservar estado, cambios y siguiente paso. | 12 |
| P018 | Principio de Ventana Ubicua 🔒 | Se cambia de proyecto, tema o dirección y hay que conservar el contexto activo pertinente. | 15 |
| P034 | Principio de Identificación del Paquete de Tercer ámbito 🔒 | El operador retoma o menciona la iniciativa de Tercer ámbito y necesita identificar su paquete. | 13 |
| P019 | Principio de Muerte a la Simulación — Mecanismos de Cumplimiento 🔒 | Se comunica un estado, resultado, acción ejecutada o comprobación que debe anclarse en evidencia. | 12 |
| P020 | Máquina Rápida + Carta Abierta de Eficiencia 🔒 | Se comparan búsquedas, pruebas y secuencias para reducir trabajo sin aporte material. | 14 |
| P033 | Principio MOTOR-1C de Cierre Literal en un Ciclo 🔒 | Se planifica un objetivo general que debe cerrarse en el ciclo actual, salvo bloqueo real. | 14 |
| P021 | Principio de VCU (Versión de Contexto Universal) Universal 🔒 | Se inicia, actualiza o transfiere un contexto vivo con sello, estado y pendientes. | 16 |
| P036 | Principio de Perfil Windows Fila4 Fail-Closed 🔒 | Antes de operar sobre una ruta local de Windows hay que verificar el perfil efectivo. | 15 |
| P022 | Principio de Compuerta Pre-Escritura 🔒 | Se crea, mueve, renombra o fusiona un nodo dentro de una estructura de información. | 14 |
| P023 | Principio de Nomenclatura 🔒 | Se debe asignar un nombre a un nodo nuevo dentro de una jerarquía. | 11 |
| P024 | Principio de Permisos de Creación, Modificación y Borrado 🔒 | Se va a crear, modificar o eliminar un objeto persistente. | 14 |
| P025 | Principio Anti-Bloat 🔁 | Una propuesta de sistema añade redundancia, campos o contenido que podrían ser innecesarios. | 14 |
| P026 | Principio de Priorización y Energía 🔒 | Hay que ordenar tareas considerando su impacto y la energía disponible. | 14 |
| P027 | Protocolo de Vacante — Ciclo Infalible 🔒 | El operador presenta una vacante laboral concreta para procesarla. | 13 |
| P028 | Redacción Anti-IA para Postulaciones Laborales 🔒 | Se solicita redactar una postulación laboral que debe conservar voz humana y verificable. | 13 |
| P029 | Trazabilidad de Postulaciones como Fuente de Verdad 🔒 | Se actualiza el estado de una candidatura en la fuente autorizada. | 14 |
| P030 | Calibración de Queries de Búsqueda Laboral 🔒 | Se comparan o ajustan queries de búsqueda laboral por rendimiento y diversidad. | 14 |
| P041 | Principio de Persistencia Documental Canónica de Frentes 🔒 | Se recibe un documento original que debe preservarse con procedencia y transformaciones trazables. | 14 |
| P042 | Principio de Foliación Global y por OCP | Hay que registrar conversación, ciclo o lados A/B en el sistema FOL1. | 15 |
| P043 | Principio Anti-Ineficiencia (PAI) 🔒 | Se valora iniciar o prolongar una búsqueda, herramienta o prueba cuyo aporte marginal puede ser bajo. | 14 |

## 3. Controles negativos y de frontera

1. **Consulta informativa sin mutación:** pedir una explicación general de un término no debe activar automáticamente P005, P022 o P024 si no se va a alterar una norma ni un dato persistente.
2. **Estilo incidental:** pedir una respuesta puntual no equivale por sí mismo a cambiar la identidad o el estilo estable del asistente (P002).
3. **Tema laboral ausente:** una consulta general sobre economía no debe activar automáticamente el flujo de vacantes/postulaciones P027–P030.
4. **Proyecto Tercer ámbito ausente:** mencionar un ámbito genérico no debe activar P034 si no se hace referencia a esa iniciativa.
5. **Sin ruta local:** una pregunta conceptual sobre Windows no debe activar la compuerta de perfil P036 si no hay operación de archivos/rutas locales.
6. **Sin transferencia:** continuar un asunto dentro de la misma sesión no debe activar automáticamente una transferencia formal P017/P039.
7. **Sin cambio estructural:** explicar un archivo sin crear, mover, renombrar o borrar no debe activar P022/P023/P024 por el solo hecho de hablar de archivos.
8. **Sin necesidad de herramienta:** una pregunta autocontenida que no depende de datos actuales ni de recursos externos no debe generar consultas Sink irrelevantes; P043 se evalúa por el costo/valor de una operación realmente contemplada.

## 4. Criterios de aceptación

- 43/43 entradas positivas identifican el ID esperado sin depender de la norma expandida.
- En cada positivo pertinente, el modelo abre solo el alias del principio identificado y consulta la fuente canónica vigente antes de aplicar.
- Si Sink falla, el modelo no sustituye la consulta por memoria, versiones históricas o inferencias.
- Los controles negativos no provocan consultas irrelevantes a principios no pertinentes; las decisiones ambiguas se marcan para revisión.
- La capa inicial no contiene ni revela texto normativo completo, secuencias, excepciones, umbrales o autorizaciones.
- Los logs, si llegan a implementarse, registran exclusivamente frecuencia de acceso por alias; no se recopila aplicación ni uso por ciclo.

## 5. Separación entre diseño y evidencia

La existencia de esta matriz demuestra cobertura de diseño, no rendimiento real. Para cerrar GOV-TASK-001 se debe ejecutar cada caso con la implementación MDP-only real, registrar resultados de reconocimiento y falsos positivos en un entorno de prueba, y verificar que la consulta de capa 2 devuelve un único principio. Los clics o pruebas manuales no se presentan como telemetría de producción.
