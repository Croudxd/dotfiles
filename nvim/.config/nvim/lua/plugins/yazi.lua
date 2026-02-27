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
    
  },
  init = function()
    -- Disables netrw so Yazi takes over directory opening
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
