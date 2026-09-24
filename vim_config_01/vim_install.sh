#!/usr/bin/env bash
#---------------------------------------------------------------
# vim_install.sh
# Instala o Vim, o vim-plug, todos os plugins e o .vimrc deste
# repositorio, replicando a configuracao usada no sistema em
# uma instalacao limpa (foco em Termux, com fallback para apt).
#---------------------------------------------------------------
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIMRC_SRC="$SCRIPT_DIR/.vimrc"
SNIPPETS_DIR="$SCRIPT_DIR/snippets"
VIM_DIR="$HOME/.vim"
NVIM_DIR="$HOME/.config/nvim"
PLUG_VIM="$VIM_DIR/autoload/plug.vim"
# Caminho customizado usado no .vimrc: call plug#begin('~/.vim/autoload/plug/start')
PLUG_HOME="$VIM_DIR/autoload/plug/start"
# UltiSnips do vim-snippets carrega daqui; e' onde vivem os snippets personalizados
VIM_SNIPPETS_ULTISNIPS="$PLUG_HOME/vim-snippets/UltiSnips"

log()  { printf '\n\033[1;32m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[aviso]\033[0m %s\n' "$1"; }

if [ ! -f "$VIMRC_SRC" ]; then
    echo "Erro: $VIMRC_SRC nao encontrado. Rode este script de dentro do repositorio." >&2
    exit 1
fi

#-----------------------------------------------------------------
# 1. Dependencias do sistema
#-----------------------------------------------------------------
# nodejs/npm  -> coc.nvim, bracey.vim, vim-prettier
# python      -> plugins com suporte a python (ultisnips, ale, etc)
# golang      -> vim-go (GoUpdateBinaries)
# make/clang  -> vimproc.vim (compilacao)
# ctags       -> tagbar
# ripgrep     -> busca usada por fzf/telescope
# neovim      -> exigido por claudecode.nvim e ChatGPT.nvim (plugins Lua)
PACKAGES=(vim neovim git curl nodejs python golang make clang ctags ripgrep)

if command -v pkg >/dev/null 2>&1; then
    log "Ambiente Termux detectado. Instalando dependencias"
    pkg update -y
    for p in "${PACKAGES[@]}"; do
        pkg install -y "$p" || warn "falha ao instalar pacote '$p' (continuando)"
    done
elif command -v apt >/dev/null 2>&1; then
    log "Ambiente apt (Debian/Ubuntu) detectado. Instalando dependencias"
    APT_PACKAGES=(vim neovim git curl nodejs npm python3 golang-go make clang universal-ctags ripgrep)
    sudo apt update
    for p in "${APT_PACKAGES[@]}"; do
        sudo apt install -y "$p" || warn "falha ao instalar pacote '$p' (continuando)"
    done
else
    warn "Gerenciador de pacotes nao reconhecido. Instale manualmente: ${PACKAGES[*]}"
fi

if ! command -v yarn >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    log "Instalando yarn (necessario para o vim-prettier)"
    npm install -g yarn || warn "falha ao instalar yarn (vim-prettier pode nao instalar sozinho)"
fi

if ! command -v claude >/dev/null 2>&1; then
    warn "Comando 'claude' nao encontrado no PATH. O claudecode.nvim precisa do Claude Code CLI instalado: https://docs.anthropic.com/en/docs/claude-code"
fi

#-----------------------------------------------------------------
# 2. Backup da configuracao existente (nunca sobrescrever sem guardar)
#-----------------------------------------------------------------
if [ -e "$HOME/.vimrc" ] || [ -d "$VIM_DIR" ] || [ -e "$NVIM_DIR/init.vim" ]; then
    BACKUP_DIR="$HOME/.vim_backup_$(date +%Y%m%d_%H%M%S)"
    log "Fazendo backup da configuracao atual em $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    [ -e "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$BACKUP_DIR/"
    [ -d "$VIM_DIR" ] && mv "$VIM_DIR" "$BACKUP_DIR/"
    [ -e "$NVIM_DIR/init.vim" ] && mkdir -p "$BACKUP_DIR/nvim" && mv "$NVIM_DIR/init.vim" "$BACKUP_DIR/nvim/"
fi

#-----------------------------------------------------------------
# 3. Copiar o .vimrc do repositorio (Vim e Neovim usam o mesmo arquivo)
#-----------------------------------------------------------------
log "Copiando .vimrc para $HOME/.vimrc"
cp "$VIMRC_SRC" "$HOME/.vimrc"

log "Copiando config para $NVIM_DIR/init.vim (necessario p/ claudecode.nvim e ChatGPT.nvim)"
mkdir -p "$NVIM_DIR"
cp "$VIMRC_SRC" "$NVIM_DIR/init.vim"

#-----------------------------------------------------------------
# 4. Instalar o vim-plug
#-----------------------------------------------------------------
log "Instalando vim-plug em $PLUG_VIM"
if ! curl -fLo "$PLUG_VIM" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; then
    echo "Erro ao baixar o vim-plug. Verifique sua conexao e rode o script novamente." >&2
    exit 1
fi
mkdir -p "$PLUG_HOME"

#-----------------------------------------------------------------
# 5. Instalar todos os plugins declarados no .vimrc
#-----------------------------------------------------------------
# Usa nvim quando disponivel: claudecode.nvim e ChatGPT.nvim sao Lua/Neovim-only
# e nao instalam corretamente com o Vim classico.
log "Instalando plugins com PlugInstall (pode demorar alguns minutos)"
if command -v nvim >/dev/null 2>&1; then
    nvim -es -u "$NVIM_DIR/init.vim" -i NONE -c "PlugInstall --sync" -c "qa" || \
        warn "PlugInstall (nvim) terminou com avisos, confira a saida acima"
else
    warn "nvim nao encontrado; instalando plugins com vim (claudecode.nvim e ChatGPT.nvim ficarao inativos)"
    vim -es -u "$HOME/.vimrc" -i NONE -c "PlugInstall --sync" -c "qa" || \
        warn "PlugInstall terminou com avisos, confira a saida acima"
fi

#-----------------------------------------------------------------
# 6. Restaurar snippets personalizados (editados direto no vim-snippets)
#-----------------------------------------------------------------
# O clone limpo do honza/vim-snippets nao traz os atalhos personalizados
# (foram editados direto nos arquivos do plugin, sem commit/push). Este
# passo sobrescreve os arquivos recem-clonados com as versoes salvas
# no repositorio para nao perder esses snippets numa instalacao limpa.
if [ -d "$SNIPPETS_DIR" ] && [ -d "$VIM_SNIPPETS_ULTISNIPS" ]; then
    log "Restaurando snippets personalizados em $VIM_SNIPPETS_ULTISNIPS"
    for f in "$SNIPPETS_DIR"/*.snippets; do
        [ -f "$f" ] || continue
        cp "$f" "$VIM_SNIPPETS_ULTISNIPS/$(basename "$f")"
    done
else
    warn "Snippets personalizados nao aplicados (pasta $SNIPPETS_DIR ou $VIM_SNIPPETS_ULTISNIPS ausente)"
fi

log "Instalacao concluida! Abra o nvim para conferir os plugins e o tema."
if [ -n "${BACKUP_DIR:-}" ]; then
    echo "Backup da configuracao anterior salvo em: $BACKUP_DIR"
fi

if [ -z "${OPENAI_API_KEY:-}" ]; then
    warn "Variavel \$OPENAI_API_KEY nao definida. O ChatGPT.nvim (<leader>oo, <leader>oa, ...) nao vai funcionar ate voce exportar sua chave da OpenAI (ex: no ~/.bashrc)."
fi
if ! command -v claude >/dev/null 2>&1; then
    warn "Comando 'claude' nao encontrado. O claudecode.nvim (<leader>ac, <leader>af, ...) precisa do Claude Code CLI instalado e autenticado."
fi
