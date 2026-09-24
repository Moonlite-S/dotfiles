-- Treesitter highlighting for markdown only (not enabled config-wide -
-- only markdown/markdown_inline parsers are installed, see the plugin
-- list). The new nvim-treesitter doesn't auto-enable highlighting for
-- installed parsers - this is its own documented setup snippet
-- (nvim-treesitter's README, "Highlighting" section), required for
-- render-markdown.nvim to have a parse tree to work from.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function() vim.treesitter.start() end,
})
