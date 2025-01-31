return {
  "norcalli/nvim-colorizer.lua",

  event = "VeryLazy",
  opts = {
    lazy_load = true,
    -- other setup options
  },
  config = function()
    require 'colorizer'.setup()
  end
}
