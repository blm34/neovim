vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { silent = true, noremap = true })

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 100

vim.opt.colorcolumn = "80"

-- Update buffers if changed and not modified
vim.opt.autoread = true
vim.api.nvim_create_autocmd(
    { "FocusGained", "BufEnter" },
    { command = "checktime" }
)

-- Set up undo file
vim.opt.undofile = true
vim.opt.undodir = { vim.fn.stdpath("data") .. "/undo" }

if vim.fn.isdirectory(vim.opt.undodir:get()[1]) == 0 then
    vim.fn.mkdir(vim.opt.undodir:get()[1], "p")
end
