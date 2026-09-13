@echo off
chcp 65001 >nul
echo ====================================================
echo  INICIANDO ENVIO TOTAL DO NARUTO ONLINE PARA O GITHUBU
echo ====================================================

echo [1/4] Adicionando regra para ignorar o arquivo reservado aux.c...
echo 02_LEGACY_ARCHIVE/official_client/resources/app_extracted/aux.c >> ".gitignore"

echo [2/4] Preparando e indexando todos os arquivos...
git add --all --force

echo [3/4] Criando commit inicial/atualizacao...
git commit -m "Auto-commit: Naruto Online complete project backup"

echo [4/4] Enviando arquivos para o repositorio remoto (GitHub)...
git push -u origin main --force

echo ====================================================
echo  PROCESSO CONCLUIDO! VERIFIQUE AS MENSAGENS ACIMA.
echo ====================================================
pause
