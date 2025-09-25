return {
    "nvim-mini/mini.jump",
    version = "*",
    config = function()
        require("mini.jump").setup({
            delay = {
                highlight = 200,
                idle_stop = 3000,
            }
        })
    end
}
