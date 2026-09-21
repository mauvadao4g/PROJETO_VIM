#!/usr/bin/env bash
# vim_install.sh — instalação e configuração 100% automatizada do Vim
# Foco: scripts Bash, tema Dracula + temas escuros adicionais e snippets.
#
# Uso:
#   ./vim_install.sh              # instalação completa (pacotes + config + plugins)
#   ./vim_install.sh --no-apt     # pula a instalação de pacotes do sistema
#
# Reexecutar este script em qualquer máquina nova reproduz a mesma configuração.
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIM_DIR="$HOME/.vim"
VIMRC="$HOME/.vimrc"
BACKUP_DIR="$HOME/.vim_backup_$(date +%Y%m%d_%H%M%S)"
SKIP_APT=0

for arg in "$@"; do
	case "$arg" in
		--no-apt) SKIP_APT=1 ;;
		*) echo "Argumento desconhecido: $arg" >&2; exit 1 ;;
	esac
done

log()  { printf '\033[1;32m[+] %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m[!] %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31m[x] %s\033[0m\n' "$*" >&2; }

need_cmd() { command -v "$1" >/dev/null 2>&1; }

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
	if need_cmd sudo; then
		SUDO="sudo"
	else
		warn "Não é root e 'sudo' não está disponível; a instalação de pacotes pode falhar."
	fi
fi

install_packages() {
	if [ "$SKIP_APT" -eq 1 ]; then
		warn "Instalação de pacotes pulada (--no-apt)."
		return
	fi
	if ! need_cmd apt-get; then
		warn "apt-get não encontrado; pulando instalação automática de pacotes."
		warn "Garanta manualmente: vim (com +python3), git, curl, shellcheck, ripgrep, fzf."
		return
	fi

	log "Instalando dependências via apt-get..."
	export DEBIAN_FRONTEND=noninteractive
	$SUDO apt-get update -y
	if ! $SUDO apt-get install -y vim-nox git curl python3 shellcheck ripgrep fzf jq; then
		warn "vim-nox indisponível; tentando pacote 'vim' genérico."
		$SUDO apt-get install -y vim git curl python3 shellcheck ripgrep fzf jq
	fi

	if ! need_cmd shfmt; then
		if $SUDO apt-get install -y shfmt 2>/dev/null; then
			log "shfmt instalado via apt."
		else
			warn "shfmt não disponível no apt. A formatação automática de shell (ALE fixer) ficará desativada."
			warn "Instale manualmente depois com: go install mvdan.cc/sh/v3/cmd/shfmt@latest"
		fi
	fi
}

check_ai_deps() {
	log "Verificando dependências para GitHub Copilot e Claude..."

	if need_cmd node; then
		local node_major
		node_major="$(node -v | sed 's/^v//' | cut -d. -f1)"
		if [ "$node_major" -ge 18 ]; then
			log "Node.js $(node -v) encontrado (ok para o GitHub Copilot)."
		else
			warn "Node.js $(node -v) é antigo demais para o GitHub Copilot (precisa de >= 18)."
			warn "Atualize manualmente (ex: via nvm) antes de usar :Copilot."
		fi
	else
		warn "Node.js não encontrado; o GitHub Copilot precisa de Node.js >= 18."
		warn "Instale manualmente (ex: via nvm) e rode este script de novo."
	fi

	if need_cmd claude; then
		log "Claude Code CLI encontrado ($(claude --version 2>/dev/null | head -1))."
	else
		warn "Comando 'claude' não encontrado no PATH; os atalhos <leader>a* (Claude) não vão funcionar até instalá-lo e autenticá-lo."
	fi
}

MARKER="$VIM_DIR/.vim_install_managed"

backup_existing() {
	# Se já foi instalado por este script antes, não mexe em ~/.vim de novo:
	# preserva ~/.vim/plugged para não ter que reclonar tudo a cada reinstalação.
	if [ -f "$MARKER" ]; then
		log "Configuração já gerenciada por este instalador; pulando backup (cache de plugins preservado)."
		return
	fi

	local need_backup=0
	[ -e "$VIMRC" ] && [ ! -L "$VIMRC" ] && need_backup=1
	[ -d "$VIM_DIR" ] && need_backup=1

	if [ "$need_backup" -eq 1 ]; then
		mkdir -p "$BACKUP_DIR"
		[ -e "$VIMRC" ] && mv "$VIMRC" "$BACKUP_DIR/vimrc"
		[ -d "$VIM_DIR" ] && mv "$VIM_DIR" "$BACKUP_DIR/.vim"
		log "Configuração anterior (não gerenciada por este instalador) movida para: $BACKUP_DIR"
	fi
}

deploy_files() {
	log "Implantando arquivos de configuração..."
	mkdir -p "$VIM_DIR"/{autoload,ftplugin,UltiSnips,plugged,undo}
	cp "$SCRIPT_DIR/files/vimrc" "$VIMRC"
	cp "$SCRIPT_DIR/files/ftplugin/sh.vim" "$VIM_DIR/ftplugin/sh.vim"
	cp "$SCRIPT_DIR/files/UltiSnips/sh.snippets" "$VIM_DIR/UltiSnips/sh.snippets"
	touch "$MARKER"
}

install_vim_plug() {
	local plug_file="$VIM_DIR/autoload/plug.vim"
	if [ ! -f "$plug_file" ]; then
		log "Instalando vim-plug..."
		curl -fLo "$plug_file" --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		log "vim-plug já instalado."
	fi
}

install_plugins() {
	log "Instalando/atualizando plugins (isso pode levar um minuto)..."
	if ! vim -Es -u "$VIMRC" -c "PlugInstall --sync" -c "qa" 2>&1 | tail -n 40; then
		err "Falha ao instalar os plugins com o Vim. Verifique a saída acima."
		exit 1
	fi
}

print_summary() {
	cat <<'EOF'

=====================================================================
 Instalação concluída!
=====================================================================
Atalhos principais:
  F5 / F6        -> tema anterior / próximo
                    (Dracula, Gruvbox, Nord, One Dark, Molokai, Palenight, Everforest)
  Ctrl-n         -> abrir/fechar NERDTree
  Ctrl-p         -> localizar arquivos (fzf)
  <espaço> f     -> buscar texto no projeto (Rg, requer ripgrep)
  <espaço> b     -> listar buffers abertos
  <espaço> w     -> salvar
  <espaço> c     -> comentar/descomentar linha ou seleção
  gcc / gc       -> comentar (vim-commentary)
  <Tab>          -> expandir snippet (UltiSnips)
  Ctrl-j/Ctrl-k  -> pular entre campos do snippet
  Em arquivo .sh:
    <espaço> r   -> salvar e executar o script
    <espaço> x   -> chmod +x no script atual

Snippets de bash disponíveis (digite e pressione Tab):
  shebang, script, func, if, ife, ifelif, for, forc, while, until,
  case, getopts, args, trap, log, arr, arrfor, readf, heredoc, hascmd,
  colors, echoc, clog, ts, tsfile, jq, curljson, confirm, retry,
  mktmp, mktmpd, isroot, envdef, spinner, lock

Lint/format automático de shell via ALE + shellcheck (+ shfmt, se instalado).

GitHub Copilot:
  <C-l> (modo inserção) -> aceitar sugestão (Tab continua sendo do UltiSnips)
  :Copilot setup         -> autenticar (rodar uma vez por máquina)
  :Copilot enable/disable/status

Claude (Claude Code CLI):
  <espaço> a c   -> abrir o Claude interativo em um split
  <espaço> a e   -> pedir para explicar o arquivo atual (ou trecho selecionado)
  <espaço> a r   -> pedir revisão do arquivo atual (ou trecho selecionado)
  <espaço> a f   -> pedir para corrigir bugs do arquivo atual
  <espaço> a a   -> digitar um prompt livre sobre o arquivo/trecho atual

Git (vim-fugitive):
  <espaço> g i   -> init      <espaço> g s   -> status
  <espaço> g a/A -> add (arquivo/tudo)
  <espaço> g c   -> commit    <espaço> g p   -> push
  <espaço> g P   -> pull      <espaço> g l   -> log

Use ./gerar_snippets.sh para adicionar novos snippets rapidamente.

Para reinstalar/replicar esta configuração em outra máquina, copie a
pasta PROJETO_VIM e rode: ./vim_install.sh
=====================================================================
EOF
}

main() {
	install_packages
	check_ai_deps
	backup_existing
	deploy_files
	install_vim_plug
	install_plugins
	print_summary
}

main
