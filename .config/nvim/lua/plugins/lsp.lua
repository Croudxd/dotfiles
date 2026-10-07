-- Server configuration for the four languages this machine actually develops
-- in: C++, Python, Rust and Lua.
--
-- Uses the Neovim 0.11+/0.12 native `vim.lsp.config` / `vim.lsp.enable` API.
--
-- To add a language server:
--   1. Install the binary using the system/toolchain package manager.
--   2. Add its lspconfig name to the vim.lsp.enable list below.
--
-- Mason is intentionally not used for LSP binaries here. This keeps the
-- configuration portable between normal Linux distributions and NixOS.
return {
  {
    "neovim/nvim-lspconfig",

    event = {
      "BufReadPre",
      "BufNewFile",
    },

    dependencies = {
      "saghen/blink.cmp",
    },

    config = function()
      ------------------------------------------------------------------------
      -- Global LSP configuration
      ------------------------------------------------------------------------

      -- Advertise blink.cmp's completion capabilities to every language
      -- server.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
      })

      ------------------------------------------------------------------------
      -- C++
      ------------------------------------------------------------------------

      -- clangd is resolved from PATH.
      --
      -- This deliberately avoids hard-coded paths so the same configuration
      -- works whether clangd comes from pacman, apt, nixpkgs, etc.
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

      ------------------------------------------------------------------------
      -- Lua
      ------------------------------------------------------------------------

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },

            workspace = {
              checkThirdParty = false,
            },

            diagnostics = {
              globals = {
                "vim",
              },
            },

            telemetry = {
              enable = false,
            },
          },
        },
      })

      ------------------------------------------------------------------------
      -- Python
      ------------------------------------------------------------------------

      -- basedpyright owns type checking, completion, hover and navigation.
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",

              -- Only analyse files currently open in the editor instead of
              -- eagerly reporting diagnostics for the whole project.
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- Ruff owns linting/formatting.
      vim.lsp.config("ruff", {
        on_attach = function(client)
          -- basedpyright already provides proper Python hover information.
          -- Disable Ruff's hover provider so the two servers do not compete
          -- for the same request.
          client.server_capabilities.hoverProvider = false
        end,
      })

      ------------------------------------------------------------------------
      -- Rust
      ------------------------------------------------------------------------

      -- rust-analyzer is resolved through PATH/rustup.
      --
      -- The workspace toolchain is expected to be on a current stable Rust
      -- release, so rust-analyzer and the compiler stay aligned.
      --
      -- Required components:
      --
      --   rustup component add rust-analyzer rust-src
      --
      vim.lsp.config("rust_analyzer", {
        cmd = {
          "rust-analyzer",
        },

        settings = {
          ["rust-analyzer"] = {
            assist = {
              -- The term-search quick fix panics during diagnostics in both
              -- Rust 1.95 and 1.99 on etrading sources. Keep other diagnostics.
              termSearch = { fuel = 0 },
            },

            ----------------------------------------------------------------
            -- Cargo/project loading
            ----------------------------------------------------------------

            cargo = {
              -- Avoid loading/checking tests, examples and benches unless
              -- they are actually needed.
              allTargets = false,

              -- Give rust-analyzer its own Cargo target directory.
              --
              -- This intentionally trades extra disk usage for better
              -- isolation and cache reuse. RA's Cargo processes do not fight
              -- normal `cargo build`, `cargo test`, etc. over the same target
              -- directory or build lock.
              targetDir = true,
            },

            ----------------------------------------------------------------
            -- Background compiler checking
            ----------------------------------------------------------------

            check = {
              -- Avoid checking the entire Cargo workspace on every change.
              --
              -- Where possible, only the package containing the changed file
              -- is checked.
              workspace = false,

              -- Do not pass --all-targets to background checks.
              allTargets = false,
            },

            ----------------------------------------------------------------
            -- Startup/cache behaviour
            ----------------------------------------------------------------

            cachePriming = {
              -- Warm rust-analyzer's internal caches when the workspace opens.
              --
              -- Startup uses more CPU, but navigation, hover and completion
              -- should be much faster once the initial warm-up is complete.
              enable = true,

              -- Use physical CPU cores for cache priming rather than every
              -- logical thread.
              numThreads = "physical",
            },

            ----------------------------------------------------------------
            -- Stability
            ----------------------------------------------------------------

            completion = {
              termSearch = {
                -- Disable term search because this code path was involved in
                -- the rust-analyzer worker panics seen on the older toolchain.
                --
                -- Normal completion, hover, goto-definition and references
                -- still work.
                enable = false,
              },
            },
          },
        },
      })

      ------------------------------------------------------------------------
      -- Enable language servers
      ------------------------------------------------------------------------

      -- Every name here is the normal nvim-lspconfig server name.
      --
      -- The binaries themselves are resolved through PATH/toolchain
      -- management rather than downloaded by Mason.
      vim.lsp.enable({
        "clangd",
        "lua_ls",
        "rust_analyzer",
        "basedpyright",
        "ruff",
      })

      ------------------------------------------------------------------------
      -- Diagnostics
      ------------------------------------------------------------------------

      vim.diagnostic.config({
        virtual_text = {
          prefix = "-",
          spacing = 4,
        },

        underline = true,

        -- Don't constantly redraw diagnostics while actively typing.
        update_in_insert = false,

        severity_sort = true,
      })
    end,
  },
}
