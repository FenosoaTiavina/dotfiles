require("tree-sitter-manager").setup({
    auto_install = true,
    ensure_installed = {
        "bash",
        "zsh",
        "c",
        "lua",
        "zig",
        "hyprlang",
    },
    parser_dir = vim.fn.stdpath("data") .. "/site/parser",
    query_dir = vim.fn.stdpath("data") .. "/site/queries",
})
