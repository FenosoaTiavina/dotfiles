return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    { 'jvgrootveld/telescope-zoxide' },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = {
    defaults = {
      border = false,
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
    }
  },
  config = function()
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("zoxide")
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set
    keymap("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })                               -- Telescope Live Grep
    keymap("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })                           -- Telescope diagnostics
    keymap("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Telescope current symbols" })              -- Telescope current symbols
    keymap("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Telescope workspace symbols" })           -- Telescope workspace symbols
    keymap("n", "<leader>fz", ":Telescope zoxide list<CR>", { desc = "Zoxide list" })                            --Zoxide list
    keymap("n", "<leader>fv", builtin.help_tags, { desc = "Telescope Helps" })                                   -- Telescope Helps
    keymap('n', '<leader>ff', builtin.find_files, { desc = "fuzzy find files in project" })                      -- fuzzy find files in project
    keymap('n', '<leader>fb', builtin.buffers, { desc = "fuzzy find open buffers" })                             -- fuzzy find open buffers
    keymap('n', '<leader>fh', builtin.help_tags, { desc = "fuzzy find help tags" })                              -- fuzzy find help tags
    keymap('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = "fuzzy find in current file buffer" }) -- fuzzy find in current file buffer
    keymap('n', '<leader>fo', builtin.lsp_document_symbols, { desc = "fuzzy find LSP/class symbols" })           -- fuzzy find LSP/class symbols
    keymap('n', '<leader>fm', builtin.treesitter, { desc = "fuzzy find methods in current class" })              -- fuzzy find methods in current class
  end
}
