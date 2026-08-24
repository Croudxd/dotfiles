return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
    },
    diff_opts = {
      layout = "vertical",
      open_in_new_tab = false,
      hide_terminal_in_new_tab = false,
      on_new_file_reject = "close_window",
    },
  },
  cmd = {
    "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeStatus",
    "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny", "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ax", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
  },
}
