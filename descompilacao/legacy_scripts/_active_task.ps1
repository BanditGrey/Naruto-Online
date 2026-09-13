$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 > $null
# 1. Encerra processos node anteriores
Get-Process -Name node -ErrorAction SilentlyContinue | Stop-Process -Force

# 2. Inicia o Servidor Backend (porta 8080)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'D:\naruto Online\core_project'; npm run server"

# 3. Aguarda 2 segundos e inicia o Client Vite (porta 3000)
Start-Sleep -Seconds 2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'D:\naruto Online\core_project\client'; npx vite"