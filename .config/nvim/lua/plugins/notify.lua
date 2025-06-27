return {
  "rcarriga/nvim-notify",
  version = false,
  config = function()
    local notify = require("notify")
    notify.setup({
      merge_duplicates = true,
      background_colour = require("oxocarbon-lua.colors").dark[17],
    })
    vim.notify = notify.notify
  end
}
