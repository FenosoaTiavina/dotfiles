local ok, dap = pcall(require, 'dap')
if not ok then
  return
end

dap.adapters.lldb      = {
  type = 'executable',
  command = '/bin/lldb', -- adjust as needed, must be absolute path
  name = 'lldb'
}

local zig              = {
  {
    name = 'Launch',
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

      return (path and path ~= '') and path or dap.ABORT
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.zig = zig;
