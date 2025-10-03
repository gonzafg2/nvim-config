return {
  "kndndrj/nvim-dbee",
  cmd = "Dbee", -- Lazy load on command
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Use curl for reliable installation
    require("dbee").install("curl")
  end,
  keys = {
    { "<leader>db", "<cmd>Dbee<cr>", desc = "Open Database UI" },
    { "<leader>dt", "<cmd>Dbee toggle<cr>", desc = "Toggle Database UI" },
  },
  config = function()
    require("dbee").setup({
      -- Sources for database connections
      sources = {
        -- File source for persistent connections
        require("dbee.sources").FileSource:new(vim.fn.stdpath("data") .. "/dbee/connections.json"),
        -- Environment variable source for secure credentials
        require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
        -- Example connections (remove or modify as needed)
        require("dbee.sources").MemorySource:new({
          {
            name = "SQLite Example",
            type = "sqlite",
            url = vim.fn.stdpath("data") .. "/dbee/example.db",
          },
        }),
      },

      -- Lazy loading and performance
      lazy = true,

      -- Default connection (optional)
      default_connection = nil,

      -- UI Configuration
      drawer = {
        disable_help = false,
        mappings = {
          -- Tree navigation
          { key = "o", mode = "n", action = "toggle_node" },
          { key = "<cr>", mode = "n", action = "action_node" },
          { key = "r", mode = "n", action = "refresh_node" },
          -- Connection management
          { key = "cw", mode = "n", action = "edit_connection" },
          { key = "dd", mode = "n", action = "delete_connection" },
          -- Scratchpad management
          { key = "<c-n>", mode = "n", action = "new_scratchpad" },
        },
      },

      -- Editor configuration for SQL scratchpads
      editor = {
        mappings = {
          -- Execute queries
          { key = "BB", mode = "n", action = "run_file" },
          { key = "BB", mode = "v", action = "run_selection" },
          -- Save/load scratchpads
          { key = "<leader>w", mode = "n", action = "save_scratchpad" },
        },
      },

      -- Result buffer configuration
      result = {
        progress = {
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          text = "Executing query...",
        },
        mappings = {
          -- Navigation
          { key = "L", mode = "n", action = "page_next" },
          { key = "H", mode = "n", action = "page_prev" },
          { key = "E", mode = "n", action = "page_last" },
          { key = "F", mode = "n", action = "page_first" },
          -- Yanking results
          { key = "yaj", mode = "n", action = "yank_current_json" },
          { key = "yac", mode = "n", action = "yank_current_csv" },
          { key = "yaJ", mode = "n", action = "yank_all_json" },
          { key = "yaC", mode = "n", action = "yank_all_csv" },
        },
      },

      -- UI Layout
      window_layout = require("dbee.layouts").Default:new({
        drawer = { size = 0.3, position = "left" },
        editor = { size = 0.6, position = "top" },
        result = { size = 0.4, position = "bottom" },
      }),

      -- Connection options
      connection_timeout = 5000, -- 5 seconds

      -- Result options
      result_page_size = 100,

      -- Call log (for debugging)
      call_log = {
        enabled = false,
        level = vim.log.levels.INFO,
      },
    })

    -- Create data directory if it doesn't exist
    local data_path = vim.fn.stdpath("data") .. "/dbee"
    if vim.fn.isdirectory(data_path) == 0 then
      vim.fn.mkdir(data_path, "p")
    end
  end,
}
