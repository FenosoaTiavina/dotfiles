local on_attach = require("lsp.utils").on_attach
local capabilities = require("lsp.utils").capabilities

return {
    cmd          = { 'typescript-language-server', '--stdio' },
    filetypes    = { 'ts', 'typescript' },
    root_dir     = vim.fs.root(0, { 'package.json', '.git' }),
    on_attach    = on_attach(),
    capabilities = capabilities,
}
