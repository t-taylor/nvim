local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

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
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	-- More verbs/ motions
	use("wellle/targets.vim")
	use("easymotion/vim-easymotion")

	-- syntax
	use("sheerun/vim-polyglot")

	-- common bindings
	use("tpope/vim-unimpaired")

	-- rename
	use("tpope/vim-eunuch")

	-- Unicode
	use("chrisbra/unicode.vim")

	-- Makestuff
	use("tpope/vim-dispatch")
	-- Math
	use("arecarn/vim-crunch")
	-- Comment
	use("tpope/vim-commentary")

	-- swap
	use("machakann/vim-swap")

	-- indent markers
	use("Yggdroot/indentLine")

	-- project folderuse {
	use("ahmedkhalf/project.nvim")

	use({ "shortcuts/no-neck-pain.nvim", tag = "*" })

	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	-- null-lsp
	use("jose-elias-alvarez/null-ls.nvim")

	-- rust
	use("simrat39/rust-tools.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use("folke/trouble.nvim")

	-- Ensure packer is installed
	if packer_bootstrap then
		require("packer").sync()
	end
end)

require("mason").setup()
require("mason-lspconfig").setup()

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "✗" })
sign({ name = "DiagnosticSignWarn", text = "‼" })
sign({ name = "DiagnosticSignHint", text = "💡" })
sign({ name = "DiagnosticSignInfo", text = "ℹ" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
