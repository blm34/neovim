vim.cmd("setlocal textwidth=80")

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"
vim.opt_local.foldtext = "vimtex#fold#text()"
vim.opt_local.foldlevel = 1
