-- Server configuration for the four languages this machine actually develops
-- in: C++, Python, Rust and Lua.
--
-- Uses the Neovim 0.11+/0.12 native `vim.lsp.config` / `vim.lsp.enable` API.
-- The previous version drove everything through mason-lspconfig's `handlers`
-- table, which was removed in mason-lspconfig 2.x, so none of those handlers
-- had been running at all. Mason has since been dropped entirely; see the
-- note above vim.lsp.enable below.
--
-- To add a language server: install the binary with the system package
-- manager, then add its lspconfig name to the vim.lsp.enable list.
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

      -- C++ — clangd is resolved from PATH, so it works wherever the package
      -- is declared (pacman: clang / nixpkgs: clang-tools). No absolute path
      -- on purpose: hardcoding /usr/... would break on NixOS.
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

      -- Every server is a binary supplied by the system, not by Mason. Mason
      -- downloaded prebuilt FHS binaries (its rust-analyzer asks for
      -- /lib64/ld-linux-x86-64.so.2), which is exactly what does not exist on
      -- NixOS, so this list is the portable form: the names never change, only
      -- how the binary is declared. `pacman -S x` today becomes an entry in
      -- home.packages / environment.systemPackages later.
      vim.lsp.enable({
        "clangd",         -- pacman: clang
        "lua_ls",         -- pacman: lua-language-server
        "rust_analyzer",  -- rustup (also pacman: rust-analyzer)
        "basedpyright",   -- uv tool install
        "ruff",           -- uv tool install
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
