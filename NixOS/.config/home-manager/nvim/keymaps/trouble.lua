-- trouble.nvim's own recommended default keymaps (its README's
-- lazy.nvim install snippet), just as plain vim.keymap.set calls here
-- instead of a lazy.nvim `keys` spec. symbols/lsp overridden to a
-- short bottom split - symbols' own mode default and lsp's README
-- default both hardcode win.position=right (a tall vertical pane);
-- win.size=12 pins the height explicitly rather than relying on
-- trouble's own position-based fallback (10 for top/bottom, in
-- window.lua), in case that default ever changes.
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false win.position=bottom win.size=12<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=bottom win.size=12<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })
