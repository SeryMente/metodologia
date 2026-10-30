# C-MCP-JULES-009 · modelo rector de exactamente dos fases MCP Jules v1.0

**Fecha:** 2026-10-29. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Gobierno:** DUG Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9. **Evento:** C-MCP-JULES-009.

## Aclaración vinculante del operador

El operador estableció que el proyecto tiene únicamente dos fases:

1. **Fase 1:** el asistente resuelve de extremo a extremo un plan completo, confiable y suficientemente detallado para guiar todo el resultado.
2. **Fase 2:** el asistente implementa de extremo a extremo el sistema completo hasta dejarlo instalado, publicado/desplegado donde aplique, validado y realmente utilizable desde ChatGPT Free.

La reconciliación, implementación, pruebas, publicación, despliegue, smoke test, rollback y puesta en servicio no son fases adicionales: son etapas internas de la Fase 2. Esta aclaración sustituye la nomenclatura R1/R2 que separaba la ejecución en Fases 2, 3 y 4.

## Modelo definitivo

### Fase 1 — Planeación integral end-to-end

**Estado:** COMPLETA como diseño R3.

La salida es un plan rector único que define:
- producto y experiencia final;
- cliente obligatorio ChatGPT Free y exclusión absoluta de Codex;
- arquitectura y siete herramientas;
- API Jules, estados, aprobación humana, feedback y ciclo bidireccional;
- distribución y canal ChatGPT Free, OAuth, identidad, scopes y aislamiento de repositorios;
- seguridad, secretos, fallos, retry, paginación, persistencia y recuperación;
- 32 pruebas/gates falsables;
- procedimiento de implementación, validación, publicación, despliegue, reversión y aceptación de Fase 2;
- criterios exactos para declarar la solución utilizable.

Fase 1 no incluye cambios de código ni afirma que la integración externa esté ya validada. Sí debe resolver documentalmente todas las decisiones de diseño y transformar incertidumbres externas en compuertas verificables y conductas ante fallo.

### Fase 2 — Implementación end-to-end hasta sistema utilizable

**Estado:** NO INICIADA; es la única fase restante.

Se ejecuta como una única fase con cinco etapas de trabajo:

- **2.1 Preflight y reconciliación:** comprobar candidato, contratos, CI, ruta soportada desde Free, OAuth, identidad y permisos por recurso.
- **2.2 Implementación completa:** completar las siete herramientas, servidor KHORA, cliente Jules, controles, seguridad, plugin y dependencias.
- **2.3 Validación integrada:** ejecutar T01–T32, llamada real a Jules, OAuth real y ciclo E2E desde ChatGPT Free con repositorio sandbox.
- **2.4 Release y activación:** revisión, autorizaciones, merge, despliegue, publicación/activación del plugin, smoke test y rollback.
- **2.5 Aceptación y puesta en servicio:** desarrollar una tarea real, comprobar entrega, publicar guía y entregar el sistema operativo.

Estas etapas no son fases del proyecto ni se reportan como Fase 3 o Fase 4.

## Criterio único de éxito del proyecto

El proyecto solo se considera completo cuando, desde una cuenta personal ChatGPT Free y un chat normal, el operador puede:
1. indicar un repositorio y una tarea de desarrollo;
2. crear una sesión Jules en la fuente/rama autorizadas;
3. revisar y aprobar explícitamente el plan actual;
4. permitir que Jules implemente el cambio;
5. recuperar las preguntas/solicitudes de feedback y contestarlas dentro de la misma sesión;
6. recibir y verificar el pull request/artefactos y los tests reales;
7. reanudar tras interrupciones sin duplicados ni pérdida de estado;
8. utilizar el servicio ya publicado/desplegado y documentado.

El éxito no se alcanza con una compilación, una PR abierta, una conexión de lectura, un test simulado ni una prueba con un plan ChatGPT pagado.

Si OpenAI no permite herramientas MCP de escritura desde ChatGPT Free por ninguna ruta soportada, Fase 2 queda **BLOCKED** con evidencia. No se sustituye el objetivo por un plan de pago, Developer Mode, Codex, GPT Actions ni un relevo manual sin una nueva decisión explícita del operador.

## Artefactos reconciliados

- [Plan integral v1.0](../PLAN-INTEGRAL-MCP-JULES-v1.0.md): §15 define exactamente dos fases y etapas 2.1–2.5; §22 contiene el procedimiento único de Fase 2. Blob `0872f0caadcb2835bbc2cffbacc7de4c564449f7`.
- [Objeto canónico](../OBJETO-CANONICO.md): v0.1.6, dos fases; blob `3d1071ac66c70b1d4892f291a03df8c5bf425906`.
- [Plan de aceptación](../pruebas/PLAN-ACEPTACION-MVP.md): versión 1.3, 32 criterios, todos asociados a Fase 2 y pendientes; blob `3862754635bb449d0b4df13dc87ce1d3909c338b`.
- [README](../README.md): índice y estado vivo pendientes de lectura de vuelta tras esta crónica.
- Investigación, prompts y guía de replicación conservan ChatGPT Free y la prohibición de Codex.

## Límites de ejecución de este ciclo

- No se modificó código del repositorio KHORA.
- No se ejecutó API Jules ni se validó el secreto.
- No se publicó ni instaló el plugin en ChatGPT Free.
- No se ejecutó E2E, merge ni despliegue.
- El DUG, el control del frente padre Metacanon y el CONTROL-RESPONSABILIDAD.json del frente MCP Jules permanecen sin cambios; se conserva generación 2 y titularidad vigente.

## Estado final

**Modelo de proyecto: DOS FASES Y SOLO DOS.**

- Fase 1 — PLANEACIÓN INTEGRAL: COMPLETA.
- Fase 2 — IMPLEMENTACIÓN E2E, RELEASE Y PUESTA EN SERVICIO: PENDIENTE; única fase restante.

La Fase 2 será considerada terminada únicamente cuando el sistema completo pueda utilizarse para desarrollar un repositorio desde ChatGPT Free conforme al criterio único de éxito.
