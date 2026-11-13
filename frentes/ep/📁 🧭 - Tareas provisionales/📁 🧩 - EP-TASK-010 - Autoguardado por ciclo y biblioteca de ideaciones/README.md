# EP-TASK-010 — Autoguardado por ciclo y biblioteca de ideaciones

**ID local:** EP-TASK-010  
**Estado:** `pendiente · WAITING_EP_VAULT_UNLOCK · BACKUP_ACCEPTANCE_PENDING`  
**Prioridad/secuencia:** Alta · núcleo persistente, integrado con EP-TASK-009  
**Frente propietario:** Entorno Persistente (EP)  
**Módulo:** MOD-EP-PRODUCT-DESIGN  
**OCP padre:** frentes/ep/OEP.md  
**Núcleo:** este README es la especificación y crónica acumulativa única de la tarea. No crea otro FT, OCP ni control.

## Enunciado ejecutivo

Conservar borradores, ideas parciales, desarrollos maduros y síntesis de Carson mediante guardado automático al completar cada ciclo de ideación. Crear o asociar automáticamente el proyecto, usar nombre descriptivo cuando el operador no lo aporte, aplicar etiquetas esenciales, conservar versiones y ofrecer una biblioteca indexada que permita buscar y reutilizar ideas sin romper la procedencia.

## 1. Fuente rectora — instrucción literal

**Fuente:** SRC-PD-20261113-IDEACION-03 · instrucción directa del operador · 2026-11-13.  
**Ubicación canónica:** MOD-EP-PRODUCT-DESIGN/SPRINT-GENERAL-PRODUCT-DESIGN.md §18.  
**Contenido literal completo:** se reproduce en EP-TASK-009 §1 y en el sprint §18. Este núcleo conserva a continuación los fragmentos que fundamentan directamente el alcance, sin presentarlos como sustituto del original:

~~~text
El autoguardado tipo Office y la biblioteca indexada no tiene que ser al carácter, sino por ciclo. Hacer un guardado básico del proyecto en curso autonombrándolo si el usuario no aporta alguna denominación y etiquetándolo de manera esencial. Es decir como es un módulo de lluvia de ideas, lo que yo estoy tratando de hacer es disponer de una persistencia de los borradores de las ideas que trabaje a veces de manera incompleta o poco finalizada, así como de las más maduras que también podré trabajar de manera profunda con la ayuda de la herramienta. Y disponer de estos diseños hasta el fin de los tiempos sin tener miedo a que se pierdan esas ideaciones.
~~~

## 2. Matriz de trazabilidad

| Requisito | Entrega | Criterio de aceptación |
|---|---|---|
| Guardado por ciclo, no por carácter | Escritor de ciclos transaccional | Cada tanda, pausa, transición o cierre genera un punto de guardado y no una escritura por carácter. |
| Conservar borradores y maduras | Registro estructurado con contenido íntegro | El contenido original de una idea se puede recuperar, incluso si está incompleto o contradicho después. |
| Proyecto automático | project.json con nombre y origen del nombre | Si el operador no aporta nombre, se genera uno legible desde tema/fecha sin preguntar. |
| Etiquetas esenciales | Tags simples | Tipo lluvia-de-ideas, tema/área y madurez; reusable solo cuando se marque expresamente. |
| Versiones | Ciclos inmutables y manifiesto atómico | Las versiones anteriores siguen recuperables; corregir crea nueva revisión, no destrucción. |
| Biblioteca | SQLite + FTS5 como índice derivado | Se busca por texto, nombre, resumen, etiquetas, tipo y proyecto. |
| Reutilización entre proyectos | Relaciones de referencia | El mismo ítem se puede enlazar a varios proyectos sin duplicar el original. |
| Durabilidad | Workspace EP protegido + backup cifrado | Read-back, integridad y restauración verificados; no se promete permanencia sin pruebas. |

## 3. Modelo mínimo aprobado para implementar

### 3.1 Proyecto

project.json: project_id local, title, title_origin (operator/automatic), created_at, updated_at, tags[], status y latest_version.

Nombre automático: título descriptivo derivado del tema y la fecha. Sin tema aún: «Ideación sin título — fecha». Renombrar agrega una nueva revisión del manifiesto.

### 3.2 Sesión

session.json: session_id local, project_id, topic, goal, agent=Carson, engine=bmad-brainstorming, mode, status (active/paused/completed), created_at, updated_at y last_saved_cycle.

### 3.3 Registro de ciclos

Cada archivo cycles/NNNNNN.json es inmutable e incluye: cycle_number, started_at, saved_at, stage, techniques[], items[], open_questions[], decisions[], links_to_previous[] y integrity.sha256. Cada item preserva item_id, type, full_text, author (operator/Carson), maturity (draft/developing/mature), reusable y provenance.

Un ciclo es una tanda de técnica(s), la transición divergencia→convergencia, una pausa/interrupción o cierre. En un guardado se consolida lo producido desde el ciclo previo. No se persiste carácter a carácter; tampoco se pierden ideas parciales al producir una síntesis.

### 3.4 Biblioteca

library.sqlite (SQLite FTS5) es derivado y reconstruible desde project.json, session.json y cycles/*.json. Indexa proyectos, sesiones e ítems; los filtros incluyen texto, tema/etiqueta, madurez, estado y proyecto. Las relaciones entre proyectos son referencias al ítem canónico, no copias independientes.

## 4. Ubicación y protección

Ruta lógica dentro de la bóveda Cryptomator del workspace EP:

SeryMente/Metodologia/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/data/<terminal>/brainstorming/

projects/<project-id>/project.json  
projects/<project-id>/sessions/<session-id>/session.json  
projects/<project-id>/sessions/<session-id>/cycles/000001.json  
library/library.sqlite

No escribir fuera del montaje protegido EP. No utilizar Desktop, Downloads, AppData, Temp ni otro perfil como almacenamiento provisional. El respaldo remoto solo reutiliza la política EP de cifrado del lado cliente; no añadir un proveedor o sistema paralelo.

## 5. Integridad, versiones y recuperación

1. Generar el archivo del ciclo en staging dentro del workspace protegido.
2. Serializar de forma determinista, hacer flush/fsync y calcular SHA-256.
3. Promover atómicamente el ciclo inmutable y leerlo de vuelta.
4. Actualizar session.json/project.json mediante reemplazo atómico, conservar revisión previa y volver a leer.
5. Actualizar/reconstruir library.sqlite después de verificar las fuentes. El índice no puede invalidar ni reemplazar un ciclo.
6. Reanudar leyendo manifiestos y reproduciendo ciclos desde el último válido.
7. Una corrección es una nueva revisión/evento; nunca se borra el contenido original ni se reescribe un ciclo guardado.
8. Copia remota: solo ciphertext cliente-cifrado, con confirmación de subida, lectura de vuelta y prueba de restauración.

El objetivo es conservación a largo plazo; la frase «hasta el fin de los tiempos» expresa la intención, no una garantía técnica absoluta. La aceptación exige una copia protegida y un respaldo independiente recuperable, custodia de claves y pruebas periódicas de restauración.

## 6. Resultado de viabilidad observado

- Python sqlite 3.11.9 en CENTRAL\fila4 reporta SQLite 3.45.1.
- Prueba en memoria: creación de tabla virtual FTS5, inserción y consulta por término: PASS.
- Esta prueba no crea la base de biblioteca ni acredita persistencia en disco.
- RDC identificó dos conexiones al host de nombre PC10RCIF4EI4: device UUID 5182a6bc-db2c-452e-a52a-95d63f6c74d6 corresponde a CENTRAL\fila4 y UUID 952ad493-0a54-48a8-b0a2-de7aba24b0e4 a CENTRAL\MantenimientoRCI. No son dos equipos físicos verificados. Este diseño no necesita la identidad administrativa.
- La bóveda Cryptomator está bloqueada en la observación de este ciclo: W: solo muestra System Volume Information; los archivos cifrados existen bajo C:\Users\fila4\entorno-persistente. No se ha escrito ninguna ideación allí ni fuera del perímetro protegido.
- EP-TASK-002 (backup remoto) y la disponibilidad del workspace protegido siguen como dependencias. No se ha probado un restore de datos Product Design.

## 7. Dependencias y bloqueos

- Workspace EP desbloqueado y montado bajo identidad autorizada CENTRAL\fila4.
- Cumplimiento de OEP §§137–138 (confinamiento de datos).
- Mecanismo de backup del EP aceptado, especialmente EP-TASK-002.
- Integración con Carson de EP-TASK-009.

No crear almacenamiento paralelo, no almacenar ideaciones en GitHub en claro y no confundir el índice FTS5 con una copia de seguridad.

## 8. Criterios de aceptación

- Guardado de ciclos verificado tras tanda, pausa, transición y cierre.
- Prueba de borrador incompleto conservado y recuperado.
- Proyecto auto-nombrado y etiquetado sin pedir intervención al operador.
- Restauración de versión anterior sin perder la actual.
- Búsqueda FTS5 en contenido, nombres y etiquetas.
- Ítem referenciado desde dos proyectos sin duplicación ni pérdida de procedencia.
- Reconstrucción del índice desde los ciclos fuente.
- Fallo de escritura simulado: el asistente no afirma guardado, el último ciclo válido se mantiene.
- Backup cifrado del lado cliente, read-back remoto y prueba real de restauración.

## 9. Crónica acumulativa

### Ciclo de diseño y viabilidad preliminar · 2026-11-13

- Fuente: SRC-PD-20261113-IDEACION-03.
- Se fijó el guardado por ciclo, no por carácter. El ciclo comprende una tanda, transición de fase, pausa/interrupción o cierre.
- Se redujo el modelo a proyecto, sesión y ciclo; biblioteca SQLite FTS5 derivada y reconstruible.
- Se verificó FTS5 en memoria con Python/SQLite bajo CENTRAL\fila4. No se creó base de datos.
- Se confirmó que los datos del módulo deben residir dentro del workspace Cryptomator según OEP §§137–138. La bóveda estaba bloqueada y no se escribió ningún archivo de ideaciones.
- Dependencia de backup EP-TASK-002 y aceptación de restauración no resueltas.
- Estado: diseño funcional listo; implementación local pendiente del desbloqueo EP Vault y los gates de persistencia remota.
