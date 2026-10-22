<callout icon="🧭" color="blue_bg">
<b>Estado: CANÓNICO · PORTABLE · VINCULANTE.</b><br />Este protocolo convierte el registro de errores en un motor preventivo de decisión. Su propósito no es «documentar fallos», sino reducir cada objetivo general a <b>una sola intervención del operador</b> siempre que las dependencias reales lo permitan, sin sacrificar calidad, seguridad, trazabilidad ni reversibilidad.
</callout>

Página matriz: <mention url="https://app.notion.com/p/7e0a41878241826cb2c781aa2ebd5070">Registro Canónico de Errores de Terminal · Khora</mention>

## 1. Resultado ideal

Para cada objetivo general, el agente debe entregar un único artefacto o invocador que ejecute:

```txt
inventario → preflights → recuperación permitida → mutación → verificación cruzada → evidencia final
```

La unidad de optimización no es «el siguiente comando», sino el <b>objetivo completo con evidencia terminal</b>.

### Indicador principal

<code>ciclos humanos por objetivo general</code>

- Ideal: <code>1</code>.
- Aceptable por dependencia externa genuina: <code>2</code>.
- Más de <code>2</code>: exige análisis de recurrencia y promoción de un nuevo guardarraíl.
- Nunca se reduce el número de ciclos ocultando riesgo, omitiendo verificación o declarando éxito por intención.

## 2. Principios no negociables

1. <b>El registro es ejecutable conceptualmente:</b> cada error debe cambiar una decisión futura.
2. <b>No repetir una clase de fallo:</b> el segundo caso equivalente debe ser interceptado antes de la ejecución.
3. <b>Preflight antes de cirugía:</b> una dependencia roja bloquea mutaciones posteriores.
4. <b>Una sola superficie para el operador:</b> preferir archivo versionado/descargable más invocador mínimo.
5. <b>La orquestación también se valida:</b> no basta con compilar payloads internos; rutas, shells, working directory y ejecutables son parte del programa.
6. <b>Estado explícito:</b> todo aborto debe indicar qué cambió, qué no ocurrió y desde dónde reanudar.
7. <b>Éxito con evidencia doble:</b> respuesta satisfactoria más comprobación del efecto persistido.
8. <b>Agresividad segura:</b> paralelizar lo independiente y encadenar lo dependiente; nunca confundir rapidez con ausencia de compuertas.

## 3. Contrato de datos del registro

Cada entrada debe contener, explícita o inferiblemente, los siguientes campos:

<table fit-page-width="true" header-row="true">
<tr>
<td>
Campo
</td>
<td>
Función operativa
</td>
<td>
Regla
</td>
</tr>
<tr>
<td>
<b>Objetivo</b>
</td>
<td>
Hito general que se intentaba cerrar
</td>
<td>
No registrar errores sin contexto de objetivo
</td>
</tr>
<tr>
<td>
<b>Fase</b>
</td>
<td>
inventario · preflight · preparación · mutación · verificación · entrega
</td>
<td>
Permite ubicar la compuerta faltante
</td>
</tr>
<tr>
<td>
<b>Componente</b>
</td>
<td>
PowerShell · Python · Node · PostgreSQL · Neo4j · proveedor · red · CI
</td>
<td>
Clave primaria semántica
</td>
</tr>
<tr>
<td>
<b>Síntoma verbatim</b>
</td>
<td>
Texto exacto y código HTTP/exit code
</td>
<td>
No parafrasear la evidencia primaria
</td>
</tr>
<tr>
<td>
<b>Huella</b>
</td>
<td>
Componente + fase + clase de excepción + recurso
</td>
<td>
Normalizar PID, rutas temporales y timestamps
</td>
</tr>
<tr>
<td>
<b>Causa</b>
</td>
<td>
confirmada · probable · abierta
</td>
<td>
No presentar hipótesis como causa confirmada
</td>
</tr>
<tr>
<td>
<b>Impacto</b>
</td>
<td>
archivos, procesos, datos y servicios alcanzados
</td>
<td>
Incluir siempre «qué no se ejecutó»
</td>
</tr>
<tr>
<td>
<b>Corrección</b>
</td>
<td>
Acción inmediata
</td>
<td>
Debe ser reanudable e idempotente
</td>
</tr>
<tr>
<td>
<b>Guardarraíl</b>
</td>
<td>
Prevención automatizable
</td>
<td>
Debe bajar al artefacto o plantilla
</td>
</tr>
<tr>
<td>
<b>Verificación</b>
</td>
<td>
Evidencia que cerrará el error
</td>
<td>
Un error sin verificación queda abierto
</td>
</tr>
<tr>
<td>
<b>Recurrencia</b>
</td>
<td>
Número de huellas equivalentes
</td>
<td>
Activa escalamiento automático
</td>
</tr>
</table>

## 4. Huella y recuperación inteligente

### Huella normalizada

```txt
fingerprint = componente / fase / excepción-o-código / recurso-estable / operación
```

Ejemplos:

- <code>powershell/preflight/CommandNotFound/tsx/primer_vinculo</code>
- <code>voyage/resolución/http-429/embeddings/incrustar</code>
- <code>neo4j/startup/tcp-timeout/7687/verify_connectivity</code>
- <code>node/preflight/parser-error/node-e/sql-probe</code>

Se eliminan de la huella: PID, GUID temporales, hora, líneas decorativas y rutas de logs efímeras.

### Ranking de antecedentes

Antes de planificar, puntuar entradas candidatas:

```txt
+5 mismo componente
+5 misma clase de error/código
+4 misma fase
+4 mismo recurso estable
+3 mismo sistema operativo/shell
+2 mismo objetivo
+2 recurrencia previa
+1 reciente
-5 causa posteriormente refutada
-3 tecnología o ruta retirada
```

Se leen primero las entradas con mayor puntuación; no se recita todo el registro.

## 5. Algoritmo MOTOR-1C

### Paso 0 · Definir el cierre

Escribir antes de cualquier herramienta:

- objetivo general;
- evidencia mínima de éxito;
- evidencia persistida secundaria;
- operaciones potencialmente destructivas;
- límite de tiempo y reintentos.

Si la evidencia final no está definida, no existe plan ejecutable.

### Paso 1 · Consultar el registro

1. Buscar huellas por componente, fase y recurso.
2. Recuperar correcciones ya verificadas.
3. Identificar guardarraíles obligatorios.
4. Marcar caminos refutados para no repetirlos.
5. Detectar si el objetivo ya tiene un artefacto reutilizable.

### Paso 2 · Construir el DAG

Clasificar cada paso:

- <b>P0 independiente:</b> inventarios y verificaciones que pueden ejecutarse en paralelo.
- <b>P1 compuerta:</b> su fallo impide toda mutación posterior.
- <b>P2 preparación:</b> genera artefactos reversibles.
- <b>P3 mutación:</b> cambia código, procesos o datos.
- <b>P4 verificación:</b> comprueba resultado primario y persistencia.
- <b>P5 recuperación:</b> solo se activa ante una huella conocida y acotada.

Regla: ejecutar juntos los P0; encadenar P1→P2→P3→P4; P5 nunca puede ocultar un fallo desconocido.

### Paso 3 · Ejecutar la matriz de preflight

<table fit-page-width="true" header-row="true">
<tr>
<td>
Capa
</td>
<td>
Preflight mínimo
</td>
<td>
Bloquea
</td>
</tr>
<tr>
<td>
Archivos
</td>
<td>
existencia, ruta canónica, permisos, hash opcional
</td>
<td>
Preparación
</td>
</tr>
<tr>
<td>
Orquestador
</td>
<td>
shell, working directory, quoting, ejecutables con <code>Test-Path</code>/<code>Get-Command</code>
</td>
<td>
Toda ejecución
</td>
</tr>
<tr>
<td>
Sintaxis
</td>
<td>
compilador/checker nativo de cada runtime
</td>
<td>
Mutación
</td>
</tr>
<tr>
<td>
Proceso local
</td>
<td>
listener único, PID y command line esperados, health acotado
</td>
<td>
Llamadas locales
</td>
</tr>
<tr>
<td>
Red
</td>
<td>
DNS + TCP por puerto con timeout explícito, sin UI ambigua
</td>
<td>
Servicios cloud
</td>
</tr>
<tr>
<td>
Credenciales
</td>
<td>
presencia y alias; nunca revelar valores
</td>
<td>
Autenticación
</td>
</tr>
<tr>
<td>
Proveedor
</td>
<td>
modelo existente, endpoint correcto, cuota/rate limit
</td>
<td>
Pipeline
</td>
</tr>
<tr>
<td>
Datos
</td>
<td>
fila/objeto fuente, versión, hash e idempotency key
</td>
<td>
Mutación
</td>
</tr>
</table>

### Paso 4 · Generar un solo artefacto

El artefacto debe ser:

- autocontenido;
- idempotente o protegido contra repetición;
- con rutas resueltas desde una raíz comprobada;
- sin código complejo en <code>node -e</code> o <code>python -c</code>;
- con payloads temporales en el directorio que conserva resolución de módulos;
- con respaldos antes de edición;
- con limpieza en <code>finally</code>;
- con marcadores de fase legibles;
- capaz de imprimir el log relevante cuando falla;
- capaz de retomar desde el último hito seguro.

### Paso 5 · Validar el artefacto antes de entregarlo

Validación obligatoria por capas:

1. <b>Payload:</b> checker/compilador de cada lenguaje.
2. <b>Orquestación:</b> rutas, variables, quoting y directorio de trabajo.
3. <b>Dependencias:</b> ejecutables y módulos realmente disponibles.
4. <b>Control de flujo:</b> exit codes, excepciones, <code>finally</code>, rollback.
5. <b>Prueba negativa:</b> simular al menos un recurso ausente y confirmar SAFE\_STOP.
6. <b>Prueba de repetición:</b> una segunda ejecución no debe duplicar datos ni corromper estado.

Si el entorno del operador no está disponible para validar una ruta, el artefacto debe validarla en runtime antes de mutar.

### Paso 6 · Ejecutar con recuperación acotada

Permitido automáticamente:

- reintento de red con backoff y máximo explícito;
- reinicio de un proceso solo si PID/command line coinciden;
- renovación de health después de un reinicio verificado;
- reanudación desde respaldo o checkpoint conocido.

Prohibido automáticamente:

- cambiar credenciales;
- desactivar seguridad;
- matar procesos desconocidos;
- repetir una mutación sin idempotency key;
- sustituir proveedores o modelos sin decisión explícita;
- reinterpretar un error desconocido como transitorio.

### Paso 7 · Cerrar con evidencia doble

Ejemplos:

- API <code>200</code> + fila persistida;
- ingesta <code>ok</code> + conteos/identificadores en Neo4j;
- despliegue exitoso + health remoto;
- archivo generado + parser/lector independiente;
- commit creado + diff esperado y working tree conocido.

Sin evidencia secundaria, el estado es «ejecutado, no verificado».

### Paso 8 · Retroalimentar el registro

Después de cada ciclo:

- si tuvo éxito, cerrar errores relevantes y registrar la evidencia;
- si falló, crear una sola entrada por causa real, no por cada síntoma derivado;
- promover el guardarraíl al artefacto;
- actualizar la huella y recurrencia;
- conservar el punto exacto de reanudación;
- decidir si el artefacto pasa a plantilla portable.

## 6. Escalamiento por recurrencia

<table fit-page-width="true" header-row="true">
<tr>
<td>
Frecuencia
</td>
<td>
Respuesta obligatoria
</td>
</tr>
<tr>
<td>
Primera
</td>
<td>
Diagnóstico, impacto y corrección acotada
</td>
</tr>
<tr>
<td>
Segunda huella equivalente
</td>
<td>
Automatizar preflight/guardarraíl; prohibido repetir comando desnudo
</td>
</tr>
<tr>
<td>
Tercera
</td>
<td>
Revisión arquitectónica; retirar el camino operativo que reincide
</td>
</tr>
<tr>
<td>
Cuarta o más
</td>
<td>
Incidente sistémico; detener expansión funcional hasta eliminar la clase
</td>
</tr>
</table>

Los errores derivados en cascada se agrupan bajo la primera causa causal. Esto evita inflar el registro sin perder evidencia.

## 7. Política de comandos mínimos

### Regla del invocador

El operador debería copiar como máximo una línea corta:

```powershell
& 'ruta\artefacto-validado.ps1'
```

El invocador nunca contiene lógica de negocio ni código de otro runtime.

### Cuándo sí dividir un ciclo

Solo cuando exista:

- intervención humana externa inevitable;
- MFA/CAPTCHA/aprobación;
- propagación o espera cloud no acotable;
- cambio de red o dispositivo;
- decisión irreversible que requiera confirmación;
- evidencia nueva que invalide el DAG.

La división debe indicar exactamente el checkpoint y el único dato pendiente.

## 8. Perfil Khora actual

Orden canónico para una ingesta real:

```txt
archivos + TSX + Python
        ↓
Kernel listener/health
        ↓
Neo4j DNS/TCP/driver
PostgreSQL TCP/SELECT 1
Groq modelo/chat
Voyage batch embedding
        ↓
volcado aprobado + hash + versión
        ↓
primer_vinculo
        ↓
acta de ingesta
        ↓
InformationObject + Entity + RELATION
        ↓
estado del volcado en PostgreSQL
```

Guardarraíles activos:

- mapa de identidad fijo: <code>fila4</code> posee sesión/repositorio/descargas y <code>MantenimientoRCI</code> posee el venv elevado; ningún artefacto puede inferir que ambos comparten <code>LOCALAPPDATA</code> ni que conocer una ruta de otro perfil concede permiso para leerla; esta regla cubre dependencias directas e indirectas: antes de delegar recuperación en otro script se valida qué runtime resolverá bajo la identidad efectiva;
- verificación sin cruce de privilegios: cuando exista API oficial, se prefiere sobre inspeccionar o ejecutar artefactos del perfil elevado; para Neo4j Aura, conteos y evidencia final usan Query API por HTTPS/443; el nombre de base no se fija como <code>neo4j</code>: se resuelve desde configuración/URI/host y se ratifica con <code>RETURN 1</code> antes de cualquier consulta de evidencia;
- raíz canónica: <code>C:\Users\fila4\source\repos\khora</code>, independiente del directorio actual o de copias bajo <code>khora-session</code>;
- rutas bajo <code>khora-web</code> se derivan de <code>$root\khora-web</code>;
- TSX debe existir antes de la ingesta;
- payloads Node/Python complejos viven en archivos temporales;
- un gestor de paquetes no se considera disponible solo porque exista su ejecutable: debe validarse su fuente con una operación funcional; para runtimes base se mantiene una ruta oficial directa, firmada, con integridad comprobada y ámbito de usuario, evitando que WinGet/Scoop/Chocolatey sean puntos únicos de fallo;
- Voyage usa batching y backoff para 429;
- timeout de ingesta es configurable;
- listeners solo se reinician si son Uvicorn esperado;
- fallos anteriores a asentamiento no autorizan afirmar que existe grafo;
- el grafo solo existe cuando hay acta y conteos directos;
- consistencia multi-almacén: PostgreSQL no puede consolidar <code>ingerido</code> antes de verificar Neo4j; si una transacción distribuida no es posible, se usa estado intermedio explícito, idempotency key y compensación, y nunca se reintenta cuando SQL avanzó pero el grafo no está demostrado;
- identidad de verificación: el consumidor no puede predecir un ID distinto del que canoniza el Kernel; la evidencia se vincula por <code>volcado_id + version + sha256</code> o por el ID realmente retornado/persistido, y todo cero por identificador se contrasta con la clave de negocio antes de declarar ausencia.

## 9. Formatos operativos

### Brief previo

```txt
OBJETIVO:
EVIDENCIA TERMINAL:
EFECTO PERSISTIDO:
DEPENDENCIAS:
HUELLAS RELEVANTES:
GUARDARRAÍLES OBLIGATORIOS:
CHECKPOINT/ROLLBACK:
ARTEFACTO ÚNICO:
```

### Salida estándar del artefacto

```txt
PHASE=<nombre> STATUS=OK|SAFE_STOP
CHANGED=<recursos>
NOT_EXECUTED=<fases>
BACKUP=<ubicación o none>
RESUME_FROM=<checkpoint>
EVIDENCE_PRIMARY=<dato>
EVIDENCE_PERSISTED=<dato>
OBJECTIVE=COMPLETED|BLOCKED
```

### Registro de error

```txt
Objetivo · fase · componente · síntoma verbatim · huella · causa/confianza · impacto · corrección · guardarraíl · verificación pendiente · recurrencia
```

## 10. Métricas y auditoría

Revisar periódicamente:

- ciclos por objetivo;
- comandos copiados por objetivo;
- porcentaje de errores interceptados por preflight;
- recurrencias por huella;
- fallos de pegado/parser;
- tiempo hasta causa confirmada;
- abortos antes de mutación frente a fallos posteriores;
- éxitos con evidencia doble;
- guardarraíles creados y reutilizados.

### Umbrales

- Parser/copiado > 0 en un objetivo: migrar inmediatamente a archivo.
- Misma huella ≥ 2: automatización obligatoria.
- Objetivo > 2 ciclos: retrospectiva causal antes de continuar.
- Éxito sin evidencia persistida: se contabiliza como no cerrado.
- Timeout sin capa identificada: prohibido aumentar el timeout antes de aislar la causa.

## 11. Bloque portable para cualquier modelo o hilo

<callout icon="📦" color="gray_bg">
<b>INSTRUCCIÓN CANÓNICA PORTABLE MOTOR-1C</b><br /><br /><br />Antes de actuar, define el objetivo terminal y su evidencia persistida. Consulta el registro de errores por huella normalizada y recupera correcciones verificadas, caminos refutados y guardarraíles. Construye un DAG de dependencias; ejecuta en paralelo los preflights independientes y encadena las fases dependientes con SAFE\_STOP. Busca cerrar el objetivo completo mediante un único artefacto idempotente, reversible y autodiagnosticable, invocado por una línea mínima. Valida payloads, orquestación, rutas, ejecutables, quoting, working directory, limpieza y repetición. El segundo error equivalente debe convertirse en automatización; el tercero obliga a cambiar de arquitectura. No declares éxito sin evidencia primaria y persistida. Después del ciclo, actualiza el registro con causa real, impacto, checkpoint, guardarraíl y verificación.
</callout>

## 12. Gobernanza

- Este protocolo prevalece sobre la conveniencia de emitir un comando rápido.
- Toda excepción debe quedar explícitamente justificada.
- Las mejoras verificadas se incorporan aquí, no solo al chat donde surgieron.
- El protocolo es portable: cambia el perfil de entorno, no sus invariantes.
- La versión vigente es la que figura en esta página y está enlazada desde el registro matriz.

<callout icon="🎯" color="green_bg">
<b>Criterio de efectividad:</b> MOTOR-1C funciona cuando los errores históricos dejan de explicar por qué volvimos a fallar y empiezan a impedir que la clase de fallo vuelva a ejecutarse.
</callout>
