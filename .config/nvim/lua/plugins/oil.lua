return {
    'stevearc/oil.nvim',
    dependencies = { 
        { "nvim-mini/mini.icons", opts = {} } 
    },
    lazy         = false,
    opts         = {
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = false,
        },
    },
}
