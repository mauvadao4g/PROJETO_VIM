"---------------------------------------------------------------
" INICIANDO CONFIGURAÇÕES
" Ver: 11
" MAUVADAO
"---------------------------------------------------------------
"------------------------------------------------
" Gerenciador de plugins
" Install VimPlug from - https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"------------------------------------------------

call plug#begin('~/.vim/autoload/plug/start')

" COMPILOT -> GITHUB
Plug  'github/copilot.vim'

" Claude Code -> integracao oficial com o Claude Code CLI (protocolo MCP)
Plug 'folke/snacks.nvim'
Plug 'coder/claudecode.nvim'

" ChatGPT -> requer $OPENAI_API_KEY no ambiente
Plug 'MunifTanjim/nui.nvim'
Plug 'jackMort/ChatGPT.nvim'

" Temas
Plug 'arcticicestudio/nord-vim'           " tema nord
Plug 'joshdick/onedark.vim'               " tema onedark
Plug 'sainnhe/everforest'                 " tema everforest
Plug 'sainnhe/gruvbox-material'           " tema material basado en gruvbox
Plug 'sainnhe/sonokai'                    " tema sonokai
Plug 'folke/tokyonight.nvim'              " tema tokyo night
Plug 'glepnir/zephyr-nvim'                " tema zephyr
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'tomasr/molokai'
Plug 'zenorocha/dracula-theme'
Plug 'morhetz/gruvbox'
" temas Novos.
Plug 'rakr/vim-one' " For mac
" Plug 'sonph/onehalf', { 'rtp': 'vim' } "preferred on linux server
Plug 'dracula/vim', { 'as': 'dracula' }    " tema dracula

" Suporte ao live server para HTML/CSS/JS
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Mostrar paleta de cores nos codigos Exe; #fff
Plug 'ap/vim-css-color'


" SNIPPETS
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'

Plug 'mattn/emmet-vim'

Plug 'Shougo/neocomplete.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/vimshell.vim'

Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'gmarik/Vundle.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"------------------------
" TESTANDO NOVOS PLUGINS
"------------------------
" Used to comment whe whole line or select lines
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'


" Viminspector to debug
Plug 'puremourning/vimspector'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Better Syntax Support
Plug 'sheerun/vim-polyglot'

" Git pluggin
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Used to shows icons on screen
Plug 'ryanoasis/vim-devicons'


" Styled components
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Go extension
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'


"Git plugin
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Prettier for code
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" Used to shows icons on screen
Plug 'ryanoasis/vim-devicons'

"Plugin for search engine inside nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'


" Viminspector to debug
Plug 'puremourning/vimspector'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'




" Suporte a Python
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" Melhor navegação entre arquivos
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Melhor navegação de código
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'

" Suporte para controle de Git
Plug 'tpope/vim-fugitive'

" Plugins adicionais para suporte a PHP
Plug 'StanAngeloff/php.vim'


" Suporte a Python
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" Melhor navegação entre arquivos
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()





"------------------------------------------------
" Configurações do VimShell
"------------------------------------------------
" Define a tecla para abrir o VimShell
" nmap <Leader>t :VimShell<CR>

" Use uma janela horizontal para o VimShell
let g:vimshell_window_type = 'horizontal'


"------------------------------------------------
" Configurações do Airline
"------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
highlight Comment gui=none cterm=none
let g:airline_theme='dracula'



"------------------------------------------------
" Configurações gerais
"------------------------------------------------
syntax on
filetype plugin indent on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

" Tema Dracula
set background=dark
colorscheme dracula

"------------------------------------------------
" Melhor visualização
"------------------------------------------------
set cursorline
set termguicolors
" highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray
highlight CursorLine cterm=bold ctermbg=235 guibg=#1e1e1e

"------------------------------------------------
" Configurações do Coc
"------------------------------------------------
set hidden
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

"------------------------------------------------
" Configuração do auto-pairs
"------------------------------------------------
" let g:AutoPairsShortcutToggle = '<C-p>'
let g:AutoPairsMapBS = 1  " Habilitar backspace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida


" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>

"----------------------------------------------------------------
" Configurações do Ultisnips
"----------------------------------------------------------------
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDir = '~/.vim/plugged/ultisnips/'



"------------------------------------------------
" Configuração do emmet
"------------------------------------------------
" Ativar o Emmet apenas em arquivos HTML, CSS, etc.
let g:user_emmet_leader_key='<C-Z>'

" Expandir a abreviação do Emmet com Ctrl+y,
" que é a combinação padrão sugerida pelo plugin
imap <C-y>, <Plug>(emmet-expand-abbr)
nmap <C-y>, <Plug>(emmet-expand-word)

" Navegar entre os pontos de edição do Emmet
imap <C-y>n <Plug>(emmet-next-edit-point)
imap <C-y>p <Plug>(emmet-prev-edit-point)

" Envolver seleção com tag do Emmet (modo visual)
vmap <C-y>, <Plug>(emmet-wrap-with-abbreviation)

"-------------------
" Outras Configurações do Emmet
"-------------------
" Habilitar automaticamente Emmet em tipos de arquivo suportados
autocmd FileType html,css,javascript,php EmmetInstall
let g:user_emmet_settings = {
\   'html' : {
\       'filters' : 'html,css,js',
\   },
\   'css' : {
\       'filters' : 'bem',
\   },
\   'js' : {
\       'filters' : 'js',
\   }
\}

" Personalização de abreviações
" Adicione customizações úteis para projetos recorrentes
let g:user_emmet_custom_snippets = {
\   'html' : {
\       'navheader' : '<nav><ul><li><a href=""></a></li></ul></nav>',
\       'footerlinks' : '<footer><ul><li><a href=""></a></li></ul></footer>',
\   },
\   'css' : {
\       'clearfix' : '&:after { content: ""; display: block; clear: both; }',
\   }
\}

" Auto-expandir "!" para estrutura básica HTML
" "autocmd FileType html inoremap ! html:5<C-y>,



" Outros atalhos úteis
" Mover uma tag ao redor do texto
imap <C-y>d <Plug>(emmet-balance-tag-outward)
imap <C-y>D <Plug>(emmet-balance-tag-inward)

" Incrementar ou decrementar números
imap <C-y>+ <Plug>(emmet-increment-number)
imap <C-y>- <Plug>(emmet-decrement-number)


" ###################
"-------------------
" Configurações de indentação específicas por linguagem
"-------------------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,css,php setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab

"-------------------
" Atalhos personalizados
"-------------------
" Alternar entre NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Alternar entre Tagbar
nnoremap <C-b> :TagbarToggle<CR>

" FZF para busca de arquivos
nnoremap <C-p> :Files<CR>



"-------------------
" Configuração do ALE (Linting)
"-------------------
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'php': ['phpcs'],
\   'html': ['htmlhint'],
\   'css': ['stylelint'],
\   'sh': ['shellcheck']
\}
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'php': ['phpcbf'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'sh': ['shfmt']
\}
let g:ale_fix_on_save = 1


"-------------------
" Configuração do Bracey
"-------------------
let g:bracey_auto_start_browser = 1  " Inicia automaticamente o navegador
let g:bracey_browser_command = 'firefox'  " Define o navegador como Firefox
let g:bracey_server_port = 3000  " Define a porta do servidor
let g:bracey_auto_refresh = 1  " Habilita o auto-refresh automático

" Atalhos personalizados para Bracey
" Iniciar o Bracey com Ctrl+b
nnoremap <C-b> :Bracey<CR>
" Atualizar o Bracey manualmente com Ctrl+u
nnoremap <C-u> :BraceyReload<CR>
" Parar o servidor do Bracey com Ctrl+q
nnoremap <C-q> :BraceyStop<CR>

" Auto-inicialização do Bracey ao abrir arquivos HTML/CSS/JS
autocmd FileType html,css,js silent! :Bracey


"####----||------#######

"------------------------------------------------
" Mapeamentos personalizados no modo de inserção
"------------------------------------------------


" Ctrl+e: Vai para o final da linha e continua editando
inoremap <C-e> <Esc>A

" Ctrl+a: Vai para o início da linha e continua editando
inoremap <C-a> <Esc>I

" Ctrl+l: Vai pra linha de baixo
inoremap <C-j> <Esc>o

" Ctrl+k: Vai pra linha de cima
inoremap <C-k> <Esc>k

" Ctrl+L: Apaga a próxima palavra no modo de inserção
inoremap <C-l> <Esc>S


" Mapeamentos personalizados
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" EASY CAPS - Shift + u = upper case, u = lower case
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Save and exit easier way
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
" inoremap <C-d> <esc>:wq!<cr>               " save and exit
" nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>


" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" TABS
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>
nnoremap <C-t> :tabnew<CR>
 noremap <C-k> :tabclose<CR>
" noremap <C-e> :tabclose<CR>

" No more Arrow keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>

"----------------------
tnoremap ;; <C-\><C-n>
inoremap ;; <Esc>
"----------------------

" Open nerdTree with keyshortcut
let mapleader = ","
" nmap <leader>g :normal! ggVG<CR> "Seleciona todas as linhas
nmap <leader>ne :NERDTree<cr> "Abre o NerdTree

"-------------------------------
" Configurações do Fugitive
" nnoremap <Leader>gs :Git<CR>
" nnoremap <Leader>gc :Git commit<CR>
" nnoremap <Leader>gp :Git push<CR>
"-------------------------------
" Git fugitive mappings
noremap <leader>gl :G log<CR>
noremap <leader>gc :G commit<CR>
noremap <leader>gp :G push<CR>

" Equivalent to git status
noremap <leader>gs :G <CR>

"open github url on web browser
noremap <leader>gb :GBrowse <CR> 
"-------------------------------

" Mapeamento para abrir o terminal
 noremap <Leader>t :vsplit term://zsh<CR>


" Mapear <Leader>cc para comentar a linha atual
noremap <Leader>cc <Esc>

" Mapear <Leader><Esc>cc para descomentar a linha atual
inoremap <Leader><Esc>cc <Esc>^x

"Search for all ocourrences of the phrase that you write
nnoremap <C-f> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>

" CTRL + C now yank the selected
vmap <C-c> "+y

" Clears the vim highlighing
noremap <C-l> :noh<CR>

" Changes all ocourrences for the text that you have typed
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"Debugging keys
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

" Keys for completion
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')

nmap <Leader>rr :NERDTreeFocus<cr>R<c-w><c-p>


"  PLUGINS SETINGS
" VimSpector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>



" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gdd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gk <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <silent> mm <cmd>lua vim.lsp.buf.rename()<CR>
" close rename win use <C-c> in insert mode or  in noremal mode or


"---------------------------------------------------------------
" ADICIONANDO ATALHO PRO SCRIPT subGit.sh
"---------------------------------------------------------------
nnoremap <leader>sg :!bash /bin/subGit.sh<CR>

"------------------------------------------------
" Configuração do Claude Code (claudecode.nvim)
" Requer: Neovim + Claude Code CLI instalado (comando `claude` no PATH)
" pcall porque no primeiro PlugInstall o plugin ainda nao existe
"------------------------------------------------
lua << EOF
pcall(function() require("claudecode").setup() end)
EOF

nnoremap <leader>ac :ClaudeCode<CR>
nnoremap <leader>af :ClaudeCodeFocus<CR>
nnoremap <leader>ar :ClaudeCode --resume<CR>
nnoremap <leader>aC :ClaudeCode --continue<CR>
nnoremap <leader>am :ClaudeCodeSelectModel<CR>
nnoremap <leader>ab :ClaudeCodeAdd %<CR>
vnoremap <leader>as :ClaudeCodeSend<CR>
nnoremap <leader>aa :ClaudeCodeDiffAccept<CR>
nnoremap <leader>ad :ClaudeCodeDiffDeny<CR>

"------------------------------------------------
" Configuração do ChatGPT.nvim
" Requer: variavel de ambiente $OPENAI_API_KEY definida antes de abrir o nvim
"------------------------------------------------
lua << EOF
pcall(function()
  require("chatgpt").setup({
    openai_params = {
      model = "gpt-5-mini",
    },
  })
end)
EOF

nnoremap <leader>oo :ChatGPT<CR>
nnoremap <leader>oa :ChatGPTActAs<CR>
vnoremap <leader>oe :ChatGPTEditWithInstructions<CR>
nnoremap <leader>of :ChatGPTRun fix_bugs<CR>
nnoremap <leader>ox :ChatGPTRun explain_code<CR>
nnoremap <leader>ot :ChatGPTRun add_tests<CR>

"---------------------------------------------------------------
" ENCERRANDO CONFIGURAÇÕES
"---------------------------------------------------------------
