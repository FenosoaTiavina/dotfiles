-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap


-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "save and quit" })                   --save and quit
keymap.set("n", "<leader>wa", ":wqall<CR>", { desc = "save all and quit" })            --save and quit
keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "quit without saving" })             --quit without saving
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "save" })                             --save
keymap.set("n", "gx", ":!xdg-open <c-r><c-a><CR>", { desc = "open URL under cursor" }) --open URL under cursor

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })           --split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })         --split window horizontally
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "close split window" })            --close split window
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "make split window height shorter" })  --make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "make split windows height taller" })  --make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "make split windows width bigger" })  --make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5", { desc = "make split windows width smaller" }) --make split windows width smaller
keymap.set("n", "<C-k>", ":wincmd k <CR>", { desc = "switch to split up" })             --switch to split up
keymap.set("n", "<C-j>", ":wincmd j <CR>", { desc = "switch to split down" })           --switch to split down
keymap.set("n", "<C-h>", ":wincmd h <CR>", { desc = "switch to split left" })           --switch to split left
keymap.set("n", "<C-l>", ":wincmd l <CR>", { desc = "switch to split right" })          --switch to split right

-- buffer management
keymap.set("n", "<TAB>", "<CMD>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bx", "<CMD>bdelete<CR>", { desc = "Previous buffer" })
