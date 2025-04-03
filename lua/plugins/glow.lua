return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function()
      require("glow").setup({
        -- Opciones de estilo
        style = "dark", -- o "light" dependiendo de tu tema
        width = 120, -- ancho de la ventana
        height = 80, -- altura de la ventana

        -- Configura para abrir en terminal
        pager = false, -- no usar pager

        -- Más opciones
        border = "rounded", -- estilo del borde: "shadow", "rounded", "double", "single", or "none"

        -- Opciones para la ventana
        window_type = "floating", -- Posibles valores: "floating", "split", "vsplit"

        -- Para mostrar línea de números
        line_number = true,
      })
    end,
    -- Asigna una tecla para abrir Glow
    keys = {
      { "<leader>md", "<cmd>Glow<cr>", desc = "Markdown Preview (Glow)" },
    },
  },
}
