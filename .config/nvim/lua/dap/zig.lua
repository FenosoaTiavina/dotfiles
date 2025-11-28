local ok, dap = pcall(require, 'dap')
if not ok then
    return
end

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.adapters.gdb = {
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
}

local zig = {
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
    {
        name = 'Launch with args',
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
        args = function()
            local args = ''
            vim.ui.input({
                prompt = 'args',
                default = "",
            }, function(value)
                args = value
            end)

            return (args and args ~= '') and args or dap.abort
        end,
    },

    {
        name = 'run executable (gdb)',
        type = 'gdb',
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
    },

}

dap.configurations.zig = zig;
