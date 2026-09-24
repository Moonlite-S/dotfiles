-- mini.visits: tracks which paths (files and directories) get
-- visited, per project root, ranked by frecency (frequency + how
-- recently). Registration is automatic (autocmd-driven), nothing to
-- do while working. Keymap in keymaps/visits.lua opens mini.extra's
-- picker over that tracked history.
require('mini.visits').setup({})
