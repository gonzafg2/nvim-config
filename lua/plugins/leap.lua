-- Override LazyVim's leap config to fix deprecation warning
-- Using Sneak-style mappings (see :help leap-mappings)
return {
  url = "https://codeberg.org/andyg/leap.nvim",
  keys = {
    { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
    { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
  },
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end

    -- Opciones para mejor experiencia visual
    leap.opts.highlight_unlabeled_phase_one_targets = true  -- Resaltar coincidencias inmediatamente
    leap.opts.safe_labels = {}  -- Forzar mostrar etiquetas siempre (no auto-jump)

    -- Colores más visibles para las etiquetas
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })  -- Atenuar fondo
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#ffffff", bg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "LeapLabel", { fg = "#000000", bg = "#00ff87", bold = true })

    -- Sneak-style mappings (no deprecated functions)
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
  end,
}
