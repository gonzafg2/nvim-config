-- Deshabilitar diagnósticos en archivos .env
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.env",
  callback = function()
    vim.diagnostic.enable(false) -- Desactiva diagnósticos en archivos .env
  end,
})
--
-- -- Deshabilitar formateo automático en archivos .env
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   pattern = "*.env",
--   callback = function()
--     vim.b.disable_autoformat = true
--   end,
-- })
