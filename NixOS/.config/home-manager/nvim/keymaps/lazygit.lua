-- snacks.lazygit replaced the old ~25-line hand-written floating
-- terminal function - Snacks.lazygit() does the same (lazygit is
-- already installed system-wide, configuration.nix) plus
-- auto-generates a lazygit theme matching the current colorscheme.
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Open lazygit' })
