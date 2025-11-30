require("lsp.completion")
require("lsp.diagnostics")

vim.lsp.enable({
    'basedpyright',
    'ruff',
    'lua_ls',
    'texlab',
})
