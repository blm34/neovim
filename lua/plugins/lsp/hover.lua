return {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").config({
            providers = {
                'hover.providers.lsp',
                'hover.providers.dap',
                'hover.providers.man',
                'hover.providers.dictionary',
            },
        })

        vim.keymap.set('n', 'K', function()
            require('hover').open()
        end, { desc = 'hover.nvim (open)' })

        vim.keymap.set('n', 'gK', function()
            require('hover').enter()
        end, { desc = 'hover.nvim (enter)' })

        vim.keymap.set('n', '<C-p>', function()
            require('hover').hover_switch('previous')
        end, { desc = 'hover.nvim (previous source)' })

        vim.keymap.set('n', '<C-n>', function()
            require('hover').hover_switch('next')
        end, { desc = 'hover.nvim (next source)' })
    end
}
