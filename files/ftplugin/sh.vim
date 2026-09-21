" Configurações específicas para arquivos shell/bash
setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal commentstring=#\ %s
setlocal foldmethod=marker

" <leader>r : salva e executa o script atual
nnoremap <buffer> <leader>r :w<CR>:!bash %<CR>
" <leader>x : marca o script como executável
nnoremap <buffer> <leader>x :!chmod +x %<CR>
