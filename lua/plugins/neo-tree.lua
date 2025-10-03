-- Configuración personalizada de Neo-tree que sobrescribe LazyVim
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- Configuración de la ventana
    window = {
      position = "left",
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
    -- Habilitar iconos de archivos
    enable_git_status = true,
    enable_diagnostics = true,
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
        folder_closed = "󰉋",
        folder_open = "󰝰",
        folder_empty = "󰉖",
        default = "󰈔",
        highlight = "NeoTreeFileIcon",
        folder_empty_open = "󰷏",
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
          added = "[A]",
          modified = "[M]",
          deleted = "[D]",
          renamed = "[R]",
          -- Status type
          untracked = "[U]",
          ignored = "[I]",
          unstaged = "[~]",
          staged = "[S]",
          conflict = "[!]",
        },
      },
    },
    -- Configuración de colores para estados git
    document_symbols = {
      kinds = {
        File = { icon = "󰄵", hl = "Tag" },
        Namespace = { icon = "󰜍", hl = "Include" },
        Package = { icon = "󰞔", hl = "Label" },
        Class = { icon = "󰛯", hl = "Include" },
        Property = { icon = "󰝰", hl = "@property" },
        Enum = { icon = "󰛯", hl = "@number" },
        Function = { icon = "󰃎", hl = "Function" },
        String = { icon = "󰞍", hl = "String" },
        Number = { icon = "󰣺", hl = "Number" },
        Array = { icon = "󰞨", hl = "Type" },
        Object = { icon = "󰅋", hl = "Type" },
        Key = { icon = "󰄕", hl = "Keyword" },
        Null = { icon = "󰌃", hl = "Constant" },
        EnumMember = { icon = "󰛯", hl = "Number" },
        Struct = { icon = "󰛯", hl = "Type" },
        Event = { icon = "󰣼", hl = "Constant" },
        Operator = { icon = "󰠔", hl = "Operator" },
        TypeParameter = { icon = "󰛯", hl = "Type" },
      },
    },
  },
  -- Configurar highlights personalizados
  config = function(_, opts)
    -- Configurar highlights para estados git
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#a6d189" })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#e5c890" })
    vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#e78284" })
    vim.api.nvim_set_hl(0, "NeoTreeGitRenamed", { fg = "#85c1dc" })
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#f4b8e4" })
    vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#737994" })
    vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#ef9f76" })
    vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#a6d189" })
    vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#e78284" })

    -- Aplicar configuración
    require("neo-tree").setup(opts)
  end,
  -- Keymaps adicionales
  keys = {
    -- Mantener los keymaps por defecto de LazyVim
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (Root Dir)" },
    { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus NeoTree" },
    -- Añadir keymaps para resize
    {
      "<leader>w>",
      function()
        local manager = require("neo-tree.sources.manager")
        local view = manager.get_state("filesystem")
        if view and view.window and view.window.winid and vim.api.nvim_win_is_valid(view.window.winid) then
          local current_width = vim.api.nvim_win_get_width(view.window.winid)
          vim.api.nvim_win_set_width(view.window.winid, current_width + 5)
        else
          vim.notify("Neo-tree window not found", vim.log.levels.WARN)
        end
      end,
      desc = "Increase Neo-tree Width",
    },
    {
      "<leader>w<",
      function()
        local manager = require("neo-tree.sources.manager")
        local view = manager.get_state("filesystem")
        if view and view.window and view.window.winid and vim.api.nvim_win_is_valid(view.window.winid) then
          local current_width = vim.api.nvim_win_get_width(view.window.winid)
          vim.api.nvim_win_set_width(view.window.winid, math.max(current_width - 5, 20))
        else
          vim.notify("Neo-tree window not found", vim.log.levels.WARN)
        end
      end,
      desc = "Decrease Neo-tree Width",
    },
  },
}
