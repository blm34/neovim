-- Set leader and local leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Move selected text with J and K in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Stay in visual mode when indenting blocks
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Recenter screen on jumps
vim.keymap.set("n", "n", function()
    vim.cmd("normal! n")
    require("mini.animate").execute_after("scroll", vim.cmd("normal! zzzv"))
end)
vim.keymap.set("n", "N", function()
    vim.cmd("normal! N")
    require("mini.animate").execute_after("scroll", vim.cmd("normal! zzzv"))
end)

-- Custom copy paste remaps
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("x", "<leader>p", "\"+p")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Global replace word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Move between windows with Alt+direction
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")

-- Resize windows with Ctrl+Alt+direction
vim.keymap.set("n", "<CM-h>", function() vim.cmd("vertical resize -1") end)
vim.keymap.set("n", "<CM-l>", function() vim.cmd("vertical resize +1") end)
vim.keymap.set("n", "<CM-j>", function() vim.cmd("resize -1") end)
vim.keymap.set("n", "<CM-k>", function() vim.cmd("resize +1") end)

-- Terminal commands
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")

-- add blank lines in normal mode
vim.keymap.set("n", "go", "o<ESC>k")
vim.keymap.set("n", "gO", "O<ESC>j")
