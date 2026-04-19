local z_utils = require("telescope._extensions.zoxide.utils")

require('telescope').setup {
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
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",

            },
            zoxide = {
                prompt_title = "[ Walking on the shoulders of TJ ]",
                mappings = {
                    default = {
                        after_action = function(selection)
                            print("Update to (" .. selection.z_score .. ") " .. selection.path)
                        end
                    },
                    ["<C-s>"] = {
                        -- before_action = function(selection) print("before C-s") end,
                        action = function(selection)
                            vim.cmd.edit(selection.path)
                        end
                    },
                    -- Opens the selected entry in a new split
                    ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                },
            }
        }
    }
}

local config = function()
    require('telescope').load_extension('fzf')
    require("telescope").load_extension("zoxide")
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set
    keymap("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })                               -- Telescope Live Grep
    keymap("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })                           -- Telescope diagnostics
    keymap("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Telescope current symbols" })              -- Telescope current symbols
    keymap("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Telescope workspace symbols" })           -- Telescope workspace symbols
    keymap("n", "<leader>fz", require("telescope").extensions.zoxide.list, { desc = "Zoxide list" })
    keymap("n", "<leader>fv", builtin.help_tags, { desc = "Telescope Helps" })                                   -- Telescope Helps
    keymap('n', '<leader>ff', builtin.find_files, { desc = "fuzzy find files in project" })                      -- fuzzy find files in project
    keymap('n', '<leader>fb', builtin.buffers, { desc = "fuzzy find open buffers" })                             -- fuzzy find open buffers
    keymap('n', '<leader>fh', builtin.help_tags, { desc = "fuzzy find help tags" })                              -- fuzzy find help tags
    keymap('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = "fuzzy find in current file buffer" }) -- fuzzy find in current file buffer
    keymap('n', '<leader>fo', builtin.lsp_document_symbols, { desc = "fuzzy find LSP/class symbols" })           -- fuzzy find LSP/class symbols
    keymap('n', '<leader>fm', builtin.treesitter, { desc = "fuzzy find methods in current class" })              -- fuzzy find methods in current class
end
config()
