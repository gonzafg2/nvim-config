return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
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
        colors.hint = colors.blue
        colors.error = "#ff5555"
      end,
      on_highlights = function(highlights, colors)
        highlights.CursorLine = {
          bg = colors.bg_highlight,
        }
        highlights.TabLine = {
          bg = colors.bg_dark,
          fg = colors.comment,
        }
        highlights.TabLineSel = {
          bg = colors.bg,
          fg = colors.blue,
        }
        if highlights.transparent then
          highlights.StatusLine = {
            bg = "NONE",
          }
        end
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
