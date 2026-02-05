return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    local function set_white_borders()
      local highlights = {
        TelescopeBorder         = { fg = "#ffffff" },
        TelescopePromptBorder   = { fg = "#ffffff" },
        TelescopeResultsBorder  = { fg = "#ffffff" },
        TelescopePreviewBorder  = { fg = "#ffffff" },
        TelescopePromptTitle    = { fg = "#ffffff", bold = true },
        TelescopeResultsTitle   = { fg = "#ffffff", bold = true },
        TelescopePreviewTitle   = { fg = "#ffffff", bold = true },
        TelescopePromptPrefix   = { fg = "#ffffff" },
        TelescopeSelection      = { bg = "#333333", fg = "#ffffff", bold = true },
      }
      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end

    set_white_borders()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        set_white_borders()
      end,
    })

    -- 4. Setup Telescope
    telescope.setup({
      defaults = themes.get_ivy({
        prompt_prefix = " >> ",
        selection_caret = "> ",
        border = true,
        borderchars = {
          prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        layout_config = {
          height = 0.4,
        },
      }),
    })

    -- 5. Keymaps
    vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end,
}
