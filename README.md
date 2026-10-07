# Metodología

Repositorio transversal de la organización **Ser y Mente** para desarrollar, conservar y evolucionar la metodología común de trabajo aplicable a sus repositorios.

## Estado actual

La metodología cuenta con un núcleo de versionado metodológico y un **Sistema de Instrucciones Metacognitivas** destinado a gobernar la interpretación, decisión y ejecución del modelo.

## Punto de entrada transversal de contexto

Para cualquier conversación sujeta a esta metodología, el contexto operativo transversal se obtiene del repositorio y no de la memoria de una conversación aislada.

**Orden mínimo de lectura:**

1. [`SI-METACOGNITIVO.md`](SI-METACOGNITIVO.md) — norma canónica vigente.
2. [`ESTADO-RDC-ACTIVO.md`](ESTADO-RDC-ACTIVO.md) — identidad persistente de la sesión RDC y estado de conectividad.
3. [`ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`](ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md) — verificación y bloqueo.

La sesión RDC no se reinicia al cambiar de conversación. Permanece globalmente vigente hasta una finalización o sustitución explícita. Una desconexión temporal o un dispositivo offline afecta la conectividad observable, no la existencia de la sesión persistida.

Una conversación nueva debe heredar el estado registrado antes de pedir nuevamente los datos de la sesión.

## Principio de evolución

La metodología se define gradualmente. Las decisiones confirmadas se incorporan al repositorio como registro canónico y trazable. Las normas fundamentales permanecen separadas de procedimientos, herramientas e implementaciones.

## Sistema de Instrucciones Metacognitivas

El SI canónico se encuentra en [SI-METACOGNITIVO.md](SI-METACOGNITIVO.md).

Versión vigente:

**v1.5.0 — Bloqueo Operativo Fail-Closed con Resolución Conversacional**

El SI contiene los principios fundamentales **P019–P032**, incluyendo P028 · Trazabilidad Normativa, P029 · Identidad y Vigencia Canónica, P030 · Fidelidad Terminológica Canónica, P031 · Normalización de Transcripción y P032 · Contexto Operativo Verificado.

## Última actualización de Metodología

**v0.9.2 — Salida Visible Mínima y Contexto Condensado**  
2026-10-07

Esta evolución establece el gate de contexto operativo, el estado transversal de RDC, el bloqueo fail-closed de ejecución y su resolución conversacional abierta. El trabajo bajo la identidad efectiva de la sesión RDC está permitido cuando sea técnicamente válido; la restricción específica es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.


La identidad persistente de la sesión RDC y su registro transversal se mantienen mediante ESTADO-RDC-ACTIVO.md. La conectividad se verifica por ciclo mediante ping como comprobación primaria cuando el ciclo requiera uso RDC en vivo. La salida visible de cada ciclo muestra únicamente el contexto y resultado esenciales; el detalle permanece en los registros.


## Glosario operativo

El repositorio incorpora un glosario metodológico transversal en [GLOSARIO-OPERATIVO.md](GLOSARIO-OPERATIVO.md) y su gobernanza en [ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md](ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md). Su objetivo es evitar deriva de nomenclatura entre dictado, conversaciones, documentos y artefactos.


## Gate de contexto operativo

Todo ciclo sujeto a la metodologia debe pasar el gate fail-closed de contexto operativo antes de ejecutar trabajo dependiente del entorno. El contrato se encuentra en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`, y el estado global de la sesion RDC en `ESTADO-RDC-ACTIVO.md`.

La incapacidad de detectar automaticamente la sesion no se interpreta como ausencia. Si no puede establecerse ACTIVA o INACTIVA, el ciclo solicita al usuario confirmar si RDC es requisito; si lo es, queda bloqueado hasta establecer y verificar la sesion.
