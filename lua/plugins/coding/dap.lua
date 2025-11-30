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
        keys = {
            {
                "<leader>dc",
                function() require("dap").continue() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>db",
                function() require("dap").toggle_breakpoint() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dL",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: ")) end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dq",
                function() require("dap").terminate() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dk",
                function() require("dap.ui.widgets").hover() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dr",
                function() require("dap").repl_open() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dl",
                function() require("dap").run_last() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>do",
                function() require("dap").step_over() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>di",
                function() require("dap").step_into() end,
                noremap = true,
                silent = true,
            },
            {
                "<leader>dO",
                function() require("dap").step_out() end,
                noremap = true,
                silent = true,
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

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
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
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
        lazy = true,
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
