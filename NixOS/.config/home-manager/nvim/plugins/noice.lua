-- noice.nvim: replaces the bottom command-line/message row with
-- floating windows - cmdline centered (its own default view,
-- "cmdline_popup", no extra config needed to get that), messages as
-- popups, like LazyVim. Replaced the native vim._core.ui2 attempt,
-- which works but can't be centered (hardcoded bottom-anchored, no
-- config option for it). Needs nui-nvim (added above), the one
-- non-mini.nvim dependency in this config.
--
-- noice intercepts LSP hover/signature help itself and renders them
-- through its own "hover" view, which hardcodes a borderless style -
-- vim.o.winborder above never gets consulted for these two, so they
-- need noice's own official preset for it (confirmed in its source:
-- lsp_doc_border sets exactly views.hover.border.style = 'rounded').
-- Its "mini" view (short one-line messages, e.g. LSP progress) is
-- also hardcoded borderless with no preset for it, hence the direct
-- override below.
--
-- Doesn't replace noice.nvim - noice's own "notify" view already
-- lists `backend = { "snacks", "notify" }` and auto-detects this
-- (confirmed in source: `is_available()` checks
-- `Snacks.config.notifier.enabled`), so simply enabling notifier in
-- snacks.lua makes noice route all vim.notify traffic through
-- Snacks.notifier.notify() automatically. Everything else noice
-- does (centered cmdline, LSP hover border, popupmenu) is
-- untouched here.
require('noice').setup({
  presets = { lsp_doc_border = true },
  views = { mini = { border = { style = 'rounded' } } },
})
