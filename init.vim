" General
set number
set relativenumber
syntax on
filetype indent plugin on
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set modeline
set ruler
set backspace=2
set encoding=utf-8
set spell
set clipboard+=unnamedplus
set inccommand=split
set winwidth=80

set undofile
set undodir=~/.local/share/nvim/undo
set undolevels=1000
set undoreload=10000

" URL: http://vim.wikia.com/wiki/Example_vimrc
set hidden
set wildmenu
set showcmd
set ignorecase
set smartcase
set autoindent
set nostartofline
set laststatus=2
set confirm
set cmdheight=1
set notimeout ttimeout ttimeoutlen=200
set signcolumn=yes

set nojoinspaces

set updatetime=300
set shortmess+=c

set mouse=a

set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

" Shell
set shell=bash
"" Python
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" QOL/binds
map Y y$
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :
nnoremap ZQ :qa<cr>
nmap zp z=
inoremap <C-e> <C-o>e<right>
inoremap <C-a> <C-o>b
inoremap jk <Esc>
inoremap jl <Esc>:w<cr>
tnoremap jk <C-\><C-n>
nnoremap go :tabedit

nnoremap <space><space> A

let mapleader=","
nnoremap <space> <nop>
let maplocalleader=" "

function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

nnoremap <silent> coq :call QuickFix_toggle()<cr>

" persistent sessions
function! MakeSession()
  let b:sessiondir = $HOME . "/.local/share/nvim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.local/share/nvim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

nmap <leader>ss ;call LoadSession()<cr>
nmap <leader>sS ;call MakeSession()<cr>

" termbin
nnoremap gy :w !nc termbin.com 9999 \| xclip -selection clipboard<cr>

nnoremap <silent> <C-L> :nohl<CR><C-L>
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

nnoremap <silent> <F6> :set spell!<cr>

"##### auto fcitx  ###########
let g:input_toggle = 0
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"Exit insert mode
autocmd InsertLeave * call Fcitx2en()
"Enter insert mode
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######

" Hide status bar
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set showtabline=0
        set nu!
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set showtabline=2
        set nu!
    endif
endfunction

nnoremap <F7> :call ToggleHiddenAll()<CR>

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

au BufRead /tmp/mutt-* set tw=72

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
"" Color scheme
Plug 'morhetz/gruvbox'
"" ansi color esc
Plug 'chrisbra/Colorizer'
"" Brackets
Plug 'machakann/vim-sandwich'
"" Fancy git stuff
Plug 'tpope/vim-fugitive'
"" fzf
Plug 'junegunn/fzf.vim'
"" More verbs/ motions
Plug 'wellle/targets.vim'
Plug 'easymotion/vim-easymotion'
"" syntax
Plug 'sheerun/vim-polyglot'
"" common bindings
Plug 'tpope/vim-unimpaired'
"" rename
Plug 'tpope/vim-eunuch'
"" slup for clojure (great repo)
"Plug 'guns/vim-sexp'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Async
Plug 'mhinz/neovim-remote'
" clj
"Plug 'Olical/conjure'
" Async make
Plug 'neomake/neomake'
" Unicode
Plug 'chrisbra/unicode.vim'
" Makestuff
Plug 'tpope/vim-dispatch'
" Complete
"Plug 'ncm2/float-preview.nvim'
"" quickfix gutter
"Plug 'tomtom/quickfixsigns_vim'
" Math
Plug 'arecarn/vim-crunch'
" Complete
"Plug 'davidhalter/jedi-vim'
" indent
Plug 'Vimjas/vim-python-pep8-indent'
" terminal text pipe
Plug 'kassio/neoterm'
" GO
Plug 'fatih/vim-go'
call plug#end()


" gruvbox
set background=dark
"let g:gruvbox_improved_strings=1
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_italic=1
colorscheme gruvbox

" buffkill
let g:BufKillCreateMappings = 0

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

nnoremap <tab>b :Buffers<cr>
nnoremap <tab>f :Files<cr>
nnoremap <tab>/ :Rg<cr>
nnoremap <tab>* :Rg <C-R>=expand("<cword>")<CR><CR>
vnoremap <tab>/ :call RgRange()<cr>
nnoremap <tab>t :Lines<cr>

" complete
set completeopt=menu
"let g:float_preview#docked = 1

" neoterm
let g:neoterm_default_mod='vertical bo' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
let g:neoterm_automap_keys=""
nnoremap <leader>m :TREPLSendLine<cr><cr>" send current line and move down
vnoremap <leader>m :TREPLSendSelection<cr> " send current selection
nnoremap <leader>% :TREPLSendFile<cr>

let g:neoterm_repl_python = "pipenv run ipython --no-autoindent"
