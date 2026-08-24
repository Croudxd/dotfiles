return {
  {
    "saghen/blink.cmp",
    version = "*", -- Use a release tag to download pre-built binaries
    dependencies = {
      {
        -- Builds the jsregexp native module, which LuaSnip needs for
        -- variable/placeholder transformations in LSP snippets. Compiles with
        -- the gcc + lua headers already on this machine; no new packages.
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for 4 rows, 'super-tab' for 2 rows (Tab to accept)
      keymap = { 
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true, -- Fallback highlight groups to nvim-cmp
        nerd_font_variant = 'mono'
      },

      -- Set up your snippets engine
      snippets = {
        preset = 'luasnip'
      },

      -- Default list of enabled providers
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      
      -- Experimental signature help (Crucial for C++ Quant Dev!)
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
}
