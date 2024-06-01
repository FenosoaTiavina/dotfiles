require "nvchad.mappings"

-- add yours here
--

map = vim.keymap.set

unmap = vim.keymap.del

unmap("n", "<leader>/")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>/", "<cmd>Oil<CR>", { desc = "Open parent directory" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
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

local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end
local function select_version()
  require("crates").show_versions_popup()
  require("crates").focus_popup()
end
map("n", "<leader>cv", select_version, { silent = true, desc = "Select version" })
map("n", "K", show_documentation, { silent = true, desc = "Show documentation" })

map("n", "<leader>ru", "<cmd>lua require('crates').upgrade_all_crates()<cr>", { desc = "update crates" })
map("n", "<leader>rf", "<cmd>lua require('crates').show_crate_popup()<cr>", { desc = "show crate pop up" })

local select_features = function()
  require("crates").show_features_popup()
  require("crates").focus_popup()
end

map("n", "<leader>rcf", select_features, { desc = "show features pop up" })

map("n", "<C-h>", "<C-w>h", { desc = "Goto to window left " })
map("n", "<C-l>", "<C-w>l", { desc = "Goto to window right " })
map("n", "<C-k>", "<C-w>k", { desc = "Goto to window up " })
map("n", "<C-j>", "<C-w>j", { desc = "Goto to window down " })
map("n", "<leader>cC", require("crates").open_crates_io, {})
-- Resize Windows
map("n", "<C-Left>", "<C-w><", { desc = "Resize window left" })
map("n", "<C-Right>", "<C-w>>", { desc = "Resize window right " })
map("n", "<C-Up>", "<C-w>+", { desc = "Resize window up " })
map("n", "<C-Down>", "<C-w>-", { desc = "Resize window down " })

-- Windows
map("n", "<leader>ñ", "<CMD>vsplit<CR>", { desc = "vertical split" })
map("n", "<leader>p", "<CMD>split<CR>", { desc = "Horizontal split" })

map("n", "<TAB>", "<CMD>bnext<CR>", { desc = "Next buffer" })

map("n", "<S-TAB>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
