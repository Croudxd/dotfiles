return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "",
        section_separators = "",
        -- Default refreshes the whole statusline on every CursorMoved/CursorMovedI
        -- at a 16ms (~60fps) throttle, which recomputes all components (including
        -- git branch) on every single keystroke/cursor move. Drop that trigger and
        -- rely on the timer refresh instead.
        refresh = {
          statusline = 250,
          tabline = 1000,
          winbar = 1000,
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "ModeChanged",
          },
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = {
          function()
            local encoding = vim.o.fileencoding
            if encoding == "" then
              return vim.bo.fileformat .. " :: " .. vim.bo.filetype
            else
              return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
            end
          end,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
