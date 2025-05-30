local telescope = require('telescope.builtin')

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.diagnostic.config {
  virtual_text  = false,
  virtual_lines = true,
}

local on_attach = function()
  local keymap = vim.keymap
  -- LSP
  keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "code action" })              --code action
  keymap.set('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Hover" })                               --Hover
  keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "goto to definition" })        --goto to definition
  keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "goto to declaration" })      --goto to declaration
  keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "go to implementation" })  --go to implementation
  keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "goto type definition" }) --goto type definition
  keymap.set('n', '<leader>gr', function() telescope.lsp_references() end, { desc = "Goto references" })         --Goto references
  keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })        --Signature help
  keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Lsp rename" })                    --Lsp rename
  keymap.set('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', { desc = "Format file" })                   --Format file
  keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Diagnostic float" })       --Diagnostic float
  keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Previous diagnostic" })     --Previous diagnostic
  keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Next diagnostic" })         --Next diagnostic
end


return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim',                opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/lazydev.nvim
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
        },
      },
    },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_enable = {},
      automatic_installation = {},
      -- Install these LSPs automatically
      ensure_installed = {
        -- 'bashls', -- requires npm to be installed
        'cssls', -- requires npm to be installed
        'html',  -- requires npm to be installed
        'lua_ls',
        'zls',
        'gopls',
        'marksman',
        'biome',
        'angularls',
        'tailwindcss', 'jsonls',
      }
    })

    local lspconfig = require('lspconfig')
    -- Lua LSP settings

    lspconfig.lua_ls.setup {
      on_attach    = on_attach,
      capabilities = capabilities,
      settings     = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
        },
      },
    }

    lspconfig.zls.setup {
      on_attach    = on_attach,
      capabilities = capabilities,
    }

    lspconfig.angularls.setup {
      on_attach    = on_attach,
      capabilities = capabilities,
      cmd          = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
      filetypes    = { "typescript", "html", "typescriptreact", "typescript.tsx" },
    }

    lspconfig.biome.setup {
      on_attach    = on_attach,
      capabilities = capabilities,
      cmd          = { "biome", "lsp-proxy" },
      filetypes    = { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" },
    }

    lspconfig.clangd.setup {
      on_attach    = function()
        vim.keymap.set("n", "<leader>ss", "<cmd> ClangdSwitchSourceHeader <CR>",
          { desc = "Switch between source and header" })
        on_attach()
      end,
      cmd          = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--all-scopes-completion",
        "--pretty",
        "-j=4",
        "--inlay-hints",
        "--header-insertion-decorators",
        "--function-arg-placeholders",
        "--completion-style=detailed",
      },
      filetypes    = { "c", "cpp", "objc", "objcpp", "h", "hpp", "inl" },
      capabilities = capabilities,
    }
  end
}
