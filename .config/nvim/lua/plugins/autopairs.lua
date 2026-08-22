return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,      -- integrate with Treesitter
        enable_check_bracket_line = false,
        map_cr = true,        -- auto insert newline on <CR>
        map_bs = true,        -- auto delete brackets
      })
    end,
  },
}
