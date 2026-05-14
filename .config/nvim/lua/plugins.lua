-- plugins
vim.pack.add {
    { src = "https://github.com/stevearc/oil.nvim.git" },
    { src = "https://github.com/saghen/blink.cmp",                           data = { event = "InsertEnter" } },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/kevinhwang91/nvim-ufo" },
    { src = "https://github.com/kevinhwang91/promise-async" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/jvgrootveld/telescope-zoxide" },
    { src = "https://github.com/nvim-lua/popup.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",   data = { build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install" } },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/TamaMcGlinn/quickfixdd" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/LunarVim/bigfile.nvim" },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/stevearc/conform.nvim.git" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/pynappo/hyprlang-to-lua.nvim" }
}

-- native plugins
vim.cmd.packadd { "nvim.undotree" }


-- config
require("plugins.oil")
require("plugins.blink-cmp")
require("plugins.undotree")
require("plugins.telescope-nvim")
require("plugins.ufo")
require("plugins.quickfixdd")
require("plugins.ibl")
require("plugins.comment")
require("plugins.big-file")
require("plugins.conform")
require("plugins.autopairs")
require("plugins.surround")
require("plugins.diffview")
require("plugins.gitsigns")
require("plugins.treesitter-manager")
