return {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- Deshabilitar en tipos de archivo específicos
      vim.g.copilot_filetypes = {
        ["*"] = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      }

      -- Configuración de Node.js
      vim.g.copilot_node_command = "node" -- Node.js version must be > 18.x

      -- Tab: copilot.vim lo maneja automáticamente con fallback inteligente
      -- No necesita configuración manual, funciona out-of-the-box

      -- Keybindings adicionales de navegación
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)")
    end,
  },
}
