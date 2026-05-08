return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      -- Optional: add extra groups you want to clear
      -- extra_groups = {
      --   "BufferLineTabClose",
      --   "BufferlineBufferSelected",
      -- },
    })
  end,
}
