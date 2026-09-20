-- Keymaps
local opts = { silent = true }

vim.keymap.set('n', '<C-h>', '<cmd>NvimTmuxNavigateLeft<CR>', opts)
vim.keymap.set('n', '<C-j>', '<cmd>NvimTmuxNavigateDown<CR>', opts)
vim.keymap.set('n', '<C-k>', '<cmd>NvimTmuxNavigateUp<CR>', opts)
vim.keymap.set('n', '<C-l>', '<cmd>NvimTmuxNavigateRight<CR>', opts)
vim.keymap.set('n', '<C-\\>', '<cmd>NvimTmuxNavigateLastActive<CR>', opts)

-- Plugins
vim.cmd([[
  call plug#begin()

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'RRethy/base16-nvim'

  call plug#end()
]])

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd([[
      highlight Normal guibg=none ctermbg=none
    ]])
  end,
})


local ok, matugen = pcall(require, 'matugen')
if ok then matugen.setup() end
vim.cmd([[highlight Normal guibg=none ctermbg=none]])
