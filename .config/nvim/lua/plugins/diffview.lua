require("diffview").setup {}

vim.keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "put diff from current to other during diff" })  --put diff from current to other during diff
vim.keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "get diff from left (local) during merge" })   --get diff from left (local) during merge
vim.keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "get diff from right (remote) during merge" }) --get diff from right (remote) during merge
vim.keymap.set("n", "<leader>cn", "]c", { desc = "next diff hunk" })                                        --next diff hunk
vim.keymap.set("n", "<leader>cp", "[c", { desc = "previous diff hunk" })                                    --previous diff hunk
