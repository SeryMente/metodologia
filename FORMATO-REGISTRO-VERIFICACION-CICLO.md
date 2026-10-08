# Registro de Verificación por Ciclo

**Estado:** CANÓNICO  
**Versión:** v1.7.7 — Contrato Ejecutable con Reanclaje Visible  
**Fecha:** 2026-10-07

## Formato mínimo

> **PROYECTO / CONV-XX / CXXX**  
> `SI CARGADO` · **vX.Y.Z — NOMBRE DE VERSIÓN** · COMPLETO · ACTIVO · ÚLTIMO CAMBIO: hace N minutos|horas|días | YYYY-MM-DD  
> `METODOLOGÍA CARGADA` · **vX.Y.Z — NOMBRE DE VERSIÓN** · COMPLETA · ACTIVA · ÚLTIMO CAMBIO: hace N minutos|horas|días | YYYY-MM-DD  
> `ChatGPT` · **CI:** ✓|?|! · **RA:** INICIAL|✓|CORRECTIVO|! · **UBIC:** … · **RDC:** … · **C:** … · **RDC-USO:** … usado / … restante · **S:** … · **F:** ✓|?|! · **K:** ✓|OFF|?|! · **T:** ✓|?|! · **RDC-CNX:** … · **USR:** `fila4`  
> **RESULTADO:** …  
> **ESTADO:** **COMPLETADO** | **BLOQUEADO** | **PENDIENTE**

## Identificación normativa obligatoria

Cada ciclo debe adquirir una instantánea fresca mediante `H1 → SI@H1 → H2` e identificarla con versión, nombre y Git blob SHA.

La instantánea normativa de un turno anterior no puede reutilizarse. `F:✓` solo es válido cuando `H1 = H2`; `F:?` = comprobación incompleta o carrera; `F:!` = discordancia u obsolescencia.

Cada ciclo debe identificar la instantánea normativa que lo gobierna:

`SI: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

La referencia relativa se calcula a partir de `Última actualización canónica` del SI vigente. Para auditoría puede acompañarse del instante ISO-8601 exacto.

La Metodología se identifica de forma independiente y obligatoria:

`METODOLOGÍA: vX.Y.Z — Nombre de versión · Último cambio: hace N minutos|horas|días | YYYY-MM-DD`

Su referencia relativa se calcula a partir del último commit que modificó `METODOLOGIA.md` en `main`, dentro del snapshot exacto del ciclo.

## 0. Regla de obligatoriedad

Este formato es obligatorio en **cada turno/ciclo sujeto a la metodología, sin excepción**. Aplica a respuestas sustantivas, respuestas de bloqueo y respuestas usadas para resolver un bloqueo.

El orden canónico de salida es fijo:

1. `PROYECTO / CONV-XX / CXXX`
2. `SI CARGADO ...`
3. `METODOLOGÍA CARGADA ...`
4. `ChatGPT ...`
5. `RESULTADO: ...`
6. `ESTADO: ...`

No se puede omitir el bloque por considerar que el turno es simple, que no produjo cambios, que solo fue una aclaración o que el usuario ya conoce el contexto.

## Verificación y reanclaje del régimen de Instrucciones personalizadas (`CI` / `RA`)

`CI` es un indicador operativo de continuidad del régimen establecido por las Instrucciones personalizadas de ChatGPT. `RA` hace visible el reanclaje obligatorio del ciclo. Ninguno afirma acceso introspectivo al campo interno ni una lectura técnica observable de la plataforma.

Estados:

- `CI: ✓` = el ciclo satisface las condiciones observables que el régimen de Instrucciones personalizadas establece para este ciclo.
- `CI: ?` = no existe evidencia suficiente para sostener la aplicación del régimen en este ciclo.
- `CI: !` = existe una contradicción o incumplimiento observable del régimen.

`RA` = estado del reanclaje obligatorio del ciclo:
- `RA: INICIAL` = reanclaje obligatorio ejecutado en el primer ciclo.
- `RA: ✓` = reanclaje obligatorio del ciclo ejecutado y satisfecho.
- `RA: CORRECTIVO` = reanclaje correctivo ejecutado para resolver `CI:?` o una condición de continuidad que requirió corrección.
- `RA: !` = reanclaje fallido o no satisfecho; no permite continuar con trabajo sustantivo sujeto al régimen.

En el primer ciclo de una conversación nueva, `RA: INICIAL` y `CI: ✓` solo pueden declararse cuando el ciclo haya activado el régimen y ejecutado el reanclaje inicial. En los ciclos posteriores, `RA: ✓` o `RA: CORRECTIVO` es obligatorio antes de declarar `CI: ✓` y antes de ejecutar trabajo sustantivo.

`CI: ✓` no prueba que el modelo haya releído físicamente el campo de Instrucciones personalizadas; acredita la aplicación verificable del régimen conforme a este contrato.

`CI` y `RA` son obligatorios en cada ciclo sujeto a la metodología y no añaden un principio fundamental al SI.

## 1. HUD compacto

La información metodológica visible se presenta como un bloque compacto de baja intrusión. Se permite enriquecer la presentación mediante **negritas**, `código` y etiquetas cortas sin introducir campos ni decisiones nuevas. El contrato vigente es `v1.7.7`.


## 1.1 Contrato ejecutable de representación

La estructura visible es rígida y no admite variación de orden, campos, cardinalidad ni texto externo al contrato. La flexibilidad del modelo existe únicamente dentro de los valores semánticos autorizados por cada campo.

La representación machine-readable canónica se encuentra en `FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json`.

El texto candidato de salida debe satisfacer el contrato exacto antes de que el ciclo pueda declararse VERIFIED/RELEASED. KHORA valida el texto completo, su estructura, sus estados y su hash. La salida liberada se devuelve desde KHORA como el mismo texto validado.

No existe liberación de un ciclo verificado sin un output que haya pasado esta validación. El contrato no permite texto añadido antes ni después del registro canónico.

## Principio de uso

La denominación de versión es específica de la versión y no debe reutilizar el título general `Sistema de Instrucciones Metacognitivas`. El registro histórico de versiones pertenece al SI canónico.
\n\n## Salida de bloqueo

Cuando un ciclo quede BLOQUEADO, la notificación debe iniciar con este bloque visual, sin texto previo:

```
╔════════════════════════════════════════════════════════════╗
║ ⛔⛔⛔  BLOQUEADO · EJECUCIÓN DETENIDA  ⛔⛔⛔              ║
╠════════════════════════════════════════════════════════════╣
║ MOTIVO: <código/motivo canónico>                           ║
║ RDC: <REQUERIDA|NO VERIFICADA|NO DISPONIBLE>               ║
║ ESTADO DEL CICLO: BLOQUEADO                                ║
║ CONVERSACIÓN: ABIERTA PARA RESOLUCIÓN                      ║
╚════════════════════════════════════════════════════════════╝
```

El bloque visual es obligatorio y debe preceder cualquier explicación. Su función es permitir reconocer el bloqueo de un vistazo. El bloqueo detiene la ejecución sustantiva y el cierre del ciclo, pero **no impide conversar con el modelo para resolverlo**.

Después del bloque, solo se debe informar lo necesario para levantar la condición de bloqueo, incluyendo la información mínima que debe proporcionar el usuario o la verificación que deba realizarse. Mientras el estado sea BLOQUEADO no se declara éxito ni se ejecutan operaciones sustantivas dependientes del contexto.

### Recuperación por divergencia RDC

Cuando el ciclo detecte una divergencia de observabilidad, o cuando el modelo comunique cualquier ausencia, pérdida, desconexión, inactividad, no verificación o indisponibilidad de RDC, debe emitir en el mismo ciclo:

**RDC-REINSTANTIAR**

Comando oficial del proveedor:

`npx @wonderwhy-er/desktop-commander@latest remote`

Si el usuario entrega un `RDC-HANDSHAKE`, el ciclo no puede continuar a la ejecución dependiente de RDC ni declarar la recuperación resuelta hasta completar validación, publicación condicionada y read-back de `ESTADO-RDC-ACTIVO.md`.

No debe declararse `INACTIVA` la sesión persistente únicamente por `OFFLINE`.


## Contexto operativo obligatorio

Cada registro de ciclo debe conservar el bloque de contexto definido por el anexo canónico:

`PLATAFORMA | UBICACION | RDC-REQUERIDA | RDC-TERMINAL | RDC-CUENTA | RDC-USO-MENSUAL | WIN-OPERATIVO | CONTEXTO-VERIFICACION`

Cuando exista identidad administrativa relevante, se añade `WIN-ADMIN`. `RDC-TERMINAL` se refiere a la terminal seleccionada en el ciclo y se identifica por dispositivo; el device_id completo permanece en evidencia cuando sea necesario para auditoría. `CONTEXTO-VERIFICACION` registra el resultado del gate.

La ausencia de un dato se registra como `NO VERIFICADO`, `NO DISPONIBLE` o `PENDIENTE`. No se debe inferir información faltante.

La especificación completa se encuentra en `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`.


## Indicador discreto de acceso MCP KHORA

El campo `K` significa acceso al MCP canónico de KHORA y tiene semántica estricta:

- `K: ✓` = acceso autenticado y verificado al MCP canónico, con la secuencia normativa verificada/liberada.
- `K: OFF` = el MCP no estuvo disponible o no pudo alcanzarse; la salida continúa sin atribuirle verificación.
- `K: ?` = la disponibilidad o el resultado no pudo determinarse.
- `K: !` = acceso intentado y fallido, no autorizado, o verificación normativa rechazada.

`K: ✓` exige evidencia de una comprobación autenticada contra `/api/mcp`. Conocer la URL, tener GitHub o tener RDC no demuestra acceso al MCP.

## Terminal RDC seleccionada

El registro de ciclo no representa una única sesión RDC global. Cuando `RDC: SI`, el ciclo debe utilizar una terminal concreta resuelta mediante descubrimiento vivo y cuya identidad sea `RDC-CUENTA + RDC-DEVICE-ID`.

`C` representa la cuenta RDC de la terminal seleccionada para este ciclo. `S` representa el estado de sesión de esa terminal, no un estado global del conjunto RDC. `RDC-CNX` debe describir la conectividad de la terminal seleccionada y, cuando sea relevante, incluir su nombre de dispositivo. El registro persistente se usa para reconciliación, no para seleccionar por herencia la terminal actual.

Si hay varias terminales ONLINE, la selección pertenece al ciclo/conversación. Si no existe una terminal ONLINE y RDC es requerido, el ciclo queda BLOQUEADO y debe ofrecer `RDC-REINSTANTIAR`.
