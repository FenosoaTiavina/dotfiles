return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true
    },
    picker = {
      layout = {
        reverse = true,
        layout = {
          box = "horizontal",
          backdrop = false,
          width = 0.8,
          height = 0.9,
          border = "none",
          {
            box = "vertical",
            { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
            {
              win = "input",
              height = 1,
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
          },
          {
            win = "preview",
            title = "{preview:Preview}",
            width = 0.45,
            border = "rounded",
            title_pos = "center",
          },
        },
      },
    },
  },
  init = function()
    local snacks = require("snacks")
  end,
}
