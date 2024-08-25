local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers = { "html", "cssls" }
-- lsps with default config

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  init_option = { fallbackFlags = { "-std=c++2a" } },
  capabilities = capabilities,
}
