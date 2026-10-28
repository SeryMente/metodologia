# Pendientes · Frente Gobernanza

## Estado operativo actualizado · C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20 · 2026-10-28

Los estados iniciales correspondían a la lectura de Samantha v345. Su redacción anterior permanece en el historial Git de este archivo; los puntos siguientes expresan el estado vigente observado.

1. **GOV-JSON-01 · CERRADO para DUG v352.** El bloque `gov-data` del blob `94473eccb6fa71303d5908ce678f7efeb191c215` pasa `JSON.parse` y contiene 41 principios y ocho anexos. Esto cierra el defecto histórico de parseo observado en v345; no certifica ejecución en navegador ni toda la integridad funcional.
2. **GOV-ART-01 · CERRADO respecto a la identidad del anexo.** ART-014 existe en el DUG v352 como “Sistema de Persistencia Documental de Frentes (SPDF)” y contiene las reglas de captura, custodia y recuperación. La colisión histórica con ART-012/ART-013 queda resuelta en el estado actual. No se modificó el contenido normativo del DUG en este ciclo.
3. **GOV-NAV-01 · CERRADO en los tres puntos de entrada inspeccionados.** Se actualizaron y releyeron `INICIO.md`, `frentes/metacanon/README.md` e `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt`; los enlaces activos ahora dirigen al DUG HTML y sus anclas integradas. El cierre corresponde a esos archivos, no a una auditoría global del repositorio.
4. **GOV-RDC-01 · ABIERTO.** Conservar el comando PowerShell original de RDC y validar sintaxis/función antes de declarar que está listo. No ejecutar el comando por el mero hecho de documentarlo; cualquier corrección candidata debe quedar separada del literal.
5. **GOV-IPZ-01 · PARCIAL.** El archivo IPZ fue actualizado y leído de vuelta (1479 caracteres). Las herramientas no exponen escritura y lectura del campo nativo de Instrucciones Personalizadas; su instalación permanece NO VERIFICADA.
6. **GOV-LINK-01 · PARCIAL / ABIERTO.** Se comprobaron el parseo JSON, la compilación sintáctica aislada del JavaScript, cero IDs estáticos duplicados, las definiciones de ancla para P041/ART-014 y los registros `gow-spdf`, `gow-spd` y `gow-dug`. No se ejecutó el renderizador ni la auditoría dinámica de enlaces internos y retornos; la auditoría funcional integral sigue abierta.
7. **GOV-SPDF-E2E-01 · BLOQUEADO por insumo no disponible.** No hay un archivo adjunto real en esta conversación que pueda capturarse preservando los bytes/contenido originales. No se fabricó un archivo de prueba ni se simuló captura. La prueba completa —captura real, escritura en OCP, manifiesto, cotejo y recuperación por otra instancia autorizada— queda pendiente hasta disponer de un original real y de un segundo lector autorizado verificable.

## Restricciones heredadas

- El único documento normativo es `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`; este OCP registra estado operativo y no es una fuente normativa paralela.
- No alterar contenido normativo sustantivo de Samantha ni el GOW sin autorización expresa.
- No crear anexos ni cambiar IDs en presencia de colisiones sin resolverlas.
- No ejecutar ni consultar GitHub Actions/workflows.
- No afirmar renderizado de navegador si no se prueba.
- No afirmar que el campo nativo de IPZ está actualizado sin escritura y verificación reales.
- El OCP de Metacanon permanece en `frentes/metacanon/`.
