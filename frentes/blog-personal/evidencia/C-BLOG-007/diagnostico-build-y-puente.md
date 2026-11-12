# C007 · diagnóstico focal, no reparación ni build completo
Fuente tsconfigc0dcb2e blobe7ff3a26b4400007243cc9a73fea3d9307e795a3. Include**/*.ts incorpora tests que el chequeo anterior núcleo+JSX omitió.

Salida ejecutada con TypeScript5.9.3/ES2017/strict/bundler/libdom+dom.iterable+esnext, resolución @typesReact local explícita:
```text
EXACT_CURRENT_SOURCE 1
Property 'revision' does not exist on type 'never'. 2339 tests/unit/blog-text-workflow.test.ts 44
FIX_IN_MEMORY 0
```
La primera alternativa Boolean daba0pero podía debilitar igualdadnull. Se descartó a favor de snapshot exacto, también probado EN MEMORIA:
```text
PRESERVE_EXACT_NULL_ASSERTION_IN_MEMORY 0
```
Corrección propuesta: en ese test sustituir `assert.equal(next.preview,null);` por `const initialPreview=next.preview;assert.equal(initialPreview,null);`. Getter ya no queda estrechado a null a través de await; se conserva aserción estricta original, sin casts ni cambio de producto. NO se escribió/push ni desplegó. No confirma única causaVercel sin logs reales; no es fullbuild.

Puente leído enc0dcb2e: IngresoWorkspace guarda draft.body=texto (1213–1214), recibo(1301–1303), monta consumidor(1642). PublicacionCapturaPendiente usa recibo sourceid/version/hash y literalpreparation, POSTprepare con exactdigest/previas; decisión conjunta y estado. Enlace de código existente, NO ejecución real de mic/dictado→entrega pública. Nueva BlogTextWorkspace solo restaura su journal de referencias o archiva texto manual; NO consume intenciones editoriales de Ingreso. No suponer que añadir otra captura arregla intención.

Límites/copias: referencias Git y evidencias son portables; rutas /data/herramientas actuales no se presuponen disponibles al migrar. No credenciales ni texto autobiográfico real leído/publicado.
