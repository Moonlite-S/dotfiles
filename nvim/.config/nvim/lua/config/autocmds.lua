-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Automatically rename tmux window to the current Neovim filename
local function rename_tmux_window()
  -- Check if we are actually inside a tmux session
  if vim.env.TMUX then
    -- Grab just the tail of the filename (e.g., 'index.tsx' instead of the full path)
    local filename = vim.fn.expand("%:t")

    -- If it's an empty buffer or dashboard, just call it 'nvim'
    if filename == "" then
      filename = "nvim"
    end

    -- Fire the command silently to tmux
    vim.fn.system("tmux rename-window " .. vim.fn.shellescape(filename))
  end
end

-- Trigger the function every time you enter a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = rename_tmux_window,
})

-- When you quit Neovim, hand naming control back to tmux
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    if vim.env.TMUX then
      vim.fn.system("tmux set-window-option automatic-rename on")
    end
  end,
})
