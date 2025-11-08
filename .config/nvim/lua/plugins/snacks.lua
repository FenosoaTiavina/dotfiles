return {
    "folke/snacks.nvim",
    opts = {
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
    },
    init = function()
    end,
}
