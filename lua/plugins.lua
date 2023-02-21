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
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- rust
	use("simrat39/rust-tools.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

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
