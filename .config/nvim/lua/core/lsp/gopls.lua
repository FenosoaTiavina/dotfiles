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
  cmd          = { "gopls" },                                    -- Command to start the language server
  filetypes    = { "go", "gomod", "gowork", "gotmpl", "gosum" }, -- File types that this server will handle
  root_markers = { "go.mod", "go.work", ".git" },                -- Markers to identify the root of the project
  on_attach    = on_attach(),
  capabilities = capabilities,

  settings     = { -- Settings for the language server
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unreachable = true,
        modernize = true,
        stylecheck = true,
        appends = true,
        asmdecl = true,
        assign = true,
        atomic = true,
        bools = true,
        buildtag = true,
        cgocall = true,
        composite = true,
        contextcheck = true,
        deba = true,
        atomicalign = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        defers = true,
        deprecated = true,
        directive = true,
        embed = true,
        errorsas = true,
        fillreturns = true,
        framepointer = true,
        gofix = true,
        hostport = true,
        infertypeargs = true,
        lostcancel = true,
        httpresponse = true,
        ifaceassert = true,
        loopclosure = true,
        nilfunc = true,
        nonewvars = true,
        noresultvalues = true,
        printf = true,
        shadow = true,
        shift = true,
        sigchanyzer = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        slog = true,
        sortslice = true,
        stdmethods = true,
        stdversion = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        timeformat = true,
        unmarshal = true,
        unsafeptr = true,
        unusedfunc = true,
        unusedresult = true,
        waitgroup = true,
        yield = true,
        unusedvariable = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
}
