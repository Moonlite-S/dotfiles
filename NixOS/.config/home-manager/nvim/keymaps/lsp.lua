-- LSP-driven refactors, not covered by Trouble's <leader>cs/<leader>cl
-- or conform's <leader>cf. Neovim 0.11+ already binds gra/grn to these
-- same two builtins by default, but they don't fall under the
-- <leader>c "+Code" mini.clue group for discoverability, so rebind
-- here too.
vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })

-- "source.organizeImports" is the LSP-standard kind for import
-- sorting (isort-equivalent); ruff exposes it as the more specific
-- "source.organizeImports.ruff", which this still matches since
-- CodeActionKinds are hierarchical (dot-prefixed) and Neovim's `only`
-- filter matches on that prefix. `apply = true` skips the picker
-- when exactly one match comes back - since both pyright and ruff are
-- enabled for python (lsp.lua) and both implement this kind, python
-- buffers will still show a 2-item picker rather than applying
-- silently.
vim.keymap.set('n', '<leader>co', function()
  vim.lsp.buf.code_action({
    context = { only = { 'source.organizeImports' }, diagnostics = {} },
    apply = true,
  })
end, { desc = 'Organize imports' })
