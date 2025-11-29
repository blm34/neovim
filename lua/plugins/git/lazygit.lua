-- Don't remap escape in terminal window if it is lazygit
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*lazygit*",
    callback = function(ev)
        vim.keymap.set("t", "<Esc>", "<Esc>", {
            buffer = ev.buf,
            noremap = true,
            silent = true,
        })
    end,
})

return {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LAzyGitFilterCurrentFile",
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    keys = {
        { "<leader>gg", "<CMD>LazyGit<CR>", desc = "Open LazyGit" }
    },
}
