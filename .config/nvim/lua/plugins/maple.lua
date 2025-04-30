return {
  'Forest-nvim/maple.nvim',
  config = function()
    require('maple').setup({
      -- Appearance customization
      border = 'rounded',
      title = ' Scratch ',
      title_pos = 'center',
      winblend = 0,

      -- Custom keymaps
      keymaps = {
        add = 'n',                        -- Press 'n' to create a new todo
        toggle = 't',                     -- Press 't' to toggle completion
        delete = 'D',                     -- Press 'D' to delete a todo
        close = { 'q', '<Esc>', '<C-c>' } -- More ways to close the window
      }
    })
  end
}
