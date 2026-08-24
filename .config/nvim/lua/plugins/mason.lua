return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- clangd, rust-analyzer, ruff and basedpyright all exist outside Mason
      -- already (distro packages, rustup, and `uv tool install`), so Mason only
      -- has to supply lua_ls. Keeping the list this short also avoids Mason
      -- trying to install anything that needs npm/pip/go, none of which are
      -- present on this machine.
      ensure_installed = { "lua_ls" },

      -- Servers are enabled explicitly in lsp.lua instead. With the default
      -- (`true`) mason-lspconfig enables *every* server it finds installed,
      -- which meant a leftover jdtls package started a Java server on a machine
      -- with no JDK.
      automatic_enable = false,
    },
  },
}
