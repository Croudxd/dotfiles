
return
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true, -- show git blame on current line
        current_line_blame_opts = { delay = 1000 },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
          vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous Hunk" })
          -- Actions
          vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
          vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })
        end,
      })
    end,
  }
