local function get_python_path()
    local uname = vim.loop.os_uname().sysname
    local is_windows = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or uname == "Windows_NT")
    local mason_path = vim.fn.stdpath("data")
    if is_windows then
        return mason_path .. "\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe"
    else
        return mason_path .. "/mason/packages/debugpy/venv/bin/python"
    end
end

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

            dap.adapters.python = {
                type = "executable",
                command = get_python_path(),
                args = { "-m", "debugpy.adapter" },
                options = {
                    detached = false,
                },
            }

            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = get_python_path,
                    console = "integratedTerminal",
                    justMyCode = false,
                }
            }

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
}
