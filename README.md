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

### Config ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>L` | Open Lazy pluging manager | Lazy |

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

### LSP ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `gd` | Go to definition | Go definition |
| n | `<leader>rn` | Rename variable | Re name |
| n | `<leader>ca` | Code action | Code action | 
| n | `[d` | Go to previous diagnostic |
| n | `]d` | Go to next diagnostic |
| n | `<leader>D` | Toggle diagnostics |

#### Completions ####

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| i | `<C-j>` | Select next in drop down | Down |
| i | `<C-k>` | Select previous in drop down | Up |
| i | `<C-y>` | Confirm selection (only required for snippets) | Yes |
| i | `<C-e>` | Abort completion and close menu | Exit |
| i | `<C-l>` | Jump to next input of snippet | Left |
| i | `<C-h>` | Jump to previous input of snippet | Right |

#### Hover ####

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `K` | Open hover | |
| n | `gK` | Enter hover | |
| n | `<C-p>` | Previous hover | Previous |
| n | `<C-n>` | Next hover | Next |

### Files ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>sf` | Search file names with telescope | Search files |
| n | `<leader>sc` | Search file contents with telescope | Search contents |
| n | `<leader>sg` | Search git files with telescope | Search git |
| n | `<leader>sb` | Search buffers with telescope | Search buffers |
| n | `<leader>sh` | Search help tags with telescope | Search help |
| n | `<leader>tf` | Focus the nvim-tree window, opening if required | Tree focus |
| n | `<leader>tt` | Toggle the nvim-tree window | Tree toggle |
| n | `<leader>to` | Focus the tree and move the cursor to the current file | Tree open |

#### Telescope ####

In a telescope search window the following maps apply

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n & i | `<CR>` | Open in current buffer | |
| n | `s` | Open in horizontal split | Split |
| n | `v` | Open in vertical split | Vertical |
| n | `t` | Open in new tab | Tab |

#### Nvim Tree ####

In the nvim-tree window, the following maps apply


| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `h` | Collapse directory | Left |
| n | `H` | Collapse all directories | Big left |
| n | `L` | Expand all directories | Big right |
| n | `J` | Jump down to next directory | Big right |
| n | `K` | Jump up to next directory | Big right |
| n | `cd` | Make directory under cursor the root directory | Change directory |
| n | `..` | Make parent of the root directory the new root | `cd ..` |
| n | `l` | When on a directory, expand it | Right |
| n | `ll` | When on a file, open in existing window | |
| n | `lv` | When on a file, open in vertical split | Vertical |
| n | `lh` | When on a file, open in horizontal split | Horizontal |
| n | `lt` | When on a file, open in new tab | Tab |
| n | `lp` | When on a file, open in a preview window | Preview |
| n | `n` | Create new file or directory | New |
| n | `c` | Copy file | Copy |
| n | `d` | Delete file | Delete |
| n | `r` | Rename file/directory | Rename |
| n | `x` | Cut file/folder | Ctrl+x |
| n | `p` | Paste | Paste |
| n | `y` | Copy filename| Yank |
| n | `Y` | Copy absolute filepath | Big yank |
| n | `mm` | Toggle mark on node | Mark |
| n | `mr` | Remove all marks | Mark remove |
| n | `md` | Delete marked files | Mark delete |
| n | `mx` | Cut marked files | Mark Ctrl+x |
| n | `tm` | Toggle show marked files only | Toggle marked |
| n | `th` | Toggle show hidden files | Toggle hidden |
| n | `tgi` | Toggle show git ignored files | Toggle git ignore |
| n | `tgc` | Toggle show clean git files | Toggle git clean |
| n | `gs` | Stage file under cursor | Git stage |
| n | `gu` | Unstage file under cursor | Git unstage |
| n | `g-` | Toggle staging of file under cursor | |
| n | `gc` | Make a commit | Git commit |
| n | `gb` | Open git blame in a new tab | Git blame |
| n | `?` | Open help menu to show keybinds | |
| n | `i` | Show file info | Info |
| n | `/` | Filter files based off input text | Search |
| n | `<ESC>` | Clear filter | |
| n | `q` | Close nvim-tree window | Quit |
