return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      -- Agregar atajos personalizados para mejorar búsqueda
      { "<leader>sf", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Buscar todos los archivos" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Buscar texto en archivos" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Buscar comandos" },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buscar buffers" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Buscar ayuda" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Buscar símbolos en documento" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Buscar símbolos en workspace" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Buscar diagnósticos" },
      { "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Archivos recientes" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Reanudar última búsqueda" },
      { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Explorador de archivos" },
      -- Keymap para buscar en archivos de plugins
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope._extensions.file_browser.actions")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          ".cache",
          "%.o",
          "%.a",
          "%.out",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      })

      opts.extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-c>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-d>"] = fb_actions.remove,
              ["<C-h>"] = fb_actions.goto_parent_dir,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
    end,
  },
}