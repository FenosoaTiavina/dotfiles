return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    {
      'echasnovski/mini.snippets',
      config = function()
        local gen_loader = require('mini.snippets').gen_loader
        require('mini.snippets').setup({
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
        keymap = {
          preset = 'none',

          ['<C-space>'] = {
            function(cmp)
              if cmp.is_visible() then
                return cmp.hide()
              else
                return cmp.show()
              end
            end,
          },
          ['<C-e>'] = {
            function(cmp)
              if cmp.is_signature_visible() then
                return cmp.hide_signature()
              else
                return cmp.show_signature()
              end
            end,
          },
          ['<tab>'] = { 'select_accept_and_enter', 'fallback' },
          ['<C-p>'] = { 'select_prev' },
          ['<C-n>'] = { 'select_next' },
          ['<C-b>'] = { 'scroll_documentation_up' },
          ['<C-f>'] = { 'scroll_documentation_down' },
        },

        enabled = function()
          return not vim.tbl_contains({ "oil" }, vim.bo.filetype)
              and vim.bo.buftype ~= "prompt"
              and vim.b.completion ~= false
        end,

        appearance = {
          nerd_font_variant = 'mono'
        },

        completion = {
          documentation = {
            treesitter_highlighting = true,
            auto_show = true,
            auto_show_delay_ms = 0,
            window = {
              border = 'rounded',
            }
          },

          menu = {
            auto_show = true,
            draw = {
              columns = {
                { "kind_icon", "label", gap = 1, "source_name" },
              },
              components = {

                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon
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

        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer', "lazydev" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },

        },
      }
    )
  end

}
