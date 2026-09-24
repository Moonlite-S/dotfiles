-- Nvim's own errors/warnings (plugin errors, deprecation notices,
-- vim.notify calls, etc.) - not LSP diagnostics on buffer contents,
-- which trouble.lua's <leader>xx/<leader>xX already cover. All
-- vim.notify traffic already routes through Snacks.notifier
-- (plugins/snacks.lua's `notifier = {}`, auto-detected by noice - see
-- its own comment), which keeps a history and can show just the
-- warn-and-above entries from it (confirmed in source:
-- notifier.lua's show_history/get_history take a `filter` that's a
-- minimum vim.log.levels name, "warn" here includes error too).
vim.keymap.set('n', '<leader>n', function()
  Snacks.notifier.show_history({ filter = 'warn' })
end, { desc = 'Show nvim errors/warnings' })
