local function resize_status_win(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local width = 20
    for _, line in ipairs(lines) do
        local len = vim.fn.strdisplaywidth(line)
        if len > width then
            width = len
        end
    end

    local wins = vim.fn.win_findbuf(buf)
    for _, win in ipairs(wins) do
        vim.api.nvim_win_set_width(win, width + 8)
    end
end

return {
    'tpope/vim-fugitive',
    config = function()
        local status_buf = nil
        local log_buf = nil
        local blame_bufs = {}

        -- Git status
        vim.keymap.set("n", "<leader>gs", function()
            vim.cmd("Git")
            vim.cmd("wincmd H")

            status_buf = vim.api.nvim_get_current_buf()
            resize_status_win(status_buf)
        end)

        -- Git log
        vim.keymap.set("n", "<leader>gl", function()
            -- If log is already open, close it
            if log_buf and vim.api.nvim_buf_is_valid(log_buf) then
                local wins = vim.fn.win_findbuf(log_buf)
                if #wins > 0 then
                    vim.api.nvim_win_close(wins[1], true)
                end
            end

            -- Open new log window
            vim.cmd("Git logog")
            vim.cmd("wincmd J")
            vim.cmd("horizontal resize 15")
            log_buf = vim.api.nvim_get_current_buf()
        end)

        -- Git diff
        vim.keymap.set("n", "<leader>gd", function()
            vim.cmd("Gvdiffsplit")
            local diff_buf = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = diff_buf, silent = true })
        end)

        -- Git blame
        vim.keymap.set("n", "<leader>gb", function()
            local file_buf = vim.api.nvim_buf_get_name(0)
            local file_win = vim.api.nvim_get_current_win()

            -- Close blame buffer if open
            local blame_buf = blame_bufs[file_buf]
            if blame_buf and vim.api.nvim_buf_is_valid(blame_buf) then
                local wins = vim.fn.win_findbuf(blame_buf)
                if #wins > 0 then
                    vim.api.nvim_win_close(wins[1], true)
                    blame_bufs[file_buf] = nil
                    return
                end
            end

            -- Otherwise open blame buf
            vim.cmd("Git blame")
            blame_bufs[file_buf] = vim.api.nvim_get_current_buf()

            vim.api.nvim_set_current_win(file_win)
        end)

        -- Auto cmd to resize status window
        vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
            callback = function(args)
                if status_buf and args.buf == status_buf then
                    resize_status_win(status_buf)
                end
            end,
        })

        -- Auto cmds to close git windows with q
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "fugitive", "fugitiveblame", "git" },
            callback = function()
                vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                if vim.wo.diff then
                    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
                end
            end,
        })
    end
}
