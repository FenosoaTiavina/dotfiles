local telescope = require('telescope.builtin')

M = {}
M.capabilities = require('blink.cmp').get_lsp_capabilities()

vim.diagnostic.config {
    virtual_text  = false,
    virtual_lines = true,
}

M.on_attach = function()
    local keymap = vim.keymap
    -- LSP
    keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = "code action" })                --code action
    keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, { desc = "goto to definition" })          --goto to definition
    keymap.set('n', '<leader>gD', function() vim.lsp.buf.declaration() end, { desc = "goto to declaration" })        --goto to declaration
    keymap.set('n', '<leader>gi', function() vim.lsp.buf.implementation() end, { desc = "go to implementation" })    --go to implementation
    keymap.set('n', '<leader>gt', function() vim.lsp.buf.type_definition() end, { desc = "goto type definition" })   --goto type definition
    keymap.set('n', '<leader>gr', function() telescope.lsp_references() end, { desc = "Goto references" })           --Goto references
    keymap.set('n', '<leader>gs', function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })          --Signature help
    keymap.set('n', '<leader>rr', function() vim.lsp.buf.rename() end, { desc = "Lsp rename" })                      --Lsp rename
    keymap.set('n', '<leader>fm', function() vim.lsp.buf.format() end, { desc = "Format file" })                     --Format file
    keymap.set('n', '<leader>gl', function() vim.diagnostic.open_float() end, { desc = "Diagnostic float" })         --Diagnostic float
    keymap.set('n', '<S-k>',
        function() vim.lsp.buf.hover({ border = "none", max_height = 25, max_width = 120 }) end, { desc = "Hover" }) --Hover
end



return M
