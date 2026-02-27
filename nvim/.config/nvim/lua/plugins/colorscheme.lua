return {
-- {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- 1. Call setup FIRST with transparency tweaks
--         require("lackluster").setup({
--             tweak_background = {
--                 normal = "none",     -- Main editor background
--                 telescope = "none",  -- Telescope background
--                 menu = "none",       -- nvim-cmp/completion menu
--                 popup = "none",      -- Lazy/Mason popups
--             },
--         })
--
--         -- 2. Then apply the colorscheme
--         vim.cmd.colorscheme("lackluster")
--         -- vim.cmd.colorscheme("lackluster-hack")
--     end,
-- }
-- {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     init = function()
--         vim.cmd.colorscheme("lackluster")
--         -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--     end,
-- }
-- {
--   "wnkz/monoglow.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--     init = function()
--         -- vim.cmd.colorscheme("monoglow")
--         -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--     end,
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
  {

    "RRethy/nvim-base16",

    lazy = false,

    priority = 1000,

    config = function()

      -- Apply the Gorgoroth variant

      vim.cmd('colorscheme base16-black-metal-gorgoroth')



      -- TINKER: Make the UI even cleaner for this theme

      vim.api.nvim_set_hl(0, "LineNr", { fg = "#444444" })               -- Muted line numbers

      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#222222", bg = "NONE" }) -- Darker splits

      end
  },

}
