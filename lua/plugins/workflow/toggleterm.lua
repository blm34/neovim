local uname = vim.loop.os_uname().sysname
local is_windows = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or uname == "Windows_NT")

if is_windows then
    local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = nil,
            insert_mappings = false,
            terminal_mappings = true,
            size = 20,
            hide_numbers = true,
            direction = "horizontal",
        })

        vim.keymap.set("n", "<Tab>", function()
            vim.cmd("ToggleTermToggleAll")
        end, { noremap = true, silent = true })

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, function()
                vim.cmd("ToggleTerm " .. i)
            end, { noremap = true, silent = true })
        end
    end,
}
