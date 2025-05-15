return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true
    }
  },
  init = function()
    local snacks = require("snacks")
  end,
}
