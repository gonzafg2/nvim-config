return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      codelens = { enabled = true }  -- Explicitly enable codelens
    },
    config = function(_, opts)
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/codeLens") then
          vim.lsp.codelens.refresh()
        end
      end)
    end
  }
}