-- mini.ai: extends around/inner textobjects (a/i) beyond Vim's
-- builtin set - brackets, quotes, tag, function call, argument.
-- word/WORD (aw/iw/aW/iW) aren't in mini.ai's own table by design;
-- they already work via Neovim's builtin iw/aw/iW/aW, which mini.ai
-- falls back to transparently. Shown in the mini.clue popup via the
-- generated ai_clues there - mini.clue's real caveat here (per its
-- own doc header) is narrower than it might seem: these triggers
-- don't work mid-command in "temporary Normal mode" (e.g. after
-- <C-o> in Insert mode), and can behave oddly with custom operators
-- (not a concern here - this config defines none). Uppercase custom
-- textobjects (B/D/I/L/N) come from mini.extra's gen_ai_spec - entire
-- buffer, diagnostic, indent block, line, number - kept uppercase so
-- they can't collide with mini.ai's own lowercase built-ins (b
-- brackets, f function call, q quote, t tag).
local miniextra_ai = require('mini.extra').gen_ai_spec
require('mini.ai').setup({
  custom_textobjects = {
    B = miniextra_ai.buffer(),
    D = miniextra_ai.diagnostic(),
    I = miniextra_ai.indent(),
    L = miniextra_ai.line(),
    N = miniextra_ai.number(),
  },
})
