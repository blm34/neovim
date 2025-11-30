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
* [LazyGit](https://github.com/jesseduffield/lazygit)

### Python ###

To debug python code, a virtual environment must exist at `~/.virtualenvs/debugpy`
which has debugpy installed into it.

## Keymaps ##

`<leader>` is mapped to `<space>`

`<localleader>` is mapped to `\`

### Config ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>L` | Open Lazy plugin manager | Lazy |
| n | `<leader>M` | Open Mason manager | Mason |

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
| n | `<leader>ut` | Toggle the undotree window | Undo tree |
| n | `cs"'` | Change the surrounding quotes to single quotes | Change surrounding |
| n | `ds'` | Delete the surrounding quotes | Delete surrounding |
| n | `ysiw)` | Surround the current word with () | You surround|
| n | `yss}` | Surround the entire line with {} | You surround |
| v | `Sb` | Surround the selection with the brackets | Surround |
| n | `gc` | Comment the following noun | Give comment |
| n | `gcc` | Comment the current line | Give current comment |
| n | `dgc` | Delete the comment block | |

### Visual ###

| Mode | Keymap | Action |
|------|--------|--------|
| n | `<ESC>` | Turn off highlight search |
| n | `zc` | Close fold under cursor |
| n | `zC` | Close all folds under cursor |
| n | `zo` | Open fold under cursor |
| n | `zO` | Open all folds under cursor |
| n | `zR` | Open all folds |
| n | `zM` | Close all folds |
| n | `zK` | Peak folded lines under cursor |

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
| n | `<leader>1` | Open terminal 1 (valid for 1-9) |
| n | `<Tab>` | Toggle all terminals |

### LSP ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `gd` | Go to definition | Go definition |
| n | `<leader>rn` | Rename variable | Re name |
| n | `<leader>ca` | Code action | Code action | 
| n | `[d` | Go to previous diagnostic |
| n | `]d` | Go to next diagnostic |
| n | `<leader>D` | Toggle diagnostics |
| n | `<leader>v` | Open vista window for code structure |

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
| n | `<leader>ff` | Focus the nvim-tree window, opening if required | Files focus |
| n | `<leader>ft` | Toggle the nvim-tree window | Files toggle |
| n | `<leader>fc` | Focus the tree and move the cursor to the current file | Files current |
| n | `<leader>ha` | Add the current file to the harpoon list | Harpoon add |
| n | `<leader>hr` | Remove the current file from the harpoon list | Harpoon remove |
| n | `<leader>hh` | Open the harpoon list | |
| n | `<leader>ht` | Open the harpoon window in telescope | Harpoon telescope |
| n | `<leader>h1` | Open the nth file in the harpoon list (valid from 1 to 9) | |

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
| n | `?` | Open help menu to show keybinds | |
| n | `i` | Show file info | Info |
| n | `/` | Filter files based off input text | Search |
| n | `<ESC>` | Clear filter | |
| n | `q` | Close nvim-tree window | Quit |

### Git ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>gg` | Open LazyGit | |
| n | `<leader>gs` | Open fugitive status window | Git status |
| n | `<leader>gl` | Open fugitive log window | Git log |
| n | `<leader>gd` | Open fugitive diff window | Git diff |
| n | `<leader>gb` | Open fugitive blame window | Git blame |
| n | `gha` | Stage hunks in the following motion | Git hunk add |
| n | `ghr` | Restore hunks in the following motion | Git hunk restore |

#### Fugitive ####

The following keymaps apply when in a fugitive window

| Mode | Keymap | Action |
|------|--------|--------|
| n | `q` | Close the window |
| n | `g?` | Open help menu |

### Python ###

The following are keymaps set to only work within a python file.

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>RR` | Run the current python file | Run |
| n | `<leader>RF` | Run the python file whose file path is in a chosen register | Run file |
| n | `<leader>RS` | Save the file path of the current file to a chosen register | Run save |

### Debugging ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>dc` | Continue the debugger or start a new debug session | Debug Continue |
| n | `<leader>db` | Toggle a breakpoint | Debug Breakpoint |
| n | `<leader>dB` | Set a conditional breakpoint | Debug Breakpoint |
| n | `<leader>dL` | Set a log point | Debug Logpoint |
| n | `<leader>dq` | Terminate a debug session | Debug Quit |
| n | `<leader>dk` | Open the debug hover menu | |
| n | `<leader>dr` | Open the debug repl | Debug Repl |
| n | `<leader>dl` | Run the last debug session | Debug Last |
| n | `<leader>do` | Step over a line in a debug session | Debug Over |
| n | `<leader>di` | Step into a scope in a debug session | Debug Into |
| n | `<leader>dO` | Step out of a scope in a debug session | Debug Out |
| n | `<leader>dt` | Run the closest test in debug mode | Debug Test |

### Tests ###

| Mode | Keymap | Action | Mnemonic |
|------|--------|--------|----------|
| n | `<leader>tt` | Run the closest test | Test Test |
| n | `<leader>tf` | Run the all tests in file | Test File |
| n | `<leader>ta` | Run the all tests in suite | Test All |
| n | `<leader>tq` | Stop the current test run | Test Quit |
| n | `<leader>ts` | Open the test summary panel | Test Summary |
| n | `<leader>to` | Open the closest test's output | Test Output |
| n | `<leader>tO` | Toggle the output pannel | Test Output |
| n | `<leader>tf` | Jump to the next failing test | Test Failed |

