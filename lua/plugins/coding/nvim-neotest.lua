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
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            }
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>tt", function()
            neotest.run.run()
        end, { desc = "Run closest test" })

        vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "Run tests in file" })

        vim.keymap.set("n", "<leader>ta", function()
            neotest.run.run({ suite = true })
        end, { desc = "Run tests in suite" })

        vim.keymap.set("n", "<leader>dt", function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "Debug the closest test" })

        vim.keymap.set("n", "<leader>tq", function()
            neotest.run.stop()
        end, { desc = "Stop test run" })

        vim.keymap.set("n", "<leader>ts", function()
            neotest.summary.toggle()
        end, { desc = "Open test summary" })

        vim.keymap.set("n", "<leader>to", function()
            neotest.output.open()
        end, { desc = "Open test output" })

        vim.keymap.set("n", "<leader>tO", function()
            neotest.output_panel.toggle()
        end, { desc = "Toggle output panel" })

        vim.keymap.set("n", "<leader>tf", function()
            neotest.jump.next({ status = "failed" })
        end, { desc = "Jump to failing test" })
    end
}
