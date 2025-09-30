local handlers = require("lsp.handlers")

local uname = vim.loop.os_uname().sysname
local is_windows = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or uname == "Windows_NT")

local function get_python_path(root_dir)
    -- 1. If venv is activated, use it
    if vim.env.VIRTUAL_ENV then
        local venv = vim.env.VIRTUAL_ENV
        if is_windows then
            return vim.fs.joinpath(venv, "Scripts", "python.exe")
        else
            return vim.fs.joinpath(venv, "bin", "python")
        end
    end

    -- 2. Look for venv in the project
    local paths = { ".venv", "venv" }
    for _, venv_name in ipairs(paths) do
        local venv_path = vim.fs.joinpath(root_dir, venv_name)
        if vim.fn.isdirectory(venv_path) == 1 then
            if is_windows then
                return vim.fs.joinpath(venv_path, "Scripts", "python.exe")
            else
                return vim.fs.joinpath(venv_path, "bin", "python")
            end
        end
    end

    -- 3. Fallback to system python
    return "python"
end

return {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        ".git",
        "venv",
        ".venv"
    },
    before_init = function(_, config)
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = get_python_path(config.root_dir)
    end
}
