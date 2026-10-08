## Perfil operativo obligatorio: sin reinicio

**PRESUPUESTO-REINICIO = 0.** En CIBERCAFE ninguna intervención del proceso puede provocar, programar o exigir un reinicio, apagado, reset, entrada a UEFI/BIOS o reparación offline. Una acción con dependencia de reboot se marca `BLOQUEADA-REINICIO`, se registra y se omite; el ciclo continúa con alternativas live.

La ventana de mantenimiento de este ámbito no autoriza reboot: solo permite intervenir con la terminal todavía operativa. Un reinicio externo/DeepFreeze puede ocurrir fuera del proceso; `SYNC_FLUSH` sigue siendo una protección de continuidad cuando exista una señal observable y no implica que el proceso pueda iniciarlo.

# Anexo - Proceso Persistente de Liberacion de Desempeno en Cibercafe

**Estado:** CANONICO  
**Fecha:** 2026-10-08  
**Ambito:** Terminales de cibercafe sujetas a la metodologia comun.

## 1. Proposito

Establecer un proceso persistente que aproxime cada terminal al maximo desempeno practico alcanzable sin degradar el trabajo activo, la estabilidad, la seguridad ni la recuperabilidad.

El objetivo operativo no es «optimizar una vez». Es mantener una busqueda continua de oportunidades de desempeno y conservar la memoria de lo ya medido, intentado, validado o descartado para no repetir trabajo inutil.

El «ideal absoluto» se interpreta como una optimizacion condicionada:

**MAXIMIZAR CAPACIDAD DISPONIBLE Y RESPONSIVIDAD**
sujeto a:
- no interrumpir injustificadamente al usuario;
- no cerrar ni degradar aplicaciones de trabajo;
- no sacrificar seguridad o integridad del sistema;
- no introducir cambios irreversibles sin evidencia y procedimiento apropiado;
- verificar cada cambio contra mediciones antes/despues.

## 2. Identidad de terminal

En un cibercafe, la unidad persistente es la terminal individual:

`PC-7`, `PC-8`, `PC-9`, etc.

Nunca se utiliza «CIBERCAFE» como si fuera una sola computadora.

La identidad persistente de desempeño es:

`CIBERCAFE + PC-N`

La identidad RDC sigue siendo independiente y se conserva como:

`RDC-CUENTA + RDC-DEVICE-ID`

Una misma PC puede recibir nuevas identidades RDC a lo largo del tiempo. El historial de desempeño pertenece a la identidad fisica/logica `PC-N`, mientras que la identidad RDC describe el canal de observacion de la sesion concreta.

## 3. Capas de estado

### 3.1 Estado local efimero

Vive en la terminal mientras la sesion esta activa y se pierde con mecanismos como DeepFreeze.

Incluye:
- muestras de CPU, GPU, RAM y disco;
- procesos consumidores;
- temperaturas, energia, latencias y otros indicadores disponibles;
- cola local de eventos;
- diagnosticos detallados;
- estado del agente de observacion.

### 3.2 Memoria persistente por terminal

Vive en el repositorio y sobrevive al reinicio/DeepFreeze.

Cada terminal debe tener, como minimo:

`CIBERCAFE/PC-N/ESTADO.md`
`CIBERCAFE/PC-N/EVENTOS-YYYY-MM.md`

El estado persistente conserva:
- huella de hardware conocida;
- sistema operativo y controladores relevantes;
- perfiles de carga observados;
- baseline contextual;
- cambios aplicados y revertidos;
- oportunidades conocidas;
- bloqueos o decisiones pendientes;
- ultima sincronizacion;
- cursor de eventos sincronizados;
- ultima evidencia de estabilidad.

El evento persistente conserva trazabilidad de cambios y decisiones relevantes, no cada muestra de telemetria.

## 4. Regimen de observacion

El agente local puede muestrear continuamente.

Frecuencia de referencia:
- telemetria rapida: 5-10 segundos;
- agregacion de tendencias: 1-5 minutos;
- reevaluacion de oportunidades: por evento semantico o tendencia, no por cada muestra.

La frecuencia real puede adaptarse al impacto del propio agente. El observador nunca debe convertirse en una carga significativa de CPU, RAM, GPU o disco.

## 5. HUD

Cuando el proceso se represente mediante salida conversacional visible, cada comentario operativo debe llevar un HUD compacto con los indicadores disponibles:

`HUD | CPU ... | GPU ... | VRAM ... | RAM ... | DISK ... | TEMP ... | PWR ... | OPORTUNIDAD ... | ACCION ...`

Los indicadores ausentes se expresan como `ND`; nunca se inventan valores.

El HUD sirve para informar el estado observable. No expone el razonamiento interno paso a paso del modelo.

## 6. Bucle persistente de optimizacion

El ciclo operativo es:

`OBSERVAR → MEDIR → COMPARAR → DETECTAR OPORTUNIDAD → EVALUAR RIESGO → ACTUAR → MEDIR → VALIDAR → CONSERVAR/REVERTIR → REGISTRAR → REPETIR`

Estados:
- `OBSERVANDO`
- `OPORTUNIDAD`
- `PENDIENTE`
- `CAMBIO-APLICADO`
- `VALIDADO`
- `REVERTIDO`
- `BLOQUEADO`
- `ESTABLE`

El proceso no cierra el ciclo por haber alcanzado una mejora parcial. Solo deja de actuar cuando no existe una accion segura y justificada en ese momento; la observacion puede continuar.

## 7. Jerarquia de intervencion

Las intervenciones deben priorizar, en este orden general:

1. configuraciones seguras y reversibles;
2. liberacion de recursos no utilizados;
3. mantenimiento y limpieza controlada;
4. ajustes de software o drivers con evidencia;
5. cambios de sistema con validacion y recuperacion;
6. cambios de firmware/BIOS solo fuera de actividad del usuario y bajo procedimiento especifico.

Nunca se debe matar un proceso solo por consumo alto. Debe determinarse si pertenece al trabajo activo, al cliente del cibercafe, a seguridad, al juego, a OBS, a control del puesto u otra funcion necesaria.

## 8. Baseline contextual

El desempeño no se compara contra un unico «idle» universal.

La terminal mantiene baselines, cuando sean observables, para:
- idle;
- navegador/ofimatica;
- streaming/captura;
- juego;
- carga mixta.

Una nueva oportunidad se considera significativa por diferencia contra un baseline comparable y por beneficio esperado.

El estado persistente puede reutilizar una baseline previa; no obstante, una accion que pueda cambiar el sistema debe validar de nuevo las variables dinamicas antes de aplicarse.

## 9. Memoria anti-repeticion

Antes de ejecutar un diagnostico profundo, el ciclo debe consultar `CIBERCAFE/PC-N/ESTADO.md`.

Debe reutilizar:
- hardware ya identificado;
- software/driver ya comprobado;
- cambios previamente aplicados;
- intervenciones que fallaron;
- causas ya descartadas;
- oportunidades pendientes que puedan revalidarse con una comprobacion ligera.

No se repite una medicion costosa cuando el resultado persistente sigue siendo aplicable y no existe evidencia de cambio.

Si cambia la huella de hardware, version de sistema, driver o configuracion relevante, se invalida exclusivamente el conocimiento afectado.

## 10. Eventos persistentes

Los eventos significativos usan una taxonomia minima:

- `SESSION_START`
- `BASELINE`
- `OPPORTUNITY_DETECTED`
- `CHANGE_APPLIED`
- `CHANGE_VALIDATED`
- `CHANGE_REVERTED`
- `REGRESSION`
- `ERROR`
- `HARDWARE_CHANGE`
- `DRIVER_CHANGE`
- `SESSION_END`
- `RESET_PENDING`
- `SYNC_FLUSH`

Cada evento debe registrar, cuando este disponible:

`EVENT_ID | UTC | PC-N | RDC-DEVICE-ID | TIPO | ANTES | ACCION | DESPUES | IMPACTO | RESULTADO | EVIDENCIA`

## 11. Sincronizacion hibrida

La telemetria de alta frecuencia permanece local.

La sincronizacion al repositorio utiliza tres disparadores:

### 11.1 Evento inmediato

Sincronizar de inmediato cuando ocurra:
- inicio de sesion;
- nueva huella de hardware;
- cambio aplicado;
- rollback;
- regresion o error material;
- cambio de driver/firmware;
- deteccion de una nueva oportunidad de alto impacto;
- inicio de reinicio/logoff o evento compatible con DeepFreeze.

### 11.2 Lote periodico

Si solo existen observaciones ordinarias, sincronizar el acumulado cuando ocurra lo primero:

`15 minutos` o `20 eventos semanticamente nuevos`.

El lote publica:
- estado agregado;
- tendencias;
- oportunidades nuevas;
- eventos acumulados;
- watermark/cursor.

Las muestras individuales no se publican una por una.

### 11.3 Vaciado de cierre

Antes de reinicio, logoff o cualquier mecanismo de restauracion tipo DeepFreeze, realizar un `SYNC_FLUSH` obligatorio mientras exista conectividad y autenticacion suficientes.

El objetivo es que ninguna intervencion o evento relevante de la sesion quede unicamente en el disco efimero.

## 12. Evitar consumo innecesario de llamadas RDC

Una nueva conversacion debe:

1. resolver su terminal RDC viva conforme al modelo canonico;
2. leer la memoria persistente de `PC-N`;
3. reutilizar toda la informacion que siga vigente;
4. usar RDC para observacion/accion nueva y no para preguntar repetidamente por hechos ya persistidos;
5. permitir que el agente local siga muestreando sin una llamada RDC por muestra;
6. sincronizar por evento o lote, no por ciclo de telemetria.

La llamada RDC se considera justificada cuando agrega nueva evidencia, ejecuta una accion, verifica una transicion o realiza un flush requerido.

La llamada RDC se considera justificada cuando agrega nueva evidencia, ejecuta una accion, verifica una transicion, resuelve una ambigüedad material o realiza un flush requerido.

El proceso debe preferir la reutilizacion de memoria persistente frente a una nueva llamada cuando la informacion siga dentro de su condicion de validez. La telemetria de alta frecuencia permanece local y el HUD puede reutilizar la ultima lectura verificada apropiada para la decision en curso.

Cada fase puede contabilizar RDC-LLAMADAS, RDC-REUTILIZACION y RDC-EVITADAS. Estos indicadores miden eficiencia de observacion; no sustituyen la evidencia necesaria cuando una decision requiera una lectura fresca.

## 13. DeepFreeze y continuidad

DeepFreeze y mecanismos equivalentes se consideran **sesiones locales efimeras**, no perdida de memoria del proyecto.

Al comenzar una sesion nueva en `PC-N`, el proceso debe reconstruir continuidad desde:

`REGISTRO PC-N → EVENTOS RECIENTES → ESTADO HARDWARE/DRIVERS → OBSERVACION FRESCA → OPERACION`

No debe repetir automaticamente toda la auditoria historica.

El conocimiento dinamico que haya caducado debe revalidarse; el conocimiento estructural que permanezca estable debe reutilizarse.

## 14. Seguridad y no interferencia

El proceso debe:
- detectar aplicaciones en primer plano;
- evitar intervenciones destructivas durante uso activo;
- preservar seguridad, cliente del cibercafe y software de control;
- mantener reversibilidad cuando sea posible;
- registrar toda modificacion;
- medir antes y despues;
- preferir no hacer nada antes que degradar el trabajo.

«Maximo rendimiento» no autoriza una accion que empeore estabilidad, seguridad o experiencia del usuario.

## 15. Criterio de exito

Una terminal se considera acercada al ideal cuando:
- se conocen sus recursos y cuellos de botella relevantes;
- las oportunidades seguras de alto impacto han sido atendidas;
- no existen regresiones detectadas;
- el sistema permanece observable;
- el conocimiento queda persistido por `PC-N`;
- la siguiente sesion puede continuar sin repetir trabajo ya resuelto.

No existe un estado permanente de «optimizado para siempre». Existe un estado de observacion continua con memoria de decisiones.

## 16. Dependencias canonicas

Este anexo depende de:
- `METODOLOGIA.md`
- `BOOTSTRAP-CONTEXTO-GLOBAL.md`
- `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md`
- `ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md`
- `ESTADO-RDC-ACTIVO.md`
- `GLOSARIO-OPERATIVO.md`

No crea un principio fundamental nuevo. Desarrolla el procedimiento operativo para continuidad de desempeño por terminal.


## 12.1 Presupuesto de observacion remota

Cada sesion debe tratar las llamadas RDC como un recurso operativo limitado. La prioridad es maximizar el valor obtenido por llamada, no maximizar el numero de llamadas.

Orden de preferencia:

1. reutilizar memoria persistente vigente;
2. reutilizar una observacion reciente de la misma sesion cuando sea suficiente;
3. agrupar varias comprobaciones en una sola llamada cuando la herramienta lo permita;
4. ejecutar una llamada nueva cuando agregue evidencia o habilite una accion material;
5. registrar la llamada y su valor producido.

No se repite una llamada identica solo para refrescar el HUD. Se fuerza refresco cuando el dato haya caducado, exista evidencia de cambio, una accion dependa de una lectura fresca o haya una transicion que deba verificarse.

## 12.2 Endurecimiento de memoria

Cada entrada reutilizable del estado de PC-N debe distinguir al menos:

ESTADO = VIGENTE | PENDIENTE | INVALIDADO | DESCARTADO | REQUIERE-REVALIDACION

Y, cuando sea posible:

ULTIMA-VERIFICACION | FUENTE | CONDICION-DE-VALIDEZ | INVALIDADO-POR | SIGUIENTE-ACCION | WATERMARK

Una nueva sesion no empieza desde cero. Empieza desde el conocimiento persistido y dedica llamadas RDC solamente a cerrar las incertidumbres que realmente puedan modificar la siguiente decision.
