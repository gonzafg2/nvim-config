return {
  "ahmedkhalf/project.nvim",
  opts = {
    -- Configuración de detección de proyectos
    detection_methods = { "lsp", "pattern" },
    -- Patrones para detectar la raíz del proyecto
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      "Cargo.toml",
      "pyproject.toml",
      "requirements.txt",
    },
    -- No ignorar archivos ocultos por defecto
    ignore_lsp = {},
    -- Archivos/carpetas a excluir
    exclude_dirs = {
      "~/.cargo/*",
      "~/go/pkg/*",
      "~/.local/share/nvim/lazy/*",
      "~/.cache/*",
      "~/.npm/*",
      "~/.nvm/*",
      "/tmp/*",
    },
    -- Mostrar archivos ocultos como .git
    show_hidden = false,
    -- Cambiar automáticamente al directorio del proyecto
    silent_chdir = true,
    -- Configuración del scope de historial
    scope_chdir = "global",
    -- Archivo de historial de proyectos
    datapath = vim.fn.stdpath("data"),
  },
  lazy = false,
  priority = 100,
  config = function(_, opts)
    require("project_nvim").setup(opts)

    -- Integración con Telescope después de que todo esté cargado
    vim.defer_fn(function()
      local telescope_ok, telescope = pcall(require, "telescope")
      if telescope_ok then
        telescope.load_extension("projects")

        -- Forzar detección inicial del proyecto actual si está en un directorio con .git
        local current_dir = vim.fn.getcwd()
        if vim.fn.isdirectory(current_dir .. "/.git") == 1 then
          local project_nvim = require("project_nvim")
          -- Añadir el proyecto actual al historial
          local history = require("project_nvim.utils.history")
          table.insert(history.session_projects, current_dir)
        end
      end
    end, 100)
  end,
  keys = {
    -- Keymap para acceder rápidamente a proyectos
    {
      "<leader>fp",
      function()
        local telescope_ok, telescope = pcall(require, "telescope")
        if telescope_ok then
          telescope.extensions.projects.projects()
        else
          vim.notify("Telescope no disponible", vim.log.levels.WARN)
        end
      end,
      desc = "Find Project",
    },
    -- Comando para añadir el proyecto actual manualmente
    {
      "<leader>fP",
      function()
        local current_dir = vim.fn.getcwd()
        local history = require("project_nvim.utils.history")
        table.insert(history.session_projects, current_dir)
        vim.notify("Proyecto añadido: " .. vim.fn.fnamemodify(current_dir, ":t"), vim.log.levels.INFO)
      end,
      desc = "Add Current Project",
    },
  },
  -- Comando para usar en la línea de comandos
  init = function()
    vim.api.nvim_create_user_command("ProjectAdd", function()
      local current_dir = vim.fn.getcwd()
      local history = require("project_nvim.utils.history")
      table.insert(history.session_projects, current_dir)
      vim.notify("Proyecto añadido: " .. vim.fn.fnamemodify(current_dir, ":t"), vim.log.levels.INFO)
    end, { desc = "Add current directory as project" })
  end,
}
