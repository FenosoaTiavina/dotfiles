vim.lsp.config['lua_ls']        = require("core.lsp.lua_ls")
vim.lsp.config['gopls']         = require("core.lsp.gopls")
vim.lsp.config['clangd']        = require("core.lsp.clangd")
vim.lsp.config['zls']           = require("core.lsp.zls")
vim.lsp.config['pylsp']         = require("core.lsp.pylsp")
vim.lsp.config['glsl_analyzer'] = require("core.lsp.glsl_analyzer")


vim.lsp.enable({
  "gopls",
  "zls",
  "lua_ls",
  "clangd",
  "pylsp",
  "glsl_analyzer"
})


-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
  if not client_notifs[client_id] then
    client_notifs[client_id] = {}
  end

  if not client_notifs[client_id][token] then
    client_notifs[client_id][token] = {}
  end

  return client_notifs[client_id][token]
end


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
  local notif_data = get_notif_data(client_id, token)

  if notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = vim.notify("", nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn(function()
      update_spinner(client_id, token)
    end, 100)
  end
end

local function format_title(title, client_name)
  return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
  return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client_id = ctx.client_id

  local val = result.value

  if not val.kind then
    return
  end

  local notif_data = get_notif_data(client_id, result.token)

  if val.kind == "begin" then
    local message = format_message(val.message, val.percentage)

    notif_data.notification = vim.notify(message,

      vim.log.levels.INFO
      , {
        title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = false,
      })

    notif_data.spinner = 1
    update_spinner(client_id, result.token)
  elseif val.kind == "report" and notif_data then
    notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
      replace = notif_data.notification,
      hide_from_history = false,
    })
  elseif val.kind == "end" and notif_data then
    notif_data.notification =
        vim.notify(val.message and format_message(val.message) or "Complete", "info", {
          icon = "",
          replace = notif_data.notification,
          timeout = 3000,
        })

    notif_data.spinner = nil
  end
end

-- table from lsp severity to vim severity.
vim.lsp.handlers["window/showMessage"] = function(err, method, params)
  _ = params

  local severity = vim.log.levels.INFO
  if err then
    severity = vim.log.levels.ERROR
  end
  vim.notify(method.message, severity, {
    title = 'LSP'
  })
end


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

local lsp_stop = function()
  local clients = {}

  -- default to stopping all servers on current buffer
  clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

  for _, client in ipairs(clients) do
    vim.notify(
      "Stopping " .. client.name,
      vim.log.levels.INFO,
      {
        title = "LSP"
      })
    vim.lsp.stop_client(client.id)
  end
end

local lsp_start = function(info)
  local server_name = (info ~= nil and string.len(info.args) > 0) and info.args or nil
  local configs = vim.lsp._enabled_configs
  if server_name then
    local config = configs[server_name].resolved_config
    if config then
      print("Starting: " .. config.name)
      vim.lsp.start(config, {})
      return
    end
  end

  for _, config in pairs(configs) do
    local client = config.resolved_config

    if client then
      if contains(client.filetypes, vim.bo.filetype) then
        vim.notify(
          "Starting " .. client.name,
          vim.log.levels.INFO,
          {
            title = "LSP"
          })

        vim.lsp.start(client, {})
      end
    end
  end
end

local function lsp_toggle()
  local active_clients = vim.lsp.get_clients({})

  if #active_clients >= 1 then
    lsp_stop()
    return
  end
  lsp_start(nil)
end

vim.api.nvim_create_user_command('LspStart',
  lsp_start,
  {
    desc = 'Manually launches a language server',
    nargs = '?',
  })


vim.api.nvim_create_user_command('LspStop', lsp_stop, {
  desc = 'Manually stops the given language client(s)',
  nargs = '?',
})

vim.api.nvim_create_user_command('LspInfo', "checkhealth vim.lsp", {})

vim.api.nvim_create_user_command('LspToggle', lsp_toggle, {})
