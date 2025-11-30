return {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup()

        vim.keymap.set("n", "<leader>M", vim.cmd.Mason, { desc = "Open Mason", silent = true })
    end,
}
