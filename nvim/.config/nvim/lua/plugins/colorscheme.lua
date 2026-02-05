return {
{
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("lackluster")
        -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
        -- vim.cmd.colorscheme("lackluster-mint")
    end,
}
-- {
--   "wnkz/monoglow.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }
  -- "EdenEast/nightfox.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   require("nightfox").setup({
  --     options = {
  --       style = "carbonfox", -- The professional engineering look
  --       transparent = false, 
  --       terminal_colors = true,
  --     }
  --   })
  --   vim.cmd("colorscheme carbonfox")
  -- end,
  -- Base16 plugin to handle the Black Metal Gorgoroth theme
  -- {
  --   "RRethy/nvim-base16",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Apply the Gorgoroth variant
  --     vim.cmd('colorscheme base16-black-metal-gorgoroth')
  --
  --     -- TINKER: Make the UI even cleaner for this theme
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" }) -- Transparent bg
  --     vim.api.nvim_set_hl(0, "LineNr", { fg = "#444444" })               -- Muted line numbers
  --     vim.api.nvim_set_hl(0, "VertSplit", { fg = "#222222", bg = "NONE" }) -- Darker splits
  --   end
  -- },
  --
  -- {
  --   "echasnovski/mini.indentscope",
  --   opts = {
  --     symbol = "│", -- Solid line
  --     draw = { animation = function() return 1 end }, -- Instant/Fast animation
  --   },
  --   config = function(_, opts)
  --     require("mini.indentscope").setup(opts)
  --     -- Make the animated line a cold grey to match the theme
  --     vim.api.nvim_set_hl(0, "MiniIndentScopeSymbol", { fg = "#999999" })
  --   end
  -- }
}
