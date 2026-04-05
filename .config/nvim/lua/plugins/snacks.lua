vim.pack.add {
    "https://github.com/folke/snacks.nvim",
}

require("snacks").setup {
    ---@class snacks.input.Config
    input = {
        enabled = false

    },
    ---@class snacks.picker.Config
    picker = {
        ui_select = true,
    },

    statuscolumn = {
        enabled = true,
    }
}
