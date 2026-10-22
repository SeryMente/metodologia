# Cotejo de conversación e implementación · revisión 1

Original íntegro conservado, incluida toda la salida visible exportada. Cada fila enlaza un ancla literal y su contexto; interpretación y estado separados. No equivale a una firma L0 ni a medir el delta semántico.

| Ref. | Línea original | Encargo / precisión | Estado | Evidencia / límite |
|---|---:|---|---|---|
|R01|2|Adquirir repositorio y método, sin fingir acceso|implementado|snapshot.json; preflight del publicador|
|R02|16|Portabilidad general ante agotamiento de acceso|parcial|kit/0.1.0; ensayo con modelo gratuito pendiente|
|R03|54|Uso general; gratuito es condición importante, no propósito exclusivo|incorporado|INICIO.md; no restringir proveedor|
|R04|54|Auditar fidelidad, coherencia, operación y portabilidad sin cargar lectura al usuario|parcial|esta matriz; auditoría semántica integral pendiente|
|R05|93|Recolectar y formalizar bloques coherentes; distinguir propuestas|implementado-documental|PENDIENTES.md; matriz y originales|
|R06|93|Formalizar características según práctica, no inventar complejidad|incorporado|metacanon §§29–34; revisión futura|
|R07|93|Contexto externo reconstruible distinto de memoria interna|implementado-mecánico|continuidad.cjs state/projection; M15,M16|
|R08|125|Guardar originales de ambas partes con procedencia y cobertura|parcial-verificado|adjunto exacto y diálogo disponible; no captura futura|
|R09|93|Segmentos de plataforma/chat/modelo; rol solo conocido; no ordenar concurrencia ficticia|incorporado|metacanon §30 y metadatos de sesión|
|R10|125|Directorio completo; núcleo ligero, no índice vacío ni monolito|parcial|kit resume proyección literal; refactor físico del canon pendiente|
|R11|163|Criterio técnico independiente; no ratificar propuestas por complacencia|regla-de-conducta|no métrica automática de sinceridad|
|R12|252|Arquitectura ratificada; no volver a presentar la decisión como propuesta|incorporado|metacanon §29|
|R13|252|Espejos del frente para documentos de aplicaciones|parcial|dos snapshots LISA/Harmonia; sincronía no acreditada|
|R14|252|Glosario: nombre corto y organización SeryMente como workspace|incorporado|metacanon §§29,31|
|R15|252|Sincronización aplicación→repo sin IA activa y detección de fallos|pendiente|SYNC-01; no se instala servicio ni permisos nuevos|
|R16|289|Deuda destacada, expresamente diferida; no exponer secretos|diferido-explícito|SEG-01; repositorio privado y escaneo limitado|
|R17|325|Un gobierno Samantha; SI histórico; PRIUS después, no activar|parcial|espejo333 intacto; origen Notion no verificable|
|R18|353|Mismo metaprompt, espejo no segundo gobierno|incorporado|gobernanza intacta; no afirmar sincronización|
|R19|377|Persistencia seamless entre conversaciones como prioridad máxima|parcial-probado-mecánico|kit/0.1.0; ensayo intermodelo pendiente|
|R20|399|Prompt estable apunta al estado vivo, no resumen incrustado|implementado-documental|PROMPT-UNIVERSAL-REINSTANCIACION.md y ARRANQUE del kit|
|R21|429|Iteraciones aisladas, límites súbitos, preservar dinámica Samantha|implementado-mecánico|ensayo.py regresión y laboratorio.cjs; no tocar MP|
|R22|440|Priorizar, conservar todas las notas y pendientes consultables|implementado-documental|matriz completa de anclas + PENDIENTES|
|R23|450|No pedir redictado; carga nativa Notion vs explícita; no confundir con sincronía|parcial-probado-mecánico|M07,M08; persistencia de mensajes disponibles|
|R24|495|Prompt, recibo por paso, medición y versionado por actualización|implementado-mecánico-documental|kit0.1.0; protocolo0.2; recibo; resultados con versión|
|R25|514|Literal→intención→construcción; recuperar LISA y vectores existentes|parcial|snapshot LISA1.2 y esta matriz; L0 no firmado, delta semántico no calculado|
|R26|517|Observador Harmonia de eventos visibles, prioritario ChatGPT|pendiente|snapshot Harmonia histórico; contrato técnico/seguridad actual no adquirido|
|R27|517|Laboratorio local vía conexión remota con indicadores y datos|implementado-mecánico|laboratorio Node reproducible aislado; evidencia Windows separada|
|R28|517|Percepción del operador; medir fallos visibles, no atribuir motivos sin evidencia|antecedente-no-hecho|no medir pensamiento interno ni causas comerciales|
|R29|289|Preservar error de dictado y repetición; normalizar a frentes solo al interpretar|incorporado|adjunto exacto; no corrección silenciosa|
|R30|46|Aviso entre frentes sobre Ética: no autoriza mutarla|sin-mutación|ningún archivo de Ética incluido|

## Fuentes recuperadas

LISA: Logic and Intent Specification Architecture, canon v1.2. El vector de intención L0 no es automáticamente un embedding; requiere ratificación/firma del operador. No se activa ese protocolo ni se inventa un vector firmado. Se implementa trazabilidad documental con referencias de requisito, no la cadena formal completa hasta código ni su validador semántico.

Harmonia: hub documental de julio, útil para identificar Aisthesis como dominio transversal de telemetría, no prueba de contrato técnico actual ni de observador instalado. El término dictado «Cloud» queda literal; no se afirma que sea Claude.

No se repite ni cambia la prioridad diferida de seguridad/cifrado y Sesión PRIUS. Esta implementación conserva el metaprompt byte a byte.
