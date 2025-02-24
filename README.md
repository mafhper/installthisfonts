# Instalador de Fontes do Sistema

Este script bash permite copiar fontes do diretório do sistema (`/usr/share/fonts`) para o diretório de fontes do usuário (`~/.local/share/fonts`), evitando duplicações e mantendo a estrutura original de pastas.

## Funcionalidades

- Copia arquivos de fontes (`.ttf` e `.otf`) do diretório do sistema para o diretório do usuário
- Preserva a estrutura original de subdiretórios
- Evita a duplicação de fontes já existentes
- Atualiza automaticamente o cache de fontes após a instalação
- Exibe um relatório detalhado do processo

## Requisitos

- Sistema operacional baseado em Linux (testado no Ubuntu)
- Acesso de leitura às pastas de fontes do sistema
- Permissões de escrita na pasta `~/.local/share/fonts`

## Instalação

1. Faça o download do script ou crie um novo arquivo:

```bash
nano copy_system_fonts.sh
```

2. Cole o conteúdo do script no arquivo

3. Torne o script executável:

```bash
chmod +x copy_system_fonts.sh
```

## Uso

Execute o script sem argumentos:

```bash
./copy_system_fonts.sh
```

O script irá:
1. Procurar por fontes TTF e OTF em todas as subpastas de `/usr/share/fonts`
2. Copiar apenas as fontes que ainda não existem no diretório do usuário
3. Atualizar o cache de fontes
4. Exibir um resumo da operação

## Saída de Exemplo

```
Verificando e copiando fontes do sistema para a pasta do usuário...
Copiada: truetype/arial.ttf
Ignorando: opentype/calibri.otf (já existe)
...

Resumo da operação:
Total de fontes encontradas no sistema: 156
Fontes copiadas para a pasta do usuário: 43
Fontes ignoradas (já existentes): 113

Atualizando cache de fontes...
Cache de fontes atualizado.

Processo concluído!
```

## Personalização

Se você quiser copiar fontes de um diretório diferente ou para um destino alternativo, você pode modificar as seguintes variáveis no início do script:

```bash
SYSTEM_FONT_DIR="/caminho/para/suas/fontes"
USER_FONT_DIR="$HOME/diretorio/destino"
```

## Notas

- Este script não requer privilégios de administrador, pois copia as fontes para o diretório do usuário
- Para instalar fontes no diretório do sistema, você precisaria de privilégios de administrador (sudo)
- As fontes instaladas no diretório do usuário estarão disponíveis apenas para o usuário atual
