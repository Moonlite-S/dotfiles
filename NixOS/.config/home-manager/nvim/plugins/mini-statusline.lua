-- mini.statusline: bottom statusline (mode, git, diagnostics,
-- filename, location, search count). Sets vim.o.statusline itself,
-- same pattern as bufferline.nvim setting the tabline - no other
-- plugin here touches 'statusline', so no conflict. Colors come
-- from the MiniStatusline* highlight groups in matugen.lua (Noctalia
-- template), same mechanism as telescope/mini.pick.
--
-- content.active below is a copy of the module's own default content
-- function (mini.statusline docs: this is the documented way to
-- tweak one section) with only the mode section's trunc_width
-- changed, 120 -> 0, so is_truncated (cur_width < trunc_width) is
-- never true and the mode always shows in full (Normal/Insert/...)
-- instead of collapsing to a single letter under 120 columns. The
-- original also toggles a private H.use_icons flag around itself,
-- which this copy can't reach (H is a local upvalue, not exported) -
-- confirmed harmless to omit, since every section function falls
-- back to H.get_config().use_icons (the same value) when it's unset.
-- Resolves fg/bg colors dynamically (not cached) since mode_hl's
-- actual color changes with the mode (Normal/Insert/...) - cheap
-- enough to redo every render. link=false is required to get the
-- resolved color rather than {link = 'OtherGroup'} back (confirmed:
-- nvim_get_hl only follows the link and returns real colors when
-- explicitly told to).
local function sep_hl(name, from_group, to_group)
  local from_bg = vim.api.nvim_get_hl(0, { name = from_group, link = false }).bg
  local to_bg = vim.api.nvim_get_hl(0, { name = to_group, link = false }).bg
  vim.api.nvim_set_hl(0, name, { fg = from_bg, bg = to_bg })
end
-- Powerline separator glyphs (rounded style, U+E0B4/U+E0B6 - the
-- curved counterparts of the sharp U+E0B0/U+E0B2 arrows): fg = the
-- block being left, bg = the block being entered, standard convention
-- (same one lualine/powerline use) so it reads as a smooth color
-- transition rather than a solid block. Right-pointing on the left
-- side (colors fanning out left-to-right), left-pointing on the
-- right side (fanning out right-to-left), meeting at plain
-- 'StatusLine' in the middle. Written as raw UTF-8 byte escapes
-- rather than literal characters - these are Private Use Area
-- codepoints (only meaningful with a Nerd Font), and literal PUA
-- characters didn't survive being written through some edit
-- pipelines intact.
local SEP_R, SEP_L = '\xEE\x82\xB4', '\xEE\x82\xB6'

local ministatusline = require('mini.statusline')
ministatusline.setup({
  content = {
    active = function()
      local mode, mode_hl = ministatusline.section_mode({ trunc_width = 0 })
      local git           = ministatusline.section_git({ trunc_width = 40 })
      local diff          = ministatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = ministatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = ministatusline.section_lsp({ trunc_width = 75 })
      local filename      = ministatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = ministatusline.section_fileinfo({ trunc_width = 120 })
      local location      = ministatusline.section_location({ trunc_width = 75 })
      local search        = ministatusline.section_searchcount({ trunc_width = 75 })

      sep_hl('MiniStatuslineSepModeDevinfo', mode_hl, 'MiniStatuslineDevinfo')
      sep_hl('MiniStatuslineSepDevinfoFilename', 'MiniStatuslineDevinfo', 'MiniStatuslineFilename')
      sep_hl('MiniStatuslineSepFilenameEnd', 'MiniStatuslineFilename', 'StatusLine')
      sep_hl('MiniStatuslineSepStartFileinfo', 'MiniStatuslineFileinfo', 'StatusLine')
      sep_hl('MiniStatuslineSepFileinfoMode', mode_hl, 'MiniStatuslineFileinfo')

      return ministatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        '%#MiniStatuslineSepModeDevinfo#' .. SEP_R,
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
        '%#MiniStatuslineSepDevinfoFilename#' .. SEP_R,
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%#MiniStatuslineSepFilenameEnd#' .. SEP_R,
        '%=',
        '%#MiniStatuslineSepStartFileinfo#' .. SEP_L,
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        '%#MiniStatuslineSepFileinfoMode#' .. SEP_L,
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  },
})
