return {

  -- Deshabilitado: Snacks.input maneja vim.ui.input/select
  { "stevearc/dressing.nvim", enabled = false },

  -- Barra de indentación
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│", -- Símbolo para las líneas de indentación
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
    main = "ibl",
  },

  -- Colores para los pares de paréntesis, llaves, corchetes
  -- DESACTIVADO: Si quieres reactivarlo, descomenta este bloque
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("rainbow-delimiters.setup").setup({
  --       strategy = {
  --         [""] = "rainbow-delimiters.strategy.global",
  --         vim = "rainbow-delimiters.strategy.local",
  --       },
  --       query = {
  --         [""] = "rainbow-delimiters",
  --         lua = "rainbow-blocks",
  --       },
  --       priority = {
  --         [""] = 110,
  --         lua = 210,
  --       },
  --       highlight = {
  --         "RainbowDelimiterRed",
  --         "RainbowDelimiterYellow",
  --         "RainbowDelimiterBlue",
  --         "RainbowDelimiterOrange",
  --         "RainbowDelimiterGreen",
  --         "RainbowDelimiterViolet",
  --         "RainbowDelimiterCyan",
  --       },
  --     })
  --   end,
  -- },

  -- Deshabilitado: Snacks.notifier maneja notificaciones
  { "rcarriga/nvim-notify", enabled = false },
}
