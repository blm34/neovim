return {
    "nvim-mini/mini.ai",
    version = "*",
    event = { "InsertEnter" },
    config = function()
        require("mini.ai").setup()
    end
}
