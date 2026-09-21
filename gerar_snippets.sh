#!/usr/bin/env bash
# gerar_snippets.sh — adiciona novos snippets de bash rapidamente ao
# projeto (files/UltiSnips/sh.snippets) e já disponibiliza no Vim atual.
#
# Uso interativo:
#   ./gerar_snippets.sh
#
# Uso rápido (sem prompts), lendo o corpo de um arquivo:
#   ./gerar_snippets.sh <gatilho> "<descricao>" <arquivo_com_corpo>
#
# Uso rápido, lendo o corpo da entrada padrão (Ctrl+D para terminar):
#   ./gerar_snippets.sh <gatilho> "<descricao>"
#
# Flags:
#   --anywhere   não restringe o gatilho ao início da linha (sem a flag "b")
#   -h, --help   mostra esta ajuda
set -euo pipefail
IFS=$'\n\t'

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SNIPPET_FILE="$REPO_DIR/files/UltiSnips/sh.snippets"
DEPLOYED_FILE="$HOME/.vim/UltiSnips/sh.snippets"

log()  { printf '\033[1;32m[+] %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m[!] %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31m[x] %s\033[0m\n' "$*" >&2; }

ANYWHERE=0
ARGS=()
for arg in "$@"; do
	case "$arg" in
		--anywhere) ANYWHERE=1 ;;
		-h|--help) sed -n '2,17p' "${BASH_SOURCE[0]}"; exit 0 ;;
		*) ARGS+=("$arg") ;;
	esac
done

# Modo rápido: gatilho já veio por argumento -> não faz nenhuma pergunta
# além do corpo do snippet (se nenhum arquivo/stdin for fornecido).
QUICK_MODE=0
[ -n "${ARGS[0]:-}" ] && QUICK_MODE=1

TRIGGER="${ARGS[0]:-}"
DESCRICAO="${ARGS[1]:-}"
BODY_FILE="${ARGS[2]:-}"

if [ -z "$TRIGGER" ]; then
	read -r -p "Gatilho do snippet (ex: mytrig): " TRIGGER
fi
if [[ "$TRIGGER" =~ [[:space:]] ]] || [ -z "$TRIGGER" ]; then
	err "Gatilho inválido (não pode ser vazio nem conter espaços)."
	exit 1
fi

if [ -z "$DESCRICAO" ]; then
	if [ "$QUICK_MODE" -eq 1 ]; then
		DESCRICAO="$TRIGGER"
	else
		read -r -p "Descrição do snippet: " DESCRICAO
	fi
fi
[ -z "$DESCRICAO" ] && DESCRICAO="$TRIGGER"

if [ "$ANYWHERE" -eq 1 ]; then
	FLAG=""
elif [ "$QUICK_MODE" -eq 1 ]; then
	FLAG=" b"
else
	read -r -p "Só expandir no início da linha? [S/n] " resp_b
	case "${resp_b:-s}" in
		[nN]*) FLAG="" ;;
		*) FLAG=" b" ;;
	esac
fi

TMP_BODY="$(mktemp)"
trap 'rm -f "$TMP_BODY"' EXIT

if [ -n "$BODY_FILE" ]; then
	[ -f "$BODY_FILE" ] || { err "Arquivo de corpo não encontrado: $BODY_FILE"; exit 1; }
	cp "$BODY_FILE" "$TMP_BODY"
elif [ "$QUICK_MODE" -eq 1 ] || [ ! -t 0 ]; then
	# Modo rápido sem arquivo: le o corpo da entrada padrao (Ctrl+D encerra)
	echo "Digite o corpo do snippet e finalize com Ctrl+D:" >&2
	cat > "$TMP_BODY"
else
	cat <<'EOF'

Escreva o corpo do snippet e salve. Dicas de sintaxe do UltiSnips:
  $1, $2, ...        campos editáveis (Tab pula entre eles)
  ${1:padrao}        campo editável com valor padrão
  $0                 posição final do cursor após expandir
  \$                 use para inserir um "$" literal do bash
                     (ex: \$1, \$(comando), \${VAR})

EOF
	"${EDITOR:-vim}" "$TMP_BODY"
fi

if [ ! -s "$TMP_BODY" ]; then
	err "Corpo do snippet vazio; nada foi criado."
	exit 1
fi

# Remove definição anterior do mesmo gatilho, se existir
if grep -q "^snippet ${TRIGGER}\( \|$\)" "$SNIPPET_FILE" 2>/dev/null; then
	warn "Já existe um snippet '${TRIGGER}'; ele será substituído."
	TMP_FILE="$(mktemp)"
	awk -v trig="$TRIGGER" '
		$0 ~ "^snippet " trig "( |$)" { skip=1 }
		skip { if ($0 ~ /^endsnippet/) { skip=0 }; next }
		{ print }
	' "$SNIPPET_FILE" > "$TMP_FILE"
	mv "$TMP_FILE" "$SNIPPET_FILE"
	# remove linhas em branco duplicadas deixadas pela remoção
	awk 'NF==0 && prevblank {next} {print; prevblank = (NF==0)}' "$SNIPPET_FILE" > "$SNIPPET_FILE.tmp"
	mv "$SNIPPET_FILE.tmp" "$SNIPPET_FILE"
fi

{
	echo ""
	echo "snippet ${TRIGGER} \"${DESCRICAO}\"${FLAG}"
	cat "$TMP_BODY"
	echo "endsnippet"
} >> "$SNIPPET_FILE"

log "Snippet '${TRIGGER}' adicionado em: $SNIPPET_FILE"

if [ -d "$HOME/.vim/UltiSnips" ]; then
	cp "$SNIPPET_FILE" "$DEPLOYED_FILE"
	log "Snippet disponível imediatamente no Vim (abra um arquivo .sh e digite: ${TRIGGER}<Tab>)."
else
	warn "\$HOME/.vim/UltiSnips ainda não existe; rode ./vim_install.sh para instalar a configuração."
fi
