return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
    { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open yazi in cwd" },
    { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume yazi" },
  },
  ---@type YaziConfig
  opts = {
opts = {
},
    future_features = {
      -- This helps with cleaner transitions
      nvim_0_10_display_help_in_yazi = true,
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
