local capabilities = require("lsp.utils").capabilities
local on_attach = require("lsp.utils").on_attach

-- 1. Define your base/default settings
local base_settings = {
    Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = { vim.env.VIMRUNTIME } },
    }
}

-- 2. Try to read and merge .luarc.json manually
local rc_path = vim.fn.getcwd() .. "/.luarc.json"
local f = io.open(rc_path, "r")
if f then
    local content = f:read("*a")
    f:close()
    local ok, decoded = pcall(vim.json.decode, content)
    if ok then
        -- Merge the JSON fields into base_settings.Lua
        -- vim.tbl_deep_extend "force" will overwrite base keys with JSON keys
        base_settings.Lua = vim.tbl_deep_extend("force", base_settings.Lua, decoded)
    end
end

return {
    cmd                 = {
        "lua-language-server",
    },
    filetypes           = { 'lua' },
    root_markers        = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
    },
    on_attach           = on_attach,
    capabilities        = capabilities,
    settings            = base_settings, -- Now contains both!
    single_file_support = true,
    log_level           = vim.lsp.protocol.MessageType.Warning,

}


-- return {
--     cmd                 = {
--         "lua-language-server",
--     },
--     filetypes           = { 'lua' },
--     root_markers        = {
--         ".luarc.json",
--         ".luarc.jsonc",
--         ".luacheckrc",
--         ".stylua.toml",
--         ".git",
--     },
--
--     on_attach           = on_attach(),
--     capabilities        = capabilities,
--
--     settings            = {
--         Lua = {
--             diagnostics = { globals = { 'vim' } },
--             workspace = {
--                 checkThirdParty = true,
--                 library = {
--                     vim.env.VIMRUNTIME,
--                     '${3rd}/luv/library',
--                 },
--             },
--             telemetry = { enable = false },
--             runtime = {
--                 version = 'LuaJIT',
--             }
--         },
--
--     },
--
--     single_file_support = true,
--     log_level           = vim.lsp.protocol.MessageType.Warning,
-- }
