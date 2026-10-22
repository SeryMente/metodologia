# Protocolo de benchmarking del marco · v0.1

Estado: diseño solicitado, preparado para revisión y ejecución; NO constituye resultados ni portabilidad certificada. Ciclo C-METODOLOGIA-RETOMA-05-r1. Método adquirido: 1.8 / METACANON-OBJETOS-v1.8; gobierno distribuido Samantha v333 / NX-333m. No modifica normas superiores, autoriza observación de terceros ni activa PRIUS.

## Propósito y procedencia

Medir continuidad entre conversaciones y fidelidad entre instrucción literal, interpretación explícita, acción y resultado. Fuentes: dictados originales de BENCHMARK-03 (eventos861 y1005; conservar ambos sin deducir si son reenvíos) y TRAZABILIDAD-04 (evento1164), conservados en ../../conversaciones según el mapa del núcleo. El texto original manda; esta especificación es su desarrollo técnico, no una cita literal.

## Separación de evidencias

- Mecánica: pruebas de archivos, hashes, cobertura, permisos codificados, estado de operaciones y empaquetado. Se ejecuta sin modelo; no mide comprensión.
- Semántica: una conversación independiente recibe únicamente disparador y fuentes del frente; registra plataforma/modelo solo si son verificables. Debe reconstruir propósito, estado, restricciones, pendientes y siguiente acción. Evaluación por rúbrica y referencias, no por autoafirmación del modelo.
- Campo: eventos realmente observados y accesibles en plataformas autorizadas. No acredita razonamiento interno ni motivos comerciales de un proveedor.
- Esta retoma recibió también historial exportado: no es ensayo ciego del prompt universal por sí solo.

## Unidad de medida y registro por ejecución

Identificar run_id, case_id, versión del protocolo y del arnés, versión del metacanon/metaprompt, revisión/huellas de fuentes y fixtures, modalidad mecánica/semántica/campo, entorno, capacidades disponibles, plataforma/modelo observado o desconocido, entradas efectivas, límites, resultado y evidencias. Registrar tiempos solo medidos y reloj usado; no inventar latencias de una conversación histórica. Conservar resultado esperado antes de ejecutar, salida real, adjudicación, incidentes y diferencias respecto del caso anterior. Datos inmutables por ejecución; correcciones como registros nuevos enlazados.

Estados por criterio: APROBADO, FALLIDO, NO_PROBADO, BLOQUEADO, NO_APLICA justificado. Los tres últimos no se cuentan como aprobación. Conservar denominadores: casos planeados, ejecutados y evaluables. No presentar solo el mejor intento ni confundir variantes deliberadamente incompletas del arnés con versiones históricas del marco.

## Indicadores y criterio de interpretación

| Dimensión | Indicador reproducible | Evidencia / límite |
| --- | --- | --- |
| Custodia literal | Turnos íntegros recuperados / turnos recibidos inventariados; separa operador y modelo. Informar faltantes y duplicados por ID. | Comparación literal o de bytes según el formato; hash de referencia, cobertura y transformaciones. No extrapola a mensajes nunca recibidos. |
| Contexto operativo | Criterios de retoma satisfechos / criterios aplicables de la rúbrica, con propósito, punto real, restricciones, pendientes y siguiente acción como obligatorios. | Cada criterio apunta a la fuente y a la salida evaluada; una coincidencia de palabras no prueba comprensión. |
| Gobierno | Restricciones aplicables satisfechas / restricciones aplicables evaluadas; discrepancias y permisos inventados identificados aparte. | Evidencia de fuente adquirida y conducta. Mostrar firma sin conducta no pasa. |
| Operaciones | Operaciones inciertas verificadas antes de actuar y número de efectos duplicados/no autorizados observados. | Registro previo y efecto posterior; ante efecto no verificable, BLOQUEADO, no cero asumido. |
| Intención → resultado | Requisitos materiales con cadena completa / requisitos materiales inventariados. Cadena: literal → interpretación → criterio aprobado → cambio → prueba → evidencia. | Distinguir cobertura documental y satisfacción. Un requisito con enlace pero incumplido no está satisfecho. |
| Fricción de retoma | Número de solicitudes de repetición de información ya recuperable, intervenciones humanas necesarias y tiempo medido hasta siguiente acción válida. | Excluir solo con razón registrada preguntas materiales legítimas; tiempo no disponible = NO_PROBADO. |

No fijar ahora un escalar de «delta semántico» ni pesos arbitrarios. Primero recuperar el marco existente de especificación y vectores semánticos; mientras tanto, documentar desviaciones observables por requisito: omisión, contradicción, ampliación no autorizada, resultado distinto o ausencia de evidencia. La meta de delta tendiente a cero es intención del operador, no una medición conseguida.

## Casos iniciales para preparar

1. Corte después de una decisión persistida; recuperación de pendientes y siguiente acción.
2. Tramo final no persistido: declarar la laguna, no fabricarlo.
3. Notion con gobierno automático antiguo; fuente accesible o inaccesible.
4. Otra plataforma sin gobierno instalado; repositorio privado sin conector y copia de procedencia conocida.
5. Operación incierta o ya realizada: no duplicar efectos.
6. Dos escritores o revisiones contradictorias; detener lo afectado y preservar ambos deltas.
7. Dictado con negación, corrección, repetición y propuesta no aprobada.
8. Pérdida de un pendiente expresamente diferido; detectar y conservarlo.
9. Salida que muestra una firma vigente pero actúa contra una restricción.
10. Cadena de trazabilidad con evidencia faltante o código no correspondiente: no darla por satisfecha.

Estos son casos especificados, NO ejecuciones. La batería mecánica existente permanece en ../continuidad/ensayo.py y su resultado histórico en ../continuidad/resultado.json; no se reejecutó en esta actualización.

## Orden de trabajo y aceptación

Primero conciliar originales/estado; después adquirir fuentes de especificación y el contrato de Harmonia; fijar fixtures y rúbrica; ejecutar la batería mecánica reproducible; realizar ensayo semántico independiente cuando las capacidades lo permitan; incorporar observaciones de campo autorizadas. No se presupone un servicio de modelos, proveedor de embeddings, almacenamiento, stack ni instalación.

La ausencia de efectos no autorizados, la preservación de restricciones y la honestidad sobre faltantes son compuertas, no aspectos compensables por una puntuación alta. No declarar éxito global si queda una compuerta fallida/no probada. Guardar resultados por versión y aceptar cambios por evidencia causal; no «iterar hasta perfección» sustituyendo pruebas reales por fixtures favorables.
