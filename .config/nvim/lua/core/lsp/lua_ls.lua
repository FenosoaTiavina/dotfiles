local on_attach = require("core.lsp.utils").on_attach
local capabilities = require("core.lsp.utils").capabilities

return {
  cmd                 = {
    "lua-language-server",
  },
  filetypes           = {
    "lua",
  },
  root_markers        = {
    ".git",
    ".luacheckrc",
    ".luarc.json",
    ".luarc.jsonc",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml",
  },

  on_attach           = on_attach(),
  capabilities        = capabilities,

  settings            = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },

  single_file_support = true,
  log_level           = vim.lsp.protocol.MessageType.Warning,
}
