-- Formatters, matching LSP language coverage. csharpier/clang-format/
-- prettier/nixfmt are their own binaries (extraPackages in
-- nvim/default.nix); ruff_format and rustfmt reuse the ruff/
-- rust-analyzer LSP installs. <leader>cf keymap lives in
-- keymaps/format.lua.
require('conform').setup({
  formatters_by_ft = {
    python = { 'ruff_format' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    cpp = { 'clang-format' },
    c = { 'clang-format' },
    cs = { 'csharpier' },
    rust = { 'rustfmt' },
    nix = { 'nixfmt' },
  },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
})
