-- Solo sobreescribir root_dir para que ESLint no inicie sin instalación local
-- LazyVim extra (lazyvim.plugins.extras.linting.eslint) maneja el resto
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = function(filename)
            local util = require("lspconfig.util")
            local node_root = util.find_node_modules_ancestor(filename)
            if node_root then
              local eslint_path = node_root .. "/node_modules/eslint"
              if vim.fn.isdirectory(eslint_path) == 1 then
                return node_root
              end
            end
            -- nil = no iniciar el servidor
            return nil
          end,
        },
      },
    },
  },
}
