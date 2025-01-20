-- Indentation guides
return {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  "lukas-reineke/indent-blankline.nvim",
  event = 'VeryLazy',
  main = "ibl",
  config = function ()
    require("ibl").setup()
  end
}
