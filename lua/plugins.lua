require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Load on an autocommand event
	use({ "andymass/vim-matchup", event = "VimEnter" })

	use("sainnhe/gruvbox-material")

	-- ansi color esc
	use("chrisbra/Colorizer")

	-- Brackets
	use("machakann/vim-sandwich")

	-- Fancy git stuff
	use("tpope/vim-fugitive")

	-- fzf
	use("junegunn/fzf")
	use("junegunn/fzf.vim")

	-- More verbs/ motions
	use("wellle/targets.vim")
	use("easymotion/vim-easymotion")

	-- syntax
	use("sheerun/vim-polyglot")

	-- common bindings
	use("tpope/vim-unimpaired")

	-- rename
	use("tpope/vim-eunuch")

	-- Async
	use("mhinz/neovim-remote")

	-- Async make
	use("neomake/neomake")

	-- Unicode
	use("chrisbra/unicode.vim")

	-- Makestuff
	use("tpope/vim-dispatch")
	-- Math
	use("arecarn/vim-crunch")
	-- Comment
	use("tpope/vim-commentary")

	-- GO
	use("fatih/vim-go")

	-- swap
	use("machakann/vim-swap")

	-- indent markers
	use("Yggdroot/indentLine")

	-- Spell check
	use("kamykn/spelunker.vim")
	use("kamykn/popup-menu.nvim")

	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- rust
	use("simrat39/rust-tools.nvim")
end)

require("mason").setup()
require("mason-lspconfig").setup()

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✗'})
sign({name = 'DiagnosticSignWarn', text = '‼'})
sign({name = 'DiagnosticSignHint', text = '💡'})
sign({name = 'DiagnosticSignInfo', text = 'ℹ'})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
