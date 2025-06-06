-- Configuración consolidada de optimizaciones de rendimiento
return {
  -- Configuración centralizada de lazy.nvim para máximo rendimiento
  {
    "folke/lazy.nvim",
    opts = {
      performance = {
        cache = {
          enabled = true,
          path = vim.fn.stdpath("cache") .. "/lazy/cache",
          ttl = 3600 * 24 * 7, -- Cache por 1 semana
        },
        reset_packpath = true,
        rtp = {
          reset = true,
          paths = {}, -- Rutas personalizadas si es necesario
          disabled_plugins = {
            "2html_plugin",
            "getscript",
            "getscriptPlugin",
            "gzip",
            "logipat",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "rplugin",
            "rrhelper",
            "spellfile_plugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "vimball",
            "vimballPlugin",
            "zipPlugin",
            "osc52",
            "man",
            "spellfile",
          },
        },
      },
    },
  },
  
  -- Optimización de TreeSitter con detección inteligente
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = function(lang, buf)
          -- Deshabilitar en archivos grandes
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          
          -- Deshabilitar en archivos minificados (líneas muy largas)
          local lines = vim.api.nvim_buf_get_lines(buf, 0, 5, false)
          for _, line in ipairs(lines) do
            if #line > 300 then
              return true
            end
          end
          
          -- Deshabilitar en ciertos tipos de archivo
          local disable_ft = { "log", "txt", "help" }
          local filetype = vim.bo[buf].filetype
          if filetype and vim.tbl_contains(disable_ft, filetype) then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
    },
  },

  -- Optimizar Git Signs para archivos grandes
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_file_length = 10000, -- Líneas máximas
      attach_to_untracked = false,
      sign_priority = 6,
      update_debounce = 100,
      preview_config = {
        border = "single",
        style = "minimal",
      },
      current_line_blame_opts = {
        delay = 1000,
        virtual_text_pos = "eol",
      },
      -- Deshabilitar funciones no esenciales para mejorar rendimiento
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
    },
  },

  -- Optimizar indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { 
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = false,
      },
      exclude = {
        filetypes = {
          "help", "terminal", "lazy", "mason", "notify", 
          "toggleterm", "lazyterm", "lspinfo", "checkhealth",
          "man", "gitcommit", "TelescopePrompt", "TelescopeResults",
          "dashboard", "neo-tree", "Trouble", "trouble",
        },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    },
  },

  -- Optimizar notificaciones con lazy loading mejorado
  {
    "rcarriga/nvim-notify",
    lazy = true,
    init = function()
      -- Lazy load notify
      local notif_data = {}
      
      local function lazy_notify(msg, level, opts)
        notif_data[#notif_data + 1] = { msg = msg, level = level, opts = opts }
      end
      
      local function load_notify()
        local nvim_notify = require("notify")
        nvim_notify.setup({
          timeout = 3000,
          max_height = function()
            return math.floor(vim.o.lines * 0.75)
          end,
          max_width = function()
            return math.floor(vim.o.columns * 0.75)
          end,
          render = "minimal",
          stages = "fade",
          background_colour = "#000000",
        })
        
        vim.notify = nvim_notify
        
        -- Reproducir notificaciones pendientes
        for _, notif in ipairs(notif_data) do
          vim.notify(notif.msg, notif.level, notif.opts)
        end
        notif_data = nil
      end
      
      vim.notify = lazy_notify
      vim.defer_fn(load_notify, 500)
    end,
  },

  -- Deshabilitar completamente Noice.nvim para mejor rendimiento
  {
    "folke/noice.nvim",
    enabled = false,
  },


  -- Mejorar rendimiento de los iconos
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      strict = true,
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
      },
    },
  },
}