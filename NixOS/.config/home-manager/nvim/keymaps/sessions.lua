-- <leader>Ss saves the current layout under the cwd's basename, so
-- one project directory maps to one session by default.
vim.keymap.set('n', '<leader>Ss', function()
  require('mini.sessions').write(vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
end, { desc = 'Save session' })
-- <leader>Sl opens mini.sessions' own picker to read/write/delete
-- any detected session by name.
vim.keymap.set('n', '<leader>Sl', function()
  require('mini.sessions').select()
end, { desc = 'Load/manage session' })
