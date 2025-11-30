-- Function to automatically adjust width of window
local function resize_undotree(buf)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft ~= "undotree" then return end

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local max_width = 20
    for _, line in ipairs(lines) do
        local len = vim.fn.strdisplaywidth(line)
        if len > max_width then
            max_width = len
        end
    end

    local wins = vim.fn.win_findbuf(buf)
    for _, win in ipairs(wins) do
        vim.api.nvim_win_set_width(win, max_width)
    end
end

return {
    'mbbill/undotree',
    lazy = true,
    keys = {
        {
            "<leader>ut",
            function() vim.cmd.UndotreeToggle() end,
            desc = "Open undotree",
        },
    },

    init = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_DiffpanelHeight = 15
        vim.g.undotree_DiffAutoOpen = 0
    end,

    config = function()
        vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
            callback = function(args)
                resize_undotree(args.buf)
            end,
        })
    end
}
