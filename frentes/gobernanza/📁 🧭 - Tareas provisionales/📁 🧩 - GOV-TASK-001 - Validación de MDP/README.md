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
