vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
vim.opt.numberwidth = 2
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = false
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Remote-plugin providers. Nothing in this config is a Python/Ruby/Perl/Node
-- *remote plugin*, so these only ever surface as :checkhealth warnings about
-- missing pynvim / gems / npm packages. Disabling them is unrelated to running
-- Node- or Python-based language servers, which don't use this mechanism.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

for _, d in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('t', '<C-' .. d .. '>', '<C-\\><C-n><C-w>' .. d, { desc = 'Move focus out of terminal' })
end

vim.keymap.set("n", "<C-f>", "<C-u>zz", { desc = "Scroll half-page UP and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page DOWN and center" })

vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })

vim.keymap.set("n", "<leader>bd", function()
    require('mini.bufremove').delete(0, true)
    vim.cmd('bnext')
end, { desc = "Delete buffer and move to the next" })

vim.keymap.set('n', '<leader>c', ':cd ~/.config/nvim<CR>:e .<CR>', { silent = true, desc = "Open nvim config" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- `:colorscheme` runs `hi clear`, which wipes any highlight set before it.
-- These used to be assigned at the top of init.lua, so lazy.nvim loading the
-- colorscheme below silently discarded them. Re-apply on every ColorScheme.
vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Re-apply diagnostic highlight overrides after a colorscheme loads',
    group = vim.api.nvim_create_augroup('diagnostic-hl', { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b", italic = true })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e0af68", italic = true })
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)
vim.lsp.log.set_level(vim.log.levels.ERROR)

require("lazy").setup("plugins", {
    -- No plugin in this config needs luarocks. Without this, lazy.nvim tries to
    -- bootstrap hererocks + Lua 5.1 and :checkhealth reports it as an error.
    rocks = { enabled = false },
})
