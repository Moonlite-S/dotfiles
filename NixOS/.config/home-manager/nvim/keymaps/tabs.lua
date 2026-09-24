-- Tabs: native Vim tabpages, each an independent window layout with
-- its own buffers - separate from bufferline's buffer bar
-- (plugins/bufferline.lua, which also draws a small clickable
-- indicator per open tab for free via its show_tab_indicators
-- default). Plain :tab* commands, not bufferline commands, since
-- bufferline stays in its default "buffers" mode - this is LazyVim's
-- own scheme (lua/lazyvim/config/keymaps.lua), same <leader><tab>
-- prefix and desc text, except New Tab below (LazyVim uses plain
-- :tabnew).
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close other tabs' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First tab' })
-- :tabnew always creates a fresh empty unnamed buffer for the tab's
-- window to show, since a window can't exist without some buffer -
-- that scratch buffer then lingers in the global buffer list (:ls,
-- mini.pick's buffer picker) even after the tab's closed. :tab split
-- instead opens the new tab onto the *current* buffer - no new buffer
-- is created at all.
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tab split<cr>', { desc = 'New tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
