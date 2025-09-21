return {
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            vim.notify = require("notify")
        end
    },
    {
        'm4xshen/hardtime.nvim',
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        opts = {}
    }
}
