# Metodología

Repositorio transversal de la organización **Ser y Mente** para desarrollar, conservar y evolucionar la metodología común de trabajo aplicable a sus repositorios.

## Estado actual

La metodología cuenta con un núcleo de versionado metodológico y un **Sistema de Instrucciones Metacognitivas** destinado a gobernar la interpretación, decisión y ejecución del modelo.

## Punto de entrada transversal de contexto

**Regla de frescura:** cada ciclo adquiere `H1 → SI@H1 → H2`; `F:✓` solo si `H1 = H2` y versión + nombre + blob SHA coinciden. No se aceptan caché ni copias previas. `F:?` = no comprobada/carrera; `F:!` = discordancia u obsolescencia.

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

**v1.6.4 — Recuperación Determinista de Sesión RDC**

El SI contiene los principios fundamentales **P019–P032**, incluyendo P028 · Trazabilidad Normativa, P029 · Identidad y Vigencia Canónica, P030 · Fidelidad Terminológica Canónica, P031 · Normalización de Transcripción y P032 · Contexto Operativo Verificado.

## Última actualización de Metodología

**v0.11.5 — Recuperación Determinista de Sesión RDC**  
2026-10-07

Esta evolución establece el gate de contexto operativo, el estado transversal de RDC, el bloqueo fail-closed de ejecución y su resolución conversacional abierta. El trabajo bajo la identidad efectiva de la sesión RDC está permitido cuando sea técnicamente válido; la restricción específica es no clonar ni materializar repositorios nuevos dentro del perfil o ruta de MantenimientoRCI.


La identidad persistente de la sesión RDC y su registro transversal se mantienen mediante ESTADO-RDC-ACTIVO.md. La conectividad se verifica por ciclo mediante ping como comprobación primaria cuando el ciclo requiera uso RDC en vivo. La salida visible de cada ciclo muestra únicamente el contexto y resultado esenciales; `K: ✓` solo acredita verificación/liberación de KHORA, mientras `K: OFF` declara que el verificador no estuvo disponible sin bloquear la salida.


## Glosario operativo

El repositorio incorpora un glosario metodológico transversal en [GLOSARIO-OPERATIVO.md](GLOSARIO-OPERATIVO.md) y su gobernanza en [ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md](ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md). Su objetivo es evitar deriva de nomenclatura entre dictado, conversaciones, documentos y artefactos.


## Recuperación de sesión RDC

Cuando el estado global conserva una sesión RDC ACTIVA pero el canal aparece offline/no verificable y el usuario informa actividad local de la terminal, el escenario se clasifica como **DIVERGENCIA DE OBSERVABILIDAD RDC**.

Cuando el ciclo requiere RDC en vivo, el modelo debe emitir `RDC-REINSTANTIAR`, solicitar el `RDC-HANDSHAKE` y actualizar `ESTADO-RDC-ACTIVO.md` antes de reanudar. La sesión persistente no se marca INACTIVA por un simple offline.

El procedimiento detallado se encuentra en `ANEXO-PROCEDIMIENTO-REINSTANTIACION-RDC.md`.

## Gate de contexto operativo

Todo ciclo sujeto a la metodologia debe pasar el gate fail-closed de contexto operativo antes de ejecutar trabajo dependiente del entorno. El contrato se encuentra en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`, y el estado global de la sesion RDC en `ESTADO-RDC-ACTIVO.md`.

La incapacidad de detectar automaticamente la sesion no se interpreta como ausencia. Si no puede establecerse ACTIVA o INACTIVA, el ciclo solicita al usuario confirmar si RDC es requisito; si lo es, queda bloqueado hasta establecer y verificar la sesion.


## Sincronización audio–transcripción en vivo

La metodología incorpora un procedimiento canónico para sincronizar audio y transcripción mediante benchmark reproducible, baseline congelada, IGP y dashboard.

**Caso prioritario de validación:** Otro Gran Programa — https://github.com/SeryMente/otrobuenprograma

- ANEXO-PROCEDIMIENTO-SINCRONIZACION-AUDIO-TRANSCRIPCION-VIVO.md
- ANEXO-DASHBOARD-IGP-SINCRONIZACION.md

La extensión a proyectos futuros no debe retrasar el objetivo operativo de mejorar OGP.


## Gate de ejecución en ChatGPT

Todo ciclo sujeto a la metodología intenta resolver la cascada normativa durante Thinking cuando esta ventana está disponible. `INSTANT`, ausencia o estado desconocido no bloquean por sí mismos la salida. Cuando KHORA no está disponible, el contrato visible `v1.7.2` se conserva y el HUD declara `K: OFF`.
