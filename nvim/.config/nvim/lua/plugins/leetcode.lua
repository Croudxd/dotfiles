return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",

    dependencies = {
        "nvim-telescope/telescope.nvim",
        "muniftanjim/nui.nvim",
        -- Optional dependencies
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
    lang = "cpp",
    storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
    },
    injector = {
        ["cpp"] = {
            before = {
                "#include <vector>",
                "#include <string>",
                "#include <algorithm>",
                "using namespace std;",
            },
        },

    },
    }
}



