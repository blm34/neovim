return {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },
    -- Load when a keymap defined by nvim-dap is used
    keys = {
        { "<leader>dc" },
        { "<leader>db" },
        { "<leader>dB" },
        { "<leader>dL" },
        { "<leader>dq" },
        { "<leader>dk" },
        { "<leader>dr" },
        { "<leader>dl" },
        { "<leader>do" },
        { "<leader>di" },
        { "<leader>dO" },
    },
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "python",
                "bash",
            },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,

                python = function()
                    -- setup defined in dap.lua - do nothing here
                end,
            },
        })
    end,
}
