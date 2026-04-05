vim.pack.add {"https://github.com/stevearc/oil.nvim.git"}

require("oil").setup()

vim.keymap.set("n", "<leader>/", "<CMD>Oil<CR>", { desc = "Open parent directory" })
