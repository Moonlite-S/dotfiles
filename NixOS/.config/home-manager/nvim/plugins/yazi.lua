-- yazi.nvim: file explorer, replaced snacks.explorer - opens the
-- actual yazi TUI (already installed system-wide, configuration.nix)
-- in a floating window instead of a picker-based tree. Depends on
-- plenary.nvim (added to the plugin list, its only hard dependency
-- per its own lazy.lua). open_for_directories replaces netrw for
-- directory buffers (`:e some-dir`), which is why netrw needs to be
-- marked loaded/disabled first - both per the README's documented
-- setup. grep_in_directory/picker_add_copy_relative_path_action
-- default to "telescope" (confirmed in yazi/config.lua) which isn't
-- installed here - pointed at "snacks.picker" instead, since that's
-- enabled. Keymap in keymaps/explorer.lua.
vim.g.loaded_netrwPlugin = 1
require('yazi').setup({
  open_for_directories = true,
  integrations = {
    grep_in_directory = 'snacks.picker',
    picker_add_copy_relative_path_action = 'snacks.picker',
  },
})
