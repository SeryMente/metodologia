# EP Vault — Pulido industrial y secuencia mecánica realista

Fecha: 2026-11-08  
Frente / tarea: EP-TASK-004  
Base revisada: `feat/ep-vault-clean-room-20261108` · commit `9a5f0c686b8533878610d08e52cef427ad3f0933`  
Destino: Fila4 / paquete local `%LOCALAPPDATA%\Khora\tools\ep-vault`

## Estado y propósito

Este documento define el siguiente trabajo de H3/H4 para que Samantha lo implemente. **No es evidencia de que el código o los recursos de audio ya hayan sido modificados.** La autorización del operador cubre el pulido visual y sensorial dentro de EP-TASK-004; no cambia la asignación de roles del OEP §13.

La revisión de Fila4 encontró una puerta radial dibujada en un Canvas WPF, 12 cerrojos, un volante y una animación que libera los cerrojos en 620 ms, gira el volante 165° en 1.05 s y desplaza/desvanece el disco en aproximadamente 1.35 s. No se localizaron referencias a `MediaPlayer`, `SoundPlayer` ni archivos de audio en `src`. El efecto actual es una ilustración animada, no una apertura mecánica convincente.

## Dirección de arte

Objetivo: una bóveda industrial antigua, pesada y funcional. Debe parecer fundida, mecanizada y usada durante décadas; no una interfaz sci-fi ni un objeto dorado decorativo.

### Paleta propuesta

| Uso | Color |
|---|---|
| Vacío / fondo profundo | `#050708` |
| Carbón | `#090E10` |
| Hierro ennegrecido | `#121719` |
| Acero pavonado | `#20282B` |
| Acero mecanizado | `#303A3E` |
| Borde frío / reflejo | `#596367` |
| Pátina oscura | `#35413F` |
| Óxido discreto | `#493027` |
| Latón envejecido, acento menor | `#66543D` |
| Latón apagado para indicadores | `#88714E` |
| Texto primario | `#C4C5BE` |
| Texto secundario | `#858D8E` |

Reducir el latón/dorado a menos del 4 % de la superficie percibida: únicamente tornillería, grabados o indicadores puntuales. Eliminar los reflejos dorados brillantes actuales (`#C3A36A`) de bordes, líneas y controles. No sustituirlos por naranja saturado.

### Materiales y geometría

- Mantener la regla clean-room: la escena y sus recursos se crean desde cero; no reutilizar UI legacy.
- Dar espesor aparente al marco y a la puerta: aro exterior fijo, placa de cierre, reborde biselado, junta/sello perimetral y cavidad interior oscura.
- Sustituir los círculos concéntricos uniformes por capas con variaciones controladas: acero fundido, caras mecanizadas, soldaduras, marcas de torno, tornillos hexagonales, arañazos direccionales, golpes pequeños y oxidación en juntas.
- Usar luces laterales rasantes y reflejos fríos estrechos para revelar relieve. Evitar glow uniforme, cromado espejo, degradados limpios de plástico o grano excesivo.
- Los elementos móviles deben ser piezas distintas de la estructura fija. No desplazar ni desvanecer todo el disco como una sola lámina.
- Preferencia técnica: escena WPF `Viewport3D` o composición 2.5D con capas, perspectiva, biseles y sombras físicamente coherentes. Si se conserva Canvas, debe justificarse el límite y lograr primero una simulación convincente de profundidad; no llamar “3D” a una escena plana.

## Coreografía de apertura

La autenticación debe concluir correctamente antes de comenzar cualquier animación o sonido. Un fallo mantiene la puerta sellada y no reproduce la secuencia de apertura.

Duración objetivo: 5.5–6.5 segundos; la sensación debe ser de masa, fricción y resistencia, no de transición rápida.

1. **Pre-carga (0.0–0.4 s):** vibración mínima del conjunto y un golpe seco de embrague/relé. Estado `DESBLOQUEANDO`.
2. **Retirada de cerrojos (0.4–1.8 s):** los pasadores se retraen por grupos con desfase; primero libera el seguro principal, luego laterales y finalmente superiores/inferiores. Cada pieza debe detenerse con un pequeño tope mecánico.
3. **Volante (1.2–2.8 s):** giro pesado, aceleración lenta, un punto de resistencia y descarga de inercia. No usar velocidad angular constante.
4. **Ruptura del sello (2.7–3.5 s):** junta perimetral que cede, pequeño desplazamiento inicial de la puerta, vibración estructural y liberación breve de presión.
5. **Giro de puerta (3.4–5.8 s):** pivote sobre bisagra lateral desplazada; el canto debe mostrar espesor. Añadir parallax y sombra proyectada. La puerta empieza con resistencia, gana velocidad y desacelera por su propia masa.
6. **Asentamiento (5.8–6.4 s):** tope metálico profundo, oscilación residual corta y luz tenue dentro de la cámara. Solo entonces pasar a `ABIERTA`.

La apertura no debe terminar con un simple fade del disco. La estructura del marco permanece inmóvil y visible.

## Coreografía de cierre

Secuencia inversa, pero no espejo mecánico exacto: la puerta retorna lentamente, asienta contra la junta, el volante gira en sentido inverso y los cerrojos entran uno a uno. El último pasador produce el golpe final de cierre. Solo después se confirma `SELLADA`, se limpia la vista sensible y se invalida la sesión conforme al TTL ya definido.

## Diseño sonoro

Crear sonidos originales, locales y sin dependencias de red. No descargar ni reutilizar grabaciones comerciales.

Recursos previstos, en WAV mono/stereo según mezcla:
- `bolt-release.wav`: pasadores de acero con golpe corto y cola metálica.
- `wheel-under-load.wav`: rueda/manivela con fricción irregular, chirrido grave y tensión.
- `seal-break.wav`: junta comprimida que se separa, con un soplo breve de presión.
- `hinge-groan.wav`: chirrido profundo y áspero, con armónicos metálicos; debe evolucionar con el ángulo de apertura.
- `door-stop.wav`: impacto grave, corto, con resonancia de estructura.
- `bolt-lock.wav`: enclavamiento final, seco y contundente.

Requisitos:
- Reproducción local mediante un componente WPF apropiado (`MediaPlayer` o equivalente), no mediante un servicio externo.
- Sin sonido al iniciar la app ni antes de autenticar. Reproducir solo por acción explícita del mecanismo.
- Mezclar eventos con pequeñas diferencias temporales y volumen; evitar una pista única repetida que suene a efecto de videojuego.
- Control visible de silencio/volumen, respetar el volumen del sistema y ofrecer una opción de movimiento reducido que también suprima o simplifique los efectos sonoros.
- La ausencia o fallo de un WAV no puede bloquear autenticación, cierre ni expiración de sesión. Capturar errores y degradar a modo silencioso.
- No reproducir sonido en `ERROR`, en autenticación fallida ni cuando la sesión ya haya vencido.

## Criterios de aceptación

- [ ] Paleta más oscura, predominantemente hierro/acero; latón/dorado solo como acento menor.
- [ ] La puerta tiene espesor, bisagras y junta visibles; el marco fijo no se mueve.
- [ ] Los cerrojos se liberan por etapas y se reconocen como piezas separadas.
- [ ] El volante transmite resistencia y tiene aceleración/desaceleración no lineal.
- [ ] La puerta pivota alrededor de una bisagra lateral; no desaparece por opacidad ni se desliza como una tarjeta.
- [ ] La apertura/cierre tiene impactos, asentamiento y vibración residual moderada.
- [ ] Los sonidos son originales, locales, sincronizados y opcionales.
- [ ] Autenticación fallida nunca abre la cámara ni dispara sonido de apertura.
- [ ] TTL, cierre por expiración, limpieza de vistas y estados de seguridad no se alteran por el trabajo visual.
- [ ] Movimiento reducido, mute, teclado, DPI y resoluciones habituales se prueban.
- [ ] La suite sintética pasa en Windows PowerShell 5.1; se repite prueba WPF de apertura, cierre, error y vencimiento.
- [ ] Ningún perfil formal, variable real, contraseña, nota efímera o bóveda productiva se usa como fixture.
- [ ] Registrar SHA-256 de código y WAV, resultado de pruebas, captura de preview sintético y read-back de la rama antes de entregar.

## Restricciones que siguen vigentes

- No inicializar, leer, autenticar ni modificar la bóveda formal de Fila4 ni el archivo de vault no atribuido de PC-14.
- No tocar BitLocker como parte del pulido. La protección de disco sigue siendo un control independiente.
- No realizar captura de secretos reales hasta que se satisfagan los requisitos de protección de host del OEP.
- No introducir telemetría, red, servicios remotos ni reproducción automática.
- Samantha conserva la escritura del código conforme al OEP §13; Claudia puede documentar, coordinar y revisar.


## Ejecución local y estado as-built · 2026-11-08

La especificación dejó de ser solo propuesta: el pulido se implementó localmente en PC-14 y se replicó en el perfil de Fila 4. El siguiente bloque describe lo que existe realmente; no sustituye la aceptación visual presencial.

### Cambios entregados en el código local

- Paleta trasladada a hierro ennegrecido, acero pavonado, carbón y grafito. Los tonos dorados brillantes se sustituyeron por reflejos fríos de acero; el latón queda reducido a acentos residuales. El escaneo de los tokens de oro anteriores devuelve cero coincidencias.
- La puerta Canvas conserva su diseño clean-room, ahora con abrasiones deterministas, arañazos radiales y pequeñas marcas de oxidación.
- El marco de ventana solicita el modo oscuro nativo de DWM, con fallback seguro si el sistema no lo admite.
- Se añadió el control visible **SONIDO** para silenciar o habilitar los efectos. Si Windows tiene movimiento reducido, se omiten la animación de apertura y su audio.
- El giro se cambió a un pivote lateral (centro local x=64) y se añadió compresión horizontal hasta 0.86 durante la apertura para sugerir profundidad/bisagra. Sigue siendo una escena WPF 2D/2.5D; no es un modelo 3D físico ni una simulación CAD.
- Se generaron dos WAV originales, locales y sin dependencias externas: `Vault-Open-Creak.wav` (6 s) y `Vault-Close-Latch.wav` (3 s). Son efectos procedurales sintetizados con fricción, armónicos resonantes, golpes y reverberación corta; no son grabaciones de una bóveda real.
- Core, CLI y GUI mantienen el contrato de sesión compartida: registro DPAPI CurrentUser, TTL absoluto, CLI reuse sin segundo prompt, Lock con revocación interproceso y GUI monitor cada segundo.

### Coreografía realmente implementada

**Apertura (~5.85 s):** pasadores con desfase de 38 ms, viaje de 1.28 s; el volante comienza a 0.92 s y gira durante 2.35 s; el giro/desplazamiento de la hoja comienza a 2.28 s y dura 3.15 s; compresión horizontal 1.00 → 0.86. El panel de cámara aparece al final del temporizador de 5.85 s.

**Cierre (~2.85 s):** la hoja vuelve al marco; volante y cerrojos siguen en etapas posteriores. La sesión se invalida y las vistas se limpian antes del movimiento, como exige el contrato de seguridad.

### Archivos de sonido

| Archivo | SHA-256 |
|---|---|
| `assets/audio/Vault-Open-Creak.wav` | `83CD305566EEC7545F676CAD7A65B502151FBB2AAEDA13402C3991C9E5F98D2E` |
| `assets/audio/Vault-Close-Latch.wav` | `EAC3DBEC8BE5A65E30188E9633810B25AFAE0F3F0B252F94D35CB29909B184D2` |

### Validación local en ambos dispositivos

- `Test-EPVault.ps1`: `EP_VAULT_VALIDATION_PASS`, exit code 0, posterior a la actualización de GUI, XAML y aserciones de sonido.
- Parser PowerShell 5.1, XAML parse/name contract, clean-room scan, criptografía, rechazo de password/tamper, ocho TTL, allowlist, Job Object, DPAPI notes, CRUD, backups y redacción de logs: PASS.
- Nuevo bloque de regresión: presencia de SoundToggle, cableado mute, titlebar DWM, textura rústica, tiempos de apertura/cierre y firma RIFF/WAVE de ambos recursos: PASS.
- `SoundPlayer.Load()` en los dos WAV: PASS.
- Sesión CLI/GUI compartida probada de forma sintética en ambos equipos: CLI reutiliza sin prompt adicional; Lock desde otro proceso revoca la sesión original.
- Hash canónico de contenido cotejado entre PC-14 y Fila 4 (UTF-8, LF normalizado, BOM y terminadores finales excluidos):
  - Core `05622BCDFFA2D5CB8DB775A6FE28E4D7ED1231C422595F7D366AAA1B9061EBBC`
  - CLI `35140DA1ED9F4BB2CDC29898F67C0102738DB828A4C7D2B523B8BB2B6B1BCAD1`
  - GUI `4938FE594C9B37B3E192C2645595EDFD5200E52D4E72E9596F8E10C0C5DE8D93`
  - XAML `A4185C553116AC9665CA9626F2402577A4BB9FFA372BF6C600B69D91FC639A6B`
  - Tests `88B7CBF29BBEF4ACE2DECD3C96739D17C40D4E2A31A9A152B8E933EB07A3BD24`

### Límites y aceptación

La validación es sintética y automatizada; no sustituye una revisión visual/auditiva del operador ni una prueba E2E desde la sesión interactiva Fila4. No se inspeccionó ni modificó la bóveda formal PC-14 de 576 bytes, cuya procedencia continúa NO ATRIBUIDA; Fila4 no tiene archivo formal. No se leyeron secretos, no se usó el portapapeles y no se modificó BitLocker. La recolección de credenciales reales sigue sujeta al gate de cifrado del host. La asignación de roles Claudia/Samantha está en el bloque LEER PRIMERO del OEP, no en su sección numerada 13; la cita anterior a «OEP §13» queda rectificada.


## Rectificación final — bisagra lateral, mute y prueba interproceso permanente · 2026-11-08

La última iteración de PC-14/Fila4 añadió un pivote de bisagra lateral (centro local x=64), compresión de la hoja de 1.00 a 0.86 mientras abre y un control `SONIDO` visible para silenciar o activar los efectos. El código omite efectos sonoros cuando `ClientAreaAnimation` está desactivado. El sonido se mantiene opcional; los WAV son síntesis procedural original, no grabación física de metal.

**Tiempos finales:**
- Pasadores: 1.28 s con desfase escalonado de 38 ms.
- Volante: inicia en 0.92 s y dura 2.35 s.
- Puerta: inicia en 2.28 s, gira y se desplaza durante 3.15 s; termina aproximadamente a 5.85 s.
- Cierre: aproximadamente 2.85 s, con volante y cerrojos en fases posteriores.

**Regresión permanente:** `Test-EPVault.ps1` ahora crea bóveda/valor sintéticos, inicia un CLI en proceso independiente, exige que liste el nombre sin solicitar password y comprueba que `Lock` desde el CLI revoca la sesión del proceso padre. Esta prueba forma parte de la suite usada por CI, no solo de un ensayo manual.

**Límite visual:** el resultado es WPF vectorial con cues 2.5D; no es una escena 3D físicamente exacta. La aceptación visual/auditiva del operador y la prueba E2E desde la sesión interactiva Fila4 siguen siendo necesarias antes de H10.


---

## Diseño visual hiperrealista v2 — congelación previa a implementación · 2026-11-09

**Estado:** DISEÑO DEFINIDO PARA IMPLEMENTACIÓN; aceptación visual humana pendiente.  
**Autorización:** instrucción directa del operador: «sin elementos de fantasía en la GUI. Realismo, no obstante, si. Es una simulacion de boveda inmersiva»; precisión posterior: «hiperrealista sería el término» y orden de diseñar antes de implementar.  
**Base:** materiales, geometría y coreografía de este mismo documento; no se introduce una dirección de arte alternativa.

### 1. Concepto visual bloqueado

Simulación inmersiva de una cámara acorazada industrial de alta seguridad, construida para resistir décadas de uso. Debe parecer un mecanismo físico de ingeniería pesada, no un videojuego ni una interfaz de ciencia ficción. Referencias materiales: acero al carbono pavonado, acero mecanizado, fundición oscura, juntas elastoméricas, tornillería industrial y huellas moderadas de mantenimiento.

Se prohíben hologramas, HUD flotantes, neón, circuitos luminosos, glows decorativos, partículas, rayos, runas, ornamentos fantásticos, metales dorados brillantes, transiciones de tarjeta, desvanecimiento de la hoja o movimiento de toda la escena como una lámina plana.

### 2. Composición y jerarquía

- **Escena principal (aprox. 65–70 % del área):** puerta circular acorazada a escala visual dominante, observada casi frontal con perspectiva oblicua ligera de tres cuartos. Debe ocupar el foco visual sin tapar los controles.
- **Marco fijo:** brida circular empotrada en un muro de hormigón/metal oscuro, aro exterior grueso, garganta interior, alojamientos de bisagra y fijaciones de anclaje. Permanece inmóvil durante toda la secuencia.
- **Hoja móvil:** disco de acero con espesor visible, canto mecanizado, bisel perimetral, contraplaca, reborde de compresión y junta de sellado. Deben distinguirse el plano frontal, el canto y el retroceso respecto al marco.
- **Mecanismo:** volante central de ocho radios con cubo y eje, doce bulones radiales independientes, tres conjuntos de bisagras laterales con placas y barriles, retenes y alojamientos.
- **Acceso:** panel de autenticación lateral sobrio e integrado; no se superpone a la puerta ni simula botones físicos de fantasía.
- **Jerarquía funcional:** estado y TTL legibles; lista de variables/notas y acciones solo después de autenticar. La escena no revela nombres, valores ni metadatos sensibles.

### 3. Materiales y acabado

WPF no ofrece un pipeline PBR completo ni sombras físicas de motor de videojuego. El objetivo es una simulación 3D geométrica convincente con iluminación y respuesta especular controladas; no se describirá como renderizador CAD ni fotográfico real.

| Pieza | Material / acabado |
|---|---|
| Muro y cámara | Hormigón grafito mate, cavidad negra sin reflejo |
| Brida fija | Acero fundido oscuro, gran espesor y aristas suavizadas |
| Cara de puerta | Acero pavonado, satinado industrial y desgaste direccional |
| Biseles / caras torneadas | Acero mecanizado con reflejo estrecho y controlado |
| Bulones y tornillería | Acero endurecido, cabezas hexagonales y chaflanes |
| Junta | Elastómero negro, compresión visible antes de abrir |
| Zonas de roce | Pulido localizado en aristas, sin brillo cromado |
| Oxidación | Pátina marrón-gris localizada en ranuras; nunca salpicaduras decorativas |

**Paleta:** carbón #080B0D; cavidad #0B1012; acero pavonado #20282B; fundición #30383A; acero mecanizado #536065; reflejo frío #A8B0B2; pátina #343B38; óxido oscuro #49372F; texto #C4C9C7. No se utilizará cian/neón como luz decorativa.

La superficie tendrá marcas de torno concéntricas muy finas, arañazos direccionales cortos, pequeñas marcas de herramienta, tornillería avellanada y juntas con variación tonal. No cubrir la pieza de ruido/grano; geometría y luz deben producir la sensación de material.

### 4. Geometría y cámara

La escena utilizará Viewport3D, PerspectiveCamera, mallas trianguladas y GeometryModel3D reales para los elementos principales. Cada componente móvil tendrá grupo y transformaciones locales independientes: marco y brida fijos; hoja y canto con pivote en la línea de bisagras; volante sobre su eje; bulones con recorrido radial; bisagras fijas con barriles y placas; junta que se separa de la brida al liberar la hoja.

Cámara casi frontal, con perspectiva suficiente para leer 0.35–0.45 unidades de espesor en la hoja; campo visual aproximado de 35–42°. La cámara no se mueve para simular una explosión ni para sustituir el movimiento del mecanismo.

**Límite técnico:** iluminación ambiental y direccional más reflejos especulares por material; no afirmar sombras dinámicas físicamente exactas si WPF no las calcula. Cualquier sombra será una aproximación documentada, no un efecto luminoso.

### 5. Coreografía mecánica de apertura

Duración objetivo: 6.2–6.8 s. La autenticación válida debe estar confirmada antes de sonido o movimiento.

| Tiempo aprox. | Operación física |
|---|---|
| 0.0–0.35 s | Precarga del tren de bloqueo; golpe amortiguado de embrague |
| 0.35–1.9 s | Bulones se retraen por grupos con recorrido individual |
| 0.95–2.9 s | Volante gira con aceleración, resistencia y asentamiento |
| 2.5–3.3 s | La junta perimetral libera compresión; la hoja se separa apenas del marco |
| 3.2–6.2 s | La hoja rota sobre eje vertical lateral; el canto y el espesor permanecen visibles |
| 6.2–6.6 s | Tope mecánico y oscilación residual leve; aparece la cámara interior |

La puerta no se desvanece, no se desliza como tarjeta y no se escala para fingir profundidad. Marco y cámara permanecen fijos. El ángulo final debe permitir ver la cara interior y el canto; no se busca que la hoja desaparezca fuera del viewport.

### 6. Coreografía de cierre

Primero se revoca la sesión y se eliminan vistas/datos sensibles; después empieza el cierre físico. La hoja vuelve con desaceleración controlada, comprime la junta, el volante gira inversamente, los bulones entran por grupos y el pasador principal produce el golpe final. Solo al terminar se confirma SELLADA. TTL y revocación de sesión no dependen del éxito de la animación.

### 7. Sonido y accesibilidad

- Efectos locales originales, sincronizados con el mecanismo y opcionales; ausencia/fallo de WAV nunca bloquea autenticación, cierre o TTL.
- Sin sonido de apertura al iniciar, autenticar fallidamente o expirar sesión.
- SONIDO y movimiento reducido conservan su función; movimiento reducido evita interpolaciones y audio mecánico no esencial.
- Foco inicial, navegación de teclado, DPI y escalado de ventana se prueban sin alterar controles nativos de contraseña.
- Campos PasswordBox vacíos en perfil limpio; nunca inspeccionar sus contenidos para pruebas.

### 8. Verificación y corte

- Parser PowerShell 5.1, carga XAML y contrato de nombres: obligatorios.
- Geometría: Viewport3D, cámara perspectiva, mallas de puerta, marco, bisagras, bulones y volante; elementos móviles con transformaciones independientes.
- Regresión de autenticación, cifrado, notas DPAPI, TTL, allowlist, redacción de logs y revocación interproceso: sin cambios de semántica ni debilitamiento.
- Prueba de apertura/cierre, error, expiración y reduced-motion en perfil sintético limpio.
- Render WPF de preview, inspección visual humana y lectura de vuelta de SHA/PR antes de cerrar H3/H4/H10.
- La aceptación final permanece pendiente mientras no exista render revisado desde el entorno interactivo y confirmación humana.

