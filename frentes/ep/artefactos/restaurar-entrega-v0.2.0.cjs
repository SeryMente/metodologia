// Restaurador de un archivo histórico, no launcher de EP. Node sin dependencias externas.
const fs=require('node:fs'), path=require('node:path'), crypto=require('node:crypto');
const dst=path.join(__dirname,'KHORA-OEP-v0.2.0-ENTREGA-PRIVADA.zip');
const data=Buffer.from(fs.readFileSync(path.join(__dirname,'entrega-v0.2.0.zip.b64'),'utf8').trim(),'base64');
const hash=crypto.createHash('sha256').update(data).digest('hex');
if(hash!=='0bdd7db2d665eafc044cf8f24b834e4c0cbe277b0e8c40731545a7d3273cc05b' || data.length!==91650) throw new Error('INTEGRITY_MISMATCH');
if(fs.existsSync(dst)) {const old=fs.readFileSync(dst); if(!old.equals(data)) throw new Error('DESTINATION_EXISTS_DIFFERENT'); console.log('Original ya restaurado exacto');} else {fs.writeFileSync(dst,data,{flag:'wx'}); if(!fs.readFileSync(dst).equals(data)) throw new Error('READBACK_MISMATCH'); console.log('Original restaurado exacto');}
