return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
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
