require("lspconfig")["gopls"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
	settings = {},
})

require("lspconfig")["golangci_lint_ls"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
	settings = {},
})

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<leader>B", function()
	vim.cmd.Dispatch("go build ./...")
end, bufopts)
vim.keymap.set("n", "<leader>b", function()
	vim.cmd.Dispatch("go build %")
end, bufopts)
vim.keymap.set("n", "<leader>T", function()
	vim.cmd.Dispatch("go test ./...")
end, bufopts)
vim.keymap.set("n", "<leader>r", function()
	vim.cmd.Dispatch("go run %")
end, bufopts)
vim.keymap.set("n", "<leader>v", function()
	vim.cmd.Dispatch("go vet %")
end, bufopts)
vim.keymap.set("n", "<leader>V", function()
	vim.cmd.Dispatch("go vet ./...")
end, bufopts)

vim.cmd([[
augroup go_fmt
  autocmd!
  autocmd BufWritePost *.go silent Dispatch! go fmt %
augroup end
]])
