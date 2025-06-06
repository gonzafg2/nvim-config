return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- Configurar directorio temporal para tree-sitter
      vim.env.TMPDIR = vim.fn.expand("~/.cache/nvim/tmp")
      vim.fn.mkdir(vim.env.TMPDIR, "p")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    opts = function(_, opts)
      -- Solo instalar parsers esenciales y los que realmente uses
      opts.ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "sql",
        "terraform",
        "tsx",
        "typescript",
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
      
      -- Mejor rendimiento con folding
      opts.fold = {
        enable = true,
      }
      
      return opts
    end,
    config = function(_, opts)
      -- Configurar el compilador para tree-sitter
      require("nvim-treesitter.install").compilers = { "gcc", "cc", "clang", "cl" }
      require("nvim-treesitter.install").prefer_git = false
      
      require("nvim-treesitter.configs").setup(opts)
      
      -- Configurar folding con treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- No plegar automáticamente al abrir archivos
    end,
  },
}