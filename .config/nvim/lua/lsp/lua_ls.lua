local on_attach = require("lsp.utils").on_attach
local capabilities = require("lsp.utils").capabilities

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
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                },
            },
            telemetry = { enable = false },
        },
    },

    single_file_support = true,
    log_level           = vim.lsp.protocol.MessageType.Warning,
}
