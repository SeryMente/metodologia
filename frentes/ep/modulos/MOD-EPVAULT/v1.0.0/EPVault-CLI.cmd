@echo off
setlocal
set "CLI=%~dp0src\EP.Vault.CLI.ps1"
if not exist "%CLI%" (echo EP_VAULT_CLI_NOT_FOUND& exit /b 2)
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%CLI%" %*
exit /b %ERRORLEVEL%
