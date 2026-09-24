-- trouble.nvim: a persistent, foldable list panel for diagnostics
-- (also covers LSP refs/symbols, quickfix, loclist) - complements
-- rather than replaces the existing diagnostic tooling: mini.bracketed
-- already gives [d/]d single-diagnostic navigation, and
-- Snacks.picker.diagnostics() (unbound) gives a fuzzy one-off lookup,
-- but neither gives a standing, glanceable list of everything wrong
-- in the buffer/workspace at once. Picks up mini.icons automatically
-- (tries it before nvim-web-devicons, confirmed in its source), so no
-- extra icon dependency needed.
require('trouble').setup({})
