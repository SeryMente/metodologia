# C-MCP-JULES-008 · revisión R2 y cierre integral de Fase 1

**Fecha:** 2026-10-29. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Gobierno:** DUG Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9. **Evento:** C-MCP-JULES-008.

## Motivo de revisión

El cierre R1 (C-MCP-JULES-007) no resolvió de manera suficiente el requisito de uso desde ChatGPT Free. Su análisis se concentró en la conexión MCP personalizada privada y no investigó de forma completa la distribución de un plugin MCP público. También dejó ambigua la prohibición de Codex expresada por el operador. Se reabrió el cierre documental de Fase 1, sin iniciar implementación.

El operador confirmó expresamente que Codex no se utilizará nunca en el futuro previsible. Esta restricción se incorpora como invariante del producto: no se usará en desarrollo, pruebas, publicación, instalación, operación, documentación de instrucciones ni contingencias.

## Investigación de compatibilidad y decisión de diseño

Fuentes oficiales de OpenAI consultadas el 2026-10-29:

- [Conexión de servidores MCP personalizados](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt): la compatibilidad completa con MCP y escritura se documenta para Business y Enterprise/Edu; Pro dispone de lectura/recuperación. No se presume que Free pueda conectar directamente un MCP personalizado con escritura.
- [Plugins en ChatGPT](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt): el directorio está disponible en distintos planes, pero el uso de cada plugin depende de plan, región, cuenta y capacidades.
- [Envío y publicación de plugins](https://developers.openai.com/plugins/deploy/submission): se puede empaquetar un plugin con un servidor MCP remoto, verificar dominio, conectar y escanear herramientas, someter a revisión y publicar.
- [Autenticación de usuarios MCP](https://developers.openai.com/plugins/build/auth): OAuth 2.1, Authorization Code + PKCE S256, metadatos de recurso protegido y servidor de autorización, validación de audiencia y scopes.
- [FAQ de ChatGPT Free](https://help.openai.com/en/articles/9275245-chatgpt-free-tier-faq): las cuentas personales Free no pueden crear/publicar GPTs nuevos; pueden usar GPTs existentes. GPT Actions/GPT personalizado no se seleccionan como dependencia.

**Decisión de diseño R2:** la ruta objetivo para demostrar ChatGPT Free es un plugin MCP público aprobado y publicado en el directorio de ChatGPT, conectado al único servidor MCP existente de KHORA en `/api/mcp`. No se crea un segundo servidor, no se usa Developer Mode como sustituto de la experiencia Free y no se depende de GPT Actions.

Esta ruta es una candidata fundada en documentación oficial, no una compatibilidad de escritura demostrada. OpenAI no garantiza que todo plugin o toda acción de escritura esté disponible en todas las cuentas Free/regiones. La instalación, OAuth, descubrimiento de las siete herramientas y una escritura real no destructiva desde ChatGPT Free son gates duros de Fase 2/3. Si alguno falla, el estado es BLOCKED/FAIL; no se declara MVP ni se sustituye silenciosamente por un plan de pago, un relevo manual, GPT Actions o Codex.

## Correcciones de diseño incorporadas

1. Cliente obligatorio: cuenta personal ChatGPT Free, chat normal, superficie web y región de operación.
2. Distribución: paquete MCP público del directorio, un solo endpoint HTTPS de KHORA.
3. Autenticación: OAuth 2.1 + PKCE S256, metadatos MCP, validación issuer/audience/expiry/scopes.
4. Autorización: asignación sujeto OAuth → identidad KHORA → fuentes Jules permitidas → repositorios → ramas → scopes. El servidor filtra fuentes y vuelve a validar source/branch antes de crear sesiones.
5. Seguridad: publicar el plugin no concede acceso anónimo ni habilita a todo instalador para consultar los repositorios privados; JULES_API_KEY continúa solo en el servidor.
6. No se depende de GPTs personalizados/GPT Actions; se prohíbe Codex en todo el ciclo.
7. Cuotas Free e interrupciones deben preservar checkpoints y permitir reanudación explícita sin duplicar POST.
8. Se conserva arquitectura de un solo servidor KHORA, siete herramientas, aprobación humana forzada, AUTO_CREATE_PR, sin auto-merge/deploy ni worker persistente.

## Secuencia canónica conservada

- **Fase 1 — Planeación integral:** COMPLETA como especificación R2. No modifica código.
- **Fase 2 — Reconciliación e implementación:** comparar el candidato con el plan; ejecutar un gate temprano de plugin público/ChatGPT Free; reconciliar OAuth y autorización por usuario; corregir source/branch, retries, paginación, estados, diagnósticos y pruebas.
- **Fase 3 — Validación integrada real:** probar Jules API, plugin instalado en ChatGPT Free, OAuth, aislamiento, siete herramientas y ciclo E2E bidireccional desde repositorio sandbox; probar cuotas y reanudación.
- **Fase 4 — Release y replicación controlada:** revisión, autorización, merge/despliegue, publicación del plugin, smoke test desde Free, rollback y guía replicable.

No se crean ocho fases ni se cambia la secuencia canónica aprobada.

## Aceptación

La matriz crece de 25 a **31 pruebas/gates**, incorporando:
- publicación y aprobación del plugin público;
- OAuth y aislamiento por usuario/fuente/repositorio/rama;
- cuotas Free y reanudación;
- no dependencia de GPT Actions;
- exclusión absoluta de Codex;
- actualización controlada de herramientas publicadas.

Todos los tests nuevos permanecen PENDIENTE. No se marca PASS sin evidencia real.

## Artefactos actualizados

- `PLAN-INTEGRAL-MCP-JULES-v1.0.md`: R2, 24 secciones, 31 tests/gates; blob `79fc509ce97d75e6959dd2c425dceb933153df62`.
- `OBJETO-CANONICO.md`: v0.1.5, estado/cliente Free/pendientes alineados; blob `3ac7b56c9df56ee65b578767be0f02d745fab6ef`.
- `pruebas/PLAN-ACEPTACION-MVP.md`: 31 pruebas/gates; blob `c3f5b65bbca5aade86bd708d7c248b1accce9a81`.
- `fuentes/INVESTIGACION-API-JULES-CHATGPT.md`: ruta pública y OAuth documentados; blob `e4d5ddb28e93421c34dcdc549cc49b06dc050ddb`.
- `prompts/ASISTENTE-MCP.md`: cliente Free, plugin público y no Codex; blob `8f6f8b1dd4c246c33098f8bd10318c1a51cf5a9d`.
- `prompts/JULES-CONSTRUCTOR.md`: restricciones Free/no Codex; blob `8e8f42c98741116135e4b0ad48cad4833a7eb72b`.
- `replicacion/GUIA-REPLICACION-FRENTES.md`: instalación del plugin y aislamiento por usuario; blob `bd8c32b7b5a4691c942abb83a75fd2e75bae9587`.
- `README.md`: ciclo vigente y estado alineados; blob `955ccec593435b68726c68eaa703d6f9d4a9db4d`.

## Límites y no ejecución

- No se modificó código de KHORA ni se ejecutaron llamadas a Jules.
- No se probó la clave Jules; su valor no se leyó ni expuso.
- No se preparó ni publicó un plugin, no se envió paquete a revisión y no se hizo una prueba desde una cuenta ChatGPT Free.
- No se ejecutó E2E, release, merge ni despliegue.
- Metodología PR #19 y KHORA PR #338 continúan como candidatos sujetos a verificación actual.
- El DUG Samantha v360, el control del frente padre Metacanon y el control de responsabilidad MCP Jules no se modificaron. El control de responsabilidad mantiene generación 2 y lectura de vuelta verificada.

## Estado de cierre

**Fase 1: COMPLETA como diseño integral R2.** La especificación ahora guía el resultado desde el requisito de ChatGPT Free hasta las cuatro fases de entrega, con gates falsables y una restricción absoluta de no utilizar Codex. La compatibilidad real de escritura en Free sigue NO VERIFICADA y es el primer gate externo de Fase 2/3, no un hecho declarado.

**Siguiente fase autorizable:** Fase 2 — reconciliación e implementación, empezando por demostrar el canal de plugin público/Free y el contrato OAuth/aislamiento. El cierre de Fase 1 no autoriza merge, publicación ni despliegue.
