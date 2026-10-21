'use strict';
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const cp = require('node:child_process');

const root = path.resolve(__dirname, '../../../..');
const files = {
  verbatim: 'frentes/metodologia/conversaciones/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-dialogo.jsonl',
  control: 'frentes/metodologia/CONTROL-RESPONSABILIDAD.json',
  accessControl: 'frentes/acceso/CONTROL-RESPONSABILIDAD.json',
  ipz: 'frentes/metodologia/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt',
  gow: 'gobernanza/GLOSARIO-WORKSPACE.md',
  sam: 'gobernanza/METAPROMPT-CANONICO-SAMANTHA.md',
  metacanon: 'METACANON-OBJETOS-CANONICOS.md',
  output: 'frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-salida-final-SES-20261021-6B9E2F41.md',
  previousOutput: 'frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md',
  checklist: 'frentes/metodologia/entregas/CHATGPT-v0.3/CHECKLIST-VERBATIM-21.md',
  pending: 'frentes/metodologia/PENDIENTES.md',
  readme: 'frentes/metodologia/README.md',
  continuationPrompt: 'frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-CONTINUIDAD-METODOLOGIA-VERBATIM-E2E-22.txt',
  migrationPrompt: 'frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt',
  checkpoint: 'frentes/metodologia/entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md',
  leeme: 'frentes/metodologia/entregas/CHATGPT-v0.3/LEEME.md',
  entry: 'frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-ENTRADA.txt',
  manifest: 'frentes/metodologia/entregas/CHATGPT-v0.3/MANIFIESTO-C-METODOLOGIA-MIGRACION-HILO-FRESCO-21.json',
  genericOutput: 'frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-salida-final.md'
};
const read = key => fs.readFileSync(path.join(root, files[key]), 'utf8');
const sha256 = s => crypto.createHash('sha256').update(s, 'utf8').digest('hex');
const checks = [];
function test(id, fn) {
  try { fn(); checks.push({ id, passed: true }); }
  catch (e) { checks.push({ id, passed: false, error: e.message }); }
}
let verbatim, control, accessControl, ipz, gow, sam, metacanon, output, previousOutput, checklist, pending, readme, continuationPrompt, migrationPrompt, checkpoint, leeme, entry, manifest, genericOutput;
try {
  verbatim = JSON.parse(read('verbatim').split(/\r?\n/)[0]).verbatim;
  control = JSON.parse(read('control'));
  accessControl = JSON.parse(read('accessControl'));
  ipz = read('ipz').trimEnd();
  gow = read('gow');
  sam = read('sam');
  metacanon = read('metacanon');
  output = read('output');
  previousOutput = read('previousOutput');
  checklist = read('checklist');
  pending = read('pending');
  readme = read('readme');
  continuationPrompt = read('continuationPrompt');
  migrationPrompt = read('migrationPrompt');
  checkpoint = read('checkpoint');
  leeme = read('leeme');
  entry = read('entry');
  manifest = JSON.parse(read('manifest'));
  genericOutput = read('genericOutput');
} catch (e) {
  console.error(JSON.stringify({ result: 'BLOCKED', reason: 'required source could not be read', error: e.message }));
  process.exit(2);
}
test('V01-un-repositorio-admite-multiples-FT', () => {
  if (verbatim.length !== 9) throw new Error('expected 9 original operator statements');
  if (control.front !== 'metodologia' || accessControl.front !== 'acceso') throw new Error('two distinct FT controls not found');
});
test('V02-IPZ-enlaza-y-remite-al-GOW', () => {
  if (!ipz.includes('https://github.com/SeryMente/metodologia/blob/main/gobernanza/GLOSARIO-WORKSPACE.md')) throw new Error('canonical GOW link missing');
  if (!gow.includes('v2.2') || !gow.includes('No es un Hub')) throw new Error('current GOW version/scope not detected');
  if (!sam.includes('P008') || !sam.toLowerCase().includes('al inicio y al cierre de cada ciclo')) throw new Error('Sam P008 cycle-review rule missing');
});
test('V03-IPZ-es-termino-canonico-y-cuenta-verificada', () => {
  if (!gow.includes('Instrucciones Personalizadas de ChatGPT (IPZ)')) throw new Error('IPZ glossary entry missing');
  if (ipz.length !== 1451) throw new Error('IPZ length expected 1451 characters excluding final line ending; got ' + ipz.length);
});
test('V04-una-sesion-activa-registrada-en-el-control-actual', () => {
  if (control.status !== 'owned' || control.session_assignment?.status !== 'active') throw new Error('current owner/session not active');
  if (control.generation !== 3 || control.session_folio !== 'SES-20261021-6B9E2F41') throw new Error('current generation/folio mismatch');
  if (control.handoff_preparation?.status !== 'transferred' || control.transfer?.status !== 'transferred') throw new Error('transfer event not completed in control');
  if (control.session_assignment?.front_ocp !== 'frentes/metodologia/') throw new Error('wrong OCP recorded');
});
test('V05-ultima-salida-previa-reproducida-literalmente', () => {
  if (!output.includes(previousOutput)) throw new Error('previous persisted output is not an exact substring of the reinstantiation output');
  if (!output.includes(files.previousOutput)) throw new Error('previous-output provenance path missing');
});
test('V06-formato-Metacanon-§4-de-diez-campos', () => {
  for (let n = 1; n <= 10; n++) if (!output.includes('## ' + n + '. ')) throw new Error('output field ' + n + ' missing');
  if (!metacanon.includes('## 4. Salida por ciclo')) throw new Error('canonical §4 not found');
});
test('V07-IPZ-enlaza-directamente-a-Metacanon-§4', () => {
  if (!ipz.includes('https://github.com/SeryMente/metodologia/blob/main/METACANON-OBJETOS-CANONICOS.md#4-salida-por-ciclo')) throw new Error('Metacanon §4 direct link missing');
});
test('V08-IPZ-enlaza-directamente-a-la-cascada-de-Sam', () => {
  if (!ipz.includes('https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.md#-i-principios-universales-carga-inmediata')) throw new Error('Sam cascade direct link missing');
  for (const p of ['P001', 'P038', 'P037', 'P008']) if (!sam.includes(p)) throw new Error('relevant Sam principle missing: ' + p);
});
test('V09-MCP-normativo-permanece-desactivado', () => {
  if (!ipz.includes('MCP normativo DESACTIVADO')) throw new Error('IPZ does not mark normative MCP disabled');
  if (!metacanon.includes('la verificación normativa por MCP permanece desactivada')) throw new Error('Metacanon does not maintain disabled status');
});
test('continuidad-checklist-y-pendientes-enlazados', () => {
  for (let n = 1; n <= 9; n++) if (!checklist.includes('| ' + n + ' |')) throw new Error('verbatim checklist row ' + n + ' missing');
  if (!checklist.includes(files.verbatim) || !pending.includes('CHECKLIST-VERBATIM-21.md')) throw new Error('checklist provenance/pending reference missing');
});
test('OCP-entrypoint-no-duplica-estado-y-dirige-al-nucleo', () => {
  if (!readme.includes('no un segundo estado vivo')) throw new Error('README does not declare that it is not a parallel state');
  if (!readme.includes('METACANON-OBJETOS-CANONICOS.md') || !readme.includes('CONTROL-RESPONSABILIDAD.json')) throw new Error('README canonical nucleus/control routes missing');
  if (!readme.includes(files.checklist) && !readme.includes('CHECKLIST-VERBATIM-21.md')) throw new Error('README checklist route missing');
});
test('prompt-de-continuidad-no-reclama-sobre-transferencia-consumida', () => {
  if (!continuationPrompt.includes('No repitas la reclamación CAS') || !continuationPrompt.includes('CONTROL-RESPONSABILIDAD.json')) throw new Error('reusable prompt does not require current control preflight');
  if (!continuationPrompt.includes('PROMPT-MIGRACION-HILO-FRESCO-21.txt')) throw new Error('reusable prompt does not identify the consumed one-use prompt');
});
test('prompt-de-un-solo-uso-marcado-consumido', () => {
  if (!migrationPrompt.includes('PROMPT DE UN SOLO USO CONSUMIDO')) throw new Error('old one-time prompt is not marked consumed');
  if (!migrationPrompt.includes('SES-20261021-6B9E2F41')) throw new Error('old prompt does not document the completed transfer');
});
test('checkpoint-refleja-transferencia-completada-y-entrypoints-actuales', () => {
  if (!checkpoint.includes('ESTADO ACTUAL VERIFICADO') || !checkpoint.includes('generación **3**')) throw new Error('checkpoint lacks current verified state overlay');
  if (!checkpoint.includes('PROMPT-CONTINUIDAD-METODOLOGIA-VERBATIM-E2E-22.txt')) throw new Error('checkpoint does not route new threads to current continuation prompt');
  if (!leeme.includes('se consumó') || !entry.includes('PROMPT-CONTINUIDAD-METODOLOGIA-VERBATIM-E2E-22.txt')) throw new Error('entrypoints still indicate a pending transfer or stale prompt');
});
test('manifest-y-salida-generica-no-declaran-transferencia-pendiente', () => {
  if (!manifest.status.includes('transferred_and_readback_verified') || manifest.handoffPreparation?.transferComplete !== true) throw new Error('manifest status is stale');
  if (!genericOutput.includes('SUPERSEDIDO COMO SALIDA DEFINITIVA')) throw new Error('generic output is not marked superseded');
});
const headResult = cp.spawnSync('git', ['rev-parse', 'HEAD'], { cwd: root, encoding: 'utf8' });
const result = {
  schema: 'metodologia-verbatim-e2e/1',
  event: 'C-METODOLOGIA-VERBATIM-E2E-22',
  executed_at: new Date().toISOString(),
  scope: 'nine original operator requirements plus their persisted artifacts; this is an artifact-chain test, not an LLM semantic-acceptance test or native ChatGPT settings read-back',
  environment: { platform: process.platform, node: process.version, source_commit: headResult.status === 0 ? headResult.stdout.trim() : null },
  records: checks,
  passed: checks.filter(x => x.passed).length,
  total: checks.length,
  result: checks.every(x => x.passed) ? 'PASS' : 'FAIL',
  ipz_native_field: 'NOT_EVALUABLE_WITH_AVAILABLE_CONNECTORS',
  uniqueness_scope: 'current FT control verified; repository search is limited to the nine exposed SeryMente repositories and does not prove organization-wide global uniqueness',
  source_sha256: Object.fromEntries(Object.entries(files).map(([k,p]) => [p, sha256(fs.readFileSync(path.join(root,p)))]))
};
console.log(JSON.stringify(result, null, 2));
if (process.argv[2]) fs.writeFileSync(process.argv[2], JSON.stringify(result, null, 2) + '\n', { flag: 'wx', encoding: 'utf8' });
process.exitCode = result.result === 'PASS' ? 0 : 1;
