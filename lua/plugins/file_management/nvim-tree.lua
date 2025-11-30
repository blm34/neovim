-- Open preview window (used by lp mapping)
local function open_preview()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    if not node or node.type ~= "file" then return end

    local buf = vim.fn.bufadd(node.absolute_path)
    vim.fn.bufload(buf)

    local width = math.floor(vim.o.columns * 0.7)
    local height = math.floor(vim.o.lines * 0.7)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.schedule(function()
        vim.fn.getchar()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        api.tree.focus()
    end)
end

local function on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function get_node_path()
        local node = api.tree.get_node_under_cursor()
        if not node then return nil end
        return node.absolute_path
    end

    -- navigation
    vim.keymap.set("n", "h", api.node.navigate.parent_close, { buffer = bufnr, desc = "Nav: Collapse folder" })
    vim.keymap.set("n", "H", api.tree.collapse_all, { buffer = bufnr, desc = "Nav: Collapse all" })
    vim.keymap.set("n", "L", api.tree.expand_all, { buffer = bufnr, desc = "Nav: Expand all" })
    vim.keymap.set("n", "J",
        function()
            local last_line_no = vim.fn.line(".")
            while true do
                vim.cmd("normal! j")
                local node = api.tree.get_node_under_cursor()
                local new_line_no = vim.fn.line(".")

                if not node or new_line_no == last_line_no then
                    vim.notify("No next folder", vim.log.levels.INFO)
                    break
                end

                if node.type == "directory" then
                    break
                end

                last_line_no = new_line_no
            end
        end, { buffer = bufnr, desc = "Nav: Jump to next folder" }
    )
    vim.keymap.set("n", "K",
        function()
            local last_line_no = vim.fn.line(".")
            while true do
                vim.cmd("normal! k")
                local node = api.tree.get_node_under_cursor()
                local new_line_no = vim.fn.line(".")

                if not node or new_line_no == last_line_no then
                    vim.notify("No previous folder", vim.log.levels.INFO)
                    break
                end

                if node.type == "directory" then
                    break
                end

                last_line_no = new_line_no
            end
        end, { buffer = bufnr, desc = "Nav: Jump to previous folder" }
    )
    vim.keymap.set("n", "cd",
        function()
            local node = api.tree.get_node_under_cursor()
            local dir
            if node.type == "directory" then
                dir = node
            else
                dir = node.parent
            end
            api.tree.change_root_to_node(dir)
        end, { buffer = bufnr, desc = "Nav: Change directory" }
    )
    vim.keymap.set("n", "..", api.tree.change_root_to_parent,
        { buffer = bufnr, desc = "Nav: Change directory to parent" })

    -- opening
    vim.keymap.set("n", "l",
        function()
            local node = api.tree.get_node_under_cursor()
            if node.type == "directory" then
                api.node.open.edit()
            else
                local key = vim.fn.getcharstr()
                if key == "l" then
                    api.node.open.edit()
                elseif key == "v" then
                    api.node.open.vertical()
                elseif key == "h" then
                    api.node.open.horizontal()
                elseif key == "t" then
                    api.node.open.tab()
                elseif key == "p" then
                    open_preview()
                else
                    vim.notify("Unmapped key in nvim-tree: l" .. key, vim.log.levels.INFO)
                end
            end
        end, { buffer = bufnr, desc = "Nav: open" }
    )

    -- file manipulation
    vim.keymap.set("n", "n", api.fs.create, { buffer = bufnr, desc = "Manipulation: New file/folder" })
    vim.keymap.set("n", "c", api.fs.copy.node, { buffer = bufnr, desc = "Manipulation: Copy file" })
    vim.keymap.set("n", "d", api.fs.remove, { buffer = bufnr, desc = "Manipulation: Delete file" })
    vim.keymap.set("n", "r", api.fs.rename, { buffer = bufnr, desc = "Manipulation: Rename file" })
    vim.keymap.set("n", "x", api.fs.cut, { buffer = bufnr, desc = "Manipulation: Cut file" })
    vim.keymap.set("n", "p", api.fs.paste, { buffer = bufnr, desc = "Manipulation: Paste file" })
    vim.keymap.set("n", "y", api.fs.copy.filename, { buffer = bufnr, desc = "Manipulation: Copy filename" })
    vim.keymap.set("n", "Y", api.fs.copy.absolute_path, { buffer = bufnr, desc = "Manipulation: Copy filepath" })

    -- bookmark manipulation
    vim.keymap.set("n", "mm", api.marks.toggle, { buffer = bufnr, desc = "Mark: Toggle mark" })
    vim.keymap.set("n", "mr", api.marks.clear, { buffer = bufnr, desc = "Mark: Clear all marksnvim-tree-api.marks" })
    vim.keymap.set("n", "md", api.marks.bulk.delete, { buffer = bufnr, desc = "Mark: Delete all marked files" })
    vim.keymap.set("n", "mx", api.marks.bulk.move, { buffer = bufnr, desc = "Mark: Move all marked files (cut)" })

    -- view
    vim.keymap.set("n", "tm", api.tree.toggle_no_bookmark_filter, { buffer = bufnr, desc = "Toggle: un-marked files" })
    vim.keymap.set("n", "th", api.tree.toggle_hidden_filter, { buffer = bufnr, desc = "Toggle: hidden files" })
    vim.keymap.set("n", "tgi", api.tree.toggle_gitignore_filter, { buffer = bufnr, desc = "Toggle: git ignored files" })
    vim.keymap.set("n", "tgc", api.tree.toggle_git_clean_filter, { buffer = bufnr, desc = "Toggle: git clean files" })

    -- misc
    vim.keymap.set("n", "?", api.tree.toggle_help, { buffer = bufnr, desc = "Misc: Toggle Help" })
    vim.keymap.set("n", "i", api.node.show_info_popup, { buffer = bufnr, desc = "Misc: Show info" })
    vim.keymap.set("n", "/", api.live_filter.start, { buffer = bufnr, desc = "Filter: start" })
    vim.keymap.set("n", "<ESC>", api.live_filter.clear, { buffer = bufnr, desc = "Filter: Clear filter" })
    vim.keymap.set("n", "q", api.tree.close, { buffer = bufnr, desc = "Mics: Close tree" })
end

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        local api = require("nvim-tree.api")
        require("nvim-tree").setup({
            hijack_cursor = true,
            disable_netrw = true,
            view = {
                centralize_selection = true,
                preserve_window_proportions = true,
                number = true,
                relativenumber = true,
                width = {
                    min = 30,
                    max = -1,
                    padding = 1,
                },
            },
            filters = {
                custom = { "__pycache__", },
            },
            renderer = {
                root_folder_label = function(path)
                    return "  " .. vim.fn.fnamemodify(path, ":t")
                end,
                add_trailing = true,
                group_empty = true,
                indent_markers = { enable = true, },
                icons = {
                    git_placement = "signcolumn",
                    diagnostics_placement = "signcolumn",
                    modified_placement = "before",
                    bookmarks_placement = "after",
                    glyphs = {
                        git = {
                            unstaged = "U",
                            staged = "S",
                            renamed = "➜",
                            unmerged = "",
                            untracked = "?",
                            deleted = "X",
                            ignored = "◌",
                        }
                    }
                }
            },
            git = {
                enable = true,
                show_on_open_dirs = false,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
                severity = {
                    min = vim.diagnostic.severity.WARN,
                }
            },
            modified = {
                enable = true,
                show_on_open_dirs = false,
            },
            on_attach = on_attach
        })

        vim.keymap.set("n", "<leader>ff", api.tree.open)
        vim.keymap.set("n", "<leader>ft", function()
            api.tree.toggle({ focus = false })
        end
        )
        vim.keymap.set("n", "<leader>fc", function()
            api.tree.open({ find_file = true })
        end
        )
    end
}
