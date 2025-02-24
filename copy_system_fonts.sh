#!/bin/bash

# Script para copiar fontes do sistema para a pasta de fontes do usuário
# Este script copia apenas fontes que ainda não existem na pasta do usuário

# Definir pasta de fontes do sistema e do usuário
SYSTEM_FONT_DIR="/usr/share/fonts"
USER_FONT_DIR="$HOME/.local/share/fonts"

# Criar a pasta de fontes do usuário se não existir
if [ ! -d "$USER_FONT_DIR" ]; then
    echo "Criando diretório de fontes do usuário em $USER_FONT_DIR..."
    mkdir -p "$USER_FONT_DIR"
fi

# Contadores
TOTAL=0
INSTALADAS=0
IGNORADAS=0

# Processar todas as fontes nas subpastas do sistema
echo "Verificando e copiando fontes do sistema para a pasta do usuário..."
while IFS= read -r fonte; do
    TOTAL=$((TOTAL+1))
    # Obter caminho relativo para recriar estrutura de pastas
    REL_PATH=$(echo "$fonte" | sed "s|$SYSTEM_FONT_DIR/||")
    DEST_DIR=$(dirname "$USER_FONT_DIR/$REL_PATH")
    
    # Garantir que a pasta de destino exista
    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
    fi
    
    # Verificar se a fonte já existe na pasta do usuário
    if [ -f "$USER_FONT_DIR/$REL_PATH" ]; then
        echo "Ignorando: $REL_PATH (já existe)"
        IGNORADAS=$((IGNORADAS+1))
    else
        # Copiar a fonte
        cp -v "$fonte" "$USER_FONT_DIR/$REL_PATH"
        echo "Copiada: $REL_PATH"
        INSTALADAS=$((INSTALADAS+1))
    fi
done < <(find "$SYSTEM_FONT_DIR" -type f \( -name "*.ttf" -o -name "*.otf" \))

# Exibir resumo
echo ""
echo "Resumo da operação:"
echo "Total de fontes encontradas no sistema: $TOTAL"
echo "Fontes copiadas para a pasta do usuário: $INSTALADAS"
echo "Fontes ignoradas (já existentes): $IGNORADAS"

# Atualizar o cache de fontes apenas se alguma fonte foi instalada
if [ $INSTALADAS -gt 0 ]; then
    echo ""
    echo "Atualizando cache de fontes..."
    fc-cache -f
    echo "Cache de fontes atualizado."
fi

echo ""
echo "Processo concluído!"
