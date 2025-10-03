-- Parches para LazyVim para corregir errores conocidos
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Asegurar que folds existe antes de que LazyVim lo acceda
      -- Esto previene el error "attempt to index field 'folds' (a nil value)"
      opts.folds = opts.folds or { enabled = false }

      -- Asegurar que codelens existe
      opts.codelens = opts.codelens or { enabled = false }

      -- Asegurar que inlay_hints existe
      opts.inlay_hints = opts.inlay_hints or { enabled = true }

      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- Asegurar que los parsers se actualicen correctamente
      local install_ok, install = pcall(require, "nvim-treesitter.install")
      if install_ok then
        install.update({ with_sync = true })()
      end
    end,
    opts = function(_, opts)
      -- Asegurar que la configuración básica existe
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or { "lua", "vim", "vimdoc", "query" }
      opts.highlight = opts.highlight or { enable = true, additional_vim_regex_highlighting = false }
      opts.indent = opts.indent or { enable = true }
      opts.incremental_selection = opts.incremental_selection or {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }

      return opts
    end,
    config = function(_, opts)
      -- Configuración robusta de treesitter
      local function setup_treesitter()
        -- Múltiples intentos para configurar treesitter
        local configs_methods = {
          function() return require("nvim-treesitter.configs") end,
          function() return require("nvim-treesitter.config") end,
        }

        for _, get_config in ipairs(configs_methods) do
          local ok, configs = pcall(get_config)
          if ok and configs and configs.setup then
            configs.setup(opts)
            return true
          end
        end

        -- Si falla, configuración mínima manual
        vim.notify("Using fallback treesitter configuration", vim.log.levels.WARN)
        return false
      end

      setup_treesitter()
    end,
  },
}