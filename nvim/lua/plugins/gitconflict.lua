
return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,  -- Create default keymaps
        disable_diagnostics = true, -- Disable LSP diagnostics in conflict regions
        highlights = {
          incoming = "DiffText",
          current = "DiffAdd",
        },
      })
    end,
  },
}
