# Glosario Operativo de la Metodologia

**Estado:** CANONICO  
**Version:** v1.1.1  
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
**Regla:** no se confunde con una sesion de terminal.

### Sesion RDC
**Tipo:** estado operativo.  
**Definicion:** conexion remota autenticada a un dispositivo mediante RDC.  
**Distincion:** una sesion RDC activa no equivale necesariamente a una sesion terminal iniciada mediante la herramienta.

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
**Definicion:** cuenta utilizada para elevacion o funciones de puente tecnico.  
**Regla:** su uso directo para trabajo ordinario esta prohibido cuando exista un usuario operativo definido.

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

### Estado RDC activo
**Tipo:** registro operativo global.
**Definicion:** estado compartido que identifica la sesion RDC globalmente vigente para las conversaciones sujetas a la metodologia.
**Fuente:** ESTADO-RDC-ACTIVO.md.
**Regla:** el registro se consume y verifica por ciclo; una nueva sesion verificada sustituye a la anterior.

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
