require("lspconfig")["tsserver"].setup({
    on_attach = lsp_on_attach,
    flags = lsp_flags,
    settings = {},
})
