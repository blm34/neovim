require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright", -- Python
        "ruff",         -- Python linting
        "lua_ls",       -- Lua
        "bashls",       -- Bash
        "marksman",     -- Markdown
        "texlab",       -- Latex
    },
    automatic_installation = true,
})

require("lsp.completion")
require("lsp.diagnostics")

vim.lsp.enable({
    'basedpyright',
    'ruff',
    'lua_ls',
    'texlab',
})
