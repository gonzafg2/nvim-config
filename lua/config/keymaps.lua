-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Mejores movimientos para navegación
keymap("n", "<C-d>", "<C-d>zz", vim.tbl_extend("force", opts, { desc = "Scroll down and center" }))
keymap("n", "<C-u>", "<C-u>zz", vim.tbl_extend("force", opts, { desc = "Scroll up and center" }))

-- Mantener el cursor centrado al buscar
keymap("n", "n", "nzzzv", vim.tbl_extend("force", opts, { desc = "Next search result and center" }))
keymap("n", "N", "Nzzzv", vim.tbl_extend("force", opts, { desc = "Previous search result and center" }))

-- Navegación de buffers con leader key (evitar conflictos con movimientos de Leap)
keymap("n", "<leader>bn", ":bnext<CR>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
keymap("n", "<leader>bp", ":bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))
keymap("n", "<leader>bd", ":bdelete<CR>", vim.tbl_extend("force", opts, { desc = "Delete buffer" }))
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", vim.tbl_extend("force", opts, { desc = "Switch buffer" }))

-- Navegación de tabs
keymap("n", "<leader><tab>n", "<cmd>tabnext<cr>", vim.tbl_extend("force", opts, { desc = "Next Tab" }))
keymap("n", "<leader><tab>p", "<cmd>tabprevious<cr>", vim.tbl_extend("force", opts, { desc = "Previous Tab" }))
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", vim.tbl_extend("force", opts, { desc = "Close Tab" }))
keymap("n", "<leader><tab>o", "<cmd>tabnew<cr>", vim.tbl_extend("force", opts, { desc = "New Tab" }))

-- Reseleccionar visual después de indentar
keymap("v", "<", "<gv", vim.tbl_extend("force", opts, { desc = "Unindent and reselect" }))
keymap("v", ">", ">gv", vim.tbl_extend("force", opts, { desc = "Indent and reselect" }))

-- Mover líneas en modo visual
keymap("v", "J", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move lines down" }))
keymap("v", "K", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move lines up" }))

-- Mejor experiencia con Join lines
keymap("n", "J", "mzJ`z", vim.tbl_extend("force", opts, { desc = "Join lines (cursor stays)" }))

-- Yank hasta el final de línea (consistente con C y D)
keymap("n", "Y", "y$", vim.tbl_extend("force", opts, { desc = "Yank to end of line" }))

-- Pegado mejorado en modo visual
keymap("x", "<leader>p", [["_dP]], vim.tbl_extend("force", opts, { desc = "Paste without yanking" }))

-- Copiar al portapapeles del sistema
keymap({ "n", "v" }, "<leader>y", [["+y]], vim.tbl_extend("force", opts, { desc = "Copy to system clipboard" }))
keymap("n", "<leader>Y", [["+Y]], vim.tbl_extend("force", opts, { desc = "Copy line to system clipboard" }))

-- Eliminar sin copiar
keymap({ "n", "v" }, "<leader>d", [["_d]], vim.tbl_extend("force", opts, { desc = "Delete without yanking" }))

-- Navegación entre ventanas más rápida
keymap("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Go to left window" }))
keymap("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Go to lower window" }))
keymap("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Go to upper window" }))
keymap("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Go to right window" }))

-- Redimensionar ventanas con teclas de flecha
keymap("n", "<C-Up>", ":resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Decrease window height" }))
keymap("n", "<C-Down>", ":resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Increase window height" }))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Decrease window width" }))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Increase window width" }))

-- Desactivar macros accidentales
keymap("n", "q", "<Nop>", opts)
keymap("n", "Q", "q", vim.tbl_extend("force", opts, { desc = "Record macro" }))

-- Mejor escape
keymap("i", "jk", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode" }))

-- Guardar rápido
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", vim.tbl_extend("force", opts, { desc = "Save file" }))

-- Mejor experiencia con búsqueda
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlights" }))

-- Database client (dbee) keybindings
keymap("n", "<leader>db", "<cmd>Dbee<cr>", vim.tbl_extend("force", opts, { desc = "Open Database UI" }))
keymap("n", "<leader>dt", "<cmd>Dbee toggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle Database UI" }))
keymap("n", "<leader>dc", "<cmd>Dbee close<cr>", vim.tbl_extend("force", opts, { desc = "Close Database UI" }))

-- Database query execution (available when dbee is active)
keymap("n", "<leader>de", function()
  require("dbee").api.core.execute()
end, vim.tbl_extend("force", opts, { desc = "Execute current query" }))

keymap("v", "<leader>de", function()
  require("dbee").api.core.execute_selection()
end, vim.tbl_extend("force", opts, { desc = "Execute selected query" }))

-- Database result navigation
keymap("n", "<leader>dn", function()
  require("dbee").api.ui.result_page_next()
end, vim.tbl_extend("force", opts, { desc = "Next result page" }))

keymap("n", "<leader>dp", function()
  require("dbee").api.ui.result_page_prev()
end, vim.tbl_extend("force", opts, { desc = "Previous result page" }))

-- Database result storage
keymap("n", "<leader>ds", function()
  require("dbee").store("csv", "file", { extra_arg = vim.fn.input("Save to file: ") })
end, vim.tbl_extend("force", opts, { desc = "Save results to file" }))
