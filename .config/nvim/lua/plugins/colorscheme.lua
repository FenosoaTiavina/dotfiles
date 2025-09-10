return {
    dir = "~/dotfiles/.config/nvim/local/oxocarbon",
    priority = 1000,
    config = function()
        vim.opt.background = "dark" -- set this to dark or light
        vim.g.oxocarbon_lua_keep_terminal = true
        vim.g.oxocarbon_lua_transparent = true
        vim.g.oxocarbon_lua_alternative_telescope = false
        vim.cmd("colorscheme oxocarbon-lua")
    end
}
