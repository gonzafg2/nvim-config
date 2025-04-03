return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>b"] = { name = "Buffer" },
        ["<leader>f"] = { name = "Find/Archivo" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>l"] = { name = "LSP" },
        ["<leader>s"] = { name = "Buscar" },
        ["<leader>t"] = { name = "Terminal" },
        ["<leader>w"] = { name = "Ventana" },
        ["<leader>o"] = { name = "Obsidian" },
        ["<leader>x"] = { name = "Diagnósticos" },
        ["<leader>q"] = { name = "Sesión/Salir" },
      },
      window = {
        border = "rounded",       -- none, single, double, shadow, rounded
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}