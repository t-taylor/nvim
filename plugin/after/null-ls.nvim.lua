local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- lua
        null_ls.builtins.formatting.stylua,

        -- golang
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
        --null_ls.builtins.diagnostics.revive,

        -- php
        --null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.diagnostics.phpmd.with({
            extra_args = { "unusedcode" },
        }),
        --null_ls.builtins.diagnostics.phpstan,
        --null_ls.builtins.diagnostics.php,

        -- terraform
        -- null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.formatting.terraform_fmt,

        -- misc
        --null_ls.builtins.diagnostics.semgrep,
        null_ls.builtins.diagnostics.codespell,

        -- javascript/typescript
        null_ls.builtins.diagnostics.eslint,

        -- json
        null_ls.builtins.formatting.jq,
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
