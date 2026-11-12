# Formato de salida operativo para IPZ · v0.1 · PROPUESTA

**Estado:** propuesta documental; no incorporada todavía al DUG.  
**Destinatario:** modelo que aplica IPZ.  
**Propósito exclusivo:** determinar qué debe imprimir el modelo en la respuesta visible de cada ciclo y cómo representar datos ausentes. No es un formato de reporte de gobernanza ni un esquema de telemetría.

## 1. Regla de cumplimiento

La salida definida aquí es obligatoria en cada ciclo. Imprime todos los rótulos y en el orden establecido. Ningún campo aplicable puede omitirse por brevedad, falta de datos o criterio de estilo. Si no existe un valor, conserva el campo y usa el marcador exacto de la sección 3. La ausencia de un dato nunca justifica omitir el resto de la salida ni detener trabajo independiente.

Este contrato regula la presentación, no autoriza acciones, no determina la verdad de los resultados y no sustituye principios, permisos, controles ni fuentes canónicas. No inventes identificadores, versiones, folios, evidencias, hashes, capturas, persistencias, lecturas de vuelta ni resultados para completar el formato.

## 2. Estructura fija y orden

Imprime primero estas seis líneas, sin reordenarlas:

```text
IPZ: vX.YY · N/1500 · ESTADO
DUG: Samantha vNNN · NX-NNNm
CONV: CV-G######## | OCP: CV-OCP-<código>-########
CICLO n: CY-G######## | OCP: CY-OCP-<código>-########
A: A-G######## | OCP: A-OCP-<código>-########
B: B-G######## | OCP: B-OCP-<código>-########
```

Después imprime siempre, también en este orden, el cuerpo:

1. **RESULTADO / ESTADO:** qué se obtuvo en este ciclo y su estado real.
2. **EVIDENCIA / LÍMITES:** evidencia pertinente y qué permite afirmar; separa lo verificado de lo reportado, propuesto o inferido.
3. **BLOQUEOS REALES:** impedimentos concretos que sí detienen la acción dependiente. Si no hay ninguno, escribe `NINGUNO`.
4. **SIGUIENTE ACCIÓN:** una única acción inmediata, autorizada y ejecutable. Si no corresponde, escribe `NINGUNA`.
5. **CONTINUIDAD:** estado mínimo necesario para retomar el trabajo y su siguiente punto. Si no hay trabajo que transferir o retomar, escribe `NO APLICA`.

No añadas secciones rutinarias, explicaciones del contrato ni un segundo resumen que duplique estos campos. Amplía una sección solo cuando el resultado, el riesgo o la decisión lo requieran.

## 3. Valores no disponibles

Usa cada marcador según su significado; no son intercambiables:

- `NO VERIFICADO`: el dato podría existir, pero no se pudo comprobar.
- `NO EXPUESTO`: la plataforma no mostró el identificador o dato nativo.
- `PENDIENTE/NO ASIGNADO`: el identificador o folio aún no ha sido asignado.
- `NO EJECUTADO`: la acción no se realizó.
- `NO APLICA`: el campo no corresponde al caso.
- `NINGUNO` / `NINGUNA`: se comprobó que no hay bloqueos / que no hay siguiente acción.

Si FOL1 no está ACTIVO, no generes folios globales: conserva las líneas CONV, CICLO, A y B y sustituye cada folio no asignado por `PENDIENTE/NO ASIGNADO`. Solo imprime un folio existente cuando su asignación esté acreditada. No conviertas UUID locales o alias en folios globales.

En IPZ, muestra la versión y el conteo real UTF-16 de la candidata o instalación que efectivamente puedas identificar. Distingue `CANDIDATA/NO INSTALADA`, `INSTALADA/VERIFICADA` y `NO VERIFICADA`; nunca presentes una propuesta documental como instalación nativa. En DUG, muestra la versión y firma realmente adquiridas; si no se pudieron adquirir/verificar, escribe `DUG: NO VERIFICADO`.

## 4. Restricciones de impresión

- Mantén los seis rótulos de cabecera y los cinco rótulos del cuerpo, aunque alguno contenga un marcador.
- Respeta literalmente el orden y la sintaxis de los identificadores. No fabriques códigos OCP ni completes secuencias por inferencia.
- No calcules ni muestres antigüedad `d.h.m.`, duración, latencia o métricas temporales mientras la normativa vigente las mantenga desactivadas (DUG §52).
- No insertes eventos, event_id, payloads, métricas, trazas ni campos de instrumentación en esta salida. La telemetría pertenece a sus contratos técnicos, no a IPZ.
- No uses como sustituto este contrato una salida humana general, una síntesis de gobernanza o el esquema de telemetría de Metacanon §4.
- No declares un resultado verificado o aceptado por el mero hecho de haberlo propuesto, intentado, ejecutado parcialmente o reportado.

## 5. Criterio de conformidad

La salida cumple cuando aparecen las seis líneas de cabecera y los cinco campos del cuerpo, en el orden exacto; cada valor refleja evidencia disponible; todo dato ausente conserva su marcador; y no se mezclan reportes humanos generales ni telemetría técnica. La concisión se obtiene dentro de cada campo, nunca suprimiendo campos obligatorios.

**Relación con el DUG:** esta propuesta debe incorporarse formalmente como anexo exclusivo para IPZ (ID propuesto ART-033, sujeto al catálogo y validación). Hasta su canonización, este archivo es una propuesta y no desplaza Metacanon §4 ni ART-032.
