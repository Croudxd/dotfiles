return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      -- This makes "fzy" match "fuzzy"
      mode = "fuzzy",
      ignorecase = true,
    },
    modes = {
      -- This ensures that when you use Flash as an operator (like after 'y')
      -- it behaves exactly like the jump mode
      char = {
      enabled = true,
      jump_labels = true,
      multi_line = true,
      },
      remote = {
        enabled = true,
      }
    }
  },
  keys = {
    -- 1. Normal Jump: Press Enter, type 'fzy', see labels, press label to jump
    { "<CR>", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash Jump" },

    -- 2. Remote Operator: Press 'yi', then 'Enter', type 'fzy', press label to yank
    -- This specific 'o' mode mapping enables the "yank from a distance" behavior
    { "<CR>", mode = { "o" }, function() require("flash").remote() end, desc = "Remote Flash" },
    { "<S-CR>", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
