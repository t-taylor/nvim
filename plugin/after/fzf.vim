" fzf
function! RgRange() range
    " Get the line and column of the visual selection marks
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]

    " Get all the lines represented by this range
    let lines = getline(lnum1, lnum2)

    " The last line might need to be cut if the visual selection didn't end on the last column
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    " The first line might need to be trimmed if the visual selection didn't start on the first column
    let lines[0] = lines[0][col1 - 1:]

    " Get the desired text
    let selectedText = join(lines, "\n")

    call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(selectedText), 1, 0)
endfunction

nnoremap fzb :Buffers<cr>
nnoremap fzf :Files<cr>
nnoremap fz/ :Rg<cr>
nnoremap fz* :Rg <C-R>=expand("<cword>")<CR><CR>
vnoremap fz/ :call RgRange()<cr>
nnoremap fzt :Lines<cr>
nnoremap fzl :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case .", 1, 0)<cr>

