return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  use 'sainnhe/gruvbox-material'

  -- ansi color esc
  use 'chrisbra/Colorizer'

  -- Brackets
  use 'machakann/vim-sandwich'

  -- Fancy git stuff
  use 'tpope/vim-fugitive'

  -- fzf
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- More verbs/ motions
  use 'wellle/targets.vim'
  use 'easymotion/vim-easymotion'

  -- syntax
  use 'sheerun/vim-polyglot'

  -- common bindings
  use 'tpope/vim-unimpaired'

  -- rename
  use 'tpope/vim-eunuch'

  -- Async
  use 'mhinz/neovim-remote'

  -- Async make
  use 'neomake/neomake'

  -- Unicode
  use 'chrisbra/unicode.vim'

  -- Makestuff
  use 'tpope/vim-dispatch'
  -- Math
  use 'arecarn/vim-crunch'
  -- Comment
  use 'tpope/vim-commentary'

  -- GO
  use 'fatih/vim-go'

  -- swap
  use 'machakann/vim-swap'

  -- indent markers
  use 'Yggdroot/indentLine'

  -- Spell check
  use 'kamykn/spelunker.vim'
  use 'kamykn/popup-menu.nvim'

end)
