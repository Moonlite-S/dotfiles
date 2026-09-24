-- mini.comment: replaces Neovim's built-in gc/gcc commenting
-- (nvim >=0.10's default 'vim._comment' mappings) with mini.nvim's
-- own - same keys (gc operator + visual, gcc current line), so this
-- just overrides those default mappings, no relearning needed, but
-- adds mini.nvim's hooks/customization and (if treesitter is ever
-- added later) embedded-language-aware commentstring detection.
require('mini.comment').setup({})
