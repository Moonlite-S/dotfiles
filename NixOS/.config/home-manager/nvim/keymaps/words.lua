-- snacks.words: jump between LSP references of the symbol under the
-- cursor. Only lights up with an attached LSP.
vim.keymap.set('n', ']]', function() Snacks.words.jump(1, true) end, { desc = 'Next reference' })
vim.keymap.set('n', '[[', function() Snacks.words.jump(-1, true) end, { desc = 'Previous reference' })
