@echo off
title Baixador de Assets em Lote
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: Cria a pasta de destino
if not exist "Assets_Baixados" mkdir "Assets_Baixados"

echo Baixando SWFs sequenciais...

:: Exemplo de loop para testar do 00000000 ao 00000050
for /L %%i in (0,1,50) do (
    set "NUM=00000000%%i"
    set "ARQ=!NUM:~-8!.swf"
    
    echo Baixando: !ARQ!
    curl -s -f "https://narutosp.plaync100.net/public/2021111517/Resources/!ARQ!" -o "Assets_Baixados\!ARQ!"
)

echo.
echo Processo concluido! Verifique a pasta Assets_Baixados.
pause