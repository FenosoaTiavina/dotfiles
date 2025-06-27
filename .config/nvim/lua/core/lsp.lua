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
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})



if vim.g.lspconfig ~= nil then
  return
end
vim.g.lspconfig = 1

local contains = function(array, value)
  for _, v in ipairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

vim.api.nvim_create_user_command('LspStart', function(info)
  local server_name = string.len(info.args) > 0 and info.args or nil
  local configs = vim.lsp._enabled_configs
  if server_name then
    local config = configs[server_name].resolved_config
    if config then
      print("Starting: " .. config.name)
      vim.lsp.start(config, {})
      return
    end
  end

  for _, data in pairs(configs) do
    local config = data.resolved_config

    if config then
      print("Starting: " .. config.name)
      if contains(config.filetypes, vim.bo.filetype) then
        vim.lsp.start(config, {})
      end
    end
  end
end, {
  desc = 'Manually launches a language server',
  nargs = '?',
})

vim.api.nvim_create_user_command('LspInfo', "checkhealth vim.lsp", {})

vim.api.nvim_create_user_command('LspStop', function(info)
  _ = info
  ---@type string
  local clients = {}

  -- default to stopping all servers on current buffer
  clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

  for _, client in ipairs(clients) do
    print("Stopping: " .. client.name)
    vim.lsp.stop_client(client.id)
  end
end, {
  desc = 'Manually stops the given language client(s)',
  nargs = '?',
})
