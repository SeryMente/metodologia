# Glosario Operativo de la Metodologia

**Estado:** CANONICO  
**Version:** v1.3.1  
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

No se hereda automáticamente vocabulario del corpus Notion anterior por mera mención. La adopción expresa del Metaprompt Canónico de Samantha como gobierno general no activa todos sus protocolos o proyectos citados. Sesión PRIUS queda identificada y diferida, no activada; las demás voces requieren ámbito y adopción pertinentes. Tampoco se hereda vocabulario teorico o especifico de proyecto sin necesidad transversal demostrada.

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


### PERFIL-CIBERCAFE-NO-REINICIO
Perfil operativo permanente del ámbito CIBERCAFE en el que la continuidad de la sesión tiene prioridad: `PRESUPUESTO-REINICIO = 0` y ninguna intervención puede requerir reboot de la terminal.

### BLOQUEADA-REINICIO
Estado de una intervención que requiere reinicio, apagado, reset, entrada a UEFI/BIOS o reparación offline. Se registra como oportunidad, no se ejecuta y no bloquea por sí mismo el resto del ciclo.

### VENTANA-DE-MANTENIMIENTO-LIVE
Periodo de mantenimiento en CIBERCAFE en el que la terminal permanece encendida, conectada y utilizable por el usuario. No autoriza reinicio.

### Cuota de deployment Vercel
**Tipo:** restricción de plataforma.
**Definición:** límite vigente que Vercel aplica a la creación de nuevos deployments, dependiente del plan y de las ventanas temporales del proveedor.
**Regla:** se verifica contra la documentación y el estado vigente de Vercel; no se trata como una constante permanente ni como indicio de indisponibilidad total de KHORA.

### Deployment
**Tipo:** objeto de publicación.
**Definición:** versión del proyecto creada y servida por Vercel o preparada para servirla.
**Regla:** la existencia de un deployment no significa que represente el `main` actual; debe verificarse su commit/SHA y estado.

### Ejecución local
**Tipo:** modo de ejecución.
**Definición:** instancia de Cora ejecutada fuera del servicio remoto de Vercel, normalmente desde el repositorio canónico en el equipo local.
**Regla:** puede usarse para desarrollo, depuración y validación cuando el URL canónico no sea materialmente necesario. No adquiere autoridad de producción.

### URL canónico de publicación
**Tipo:** referencia de despliegue.
**Definición:** URL que la metodología reconoce como superficie canónica de producción de un proyecto.
**Regla:** una instancia local o un deployment histórico no se presenta como equivalente al URL canónico sin una decisión explícita y verificable.

### Verificación local de build Vercel
**Tipo:** mecanismo de validación.
**Definición:** ejecución local de `vercel build` para obtener y revisar el artefacto `.vercel/output` sin crear por sí misma un deployment remoto.
**Regla:** `vercel deploy` y `vercel deploy --prebuilt` sí crean deployments y quedan sujetos a los límites del proveedor.

### Estado de cuota Vercel
**Tipo:** estado operativo de ciclo.
**Definición:** clasificación de la capacidad de crear el deployment requerido en el momento de la operación.
**Valores:** `NO-REQUERIDA`, `DISPONIBLE`, `LIMITADA`, `NO-VERIFICADA`.
**Regla:** `LIMITADA` bloquea la publicación que necesita un deployment nuevo, pero no bloquea por sí misma las operaciones sobre deployments existentes ni la ejecución local.


## 7. Formalización de frentes — C-METODOLOGIA-GOBIERNO-01

### Frente de trabajo
**Tipo:** objeto de persistencia compuesto.  
**Nombre técnico:** objeto canónico de persistencia de frente de trabajo.  
**Nombre corto equivalente:** frente de trabajo.  
**Definición:** directorio completo con núcleo operativo único, contexto externo recuperable, conversaciones originales, crónica y materiales pertinentes. No equivale a un único .md. En lenguaje ordinario también puede designar el esfuerzo: explicitar la distinción cuando afecte custodia o arquitectura.  
**Normalización:** «fuentes de trabajo» se corrige a «frentes de trabajo» cuando el contexto lo identifica inequívocamente; conservar el original del dictado.

### Núcleo operativo
Archivo de entrada y estado vigente de un frente. Orienta y enruta, conserva gobierno obligatorio y continuidad suficiente; no duplica toda la historia ni es un índice vacío.

### Contexto persistido
Representación externa verificable necesaria para reconstruir una ventana de trabajo útil en otra instancia. No es la ventana interna ni la memoria del modelo.

### Historial conversacional
Originales secuenciados de entradas del usuario y salidas visibles del modelo, con cambios de plataforma, conversación y modelo, y rol/persona cuando existan. No equivale al contexto operativo ni a una síntesis.

### Crónica del frente
Registro explicativo de acontecimientos, decisiones, acciones, evidencias, límites y continuidad enlazado con originales; no los sustituye.

### Espacio de trabajo Ser y Mente
Organización `SeryMente` y sus repositorios como espacio persistente común. Las aplicaciones comerciales, como Notion, son superficies vinculadas, no la única persistencia.

### Sincronización perpetua
Requisito ratificado: cada cambio documental en la aplicación de origen desencadena actualización automática de su espejo en el repositorio del frente. Alcance confirmado aplicación → repositorio; no presume dirección inversa. Mecanismo aún pendiente; una copia puntual no acredita continuidad automática.

### Metaprompt Canónico de Samantha
Documento de Capa 1 que contiene identidad, comportamiento y reglas generales y gobierna el espacio de trabajo Ser y Mente y sus repositorios. Un mismo documento con copia operativa en GitHub, no dos autoridades por estar espejado. Antecedente de migración: v332 · NX-332m; no es prueba de vigencia. El espejo adquirido333 y su procedencia se consultan en gobernanza, sin fijar aquí otra autoridad. «Samanta», «Metapron» y «Metapromp» son variantes de dictado, no nombres nuevos.

### Sesión PRIUS
Segunda capa de gobernanza histórica del espacio Notion. Uso futuro previsto; revisión/adaptación diferidas explícitamente hasta que no haya urgencias. Copiar o mencionar su canon no abre una sesión.

### Metacanon de frentes
Método de configuración y mantenimiento de los frentes, subordinado al gobierno general. No se confunde con el metaprompt ni sustituye las reglas superiores de cada plataforma.

## 8. Precisión de revisión integral1.10

### Categorías de revisión
Dieciséis ejes de auditoría de cobertura e integración del método. No reemplazan los trece bloques del molde del núcleo ni obligan a dieciséis secciones nuevas por frente.

### Contrato de cierre
Concreción del encargo, criterio observable, fuente de intención, permiso, dependencias, evidencia y checkpoint dentro del núcleo existente. No es un segundo estado ni autorización automática.

### Aceptación funcional
Contraste del funcionamiento previsto con evidencia del receptor real y su entorno. Se distingue de revisión documental completada y de controles mecánicos aprobados; no se deduce de ellos.

### Recibo de refresco
Evidencia derivada de lectura de la fuente central: revisión, versión/huella, modificación, comprobación y adopción. No constituye otro núcleo ni actualiza por sí solo un frente.

### Antigüedad del método
Tiempo desde la última modificación comprobada del archivo metodológico, distinto del tiempo desde su comprobación o empaquetado. Si faltan reloj/fuente/fecha coherentes, edad no verificada.

- **Responsable exclusivo del frente:** único hilo/instancia vigente en el control, no todo lector o colaborador.
- **Generación de responsabilidad:** contador que invalida permisos operativos anteriores al transferir/liberar; no autentica identidad por sí mismo.
- **Comparación y sustitución atómicas:** reemplazo condicionado a la huella exacta observada, sin que un segundo competidor sobrescriba silenciosamente.
- **Preflight cooperativo:** comprobación previa; no equivale a imposición transaccional de todas las escrituras.
