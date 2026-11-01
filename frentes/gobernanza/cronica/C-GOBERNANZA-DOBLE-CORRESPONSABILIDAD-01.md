# C-GOBERNANZA-DOBLE-CORRESPONSABILIDAD-01 · incorporación de segunda corresponsable · 2026-11-01

## A · instrucción literal y autorización

> Asume co-responsabilidad del frente Gobernanza, como segunda conversación.

La instrucción expresa del operador autoriza la operación `ADD_CO_RESPONSIBLE` exclusivamente para `frentes/gobernanza/`. No autoriza transferencia ni sustitución del titular actual. Se conserva la regla ordinaria de una conversación por frente y se aplica la excepción de dos como máximo.

## B · resultado materializado

Se publicó DUG v375 · NX-375m en `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, blob `c993a59163c2c163b17b599a003919b53c5cf6a8`, commit `7830c14d5e6078991838c044fdbd6786f5595220`. La edición ajusta P037 y P039, Metacanon §§38, 42.6–42.7 y 47.2, y GOW 2.15. El JSON embebido se parseó después de la escritura. Se conservaron los 21 anexos existentes y ART-028.

Se publicó el procedimiento operativo derivado `entregas/CHATGPT-v0.8/AT-v1.2.md`, blob `ebe5f0f627865532647cbd226a46c05b48d69d77`, commit `702e61f800c5a4d56e9f28bc8b96528ebe15a50c`. AT v1.2 sigue siendo propuesta operativa, no un anexo independiente canonizado. AT v1.1 y su esquema quedan intactos.

## Control compartido

`frentes/gobernanza/CONTROL-RESPONSABILIDAD.json` quedó en generación 10, blob final `403748d4a401c73abf322b2bc48bd517a9c56600`. Su lectura de vuelta confirma dos sesiones activas, en un mismo control:

- Titular preservado: `chatgpt-C-GOBERNANZA-RETOMA-07-SES-20261031-GV8AA51721` · `SES-20261031-GV8AA51721` · UUIDv7 local `01a193a9-7a00-7286-9216-45a477d294c1`.
- Corresponsable añadida: `chatgpt-C-GOBERNANZA-DOBLE-CORRESPONSABILIDAD-01-SES-20261101-ED4A2B32` · instancia `chatgpt-gobernanza-corresponsable-2026-11-01-ED4A2B32` · `SES-20261101-ED4A2B32` · UUIDv7 local `01a198fc-96f9-7b06-bdca-d419a8683c09`.

El control registra el evento como `VERIFIED_READBACK`. Se incrementó la generación común de 9 a 10; no se sustituyó el titular. El identificador nativo de conversación no está expuesto; el alias y UUIDv7 son identificadores operativos/locales.

## Límites y estado

La cardinalidad máxima es dos. Una tercera conversación queda bloqueada. Ambas sesiones deben leer el mismo control vigente y usar SHA/CAS/read-back antes de cada escritura canónica. Esta garantía es cooperativa; no se afirma fencing universal frente a escritores no cooperantes.

FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se asignan folios globales CV/CY/A/B ni ciclos globales o por OCP en este evento. MCP normativo permanece `DESACTIVADO`. No se modificaron controles de otros frentes.

## Verificación

- DUG v375: leído de vuelta; JSON embebido parseado; P037/P039, §§38/42/47 y GOW 2.15 comprobados; ART-028 preservado.
- Control: leído de vuelta dos veces; generación 10, dos entradas, titular preservado, corresponsable presente, evento `VERIFIED_READBACK`.
- AT v1.2: creado y leído de vuelta.
- Pendiente: una lectura posterior desde la otra conversación no se afirma ni se simula.
