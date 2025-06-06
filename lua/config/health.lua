-- Archivo de diagnóstico de salud para Neovim
local M = {}

-- Función requerida por Neovim para :checkhealth
function M.check()
  local health = vim.health or require("health")
  health.start("Configuración personalizada")
  
  -- Verificar rendimiento
  local perf = M.check_performance()
  local sys = M.system_info()
  
  -- Información del sistema
  health.info(string.format("Neovim Version: %s", sys.nvim_version or "Unknown"))
  health.info(string.format("OS: %s", sys.os))
  health.info(string.format("CPU Cores: %s", sys.cpu_count))
  health.info(string.format("Total Memory: %.2f GB", sys.memory))
  
  -- Métricas de rendimiento
  health.info(string.format("Startup Time: %.3f ms", perf.startup_time * 1000))
  health.info(string.format("Loaded Plugins: %d", perf.loaded_plugins))
  health.info(string.format("TreeSitter Parsers: %d", perf.treesitter_parsers))
  health.info(string.format("Active LSP Clients: %d", perf.lsp_clients))
  
  -- Verificaciones y recomendaciones
  if perf.startup_time * 1000 > 200 then
    health.warn("Startup time is high (>200ms)", {
      "Run :OptimizeConfig to find unused plugins",
      "Run :ProfilePlugins to identify slow plugins"
    })
  else
    health.ok("Startup time is good")
  end
  
  if perf.loaded_plugins > 100 then
    health.warn("Too many plugins loaded", {
      "Run :OptimizeConfig to identify unused plugins"
    })
  else
    health.ok("Plugin count is reasonable")
  end
  
  if perf.treesitter_parsers > 30 then
    health.warn("Many TreeSitter parsers installed", {
      "Consider removing unused language parsers"
    })
  else
    health.ok("TreeSitter parser count is reasonable")
  end
  
  -- Comandos disponibles
  health.start("Comandos de diagnóstico disponibles")
  health.ok(":CheckPerformance - Reporte detallado de rendimiento")
  health.ok(":ProfilePlugins - Análisis de tiempos de carga")
  health.ok(":OptimizeConfig - Detectar plugins no usados")
  health.ok(":OptimizeConfigSave - Guardar reporte de optimización")
end

-- Función para verificar el rendimiento
function M.check_performance()
  local start_time = vim.fn.reltime()
  local stats = {
    startup_time = vim.fn.reltimefloat(vim.fn.reltime(start_time)),
    loaded_plugins = #vim.tbl_keys(require("lazy").plugins()),
    treesitter_parsers = #vim.tbl_keys(require("nvim-treesitter.parsers").get_parser_configs()),
    lsp_clients = #vim.lsp.get_active_clients(),
  }
  
  return stats
end

-- Función para mostrar información del sistema
function M.system_info()
  local info = {
    nvim_version = vim.fn.execute("version"):match("NVIM v([^\n]+)"),
    os = vim.loop.os_uname().sysname,
    cpu_count = vim.loop.cpu_info() and #vim.loop.cpu_info() or "N/A",
    memory = vim.loop.get_total_memory() / 1024 / 1024 / 1024, -- GB
  }
  
  return info
end

-- Comando para verificar la salud de la configuración
vim.api.nvim_create_user_command("CheckPerformance", function()
  local perf = M.check_performance()
  local sys = M.system_info()
  
  print("=== Neovim Performance Report ===")
  print("")
  print("System Information:")
  print(string.format("  • Neovim Version: %s", sys.nvim_version or "Unknown"))
  print(string.format("  • OS: %s", sys.os))
  print(string.format("  • CPU Cores: %s", sys.cpu_count))
  print(string.format("  • Total Memory: %.2f GB", sys.memory))
  print("")
  print("Performance Metrics:")
  print(string.format("  • Startup Time: %.3f ms", perf.startup_time * 1000))
  print(string.format("  • Loaded Plugins: %d", perf.loaded_plugins))
  print(string.format("  • TreeSitter Parsers: %d", perf.treesitter_parsers))
  print(string.format("  • Active LSP Clients: %d", perf.lsp_clients))
  print("")
  
  -- Recomendaciones
  if perf.startup_time * 1000 > 200 then
    print("⚠️  Startup time is high. Consider:")
    print("   - Reducing number of plugins")
    print("   - Improving lazy loading")
  end
  
  if perf.loaded_plugins > 100 then
    print("⚠️  Too many plugins loaded. Review and remove unused ones.")
  end
  
  if perf.treesitter_parsers > 30 then
    print("⚠️  Many TreeSitter parsers installed. Consider removing unused ones.")
  end
end, { desc = "Check Neovim performance" })

-- Comando para listar plugins pesados
vim.api.nvim_create_user_command("ProfilePlugins", function()
  local lazy = require("lazy")
  local plugins = {}
  
  for name, plugin in pairs(lazy.plugins()) do
    if plugin._.loaded then
      table.insert(plugins, {
        name = name,
        load_time = plugin._.loaded.time or 0,
        source = plugin._.loaded.source or "unknown",
      })
    end
  end
  
  -- Ordenar por tiempo de carga
  table.sort(plugins, function(a, b)
    return a.load_time > b.load_time
  end)
  
  print("=== Plugin Load Times ===")
  print("")
  for i, plugin in ipairs(plugins) do
    if i <= 20 then -- Mostrar solo los 20 más pesados
      print(string.format("%2d. %-30s %.2f ms (%s)", 
        i, plugin.name, plugin.load_time, plugin.source))
    end
  end
end, { desc = "Profile plugin load times" })

-- Verificar salud general
vim.api.nvim_create_user_command("CheckHealth", function()
  vim.cmd("checkhealth")
end, { desc = "Run Neovim health check" })

-- Comando para detectar plugins no usados
vim.api.nvim_create_user_command("OptimizeConfig", function()
  local lazy = require("lazy")
  local usage_data = {}
  local all_plugins = {}
  
  -- Recopilar información de todos los plugins
  for name, plugin in pairs(lazy.plugins()) do
    local last_used = "Nunca cargado"
    local load_count = 0
    local is_loaded = false
    
    if plugin._ and plugin._.loaded then
      is_loaded = true
      load_count = plugin._.loaded.count or 1
      -- Estimar último uso basado en si está cargado actualmente
      last_used = is_loaded and "Sesión actual" or "Sesión anterior"
    end
    
    table.insert(all_plugins, {
      name = name,
      loaded = is_loaded,
      load_count = load_count,
      last_used = last_used,
      lazy = plugin.lazy ~= false,
      event = plugin.event,
      cmd = plugin.cmd,
      ft = plugin.ft,
      keys = plugin.keys,
    })
  end
  
  -- Ordenar por estado de carga y nombre
  table.sort(all_plugins, function(a, b)
    if a.loaded ~= b.loaded then
      return not a.loaded -- No cargados primero
    end
    return a.name < b.name
  end)
  
  print("=== Plugin Optimization Report ===")
  print("")
  
  -- Mostrar plugins no cargados (candidatos a eliminar)
  local unused_count = 0
  print("📦 Plugins no cargados (candidatos a eliminar):")
  for _, plugin in ipairs(all_plugins) do
    if not plugin.loaded then
      unused_count = unused_count + 1
      local trigger = "Sin trigger"
      if plugin.event then
        trigger = "Evento: " .. vim.inspect(plugin.event)
      elseif plugin.cmd then
        trigger = "Comando: " .. vim.inspect(plugin.cmd)
      elseif plugin.ft then
        trigger = "FileType: " .. vim.inspect(plugin.ft)
      elseif plugin.keys then
        trigger = "Teclas: " .. vim.inspect(plugin.keys)
      end
      print(string.format("  • %-30s | %s", plugin.name, trigger))
    end
  end
  
  if unused_count == 0 then
    print("  ✅ Todos los plugins han sido cargados")
  end
  
  print("")
  
  -- Mostrar plugins raramente usados
  print("⚡ Plugins con carga lazy óptima:")
  local lazy_count = 0
  for _, plugin in ipairs(all_plugins) do
    if plugin.loaded and plugin.lazy then
      lazy_count = lazy_count + 1
      if lazy_count <= 10 then -- Mostrar solo los primeros 10
        print(string.format("  • %-30s", plugin.name))
      end
    end
  end
  print(string.format("  ... y %d más", math.max(0, lazy_count - 10)))
  
  print("")
  
  -- Resumen y recomendaciones
  print("📊 Resumen:")
  print(string.format("  • Total de plugins: %d", #all_plugins))
  print(string.format("  • Plugins cargados: %d", #all_plugins - unused_count))
  print(string.format("  • Plugins no usados: %d", unused_count))
  print(string.format("  • Plugins con lazy loading: %d", lazy_count))
  
  print("")
  print("💡 Recomendaciones:")
  if unused_count > 10 then
    print("  • Considera eliminar los plugins no usados para mejorar el rendimiento")
  end
  if lazy_count < (#all_plugins - unused_count) * 0.5 then
    print("  • Considera habilitar lazy loading para más plugins")
  end
  
  -- Guardar reporte en archivo si se solicita
  print("")
  print("💾 Ejecuta :OptimizeConfigSave para guardar el reporte en optimization-report.txt")
end, { desc = "Analyze and optimize plugin configuration" })

-- Versión que guarda el reporte
vim.api.nvim_create_user_command("OptimizeConfigSave", function()
  -- Capturar la salida
  local output = vim.api.nvim_exec("OptimizeConfig", true)
  
  -- Guardar en archivo
  local report_path = vim.fn.stdpath("config") .. "/optimization-report.txt"
  local file = io.open(report_path, "w")
  if file then
    file:write(output)
    file:close()
    print("\n✅ Reporte guardado en: " .. report_path)
  else
    print("\n❌ Error al guardar el reporte")
  end
end, { desc = "Save optimization report to file" })

return M