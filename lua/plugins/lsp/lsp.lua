return {
    {
        "neovim/nvim-lspconfig", -- LSP client
    },
    {
        "williamboman/mason-lspconfig.nvim", -- Mason to lspconfig bridge
        dependencies = {
            "williamboman/mason.nvim",
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
        end,
    },
}
