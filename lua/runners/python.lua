local M = {}

local uv = vim.loop

local uname = vim.loop.os_uname().sysname
local is_windows = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or uname == "Windows_NT")

local function is_executable(path)
    if not path or path == "" then return false end
    local stat = uv.fs_stat(path)
    return stat ~= nil
end

local function python_in_dir(dir)
    if not dir or dir == "" then return nil end

    local venv_names = {
        ".venv",
        "venv",
        ".env",
        "env",
    }

    local path_within_venv
    if is_windows then
        path_within_venv = vim.fs.joinpath("Scripts", "python.exe")
    else
        path_within_venv = vim.fs.joinpath("bin", "python")
    end

    for _, venv_name in ipairs(venv_names) do
        local path = vim.fs.joinpath(dir, venv_name, path_within_venv)
        if is_executable(path) then return path end
    end
end

local function find_venv_upwards(start_dir)
    local cur = vim.fn.fnamemodify(start_dir, ":p")
    local prev = ""
    while cur ~= prev do
        local py = python_in_dir(cur)
        if py then return py end
        prev = cur
        cur = vim.fn.fnamemodify(cur, ":h")
    end
end

local function get_python_executable()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv and venv ~= "" then
        local path
        if is_windows then
            path = vim.fs.joinpath(venv, "Scripts", "python.exe")
        else
            path = vim.fs.joinpath(venv, "bin", "python")
        end
        if is_executable(path) then return path end
    end

    local buf = vim.api.nvim_buf_get_name(0)
    local dir
    if buf ~= "" then
        dir = vim.fn.fnamemodify(buf, ":h")
    else
        dir = uv.cwd()
    end
    local found = find_venv_upwards(dir)
    if found then return found end

    if not is_windows and vim.fn.executable("python3") == 1 then return "python3" end
    if vim.fn.executable("python") == 1 then return "python" end
end

local function quote_arg(arg)
    if arg:find("%s") then
        if is_windows then
            return '"' .. arg .. '"'
        else
            return "'" .. arg:gsub("'", "'\\''") .. "'"
        end
    end
    return arg
end

local Terminal = require("toggleterm.terminal").Terminal
local py_term = nil
local function run_in_toggleterm(cmd)
    if not py_term then
        py_term = Terminal:new({
            id = 98,
            display_name = "Python",
            direction = "horizontal",
            close_on_exit = false,
            hidden = false,
        })
    end

    if not py_term:is_open() then
        py_term:open()
    end

    py_term:send("clear && " .. cmd, true)
end


-- ====== Public API ====== --

function M.run_current_file()
    local file = vim.fn.expand("%:p")
    if vim.fn.filereadable(file) == 0 then
        vim.notify("No readable file", vim.log.levels.WARN)
        return
    end
    local py = get_python_executable()
    if not py then
        vim.notify("No Python interpreter found", vim.log.levels.ERROR)
        return
    end
    local cmd = string.format("%s %s", quote_arg(py), quote_arg(file))
    run_in_toggleterm(cmd)
end

function M.run_file_from_register(reg)
    local path = vim.fn.getreg(reg):gsub("%s+$", "")

    if path == "" then
        vim.notify("Register @" .. reg .. " empty", vim.log.levels.WARN)
        return
    end

    if vim.fn.filereadable(path) == 0 then
        vim.notify("File not found: " .. path, vim.log.levels.ERROR)
        return
    end

    local py = get_python_executable()
    if not py then
        vim.notify("No Python interpreter found", vim.log.levels.ERROR)
        return
    end
    local cmd = string.format("%s %s", quote_arg(py), quote_arg(path))
    run_in_toggleterm(cmd)
end

function M.pick_register_and_run()
    local regs = {}
    for i = string.byte("a"), string.byte("z") do
        local reg = string.char(i)
        local contents = vim.fn.getreg(reg)
        if contents and contents ~= "" then
            local file = contents:gsub("\n", ""):gsub("%s+$", "")
            if file:match("%.py$") and vim.fn.filereadable(file) == 1 then
                table.insert(regs, {
                    reg = reg,
                    file = file,
                    label = string.format("@%s: %s", reg, file),
                })
            end
        end
    end

    if #regs == 0 then
        vim.notify("No registers contain python file paths", vim.log.levels.WARN)
        return
    end

    table.sort(regs, function(a, b) return a.reg < b.reg end)

    vim.ui.select(
        regs,
        {
            prompt = "Select register to run:",
            format_item = function(item) return item.label end,
        },
        function(choice)
            if choice then
                M.run_file_from_register(choice.reg)
            end
        end
    )
end

function M.save_current_file_to_register()
    local file = vim.fn.expand("%:p")
    if file == "" or vim.fn.filereadable(file) == 0 then
        vim.notify("No valid file to save", vim.log.levels.WARN)
        return
    end

    local reg = vim.fn.input("Save to register (a-z): ")
    if not reg or reg == "" then return end

    vim.fn.setreg(reg, file)
    vim.notify("Saved " .. file .. " into @" .. reg)
end

return M
