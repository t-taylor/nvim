require("lspconfig")["lua_ls"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
})

vim.cmd([[
augroup stylua_save
  autocmd!
  autocmd BufWritePost *.lua silent Dispatch! stylua %
augroup end
]])
