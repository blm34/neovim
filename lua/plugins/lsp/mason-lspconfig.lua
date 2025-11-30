return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
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

        vim.lsp.enable({
            'basedpyright',
            'ruff',
            'lua_ls',
            'texlab',
        })
    end,
}
