-- <leader>v opens mini.extra's picker over mini.visits' tracked
-- history to jump back to any of them.
vim.keymap.set('n', '<leader>v', function()
  require('mini.extra').pickers.visit_paths()
end, { desc = 'Visited files' })
