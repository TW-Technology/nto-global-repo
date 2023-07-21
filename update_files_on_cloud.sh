#!/bin/bash

# Comprimir os arquivos, excluindo o diretório .git
tar czf /tmp/FfZUzZmGzc.tar.gz --exclude='.git' ./

# Transferir o arquivo comprimido para o servidor remoto
scp /tmp/FfZUzZmGzc.tar.gz $REMOTE_USER@$REMOTE_HOST:/home/nto-global-repo/

# Conectar ao servidor remoto e extrair os arquivos
ssh $REMOTE_USER@$REMOTE_HOST "cd /home/nto-global-repo/ && tar xzf FfZUzZmGzc.tar.gz"

# Remover o arquivo comprimido temporário no servidor remoto
ssh $REMOTE_USER@$REMOTE_HOST "rm /home/nto-global-repo/FfZUzZmGzc.tar.gz"
