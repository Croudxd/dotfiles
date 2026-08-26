-- Treesitter drives two things this config cares about:
--   1. Buffer syntax highlighting (better than Vim's regex highlighter).
--   2. LSP hover / signature-help rendering. Neovim's default hover feeds the
--      server's markdown response through treesitter; without the `markdown`
--      and `markdown_inline` parsers installed, `K` shows one flat grey blob.
--      With them, code fences pick up the right language highlighter (Rust
--      snippets in a hover look like Rust, not prose).
--
-- Uses nvim-treesitter's `main` branch. The `master` branch is the classic
-- one but its query predicates call APIs that were removed from Neovim
-- 0.11's built-in treesitter runtime, which produces
-- `attempt to call method 'range' (a nil value)` on every buffer that has
-- language injections (markdown, doc comments, etc.). `main` is now just a
-- parser+query installer that leans on Neovim's built-in
-- `vim.treesitter.start` for highlighting — no shared runtime, nothing to
-- go stale against future Neovim releases.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install({
        "markdown", "markdown_inline",
        "rust", "python", "lua", "cpp", "c",
        "bash", "json", "yaml", "toml",
        "vim", "vimdoc", "query", "diff",
      })

      -- Attach the built-in highlighter to every buffer whose filetype has
      -- a parser installed. pcall keeps unknown filetypes silent instead of
      -- printing an error on every open.
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Start treesitter highlighting when a parser exists",
        group = vim.api.nvim_create_augroup("ts-highlight", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
