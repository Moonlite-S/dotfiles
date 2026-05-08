return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = {
        "RenderMarkdownCode",
        "RenderMarkdownCodeInline",
        "@markup.raw.block",
        "@markup.raw.block.markdown",
      },
    })
  end,
}
