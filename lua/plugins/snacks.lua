return {
  "folke/snacks.nvim",
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Forzar activación de módulos que requieren override
    if opts.input and opts.input.enabled then
      require("snacks").input.enable()
    end
  end,
  opts = function(_, opts)
    -- Asegurar que los módulos críticos estén habilitados
    opts.input = opts.input or {}
    opts.input.enabled = true
    opts.input.override = true -- Tomar control de vim.ui.input

    opts.notifier = opts.notifier or {}
    opts.notifier.enabled = true

    opts.dashboard = opts.dashboard or {}
    opts.dashboard.enabled = true

    -- Extender la configuración existente del dashboard
    local keys = {
      { icon = "󰈔 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = "󰈙 ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = "󰋚 ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = "󰊢 ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      {
        icon = "󰉋 ",
        key = "p",
        desc = "Find Project",
        action = function()
          -- Asegurar que el plugin esté cargado
          local project_ok, _ = pcall(require, "project_nvim")
          local telescope_ok, telescope = pcall(require, "telescope")

          if project_ok and telescope_ok then
            -- Verificar si la extensión está cargada
            if telescope.extensions.projects then
              telescope.extensions.projects.projects()
            else
              vim.notify("Cargando extensión de proyectos...", vim.log.levels.INFO)
              telescope.load_extension("projects")
              vim.defer_fn(function()
                telescope.extensions.projects.projects()
              end, 100)
            end
          else
            -- Fallback: mostrar directorios con .git
            if telescope_ok then
              telescope.builtin.find_files({
                prompt_title = "Proyectos (Buscar .git)",
                cwd = vim.fn.expand("~"),
                find_command = { "find", ".", "-maxdepth", "3", "-name", ".git", "-type", "d" },
                attach_mappings = function(_, map)
                  map("i", "<CR>", function(prompt_bufnr)
                    local selection = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").close(prompt_bufnr)
                    local project_dir = vim.fn.fnamemodify(selection.path, ":h")
                    vim.cmd("cd " .. project_dir)
                  end)
                  return true
                end,
              })
            else
              vim.notify("Telescope no disponible", vim.log.levels.ERROR)
            end
          end
        end,
      },
      {
        icon = "󰒓 ",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      { icon = "󰁯 ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰚥 ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
      { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
      { icon = "󰗼 ", key = "q", desc = "Quit", action = ":qa" },
    }

    -- Asegurar que el dashboard esté configurado
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}

    -- Añadir las teclas al preset existente
    opts.dashboard.preset.keys = keys

    return opts
  end,
}
