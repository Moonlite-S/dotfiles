vim.keymap.set('n', '<leader>e', function()
  require('yazi').yazi()
end, { desc = 'Open file explorer' })
