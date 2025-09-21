return {
    "nvim-mini/mini.diff",
    version = "*",
    config = function()
        require("mini.diff").setup({
            view = {
                style = "sign",
                signs = {
                    add = '┃',
                    change = '┃',
                    delete = '▁',
                },
            },
            mappings = {
                apply = "gha",
                reset = "ghr",
            },
        })
    end,
}
