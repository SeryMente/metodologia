'use strict';
const crypto=require('node:crypto');
const FRONT='metodologia',PATH='frentes/metodologia/CONTROL-RESPONSABILIDAD.json';
function valid(r){return !!(r&&r.schema==='responsabilidad/1'&&r.front===FRONT&&Number.isSafeInteger(r.generation)&&r.generation>0&&['owned','released'].includes(r.status)&&typeof r.owner_thread==='string'&&r.owner_thread.length>0&&typeof r.instance==='string'&&r.instance.length>0&&typeof r.authorization_ref==='string'&&r.authorization_ref.length>0);}
function transition(current,request){
 if(!request||typeof request.thread!=='string'||!request.thread||typeof request.instance!=='string'||!request.instance||!request.authorization_ref)throw Error('BLOCKED: identidad y autorización necesarias');
 if(current!==null&&!valid(current))throw Error('BLOCKED: control ilegible o inconsistente');
 let next;if(request.action==='claim'){
  if(current&&current.status==='owned')throw Error('BLOCKED: frente ya tiene responsable; no renovar ni usurpar');
  next={schema:'responsabilidad/1',front:FRONT,status:'owned',owner_thread:request.thread,instance:request.instance,generation:current?current.generation+1:1,authorization_ref:request.authorization_ref};
 }else if(['release','transfer'].includes(request.action)){
  if(!current||current.status!=='owned'||current.owner_thread!==request.thread||current.instance!==request.instance||current.generation!==request.generation)throw Error('BLOCKED: no es el propietario vigente');
  if(request.action==='transfer'&&(!request.target_thread||!request.target_instance||request.target_thread===current.owner_thread))throw Error('BLOCKED: destino inequívoco necesario');
  next={...current,status:request.action==='release'?'released':'owned',generation:current.generation+1,authorization_ref:request.authorization_ref};
  if(request.action==='transfer'){next.owner_thread=request.target_thread;next.instance=request.target_instance;}
 }else throw Error('BLOCKED: acción desconocida');
 return next;
}
function gate(observation,identity,expected){
 // The adapter must perform an authoritative read NOW. Offline files and caller-provided claims are not authenticated observations.
 if(!observation||observation.authoritative!==true||!valid(observation.record)||!Number.isFinite(observation.observed_ms)||!Number.isFinite(observation.now_ms)||observation.now_ms<observation.observed_ms||observation.now_ms-observation.observed_ms>60000)return {allowed:false,reason:'CONTROL_NO_VERIFICADO'};
 const r=observation.record;if(r.status!=='owned'||!identity||r.owner_thread!==identity.thread||r.instance!==identity.instance||r.generation!==identity.generation||!expected||expected!==observation.blob)return {allowed:false,reason:'PROPIETARIO_O_GENERACION_DISTINTOS'};
 return {allowed:true,reason:'CONTROL_COINCIDE',fencing_generation:r.generation,expected_control_blob:observation.blob,scope:'preflight-only; canonical write must atomically enforce generation to close TOCTOU'};
}
module.exports={FRONT,PATH,valid,transition,gate};
if(require.main===module){console.error('Biblioteca sin efectos. Adquirir/transferir mediante Contents API con SHA observado; jamás push genérico para sobrescribir el control.');process.exitCode=2;}
