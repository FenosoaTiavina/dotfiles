-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  ui = {
    theme = "oxocarbon",
    tabufline = {
      enabled = false,
    },
    statusline = {
      theme = "vscode_colored",
      separator_style = "round",
    },
    hl_override = {

      LineNr = { fg = "white" },
      Comment = { fg = "#c2c2c2" },
      Visual = { bg = "white" },
      TelescopeBorder = { fg = "white" },
      TelescopeSelectionCaret = { fg = "white" },
      TelescopePromptTitle = { fg = "white" },
      TelescopePromptBorder = { fg = "white" },
      TelescopeResultsTitle = { fg = "white" },
      TelescopePreviewTitle = { fg = "white" },
    },
  },
  mason = {
    pkgs = {
      "lua-language-server",
      "stylua",
      "html-lsp",
      "css-lsp",
      "prettier",
      "rust-analyzer",
    },
  },
}

return M
