-- Iconos definidos para reutilizar (opcional)
local robot_icon = "󰚩"
-- local find_icon = ""

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- false | "classic" | "modern" | "helix"
    preset = "helix",
    win = {
      no_overlap = true,
      border = "double",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        winblend = 0,
      },
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
    keys = {
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    sort = { "local", "order", "group", "alphanum", "mod" },
    expand = function(node)
      return not node.desc
    end,
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      ellipsis = "…",
      mappings = true,
      colors = true,
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
      show_help = true,
      show_keys = true,
      disable = {
        ft = {},
        bt = {},
      },
      debug = false,
    },
  },
  keys = {
    -- Renombrar el grupo 'a' a '+IA'
    -- Se usa la descripción del prefijo para el nombre del grupo
    { "<leader>a", group = robot_icon .. "IA", desc = robot_icon .. "IA" },

    -- Mapeos específicos bajo el grupo 'a' (ahora 'IA')
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Abrir ClaudeCode" },
    -- { "<leader>ac", "<cmd>AIConfig<cr>", desc = "Configure AI" },

    -- Otros mapeos y grupos
    -- { "<leader>f", group = "[F]ind", desc = "Find Group" },
    -- { "<leader>fs", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- { "<leader>c", group = "Código", desc = "Código" },
  },
}
