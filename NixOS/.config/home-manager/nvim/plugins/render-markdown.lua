-- render-markdown.nvim: renders headings/callouts/etc. GitHub-style
-- in place, revealing the raw markdown source only on the line the
-- cursor is currently on - its signature, default behavior, no
-- config needed for that. Depends on treesitter (treesitter-markdown.lua)
-- for parsing and picks up mini.icons automatically for code-block
-- icons (tries it before nvim-web-devicons, confirmed in its source).
require('render-markdown').setup({})
