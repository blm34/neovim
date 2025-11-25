return {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
        handlers = {},
        automatic_installation = {
            exclude = {
                "python",
            },
        },
        ensure_installed = {
            "bash",
            "python",
        },
    },
    dependencies = {
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim",
    },
}
