return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "jdtls" },
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
        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            capabilities = capabilities,
            cmd = {
              "jdtls",
              "--data", vim.fn.expand("~/.cache/jdtls/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
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
