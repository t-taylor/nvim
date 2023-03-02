-- Setup extra parsers.
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"go",
		"gomod",
		"html",
		"javascript",
		"json",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"php",
		"python",
		"regex",
		"rust",
		"sql",
		"terraform",
		"toml",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = 'gnn',
	-- 		node_incremental = 'grn',
	-- 		scope_incremental = 'grc',
	-- 		node_decremental = 'grm',
	-- 	},
	-- },

	indent = {
		enable = true,
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>>"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader><"] = "@parameter.inner",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})
-- code folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10 -- deepest fold is 10 levels
vim.opt.foldenable = false -- don't fold by default
vim.opt.foldlevel = 1
