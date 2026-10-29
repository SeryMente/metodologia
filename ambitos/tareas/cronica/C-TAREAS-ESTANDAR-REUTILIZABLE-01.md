# Crónica · C-TAREAS-ESTANDAR-REUTILIZABLE-01

**Fecha:** 2026-10-28  
**Ciclo:** C-20261028-8B4D930F  
**Sesión de Tareas:** SES-20261028-TA6F31C9 · generación 1  
**Estado:** ESTÁNDAR CANDIDATO v0.1 MATERIALIZADO Y RELEÍDO; NO CANONIZADO.

## 1. Encargo

El operador pidió separar taxonomía conceptual e infraestructura, canonizar Propósito como elemento conceptual declarativo asociado al alcance de un FT, documentar que ese enunciado puede ser un archivo o una sección raíz sin directorio propio, continuar con Tareas y evaluar el uso de un molde común reutilizable entre ámbitos. La parte de gobernanza se ejecutó bajo su autorización expresa en el ciclo C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01; esta crónica se centra en la decisión de diseño de tareas.

## 2. Recomendación

Conviene un estándar compartido siempre que se defina como **contrato mínimo semántico** y no como formulario rígido. Se distinguen tres cosas:
- el estándar común que define qué datos e invariantes conserva una tarea;
- los perfiles de dominio, que extienden el contrato cuando el ámbito necesita campos o reglas propias;
- el subsistema Tareas, que coordina el ciclo de vida, registro y seguimiento de tareas.

Este diseño permite interoperabilidad conceptual sin imponer una única plataforma, estructura de directorios ni herramienta de gestión a todos los ámbitos.

## 3. Artefactos

- `ESTANDAR-COMUN-DE-TAREA-v0.1.md`: definición semántica del contrato compartido, invariantes, modelo de datos candidato, ciclo de vida, extensión por dominio, persistencia/interoperabilidad y criterios de aceptación.
- `ESQUEMA-TAREA-COMUN-v0.1.json`: proyección técnica del contrato, con estados y validaciones condicionales candidatas.
- `README.md` y `PENDIENTES.md`: enlaces de entrada y registro del ciclo.

## 4. Modelo común candidato

El contrato contempla identidad estable, título accionable, procedencia, alcance/contexto, estado, resultado esperado, criterios de aceptación, responsable y prioridad únicamente cuando están confirmados, fecha límite explícita, siguiente acción, relaciones tipadas, bloqueos, referencias de evidencia, marcas temporales y extensiones con espacio de nombres.

Una tarea capturada puede estar incompleta; no se exige que todos los campos existan al inicio. Antes de pasar a definida o ejecutarse, necesita resultado y aceptación suficientes. El cierre exige verificar criterios según el caso. Un perfil de ámbito puede ampliar el modelo, pero no redefinir los campos comunes.

## 5. Estado y pruebas

El archivo JSON se leyó de vuelta y pasó `JSON.parse`. No se ejecutó todavía un validador de JSON Schema compatible con 2020-12, tampoco se validaron casos de estado mediante un ejecutor ni se realizó una prueba end-to-end con tareas reales. No se eligió plataforma de estado ni se creó registro vacío. El contrato sigue siendo CANDIDATO v0.1.

## 6. Próximo paso

Validar dos o tres casos representativos autorizados de distinta naturaleza antes de elevar el contrato a v1.0. Evaluar cada campo con criterios de necesidad, claridad, procedencia, verificabilidad e interoperabilidad; retirar el exceso. Solo después decidir qué parte puede promoverse a estándar metodológico y qué perfiles deben seguir siendo locales.
