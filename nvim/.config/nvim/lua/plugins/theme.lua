return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- Force true transparency to let your Kitty background bleed through
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        -- Base UI Colors
        colors.bg = "#1A161E" -- Fallback if transparency fails
        colors.bg_dark = "#141017"
        colors.bg_float = "#1A161E"
        colors.fg = "#F4EDEA" -- Warm cream text
        colors.fg_dark = "#E0DEF4"
        colors.fg_gutter = "#7A738C" -- Muted line numbers
        colors.border = "#FFB7B2" -- Pastel pink borders

        -- Sakura Miku Syntax Palette
        colors.magenta = "#FFB7B2" -- Primary Pink
        colors.purple = "#FF8FA3" -- Vibrant Pink
        colors.cyan = "#89DCEB" -- Miku Teal
        colors.blue = "#96CDFB" -- Sky Blue
        colors.green = "#A6D189" -- Leek Mint
        colors.yellow = "#F6C177" -- Warm Blonde
        colors.red = "#F28FAD" -- Soft Cherry
      end,
      on_highlights = function(hl, c)
        -- Force UI elements to use the custom pinks
        hl.CursorLineNr = { fg = c.magenta, bold = true }
        hl.TelescopeBorder = { fg = c.border }
        hl.NeoTreeFloatBorder = { fg = c.border }
        -- Directory tree: root name, directory names/icons in pink
        hl.NeoTreeRootName = { fg = c.magenta, bold = true }
        hl.NeoTreeDirectoryName = { fg = c.magenta }
        hl.NeoTreeDirectoryIcon = { fg = c.magenta }
        hl.NeoTreeIndentMarker = { fg = c.fg_gutter }
        hl.NeoTreeExpander = { fg = c.fg_gutter }
        -- Title bar (peeking buffers): pink bg like SnacksPickerListTitle
        hl.NeoTreeTitleBar = { fg = c.bg_dark, bg = c.magenta }
        -- File names and cursor line
        hl.NeoTreeFileName = { fg = c.fg }
        hl.NeoTreeCursorLine = { bg = "#261A24" }
        hl.NeoTreeDotfile = { fg = c.fg_gutter, italic = true }
        hl.NeoTreeDimText = { fg = c.fg_gutter }
        hl.NeoTreeModified = { fg = c.yellow }
        -- Git status following the palette
        hl.NeoTreeGitAdded = { fg = c.green }
        hl.NeoTreeGitDeleted = { fg = c.red }
        hl.NeoTreeGitModified = { fg = c.yellow }
        hl.NeoTreeGitConflict = { fg = c.red, bold = true }
        hl.NeoTreeGitIgnored = { fg = c.fg_gutter, italic = true }
        hl.NeoTreeGitUntracked = { fg = c.cyan }
        hl.NeoTreeGitStaged = { fg = c.green }
        hl.NeoTreeGitRenamed = { fg = c.cyan }
        hl.WhichKeyFloat = { bg = c.bg_dark }

        -- Override comments to be slightly more readable against the dark BG
        hl.Comment = { fg = "#7A738C", italic = true }

        -- Snacks Picker / Explorer
        -- Borders & titles: setting the base groups cascades to list/input/preview sub-windows
        hl.SnacksPicker = { bg = "#1C1020" }
        hl.SnacksPickerBorder = { fg = c.magenta }
        hl.SnacksPickerTitle = { fg = c.bg_dark, bg = c.magenta }
        hl.SnacksPickerFooter = { fg = c.magenta }
        -- Fuzzy match characters and the > prompt
        hl.SnacksPickerMatch = { fg = c.purple, bold = true }
        hl.SnacksPickerPrompt = { fg = c.magenta }
        -- Selected marker (shown on multi-selected items)
        hl.SnacksPickerSelected = { fg = c.purple, bold = true }
        -- Cursor line in the results list (subtle dark-rose tint)
        hl.SnacksPickerListCursorLine = { bg = "#261A24" }
        -- Explorer: directory names, parent paths, and tree structure in pastel pink tones
        hl.SnacksPickerDirectory = { fg = c.magenta }
        hl.SnacksPickerDir = { fg = "#7A4870" }
        hl.SnacksPickerTree = { fg = "#6B3858" }
        -- Explorer sidebar window title and border (list window-specific overrides)
        hl.SnacksPickerListTitle = { fg = c.bg_dark, bg = c.magenta }
        hl.SnacksPickerListBorder = { fg = c.magenta }
      end,
    },
  },
  -- Tell LazyVim to explicitly use our hijacked version of the theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
