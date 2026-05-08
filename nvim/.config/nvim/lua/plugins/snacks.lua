return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
        },
        win = {
          input = { wo = { winblend = 10 } },
          list = { wo = { winblend = 10 } },
          preview = { wo = { winblend = 5 } },
        },
      },
    },
  },
}
