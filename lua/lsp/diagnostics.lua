-- Flag to track display of diagnostics
local diagnostics_enabled = true
local virtual_text_namespace = vim.api.nvim_create_namespace("virtual_text")
local virtual_lines_namespace = vim.api.nvim_create_namespace("virtual_lines")

-- Redraw diagnostics with virtual text on all but the current line,
-- and virtual lines on only the current line
local function update_diagnostics()
    if not diagnostics_enabled then return end

    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].buflisted then return end

    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    local all_diagnostics = vim.diagnostic.get(bufnr)

    local virtual_text_diagnostics = {}
    for _, d in ipairs(all_diagnostics) do
        if d.lnum ~= cursor_line then
            table.insert(virtual_text_diagnostics, d)
        end
    end

    local icons = {
        ERROR = "",
        WARN  = "",
        INFO  = "",
        HINT  = "",
    }

    vim.diagnostic.show(virtual_text_namespace, bufnr, virtual_text_diagnostics, {
        virtual_text = {
            prefix = function(diagnostic)
                local sev = diagnostic.severity
                if sev == vim.diagnostic.severity.ERROR then
                    return icons.ERROR .. " "
                elseif sev == vim.diagnostic.severity.WARN then
                    return icons.WARN .. " "
                elseif sev == vim.diagnostic.severity.INFO then
                    return icons.INFO .. " "
                elseif sev == vim.diagnostic.severity.HINT then
                    return icons.HINT .. " "
                end
                return "● "
            end,
            spacing = 2,
            severity = { min = vim.diagnostic.severity.HINT },
            source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    vim.diagnostic.show(virtual_lines_namespace, bufnr, vim.diagnostic.get(bufnr, { lnum = cursor_line }), {
        virtual_lines = { only_current_line = true },
    })
end

-- Autocommand to refresh on movement
vim.api.nvim_create_autocmd({ "CursorMoved", "InsertLeave", "BufEnter", "DiagnosticChanged" }, {
    callback = update_diagnostics,
})

local function hide_diagnostics()
    if diagnostics_enabled then return end

    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    if not vim.bo[bufnr].buflisted then return end

    vim.diagnostic.hide(virtual_text_namespace)
    vim.diagnostic.hide(virtual_lines_namespace)
    vim.diagnostic.show(nil, bufnr, nil, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

local function toggle_diagnostics()
    diagnostics_enabled = not diagnostics_enabled

    if diagnostics_enabled then
        update_diagnostics()
    else
        hide_diagnostics()
    end
end

vim.keymap.set("n", "<leader>D", toggle_diagnostics)
