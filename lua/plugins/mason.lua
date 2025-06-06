return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "vue-language-server", -- Este es el correcto para Vue 3
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "yaml-language-server",
        "lua-language-server",
        "rust-analyzer",
        "pyright",
        "marksman",
        "bash-language-server",
        "terraform-ls",
        "sqlls",
        
        -- Formatters
        "prettier",
        "stylua",
        "shfmt",
        
        -- Linters
        "markdownlint-cli2",
        "shellcheck",
      },
    },
  },
}