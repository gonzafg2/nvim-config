return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    opts = function(_, opts)
      -- Asegurar que opts existe
      opts = opts or {}
      -- Solo instalar parsers esenciales y los que realmente uses
      opts.ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "scss",
        "sql",
        "terraform",
        "svelte",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      }
      
      -- Configuración mejorada
      opts.highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
      
      opts.indent = {
        enable = true,
        disable = { "python", "yaml" }, -- Estos lenguajes tienen mejor indentación nativa
      }
      
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
      
      -- Configuración de autotag para HTML/JSX
      opts.autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      }
      
      -- Configuración de textobjects
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]l"] = "@loop.outer",
            ["]p"] = "@parameter.inner",
            ["]i"] = "@conditional.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]L"] = "@loop.outer",
            ["]P"] = "@parameter.outer",
            ["]I"] = "@conditional.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[l"] = "@loop.outer",
            ["[p"] = "@parameter.inner",
            ["[i"] = "@conditional.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[L"] = "@loop.outer",
            ["[P"] = "@parameter.outer",
            ["[I"] = "@conditional.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sp"] = "@parameter.inner",
            ["<leader>sf"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>sP"] = "@parameter.inner",
            ["<leader>sF"] = "@function.outer",
          },
        },
      }
      
      -- Configuración de folding segura con treesitter
      opts.fold = {
        enable = true,
      }

      return opts
    end,
    config = function(_, opts)
      -- Manejo robusto de errores para configurar treesitter

      -- Intento primario: usar el módulo estándar
      local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
      if configs_ok and configs.setup then
        configs.setup(opts)
        return
      end

      -- Intento secundario: usar el módulo config (singular)
      local config_ok, config = pcall(require, "nvim-treesitter.config")
      if config_ok and config.setup then
        config.setup(opts)
        return
      end

      -- Intento terciario: configuración manual esencial
      local ok, ts = pcall(require, "nvim-treesitter")
      if ok then
        -- Configurar manualmente highlight y parsers esenciales
        pcall(function()
          vim.treesitter.language.register("bash", "sh")
          vim.treesitter.language.register("bash", "zsh")
          vim.treesitter.language.register("javascript", "javascriptreact")
          vim.treesitter.language.register("typescript", "typescriptreact")
        end)

        -- Configurar highlight si está disponible
        pcall(function()
          if vim.treesitter.highlighter then
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(bufnr) then
                vim.treesitter.highlighter.new(vim.treesitter.get_parser(bufnr))
              end
            end
          end
        end)
      end

      -- Configurar el compilador para tree-sitter si está disponible
      local install_ok, install = pcall(require, "nvim-treesitter.install")
      if install_ok then
        install.compilers = { "gcc", "cc", "clang", "cl" }
        install.prefer_git = false
      end

      -- Configurar folding de forma segura
      if opts.fold and opts.fold.enable then
        pcall(function()
          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt.foldenable = false -- No plegar automáticamente al abrir archivos
          vim.opt.foldlevelstart = 99 -- Comenzar con todos los folds abiertos
        end)
      end
    end,
  },
}