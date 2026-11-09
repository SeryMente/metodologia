# 📝 GOV-TASK-001 · Validación de microdescriptores de pertinencia

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-001`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Validar los 43 MDP para comprobar que permiten reconocer el significado y la señal de activación, pero no bastan para aplicar íntegramente el principio sin consultar su texto desarrollado en Sink.

## Referencia de origen

DUG v373 · ART-027; diseño originado en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límites

DUG v373 y acceso de lectura a la fuente canónica; no inventar reglas ni alterar principios.

## Siguiente actuación

Contrastar los MDP con entradas representativas y ajustar solo aquellos que no permitan reconocer la pertinencia o que revelen demasiado detalle operativo.

## Comprobación estructural inicial · lectura de DUG v373

- 43 IDs de principio únicos.
- 43 MDP en la tabla humana y 43 campos `microdescriptor` en `gov-data`.
- Coincidencia literal de los 43 MDP entre ambas representaciones.
- Longitud mínima 11 y máxima 16 palabras; cero descriptores fuera del rango.

**Alcance de esta comprobación:** valida identidad, sincronización y extensión; no demuestra por sí sola que cada MDP identifique correctamente todos los casos de pertinencia ni que su insuficiencia deliberada esté bien calibrada. Se requieren pruebas semánticas con entradas variadas.


## Matriz semántica de prueba

Se creó [MATRIZ-PRUEBAS-MDP-v1.md](./MATRIZ-PRUEBAS-MDP-v1.md), con 43 entradas positivas (una por principio), ocho controles negativos/de frontera y criterios para exigir Sink antes de aplicar. El archivo es un protocolo de prueba, no evidencia de ejecución. Pendiente ejecutar los casos en una vista inicial MDP-only y registrar falsos positivos y negativos; Sink aún no está desplegado.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.


## Vector vigente · C-GOBERNANZA-VECTOR-SEMANTICO-01 · 2026-10-31

Además de la matriz semántica existente, verificar la forma compacta del nombre expuesto al modelo: `Principio DI · [1–3 términos atómicos]`. Debe existir mapeo inequívoco de cada etiqueta a su ID y título canónico del DUG, sin reescribir el título normativo. Validar los 43 MDP con positivos/negativos: el descriptor debe permitir comprender el principio y detectar pertinencia, pero no reemplazar el texto desarrollado ni habilitar aplicación segura sin consultarlo. La matriz actual es un protocolo de prueba, no evidencia de que ya se ejecutó.

Trazabilidad rectora: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).


## Rebaselining para el sprint Sink local · 2026-11-09

**DUG vigente:** Samantha v385 · NX-385m; commit `7dcdac6c62f9e8a27ce11f8fa0e4fc379a3d12f8`; blob `72cd2e8e4e6a594b300ba1868baeabc2472beb97`. Las referencias a DUG v373 de los apartados anteriores son procedencia histórica, no pins vigentes.

La matriz `MATRIZ-PRUEBAS-MDP-v1.md` sigue siendo un protocolo pendiente de ejecución: 43 positivos + 8 controles negativos/frontera. Durante el sprint se ejecutará contra los 43 MDP de v385 y el catálogo Sink local; se registrarán por caso ID/título/resultado y falsos positivos/negativos. La aprobación semántica no autoriza aplicar el principio solo con el MDP: si hay pertinencia, debe consultarse el texto desarrollado mediante `SINK:Pxxx` y validar su identidad/hash. Muestra vertical inicial recomendada: P004; smoke ampliado P001/P004/P005/P038/P043.


## Baseline del sprint · Samantha v386 · 2026-11-09

Fuente de validación: DUG `Samantha v386 · NX-386m`, blob `22dca684830a36dff019b47811d9b800cc9bea0a`, leído desde `main` en el head `82843bca9493a522405d840393c229d2af363342`. Ejecutar la matriz existente (43 positivos + 8 negativos/frontera) contra los 43 MDP de esa revisión. No editar el DUG ni los principios desde esta tarea. Cada resultado identifica caso, ID, título, entrada, expectativa, resultado observado y evidencia. Si resulta pertinente, exigir recuperación `SINK:Pxxx` y cotejo de ID/título/pin/hash antes de aplicar el principio. La matriz es protocolo hasta que existan resultados ejecutados y leídos de vuelta.
