let g:neoterm_eof=""
"autocmd BufWritePre *.py execute ':Black'

nnoremap <buffer> <leader>nx :call jupyter_ascending#execute()<cr>
nnoremap <buffer> <leader>nX :call jupyter_ascending#execute_all()<cr>

