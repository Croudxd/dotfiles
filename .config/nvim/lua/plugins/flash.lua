return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      -- This makes "fzy" match "fuzzy" globally for Flash
      mode = "fuzzy",
      ignorecase = true,
    },
    modes = {
      char = {
        enabled = true,
        jump_labels = true,
        multi_line = true,
      },
      remote = {
        enabled = true,
      },
      -- NEW: This turns Neovim's native / and ? into a Flash fuzzy search
      search = {
        enabled = true,
      }
    }
  },
  keys = {
    -- 1. Normal Jump (Viewport restricted, fast)
    { "<CR>", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash Jump" },

    -- 2. Remote Operator
    { "<CR>", mode = { "o" }, function() require("flash").remote() end, desc = "Remote Flash" },
    { "<S-CR>", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
