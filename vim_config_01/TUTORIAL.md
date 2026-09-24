# Tutorial de Atalhos - vim_config_01

`mapleader` = `,` (vírgula) — todo atalho `<Leader>` abaixo é `,` + tecla.

## Claude Code (claudecode.nvim)

Requer Neovim + Claude Code CLI instalado e autenticado (comando `claude` no PATH).

| Atalho | Modo | Ação |
|---|---|---|
| `,ac` | Normal | Abre o Claude Code |
| `,af` | Normal | Foca na janela do Claude Code |
| `,ar` | Normal | Retoma a última sessão (`--resume`) |
| `,aC` | Normal | Continua a última conversa (`--continue`) |
| `,am` | Normal | Seleciona o modelo |
| `,ab` | Normal | Adiciona o arquivo atual (`%`) como contexto |
| `,as` | Visual | Envia o trecho selecionado para o Claude |
| `,aa` | Normal | Aceita o diff sugerido |
| `,ad` | Normal | Rejeita o diff sugerido |

## ChatGPT.nvim

Requer a variável de ambiente `$OPENAI_API_KEY` definida antes de abrir o nvim.

| Atalho | Modo | Ação |
|---|---|---|
| `,oo` | Normal | Abre o ChatGPT |
| `,oa` | Normal | ChatGPT Act As... |
| `,oe` | Visual | Edita o trecho selecionado com instruções |
| `,of` | Normal | Roda ação "fix_bugs" |
| `,ox` | Normal | Roda ação "explain_code" |
| `,ot` | Normal | Roda ação "add_tests" |

## Navegação de arquivos e código

| Atalho | Modo | Ação |
|---|---|---|
| `Ctrl+n` | Normal | Alterna o NERDTree |
| `,ne` | Normal | Abre o NERDTree |
| `,rr` | Normal | Foca o NERDTree e recarrega (`R`) |
| `Ctrl+b` | Normal | Alterna o Tagbar *(sobrescrito depois por Bracey, ver abaixo)* |
| `Ctrl+p` | Normal | FZF - busca de arquivos (`:Files`) |
| `Ctrl+f` | Normal | Telescope - grep de string (pede o termo) |

> Nota: `Ctrl+b` é mapeado duas vezes no arquivo (`TagbarToggle` e depois `:Bracey`) — vale o último, que é o Bracey.

## Git (vim-fugitive)

| Atalho | Ação |
|---|---|
| `,gl` | `git log` |
| `,gc` | `git commit` |
| `,gp` | `git push` |
| `,gs` | `git status` (`:G`) |
| `,gb` | Abre a URL do GitHub no navegador (`:GBrowse`) |
| `,sg` | Roda o script `/bin/subGit.sh` |

## Debug (vimspector)

| Atalho | Ação |
|---|---|
| `,dd` | Inicia o debug (`Launch`) |
| `,de` | Reseta / avalia expressão (mapeado duas vezes: `Reset` e depois `VimspectorEval`) |
| `,dc` | Continua execução |
| `,dt` | Toggle breakpoint |
| `,dT` | Limpa todos os breakpoints |
| `,dk` | Reinicia o debugger |
| `,dh` | Step out |
| `,dl` | Step into |
| `,dj` | Step over |
| `,dx` | Reseta o Vimspector |
| `,dw` | Vimspector Watch |
| `,do` | Mostra o output do Vimspector |

> Java: `,dd` em arquivos `.java` usa `CocCommand java.debug.vimspector.start` em vez do launch padrão.

## LSP (nvim-lspconfig)

| Atalho | Ação |
|---|---|
| `gd` | Vai para a definição |
| `gdd` | Vai para a declaração |
| `gr` | Lista referências |
| `gi` | Vai para a implementação |
| `gk` | Mostra hover/documentação |
| `Ctrl+k` | Mostra signature help *(também usado pelo LSP diagnostic goto_prev — conflito, ver nota)* |
| `Ctrl+n` | Próximo diagnóstico *(conflita com o toggle do NERDTree acima)* |
| `Ctrl+p` | Próximo diagnóstico *(conflita com o FZF Files acima)* |
| `mm` | Renomeia o símbolo sob o cursor |

> ⚠️ Há conflitos de atalho no arquivo original: `Ctrl+n`, `Ctrl+p` e `Ctrl+k` são remapeados mais de uma vez para coisas diferentes (NERDTree/FZF vs. LSP). Vale sempre o último mapeamento carregado no `vimrc`.

## Emmet (HTML/CSS/JS/PHP)

| Atalho | Modo | Ação |
|---|---|---|
| `Ctrl+y ,` | Insert/Normal | Expande abreviação Emmet |
| `Ctrl+y n` | Insert | Próximo ponto de edição |
| `Ctrl+y p` | Insert | Ponto de edição anterior |
| `Ctrl+y ,` | Visual | Envolve seleção com tag |
| `Ctrl+y d` | Insert | Move tag para fora |
| `Ctrl+y D` | Insert | Move tag para dentro |
| `Ctrl+y +` | Insert | Incrementa número |
| `Ctrl+y -` | Insert | Decrementa número |

## Bracey (live server HTML/CSS/JS)

| Atalho | Ação |
|---|---|
| `Ctrl+b` | Inicia o Bracey |
| `Ctrl+u` | Recarrega o Bracey |
| `Ctrl+q` | Para o servidor Bracey *(conflita com "sair descartando" abaixo)* |

## Edição e movimentação

| Atalho | Modo | Ação |
|---|---|---|
| `Ctrl+e` | Insert | Vai para o fim da linha |
| `Ctrl+a` | Insert | Vai para o início da linha |
| `Ctrl+j` | Insert | Abre nova linha abaixo |
| `Ctrl+k` | Insert | Vai para a linha de cima |
| `Ctrl+l` | Insert | Apaga a palavra atual (substitui) |
| `Ctrl+u` | Insert/Normal | Maiúsculas na palavra sob o cursor |
| `Ctrl+s` | Insert/Normal | Salva o arquivo |
| `Ctrl+q` | Insert/Normal | Sai descartando alterações |
| `<` / `>` | Visual | Recua/avança indentação mantendo seleção |
| `Ctrl+h/j/k/l` | Normal | Navega entre janelas |
| `Alt+h/j/k/l` | Normal | Redimensiona janelas |
| `Tab` | Normal | Próxima aba |
| `Shift+Tab` | Normal | Aba anterior |
| `Ctrl+t` | Normal | Nova aba |
| `Ctrl+k` | Normal | Fecha aba *(conflita com "linha de cima" acima)* |
| Setas (↑↓←→) | Normal/Visual | Desabilitadas (`<NOP>`) |
| `;;` | Terminal/Insert | Sai para o modo normal |
| `,t` | Normal | Abre terminal (`vsplit term://zsh`) |
| `Ctrl+c` | Visual | Copia (`yank`) para a área de transferência (`"+y`) |
| `Ctrl+l` | Normal | Limpa o highlight de busca *(conflita com "apaga palavra" no insert, mas são modos diferentes)* |
| `,r` | Normal | Substituir todas as ocorrências (`:%s///g`) |
| `,rc` | Normal | Substituir com confirmação (`:%s///gc`) |
| `,r` / `,rc` | Visual | Mesma coisa, só no trecho selecionado |
| `*` | Visual | Busca a seleção atual |
| `Ctrl+c` | Normal | Comenta a linha (`:Commentary`) |

## Observação sobre conflitos

Este `vimrc` tem vários atalhos remapeados mais de uma vez (`Ctrl+n`, `Ctrl+p`, `Ctrl+k`, `Ctrl+b`, `Ctrl+q`, `Ctrl+l`). No Vim/Neovim, quando a mesma combinação é mapeada duas vezes no mesmo modo, **o último mapeamento no arquivo sobrescreve o anterior**. Se algum desses atalhos não estiver funcionando como esperado, é por causa disso — vale revisar e remover as duplicatas.
