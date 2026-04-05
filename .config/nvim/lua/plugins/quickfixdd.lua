-- Adds delete functionality to quickfix list (keymap dd)
vim.pack.add {
  'https://github.com/TamaMcGlinn/quickfixdd',
}

-- Quickfix keymaps
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "open quickfix list" })                --open quickfix list
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "jump to next quickfix list item" })   --jump to next quickfix list item
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "jump to prev quickfix list item" })   --jump to prev quickfix list item
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "jump to first quickfix list item" }) --jump to first quickfix list item
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "jump to last quickfix list item" })   --jump to last quickfix list item
vim.keymap.set("n", "<leader>qx", ":cclose<CR>", { desc = "close quickfix list" })              --close quickfix list
