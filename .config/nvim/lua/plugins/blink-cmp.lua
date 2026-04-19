require("blink.cmp").setup {
    cmdline = {
        keymap = {
            preset = 'none',
            ['<c-p>'] = { 'select_prev' },
            ['<c-n>'] = { 'select_next' },
            ['<tab>'] = { 'accept' },

            ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },
        },
        completion = { menu = { auto_show = true } },
    },
    keymap = {
        preset = 'none',
        ['<c-p>'] = { 'select_prev' },
        ['<c-n>'] = { 'select_next' },
        ['<tab>'] = { 'accept' },

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

    fuzzy = {
        sorts = {
            'exact',
            -- defaults
            'score',
            'sort_text',
        },
        implementation = "lua"
    },
}
