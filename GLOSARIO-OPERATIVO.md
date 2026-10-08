# Glosario Operativo de la Metodologia

**Estado:** CANONICO  
**Version:** v1.2.0  
**Ambito:** Todos los proyectos y conversaciones sujetos a la metodologia comun.

## 1. Funcion

Este glosario fija la forma y el significado de los terminos operativos transversales de la metodologia. No sustituye los documentos normativos que desarrollan el significado tecnico de cada objeto y no incorpora automaticamente el vocabulario de proyectos particulares.

## 2. Regla de autoridad

Cuando exista una entrada canonica, su forma debe utilizarse en salidas, documentos, nombres de artefactos y referencias metodologicas. Una variante de dictado o transcripcion puede registrarse como alias de normalizacion, pero no se convierte por ello en forma canonica.

## 3. Terminos canonicos

### CECEQ
**Tipo:** ubicacion.  
**Definicion:** nombre canonico de la ubicacion de trabajo correspondiente al Centro Cultural Gomez Morin en Queretaro.  
**Forma canonica:** CECEQ.  
**Variantes de transcripcion conocidas:** CSEC, CSEQ.  
**Regla:** las variantes se normalizan a CECEQ.

### KHORA
**Tipo:** producto / sistema.  
**Definicion:** nombre canonico de la protesis cognitiva digital y de su sistema asociado dentro del proyecto.  
**Forma canonica:** KHORA.  
**Variantes historicas o de transcripcion:** Cora, Khora con capitalizacion variable.  
**Regla:** Cora no se emite como nombre canonico del producto; se normaliza a KHORA.

### RDC
**Tipo:** mecanismo de acceso.  
**Definicion:** Remote Desktop Commander, canal utilizado para operar el entorno remoto autorizado.  
**Forma canonica:** RDC.  
**Regla:** no se confunde con la identidad de una terminal ni con la ubicacion fisica.

### Identidad RDC
**Tipo:** identidad operativa de dispositivo.  
**Definicion:** combinacion de `RDC-CUENTA + RDC-DEVICE-ID` que identifica una terminal concreta ante el proveedor RDC.  
**Regla:** el nombre visible del dispositivo no basta para identificar una terminal.

### Sesion RDC
**Tipo:** estado operativo por terminal.  
**Definicion:** conexion remota autenticada asociada a una identidad RDC concreta.  
**Distincion:** pueden coexistir varias sesiones RDC en dispositivos diferentes; no existe una unica sesion RDC global para todas las conversaciones.

### Divergencia de observabilidad RDC
**Tipo:** estado operativo de recuperación.  
**Definicion:** condicion en la que una terminal RDC requerida no puede verificarse en vivo mientras el usuario aporta evidencia local positiva de actividad de esa terminal.  
**Regla:** no permite inferir finalizacion ni sustituir la terminal por otra identidad ONLINE. Cuando el ciclo requiere esa terminal en vivo, activa el protocolo `RDC-REINSTANTIAR`.

### RDC-REINSTANTIAR
**Tipo:** comando conversacional de recuperación.  
**Definicion:** instrucción canónica que solicita cerrar la terminal/sesión RDC observada, iniciar una nueva sesión y devolver el `RDC-HANDSHAKE` necesario para sustituir de forma verificable el estado global.  
**Regla:** no se interpreta como comando de shell ni como evidencia de finalizacion de otra identidad.

### Ubicacion actual
**Tipo:** estado transversal.  
**Definicion:** lugar fisico de trabajo vigente para los ciclos actuales.  
**Regla:** permanece vigente entre conversaciones hasta declaracion explicita de cambio.

### Usuario Windows operativo
**Tipo:** identidad operativa.  
**Definicion:** cuenta bajo la que deben ejecutarse las operaciones ordinarias del entorno.  
**Regla:** identifica la identidad operativa de referencia del perfil; no obliga por sí misma a cambiar la identidad efectiva de ejecución.

### Usuario Windows administrativo
**Tipo:** identidad administrativa.  
**Definicion:** identidad administrativa o elevada disponible en el entorno. Puede coincidir con la identidad efectiva de la sesión RDC.  
**Regla:** su uso para trabajo ordinario está permitido cuando la operación sea técnicamente válida. La única restricción específica de materialización de repositorios se define en los anexos operativos.

### Bloqueo de ejecucion
**Tipo:** estado de ejecución.
**Definicion:** condición en la que el ciclo no puede realizar trabajo sustantivo ni declararse cerrado por faltar una precondición verificable.
**Regla:** el bloqueo es operativo, no conversacional. El modelo permanece disponible para resolver la causa, recibir información y volver a verificar el contexto.

### Notificacion de bloqueo
**Tipo:** formato operativo.
**Definicion:** salida visual estandarizada que identifica inmediatamente un ciclo bloqueado.
**Regla:** debe aparecer al inicio de una notificación de bloqueo y utilizar el formato canónico del registro por ciclo.

### Ciclo
**Tipo:** unidad metodologica.  
**Definicion:** unidad de secuencia y trazabilidad global establecida por la metodologia.

### Conversacion
**Tipo:** contenedor.  
**Definicion:** contexto conversacional que contiene uno o mas ciclos; no sustituye la identidad global del ciclo.

### Glosario Operativo
**Tipo:** instrumento normativo-operativo.  
**Definicion:** fuente transversal que fija formas y significados de los terminos canonizados por la metodologia.

### Variante de transcripcion
**Tipo:** alias de normalizacion.  
**Definicion:** forma producida por dictado, reconocimiento de voz o legado que corresponde razonablemente a un termino canonico.  
**Regla:** la variante no adquiere autoridad por aparecer en la entrada original del usuario.

### Termino canonico
**Tipo:** unidad terminologica.  
**Definicion:** forma ortografica y semantica que debe utilizarse una vez incorporada al glosario.

### RDC-REQUERIDA
**Tipo:** estado de requisito del ciclo.
**Definicion:** indica si la conversacion o ciclo requiere una sesion RDC activa para ejecutar la tarea.
**Valores:** SI, NO o PENDIENTE DE RESOLUCION.
**Regla:** una deteccion indeterminada no puede convertirse en SI o NO por inferencia; debe resolverse explicitamente.

### CONTEXTO-VERIFICACION
**Tipo:** estado de gate.
**Definicion:** resultado de la comprobacion del contexto operativo antes de ejecutar.
**Valores canonicos:** VERIFICADO-ACTIVO, VERIFICADO-INACTIVO, NO-REQUERIDO, BLOQUEADO.
**Regla:** estados de deteccion como NO-VERIFICADO, INDETERMINADO o FUENTE-NO-DISPONIBLE no son estados de paso.

### Registro RDC activo
**Tipo:** registro operativo global.
**Definicion:** registro compartido que conserva identidades RDC conocidas, ciclos de vida y metadatos de continuidad entre conversaciones.
**Fuente:** ESTADO-RDC-ACTIVO.md.
**Regla:** no selecciona una terminal global ni sustituye el descubrimiento vivo del proveedor. La terminal actual se resuelve por ciclo.

### Procedencia
**Tipo:** trazabilidad.  
**Definicion:** informacion que permite conocer el origen de un dato, afirmacion o termino.

## 4. Terminos deliberadamente no heredados

No se heredan automaticamente GOW, WS, SSC, FIAT, PRIUS, RAP, MDC, VRC ni Entorno Persistente cuando procedan del corpus anterior de Notion y no hayan sido adoptados por este canon. Tampoco se hereda vocabulario teorico o especifico de proyecto sin necesidad transversal demostrada.

## 5. Procedencia de la migracion

Este glosario rescata de forma conservadora la arquitectura del antiguo GOW: una fuente transversal de terminologia, procedencia y separacion entre vocabulario global y vocabulario de proyecto.

Origen consultado: https://app.notion.com/p/1715d4a3b2508335ad3401f1d1d545f9

El contenido del antiguo GOW no se adopta en bloque.

## 6. Regla de correccion

Cuando una entrada de usuario contiene una variante de transcripcion y existe una correspondencia canonica suficientemente determinada, la salida utiliza la forma canonica. Si existe ambiguedad real, se conserva la incertidumbre y no se inventa equivalencia.


### Terminal RDC seleccionada
**Tipo:** estado operativo de ciclo.  
**Definicion:** identidad RDC concreta elegida para el ciclo actual despues del descubrimiento vivo.  
**Regla:** la seleccion es local a la conversacion/ciclo y se identifica por cuenta + device_id. No se hereda como seleccion global desde otra conversacion.

### Descubrimiento RDC vivo
**Tipo:** mecanismo de verificacion.  
**Definicion:** consulta al proveedor RDC que determina que identidades de dispositivo estan actualmente observables/ONLINE.  
**Regla:** tiene precedencia sobre el registro persistente para determinar presencia y conectividad actuales.


### PC-N
**Tipo:** identidad persistente de terminal de CIBERCAFE.  
**Definicion:** identificador de una computadora individual del cibercafe, por ejemplo `PC-7`, `PC-8` o `PC-9`.  
**Regla:** el registro y la memoria de desempeno pertenecen a cada `PC-N`; CIBERCAFE no se trata como una sola maquina.

### Evento de desempeno
**Tipo:** registro operativo.  
**Definicion:** hecho semantico relevante del proceso de observacion, optimizacion, cambio, regresion, error o sincronizacion de una terminal.

### Memoria persistente de desempeno
**Tipo:** estado transversal por terminal.  
**Definicion:** estado consolidado de desempeno que sobrevive a sesiones locales efimeras y mecanismos de restauracion como DeepFreeze mediante el repositorio.

### Sincronizacion hibrida de desempeno
**Tipo:** mecanismo operativo.  
**Definicion:** estrategia que mantiene telemetria de alta frecuencia local y publica al repositorio eventos materiales inmediatamente, observaciones ordinarias en lotes y un `SYNC_FLUSH` antes de reinicio/DeepFreeze cuando sea observable.


### Economia de llamadas RDC
**Tipo:** criterio de eficiencia operativa.  
**Definicion:** capacidad de obtener evidencia, acciones o decisiones utiles minimizando llamadas RDC que no agreguen valor.  
**Regla:** una llamada remota debe justificarse por descubrimiento, accion, verificacion de transicion, resolucion de ambigüedad material o sincronizacion; las mediciones repetibles y la telemetria frecuente deben resolverse localmente o mediante reutilizacion y batching.

### RDC-REUTILIZACION
**Tipo:** indicador de eficiencia.  
**Definicion:** cantidad o proporcion de verificaciones servidas mediante memoria persistente u observaciones ya vigentes, evitando una nueva llamada RDC.  

### RDC-EVITADAS
**Tipo:** indicador de eficiencia.  
**Definicion:** llamadas remotas que no fueron necesarias gracias a reutilizacion, agregacion o batching de informacion.
