return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "bashls",
        "gopls",
        "jdtls",
        "pyright",
        "tinymist",
    },
        handlers = {
            tinymist = function()
                require("lspconfig").tinymist.setup({
                    filetypes = { "typst" },
                })
            end,
        },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
