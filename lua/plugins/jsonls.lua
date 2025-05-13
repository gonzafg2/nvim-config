return {
  "neovim/nvim-lspconfig",
  opts = function()
    local function get_jsonls_schemas()
      return {
        {
          description = "package.json",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json"
        },
        {
          description = "tsconfig.json",
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json"
        },
        {
          description = "eslintrc.json",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "https://json.schemastore.org/eslintrc.json"
        },
        {
          description = "lazyvim.json",
          fileMatch = { "lazyvim.json" },
          url = "https://raw.githubusercontent.com/LazyVim/LazyVim/main/lazy-lock.json"
        }
      }
    end

    return {
      servers = {
        jsonls = {
          settings = {
            json = {
              validate = { enable = true },
              format = { enable = true },
              schemas = get_jsonls_schemas()
            }
          }
        }
      }
    }
  end
}