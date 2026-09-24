-- mini.icons: used natively by mini.clue, and by snacks.nvim's
-- explorer/picker/dashboard (it tries mini.icons first, confirmed in
-- source - no extra config needed there). Also mocks
-- 'nvim-web-devicons' for bufferline.nvim (the one plugin here
-- hardcoded to require() that package) so icons work without adding
-- the real nvim-web-devicons dependency.
require('mini.icons').setup({})
require('mini.icons').mock_nvim_web_devicons()
