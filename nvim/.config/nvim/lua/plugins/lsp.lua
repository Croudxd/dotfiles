return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- This is the modern way to bridge cmp and lspconfig
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      local lspconfig = require("lspconfig")
      
      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
        handlers = {
          -- Default handler for all installed servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- Targeted C++ Accuracy Setup
          ["clangd"] = function()
            lspconfig.clangd.setup({
              capabilities = capabilities,
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
          end,
        },
      })

      -- UI: The "Simple Red Underline" Look
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
