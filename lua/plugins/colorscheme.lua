return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- Asegura que se cargue primero
    opts = {
      style = "storm", -- Opciones: "storm", "moon", "night", "day"
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer", "nvim-tree", "telescope" },
      lualine_bold = true,
      on_colors = function(colors)
        -- Ajustes personalizados de colores si lo deseas
        colors.hint = colors.blue
        colors.error = "#ff5555"
      end,
      on_highlights = function(highlights, colors)
        -- Resaltar la línea actual
        highlights.CursorLine = {
          bg = colors.bg_highlight,
        }
        -- Mejor visual para las pestañas (buffers/tabs)
        highlights.TabLine = {
          bg = colors.bg_dark,
          fg = colors.comment,
        }
        highlights.TabLineSel = {
          bg = colors.bg,
          fg = colors.blue,
        }
        -- Eliminar el fondo de la barra de estado cuando es transparente
        if highlights.transparent then
          highlights.StatusLine = {
            bg = "NONE",
          }
        end
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- Asegúrate de que se activa el tema
      vim.cmd("colorscheme tokyonight")
    end,
  },
  
  -- Agregar otro tema por si quieres cambiar fácilmente
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { dark = "mocha", light = "latte" },
      dim_inactive = {
        enabled = true,
        percentage = 0.15,
      },
      integrations = {
        telescope = true,
        which_key = true,
        cmp = true,
        nvimtree = true,
        treesitter = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
  },
}