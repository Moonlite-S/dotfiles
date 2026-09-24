-- mini.cmdline: command-line workflow improvements (autocomplete,
-- autocorrect misspelled commands/options, and a floating preview of
-- a command's target line range as you type a range) - explicitly
-- designed to layer under noice.nvim rather than fight it: its own
-- docs describe itself as improving cmdline *workflow* without
-- touching the UI, which noice already owns here.
require('mini.cmdline').setup({})
