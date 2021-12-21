" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>

function! ReuseVimGoTerm(cmd) abort
    for w in nvim_list_wins()
        if "goterm" == nvim_buf_get_option(nvim_win_get_buf(w), 'filetype')
            call nvim_win_close(w, v:true)
            break
        endif
    endfor
    execute a:cmd
endfunction

let g:go_term_enabled = 1
let g:go_term_mode = "silent keepalt rightbelow 10 split"
let g:go_def_reuse_buffer = 1

nnoremap <buffer> <leader>r :call ReuseVimGoTerm('GoRun')<Return>
nnoremap <buffer> <leader>T :call ReuseVimGoTerm('GoTest')<Return>
nnoremap <buffer> <leader>t :call ReuseVimGoTerm('GoTestFunc')<Return>

function! CloseVimGoTerm() abort
    for w in nvim_list_wins()
        if "goterm" == nvim_buf_get_option(nvim_win_get_buf(w), 'filetype')
            call nvim_win_close(w, v:true)
            break
        endif
    endfor
endfunction

nnoremap <buffer> <leader>c :call CloseVimGoTerm()<Return>

nnoremap <buffer> <leader>ds :GoDebugStart<cr>
nnoremap <buffer> <leader>dt :GoDebugTestFunc<cr>
nnoremap <buffer> <leader>db :GoDebugBreakpoint<cr>
nnoremap <buffer> <leader>dc :GoDebugContinue<cr>
nnoremap <buffer> <leader>de :GoDebugStop<cr>
