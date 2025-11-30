return {
    "lewis6991/hover.nvim",
    lazy = true,
    keys = {
        {
            "K",
            function() require("hover").open() end,
            desc = "hover.nvim (open)",
        },
        {
            "gK",
            function() require("hover").enter() end,
            desc = "hover.nvim (enter)",
        },
        -- ToDo: Next and previous don't work - why?
        {
            "<C-p>",
            function() require("hover").switch("previous") end,
            desc = "hover.nvim (previous source)",
        },
        {
            "<C-n>",
            function() require("hover").switch("next") end,
            desc = "hover.nvim (next source)",
        },
    },
    config = function()
        local hover = require("hover")
        hover.config({
            providers = {
                'hover.providers.diagnostic',
                'hover.providers.lsp',
                'hover.providers.dap',
                'hover.providers.man',
                'hover.providers.dictionary',
            },
        })
    end
}
