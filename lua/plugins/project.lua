return {
  "ahmedkhalf/project.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("project_nvim").setup({
      -- Configuración opcional
      detection_methods = { "lsp", "pattern" }, -- Detecta proyectos usando LSP o patrones
      patterns = { ".git", "Makefile", "package.json" }, -- Archivos/directorios que identifican un proyecto
      -- Directory behavior
      show_hidden = true, -- Show hidden files in telescope
      silent_chdir = true, -- Don't print message when changing directory

      -- Telescope integration
      telescope_settings = {
        -- Display settings for telescope
        order_by = "recent",
        search_inside = true,
      },
    })
  end,
}
