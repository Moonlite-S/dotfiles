-- snacks.dashboard's header takes a plain multi-line string. This is
-- the "ansi_shadow" figlet font rendering of "NEOVIM" - the same
-- header snacks.nvim ships as its own built-in default (confirmed in
-- source, lua/snacks/dashboard.lua's `header` default), also the most
-- commonly used dashboard header in the community (confirmed via
-- MaximilianLloyd/ascii.nvim's curated collection, where it's listed
-- under the same name). Each key below is bound as a real, immediate
-- single-key mapping (confirmed in source), so pressing e.g. "f" fires
-- instantly - no typed-query disambiguation step like mini.starter's
-- evaluate_single needed, since each item just owns one literal key.
-- Find Files/Grep/Recent actions route through Snacks.dashboard.pick(),
-- which auto-prefers Snacks.picker (enabled below) over mini.pick/
-- telescope/fzf-lua. Restore Session explicitly supports mini.sessions
-- out of the box (confirmed in source: `section = "session"` calls
-- `require('mini.sessions').read()`), so the existing <leader>Sl
-- session setup keeps working from here with no glue code.
local dashboard_header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

require('snacks').setup({
  -- Same animated current-scope highlight mini.indentscope gave,
  -- plus static indent guides mini.indentscope didn't have.
  -- chunk.enabled defaults to false (confirmed in source), left off
  -- to match mini.indentscope's scope-only look rather than opting
  -- into the extra box-drawing mode unprompted.
  indent = {},
  -- Highlights other occurrences of the symbol under the cursor via
  -- real LSP references (semantic, not textual matching), plus adds
  -- jump-between-references (keymaps/words.lua). Only lights up with
  -- an attached LSP, unlike mini.cursorword (replaced) which worked
  -- on any buffer regardless.
  words = {},
  -- General-purpose fuzzy pickers (files/grep/recent) - has far more
  -- built-in sources than mini.pick (LSP refs/symbols, git log/
  -- status, diagnostics, etc.), though mini.pick/mini.extra stay
  -- installed regardless (they still back mini.ai's custom
  -- textobjects and the visited-files picker). Keymaps in
  -- keymaps/picker.lua.
  picker = {},
  -- Keymap in keymaps/lazygit.lua opens the real lazygit TUI (already
  -- installed system-wide) in a themed floating terminal.
  lazygit = {},
  -- Keymap in keymaps/buffers.lua deletes a buffer without closing
  -- its window/split.
  bufdelete = {},
  -- Keymap in keymaps/gitbrowse.lua opens the current file/line on
  -- the remote host (GitHub etc.) - new capability, not a replacement
  -- for mini.git, which stays for inline blame/signs.
  gitbrowse = {},
  -- Doesn't replace noice.nvim - noice's own "notify" view already
  -- lists `backend = { "snacks", "notify" }` and auto-detects this
  -- (confirmed in source: `is_available()` checks
  -- `Snacks.config.notifier.enabled`), so simply enabling this here
  -- makes noice route all vim.notify traffic through
  -- Snacks.notifier.notify() automatically. Everything else noice
  -- does (centered cmdline, LSP hover border, popupmenu) is
  -- untouched - no changes needed on noice's own setup() call.
  notifier = {},
  dashboard = {
    preset = {
      header = dashboard_header,
      -- Icons written as raw UTF-8 byte escapes, extracted directly
      -- from snacks.nvim's own default keys - literal Nerd Font PUA
      -- glyphs don't survive being written through some edit
      -- pipelines intact.
      keys = {
        { icon = '\xEF\x85\x9B\x20', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = '\xEF\x80\x82\x20', key = 'f', desc = 'Find Files', action = function() Snacks.dashboard.pick('files') end },
        { icon = '\xEF\x80\xA2\x20', key = 'g', desc = 'Grep', action = function() Snacks.dashboard.pick('live_grep') end },
        { icon = '\xEF\x83\x85\x20', key = 'r', desc = 'Recent Files', action = function() Snacks.dashboard.pick('oldfiles') end },
        -- Not `section = 'session'`: that relies on Snacks'
        -- M.have_plugin(), which only checks lazy.nvim's plugin
        -- registry (confirmed in source) - always false here since
        -- this config uses home-manager/Nix, not lazy.nvim, so that
        -- item would silently never appear. Calling mini.sessions
        -- directly instead (this is exactly what section='session'
        -- would have called anyway, had detection worked).
        -- Counts sessions before deciding: `.read()` alone always
        -- jumps straight to the latest one, and `.select('read')`
        -- alone always pops a vim.ui.select picker even with a single
        -- entry. Reading paths off `mini.sessions`' own public config
        -- (rather than hardcoding stdpath('data')/session + Session.vim)
        -- keeps this in sync if that config ever changes.
        {
          icon = '\xEE\x8D\x88\x20',
          key = 's',
          desc = 'Restore Session',
          action = function()
            local sessions = require('mini.sessions')
            local cfg = sessions.config
            local names = {}
            if cfg.directory ~= '' and vim.fn.isdirectory(cfg.directory) == 1 then
              for _, name in ipairs(vim.fn.readdir(cfg.directory)) do
                names[name] = true
              end
            end
            if cfg.file ~= '' and vim.fn.filereadable(vim.fn.getcwd() .. '/' .. cfg.file) == 1 then
              names[cfg.file] = true
            end
            if vim.tbl_count(names) > 1 then
              sessions.select('read')
            else
              sessions.read()
            end
          end,
        },
        { icon = '\xEF\x90\xA6\x20', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    -- Default sections also include "startup" (loaded-plugin count +
    -- startup time), which unconditionally does
    -- require('lazy.stats').stats() - hard-dependent on lazy.nvim as
    -- the plugin manager. This config uses home-manager/Nix for
    -- plugins, not lazy.nvim, so that section always errors here.
    -- Overriding sections to drop it (header + keys only, matching
    -- what mini.starter showed before - no startup stats either way).
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
})
