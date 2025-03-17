return {
  -- "B4mbus/oxocarbon-lua.nvim",
  "nyoom-engineering/oxocarbon.nvim",
  priority = 1000,
  config = function()
    vim.opt.background = "dark" -- set this to dark or light
    vim.g.oxocarbon_lua_keep_terminal = true
    vim.g.oxocarbon_lua_transparent = true
    -- vim.cmd("colorscheme oxocarbon-lua")
    vim.cmd("colorscheme oxocarbon")
    -- local oxocarbon = require('oxocarbon')
  end
}
