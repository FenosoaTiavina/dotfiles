return {
  'Forest-nvim/maple.nvim',
  config = function()
    require('maple').setup({
      -- Appearance customization
      border = 'rounded',
      title = ' Scratch ',
      title_pos = 'center',
      winblend = 0,
    })
  end
}
