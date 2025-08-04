local on_attach = require("core.lsp.utils").on_attach
local capabilities = require("core.lsp.utils").capabilities

return {
  cmd                 = {
    "glsl_analyzer",
  },
  filetypes           = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
  root_markera        = { ".git" },

  on_attach           = on_attach(),
  capabilities        = capabilities,

  single_file_support = true,
  log_level           = vim.lsp.protocol.MessageType.Warning,
}
