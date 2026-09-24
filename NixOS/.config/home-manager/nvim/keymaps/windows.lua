-- Windows/panes: native nvim splitting (<C-w>s/<C-w>v/<C-w>q/etc. all
-- still work as-is) plus LazyVim-style shortcuts to create them.
-- Moving between splits is already handled by the tmux-navigator
-- plugin (<C-h/j/k/l>, seamless across tmux panes and nvim splits too).
vim.keymap.set('n', '<leader>-', '<C-w>s', { desc = 'Split window below' })
vim.keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split window right' })

-- <leader>w group: manipulating existing panes (closing, resizing,
-- swapping) - all thin wrappers over native <C-w> commands, which
-- mini.clue already surfaces standalone via gen_clues.windows()
-- (plugins/mini-clue.lua). This group just gives them a leader-based
-- entry point with mnemonic letters instead of memorizing <C-w> symbols.
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Delete other windows' })
vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = 'Swap window with next' })
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate windows' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })
vim.keymap.set('n', '<leader>wh', '<C-w>3<', { desc = 'Decrease window width' })
vim.keymap.set('n', '<leader>wl', '<C-w>3>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>wj', '<C-w>3-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<leader>wk', '<C-w>3+', { desc = 'Increase window height' })
