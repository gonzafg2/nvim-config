return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          -- Mostrar sesión actual
          {
            function()
              if vim.v.this_session ~= "" then
                return " " .. vim.fn.fnamemodify(vim.v.this_session, ":t:r")
              end
              return ""
            end,
            color = { fg = "#7aa2f7" },
          },
          -- Mostrar modo de paste
          {
            function()
              if vim.o.paste then
                return "PASTE"
              end
              return ""
            end,
            color = { fg = "#f7768e", gui = "bold" },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            path = 1,
            symbols = { modified = "  ", readonly = "", unnamed = "" },
          },
          -- Mostrar macro recording
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then
                return "Recording @" .. reg
              end
              return ""
            end,
            color = { fg = "#ff9e64", gui = "bold" },
          },
          -- Mostrar searchcount mejorado
          {
            function()
              if vim.v.hlsearch == 0 then
                return ""
              end
              local ok, searchcount = pcall(vim.fn.searchcount)
              if ok and searchcount.total > 0 then
                return string.format(" %d/%d", searchcount.current, searchcount.total)
              end
              return ""
            end,
            color = { fg = "#ff9e64" },
          },
          -- Lazy pending updates
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
          -- Mostrar palabra actual bajo el cursor
          {
            function()
              local word = vim.fn.expand("<cword>")
              if word ~= "" and #word > 2 then
                return "󰊄 " .. word
              end
              return ""
            end,
            color = { fg = "#7aa2f7" },
            cond = function()
              return vim.fn.mode() == "n"
            end,
          },
          -- Mostrar git branch
          {
            "branch",
            icon = "",
            color = { fg = "#98be65", gui = "bold" },
          },
          -- Mostrar diff summary
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_x = {
          -- Mostrar estado de copilot
          {
            function()
              local ok, copilot_client = pcall(function()
                return vim.lsp.get_clients({ name = "copilot", bufnr = 0 })[1]
              end)
              if ok and copilot_client then
                return ""
              else
                return ""
              end
            end,
            color = function()
              local ok, copilot_client = pcall(function()
                return vim.lsp.get_clients({ name = "copilot", bufnr = 0 })[1]
              end)
              if ok and copilot_client then
                return { fg = "#6CC644" }
              else
                return { fg = "#6e6a86" }
              end
            end,
          },
          -- Mostrar encoding y formato de archivo
          {
            "encoding",
            fmt = string.upper,
            color = { fg = "#98be65" },
            cond = function()
              return vim.bo.fileencoding ~= "utf-8"
            end,
          },
          {
            "fileformat",
            symbols = {
              unix = "",
              dos = "",
              mac = "",
            },
            color = { fg = "#51afef" },
            cond = function()
              return vim.bo.fileformat ~= "unix"
            end,
          },
          -- LSP activo
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return ""
              end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            color = { fg = "#e0af68" },
          },
          -- Formatters disponibles
          {
            function()
              local formatters = {}
              local filetype = vim.bo.filetype
              
              -- Formatters comunes por tipo de archivo
              local formatter_map = {
                javascript = { "prettier", "eslint" },
                typescript = { "prettier", "eslint" },
                javascriptreact = { "prettier", "eslint" },
                typescriptreact = { "prettier", "eslint" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
                python = { "black", "ruff" },
                go = { "gofmt", "goimports" },
                rust = { "rustfmt" },
              }
              
              if formatter_map[filetype] then
                return "󰏖 " .. table.concat(formatter_map[filetype], ",")
              end
              
              return ""
            end,
            color = { fg = "#ff9e64" },
            cond = function()
              return vim.bo.filetype ~= ""
            end,
          },
          -- Mostrar estado de formateo (LazyVim)
          {
            function()
              -- Verificar si el autoformat está habilitado
              if vim.g.autoformat then
                return "󰉿 auto"
              else
                return "󰉿 off"
              end
            end,
            color = function()
              if vim.g.autoformat then
                return { fg = "#98be65" }
              else
                return { fg = "#6e6a86" }
              end
            end,
            on_click = function()
              vim.g.autoformat = not vim.g.autoformat
              if vim.g.autoformat then
                vim.notify("Autoformat enabled", vim.log.levels.INFO)
              else
                vim.notify("Autoformat disabled", vim.log.levels.WARN)
              end
            end,
          },
          -- Tamaño del archivo
          {
            function()
              local size = vim.fn.getfsize(vim.fn.expand("%:p"))
              if size < 0 then
                return ""
              elseif size < 1024 then
                return string.format("%dB", size)
              elseif size < 1024 * 1024 then
                return string.format("%.1fK", size / 1024)
              else
                return string.format("%.1fM", size / 1024 / 1024)
              end
            end,
            color = { fg = "#a9a1e1" },
            cond = function()
              return vim.fn.expand("%:p") ~= ""
            end,
          },
        },
        lualine_y = {
          -- Mostrar número total de líneas
          {
            function()
              return " " .. vim.api.nvim_buf_line_count(0)
            end,
            color = { fg = "#7aa2f7" },
          },
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%H:%M:%S")
            end,
            color = { bg = "#61afef", fg = "#000000", gui = "bold" },
          },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
