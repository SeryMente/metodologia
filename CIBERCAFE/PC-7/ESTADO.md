# Estado Persistente de Desempeno - PC-7

**Estado:** ACTIVO · memoria persistente de terminal
**Ubicacion:** CIBERCAFE
**Unidad:** PC-7
**Ultima actualizacion:** 2026-10-08

## Identidad de terminal

- Identidad de desempeno: `CIBERCAFE + PC-7`
- RDC observado en esta sesion: `blacksheepsup@gmail.com + e5a4159e-cb32-4ba6-89d6-3a2083a49893`
- Device visible: `PC-7`
- Nota: el device_id RDC es identidad de sesion; no redefine la identidad persistente PC-7.

## Huella de hardware conocida

| Recurso | Estado conocido |
|---|---|
| CPU | AMD Ryzen 5 5600X, 6 nucleos, 12 hilos |
| GPU | NVIDIA GeForce RTX 5060, 8 GB reportados por nvidia-smi |
| RAM | 31.9 GB; modulo Kingston KF3200C16D4/32GX |
| RAM configurada | 2400 MT/s |
| SSD | ADATA LEGEND 900 PRO, ~2 TB, Healthy/OK |
| Sistema | Windows 11 Pro, build 26200 |
| BIOS | ASUS PRIME B550M-K, BIOS 4101 |

## Baseline observado 2026-10-08

| Indicador | Observacion |
|---|---|
| CPU | ~4.7-19.7% durante observaciones de escritorio |
| GPU | 4-8%, 40 °C, P5/P8 en escritorio |
| VRAM | ~646-678 MiB / 8151 MiB |
| RAM | ~31.9-33.1% |
| RAM libre | ~21.4 GB |
| SSD | 0% en lecturas puntuales |
| Espacio C: | 52.8% libre |
| Plan energia | Alto rendimiento |

## Cambios validados

### 2026-10-08 - Perfil de energia

Se activo el plan `Alto rendimiento`.

Configuracion AC observada: estado minimo de CPU 100%, maximo 100%.

Resultado inmediato: sin carga anomala observable; mantener y continuar observacion.

## Oportunidades pendientes

1. RAM operando a 2400 MT/s pese a modulo con especificacion nominal 3200; investigar perfil XMP/DOCP/BIOS antes de cambiar firmware.
2. Driver NVIDIA instalado 610.47; paquete 617.42 preparado y firmado por NVIDIA, pero la instalacion no se ejecuto durante actividad del usuario.
3. BIOS 4101; investigar version y beneficio real antes de cualquier actualizacion.
4. Procesos de inicio de Steam/Epic/Riot y otros deben evaluarse por impacto y por necesidad en contexto de cibercafe, nunca eliminarse solo por existir.

## Reglas de continuidad

- Reutilizar la huella de hardware mientras no exista evidencia de cambio.
- Revalidar variables dinamicas antes de una intervencion.
- No repetir diagnosticos profundos ya resueltos sin causa de invalidacion.
- Registrar cambios, rollbacks, regresiones y decisiones.
- Mantener la observacion aun cuando no exista una accion inmediata.

## Sincronizacion

- Ultima persistencia conocida: 2026-10-08.
- Cursor de eventos: ver `EVENTOS-2026-10.md`.
- Muestras de alta frecuencia: permanecen locales y no se publican una por una.
