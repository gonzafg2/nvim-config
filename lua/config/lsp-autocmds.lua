-- Configuración de autocomandos LSP con manejo robusto de errores
-- Este archivo ayuda a prevenir errores cuando los valores esperados son nil

local M = {}

-- Función auxiliar para verificar valores antes de usar tbl_contains
local function safe_tbl_contains(tbl, value)
  if not tbl or not value then
    return false
  end
  return vim.tbl_contains(tbl, value)
end

-- Función para configurar autocomandos LSP con manejo de errores
function M.setup()
  -- Crear grupo de autocomandos para LSP
  local lsp_group = vim.api.nvim_create_augroup("LspAutocmds", { clear = true })
  
  -- Autocomando para cuando se adjunta un servidor LSP
  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      
      -- Verificar que el cliente existe antes de proceder
      if not client then
        return
      end
      
      -- Configuración específica del buffer
      local opts = { buffer = bufnr, noremap = true, silent = true }
      
      -- Aquí puedes agregar configuraciones específicas de LSP
      -- Por ejemplo, keymaps, opciones del buffer, etc.
    end,
  })
  
  -- Autocomando para manejar cambios en capacidades del LSP
  vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    group = lsp_group,
    callback = function(args)
      -- Verificar que args.data existe y tiene la estructura esperada
      if not args.data or type(args.data) ~= "table" then
        return
      end
      
      local client = args.data.client
      local buffer = args.data.buffer
      local method = args.data.method
      
      -- Verificar que todos los valores necesarios existen
      if not client or not buffer or not method then
        return
      end
      
      -- Aquí puedes agregar lógica específica para diferentes métodos LSP
    end,
  })
end

-- Función para verificar de forma segura si un buffer tiene un tipo de archivo específico
function M.has_filetype(bufnr, filetypes)
  local filetype = vim.bo[bufnr].filetype
  if not filetype or not filetypes then
    return false
  end
  
  if type(filetypes) == "string" then
    return filetype == filetypes
  elseif type(filetypes) == "table" then
    return safe_tbl_contains(filetypes, filetype)
  end
  
  return false
end

return M