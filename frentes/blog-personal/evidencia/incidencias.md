# Incidencias C-BLOG-001

- Pruebas sandbox: require absoluto de Playwright y Chromium absoluto inexistentes; se resolvieron con módulo normal y command -v. BROWSER_OK tras corrección.
- Payload: UnicodeDecodeError al tratar un pyc no rastreado como texto; excluido __pycache__, sin publicar binarios inesperados.
- Registro Notion: actualización rechazada porque un ancestro está en papelera. No se restauró ni se eludió ese límite. Registro preservado aquí, sincronización al registro superior pendiente.
- Integración continua heredada: estaticos falla en `grep -q 'Intérprete médico / Traductor (español-inglés)' index.html`; mismo fallo reproducido en base. index.html raíz es byte a byte idéntico al baseline. No se desactivó gate alguno.
- Pages 39188489558: construcción aprueba, test de contrato falla en runner Windows, sin alcanzar subida ni despliegue. No se dispone del traceback remoto completo. Hipótesis causal: Path.read_text/write_text usa encoding por defecto Windows, incompatible con flecha del artículo sintético y UTF-8 de entrega. Corrección preventiva/causal: encoding UTF-8 explícito en todas las lecturas/escrituras textuales del generador y contrato. Repetición local aprueba; próxima prueba: repetir Pages con commit corregido. El último sitio previo no se sustituyó por una compilación fallida.
