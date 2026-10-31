# C-GOBERNANZA-PERSISTENCIA-DOCUMENTAL-01 · Incorporación de exportación y transferencia de responsabilidad

**Fecha:** 2026-10-30. **OCP:** `frentes/gobernanza/`. **Estado en este punto:** escritura preparada; lectura de vuelta pendiente.

## Encargo, autoridad y alcance

El operador indicó literalmente: «ChatGPT-GOBERNANZA-20261030-1857.md usa rdc local para ir a downloads y adjuntar este texto a persistencia documental de frente GOBERNANZA, y asume repsonsabilidad del frente».

La instrucción autoriza preservar el archivo original en el OCP de Gobernanza y transferir la titularidad del frente a esta sesión. No autoriza una modificación normativa del DUG, ART-025, IPZ nativa, activación de FOL1 ni transferencia del OCP separado `ambitos/tareas/`.

## Fuente y custodia

- Dispositivo RDC: PC-14 (Windows).
- Ruta de origen: `C:\\Users\\PC 13\\Downloads\\ChatGPT-GOBERNANZA-20261030-1857.md`.
- Ruta canónica del original: `documentos/originales/ChatGPT-GOBERNANZA-20261030-1857.md`.
- Tamaño observado: 177,693 bytes; 3,391 líneas.
- SHA-256 de origen: `73C0BDA50D67840782C6E1B98A4F14803184CD029FB62D1A60CE77589CCA6C48`.
- Git blob creado para el contenido original: `5f6754d1eda125056b661cb7505614cb988eafa5`.
- Método: lectura local por RDC, transporte Base64 y creación de blob con `encoding=base64`; no se transformó el texto.
- Manifiesto: `documentos/MANIFIESTO-DOCUMENTAL.json`, entrada `DOC-GOV-CHATGPT-GOBERNANZA-20261030-1857`.

El estado documental de la entrada se mantiene `ESCRITO_NO_VERIFICADO` hasta que la lectura de vuelta desde `main` se coteje byte por byte contra los bytes de origen.

## Transferencia de responsabilidad

El control observado antes de escribir identificaba titularidad activa en generación 6:
- Titular anterior: `chatgpt-C-GOBERNANZA-RETOMA-05-SES-20261030-GV89CFA5D5`.
- Sesión anterior: `SES-20261030-GV89CFA5D5`.
- Blob SHA anterior del control: `f670960bdedf1a4747743b3216cd181722a924ec`.
- HEAD de `main` observado: `1dd4c4e35d5097d28485b86c0f37ec0faf096cb9`.

Autorización de sustitución: instrucción explícita del operador en este hilo. Se preparó el relevo:
- Evento: `C-GOBERNANZA-RETOMA-06`.
- Titular receptor: `chatgpt-C-GOBERNANZA-RETOMA-06-SES-20261030-GVC9594230`.
- Instancia: `chatgpt-gobernanza-documental-2026-10-30-C9594230`.
- Sesión: `SES-20261030-GVC9594230`.
- Generación nueva: 7.
- UUIDv7 local: `01a18f86-7da3-7135-8012-c3dbc9594230`; es un identificador operativo local, no un ID nativo de ChatGPT.
- Comprobación de colisión: cero apariciones en nueve controles de responsabilidad hermanos accesibles; no se afirma unicidad global ni exclusión técnica de escritores ajenos al control.
- Folio de ciclo global: no asignado; FOL1 sigue preparado, no activo.

El archivo original, el manifiesto, los índices del frente y el control se incluyen en el mismo commit para que el cambio sea coherente. La escritura del control utiliza el SHA observado del archivo y la actualización de `main` debe condicionarse al HEAD observado.

## Estado canónico preservado y límites

La fuente normativa consultada fue el DUG **v373 · NX-373m** (GOW 2.14). Esta operación no modifica el DUG, ART-025 ni el campo IPZ nativo. Tampoco modifica, adquiere ni transfiere `ambitos/tareas/`. No se activa FOL1 ni se crean folios globales de conversación/ciclo/A/B.

## Verificación requerida para cerrar

1. Confirmar que el avance de `main` se realizó con compare-and-swap contra el HEAD observado.
2. Leer el original desde la ruta canónica del repositorio con `encoding=base64`.
3. Comparar el Base64 leído de vuelta con los bytes Base64 de origen; cotejar el SHA-256 observado y el blob SHA.
4. Leer de vuelta el manifiesto y el control; confirmar la entrada documental, generación 7, alias y transferencia.
5. Solo entonces cambiar el estado a `PERSISTIDO_Y_VERIFICADO` y cerrar esta crónica/evidencia.
