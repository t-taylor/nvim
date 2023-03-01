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

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<leader>r", function()
	vim.cmd.Dispatch("cargo run")
end, bufopts)
vim.keymap.set("n", "<leader>T", function()
	vim.cmd.Dispatch("cargo test --workspace")
end, bufopts)
vim.keymap.set("n", "<leader>b", function()
	vim.cmd.Dispatch("cargo build --workspace")
end, bufopts)

vim.g.rustfmt_autosave = 1

local old_notify = vim.notify
local silence_pat = '[lspconfig] cmd ("cargo'
vim.notify = function(msg, level, opts)
	if string.sub(msg, 1, string.len(silence_pat)) ~= silence_pat then
		old_notify(msg, level, opts)
	end
end
