require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright", -- Python
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
    'lua_ls',
})
