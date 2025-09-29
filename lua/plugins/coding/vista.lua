return {
    "liuchengxu/vista.vim",
    config = function()
        vim.g.vista_default_executive = "nvim_lsp"
        vim.keymap.set("n", "<leader>v", function()
            vim.cmd("Vista!!")
        end)
    end,
}
