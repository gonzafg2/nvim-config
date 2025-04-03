return {
  "karb94/neoscroll.nvim",
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
    
    -- Mapeos personalizados para neoscroll
    local t = {}
    t["<C-u>"] = {"scroll", {-10, "false", "100", nil}}
    t["<C-d>"] = {"scroll", {10, "false", "100", nil}}
    t["<C-b>"] = {"scroll", {-vim.api.nvim_win_get_height(0), "false", "250", "cubic"}}
    t["<C-f>"] = {"scroll", {vim.api.nvim_win_get_height(0), "false", "250", "cubic"}}
    t["zt"] = {"zt", {"200"}}
    t["zz"] = {"zz", {"200"}}
    t["zb"] = {"zb", {"200"}}
    
    require("neoscroll.config").set_mappings(t)
  end,
}
