-- mini.clue: leader-key popup, same desc-based auto-discovery as
-- which-key had, but (unlike which-key) needs explicit triggers or it
-- does nothing. gen_clues.* adds labeled popups for common built-in
-- prefixes (g, z, marks, registers, <C-w>, built-in completion) on
-- top of <leader>.
local miniclue = require('mini.clue')

-- mini.ai's a/i textobject identifiers have no real per-key keymap to
-- auto-discover (mini.ai reads the identifier via one raw
-- getcharstr() call), so their clue entries have to be declared by
-- hand like this - generated here instead of 40+ literal table
-- entries. Only the mnemonic letters get a label; literal punctuation
-- identifiers ("(", "b" -> "(" etc.) stay fully functional but don't
-- get their own popup row since they're already self-explanatory.
local ai_ids = {
  a = 'Argument', b = 'Bracket (any)', f = 'Function call', q = 'Quote (any)',
  t = 'Tag', ['?'] = 'User prompt',
  B = 'Buffer', D = 'Diagnostic', I = 'Indent', L = 'Line', N = 'Number',
}
local ai_clues = {}
for id, desc in pairs(ai_ids) do
  for _, prefix in ipairs({ 'a', 'i' }) do
    for _, mode in ipairs({ 'o', 'x' }) do
      table.insert(ai_clues, { mode = mode, keys = prefix .. id, desc = desc })
    end
  end
end

local clues = {
  miniclue.gen_clues.g(),
  miniclue.gen_clues.marks(),
  miniclue.gen_clues.square_brackets(),
  miniclue.gen_clues.z(),
  miniclue.gen_clues.registers(),
  miniclue.gen_clues.windows(),
  miniclue.gen_clues.builtin_completion(),
  -- Group label for <leader>s; the individual entries (a/d/r/f/F/h)
  -- are auto-discovered from mini.surround's own keymap `desc`s,
  -- no need to list them here too.
  { mode = 'n', keys = '<Leader>s', desc = '+Surround' },
  { mode = 'n', keys = '<Leader>c', desc = '+Code' },
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>S', desc = '+Sessions' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>w', desc = '+Window' },
}
vim.list_extend(clues, ai_clues)

miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    -- mini.ai's a/i textobjects. Operator-pending + visual only,
    -- deliberately NOT normal mode - a/i are native Neovim commands
    -- there (append/insert), so a normal-mode trigger would shadow
    -- them entirely.
    { mode = 'o', keys = 'a' },
    { mode = 'o', keys = 'i' },
    { mode = 'x', keys = 'a' },
    { mode = 'x', keys = 'i' },
  },
  clues = clues,
  window = { delay = 500 }, -- default is 1000ms
})
