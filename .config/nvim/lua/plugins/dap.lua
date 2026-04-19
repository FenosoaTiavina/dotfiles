-- Debugging
local dap = require('dap')

vim.keymap.set("n", "<leader>bb", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" }) --Toggle breakpoint

vim.keymap.set("n", "<leader>gb", function() dap.run_to_cursor() end, { desc = "Run to cursor" })         --Run to cursor

vim.keymap.set("n", "<leader>bc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = "Toggle conditional breakpoint" }) --Toggle conditional breakpoint

vim.keymap.set("n", "<leader>bl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = "Toggle log breakpoint" })                                                                         --Toggle log breakpoint

vim.keymap.set("n", '<leader>br', function() dap.clear_breakpoints() end, { desc = "Clear breakpoints" })       --Clear breakpoints

vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List all breakpoints" }) --List all breakpoints

vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debugger continue" })                --Debugger continue

vim.keymap.set("n", "<leader>dn", function() dap.down() end, { desc = "Debugger continue" })                    --Debugger continue

vim.keymap.set("n", "<leader>dj", function() dap.step_over() end, { desc = "Debugger step over" })              --Debugger step over

vim.keymap.set("n", "<leader>dk", function() dap.step_into() end, { desc = "Debugger step into" })              --Debugger step into

vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Debugger step out" })                --Debugger step out

vim.keymap.set("n", '<leader>dd', function()
    require('dap').disconnect(); require('dapui').close();
end, { desc = "Debugger disconnect" }) --Debugger disconnect

vim.keymap.set("n", '<leader>dt', function()
    require('dap').terminate(); require('dapui').close();
end, { desc = "Debugger terminate" }) --Debugger terminate

vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")

vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")

vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)

vim.keymap.set("n", '<leader>d?',
    function()
        local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
    end)

vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')

vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')

vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)

vim.keymap.set("n", "<leader>dus", "<cmd>lua require('dap.ui.widgets.sidebar.scopes').open() <CR>",
    { desc = "Open debugging sidebar" })

vim.keymap.set("n", "<leader>gb", function() dap.run_to_cursor() end, { desc = "Run to cursor" }) --Run to cursor

vim.keymap.set("n", "<leader>bc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = "Toggle conditional breakpoint" }) --Toggle conditional breakpoint

vim.keymap.set("n", "<leader>bl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = "Toggle log breakpoint" })                                                                         --Toggle log breakpoint

vim.keymap.set("n", '<leader>br', function() dap.clear_breakpoints() end, { desc = "Clear breakpoints" })       --Clear breakpoints

vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List all breakpoints" }) --List all breakpoints

vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debugger continue" })                --Debugger continue

vim.keymap.set("n", "<leader>dn", function() dap.down() end, { desc = "Debugger continue" })                    --Debugger continue
vim.keymap.set("n", "<leader>dj", function() dap.step_over() end, { desc = "Debugger step over" })              --Debugger step over
vim.keymap.set("n", "<leader>dk", function() dap.step_into() end, { desc = "Debugger step into" })              --Debugger step into
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Debugger step out" })                --Debugger step out

vim.keymap.set("n", '<leader>dd', function()
    require('dap').disconnect(); require('dapui').close();
end, { desc = "Debugger disconnect" }) --Debugger disconnect
vim.keymap.set("n", '<leader>dt', function()
    require('dap').terminate(); require('dapui').close();
end, { desc = "Debugger terminate" }) --Debugger terminate
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
vim.keymap.set("n", '<leader>d?',
    function()
        local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
    end)
vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)


vim.keymap.set("n", "<leader>dus", "<cmd>lua require('dap.ui.widgets.sidebar.scopes').open() <CR>",
    { desc = "Open debugging sidebar" })
