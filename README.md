# Neovim Config #

To use this Neovim configuration, this repository should be cloned to:

| OS          | Path                 |
|-------------|----------------------|
| **Windows** | ~/Appdata/Local/nvim |
| **Linux**   | ~/.config/nvim       |

## Prerequisites ##

* [Neovim](https://neovim.io)
* [git](https://git-scm.com/downloads)
* [Ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

## Keymaps ##

`<leader>` is mapped to `<space>`

`<localleader>` is mapped to `\`

### Editing ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| v | `J` | Move selection down | |
| v | `K` | Move selection up | |
| n & x | `<leader>p` | Paste from system clipboard | Paste |
| n & v | `<leader>y` | Copy to system clipboard | Yank |
| n & v | `<leader>d` | Delete - don't write to the unnamed register | Delete |
| n | `<leader>s` | Global (in buffer) replace word under cursor | Substitute |
| n | `go` | Add blank line below cursor |
| n | `gO` | Add blank line above cursor |

### Visual ###

| Mode | Keymap | Action |
|------|--------|--------|
| n | `<ESC>` | Turn off highlight search |

### Quick Fix List ###

| Mode | Keymap | Action |
|------|--------|--------|
| n | `<C-j>` | Go to next item in the qfl |
| n | `<C-k>` | Go to previous item in the qfl |
| n | `<leader>j` | Got to the next item in the location list |
| n | `<leader>k` | Got to the previous item in the location list |

### Window Management ###

| Mode | Keymap | Action |
|------|--------|--------|
| n & t | `<M-h>` | Move to window to the left |
| n & t | `<M-l>` | Move to window to the right |
| n & t | `<M-j>` | Move down one window |
| n & t | `<M-k>` | Move up one window |
| n | `<CM-h>` | Decrease window width |
| n | `<CM-l>` | Increase window width |
| n | `<CM-j>` | Decrease window height |
| n | `<CM-k>` | Increase window height |
| t | `<ESC>` | Exit terminal mode (to normal mode) |

