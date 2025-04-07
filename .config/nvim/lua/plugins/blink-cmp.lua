return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      'echasnovski/mini.snippets',
      config = function()
        local gen_loader = require('mini.snippets').gen_loader
        require('mini.snippets').setup({
          mappings = {
            -- Expand snippet at cursor position. Created globally in Insert mode.
            expand = '<M-j>',
            accept = '<Tab>',
            jump_next = '<M-l>',
            jump_prev = '<M-h>',
            stop = '<ESC>',

          },

          snippets = {
            gen_loader.from_file('~/.config/nvim/snippets/global.json'),

            gen_loader.from_lang(),
          },
        })
      end
    },
  }
  ,

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts_extend = { "sources.default" },
  config = function()
    require('blink-cmp').setup(
      {

        snippets = { preset = 'mini_snippets' },
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        signature = {
          window = {
            border = 'rounded',
            direction_priority = { 'n' },
          },

          enabled = false
        },

        keymap = {
          -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-space>'] = {
            function(cmp)
              if cmp.is_visible() and not cmp.is_documentation_visible() then
                return cmp.hide()
              else
                return cmp.show()
              end
            end,
            function(cmp)
              if cmp.is_menu_visible() then
                if cmp.is_documentation_visible() then
                  return cmp.hide_documentation()
                else
                  return cmp.show_documentation()
                end
              end
            end,
            function(cmp)
              if cmp.snippet_active() then
                cmp.hide()
                return cmp.accept()
              end
            end, },
          ['<C-e>'] = {},
          ['<Tab>'] = { function(cmp)
            if cmp.is_visible() then
              cmp.hide()
              return cmp.accept()
            end
          end,
            "fallback",
          },

          --[[ ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' }, ]]

          ['<Up>'] = {},
          ['<Down>'] = {},
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<C-n>'] = { 'select_next', 'fallback' },


          ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },


          ['<S-Tab>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },

        enabled = function()
          return not vim.tbl_contains({ "oil" }, vim.bo.filetype)
              and vim.bo.buftype ~= "prompt"
              and vim.b.completion ~= false
        end,

        appearance = {
          -- Sets the fallback highlight groups to nvim-cmp's highlight groups
          -- Useful for when your theme doesn't support blink.cmp
          -- Will be removed in a future release
          -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        completion = {
          documentation = {
            treesitter_highlighting = true,
            auto_show = true,
            auto_show_delay_ms = 0,
            window = {
              border = 'rounded',
              -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
            }
          },

          menu = {
            draw = {
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon .. "   " .. ctx.kind
                  end,
                  -- Optionally, you may also use the highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end,
                }
              },
            },
            border = 'rounded',
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          },
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`

        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer', "lazydev" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },

        },
      }
    )
  end

}
