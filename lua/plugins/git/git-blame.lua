return {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
    keys = {
        {
            "<leader>gb",
            "<cmd>GitBlameToggle<CR>",
            desc = "Toggle Git blame",
        },
    },
    opts = {
        enabled = false, -- install triggered by toggle so install with it off, and then toggle it on
        message_template = "<author> • <summary> • <date> • <<sha>>",
        date_format = "%Y-%m-%d %H:%M:%S",
        gitblame_delay = 0,
    }
}
