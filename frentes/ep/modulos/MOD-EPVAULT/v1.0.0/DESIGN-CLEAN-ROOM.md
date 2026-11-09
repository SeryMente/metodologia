# EP Vault — diseño clean-room de la bóveda física

**Tarea:** EP-TASK-004  
**Hito:** H3 — Diseño visual clean-room  
**Estado:** especificación derivada de B/C y D aprobados por el operador el 2026-11-08; implementación aún pendiente.  
**Fuente de decisiones:** sección «Revisión B/C, candado D y despacho A» del README de EP-TASK-004.

## 1. Contrato de diseño

Construir una bóveda digital que se comporte y se perciba como una cámara física de seguridad. La puerta debe estar cerrada por defecto. La autenticación precede a cualquier movimiento de apertura. El estado visual nunca puede indicar «abierta» si el núcleo no confirmó una sesión válida.

El diseño no es un tablero administrativo decorado. Es una única pieza de interacción espacial: puerta, mecanismo, umbral, cámara interior y compartimentos. Los controles aparecen como piezas mecánicas o instrumentos de la cámara, no como tarjetas genéricas.

### Prohibición absoluta de reutilización

La interfaz heredada es LEGACY / NO REUTILIZAR. Este diseño se produce sin abrirla como referencia, sin capturarla ni copiarla, y sin tomar recursos, XAML, controles, layouts, estilos, nombres visuales, colores, fuentes, iconos, imágenes, animaciones o fragmentos de código visual de ella. Los nuevos archivos visuales se crean de cero en rutas independientes.

No se incorporan bitmaps, capturas, texturas extraídas ni fuentes heredadas. El primer render utilizará únicamente geometría vectorial nueva, gradientes, trazos, sombras y primitivas WPF definidas específicamente para esta experiencia. No se importan librerías de UI ni plantillas de terceros.

## 2. Dirección de arte

**Carácter:** monumental, ominoso, elegante, sobrio, táctil y preciso. La referencia conceptual es un mecanismo bancario de alta seguridad de mediados del siglo XX, interpretado con acabado contemporáneo. Evitar estética de videojuego, neón, cyberpunk, dashboard SaaS, vidrio translúcido o ornamentación gratuita.

**Materiales simulados mediante vectores:**
- acero ennegrecido y grafito mecanizado para la puerta;
- anillos de acero bruñido con reflejos controlados;
- latón envejecido para marcas, pernos, leyendas y rueda;
- luz ámbar cálida como señal de energía interna;
- cámara interior en carbón mate, con iluminación localizada y zonas de sombra.

**Paleta de construcción inicial:**
| Token | Color | Aplicación |
|---|---|---|
| VOID | #080B0D | fondo exterior |
| CARBON | #11171B | cámara y superficies profundas |
| GUNMETAL | #283239 | puerta y cuerpos metálicos |
| STEEL-LIGHT | #53616A | biseles y reflejos |
| BRASS | #927448 | mecanismos, marcas y tornillería |
| BRASS-LIGHT | #C3A36A | reflejo cálido y foco |
| AMBER | #D28B45 | señal activa/estado de energía |
| BONE | #D6CEBE | texto de lectura |

Los colores anteriores son tokens originales de esta especificación, no valores extraídos de la UI anterior.

**Tipografía:** usar una voz técnica condensada para estados y metadatos, y una voz serif sobria solo para títulos de cámara/inscripciones. Selección inicial: Bahnschrift para rótulos técnicos y Constantia para encabezados ceremoniales; Consolas para nombres de variables y datos tabulares. No copiar archivos de fuentes ni incrustar fuentes externas.

## 3. Composición principal

- Ventana inicial objetivo: 1440 × 900 DIP, escalable hacia abajo sin ocultar funciones.
- Fondo exterior amplio y oscuro, con una viñeta sutil y una única fuente de luz cálida.
- Puerta circular centrada y dominante, ocupando aproximadamente el 58–64 % de la altura útil en el estado cerrado.
- Geometría concéntrica: aro exterior, bisel, placa de puerta, eje central y rueda radial.
- Doce cerrojos radiales distribuidos uniformemente alrededor del perímetro. Deben tener volumen simulado con caras, bisel, sombra y reflejo vectorial; no imágenes.
- Marcas de índice y numeración técnica discretas en el aro; evitar texto decorativo ilegible.
- Zona inferior reservada a la acción primaria y a la autenticación. No colocar controles secundarios antes de desbloquear.
- En el estado abierto, la puerta se desplaza visualmente fuera del eje y revela la cámara interior. El contenido de variables se organiza como compartimentos físicos sobrios.

## 4. Máquina de estados UX

La UI y el núcleo comparten una máquina de estados explícita:

| Estado | Entrada | Presentación | Condición de salida |
|---|---|---|---|
| CLOSED | Inicio, Lock, vencimiento | Puerta sellada; ningún nombre/valor sensible visible | Acción local de desbloqueo |
| AUTHENTICATING | Usuario activa desbloqueo | Contraseña en PasswordBox; indicador de validación; mecanismo inmóvil | Autenticación correcta o error |
| UNLOCKING | Núcleo confirma sesión válida | Liberación secuencial de cerrojos, giro de rueda y apertura | Animación termina y núcleo revalida sesión |
| OPEN | Sesión válida y no expirada | Cámara interior y operaciones reales | Lock, cierre de ventana, suspensión o TTL |
| LOCKING | Lock, TTL, fallo de sesión o cierre | Ocultar contenido primero; animar cierre solo si el proceso de bloqueo completó | CLOSED |
| ERROR | Autenticación, I/O o integridad falla | Estado seguro; detalle operativo no sensible y código | Reintento controlado o cierre |

**Invariantes:**
1. CLOSED, AUTHENTICATING y ERROR nunca muestran variables ni notas.
2. UNLOCKING no habilita comandos de datos hasta finalizar y comprobar vigencia.
3. OPEN requiere confirmación del núcleo en cada operación; el estado visual no concede autoridad.
4. Al iniciar LOCKING, retirar inmediatamente de la vista cualquier valor revelado y cancelar operaciones pendientes.
5. Un error durante apertura termina en estado cerrado, nunca en OPEN optimista.
6. La expiración absoluta no se renueva por interacción.

## 5. Secuencia mecánica

**Apertura:** autenticación correcta → breve confirmación de integridad → liberación radial de cerrojos en dos ondas → giro del volante central → apertura de la hoja → transición a cámara interior. Duración orientativa total: 1.4–1.8 s. La secuencia puede reducirse por preferencia de accesibilidad, pero nunca saltarse la autenticación.

**Cierre:** ocultar primero datos y valores → invalidar contexto de sesión → detener trabajo temporal controlado → replegar cámara → cerrar hoja → reinsertar cerrojos → confirmar CLOSED. El cierre lógico ocurre antes del cierre ornamental.

**Movimiento:** aceleración mecánica contenida, frenado perceptible y sin rebotes caricaturescos. Evitar movimiento continuo, loops decorativos o animaciones que retrasen la acción real.

## 6. Cámara interior y operaciones

La cámara abierta contiene compartimentos funcionales identificables:
- **Variables formales:** nombres, fecha de actualización y estado; valores ocultos por defecto.
- **Notas efímeras:** identificador, creación, vencimiento y estado DPAPI; el listado nunca incluye valores.
- **Sesión:** duración seleccionada, tiempo restante, actividad y acción de bloqueo inmediato.
- **Ajustes:** duración de sesión y preferencia de movimiento reducido.

Las operaciones disponibles deben conectarse al núcleo real: desbloquear, bloquear, listar, guardar, reemplazar con confirmación explícita, eliminar, revelar de forma explícita, capturar nota, leer nota con Reveal, promover, eliminar nota y ejecutar una operación headless acotada. Ningún control ornamental se presenta como operativo.

## 7. Sesión y controles temporales

Opciones exactas: 15 s, 30 s, 1 min, 2 min, 3 min, 5 min, 10 min y 15 min. Predeterminado: 5 min desde autenticación correcta. TTL absoluto, no deslizante. El núcleo valida el vencimiento además del temporizador visual; no confiar únicamente en DispatcherTimer.

Cuando vence:
- invalidar la sesión en el núcleo;
- limpiar buffers de claves que sean arrays mutables y referencias de datos;
- ocultar controles y superficies con información;
- cancelar la operación temporal activa;
- cerrar la bóveda y presentar CLOSED.

No declarar borrado perfecto de cadenas administradas ni revocación de copias ya heredadas por otros procesos. El modelo headless evitará heredar secretos indiscriminadamente y limitará los consumidores mediante procesos administrados con duración y alcance explícitos.

## 8. Accesibilidad y calidad

- Todas las acciones críticas deben estar disponibles por teclado.
- Foco visible y orden lógico; Escape inicia bloqueo, no descarta silenciosamente un error.
- Contraste suficiente entre texto, metal y fondo; el color nunca será el único portador de estado.
- Respetar alto DPI y escalado Windows 100–200 %.
- Soportar reducir movimiento: transiciones abreviadas sin eliminar feedback de estado.
- No usar texto minúsculo como decoración ni iconos sin etiqueta accesible.
- Estado de sesión y tiempo restante siempre legibles mientras la cámara está abierta.

## 9. Criterios de aceptación H3

- [ ] XAML, recursos, geometrías y animaciones creados desde cero en rutas nuevas.
- [ ] No se importó ni abrió la GUI anterior como referencia visual.
- [ ] No existen recursos, imágenes, fuentes o controles compartidos con la UI legacy.
- [ ] Estados CLOSED, AUTHENTICATING, UNLOCKING, OPEN, LOCKING y ERROR definidos y probados.
- [ ] Puerta vectorial original con doce cerrojos y rueda central.
- [ ] Apertura/cierre siguen una secuencia legible y fail-closed.
- [ ] Escalado/DPI, teclado y movimiento reducido verificados.
- [ ] Revisión estática de referencias visuales confirma cero dependencias de la UI legacy.

## 10. Dependencias y límites

H3 define la experiencia y sus contratos; no acredita integración funcional ni aceptación final. H4 conectará cada acción al núcleo. H5 implementará y probará el TTL en GUI y CLI. H7/H8 comprobarán la seguridad y la regresión. H10 retirará físicamente la GUI anterior solo después de probar la sustituta, preservar las variables formales y demostrar recuperación.

El formato cifrado formal existente se conserva durante la primera fase por compatibilidad. Toda migración criptográfica o cambio del sobre se trata como operación aparte, versionada y probada primero con datos sintéticos.
