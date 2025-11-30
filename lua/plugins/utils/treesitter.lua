return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotage = { enable = true },
            ensure_installed = {
                "lua",
                "python",
                "bash",
                "csv",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "html",
                "json",
                "markdown",
                "markdown_inline",
                "regex",
                "sql",
                "toml",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
        })
    end
}
