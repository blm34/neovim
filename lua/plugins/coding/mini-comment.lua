return {
    "nvim-mini/mini.comment",
    version = "*",
    event = "InsertEnter",
    config = function()
        require("mini.comment").setup()
    end
}
