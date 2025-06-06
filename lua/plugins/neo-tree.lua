-- Configuración personalizada de Neo-tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- Configuración de la ventana
    window = {
      position = "right",
      width = 60, -- Aumentado el ancho a 45 columnas
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    -- Configuración del sistema de archivos
    filesystem = {
      filtered_items = {
        visible = true, -- Mostrar archivos ocultos como visibles
        hide_dotfiles = false, -- NO ocultar archivos que empiezan con .
        hide_gitignored = false, -- NO ocultar archivos ignorados por git
        hide_hidden = false, -- NO ocultar archivos ocultos (en Windows)
        hide_by_name = {
          -- Lista vacía - no ocultar ningún archivo por nombre
        },
        hide_by_pattern = {
          -- Lista vacía - no ocultar ningún archivo por patrón
        },
        always_show = { -- Siempre mostrar estos archivos/carpetas
          ".gitignore",
          ".env",
          ".env.local",
          ".env.development",
          ".env.production",
          ".dockerignore",
          "Dockerfile",
          "docker-compose.yml",
          "docker-compose.yaml",
          ".github",
          ".gitlab",
          ".vscode",
          ".idea",
        },
        never_show = {
          -- Lista vacía - mostrar todo
        },
      },
      follow_current_file = {
        enabled = true, -- Sincronizar árbol con archivo actual
        leave_dirs_open = false, -- Cerrar directorios no relacionados
      },
      group_empty_dirs = false, -- No agrupar carpetas vacías
      hijack_netrw_behavior = "open_default", -- Usar neo-tree como explorador por defecto
      use_libuv_file_watcher = true, -- Actualizar automáticamente cambios
    },
    -- Configuración de Git
    git_status = {
      window = {
        position = "float",
        width = 50,
      },
    },
    -- Configuración de Buffers
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        width = 40,
      },
    },
    -- Renderizado por defecto
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
  },
  -- Keymaps adicionales
  keys = {
    -- Mantener los keymaps por defecto de LazyVim
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (Root Dir)" },
    { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus NeoTree" },
    -- Añadir keymaps para resize
    {
      "<leader>w>",
      function()
        local view = require("neo-tree.sources.manager").get_state("filesystem")
        if view and view.window and vim.api.nvim_win_is_valid(view.window.winid) then
          vim.api.nvim_win_set_width(view.window.winid, vim.api.nvim_win_get_width(view.window.winid) + 5)
        end
      end,
      desc = "Increase Neo-tree Width",
    },
    {
      "<leader>w<",
      function()
        local view = require("neo-tree.sources.manager").get_state("filesystem")
        if view and view.window and vim.api.nvim_win_is_valid(view.window.winid) then
          vim.api.nvim_win_set_width(view.window.winid, math.max(vim.api.nvim_win_get_width(view.window.winid) - 5, 20))
        end
      end,
      desc = "Decrease Neo-tree Width",
    },
  },
}
