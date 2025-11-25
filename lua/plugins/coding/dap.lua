return {
    -- Core DAP
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local widgets = require("dap.ui.widgets")

            -- Breakpoint sign definitions
            vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DiagnosticError' })
            vim.fn.sign_define("DapBreakpointCondition", { text = '󰋗', texthl = 'DiagnosticError' })
            vim.fn.sign_define("DapLogPoint", { text = 'Ⓛ', texthl = 'DiagnosticError' })
            vim.fn.sign_define("DapStopped", { text = '󰁔', texthl = 'DiagnosticHint', linehl = 'Visual' })
            vim.fn.sign_define("DapBreakpointRejected", { text = '', texthl = 'DiagnosticWarning' })

            -- Auto-open DAP UI
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Keymaps
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<leader>dc", function() dap.continue() end, opts)
            vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, opts)
            vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, opts)
            vim.keymap.set("n", "<leader>dL", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log: ")) end, opts)
            vim.keymap.set("n", "<leader>dq", function() dap.terminate() end, opts)
            vim.keymap.set("n", "<leader>dk", function() widgets.hover() end, opts)
            vim.keymap.set("n", "<leader>dr", function() dap.repl_open() end, opts)
            vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, opts)
            vim.keymap.set("n", "<leader>do", function() dap.step_over() end, opts)
            vim.keymap.set("n", "<leader>di", function() dap.step_into() end, opts)
            vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, opts)
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dapui = require("dapui")
            dapui.setup({})

            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, opts)
        end,
    },

    -- Virtual text for variables
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("nvim-dap-virtual-text").setup({
                highlight_changed_variables = true,
                highlight_new_as_changed = true,
                show_stop_reason = true,
                only_first_definition = false,
                all_references = false,
                virt_text_pos = 'eol',
            })
        end,
    },

    -- Python adapter (debugpy)
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap_python = require("dap-python")

            local python_path
            if vim.loop.os_uname().version:match("Windows") then
                python_path = os.getenv("USERPROFILE") .. "\\.virtualenvs\\debugpy\\Scripts\\python.exe"
            else
                python_path = vim.fn.expand("~/.virtualenvs/debugpy/bin/python")
            end

            dap_python.setup(python_path)
            dap_python.test_runner = "pytest"

            local dap = require("dap")
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch current file",
                    program = "${file}",
                    console = "integratedTerminal",
                }
            }
        end,
    },
}
