return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { 
        enabled = true,
        exclude = { "markdown", "norg", "org", "plain" } -- Lista de filetypes a excluir de inlay hints
      },
      codelens = { enabled = true },
      -- Configuración de diagnósticos mejorada
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          format = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
              return string.format(" %s", diagnostic.message)
            end
            return diagnostic.message
          end,
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      -- Tabla setup requerida por LazyVim
      setup = {
        -- Aquí puedes añadir configuraciones personalizadas para servidores específicos
      },
      -- Configuración de servidores específicos
      servers = {
        -- TypeScript/JavaScript
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                includeCompletionsForModuleExports = true,
              },
              format = {
                enable = false, -- Usar prettier en su lugar
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                includeCompletionsForModuleExports = true,
              },
              format = {
                enable = false, -- Usar prettier en su lugar
              },
            },
          },
        },
        
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                autoImportCompletions = true,
              },
            },
          },
        },
        
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  "${3rd}/luv/library",
                },
              },
              telemetry = {
                enable = false,
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = true,
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                },
              },
            },
          },
        },
        
        -- JSON
        jsonls = {
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        
        -- YAML
        yamlls = {
          settings = {
            yaml = {
              hover = true,
              completion = true,
              validate = true,
              format = {
                enable = true,
              },
            },
          },
        },
        
        -- Terraform
        terraformls = {
          filetypes = { "terraform", "tf", "terraform-vars" },
        },
        
        -- Docker
        dockerls = {
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        },
        
        -- HTML/CSS
        html = {
          filetypes = { "html", "xhtml", "phtml", "hbs", "handlebars", "ejs", "erb" },
        },
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        
        -- Tailwind CSS
        tailwindcss = {
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        
        -- Vue (usando el nuevo vue-language-server)
        volar = {
          filetypes = { "vue" },
          -- Asegurarse de que Mason instale el paquete correcto
          mason = false, -- Deshabilitamos la instalación automática por ahora
        },
        
        -- Markdown
        marksman = {},
        
        -- Bash
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        
        -- SQL
        sqlls = {},
      },
    },
  },
}