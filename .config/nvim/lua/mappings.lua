require "nvchad.mappings"

-- add yours here

map = vim.keymap.set

unmap = vim.keymap.del

-- NOTE: UNMAP
unmap("n", "<leader>/")
unmap("n", "<M-i>")
unmap("n", "<M-h>")
unmap("n", "<M-v>")
unmap("n", "<C-W><C-D>")
unmap("n", "<C-W>d")

-- NOTE: END-UNMAP

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>/", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- NOTE: END-DIAGNOSTICS
local telescope = require "telescope.builtin"
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic under the cursor" })
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Renames all references to the symbol under the cursor" })
map(
  "n",
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = "Selects a code action available at the current cursor position" }
)
map("n", "<leader>gd", telescope.lsp_definitions, {
  desc = "Goto the definition of the word under the cursor, if there's only one,otherwise show all options in Telescope",
})

map("n", "<leader>ld", telescope.diagnostics, {
  desc = "Lists diagnostics in the current file buffer",
})

map("n", "<leader>gi", telescope.lsp_implementations, {
  desc = "Goto the implementation of the word under the cursor if there's only one,otherwise show all options in Telescope",
})

map("n", "<leader>gR", telescope.lsp_references, {
  desc = "Lists LSP references for word under the cursor, jumps to reference on",
})
-- NOTE: END-DIAGNOSTICS
-- NOTE: DAP
map("n", "<leader>sb", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })

map(
  "n",
  "<leader>dus",
  "<cmd>lua require('dap.ui.widgets.sidebar.scopes').open() <CR>",
  { desc = "Open debugging sidebar" }
)
map(

  "n",
  "<leader>dus",
  "<cmd>lua require('dap.ui.widgets.sidebar.scopes').open() <CR>",
  { desc = "Open debugging sidebar" }
)

-- NOTE: END-DAP

-- NOTE: RUST CRATES

local function hover()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
  else
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of coc.nvim and nvim lsp
      vim.lsp.buf.hover()
    end
  end
end
local function select_version()
  require("crates").show_versions_popup()
  require("crates").focus_popup()
end
map("n", "<leader>cv", select_version, { silent = true, desc = "Select version" })
map("n", "K", hover, { silent = true, desc = "Show documentation" })

map("n", "<leader>ru", "<cmd>lua require('crates').upgrade_all_crates()<cr>", { desc = "update crates" })
map("n", "<leader>rf", "<cmd>lua require('crates').show_crate_popup()<cr>", { desc = "show crate pop up" })

local select_features = function()
  require("crates").show_features_popup()
  require("crates").focus_popup()
end

map("n", "<leader>rcf", select_features, { desc = "show features pop up" })

-- NOTE: END-RUST CRATES
map("n", "<C-h>", "<C-w>h", { desc = "Goto to window left " })
map("n", "<C-l>", "<C-w>l", { desc = "Goto to window right " })
map("n", "<C-k>", "<C-w>k", { desc = "Goto to window up " })
map("n", "<C-j>", "<C-w>j", { desc = "Goto to window down " })
map("n", "<leader>cC", require("crates").open_crates_io, {})
-- Resize Windows
map("n", "<M-h>", "<C-w><", { desc = "Resize window left" })
map("n", "<M-l>", "<C-w>>", { desc = "Resize window right " })
map("n", "<M-k>", "<C-w>+", { desc = "Resize window up " })
map("n", "<M-j>", "<C-w>-", { desc = "Resize window down " })

-- Windows
map("n", "<leader>v", "<CMD>vsplit<CR>", { desc = "vertical split" })
map("n", "<leader>p", "<CMD>split<CR>", { desc = "Horizontal split" })

map("n", "<TAB>", "<CMD>bnext<CR>", { desc = "Next buffer" })

map("n", "<S-TAB>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Previous buffer" })
