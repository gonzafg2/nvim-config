return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  config = function()
    require("render-markdown").setup({
      -- Configuration options for rendering markdown
      render = {
        enable = true, -- Enable rendering of markdown files
        filetypes = { "markdown", "codecompanion" }, -- Filetypes to apply rendering to
        command = "render-markdown", -- Command to use for rendering
      },
      keymaps = {
        toggle = "<C-m>", -- Keymap to toggle rendering
      },
    })
  end,
}
