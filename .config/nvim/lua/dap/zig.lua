local ok, dap = pcall(require, 'dap')
if not ok then
    return
end

-- dap.adapters.gdb = {
--     id = 'gdb',
--     type = 'executable',
--     command = 'gdb',
--     args = { '--quiet', '--interpreter=dap' },
-- }

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

local zig = {
    {
        name = 'run executable (gdb)',
        type = 'lldb',
        request = 'launch',
        program = function()
            local path = ''
            vim.ui.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            }, function(value)
                path = value
            end)

            return (path and path ~= '') and path or dap.abort
        end,
        stopOnEntry = true,
    },
    {
        name = 'Launch',
        type = 'codelldb',
        request = 'launch',
        program = function()
            local path = ''
            vim.ui.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            }, function(value)
                path = value
            end)

            return (path and path ~= '') and path or dap.abort
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.zig = zig;
