@echo off
setlocal
set "GUI=%~dp0src\EP-Vault.GUI.ps1"
if not exist "%GUI%" (echo EP_VAULT_GUI_NOT_FOUND& exit /b 2)
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -STA -ExecutionPolicy Bypass -File "%GUI%"
exit /b %ERRORLEVEL%
