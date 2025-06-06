return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup({
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      duration_multiplier = 0.8, -- Slightly faster scrolling
      easing = "cubic", -- Smooth cubic easing
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
      ignored_events = { -- Events ignored while scrolling
        "WinScrolled",
        "CursorMoved",
      },
    })
    
    -- Mapeos personalizados para neoscroll usando las funciones helper
    local neoscroll = require('neoscroll')
    local keymap = {
      -- Usar C-y y C-e para evitar conflicto con keymaps.lua
      ["<C-y>"] = function() neoscroll.scroll(-10, false, 100) end,
      ["<C-e>"] = function() neoscroll.scroll(10, false, 100) end,
      ["<C-b>"] = function() neoscroll.scroll(-vim.api.nvim_win_get_height(0), false, 250, "cubic") end,
      ["<C-f>"] = function() neoscroll.scroll(vim.api.nvim_win_get_height(0), false, 250, "cubic") end,
      ["zt"] = function() neoscroll.zt(200) end,
      ["zz"] = function() neoscroll.zz(200) end,
      ["zb"] = function() neoscroll.zb(200) end,
    }
    
    local modes = { 'n', 'v' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
