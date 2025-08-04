-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Deshabilitar spell checking para evitar warnings de diccionarios faltantes
vim.opt.spell = false

-- Cargar comandos de diagnóstico
vim.defer_fn(function()
  require("config.health")
end, 100)
