return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        require("treesitter-context").setup({
            multiwindow = true,
        })
    end
}
