return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
  },
  ---@type YaziConfig
  opts = {
    -- This makes it fill the entire Neovim window
    floating_window_scaling_factor = 1.0, 
    
    -- Optional: set border to 'none' for a true edge-to-edge feel
    yazi_floating_window_border = "none",

    -- Every up/down move in yazi otherwise round-trips a "hover" event back
    -- into Neovim to re-highlight sibling buffers, which is what caused the
    -- j/k lag inside the embedded yazi window.
    highlight_hovered_buffers_in_same_directory = false,
  },
  init = function()
    -- Disables netrw so Yazi takes over directory opening
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
