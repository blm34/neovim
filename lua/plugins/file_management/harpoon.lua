local conf = require('telescope.config').values
local themes = require('telescope.themes')

-- helper function to use telescope on harpoon list.
local function toggle_telescope(harpoon_list)
    local file_paths = {}
    for _, item in ipairs(harpoon_list.items) do
        table.insert(file_paths, item.value)
    end

    local opts = themes.get_ivy({
        prompt_title = "Working List"
    })

    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end)

        vim.keymap.set("n", "<leader>hr", function()
            local list = harpoon:list()
            local buf_path = vim.fn.expand("%:p")
            for idx, item in ipairs(list.items) do
                if item.value == buf_path then
                    list:remove_at(idx)
                    break
                end
            end
        end)

        vim.keymap.set("n", "<leader>hh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<leader>ht", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window in telescope" })

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>h" .. i, function()
                harpoon:list():select(i)
            end)
        end
    end
}

