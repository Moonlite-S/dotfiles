-- snacks.gitbrowse: open the current file/line on GitHub (or
-- whatever the remote host is) - new capability, not a replacement
-- for mini.git, which stays for inline blame/signs.
vim.keymap.set('n', '<leader>go', function() Snacks.gitbrowse() end, { desc = 'Open in browser' })
