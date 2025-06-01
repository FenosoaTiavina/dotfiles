vim.lsp.config['lua_ls'] = require("core.lsp.lua_ls")
vim.lsp.config['gopls'] = require("core.lsp.gopls")
vim.lsp.config['clangd'] = require("core.lsp.clangd")
vim.lsp.config['zls'] = require("core.lsp.zls")

vim.lsp.enable({
  "gopls",
  "zls",
  "lua_ls",
  "clangd",
})


vim.diagnostic.config({
  virtual_lines = true,
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
