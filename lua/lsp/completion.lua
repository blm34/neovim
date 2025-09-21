local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- Completions
        ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        ["<C-j>"] = cmp.mapping.select_next_item(),         -- Next item in menu
        ["<C-k>"] = cmp.mapping.select_prev_item(),         -- Previous item in menu
        ["<C-e>"] = cmp.mapping.abort(),                    -- Close (exit) menu

        -- Snippet jumps
        ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP completions
        { name = "luasnip" },  -- snippets
        { name = "buffer" },   -- words in current buffer
        { name = "path" },     -- file paths
    }),
})
