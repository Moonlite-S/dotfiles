vim.keymap.set('n', '<leader>m', function()
  require('mini.map').toggle()
end, { desc = 'Toggle minimap' })
