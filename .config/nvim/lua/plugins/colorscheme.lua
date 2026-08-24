-- Active theme: base16 black-metal-gorgoroth.
--
-- Previous experiments (tokyonight, lackluster, carbonfox, ...) lived here as
-- large commented-out blocks. They're in git history if any of them is wanted
-- back; dropping them lets `:Lazy clean` remove the orphaned plugin installs.
return {
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme base16-black-metal-gorgoroth")

      -- Quieten the UI chrome for this theme.
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#444444" })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#222222", bg = "NONE" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#3a3d41", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#858585" })
    end,
  },
}
