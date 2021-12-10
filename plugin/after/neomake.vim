let g:neoterm_default_mod='vertical bo' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
let g:neoterm_automap_keys=""
nnoremap <leader>m :TREPLSendLine<cr><cr>" send current line and move down
vnoremap <leader>m :TREPLSendSelection<cr> " send current selection
nnoremap <leader>% :TREPLSendFile<cr>

let g:neoterm_repl_python = "pipenv run ipython --no-autoindent"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

let g:neomake_go_enabled_makers = ['go']
call neomake#configure#automake('rw', 500)
