local handlers = require("lsp.handlers")

return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,

    init_options = {
        settings = {
            args = {}
        }
    }
}
