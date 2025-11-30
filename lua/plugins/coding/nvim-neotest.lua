return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        -- "antoinemadec/FixCursorHold.nvim",  -- Repo says possibly needed (recommended)
        "nvim-treesitter/nvim-treesitter",

        -- Required Adapters
        "nvim-neotest/neotest-python",
    },
    keys = {
        {
            "<leader>tt",
            function() require("neotest").run.run() end,
            desc = "Run closest test"
        },
        {
            "<leader>tf",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            desc = "Run tests in file",
        },
        {
            "<leader>ta",
            function() require("neotest").run.run({ suite = true }) end,
            desc = "Run tests in suite",
        },
        {
            "<leader>dt",
            function() require("neotest").run.run({ strategy = "dap" }) end,
            desc = "Debug the closest test",
        },
        {
            "<leader>tq",
            function() require("neotest").run.stop() end,
            desc = "Stop test run",
        },
        {
            "<leader>ts",
            function() require("neotest").summary.toggle() end,
            desc = "Open test summary",
        },
        {
            "<leader>to",
            function() require("neotest").output.open() end,
            desc = "Open test output",
        },
        {
            "<leader>tO",
            function() require("neotest").output_panel.toggle() end,
            desc = "Toggle output panel",
        },
        {
            "<leader>tf",
            function() require("neotest").jump.next({ status = "failed" }) end,
            desc = "Jump to failing test",
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            }
        })
    end
}
