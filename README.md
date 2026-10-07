# Metodología

Repositorio transversal de la organización **Ser y Mente** para desarrollar, conservar y evolucionar la metodología común de trabajo aplicable a sus repositorios.

## Estado actual

La metodología cuenta con un núcleo de versionado metodológico y un **Sistema de Instrucciones Metacognitivas** destinado a gobernar la interpretación, decisión y ejecución del modelo.

## Principio de evolución

La metodología se define gradualmente. Las decisiones confirmadas se incorporan al repositorio como registro canónico y trazable. Las normas fundamentales permanecen separadas de procedimientos, herramientas e implementaciones.

## Sistema de Instrucciones Metacognitivas

El SI canónico se encuentra en [SI-METACOGNITIVO.md](SI-METACOGNITIVO.md).

Versión vigente:

**v1.5.0 — Bloqueo Operativo Fail-Closed con Resolución Conversacional**

El SI contiene los principios fundamentales **P019–P032**, incluyendo P028 · Trazabilidad Normativa, P029 · Identidad y Vigencia Canónica, P030 · Fidelidad Terminológica Canónica, P031 · Normalización de Transcripción y P032 · Contexto Operativo Verificado.

## Última actualización de Metodología

**v0.9.0 — Bloqueo Operativo Fail-Closed y Salida Visible**  
2026-10-07

Esta evolución establece el gate de contexto operativo, el estado transversal de RDC, el bloqueo fail-closed de ejecución y su resolución conversacional abierta. El trabajo bajo la identidad efectiva de la sesión RDC está permitido cuando sea técnicamente válido; la restricción específica es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.


La sesión RDC activa y su registro transversal se mantienen mediante ESTADO-RDC-ACTIVO.md y se verifican por ciclo mediante ping como comprobación primaria de bajo costo.


## Glosario operativo

El repositorio incorpora un glosario metodológico transversal en [GLOSARIO-OPERATIVO.md](GLOSARIO-OPERATIVO.md) y su gobernanza en [ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md](ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md). Su objetivo es evitar deriva de nomenclatura entre dictado, conversaciones, documentos y artefactos.


## Gate de contexto operativo

Todo ciclo sujeto a la metodologia debe pasar el gate fail-closed de contexto operativo antes de ejecutar trabajo dependiente del entorno. El contrato se encuentra en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`, y el estado global de la sesion RDC en `ESTADO-RDC-ACTIVO.md`.

La incapacidad de detectar automaticamente la sesion no se interpreta como ausencia. Si no puede establecerse ACTIVA o INACTIVA, el ciclo solicita al usuario confirmar si RDC es requisito; si lo es, queda bloqueado hasta establecer y verificar la sesion.
