-- Configuración de DAP sin JavaScript/TypeScript

return {
  -- Desactivar mason-nvim-dap que viene con los extras de DAP
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  
  -- Configurar DAP para otros lenguajes (sin JavaScript)
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Set Conditional Breakpoint" },
    },
    config = function()
      local dap = require("dap")
      
      -- Aquí puedes agregar configuraciones para otros lenguajes como Python, Go, etc.
      -- Por ejemplo, para Python:
      -- dap.adapters.python = {
      --   type = "executable",
      --   command = "python",
      --   args = { "-m", "debugpy.adapter" },
      -- }
    end,
  },
  
  -- UI para DAP
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    config = true,
  },
  
  -- Virtual text para DAP
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = true,
  },
}