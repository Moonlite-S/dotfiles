-- mini.map: a scaled-down buffer overview (minimap) in a side
-- window. Doesn't auto-show; toggle it with <leader>m (keymaps/minimap.lua).
-- Default encoding is block('3x2') - solid Unicode blocks at a coarse
-- 3x2 resolution, which reads as chunky solid bars rather than a text
-- shape. dot('4x2') is the highest-resolution option mini.map offers
-- (Braille dots, 8 per cell) and looks like a fine dot-matrix sketch
-- of the code instead.
local minimap = require('mini.map')
minimap.setup({
  symbols = { encode = minimap.gen_encode_symbols.dot('4x2') },
})
