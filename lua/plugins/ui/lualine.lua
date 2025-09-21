-- Show git branch and worktree

local branch_cache = {}

local function branch_and_worktree()
    local bufnr = vim.api.nvim_get_current_buf()

    if branch_cache[bufnr] then
        return branch_cache[bufnr]
    end

    local filename = vim.api.nvim_buf_get_name(bufnr)
    local dir
    if filename ~= "" then
        dir = vim.fn.fnamemodify(filename, ":h")
    else
        dir = vim.fn.getcwd()
    end

    -- Branch name
    local handle = io.popen('git -C "' .. dir .. '" rev-parse --abbrev-ref HEAD 2>&1')
    if not handle then
        branch_cache[bufnr] = ""
        return ""
    end
    local branch = handle:read("*l") or ""
    handle:close()

    branch = branch:gsub("%s+", "")

    -- Exit if not in a git repo
    if branch == "" or branch == "HEAD" or branch:match("^fatal") then
        branch_cache[bufnr] = ""
        return ""
    end

    -- Get git directory
    local git_dir_handle = io.popen('git -C "' .. dir .. '" rev-parse --git-dir 2>&1')
    local git_dir = git_dir_handle and git_dir_handle:read("*l") or ""
    if git_dir_handle then git_dir_handle:close() end

    git_dir = git_dir:gsub("%s+", "")

    -- Detect worktree name
    local wt = ""
    if git_dir ~= "" then
        local match = git_dir:match("[/\\]worktrees[/\\](.+)$")
        if match then
            wt = match
        end
    end

    local result = " " .. branch
    if wt ~= "" then
        result = result  .. " ( " .. wt .. ")"
    end
    branch_cache[bufnr] = result
    return result
end

-- Clear cache on buffer enter / write / git events
vim.api.nvim_create_autocmd({"BufEnter","BufWritePost"}, {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        branch_cache[bufnr] = nil
    end
})

-- Show current active LSP
local function lsp_client()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if next(clients) == nil then
        return ""
    end

    local names = {}
    for _, client in pairs(clients) do
        table.insert(names, client.name)
    end
    return " " .. table.concat(names, ",") -- gear icon
end

-- Show current harpoon index and count
local function harpoon_statusline()
    local harpoon = require("harpoon")
    local list = harpoon:list()

    if not list or not list.items then
        return ""
    end

    local total = #list.items
    if total == 0 then
        return ""
    end

    local buf_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
    local idx = nil

    for i, item in ipairs(list.items) do
        if vim.fn.fnamemodify(item.value, ":p") == buf_path then
        idx = i
        break
        end
    end

    if idx then
        return string.format("󱡅 %d/%d", idx, total)
    else
        return string.format("󱡅 %d", total)
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require("lualine").setup({
            options = {
                theme = "kanagawa",
                section_separators = { left = "", right = "" },
                component_separators = { left = "·", right = "·" },
                icons_enabled = true,
                globalstatus = false,
            },
            sections = {
                lualine_a = {
                    "mode"
                },
                lualine_b = {
                    branch_and_worktree,
                    "diff"
                },
                lualine_c = {
                    "filename",
                    harpoon_statusline
                },
                lualine_x = {
                    {"diagnostics", sources = { 'nvim_lsp' } },
                    lsp_client,
                },
                lualine_y = {
                    "progress"
                },
                lualine_z = {
                    "location"
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "fugitive", "quickfix", "nvim-tree" }
        })
    end
}
