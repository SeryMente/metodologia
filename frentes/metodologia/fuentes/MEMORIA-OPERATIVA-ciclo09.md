# Memoria operativa pertinente · extracto y cobertura

Fuente: Registro Canónico de Errores de Terminal, página7e0a41878241826cb2c781aa2ebd5070. Lectura disponible del ciclo08; no se afirma registro íntegro ni vigencia de otras operaciones. Antes de una cirugía nueva consultar la fuente si el riesgo lo exige. El ciclo09 reutiliza solo las prevenciones pertinentes: datos en archivos, esquema exacto, integridad y alcance antes de escritura. No heredar identidades, rutas de equipos o permisos de perfiles Khora.

## Incidente de preparación del ciclo08 · transcripción del registro emitido

- Operación: preparar localmente el payload de publicación del paquete de migración a ChatGPT.
- Síntoma verbatim: `AssertionError: dict_keys(['base64', 'git_blob', 'sha256'])`.
- Causa raíz: el preparador buscó claves alternativas de hash sin incluir la clave real `git_blob` del exportador.
- Impacto: aborto local antes de escribir el payload o modificar GitHub; archivos descargados y sus hashes no alterados.
- Corrección: usar la clave exacta `git_blob` del esquema adquirido; comprobar que todas las fuentes tienen hash antes de publicar.
- Verificación del registro al escribirlo: aborto confirmado; corrección/publicación pendientes entonces. Evidencia posterior del ciclo08: publicación473db6d7e261867e5a0142b4e0bcb2f6d478d0b4, lectura exacta de diez archivos y gobierno sin cambios. No se modifica retroactivamente aquel recibo.
- Prevención automatizable: validar esquema de la instantánea y hashes antes de construir mutaciones; no adivinar nombres de campos.

## Cobertura limitada

No sustituye el registro completo ni aporta un inventario de operaciones del receptor. Si no se recupera el efecto de una operación, marcar incierto y no repetir. Una copia offline no debe fingir consulta a la página.
