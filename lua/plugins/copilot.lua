return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { 
        enabled = false,
        auto_trigger = false,
        debounce = 50, -- Más agresivo para respuesta inmediata
      },
      panel = { enabled = false },
      filetypes = {
        -- Por defecto está habilitado en todos los tipos
        -- Solo especifica los que quieres deshabilitar:
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {
        settings = {
          advanced = {
            listCount = 3, -- Solo 3 sugerencias para máxima velocidad
            inlineSuggestCount = 1, -- Solo 1 sugerencia inline
            length = 500, -- Limitar longitud de las sugerencias
          },
        },
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- Adjuntar copilot-cmp al lspconfig
      require("lazyvim.util").lsp.on_attach(function(client, bufnr)
        copilot_cmp._on_insert_enter({})
      end)
    end,
  },
}