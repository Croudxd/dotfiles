return
{
  "dnlhc/glance.nvim",
  config = function()
    require("glance").setup({
      -- your configuration
    })
    vim.keymap.set("n", "gK", "<cmd>Glance definitions<cr>") -- I use gK for this
  end,
}
