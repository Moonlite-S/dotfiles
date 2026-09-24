-- blink.cmp: replaces mini.completion. Real LSP-aware completion menu
-- (docs, signature help, snippet jumping) instead of mini.completion's
-- native-ins-completion-menu wrapper. Fuzzy matcher comes prebuilt via
-- the Nix package (blink-fuzzy-lib), no local Rust build needed.
--
-- Keymap: 'default' preset already matches the native ins-completion
-- keys (C-n/C-p select, C-y accept, C-space show) this config used
-- under mini.completion. Tab/S-Tab/CR are overridden here to keep the
-- old muscle memory (Tab/S-Tab cycle the popup, Enter accepts) while
-- still falling through to blink's new snippet-jump / literal-key
-- behavior when no popup is open.
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  completion = {
    documentation = { auto_show = true },
  },
  signature = { enabled = true },
})
