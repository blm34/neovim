local handlers = require("lsp.handlers")

return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
