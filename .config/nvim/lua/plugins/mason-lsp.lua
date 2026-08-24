return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
    ensure_installed = {
        "rust_analyzer",
        -- "clojure_lsp",
    }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
