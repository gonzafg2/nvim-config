-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Cargar configuración de autocomandos LSP con manejo robusto de errores
local ok, lsp_autocmds = pcall(require, "config.lsp-autocmds")
if ok then
  lsp_autocmds.setup()
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

-- Restaurar la posición del cursor al abrir un archivo
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto formateo al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_format"),
  pattern = "*",
  callback = function()
    if vim.g.autoformat then
      require("lazyvim.util").format.format({ force = true })
    end
  end,
})

-- Establecer el tipo de archivo para ciertos archivos
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("filetype_detect"),
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Cerrar automáticamente ciertos buffers con 'q'
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "qf", -- quickfix
    "checkhealth",
    "man",
    "notify",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Entrar en modo inserción automáticamente al abrir la terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal_settings"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- Eliminar números de línea y otros elementos visuales en ciertos buffers
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("clean_view"),
  pattern = { "terminal", "toggleterm" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Configurar diagnósticos en archivos .env (solo deshabilitar visualización)
vim.api.nvim_create_autocmd("BufRead", {
  group = augroup("env_files"),
  pattern = "*.env",
  callback = function()
    -- Solo deshabilitar la visualización, no los diagnósticos en sí
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
      update_in_insert = false,
    }, vim.api.nvim_get_current_buf())
  end,
})

-- Deshabilitar formateo automático en archivos .env
vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("env_no_format"),
  pattern = "*.env",
  callback = function()
    vim.b.disable_autoformat = true
  end,
})
