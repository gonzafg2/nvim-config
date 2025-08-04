return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")
      
      opts.servers = opts.servers or {}
      
      -- Configuración de ESLint LSP
      opts.servers.eslint = {
        root_dir = function(fname)
          -- Buscar proyecto con node_modules o git
          return util.find_node_modules_ancestor(fname)
            or util.find_git_ancestor(fname)
            or util.path.dirname(fname)
        end,
        
        -- Configurar handlers personalizados
        handlers = {
          -- Suprimir el mensaje de error molesto
          ["window/showMessageRequest"] = function(err, result, ctx, config)
            if result and result.message and result.message:match("ESLint library") then
              -- Retornar silenciosamente sin mostrar el mensaje
              return vim.NIL
            end
            -- Para otros mensajes, usar el handler por defecto
            return vim.lsp.handlers["window/showMessageRequest"](err, result, ctx, config)
          end,
          
          -- También suprimir en logs
          ["window/logMessage"] = function(err, result, ctx, config)
            if result and result.message and result.message:match("ESLint library") then
              return vim.NIL
            end
            return vim.lsp.handlers["window/logMessage"](err, result, ctx, config)
          end,
        },
        
        -- Configurar para proyectos sin ESLint local
        on_new_config = function(config, root_dir)
          -- Buscar ESLint global si no hay local
          local local_eslint = util.path.join(root_dir, "node_modules", ".bin", "eslint")
          if vim.fn.executable(local_eslint) ~= 1 then
            -- Configurar para usar ESLint global
            config.cmd = { "eslint", "--stdin" }
          end
        end,
        
        settings = {
          packageManager = "npm",
          useESLintClass = false,
          experimental = {
            useFlatConfig = false,
          },
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine",
            },
            showDocumentation = {
              enable = true,
            },
          },
          codeActionOnSave = {
            enable = false,
            mode = "all",
          },
          format = false,
          nodePath = "",
          onIgnoredFiles = "off",
          problems = {
            shortenToSingleLine = false,
          },
          quiet = false,
          rulesCustomizations = {},
          run = "onType",
          validate = "on",
          workingDirectory = {
            mode = "auto",
          },
        },
      }
      
      return opts
    end,
  },
}