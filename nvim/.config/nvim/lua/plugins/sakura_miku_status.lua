return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Define the Sakura Miku palette
      local colors = {
        bg_dark = "#141017",
        bg_gray = "#2A2734",
        fg_main = "#F4EDEA",
        pink = "#FFB7B2", -- Pastel Pink
        hot_pink = "#FF8FA3", -- Vibrant Pink
        cyan = "#89DCEB", -- Miku Teal
        green = "#A6D189", -- Leek Mint
        gray = "#7A738C",
      }

      -- Map colors to specific Lualine sections and modes
      local miku_theme = {
        normal = {
          a = { bg = colors.pink, fg = colors.bg_dark, gui = "bold" },
          b = { bg = colors.bg_gray, fg = colors.fg_main },
          c = { bg = "NONE", fg = colors.fg_main }, -- Transparent middle
        },
        insert = {
          a = { bg = colors.cyan, fg = colors.bg_dark, gui = "bold" },
          b = { bg = colors.bg_gray, fg = colors.fg_main },
          c = { bg = "NONE", fg = colors.fg_main },
        },
        visual = {
          a = { bg = colors.hot_pink, fg = colors.bg_dark, gui = "bold" },
          b = { bg = colors.bg_gray, fg = colors.fg_main },
          c = { bg = "NONE", fg = colors.fg_main },
        },
        command = {
          a = { bg = colors.green, fg = colors.bg_dark, gui = "bold" },
          b = { bg = colors.bg_gray, fg = colors.fg_main },
          c = { bg = "NONE", fg = colors.fg_main },
        },
        replace = {
          a = { bg = colors.hot_pink, fg = colors.bg_dark, gui = "bold" },
          b = { bg = colors.bg_gray, fg = colors.fg_main },
          c = { bg = "NONE", fg = colors.fg_main },
        },
        inactive = {
          a = { bg = "NONE", fg = colors.gray, gui = "bold" },
          b = { bg = "NONE", fg = colors.gray },
          c = { bg = "NONE", fg = colors.gray },
        },
      }

      -- Apply the custom theme to the existing options
      opts.options.theme = miku_theme

      -- Optional: Change the section separators to match the sharp prompt style
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }

      -- Remove the clock from the bottom-right section
      opts.sections.lualine_z = {}

      return opts
    end,
  },
}
