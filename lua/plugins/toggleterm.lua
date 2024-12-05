return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<A-d>]], -- Alt + D para abrir/cerrar
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        auto_scroll = true,
        shading_factor = -30,
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 15,
        },
      })
    end,
  },
}
