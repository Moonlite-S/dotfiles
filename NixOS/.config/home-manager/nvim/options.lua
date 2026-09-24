vim.g.mapleader = " "
-- Guarantees Neovim's cache dir exists before anything tries to write
-- into it. Usually harmless no-op (shada/swapfile writes create it as
-- a side effect on a normal system), but hit this the hard way via
-- snacks.lazygit's theme sync (lua/snacks/lazygit.lua:185's
-- update_config does vim.fn.writefile straight into stdpath('cache'),
-- with no mkdir of its own) on a fresh cache dir that had never been
-- touched by anything else yet.
vim.fn.mkdir(vim.fn.stdpath('cache'), 'p')
-- No trailing ~ on empty lines past end-of-buffer
vim.opt.fillchars:append({ eob = " " })
-- System clipboard integration: every yank/delete/paste (y, d, p,
-- etc.) reads/writes the system clipboard directly, register-
-- transparent - no need for "+y/"+p. Needs wl-clipboard installed
-- (home.nix) for Neovim's clipboard provider to find wl-copy/
-- wl-paste on this Wayland (niri) setup.
vim.opt.clipboard = 'unnamedplus'
-- Remember up to 1000 recently-edited files (default is 100) so the
-- dashboard/picker "Recent Files" actions have real history to show.
vim.opt.shada:append("'1000")
-- Two independent gutter columns: absolute line number, then relative
-- distance from the cursor. v:lnum/v:relnum are always absolute/
-- relative respectively regardless of 'number'/'relativenumber', so
-- this is real dual columns rather than the single-column hybrid
-- those two options give on their own.
vim.opt.statuscolumn = "%s%=%{printf('%3d', v:lnum)} %{printf('%3d', v:relnum)} "
-- Default border for any floating window that doesn't hardcode its
-- own. mini.pick, mini.clue, and blink.cmp's menu/docs/signature
-- floats all default their own border config to nil, which defers to
-- this on nvim 0.11+ (confirmed in each module's source) - one
-- setting covers several plugins' popups. pumborder is the equivalent
-- for the classic completion menu (Neovim 0.12+). noice.nvim's LSP
-- hover/signature and "mini" message popups don't consult this (it
-- hardcodes its own borders) - see its setup() call below.
vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'
-- Neovim defaults to real tab characters displayed 8 columns wide.
-- 4-space soft tabs instead: expandtab inserts spaces for a Tab
-- press, tabstop/softtabstop keep existing tab characters (e.g. in
-- files written elsewhere) and cursor movement 4-wide too, and
-- shiftwidth matches for >>/<</auto-indent.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
