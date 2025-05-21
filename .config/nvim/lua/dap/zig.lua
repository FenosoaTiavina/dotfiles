local ok, dap = pcall(require, 'dap')
if not ok then
  return
end

dap.adapters.gdb = {
  id = 'gdb',
  type = 'executable',
  command = 'gdb',
  args = { '--quiet', '--interpreter=dap' },
}



local zig = {
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
  {
    name = 'Run executable with arguments (GDB)',
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
      return (path and path ~= '') and path or dap.ABORT
    end,
    args = function()
      local args_str = ''
      vim.ui.input({
        prompt = 'Args: ',
      }, function(value)
        args_str = value
      end)
      return vim.split(args_str, ' +')
    end,
  },
}

dap.configurations.zig = zig;
