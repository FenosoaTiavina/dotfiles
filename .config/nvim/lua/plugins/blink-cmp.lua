return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    opts = {
        cmdline = {
            keymap = { preset = 'inherit' },
            completion = { menu = { auto_show = true } },
        },
        keymap = {
            preset = 'none',
            ['<c-p>'] = { 'select_prev', 'fallback' },
            ['<c-n>'] = { 'select_next', 'fallback' },
            ['<tab>'] = { 'accept', 'fallback' },

            ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets', 'lsp', 'buffer' } }) end },
        },

        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
        opts_extend = { "sources.default" }
    }
}
