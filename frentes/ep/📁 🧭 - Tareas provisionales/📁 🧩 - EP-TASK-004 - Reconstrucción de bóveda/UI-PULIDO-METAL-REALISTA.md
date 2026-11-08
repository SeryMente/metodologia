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
