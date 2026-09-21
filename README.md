# PROJETO_VIM

Configuração automatizada do Vim focada em **desenvolvimento de scripts Bash**,
com tema **Dracula** (padrão) e outros temas escuros alternáveis, lint/format
automático de shell e snippets prontos para bash.

## Estrutura

```
PROJETO_VIM/
├── vim_install.sh              # instalador — rode este em qualquer máquina
├── gerar_snippets.sh           # cria/edita snippets rapidamente
├── tabelas_sniptes.txt         # tabela de referência com todos os atalhos
└── files/
    ├── vimrc                   # config principal (vira ~/.vimrc)
    ├── ftplugin/sh.vim         # ajustes específicos para arquivos .sh
    └── UltiSnips/sh.snippets   # snippets de bash customizados
```

## Instalação

Em qualquer máquina nova (Ubuntu/Debian), dentro desta pasta:

```bash
./vim_install.sh
```

O script instala tudo sozinho:

1. Pacotes do sistema via `apt-get`: `vim-nox` (com suporte a Python3), `git`,
   `curl`, `shellcheck`, `ripgrep`, `fzf`, `jq` e `shfmt`.
2. `vim-plug` (gerenciador de plugins).
3. Todos os plugins configurados (`PlugInstall --sync`), incluindo o
   `github/copilot.vim`.
4. Os arquivos de `files/` copiados para `~/.vimrc` e `~/.vim/`.
5. Verifica (sem instalar nada de forma invasiva) se `Node.js >= 18` e o
   comando `claude` estão disponíveis, avisando caso faltem — são
   necessários para o GitHub Copilot e para os atalhos de Claude.

Se já existir uma configuração de Vim anterior (não gerenciada por este
script), ela é movida para `~/.vim_backup_<data>_<hora>` antes de aplicar a
nova — nada é apagado. Reinstalações seguintes (rodar o script de novo)
preservam o cache de plugins em `~/.vim/plugged`, então são rápidas.

### Opções

```bash
./vim_install.sh --no-apt   # pula a instalação de pacotes do sistema
                             # (útil se vim/git/curl/shellcheck já estiverem instalados)
```

### Reinstalar/replicar em outra máquina

Copie a pasta `PROJETO_VIM` inteira para a outra máquina e rode
`./vim_install.sh` lá. O resultado é idêntico.

## Temas

Tema padrão: **Dracula**. Outros temas escuros incluídos:

| Tema      | Nome do colorscheme |
|-----------|----------------------|
| Dracula   | `dracula`            |
| Gruvbox   | `gruvbox`            |
| Nord      | `nord`               |
| One Dark  | `onedark`            |
| Molokai   | `molokai`            |
| Palenight | `palenight`          |
| Everforest| `everforest`         |

| Atalho | Ação                     |
|--------|--------------------------|
| `F5`   | Tema anterior da lista   |
| `F6`   | Próximo tema da lista    |

## Atalhos gerais

| Atalho          | Ação                                              |
|-----------------|----------------------------------------------------|
| `Ctrl-n`        | Abrir/fechar o NERDTree (árvore de arquivos)       |
| `Ctrl-p`        | Buscar/abrir arquivos (fzf)                        |
| `<espaço> f`    | Buscar texto no projeto (Rg / ripgrep)             |
| `<espaço> b`    | Listar buffers abertos                             |
| `<espaço> w`    | Salvar arquivo atual                               |
| `<espaço> q`    | Fechar arquivo atual                               |
| `<espaço> c`    | Comentar/descomentar linha ou seleção              |
| `gcc`           | Comentar/descomentar a linha atual (vim-commentary)|
| `gc` + movimento| Comentar/descomentar um trecho                     |
| `Tab`           | Expandir snippet (UltiSnips)                       |
| `Ctrl-j`        | Pular para o próximo campo do snippet              |
| `Ctrl-k`        | Voltar ao campo anterior do snippet                |

## Atalhos específicos para arquivos `.sh`

| Atalho       | Ação                                     |
|--------------|-------------------------------------------|
| `<espaço> r` | Salvar e executar o script atual (`bash %`)|
| `<espaço> x` | Tornar o script executável (`chmod +x %`)  |

## Lint e formatação de Bash

- **ALE + shellcheck**: analisa o script continuamente e mostra erros/avisos
  na coluna de sinais e via `:ALEInfo` / `<leader>` de navegação padrão do ALE.
- **shfmt**: formata o arquivo automaticamente ao salvar (`ale_fix_on_save`),
  usando indentação de 2 espaços e `case` indentado (`-i 2 -ci`).

## Snippets de Bash disponíveis

Digite o gatilho abaixo em um arquivo `.sh` e pressione `Tab`:

| Gatilho    | O que insere                                         |
|------------|-------------------------------------------------------|
| `shebang`  | Shebang + `set -euo pipefail` + `IFS`                 |
| `script`   | Esqueleto completo de script (shebang, log, main, etc.)|
| `func`     | Definição de função                                    |
| `if`       | Bloco `if`                                             |
| `ife`      | Bloco `if` / `else`                                    |
| `ifelif`   | Bloco `if` / `elif` / `else`                           |
| `for`      | Laço `for item in lista`                               |
| `forc`     | Laço `for` estilo C                                    |
| `while`    | Laço `while`                                           |
| `until`    | Laço `until`                                           |
| `case`     | Bloco `case`                                           |
| `getopts`  | Parser de argumentos com `getopts`                     |
| `args`     | Validação da quantidade de argumentos recebidos        |
| `trap`     | `trap` de limpeza no `EXIT`                            |
| `log`      | Função de log com timestamp                            |
| `arr`      | Declaração de array                                    |
| `arrfor`   | Laço `for` sobre um array                              |
| `readf`    | Leitura de arquivo linha a linha                       |
| `heredoc`  | Bloco here-doc (`cat <<EOF ... EOF`)                   |
| `hascmd`   | Checagem se um comando existe (`command -v`)           |

### Cores, tempo, JSON e utilitários

| Gatilho     | O que insere                                              |
|-------------|-------------------------------------------------------------|
| `colors`    | Variáveis de cores ANSI (`RED`, `GREEN`, `YELLOW`, etc.)     |
| `echoc`     | `echo -e` com código de cor ANSI inline                      |
| `clog`      | Funções de log coloridas: `info`, `warn`, `error`, `success` |
| `ts`        | Timestamp atual em variável (`YYYY-MM-DD HH:MM:SS`)          |
| `tsfile`    | Timestamp para nome de arquivo (`YYYYMMDD_HHMMSS`)           |
| `jq`        | Extrair um campo de um JSON com `jq`                         |
| `curljson`  | Requisição `curl` + extração de campo com `jq`               |
| `confirm`   | Confirmação sim/não antes de continuar (`read -p`)           |
| `retry`     | Repetir um comando até funcionar, com limite de tentativas   |
| `mktmp`     | Arquivo temporário com limpeza automática (`trap` + `mktemp`)|
| `mktmpd`    | Diretório temporário com limpeza automática                 |
| `isroot`    | Verificação de execução como root (`$EUID`)                  |
| `envdef`    | Variável com valor padrão (`${VAR:-padrao}`)                 |
| `spinner`   | Spinner enquanto um processo roda em segundo plano           |
| `lock`      | Lockfile para impedir execução simultânea do script          |

> `jq` e `curljson` precisam do utilitário `jq` instalado (já incluso no
> `vim_install.sh`).

Há também todos os snippets padrão de `honza/vim-snippets` disponíveis para
outras linguagens.

## Criando novos snippets rapidamente

Use o `gerar_snippets.sh` em vez de editar `files/UltiSnips/sh.snippets` na mão:

```bash
./gerar_snippets.sh                                      # modo interativo (abre $EDITOR)
./gerar_snippets.sh meutrig "minha descricao" corpo.txt   # a partir de um arquivo
./gerar_snippets.sh meutrig "minha descricao" <<'EOF'     # colando direto (Ctrl+D encerra)
codigo aqui
$0
EOF
```

Ele adiciona o snippet ao arquivo do repositório, substitui automaticamente
se o gatilho já existir e já copia para `~/.vim/UltiSnips/`, ficando
disponível imediatamente no Vim (sem precisar rodar `vim_install.sh` de novo).

## GitHub Copilot e Claude (IA)

### GitHub Copilot

Plugin oficial `github/copilot.vim`, já incluso na instalação. Requisitos:
Node.js >= 18 (o `vim_install.sh` verifica e avisa se faltar).

Na primeira vez em cada máquina, autentique com:

```vim
:Copilot setup
```

(segue um fluxo de autenticação pelo navegador; precisa de uma assinatura
ativa do GitHub Copilot na conta).

| Atalho                  | Ação                                          |
|--------------------------|-----------------------------------------------|
| `Ctrl-l` (modo inserção) | Aceitar a sugestão do Copilot                 |
| `Alt-]` / `Alt-[`        | Próxima / sugestão anterior (padrão do plugin)|
| `:Copilot enable`        | Ativar sugestões                              |
| `:Copilot disable`       | Desativar sugestões                           |
| `:Copilot status`        | Ver status da autenticação/conexão            |

> `Tab` continua reservado para expandir snippets do UltiSnips — por isso o
> Copilot foi remapeado para `Ctrl-l` (`g:copilot_no_tab_map`), evitando o
> conflito clássico entre os dois plugins.

### Claude (Claude Code CLI)

Integração via o comando `claude` (Claude Code), rodado dentro de um split
do próprio Vim usando `:terminal`. Requer o `claude` instalado e autenticado
no PATH (o `vim_install.sh` avisa se não encontrar).

| Atalho         | Ação                                                          |
|----------------|-----------------------------------------------------------------|
| `<espaço> a c` | Abre o Claude interativo (`claude`) em um split                 |
| `<espaço> a e` | Pede para explicar o arquivo atual (normal) ou a seleção (visual)|
| `<espaço> a r` | Pede revisão/bugs/sugestões do arquivo atual ou da seleção       |
| `<espaço> a f` | Pede para corrigir os bugs do arquivo atual                     |
| `<espaço> a a` | Abre `:ClaudeAsk ` na linha de comando para digitar um prompt livre|

Também dá para chamar direto: `:ClaudeAsk <pergunta>` (usa o arquivo
inteiro) ou, com um trecho selecionado em modo visual, `:'<,'>ClaudeAsk
<pergunta>` (usa só a seleção). O resultado aparece em um split de
terminal na parte de baixo da tela; feche-o normalmente com `:q` ou
`Ctrl-w c` quando terminar.

## Git (GitHub)

Atalhos via `vim-fugitive` (já incluso na instalação):

| Atalho         | Ação                                    |
|----------------|-------------------------------------------|
| `<espaço> g i` | Inicializar repositório (`git init`)       |
| `<espaço> g s` | Status (`git status`, painel interativo)   |
| `<espaço> g a` | Adicionar o arquivo atual (`git add %`)    |
| `<espaço> g A` | Adicionar tudo (`git add -A`)              |
| `<espaço> g c` | Commit (`git commit`, abre editor de mensagem)|
| `<espaço> g p` | Push (`git push`)                          |
| `<espaço> g P` | Pull (`git pull`)                          |
| `<espaço> g l` | Log (`git log`)                            |

No painel de status (`<espaço> g s`), também dá para usar os atalhos
nativos do fugitive: `s` para stage, `u` para unstage, `cc` para commit e
`g?` para ver a ajuda completa.

## Plugins instalados

- **Temas**: `dracula/vim`, `morhetz/gruvbox`, `arcticicestudio/nord-vim`,
  `joshdick/onedark.vim`, `tomasr/molokai`, `drewtempelmeyer/palenight.vim`,
  `sainnhe/everforest`
- **Interface**: `vim-airline`, `vim-airline-themes`, `preservim/nerdtree`,
  `airblade/vim-gitgutter`, `Yggdroot/indentLine`
- **Bash/Shell**: `arzg/vim-sh`, `dense-analysis/ale`
- **Snippets**: `SirVer/ultisnips`, `honza/vim-snippets`
- **IA**: `github/copilot.vim` (Claude usa o `:terminal` nativo do Vim, sem plugin)
- **Produtividade**: `tpope/vim-commentary`, `tpope/vim-surround`,
  `tpope/vim-fugitive`, `jiangmiao/auto-pairs`, `junegunn/fzf`,
  `junegunn/fzf.vim`

## Atualizando a configuração

Para mudar algo permanentemente, edite os arquivos dentro de `files/` (nunca
edite `~/.vimrc` direto, pois ele é sobrescrito a cada execução) e rode de
novo:

```bash
./vim_install.sh --no-apt
```
