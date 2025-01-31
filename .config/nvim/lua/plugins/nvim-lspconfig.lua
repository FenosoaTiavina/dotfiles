-- LSP Support
--
--
local telescope = require('telescope.builtin')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config {
  float = { border = _border }
}

local on_attach = function()
  local keymap = vim.keymap
  -- LSP
  --
  keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
  keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  keymap.set('n', '<leader>gr', function() telescope.lsp_references() end)
  keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
  keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format()<CR>')
  keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
  keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')
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
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim',                opts = {} },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = {},
      -- Install these LSPs automatically
      ensure_installed = {
        -- 'bashls', -- requires npm to be installed
        'cssls', -- requires npm to be installed
        'html',  -- requires npm to be installed
        'lua_ls',
        'clangd',
        'zls',
        'gopls',
        -- 'jsonls', -- requires npm to be installed
        -- 'lemminx',
        'marksman',
        'quick_lint_js',
        -- 'ts_ls', -- requires npm to be installed
        -- 'yamlls', -- requires npm to be installed
      }
    })

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Call setup on each LSP server
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          handlers = handlers,
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end
    })

    -- Lua LSP settings

    lspconfig.lua_ls.setup {
      handlers = handlers,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
        },
      },
    }
    lspconfig.quick_lint_js.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "quick-lint-js", "--lsp-server" },
      filetypes = { "javascript", "typescript", }

    }
    lspconfig.clangd.setup {
      handlers = handlers,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--all-scopes-completion",
        "--pretty",
        "--header-insertion=never",
        "-j=4",
        "--inlay-hints",
        "--header-insertion-decorators",
        "--function-arg-placeholders",
        "--completion-style=detailed",
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      init_option = { fallbackFlags = { "-std=c++2a" } },
      capabilities = capabilities,
    }

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
