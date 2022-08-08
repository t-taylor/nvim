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
set nospell
set spelllang=en,cjk
set clipboard+=unnamedplus
set inccommand=split
set winwidth=80
set list

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
let g:python_host_prog = 'python2'
let g:python3_host_prog = 'python3'

" QOL/binds
map Y y$
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :
nnoremap ZQ :qa<cr>
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

nnoremap <silent> yoq :call QuickFix_toggle()<cr>

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

nnoremap <silent> <C-L> :nohl<CR><C-L>:syntax sync minlines=10000<cr>
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
"Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
"" ansi color esc
Plug 'chrisbra/Colorizer'
"" Brackets
Plug 'machakann/vim-sandwich'
"" Fancy git stuff
Plug 'tpope/vim-fugitive'
"" fzf
Plug 'junegunn/fzf'
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
" Math
Plug 'arecarn/vim-crunch'
" Comment
Plug 'tpope/vim-commentary'
" Complete
Plug 'davidhalter/jedi-vim'
"" indent
"Plug 'Vimjas/vim-python-pep8-indent'
Plug 'psf/black', {'branch': 'stable'}
" terminal text pipe
Plug 'kassio/neoterm'
" GO
Plug 'fatih/vim-go'
" editorconfig
Plug 'editorconfig/editorconfig-vim'
" copilot
"Plug 'github/copilot.vim'
" swap
Plug 'machakann/vim-swap'
" juypter notebook
Plug 'untitled-ai/jupyter_ascending.vim'
" mysql
Plug 'tpope/vim-dadbod'
" indent markers
Plug 'Yggdroot/indentLine'
" Spell check
Plug 'kamykn/spelunker.vim'
Plug 'kamykn/popup-menu.nvim'
call plug#end()

" Important!!
if has('termguicolors')
  set termguicolors
endif
" For dark version.
set background=dark
colorscheme gruvbox-material

" complete
set completeopt=menu
set omnifunc=syntaxcomplete#Complete
"let g:float_preview#docked = 1
"
let g:indentLine_char = '>'
