return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 10,
        open_mapping = [[<C-a>]], -- Alt + D para abrir/cerrar terminal horizontal
        shade_terminals = true,
        shade_factor = 25,
        shade_ratio = 0.25,
        start_in_insert = true,
        auto_scroll = true,
        direction = "horizontal", -- Terminal por defecto: horizontal
        terminal_mappings = true,
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
        end,
        winbar = {
          enable = true,
        },
      })

      -- Crear una terminal flotante adicional
      local Terminal = require("toggleterm.terminal").Terminal
      local float_term = Terminal:new({
        direction = "float",
        size = 20,
        start_in_insert = true,
        shade_terminals = true,
        winbar = {
          enable = true,
        },
        float_opts = {
          border = "curved", -- Opciones: "single", "double", "curved", etc.
          winblend = 15,
        },
        on_open = function(term)
          -- Salir al modo NORMAL con <Esc> en la terminal flotante
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
        end,
      })

      -- Crear un comando para abrir/cerrar la terminal flotante
      vim.api.nvim_create_user_command("ToggleFloatTerm", function()
        float_term:toggle()
      end, { desc = "Abrir Terminal Flotante" })

      -- Mapear un atajo para abrir la terminal flotante
      vim.api.nvim_set_keymap(
        "n",
        "<C-c>", -- Alt + F para la terminal flotante
        ":ToggleFloatTerm<CR>",
        { noremap = true, silent = true, desc = "Abrir terminal flotante" }
      )
    end,
  },
}
