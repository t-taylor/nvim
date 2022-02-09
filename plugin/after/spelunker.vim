nnoremap yos :call SpellToggle()<cr>

function! SpellToggle()
    if g:enable_spelunker_vim
        let g:enable_spelunker_vim = 0
    else
        let g:enable_spelunker_vim = 1
        call spelunker#check()
    endif
endfunction
