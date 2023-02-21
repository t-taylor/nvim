require("lspconfig")["lua_ls"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
})
