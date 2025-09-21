return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        require('telescope').setup({
            defaults = {
                mappings = {
                    n = {
                        -- s to open selection in a horizontal split
                        ["s"] = function(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vim.cmd("split " .. selection.path)
                        end,
                        -- v to open selection in a vertical split
                        ["v"] = function(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vim.cmd("vsplit " .. selection.path)
                        end,
                        -- t to open in a new tab
                        ["t"] = function(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vim.cmd("tabedit " .. selection.path)
                        end,
                    },
                },
            },
        })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = 'Telescope find git files' })
        vim.keymap.set('n', '<leader>sc', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
