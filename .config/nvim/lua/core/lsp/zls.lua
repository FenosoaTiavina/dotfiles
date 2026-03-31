local on_attach = require("core.lsp.utils").on_attach
local capabilities = require("core.lsp.utils").capabilities

vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})


return {
    cmd                 = {
        "zls",
    },
    filetypes           = {
        "zig",
    },

    on_attach           = on_attach,
    capabilities        = capabilities,

    root_markers        = {
        ".git",
        "build.zig",
        "build.zig.zon",
    },
    single_file_support = true,
    log_level           = vim.lsp.protocol.MessageType.Warning,
}
