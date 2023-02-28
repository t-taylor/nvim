local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.formatting.gofumpt,
		--null_ls.builtins.diagnostics.revive,
	},
})

-- Create some helpers
local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

local _general = agrp("_general", { clear = true })
acmd({ "BufWritePre" }, {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format()
	end,
	group = _general,
})
