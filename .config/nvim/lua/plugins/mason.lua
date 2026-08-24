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
      -- ADD NEW LANGUAGE SERVERS HERE. One line is all it takes: Mason
      -- installs it and `automatic_enable` below turns it on. Names are the
      -- lspconfig ones (`:Mason` lists them, or `:h lspconfig-all`).
      --
      -- Not listed here on purpose: clangd, rust_analyzer, ruff and
      -- basedpyright. Those already exist outside Mason (pacman, rustup and
      -- `uv tool install`) and are enabled in lsp.lua, so letting Mason also
      -- install them would just mean two copies to keep updated.
      ensure_installed = {
        "lua_ls",
      },

      -- Anything Mason installs gets enabled automatically, so adding a name
      -- above is genuinely the only step.
      automatic_enable = true,
    },
  },
}
