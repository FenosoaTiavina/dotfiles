-- Code Tree Support / Syntax Highlighting
vim.pack.add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
}

require 'nvim-treesitter'.setup {
    highlight = {
        enable = true,
    },
    indent = { enable = true },
    auto_install = true,
    ensure_installed = {
        'lua',
        'c',
        'cpp',
        'go',
        'zig',
    },
}
