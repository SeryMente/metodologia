# Ancla metodológica

Este repositorio es la fuente canónica de la metodología común de los repositorios de Ser y Mente.

Las conversaciones que trabajen sobre metodología deben consultar y aplicar el contenido vigente de este repositorio. Una propuesta conversada no constituye una regla metodológica hasta que haya sido confirmada e incorporada aquí.


## Gate transversal por turno

Todo turno sujeto a la metodología debe adquirir el SI de forma atómica: leer `main` como `H1`, recuperar el SI exactamente en `H1`, volver a leer `main` como `H2` y verificar versión + nombre + blob SHA. Solo `H1 = H2` permite `F:✓`; una copia previa o lectura de `main` sin SHA exacto no es evidencia. El HUD debe mostrar `F:✓` solo tras esa comprobación. Cuando la plataforma sea ChatGPT, Thinking es la ventana preferente para ejecutar la cascada normativa con KHORA; `reasoning_mode` se registra como metadato cuando esté disponible y no constituye una prueba del razonamiento interno. Si KHORA no está disponible, el turno continúa y la salida declara `K: OFF`; el formato canónico vigente es `v1.7.6`.


## Precedencia del contexto RDC

Antes de cualquier certificación de KHORA, todo ciclo debe leer `ESTADO-RDC-ACTIVO.md` y, cuando RDC sea relevante, consultar el proveedor RDC en vivo para resolver el conjunto actual de dispositivos. La terminal seleccionada se identifica por `RDC-CUENTA + RDC-DEVICE-ID` y pertenece al ciclo, no a todas las conversaciones. Si una terminal requerida no es observable, debe ofrecerse `RDC-REINSTANTIAR` y el comando oficial `npx @wonderwhy-er/desktop-commander@latest remote` en el mismo ciclo. Un handshake fresco se considera resuelto después de validación y, cuando corresponda, publicación/read-back del registro persistente.


## Precedencia inmediata de Vercel

La mera presencia de Vercel en una tarea o hilo de desarrollo activa el objeto canónico `ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md`. Antes de ejecutar cualquier operación dependiente de Vercel, el ciclo debe:

`LIMITATION-SCAN → DEPENDENCIA-VERCEL → SUFICIENCIA-LOCAL → VÍA DE EJECUCIÓN`

Primero se comprueba si existe una limitación relevante del proveedor; después se determina cuánto del objetivo necesita materialmente Vercel; después se verifica si una implementación local basta para alcanzar ese objetivo. Cuando local sea suficiente, el trabajo continúa localmente y no se consume un deployment por inercia. Cuando local no sea suficiente, solo la parte realmente dependiente de Vercel queda condicionada por la capacidad de publicación.

Una limitación de Vercel no produce bloqueo global del esfuerzo. El bloqueo total requiere evidencia de dependencia remota material y de insuficiencia local. Esta regla tiene efecto inmediato para todos los ciclos sujetos a la metodología desde su canonización.
