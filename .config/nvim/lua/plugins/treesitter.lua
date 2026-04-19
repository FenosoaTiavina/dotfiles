-- Code Tree Support / Syntax Highlighting
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
