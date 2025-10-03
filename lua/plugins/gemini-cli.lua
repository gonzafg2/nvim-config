return {
  "marcinjahn/gemini-cli.nvim",
  cmd = "Gemini",
  -- Example key mappings for common actions:
  keys = {
    { "<leader>agg", "<cmd>Gemini toggle<cr>", desc = "Toggle Gemini CLI" },
    { "<leader>aga", "<cmd>Gemini ask<cr>", desc = "Ask Gemini", mode = { "n", "v" } },
    { "<leader>agf", "<cmd>Gemini add_file<cr>", desc = "Add File" },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = true,
}
