local on_attach = require("core.lsp.utils").on_attach
local capabilities = require("core.lsp.utils").capabilities

return {
  cmd                 = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed",
  },
  filetypes           = {
    "c", "cpp",
    "cc",
    "h", "hpp",
    "inl",
    "objc", "objcpp",
  },
  root_markers        = {
    ".git",
  },

  on_attach           = function()
    vim.keymap.set("n", "<leader>ss", "<cmd> ClangdSwitchSourceHeader <CR>",
      { desc = "Switch between source and header" })
    on_attach()
  end,

  capabilities        = capabilities,

  single_file_support = true,
  log_level           = vim.lsp.protocol.MessageType.Warning,
}
