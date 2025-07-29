-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap


-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "save and quit" })                   --save and quit
keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "quit without saving" })             --quit without saving
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "save" })                             --save
keymap.set("n", "gx", ":!xdg-open <c-r><c-a><CR>", { desc = "open URL under cursor" }) --open URL under cursor

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })           --split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })         --split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make split windows equal width" })    --make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "close split window" })            --close split window
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "make split window height shorter" })  --make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "make split windows height taller" })  --make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "make split windows width bigger" })  --make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5", { desc = "make split windows width smaller" }) --make split windows width smaller

-- buffer management
keymap.set("n", "<TAB>", "<CMD>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bx", "<CMD>bdelete<CR>", { desc = "Previous buffer" })

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "put diff from current to other during diff" })  --put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "get diff from left (local) during merge" })   --get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "get diff from right (remote) during merge" }) --get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c", { desc = "next diff hunk" })                                        --next diff hunk
keymap.set("n", "<leader>cp", "[c", { desc = "previous diff hunk" })                                    --previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "open quickfix list" })                --open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "jump to first quickfix list item" }) --jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "jump to next quickfix list item" })   --jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "jump to prev quickfix list item" })   --jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "jump to last quickfix list item" })   --jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "close quickfix list" })              --close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "toggle maximize tab" }) --toggle maximize tab

-- Oil
keymap.set("n", "<leader>/", ":Oil<CR>", { desc = "toggle file explorer" }) --toggle file explorer

-- folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Close all folds" }) -- Close all folds
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = "closeAllFolds == closeFoldsWith(0)" }) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.lsp.buf.hover()
  end
end, { desc = "Peek into folds" }) --Peek into folds

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" }) --Toggle breakpoint
keymap.set("n", "<leader>gb", "<cmd>lua require'dap'.run_to_cursor <dr>", { desc = "Run to cursor" })          --Run to cursor
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
  { desc = "Toggle conditional breakpoint" })                                                                  --Toggle conditional breakpoint
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
  { desc = "Toggle log breakpoint" })                                                                          --Toggle log breakpoint
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear breakpoints" }) --Clear breakpoints
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List all breakpoints" })    --List all breakpoints
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Debugger continue" })          --Debugger continue
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Debugger step over" })        --Debugger step over
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Debugger step into" })        --Debugger step into
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Debugger step out" })          --Debugger step out

keymap.set("n", '<leader>dd', function()
  require('dap').disconnect(); require('dapui').close();
end, { desc = "Debugger disconnect" }) --Debugger disconnect
keymap.set("n", '<leader>dt', function()
  require('dap').terminate(); require('dapui').close();
end, { desc = "Debugger terminate" }) --Debugger terminate
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?',
  function()
    local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
  end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)


keymap.set("n", "<leader>dus", "<cmd>lua require('dap.ui.widgets.sidebar.scopes').open() <CR>",
  { desc = "Open debugging sidebar" })
