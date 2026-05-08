-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fix Option + Delete (Alt + Backspace) in Insert Mode
-- Note: <M-BS> stands for Meta + Backspace
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true, silent = true })
-- Some terminals send <M-h> or other sequences, so we cover the most common ones:
vim.keymap.set("i", "<A-Backspace>", "<C-w>", { noremap = true, silent = true })
-- Make tab and shift tab move between buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })
