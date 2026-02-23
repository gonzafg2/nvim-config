return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      {
        "hrsh7th/cmp-emoji",
        ft = { "markdown", "gitcommit" }, -- Solo cargar para estos tipos de archivo
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- Fuentes optimizadas con prioridades ajustadas
      opts.sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          priority = 1000,
          max_item_count = 20, -- Limitar items para mejor rendimiento
        },
        { 
          name = "luasnip",
          priority = 750,
          max_item_count = 5,
        },
        { 
          name = "nvim_lua", -- Solo para configuración de Neovim
          priority = 500,
        },
      }, {
        -- Grupo secundario (solo se usa si el primer grupo no tiene resultados)
        { 
          name = "buffer",
          priority = 250,
          option = {
            get_bufnrs = function()
              -- Solo buffers visibles para mejor rendimiento
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
          max_item_count = 10,
        },
        { 
          name = "path",
          priority = 100,
          max_item_count = 10,
        },
      })
      
      -- Mejoras en el mapeo de teclas
      local mapping = opts.mapping or {}
      opts.mapping = cmp.mapping.preset.insert(vim.tbl_extend("force", mapping, {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif vim.fn.exists("*copilot#Accept") == 1 then
            local key = vim.fn["copilot#Accept"]("")
            if key ~= "" then
              vim.api.nvim_feedkeys(key, "i", true)
            else
              fallback()
            end
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }))
      
      -- Mejoras en el formato de visualización
      opts.formatting = {
        format = function(entry, vim_item)
          -- Iconos para cada tipo de fuente
          local icons = {
            nvim_lsp = "",
            luasnip = "",
            buffer = "",
            path = "",
            emoji = "󰱫",
            codecompanion = "",
            nvim_lua = "",
          }
          
          vim_item.kind = string.format("%s %s", icons[entry.source.name] or "", vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            emoji = "[Emoji]",
            codecompanion = "[AI]",
            nvim_lua = "[Lua]",
          })[entry.source.name]
          
          return vim_item
        end,
      }
      
      -- Configuración de ventana mejorada
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          max_width = 80,
          max_height = 15,
        },
      }
      
      -- Performance
      opts.performance = {
        debounce = 40, -- Más agresivo
        throttle = 20, -- Menos throttling
        fetching_timeout = 100, -- Timeout más corto
        max_view_entries = 20,
      }
      
      return opts
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      
      -- Configuración para búsqueda
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      
      -- Configuración para comandos
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}