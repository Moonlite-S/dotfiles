-- snacks.picker: general-purpose fuzzy pickers (files/grep/recent),
-- taking over from mini.pick for this - snacks.picker has far more
-- built-in sources (LSP refs/symbols, git log/status, diagnostics,
-- etc.), though mini.pick/mini.extra stay installed regardless (they
-- still back mini.ai's custom textobjects and the <leader>v picker).
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent files' })
