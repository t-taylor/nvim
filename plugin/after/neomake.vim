let g:neoterm_default_mod='vertical bo' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
let g:neoterm_automap_keys=""
nnoremap <leader>m :TREPLSendLine<cr><cr>" send current line and move down
vnoremap <leader>m :TREPLSendSelection<cr> " send current selection
nnoremap <leader>% :TREPLSendFile<cr>

let g:neoterm_repl_python = "pipenv run ipython --no-autoindent"

let g:neomake_go_enabled_makers = ['go', 'golangci_lint']
let g:neomake_php_enabled_makers = ['php', 'phpmd']
call neomake#configure#automake('rw', 500)
