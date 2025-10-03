return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
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

      -- Keybindings personalizados
      -- Tab: Aceptar sugerencia (con fallback inteligente)
      vim.keymap.set("i", "<Tab>", function()
        if vim.fn["copilot#Accept"]("") ~= "" then
          return vim.fn["copilot#Accept"]("")
        else
          return "<Tab>"
        end
      end, { expr = true, replace_keycodes = false })

      -- Ctrl+]: Siguiente sugerencia
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")

      -- Ctrl+\: Descartar sugerencia
      vim.keymap.set("i", "<C-\\>", "<Cmd>copilot#Dismiss()<CR>", { silent = true })
    end,
  },
}
