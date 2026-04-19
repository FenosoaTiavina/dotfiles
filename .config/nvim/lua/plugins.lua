-- plugins
vim.pack.add {
    "https://github.com/stevearc/oil.nvim.git",
    "https://github.com/saghen/blink.cmp",
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/kevinhwang91/nvim-ufo',
    'https://github.com/kevinhwang91/promise-async',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/jvgrootveld/telescope-zoxide',
    'https://github.com/nvim-lua/popup.nvim',
    'https://github.com/jvgrootveld/telescope-zoxide',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    "https://github.com/folke/snacks.nvim",
    'https://github.com/TamaMcGlinn/quickfixdd',
    'https://github.com/numToStr/Comment.nvim',
    "https://github.com/LunarVim/bigfile.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/stevearc/conform.nvim.git",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/windwp/nvim-autopairs",
    'https://github.com/sindrets/diffview.nvim',
    "https://github.com/lewis6991/gitsigns.nvim",
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
require("plugins.treesitter")
require("plugins.ibl")
require("plugins.comment")
require("plugins.big-file")
require("plugins.conform")
require("plugins.autopairs")
require("plugins.surround")
require("plugins.diffview")
require("plugins.gitsigns")
