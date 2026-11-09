# GOV-TASK-010 · Admisión operativa por instrucción del operador

**Naturaleza:** procedimiento de Gobernanza para encauzar trabajo por frente; no crea controles, sesiones, folios ni responsables paralelos.
**Estado:** `en_curso`
**Responsabilidad:** heredada del OCP Gobernanza.
**task_id:** `GOV-TASK-010`
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Permitir que la conversación ejecute el trabajo que el operador instruye, dentro del frente identificado y del alcance declarado, sin convertir los metadatos de control en permisos o bloqueos. La instrucción directa del operador es la fuente de autorización para la tarea que describe. El control del frente se consulta para conocer ubicación canónica, estado y restricciones reales, no para solicitar conformidad a un titular anterior.

## Procedimiento

1. Identificar el frente y la actuación que el operador ha indicado. Si la instrucción ya los identifica, no volver a preguntarlos.
2. Consultar el control y el OCP solo para verificar la ruta canónica, las restricciones materiales, la procedencia y el estado real.
3. Tratar generaciones, folios de sesión, alias, UUID locales, etiquetas de instancia e historial de titulares como metadatos de auditoría. No confieren ni restringen autoridad, no producen veto y no son requisitos de admisión.
4. No exigir transferencia formal, consentimiento del titular anterior, incremento de generación ni alta de corresponsables para ejecutar la instrucción vigente del operador.
5. Mantener un único escritor activo por defecto. La concurrencia se resuelve con lectura actual, comparación de SHA del archivo y relectura/reaplicación si la base cambió; no se descarta trabajo ni se bloquea por un contador registral.
6. Si el alcance de la instrucción realmente no identifica el frente o la acción, formular una sola pregunta concreta. No pedir IDs de conversación, folios, UUID ni números de generación.
7. Aplicar las políticas obligatorias de la plataforma, permisos efectivos, seguridad, privacidad y protección de credenciales. Esta simplificación no crea permisos técnicos que no existan.
8. No activar FOL1 ni asignar CV/CY/A/B mientras su activación nativa no esté verificada; esa foliación no es requisito para continuar el trabajo.

## Límites

- La autorización directa solo cubre el frente y la actuación descritos por el operador.
- No autoriza acceder a cuentas, dispositivos, secretos o sistemas para los que no existan permisos reales.
- No declarar una identidad nativa de plataforma cuando no se exponga.
- No activar `MCP-NORMATIVO` ni instalar/modificar la IPZ nativa sin su compuerta específica.
- La conversación puede continuar con diseño, análisis, consulta y trabajo autorizado; un bloqueo afecta únicamente la acción concreta que carezca de permiso o requisito técnico real.

## Criterio de aceptación

Una instrucción explícita que identifica frente y acción puede ejecutarse sin validar generación o conseguir el consentimiento del titular anterior. Las generaciones/folios no alteran el resultado. Una restricción real de plataforma, seguridad, acceso o alcance sí bloquea únicamente la acción afectada. El SHA de cada escritura se comprueba mediante lectura posterior.

## Alineación con Samantha v385 · NX-385m · 2026-11-09

P037 determina que el operador autoriza la actuación descrita. La titularidad y generación registrales dejan de funcionar como compuerta. No se impone pregunta redundante al operador ni se convierte la organización documental en un trámite adicional.


## Aplicación al sprint MCP-OCP · 2026-11-09

La instrucción explícita del operador identifica los tres frentes y autoriza el diseño/actualización documental de sus tareas provisionales. La autorización de implementación Sink local por STDIO está registrada directamente en el control MCP-OCP. No solicitar aprobación del titular anterior ni usar generación/folio como compuerta. La actuación técnica parte de `main` y permanece dentro del OCP MCP.

La admisión fail-closed se aplica a cada operación real: no leer fuera de rutas permitidas, no ejecutar sin autorización local, no aceptar fuentes no verificadas y no continuar con hashes discrepantes. No bloquea diseño, revisión de código, pruebas locales, compilación ni paquete. La instalación en PC 7 se bloquea solo por gates reales de EP (identidad/perfil, protección efectiva, dead-man LOC-OTHER, root de datos y consentimiento interactivo). Ninguna actualización documental instala o registra al operador por sí sola.
