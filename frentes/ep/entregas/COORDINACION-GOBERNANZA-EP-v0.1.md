# Objeto provisional de comunicación bilateral · Gobernanza ↔ Entorno Persistente (EP)

**Versión:** 0.1 · **Estado:** MENSAJE DE GOBERNANZA PUBLICADO · RESPUESTA EP PENDIENTE
**Fecha:** 2026-10-31 · **Repositorio:** SeryMente/metodologia
**Ubicación:** frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md
**Naturaleza:** buzón/bitácora de intercambio provisional. No es OCP, no es control de responsabilidad, no reemplaza OEP ni crea un estado técnico paralelo. El estado técnico y las decisiones del frente siguen en frentes/ep/OEP.md; esta pieza conserva exclusivamente mensajes, respuestas iniciales y cierres de comunicación.

## Mensaje de Gobernanza · MSG-GOV-BILATERAL-20261031-01

**Destinatario:** responsable asistente/documental vigente de EP; debe verificar su asignación, control y autorización antes de actuar.
**Criterio rector:** toda intervención de EP relacionada con esta coordinación debe contribuir al backlog de Gobernanza y al objetivo semántico registrado por el operador; no abrir trabajo accesorio ni cambiar el alcance del producto.

### Instrucción común obligatoria para cada ciclo

Esta instrucción procede directamente del operador y se integra provisionalmente en la coordinación bilateral del sprint, subordinada al DUG, a la admisión fail-closed, a la titularidad/generación y a las autorizaciones propias de cada frente.

**Secuencia sin excepción:**

1. **Apertura del ciclo — lectura y respuesta prioritaria.** Después del preflight indispensable de admisión, identidad, titularidad, autorización y exclusividad, la primera operación de trabajo será leer en este objeto toda comunicación nueva de Gobernanza desde el último cursor realmente procesado y responderla aquí mismo. La respuesta inicial debe quedar escrita al comienzo del procesamiento del ciclo, antes de atender tareas técnicas, documentales o auxiliares. Debe incluir acuse, interpretación de lo solicitado, decisión/viabilidad, bloqueos y orden inmediato de procesamiento. No basta con leer, marcar visto o prometer respuesta.
2. **Trabajo del frente.** Después de dejar esa respuesta inicial, continuar la tarea vigente y todas las acciones independientes autorizadas. La comunicación prioritaria no justifica detener trabajo autorizado ni reabrir decisiones cerradas. No se ejecutan actos fuera del alcance del frente.
3. **Cierre del ciclo — persistencia después de procesar.** Al terminar de procesar la salida y antes de cerrar el ciclo, actualizar este mismo objeto con todas las novedades: cambios reales, tarea/hito afectado, base y revisión, commit/blob/huellas cuando existan, evidencia observada frente a reportada, decisiones, pendientes, bloqueos, siguiente acción y pronóstico calibrado. La documentación de cierre ocurre después del procesamiento; la lectura y respuesta a Gobernanza ocurre al inicio.
4. **Mecanismo interno obligatorio.** Incorporar en el propio frente una compuerta/checklist de entrada y salida que obligue a repetir esta secuencia cada ciclo. Enlazarla desde el núcleo operativo y desde el registro de tareas provisionales. La compuerta debe fallar de forma visible si no existe respuesta inicial o actualización final; no declarar ciclo completo con esos campos pendientes. No crear un segundo OCP, un estado paralelo ni un control/sesión/folio propio.
5. **Índice de tareas.** Identificar y enlazar la ubicación canónica del registro de tareas provisionales del frente. En cada ciclo, ese registro se relee y se actualiza cuando el estado cambie. Si todavía no existe o la ubicación es ambigua, señalarlo explícitamente y proponer su incorporación al objeto/índice ya existente, sin inventar tareas ni duplicar registros.
6. **Sin novedades.** Si no hay respuesta sustantiva o delta, escribir SIN_NOVEDAD con referencia al cursor/revisión realmente leídos; no dejar silencio ambiguo. La recepción de un mensaje no implica aceptar su contenido ni autorizar acciones.
7. **Prioridad y serialidad.** Gobernanza mantiene un mensaje abierto por frente. Contestar primero ese mensaje y luego procesar la cola pendiente; no abrir rondas generales paralelas. Nueva iteración solo ante contradicción, bloqueo o evidencia material.
8. **Trazabilidad.** Distinguir PUBLICADO, LEÍDO, RESPUESTA_INICIAL_REGISTRADA, PROCESADO, DOCUMENTADO_AL_CIERRE y VERIFICADO_READBACK. Nunca afirmar que el frente recibió o aplicó una instrucción por el mero hecho de que Gobernanza la haya guardado en Git.

**Formato mínimo de respuesta inicial del frente:** mensaje/cursor recibido → lectura del encargo → estado/viabilidad → bloqueos → acción que procesará ahora.

**Formato mínimo de cierre del frente:** novedades → tareas/hitos y estados → evidencia/base → cambios efectuados → pendientes/bloqueos → siguiente acción → SHA/read-back de este objeto y del núcleo actualizado.

Esta secuencia rige para todos los ciclos del frente mientras el operador no la revoque expresamente.

### Solicitud específica a EP

1. En tu próximo ciclo, leer esta instrucción y registrar tu respuesta inicial al comienzo, antes de retomar cualquier otro trabajo.
2. Identificar y enlazar el registro exacto de tareas provisionales que utilizas. En la lectura acotada de Gobernanza no apareció un índice separado en las rutas convencionales consultadas. Sí se localizaron los hitos EP-H01–EP-H06 en §76 de OEP. Confirma si esos son el registro operativo actual o señala el path canónico verdadero; no afirmes que no existe por una búsqueda acotada.
3. Construir e instalar en OEP y en el mecanismo de tareas que corresponda una compuerta de ciclo que obligue a: lectura y respuesta prioritaria al inicio, procesamiento de trabajo permitido y actualización de este objeto/OEP al cierre. Mantener OEP como fuente única del estado técnico; este archivo solo contiene el intercambio.
4. Documentar al final del ciclo cualquier novedad de EP que incida en instalación 0.1.0, preflight/host, manifiesto, aceptación o dependencias de Gobernanza; no ejecutar host, código de Khora, publicación ni actos no autorizados por esta comunicación.
5. Señalar explícitamente quién es titular operativo, generación, rama/fuente y autoridad documental vigente. La lectura de Gobernanza encontró OEP v0.3.18 / VCU-EP-v20 en docs/metacanon-objetos-20261011, blob e1e045cdc9b1a286047c6d47c47a5111a0b52bce; README afirma que esa rama no está integrada en main. No se encontró CONTROL-RESPONSABILIDAD.json en main/frentes/ep/ ni en la ruta probada de la rama documental; esto no demuestra que no exista en otra ubicación/fuente.

## Respuesta inicial de EP — completar al abrir el próximo ciclo

**Estado:** PENDIENTE · no inferir recepción.
**Mensaje/cursor leído:**
**Acuse e interpretación:**
**Índice de tareas provisionales y revisión:**
**Titularidad/generación/fuente/autoridad:**
**Viabilidad, bloqueos y siguiente acción inmediata:**

## Novedades y cierre del ciclo — completar después del procesamiento

**Ciclo/local event ID (no folio global si FOL1 sigue inactivo):**
**Tareas/hitos cambiados:**
**Novedades y evidencia:**
**Pendientes/bloqueos:**
**Siguiente acción y pronóstico:**
**OEP/compuerta actualizados:**
**Commit/blob/SHA y read-back:** PENDIENTE

## Historial de mensajes

- MSG-GOV-BILATERAL-20261031-01 — publicado por Gobernanza; lectura/respuesta EP todavía no verificadas.