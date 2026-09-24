-- Shared by initial load and every ColorScheme re-trigger (matugen's
-- SIGUSR1 handler re-applies the theme on Noctalia changes, which
-- fires ColorScheme again). Every window is fully see-through
-- regardless of focus - NormalNC used to get a dim, theme-matched
-- tint instead (a deliberate focused-vs-unfocused visual cue), but
-- that's opaque by design, which became obvious/unwanted once the
-- snacks.nvim explorer sidebar made focused vs. unfocused panes
-- directly comparable side by side. Changed per explicit request to
-- drop that distinction everywhere, not just for Snacks windows.
--
-- NormalFloat is cleared too - confirmed in snacks.nvim's source
-- (lua/snacks/win.lua) that its shared window helper links
-- SnacksNormal/SnacksNormalNC to NormalFloat as `default = true`
-- highlights, which every Snacks window (explorer, picker,
-- dashboard) uses for its own background via winhighlight. Since
-- links resolve live, clearing NormalFloat here makes all of those
-- transparent too, without touching Snacks-specific groups directly.
-- This also covers Snacks' own unfocused state as a side effect:
-- snacks/picker/util/highlight.lua's winhl() helper (used by the
-- explorer/picker's actual list window) never remaps NormalNC at
-- all, so its unfocused look was falling back to the plain global
-- NormalNC - which is exactly why clearing NormalNC below fixes it
-- too, not just ordinary splits.
-- Doesn't affect noice's popups - see the comment on its own `border`
-- setup in plugins/noice.lua. mini.pick USED to be left alone here for
-- the same "bespoke, non-default hex colors from matugen.lua" reason,
-- but that meant its window (used by the dashboard's Recent Files and
-- the visited-files picker, keymaps/visits.lua) stayed opaque while
-- every other float went transparent - explicitly clearing
-- MiniPickNormal/Border/Prompt/PromptPrefix below overrides matugen's
-- solid guibg on those four. MiniPickBorderText (the title chip on the
-- border) and MiniPickMatchCurrent/PromptCaret (selection highlight)
-- are deliberately left alone, same as its Telescope-group equivalent
-- and BlinkCmpMenuSelection above - accent/selection chips, not window
-- chrome.
--
-- The ColorScheme autocmd below wraps its work in vim.schedule(): per
-- this file's own top comment, matugen's SIGUSR1 handler re-runs
-- base16-colorscheme.setup() (which is what actually fires ColorScheme)
-- and THEN runs its own hi() calls that re-set MiniPickNormal/Border to
-- matugen's opaque colors - all synchronously, in that order, inside
-- the same handler. An unscheduled callback here would run mid-way
-- through that sequence and get clobbered by the trailing hi() calls -
-- the same staleness class as the tmux-powerline push-vs-pull gap
-- documented in this repo's CLAUDE.md. Deferring to the next tick
-- guarantees our override always lands after matugen's, regardless of
-- call order. The explicit apply_transparency() call at the bottom of
-- this file (after the initial matugen.setup()) stays unscheduled - it
-- already runs last on startup, and scheduling it too would just add a
-- needless one-tick flash of opaque colors before it corrects.
--
-- FloatBorder is cleared too - a separate group from NormalFloat,
-- governing just the border characters, which base16-nvim gives an
-- explicit solid guibg (confirmed: base16-colorscheme.lua's own
-- FloatBorder definition). mini.clue's border links to it directly
-- (`hi('MiniClueBorder', { link = 'FloatBorder' })`, confirmed in
-- mini.clue's source), and snacks.picker's border chains down to it
-- the same way its Normal background did (SnacksPickerListBorder ->
-- SnacksPickerBorder -> FloatBorder, via the same winhl() helper).
-- noice's cmdline border was never actually fixed/transparent on
-- purpose - matugen.lua never gives it a bespoke color at all (only
-- telescope/mini.pick got that treatment), so it was already
-- rendering with no background override, which is indistinguishable
-- from transparent.
--
-- Pmenu/PmenuBorder are cleared too, for the classic native pum
-- (pumborder, Neovim 0.12+) - Neovim ships its own opaque built-in
-- default for these, unrelated to any colorscheme.
--
-- The BlinkCmp* groups need clearing directly, separately from all of
-- the above - blink.cmp's own highlights.lua links BlinkCmpMenu(Border)
-- and BlinkCmpDoc(Border)/BlinkCmpSignatureHelp(Border) to
-- Pmenu/NormalFloat as `default = true` highlights, same live-link
-- mechanism as Snacks/mini.clue above, but this base16-nvim version
-- ships first-party blink.cmp support (confirmed in
-- base16-colorscheme.lua) that gives all six of them an explicit,
-- non-default solid guibg - which wins over blink's own default-link
-- attempt entirely (a `default = true` highlight never overrides an
-- already-explicit one), the same override pattern as FloatBorder
-- above. BlinkCmpMenuSelection is deliberately left alone, matching
-- PmenuSel - it's the selected-item highlight, not chrome.
local function apply_transparency()
  vim.cmd([[
    highlight Normal guibg=none ctermbg=none
    highlight NormalNC guibg=none ctermbg=none
    highlight LineNr guibg=none ctermbg=none
    highlight CursorLineNr guibg=none ctermbg=none
    highlight SignColumn guibg=none ctermbg=none
    highlight NormalFloat guibg=none ctermbg=none
    highlight FloatBorder guibg=none ctermbg=none
    highlight Pmenu guibg=none ctermbg=none
    highlight PmenuBorder guibg=none ctermbg=none
    highlight BlinkCmpMenu guibg=none ctermbg=none
    highlight BlinkCmpMenuBorder guibg=none ctermbg=none
    highlight BlinkCmpDoc guibg=none ctermbg=none
    highlight BlinkCmpDocBorder guibg=none ctermbg=none
    highlight BlinkCmpSignatureHelp guibg=none ctermbg=none
    highlight BlinkCmpSignatureHelpBorder guibg=none ctermbg=none
    highlight MiniPickNormal guibg=none ctermbg=none
    highlight MiniPickBorder guibg=none ctermbg=none
    highlight MiniPickPrompt guibg=none ctermbg=none
    highlight MiniPickPromptPrefix guibg=none ctermbg=none
  ]])
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() vim.schedule(apply_transparency) end,
})

local ok, matugen = pcall(require, 'matugen')
if ok then matugen.setup() end
apply_transparency()
