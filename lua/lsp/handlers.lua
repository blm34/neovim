local M = {}

function M.on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>rn", function()
        local current_name = vim.fn.expand("<cword>")
        vim.ui.input({
            prompt = "Rename to: ",
            default = current_name,
        }, function(input)
            if input and #input > 0 and input ~= current_name then
                vim.lsp.buf.rename(input)
            end
        end)
    end, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format() end,
        })
    end
end

-- Capabilities (needed for nvim-cmp completion)
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
