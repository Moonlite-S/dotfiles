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

-- Enforce Strawberry Milk aesthetic for Snacks Picker & Explorer
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Folder / Directory names
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#ffb3c1" })

    -- The vertical tree branches / indent markers
    vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = "#4a3036" })

    -- The background color of the currently selected row
    vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#3d2b2f" })

    -- The characters that match when you are typing to fuzzy-find
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#a8e6cf", bold = true })

    -- The title at the top of the explorer/picker window
    vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#ffb3c1", bold = true })

    -- Optional: If you want the border of the explorer to be pink too
    -- vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#ffb3c1" })
  end,
})
