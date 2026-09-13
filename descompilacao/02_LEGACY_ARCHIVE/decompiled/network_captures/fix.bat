@echo off
title Capturador de Rede do Jogo
setlocal enabledelayedexpansion

:: Garante que o script rode na pasta local, evitando salvar no System32
cd /d "%~dp0"

set TSHARK="C:\Program Files\Wireshark\tshark.exe"

if not exist %TSHARK% (
    echo [ERRO] O tshark nao foi encontrado em: %TSHARK%
    pause
    exit /b
)

set TIMESTAMP=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%
set OUTPUT="captura_jogo_%TIMESTAMP%.pcapng"

echo ======================================================
echo    CAPTURANDO TRAFEGO: 185.136.158.81
echo ======================================================
echo Arquivo de saida: %OUTPUT%
echo.
echo Execute suas acoes no jogo. Para salvar e sair, aperte CTRL + C.
echo ======================================================
echo.

%TSHARK% -f "host 185.136.158.81" -w %OUTPUT%

echo.
echo Captura concluida com sucesso!
pause