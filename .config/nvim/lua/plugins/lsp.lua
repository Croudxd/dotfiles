-- Server configuration for the four languages this machine actually develops
-- in: C++, Python, Rust and Lua.
--
-- Uses the Neovim 0.11+/0.12 native `vim.lsp.config` / `vim.lsp.enable` API.
-- The previous version drove everything through mason-lspconfig's `handlers`
-- table, which was removed in mason-lspconfig 2.x, so none of those handlers
-- had been running at all.
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      -- Advertise blink.cmp's completion capabilities to every server. The old
      -- config passed `capabilities = capabilities`, referring to a global that
      -- was never defined, so every server silently received nil.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
      })

      -- C++ — clangd is a distro package here (/usr/sbin/clangd), no Mason
      -- install and no extra toolchain needed beyond the gcc/gdb already present.
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      })

      -- Lua — installed by Mason (single self-contained binary, no runtime).
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })

      -- Python — basedpyright owns types/navigation, ruff owns lint+format.
      -- Both come from `uv tool install`, so no pip and no system Node.
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        on_attach = function(client)
          -- basedpyright already provides hover; ruff's is much thinner and
          -- the two otherwise fight over the same position.
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- Rust — rust_analyzer comes from rustup, defaults are fine.
      vim.lsp.enable({
        "clangd",
        "lua_ls",
        "rust_analyzer",
        "basedpyright",
        "ruff",
      })

      vim.diagnostic.config({
        virtual_text = {
          prefix = "-",
          spacing = 4,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
