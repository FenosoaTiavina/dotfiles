local on_attach = require("core.lsp.utils").on_attach
local capabilities = require("core.lsp.utils").capabilities


return {
  settings     = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  },
  cmd          = { "pylsp" },
  filetypes    = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  on_attach    = on_attach(),
  capabilities = capabilities,
}
