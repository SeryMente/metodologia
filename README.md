# Metodología

Repositorio transversal de la organización **Ser y Mente** para desarrollar, conservar y evolucionar la metodología común de trabajo aplicable a sus repositorios.

## Canon transversal de Entorno Persistente

**Fuente única:** [CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md](CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md). Este canon gobierna EP, continuidad por terminal, persistencia y recuperación, WordPress local/WP-LAB, laboratorio de contenido complementario para OGP y requisitos de acceso administrativo/secretos vinculados a Cora. Los anexos EP anteriores se conservan como antecedentes y evidencia histórica subordinada; no son autoridades paralelas.

## Estado actual

La arquitectura canónica mantiene dos elementos principales: el **Sistema de Instrucciones basado en lista de principios en cascada**, que contiene los principios fundamentales ordenados por preponderancia, y la **Metodología con sus anexos**, que desarrolla procedimientos, contexto, mecanismos y soporte operativo.

## Punto de entrada transversal de contexto

**Regla de frescura:** cada ciclo adquiere `H1 → SI@H1 → H2`; `F:✓` solo si `H1 = H2` y versión + nombre + blob SHA coinciden. No se aceptan caché ni copias previas. `F:?` = no comprobada/carrera; `F:!` = discordancia u obsolescencia.

Para cualquier conversación sujeta a esta metodología, el contexto operativo transversal se obtiene del repositorio y no de la memoria de una conversación aislada.

**Orden mínimo de lectura:**

1. [`SI-METACOGNITIVO.md`](SI-METACOGNITIVO.md) — norma canónica vigente.
2. [`METODOLOGIA.md`](METODOLOGIA.md) — desarrollo metodológico vigente.
3. [`BOOTSTRAP-CONTEXTO-GLOBAL.md`](BOOTSTRAP-CONTEXTO-GLOBAL.md) — continuidad entre conversaciones.
4. [`CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md`](CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md) — canon transversal obligatorio cuando la tarea involucre EP, WP-LAB, OGP o los flujos de acceso/secretos asociados.
5. [`ESTADO-RDC-ACTIVO.md`](ESTADO-RDC-ACTIVO.md) — identidad persistente de la sesión RDC y estado de conectividad.
6. [`ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`](ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md) — verificación y bloqueo.

La sesión RDC no se reinicia al cambiar de conversación. Permanece globalmente vigente hasta una finalización o sustitución explícita. Una desconexión temporal o un dispositivo offline afecta la conectividad observable, no la existencia de la sesión persistida.

Una conversación nueva debe heredar el estado registrado antes de pedir nuevamente los datos de la sesión.

## Arquitectura

El SI contiene los principios fundamentales y los presenta verticalmente, de mayor a menor preponderancia. La Metodología y sus anexos desarrollan la aplicación práctica del SI.

Los anexos no constituyen una tercera capa normativa; son soporte subordinado del sistema. El bootstrap de continuidad y el estado `CI` son mecanismos de soporte y no añaden principios fundamentales al SI.

## Principio de evolución

La metodología se define gradualmente. Las decisiones confirmadas se incorporan al repositorio como registro canónico y trazable. Las normas fundamentales permanecen separadas de procedimientos, herramientas e implementaciones.

## Sistema de Instrucciones basado en lista de principios en cascada

El SI canónico se encuentra en [SI-METACOGNITIVO.md](SI-METACOGNITIVO.md).

Versión vigente del SI:

**v1.6.21 — Ordenamiento por Preponderancia y Categorías**

Versión vigente de la Metodología:

**v0.14.14 — Canon Transversal de Entorno Persistente y Laboratorios**

El SI contiene los principios fundamentales vigentes, ordenados de mayor a menor preponderancia. La continuidad entre conversaciones se desarrolla operativamente mediante la Metodología y el anexo `BOOTSTRAP-CONTEXTO-GLOBAL.md`.

## Última actualización de Metodología

**v0.14.14 — Canon Transversal de Entorno Persistente y Laboratorios**  
2026-10-10

Se establece un canon transversal único para EP, persistencia/cifrado/recuperación, identidad por terminal, WordPress local/WP-LAB, laboratorio de contenido complementario para OGP y requisitos de seguridad de UI/acceso vinculados a Cora. Los anexos anteriores quedan subordinados y conservan su valor histórico; el estado físico y E2E no se declara certificado sin evidencia.


La identidad persistente de la sesión RDC y su registro transversal se mantienen mediante ESTADO-RDC-ACTIVO.md. La conectividad se verifica por ciclo mediante ping como comprobación primaria cuando el ciclo requiera uso RDC en vivo. La salida visible de cada ciclo muestra únicamente el contexto y resultado esenciales; `K: ✓` solo acredita verificación/liberación de KHORA, mientras `K: OFF` declara que el verificador no estuvo disponible sin bloquear la salida.


## Gobernanza de Vercel y continuidad local

La referencia canónica se encuentra en [ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md](ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md).

El anexo cruza los casos de uso de Cora con la cuota de deployments de Vercel y determina cuándo el trabajo puede continuar sobre un deployment existente, cuándo requiere una nueva publicación y cuándo una instancia local es suficiente. La URL canónica de KHORA permanece separada de cualquier ejecución local.

## Glosario operativo

El repositorio incorpora un glosario metodológico transversal en [GLOSARIO-OPERATIVO.md](GLOSARIO-OPERATIVO.md) y su gobernanza en [ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md](ANEXO-GOBERNANZA-TERMINOLOGICA-Y-NORMALIZACION.md). Su objetivo es evitar deriva de nomenclatura entre dictado, conversaciones, documentos y artefactos.


## Recuperación de sesión RDC

Cuando el estado global conserva una sesión RDC ACTIVA pero el canal aparece offline/no verificable y el usuario informa actividad local de la terminal, el escenario se clasifica como **DIVERGENCIA DE OBSERVABILIDAD RDC**. Cuando el modelo comunique ausencia, pérdida o desconexión de RDC, debe ofrecer en el mismo ciclo `RDC-REINSTANTIAR` y el comando oficial `npx @wonderwhy-er/desktop-commander@latest remote`.

Cuando el ciclo requiere RDC en vivo, el modelo debe emitir `RDC-REINSTANTIAR`, solicitar el `RDC-HANDSHAKE` y actualizar `ESTADO-RDC-ACTIVO.md` antes de reanudar. La sesión persistente no se marca INACTIVA por un simple offline.

El procedimiento detallado se encuentra en `ANEXO-PROCEDIMIENTO-REINSTANTIACION-RDC.md`.

La recuperación no se considera resuelta hasta el read-back del estado global publicado. Las carreras de actualización se rechazan y reconcilian; no se permiten sobrescrituras ciegas.

## Gate de contexto operativo

Todo ciclo sujeto a la metodologia debe pasar el gate fail-closed de contexto operativo antes de ejecutar trabajo dependiente del entorno. El contrato se encuentra en `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`, y el estado global de la sesion RDC en `ESTADO-RDC-ACTIVO.md`.

La incapacidad de detectar automaticamente la sesion no se interpreta como ausencia. Si no puede establecerse ACTIVA o INACTIVA, el ciclo solicita al usuario confirmar si RDC es requisito; si lo es, queda bloqueado hasta establecer y verificar la sesion.


## Sincronización audio–transcripción en vivo

La metodología incorpora un procedimiento canónico para sincronizar audio y transcripción mediante benchmark reproducible, baseline congelada, IGP y dashboard.

**Caso prioritario de validación:** Otro Gran Programa — https://github.com/SeryMente/otrobuenprograma

- ANEXO-PROCEDIMIENTO-SINCRONIZACION-AUDIO-TRANSCRIPCION-VIVO.md
- ANEXO-DASHBOARD-IGP-SINCRONIZACION.md

La extensión a proyectos futuros no debe retrasar el objetivo operativo de mejorar OGP.



## Arranque CLI Windows y clonación de repositorios

Para iniciar una terminal CIBERCAFE desde PowerShell, usa [scripts/bootstrap-cibercafe-cli.ps1](scripts/bootstrap-cibercafe-cli.ps1) mediante el procedimiento documentado en [ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md](ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md). El bootstrap valida Git y Node/npm/npx, sincroniza los repositorios sin sobrescribir destinos dudosos y mantiene RDC en primer plano. La cámara virtual puede intentarse con el parámetro `-StartOBSVirtualCamera`; el bootstrap no abre, cierra, inspecciona ni modifica Chrome ni sus perfiles/permisos. Cualquier prueba de detección en una aplicación queda separada y no se da por hecha.

El clonador específico es [scripts/clone-public-repo-to-desktop.ps1](scripts/clone-public-repo-to-desktop.ps1). Para descargar un repositorio público diferente se proporciona su URL como `-RepositoryUrl`. Ambos scripts validan origin, branch, HEAD y working tree, se detienen ante cambios locales y no sustituyen la autenticación CLI requerida por los repositorios privados.

## Gate de ejecución en ChatGPT

Todo ciclo sujeto a la metodología intenta resolver la cascada normativa durante Thinking cuando esta ventana está disponible. `INSTANT`, ausencia o estado desconocido no bloquean por sí mismos la salida. Cuando KHORA no está disponible, el contrato visible `v1.7.7` se conserva y el HUD declara `K: OFF`. El HUD incluye además `CI: ✓|?|!` para registrar la aplicación verificable del régimen de Instrucciones personalizadas.


## Entorno Persistente: Fase Fundacional Cybernet y WP-LAB

El registro transversal de continuidad, decisiones, estados físicos, manifiestos no sensibles y plan de integración se encuentra en [ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md](ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md). Cualquier trabajo sobre KHORA EP, EP_VOLATIL, VHDX/BitLocker, Deadman Trigger o el laboratorio WordPress Ser y Mente debe leerlo antes de ejecutar scripts.

Para el contrato completo del arranque en terminales efímeras de Cybernet, RDC, identidad por terminal, ficha de sesión al portapapeles, OBS, observador/telemetría, orden de instanciación por coste, WordPress/Divi y capacidad de IA visual local OGP, leer también [ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md](ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md). Este anexo contiene una sección de especificaciones del usuario verbatim y distingue premisas declaradas de pruebas técnicas.

**Foco de trabajo actual:** completar exclusivamente la Fase Fundacional EP-Cybernet antes de WP-LAB o modelos IA: workspace y extensiones actualizados, Notepad++ predeterminado y comprobado, OBS Virtual Camera confirmada en Windows y enumerada realmente por Chrome, RDC fresco con ficha de sesión verificada al portapapeles y logging saneado. El criterio de salida exige dos instanciaciones consecutivas controladas sin reinicio; ver sección 16 del anexo canónico.

El anexo distingue evidencia actual de documentación histórica. La presencia de una carpeta no acredita una junction cifrada; el repositorio público conserva documentos y hashes no sensibles, nunca secretos, bases de datos, snapshots completos ni el ZIP propietario de Divi.


## Objetos canónicos portables — marco temporal

El procedimiento subordinado [METACANON-OBJETOS-CANONICOS.md](METACANON-OBJETOS-CANONICOS.md) define cómo crear objetos de contexto replicables para cualquier proyecto, preservar dictados originales como especificación, adquirir roles/instrucciones, comprobar delta y mantener viabilidad, evidencia y prompts de continuidad. Revisión vigente: [REVISION-METACANON-1.2.json](REVISION-METACANON-1.2.json); la revisión 1.0 queda como antecedente.

Marco temporal orientativo de un mes, sin infraestructura nueva ni modificación del Sistema de Instrucciones. Esta documentación no certifica productos, permisos o dispositivos y no fuerza herramientas/memoria en otras plataformas. Cada frente tiene una carpeta canónica con un objeto de estado y todos sus archivos. [Frente EP](frentes/ep/README.md) pertenece a este repositorio; Khora es referencia de código, no propietario del frente. La visibilidad de Metodología fue comprobada privada en este ciclo; revalidarla antes de cada carga de originales privados. Secretos nunca a Git.

El proyecto de mantenimiento metodológico opera en un solo hilo y sin asistente separado; la excepción del metacanon §21 no cambia los dos roles de EP.
