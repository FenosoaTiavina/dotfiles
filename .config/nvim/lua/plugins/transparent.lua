return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup { -- Optional, you don't have to run setup.
      groups = {                   -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Folded",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",

        --[[ "TelescopePromptTitle",
        "TelescopePromptPrefix",
        "TelescopePromptCounter",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopeResultsTitle",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopePreviewTitle",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder", ]]
      },
      extra_groups = {},   -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    }
    vim.cmd "TransparentEnable"
  end,
}
