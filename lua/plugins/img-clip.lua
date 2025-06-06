return {
  "HakonHarnes/img-clip.nvim",
  cmd = { "PasteImage" },
  keys = {
    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
  },
  config = function()
    require("img-clip").setup({
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    })
  end,
}
