vim.cmd([[
    syntax sync minlines=100
    syntax sync maxlines=240
    set synmaxcol=800
]])

require("lspconfig")["phpactor"].setup({
    on_attach = lsp_on_attach,
    flags = lsp_flags,
    settings = {},
})
