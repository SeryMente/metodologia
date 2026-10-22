'use strict';
if(!process.argv[2]){console.error('Uso: node ensayo-refresco.cjs salida.json');process.exit(2);}
const assert=require('node:assert/strict'),k=require('./refrescar.cjs'),fs=require('node:fs');
const now='2026-10-20T22:00:00Z',text='<!-- METACANON_VERSION=1.10; -->\nbody';
function src(t=text,date='2026-10-20T21:50:00Z'){return {source:'github-live',repository:'SeryMente/metodologia',method_path:'METACANON-OBJETOS-CANONICOS.md',head_commit:'a'.repeat(40),method_commit:'b'.repeat(40),blob_sha:k.blob(t),text:t,updated_at:date,observed_at:now}}
const previous={acquired_version:'1.9',acquired_sha256:k.hash('old'),last_good:{checked_at:'2026-10-20T21:00:00Z',blob_sha:'c'.repeat(40)}};const adoption={status:'compatible_with_existing_authority',source_sha256:k.hash(text),review_ref:'revision/real-reference'};let tests=[];
function test(id,f){try{f();tests.push({id,passed:true})}catch(e){tests.push({id,passed:false,error:e.message})}}
test('F01-detectar-nueva-version',()=>assert.equal(k.check(src(),previous,{now}).status,'UPDATE_PENDING_REVIEW'));
test('F02-adoptar-solo-con-revision',()=>assert.equal(k.check(src(),previous,{now,adoption}).acquired_version,'1.10'));
const acquired=k.check(src(),previous,{now,adoption});
test('F03-sin-cambios-por-hash',()=>assert.equal(k.check(src(),acquired,{now}).status,'CURRENT'));
test('F04-caida-preserva-adquirida',()=>{const r=k.check(null,acquired,{now});assert.equal(r.acquired_version,'1.10');assert.equal(r.source_verified_this_check,false);assert(r.badge.includes('NO VERIFICADA'))});
test('F05-hash-corrupto',()=>assert.equal(k.check({...src(),blob_sha:'d'.repeat(40)},acquired,{now}).status,'SOURCE_INCONSISTENT'));
test('F06-snapshot-no-es-consulta-viva',()=>assert.equal(k.check({...src(),source:'file-snapshot'},previous,{now}).source_verified_this_check,false));
test('F07-version-textual1.10-vs1.9',()=>assert.equal(k.compare('1.10','1.9'),1));
test('F08-retroceso-bloqueado',()=>assert.equal(k.check(src('METACANON_VERSION=1.8;'),previous,{now}).status,'ROLLBACK_REVIEW'));
test('F09-adopcion-con-huella-ajena',()=>assert.equal(k.check(src(),previous,{now,adoption:{...adoption,source_sha256:'f'.repeat(64)}}).status,'UPDATE_PENDING_REVIEW'));
test('F10-adopcion-sin-referencia',()=>assert.equal(k.check(src(),previous,{now,adoption:{...adoption,review_ref:''}}).status,'UPDATE_PENDING_REVIEW'));
test('F11-segundos',()=>assert.equal(k.age('2026-10-20T21:59:42Z',now),'hace 18 s'));
test('F12-minutos',()=>assert.equal(k.age('2026-10-20T21:50:00Z',now),'hace 10 min'));
test('F13-horas',()=>assert.equal(k.age('2026-10-20T19:00:00Z',now),'hace 3 h'));
test('F14-ayer',()=>assert.equal(k.age('2026-10-19T20:00:00Z',now),'ayer'));
test('F15-dos-dias',()=>assert.equal(k.age('2026-10-18T20:00:00Z',now),'hace 2 días'));
test('F16-reloj-futuro',()=>assert.equal(k.age('2026-10-20T23:00:00Z',now),'hora no verificada'));
test('F17-fuente-sin-fecha',()=>assert.equal(k.check({...src(),updated_at:null},previous,{now}).status,'SOURCE_INCONSISTENT'));
test('F18-marcadores-duplicados',()=>assert.equal(k.check(src(text+'\nMETACANON_VERSION=1.11;'),previous,{now}).status,'SOURCE_INCONSISTENT'));
test('F19-cambio-mismo-numero-detectado',()=>assert.equal(k.check(src(text+'x'),acquired,{now}).status,'UPDATE_PENDING_REVIEW'));
test('F20-lectura-no-muta-recibo',()=>{const before=JSON.stringify(acquired);k.check(src(),acquired,{now});assert.equal(JSON.stringify(acquired),before)});
test('F21-comprobacion-caducada',()=>assert.equal(k.check({...src(),observed_at:'2026-10-20T21:58:00Z'},acquired,{now}).status,'SOURCE_STALE'));
test('F22-sin-hora-de-lectura',()=>assert.equal(k.check({...src(),observed_at:null},acquired,{now}).source_verified_this_check,false));
test('F23-lectura-futura',()=>assert.equal(k.check({...src(),observed_at:'2026-10-20T23:00:00Z'},acquired,{now}).source_verified_this_check,false));
test('F24-zona-invalida-no-fabrica-edad',()=>assert(k.age('2026-10-18T20:00:00Z',now,'invalid/zone').includes('no verificada')));
const out={scope:'mechanical-refresh-state-machine-not-model-or-provider-availability',clock:'synthetic deterministic fixtures',records:tests,passed:tests.filter(t=>t.passed).length,total:tests.length,result:tests.every(t=>t.passed)?'PASS':'FAIL'};fs.writeFileSync(process.argv[2],JSON.stringify(out,null,2)+'\n');console.log(JSON.stringify({result:out.result,passed:out.passed,total:out.total}));if(out.result!=='PASS')process.exitCode=1;
