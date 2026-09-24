-- mini.extra: adds MiniExtra.pickers.oldfiles(), a mini.pick fuzzy
-- browser over the full v:oldfiles list - used by the dashboard's
-- "Recent Files" action and the visited-files picker. mini.pick
-- itself needs no config; it's just the picker UI mini.extra's
-- pickers run on.
require('mini.pick').setup({})
require('mini.extra').setup({})
