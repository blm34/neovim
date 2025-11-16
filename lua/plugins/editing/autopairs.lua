return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        -- Load default configuration
        npairs.setup({
            check_ts = true, -- optional but recommended if using treesitter
        })

        -- Add rules for triple quotes in Python
        npairs.add_rules({
            -- """ triple double-quotes
            Rule('"""', '"""', "python")
                :with_pair(cond.none()) -- don't treat as nested chars
                :with_move(cond.none())
                :with_del(cond.none())
                :with_cr(cond.none()),

            -- ''' triple single-quotes
            Rule("'''", "'''", "python")
                :with_pair(cond.none())
                :with_move(cond.none())
                :with_del(cond.none())
                :with_cr(cond.none()),
        })
    end,
}
