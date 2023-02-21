local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

require("lspconfig")["rust_analyzer"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
	settings = {
		["rust-analyzer"] = {},
	},
})
