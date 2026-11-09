@echo off
setlocal
set "TEST=%~dp0tests\Test-EPVault.ps1"
if not exist "%TEST%" (echo EP_VAULT_TEST_NOT_FOUND& exit /b 2)
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%TEST%"
exit /b %ERRORLEVEL%
