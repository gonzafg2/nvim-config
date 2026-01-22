-- nvim-hlslens: Better search highlighting with lens
-- https://github.com/kevinhwang91/nvim-hlslens
return {
  "kevinhwang91/nvim-hlslens",
  event = "SearchWrapped",
  keys = {
    { "n", mode = "n" },
    { "N", mode = "n" },
    { "*", mode = "n" },
    { "#", mode = "n" },
    { "/", mode = "n" },
    { "?", mode = "n" },
  },
  config = function()
    local hlslens = require("hlslens")
    hlslens.setup({
      calm_down = true,           -- Clear lens when cursor moves away
      nearest_only = false,       -- Show lens for all matches
      nearest_float_when = "auto", -- Float window when no room
    })

    -- Keymaps with hlslens integration
    local kopts = { noremap = true, silent = true }

    vim.keymap.set("n", "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set("n", "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set("n", "*",
      [[*<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set("n", "#",
      [[#<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set("n", "g*",
      [[g*<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set("n", "g#",
      [[g#<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
  end,
}
