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
