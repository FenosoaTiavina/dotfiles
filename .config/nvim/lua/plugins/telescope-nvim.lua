-- Fuzzy finder
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
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
    vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, {})
    vim.keymap.set("n", "<leader>fz", ":Telescope zoxide list<CR>", {})
    vim.keymap.set("n", "<leader>fv", builtin.help_tags, {})
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})                -- fuzzy find files in project
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})                   -- fuzzy find open buffers
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})                 -- fuzzy find help tags
    vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, {}) -- fuzzy find in current file buffer
    vim.keymap.set('n', '<leader>fo', builtin.lsp_document_symbols, {})      -- fuzzy find LSP/class symbols
    vim.keymap.set('n', '<leader>fm', function() builtin.treesitter() end)   -- fuzzy find methods in current class
  end
}
