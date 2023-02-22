require("lspconfig")["terraformls"].setup({
	on_attach = lsp_on_attach,
	flags = lsp_flags,
})
