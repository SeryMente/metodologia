# Salida final · Taxonomía conceptual, infraestructura y Tareas

La distinción queda incorporada al DUG canónico. **Ámbitos** permanece como categoría taxonómica conceptual; la infraestructura describe por separado la manera en que esas entidades se materializan en GitHub. No hay equivalencia obligatoria uno-a-uno entre categoría conceptual y directorio.

## Fuente canónica actualizada

- **DUG:** v359 · NX-359m
- **Metacanon:** 1.24
- **GOW:** 2.8 · 109 términos
- **Taxonomía estructural:** 1.3
- **Principios/anexos:** 41/16, sin cambios

Se han actualizado [ART-015](https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), ART-019, ART-020 y ART-021, además de Metacanon §§46/51, la proyección estructurada y el GOW. La fuente canónica es el mismo HTML del DUG; no se crearon documentos normativos paralelos.

## Cómo queda la taxonomía

Dentro de la categoría conceptual **Ámbitos**, el canon distingue tres elementos, pero no del mismo tipo:

1. **Persistencia documental:** ámbito funcional transversal.
2. **Gestión conversacional:** ámbito funcional transversal al mismo nivel.
3. **Propósito:** elemento conceptual canónico asociado al alcance de un frente; no una tercera función transversal.

**Propósito** es el enunciado compacto, autocontenido, que explica para qué existe un FT y delimita su alcance. Puede ser un archivo de texto en la raíz del OCP del frente o una sección identificada en un documento raíz. No necesita carpeta propia.

Por eso **no se exige un directorio `ambitos/` dentro de cada repositorio OCP**. Un directorio dedicado se justifica por los materiales, la necesidad de control/continuidad y la recuperabilidad, no por la simetría de la taxonomía. `ambitos/tareas/` permanece como la materialización provisional del diseño Tareas, que contiene varias piezas de trabajo; no se convierte en patrón obligatorio.

## Tareas: estándar reutilizable recomendado

Sí: conviene definir un **contrato común de tarea** antes de desplegar perfiles por ámbito. Ya dejé un borrador v0.1 con:

- [Estándar común de tarea v0.1](https://github.com/SeryMente/metodologia/blob/main/ambitos/tareas/ESTANDAR-COMUN-DE-TAREA-v0.1.md)
- [Esquema JSON candidato](https://github.com/SeryMente/metodologia/blob/main/ambitos/tareas/ESQUEMA-TAREA-COMUN-v0.1.json)
- [Diseño Tareas v1.0](https://github.com/SeryMente/metodologia/blob/main/ambitos/tareas/DISEÑO-TAREAS-v1.0.md)
- [Instrucciones operativas Tareas v1.0](https://github.com/SeryMente/metodologia/blob/main/ambitos/tareas/INSTRUCCIONES-TAREAS-v1.0.md)

El contrato propuesto unifica identidad, procedencia, estado, alcance, resultado esperado, aceptación, responsable explícito, siguiente acción, dependencias, bloqueos, fechas y evidencia. Los ámbitos futuros pueden añadir extensiones específicas, pero sin redefinir los campos comunes. El estándar y su esquema son **candidatos en incubación**, no normas de producción; no se ha escogido plataforma de persistencia ni se ha probado una tarea real extremo a extremo.

## Verificación y siguiente paso

El DUG se releyó de vuelta, su JSON parsea, el JavaScript operativo compila sintácticamente en aislamiento y la capa HTML estática contiene 27 IDs sin duplicados. No se ejecutó el renderizado en navegador ni la auditoría dinámica completa de enlaces. El campo nativo IPZ tampoco se modificó ni verificó.

El siguiente ciclo de Tareas debe validar propósito, fronteras y contrato común con dos o tres casos reales autorizados de naturaleza diferente. La incorporación de Tareas como ámbito funcional canónico requiere una decisión y autorización específicas posteriores.

## Registro y continuidad del ciclo

- [Crónica](../cronica/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01.md)
- [Evidencia y lecturas de vuelta](../evidencias/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01.json)
- [Diálogo del ciclo](../conversaciones/C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01-dialogo.jsonl)

El estándar de tarea reutilizable queda documentado como ciclo aparte de Tareas: [crónica](../../../../ambitos/tareas/cronica/C-TAREAS-ESTANDAR-REUTILIZABLE-01.md) · [evidencia](../../../../ambitos/tareas/evidencias/C-TAREAS-ESTANDAR-REUTILIZABLE-01.json) · [salida](../../../../ambitos/tareas/entregas/CHATGPT-v1.0/C-TAREAS-ESTANDAR-REUTILIZABLE-01-salida-final.md). Su estado es candidato v0.1, no norma canónica.
