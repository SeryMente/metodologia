const fs=require('fs'),vm=require('vm'),ts=require('/data/blog-sync/tools/node_modules/typescript/lib/typescript.js'),assert=require('node:assert/strict');
const source=fs.readFileSync('/data/blog-sync/base/khora-web/lib/server/mcp-normative.ts','utf8');
const js=ts.transpileModule(source,{compilerOptions:{module:ts.ModuleKind.CommonJS,target:ts.ScriptTarget.ES2022}}).outputText;
let upstream=0;const moduleObj={exports:{}};
const mockDb={query:async()=>({rows:[]})};
const requireStub=n=>{
 if(n==='./oauth')return {generateRandomToken:()=> 'synthetic-local-not-token',obtenerGeneracionRevocacion:async()=>0};
 if(n==='./normative-runtime')return {assertNormativeRuntimeContext:r=>{assert.equal(r.reasoning_mode,'UNAVAILABLE');},REQUIRED_OUTPUT_FORMAT_VERSION:'v1.7.7',REQUIRED_PLATFORM:'ChatGPT'};
 if(n==='./neon')return {getDb:()=>mockDb};
 if(n==='./mcp-config')return {getMcpConfig:()=>({issuer:'https://example.invalid'})};
 if(n==='./jwt')return {signJwt:()=>{throw Error('NO_TOKEN_MUST_BE_ISSUED');}};
 if(n==='./norm-check')return {getCurrentSiSnapshot:async()=>{upstream++;throw Error('SYNTHETIC_UPSTREAM_UNAVAILABLE');}};
 if(n==='./normative-output')return {};throw Error('UNEXPECTED_IMPORT_'+n);
};
vm.runInNewContext(js,{require:requireStub,exports:moduleObj.exports,module:moduleObj});
(async()=>{
 const runtime={platform:'ChatGPT',reasoning_mode:'UNAVAILABLE',output_format_version:'v1.7.7'};
 await assert.rejects(()=>moduleObj.exports.openNormativeTurn('synthetic-owner',{conversation_id:'blog-editorial-session',runtime}),/TURN_ID_INCOMPLETE/);
 assert.equal(upstream,0);
 await assert.rejects(()=>moduleObj.exports.openNormativeTurn('synthetic-owner',{runtime}),/SYNTHETIC_UPSTREAM_UNAVAILABLE/);
 assert.equal(upstream,1);console.log('NORMATIVE_CAUSAL_OK: official source c475665, incomplete ID reproduced, absent pair reaches mocked upstream; no real DB/token/network');
})().catch(e=>{console.error(e);process.exit(1);});
