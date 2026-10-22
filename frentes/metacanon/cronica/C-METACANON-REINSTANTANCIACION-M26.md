# Crónica · C-METACANON-REINSTANTANCIACION-M26

**Fecha local:** 2026-10-22 (America/Mexico_City).  
**Folio de ciclo declarado:** `C-20261022-D49F7B2C`; unicidad global NO VERIFICADA.  
**Frente:** Metacanon · **sesión activa:** `SES-20261022-5E7C91A4`, generación 4.  
**Repositorio canónico:** `SeryMente/metodologia`, rama `main`.  
**Gobierno:** Sam v339 · NX-339m; Metacanon v1.21 · `METACANON-OBJETOS-v1.21`; GOW v2.2. `MCP-NORMATIVO: DESACTIVADO`.

## Instrucciones y autorización

El prompt de reinstanciación M25 se conserva verbatim en [diálogo JSONL](../conversaciones/C-METACANON-REINSTANTANCIACION-M26-dialogo.jsonl), junto con la respuesta de autorización `Si`. Se preserva la procedencia y no se reconstruye el texto de la instrucción.

## Transferencia de responsabilidad

El control se releyó antes de escribir. La base coincidía con SHA `1d857624215d8825e784e0ffed671213b2f0271a`, titular `SES-20261021-6B9E2F41`, generación 3, estado `owned`. La respuesta afirmativa del operador autorizó únicamente Metacanon.

- Generación 3 → 4; folio nuevo `SES-20261022-5E7C91A4`.
- Alias operativo: `chatgpt-C-METACANON-REINSTANTANCIACION-M26-SES-20261022-5E7C91A4`; no es un ID nativo.
- Transferencia condicionada y read-back: commits `8d66c696354858d28cffe4c1f64ac33db1e3fe4d` y `edec79c1259382e71debb4cfa5849ea7cb590c46`.
- Corrección/read-back del alcance de colisiones: commit `c71f9c421325a9d8aa471b5d6bd79b9f11caf54b`; SHA del control leído de vuelta `8f9d04b86114e0e7fe47e6c6977c8ce6a9d047c7`.
- La búsqueda de código preescritura devolvió cero resultados y un barrido directo posterior de cuatro controles hermanos legibles no encontró otra aparición del folio. No se afirma unicidad global ni fencing universal.

## Trabajo técnico y cambios

La lectura directa en `main` mostró:
1. `scripts/bootstrap-entorno-persistente.ps1`: alcance mixto EP/CIBERCAFE; crea estado `CIBERCAFE/<PC-N>`, copia el propio script bajo `<WorkRoot>\scripts`, y descarga/valida el CLI de CIBERCAFE por commit/hash fijados, ejecutándolo con `-PrepareOnly`.
2. `scripts/bootstrap-entorno-persistente-ep.ps1`: contrato Fila4 distinto; exige identidad elevada `MantenimientoRCI`, perfil único y `WorkRoot` dentro del perfil, por defecto `Desktop\EP`.
3. `scripts/bootstrap-cibercafe-cli.ps1`: documentado como canónico en `CIBERCAFE/PC-4/ESTADO.md`; valida `Desktop\metodologia` y exige la ruta exacta `scripts\bootstrap-cibercafe-cli.ps1`.

La búsqueda de código conectada no halló coincidencias para los tres nombres; como su cobertura/indexación no está verificada, el cero no demuestra ausencia de consumidores. No se obtuvo inventario exhaustivo de invocadores. Ninguno de los tres scripts se movió ni consolidó.

- Inventario central actualizado: commit `731e2702419f33f21c7b369fd4b956fd8d1f0ab4`; read-back blob `910299b1ddeaa2c85f433f4e39a1d11d175f8b03`.
- Pendientes actualizados: commit `d94f3c8ff0f18d3b2a3430d40c82a5b8a5a6f0a8`; read-back blob `086f0628dc7e9c2d0c59d9d2dfe51dbb92ffe8d1`.
- Los fallos históricos de CI conservan causa `NO VERIFICADA`. No se ejecutaron ni consultaron workflows ni jobs.

## Lo que queda abierto

- Invocadores externos EP/CIBERCAFE, rutas de distribución y pruebas: no exhaustivamente verificados.
- Clasificación/migración del sprint GDP: pendiente; no movido.
- Clasificación formal de `SeryMente/tercer-ambito/etica/`: pendiente; no movida.
- Cobertura de repositorios de la organización: sigue limitada al alcance accesible del corte M25.

## Gobierno preservado

Sam, GOW y el canon Metacanon no fueron modificados. El repositorio conserva el nombre `SeryMente/metodologia`; el OCP sigue en `frentes/metacanon/` y las rutas heredadas se conservaron. No se tocó código de producto.
