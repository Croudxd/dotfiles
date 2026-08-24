-- Merge conflicts are handled by diffview rather than git-conflict.nvim, which
-- was removed: it reads `vim.highlight.priorities` at module load and calls the
-- old `vim.validate{table}` form, both deprecated, and both still present on
-- its upstream default branch with no release that fixes them.
--
-- During a merge, `<leader>gd` (:DiffviewOpen) opens a 3-way conflict view.
-- Inside it diffview already binds, per hunk:
--   <leader>co / ct / cb / ca   choose ours / theirs / base / all
--   <leader>cO / cT / cB / cA   same, for the whole file
--   dx / dX                     delete the conflict region / all of them
--   ]x / [x                     next / previous conflict
return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gb", "<cmd>DiffviewOpen main...HEAD<cr>", desc = "Diff branch" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- on_attach is called by gitsigns once per buffer. Everything that
      -- needs `bufnr` must live INSIDE this function.
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
        end

        map("]c", function() gs.nav_hunk("next") end, "Next hunk")
        map("[c", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hs", gs.stage_hunk, "Stage hunk")
        map("<leader>hr", gs.reset_hunk, "Reset hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("<leader>hq", function() gs.setqflist("all") end, "Hunks to quickfix")
      end,
    },
  },
}
