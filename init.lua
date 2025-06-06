-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Cargar comandos de diagnóstico
vim.defer_fn(function()
  require("config.health")
end, 100)
