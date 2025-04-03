-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- Mejores movimientos para navegación
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Mantener el cursor centrado al buscar
keymap("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Mejor navegación de buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })

-- Reseleccionar visual después de indentar
keymap("v", "<", "<gv", { desc = "Unindent and reselect" })
keymap("v", ">", ">gv", { desc = "Indent and reselect" })

-- Mover líneas en modo visual
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })
