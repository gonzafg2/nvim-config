return {
  -- Plugin oficial de GitHub Copilot (sugerencias inline)
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- Desactivar Tab mapping por defecto (lo maneja nvim-cmp)
      vim.g.copilot_no_tab_map = true

      vim.g.copilot_filetypes = {
        ["*"] = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      }

      vim.g.copilot_node_command = "node"

      -- Aceptar sugerencia con Ctrl+y
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })

      -- Navegación entre sugerencias
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)")
    end,
  },

  -- CopilotChat para conversaciones con Copilot
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
    },
    keys = {
      { "<leader>ap", "", desc = "Copilot", mode = { "n", "v" } },
      { "<leader>app", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
      { "<leader>ape", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "Explicar selección" },
      { "<leader>apr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "Revisar selección" },
      { "<leader>apf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "Corregir selección" },
      { "<leader>apo", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "Optimizar selección" },
      { "<leader>apd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "Generar docs" },
      { "<leader>apt", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "Generar tests" },
    },
    opts = {},
  },
}
