-- Disable netrw in favour of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load configs
require("config.remap")
require("config.options")
require("config.lazy")
require("lsp")
