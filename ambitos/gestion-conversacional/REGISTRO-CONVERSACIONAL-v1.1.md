# Registro conversacional · guía operativa v1.3

Contrato normativo: [ART-024](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024) y [P042](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042) del DUG. Esta guía simplifica la materialización; no activa FOL1 ni modifica la IPZ.

## Estado

**FOL1 PREPARADO, no ACTIVO.** No se emiten folios globales CV/CY/A/B. Para un ciclo sustantivo basta una referencia local de evento/ciclo y una entrada consolidada A/B en el OCP. UUIDv7, SES y alias son referencias opcionales; no se generan por rutina ni son requisitos de admisión. Los registros heredados C-/E/S se conservan literalmente como legado, sin crear nuevos ni renumerarlos. El maestro conserva sus contadores y asignaciones actuales; esta guía no lo modifica.

## Fuentes

- [Registro maestro global y por OCP](REGISTRO-MAESTRO-FOLIACION.json): fuente única de asignaciones FOL1 si se activa en el futuro.
- [Esquema del maestro](ESQUEMA-FOLIACION-MAESTRA-v1.0.json) y [esquema A/B](ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json): contratos preparados para ese eventual uso.
- [Índice de conversaciones](REGISTRO-CONVERSACIONES.csv): localizador; no gobierna la continuidad.
- Registros y esquemas E/S históricos: preservados como legado.

## Operación vigente

1. Registrar un ciclo solo cuando exista un cambio material, una decisión, un diagnóstico, una prueba, un resultado o un siguiente paso que altere el estado.
2. Conservar A (entrada literal disponible) y B (salida visible final) dentro de una única entrada consolidada. No crear dos archivos, dos escrituras ni dos folios por sistema.
3. Conservar las referencias de repositorio/frente/OCP y las huellas disponibles. No inventar IDs nativos, UUID, alias, fechas, folios ni cobertura.
4. Leer de vuelta y cotejar una escritura antes de afirmar persistencia. Si falla el registro, informar el límite y continuar trabajo independiente seguro.
5. No archivar razonamiento interno oculto ni secretos; no reconstruir originales ausentes desde memoria.

## Activación futura de FOL1

Solo cuando FOL1 esté expresamente ACTIVO y su maestro sea verificable:
- emitir folios globales y por OCP para conversación, ciclo, A y B;
- usar idempotencia, comparación SHA, reconciliación y lectura de vuelta;
- dejar pendiente únicamente el folio cuya asignación falle;
- no asignar folios retrospectivos ni renumerar registros históricos.

FOL1 no habilita ni modifica la IPZ por sí mismo. Un fallo de foliación no bloquea conversación, responsabilidad ni trabajo independiente.

## Cobertura y límites

El inventario del maestro es KNOWN_INVENTORY_ONLY, no una garantía de exhaustividad. No existe captura automática, sincronización omnicanal ni recuperación de conversaciones no disponibles. El cierre operativo y la emisión de folios son asuntos separados.
