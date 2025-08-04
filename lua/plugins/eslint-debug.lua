-- Comandos de depuración para ESLint
vim.api.nvim_create_user_command("EslintDebug", function()
  local clients = vim.lsp.get_active_clients()
  print("=== Active LSP Clients ===")
  for _, client in ipairs(clients) do
    if client.name == "eslint" or client.name == "efm" then
      print(string.format("Client: %s (id: %d)", client.name, client.id))
      print("  Root: " .. (client.config.root_dir or "none"))
      print("  Cmd: " .. vim.inspect(client.config.cmd))
      
      if client.name == "eslint" then
        print("  Settings: " .. vim.inspect(client.config.settings))
      end
    end
  end
  
  -- Verificar si ESLint está disponible
  print("\n=== ESLint Availability ===")
  print("Global ESLint: " .. vim.fn.system("which eslint"):gsub("\n", ""))
  print("NPM root: " .. vim.fn.system("npm root -g"):gsub("\n", ""))
  
  -- Verificar configuración
  local config_file = vim.fn.expand("~/.eslintrc.json")
  print("\n=== ESLint Config ===")
  print("Global config exists: " .. (vim.fn.filereadable(config_file) == 1 and "Yes" or "No"))
end, {})

return {}