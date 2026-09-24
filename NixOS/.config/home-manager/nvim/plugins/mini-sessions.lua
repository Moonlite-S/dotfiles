-- mini.sessions: save/restore whole editor sessions (open buffers,
-- window layout, cwd) to named files under stdpath('data')/session.
-- autoread is off so opening nvim always lands on the dashboard
-- (loading a session is an explicit choice via <leader>Sl or the
-- dashboard's Restore Session key); autowrite keeps whatever session
-- you did load/create up to date as you work. Keymaps in
-- keymaps/sessions.lua.
require('mini.sessions').setup({
  autoread = false,
  autowrite = true,
})
