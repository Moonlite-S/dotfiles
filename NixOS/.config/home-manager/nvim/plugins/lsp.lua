-- LSP servers (Python, TS/JS, C++, C#, Rust, Nix). Native vim.lsp.enable()
-- auto-discovers these from nvim-lspconfig's bundled lsp/*.lua config
-- files on runtimepath - no require('lspconfig') call needed, that
-- plugin is just supplying the per-server cmd/root_dir/filetypes data
-- here. vim.lsp.config('*', ...) sets the default capabilities every
-- subsequently-enabled server advertises - blink.cmp needs its extra
-- completion capabilities (snippets, resolve support, etc.) merged in
-- for completion items to actually reach it.
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
vim.lsp.enable({ 'pyright', 'ruff', 'ts_ls', 'clangd', 'rust_analyzer', 'csharp_ls', 'nixd' })
-- Neovim's diagnostic defaults only show the sign-column marker (e.g.
-- "E") and leave the message text out of the buffer entirely -
-- virtual_text/virtual_lines both default to false (confirmed in
-- vim/diagnostic.lua). virtual_lines renders the full message on its
-- own line under the offending line, so it's visible without opening
-- a float or Trouble's panel (still available via <leader>xx for a
-- standing list of everything at once).
vim.diagnostic.config({ virtual_lines = true })
