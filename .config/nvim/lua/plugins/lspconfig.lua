--[[
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
]]
return {}
