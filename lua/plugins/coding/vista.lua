return {
    "liuchengxu/vista.vim",
    lazy = true,
    keys = {
        {
            "<leader>v",
            function() vim.cmd("Vista!!") end,
            desc = "Open Vista",
        }
    },
    config = function()
        vim.g.vista_default_executive = "nvim_lsp"
    end,
}
