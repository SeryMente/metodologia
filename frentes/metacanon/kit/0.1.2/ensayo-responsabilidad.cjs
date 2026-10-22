'use strict';const assert=require('node:assert/strict'),fs=require('node:fs'),os=require('node:os'),path=require('node:path'),cp=require('node:child_process'),k=require('./responsabilidad.cjs');
let tests=[];function t(id,fn){try{fn();tests.push({id,passed:true})}catch(e){tests.push({id,passed:false,error:e.message})}}
const req={action:'claim',thread:'hilo-A',instance:'instancia-A',authorization_ref:'orden-operador'},a=k.transition(null,req),obs={record:a,authoritative:true,observed_ms:1000,now_ms:1001,blob:'a'.repeat(40)},ident={thread:'hilo-A',instance:'instancia-A',generation:1};
t('O01-primer-responsable',()=>assert.equal(a.generation,1));
t('O02-segundo-bloqueado',()=>assert.throws(()=>k.transition(a,{...req,thread:'hilo-B'})));
t('O03-no-reclamar-como-renovacion',()=>assert.throws(()=>k.transition(a,req)));
t('O04-vigente-pasa-preflight',()=>assert(k.gate(obs,ident,obs.blob).allowed));
t('O05-otro-hilo-bloqueado',()=>assert(!k.gate(obs,{...ident,thread:'hilo-B'},obs.blob).allowed));
t('O06-sin-fuente-bloqueado',()=>assert(!k.gate(null,ident,obs.blob).allowed));
t('O07-copia-offline-bloqueada',()=>assert(!k.gate({...obs,authoritative:false},ident,obs.blob).allowed));
t('O08-observacion-antigua-bloqueada',()=>assert(!k.gate({...obs,now_ms:62000},ident,obs.blob).allowed));
t('O09-generacion-antigua-bloqueada',()=>assert(!k.gate(obs,{...ident,generation:0},obs.blob).allowed));
t('O10-blob-antiguo-bloqueado',()=>assert(!k.gate(obs,ident,'b'.repeat(40)).allowed));
t('O11-no-liberar-por-otro',()=>assert.throws(()=>k.transition(a,{...req,thread:'hilo-B',action:'release',generation:1})));
t('O12-transferencia-explicita',()=>{let b=k.transition(a,{...req,action:'transfer',generation:1,target_thread:'hilo-B',target_instance:'B'});assert.equal(b.owner_thread,'hilo-B');assert.equal(b.generation,2);assert(!k.gate({...obs,record:b},ident,obs.blob).allowed)});
t('O13-sin-destino-no-transferir',()=>assert.throws(()=>k.transition(a,{...req,action:'transfer',generation:1})));
t('O14-liberacion-y-nueva-generacion',()=>{let b=k.transition(a,{...req,action:'release',generation:1});assert.equal(k.transition(b,{...req,thread:'hilo-B'}).generation,3)});
t('O15-control-corrupto-bloquea',()=>assert.throws(()=>k.transition({...a,generation:NaN},req)));
t('O16-sin-autorizacion-bloquea',()=>assert.throws(()=>k.transition(null,{...req,authorization_ref:''})));
t('O17-reloj-no-valido-bloquea',()=>assert(!k.gate({...obs,now_ms:0},ident,obs.blob).allowed));
// Real concurrent local processes, atomic exclusive creation; does NOT test GitHub Contents or provider authorization.
// Cross-platform concurrent local processes; no bash dependency; not GitHub/server fencing.
(async()=>{
 const id='O18-carrera-local-solo-un-ganador'; let dir;
 try {
  dir=fs.mkdtempSync(path.join(os.tmpdir(),'owner-race-'));
  const file=path.join(dir,'claim'),worker=path.join(dir,'worker.cjs');
  fs.writeFileSync(worker,`const fs=require('node:fs');try{const fd=fs.openSync(process.argv[2],'wx');fs.writeSync(fd,process.argv[3]);fs.closeSync(fd);process.exit(0)}catch(e){if(e.code==='EEXIST')process.exit(3);console.error(e.message);process.exit(1)}`);
  const run=value=>new Promise((resolve,reject)=>{const child=cp.spawn(process.execPath,[worker,file,value],{stdio:'ignore'});child.once('error',reject);child.once('close',resolve)});
  const codes=await Promise.all([run('A'),run('B')]);
  assert.deepEqual(codes.slice().sort((a,b)=>a-b),[0,3]);
  assert(['A','B'].includes(fs.readFileSync(file,'utf8')));
  tests.push({id,passed:true,scope:'two concurrent Node processes using exclusive file creation; local only'});
 } catch(e) { tests.push({id,passed:false,error:e.message}); }
 finally { if(dir) try { fs.rmSync(dir,{recursive:true,force:true}); } catch(e) {} }
 const result={schema:'responsabilidad-tests/1',timestamp:new Date().toISOString(),scope:'pure transitions + cross-platform concurrent local exclusive-create race; NOT GitHub concurrent race or server-enforced write fencing',passed:tests.filter(x=>x.passed).length,total:tests.length,tests};
 console.log(JSON.stringify(result,null,2)); if(result.passed!==result.total) process.exitCode=1;
})().catch(e=>{console.error(e);process.exitCode=1});
