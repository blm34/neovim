return {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            '<leader>sf',
            function() require("telescope.builtin").find_files() end,
            desc = 'Telescope find files',
        },
        {
            '<leader>sg',
            function() require("telescope.builtin").git_files() end,
            desc = 'Telescope find git files',
        },
        {
            '<leader>sc',
            function() require("telescope.builtin").live_grep() end,
            desc = 'Telescope live grep',
        },
        {
            '<leader>sb',
            function() require("telescope.builtin").buffers() end,
            desc = 'Telescope buffers',
        },
        {
            '<leader>sh',
            function() require("telescope.builtin").help_tags() end,
            desc = 'Telescope help tags',
        },
    },
    config = function()
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
    end,
}
