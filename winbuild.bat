@echo off
cd %~dp0
powershell -ExecutionPolicy Bypass -File .\winbuild.ps1 %*

