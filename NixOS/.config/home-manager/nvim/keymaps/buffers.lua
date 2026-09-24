-- Buffers: H/L to cycle, no leader. Shadows Vim's built-in H (top of
-- screen) / L (bottom of screen) motions in normal mode - that's the
-- "unbind", there's nothing else currently on these keys. Uses
-- bufferline's cycle commands (not raw :bprevious/:bnext) so cycling
-- follows the visual tabline order, which can now differ from native
-- buffer-number order once buffers are pinned/reordered.
vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })

-- snacks.bufdelete: deletes a buffer without closing its window/split
-- (plain :bdelete can do that) - <leader>bd like LazyVim.
vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete buffer' })

-- New buffer, pin/unpin, and reorder - via bufferline.nvim's user
-- commands, since mini.nvim has no equivalent.
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Pin/unpin buffer' })
-- Repeats the move command `v:count1` times, so e.g. 3<leader>bh
-- moves 3 places left - bufferline only exposes relative
-- move-next/move-prev, not "move to absolute index N", so a count
-- prefix is how you reach an arbitrary position.
vim.keymap.set('n', '<leader>bh', function()
  for _ = 1, vim.v.count1 do vim.cmd('BufferLineMovePrev') end
end, { desc = 'Move buffer left' })
vim.keymap.set('n', '<leader>bl', function()
  for _ = 1, vim.v.count1 do vim.cmd('BufferLineMoveNext') end
end, { desc = 'Move buffer right' })
