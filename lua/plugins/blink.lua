---
-- @file lua/plugins/blink.lua
--
-- @brief
-- The configuration file for the plugin blink
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-11-02
--


return {

  'saghen/blink.cmp',

  version = 'v0.5.0',

  ft = { 'lua', 'python' },

  opts = {

    keymap = {

      ['<return>'] = { 'accept', 'fallback' },
      ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    },

    highlight = {
      use_nvim_cmp_as_default = false,
    },

    accept = { auto_brackets = { enabled = false }},
    trigger = { signature_help = { enabled = true }},

    windows = {

      autocomplete = {
        min_width = 15,
        max_height = 10,
        border = 'single',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,Search:None,Pmenu:Normal',
        scrolloff = 2,
        direction_priority = { 's', 'n' },
        auto_show = true,
        selection = 'preselect',
        draw = 'minimal',
        cycle = {
          from_bottom = true,
          from_top = true,
        },
      },

      documentation = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = 'single',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,Search:None,Pmenu:Normal',
        direction_priority = {
          autocomplete_north = { 'e', 'w', 'n', 's' },
          autocomplete_south = { 'e', 'w', 's', 'n' },
        },
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },

      signature_help = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = 'single',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,Search:None,Pmenu:Normal',
        direction_priority = { 's', 'n' },
      },

      ghost_text = {
        enabled = false,
      },

    },

    fuzzy = {

      use_frecency = false,
      use_proximity = false,
      max_items = 50,

      sorts = { 'label', 'kind', 'score' },

      prebuilt_binaries = {
        download = true,
        force_version = nil,
        force_system_triple = nil,
      },

    },

    sources = {

      completion = {
        enabled_providers = { 'snippets', 'lsp', 'path', 'buffer' },
      },

      providers = {

        lsp = {

          name = 'LSP',
          module = 'blink.cmp.sources.lsp',

          enabled = true,
          transform_items = nil,
          should_show_items = true,
          max_items = nil,
          min_keyword_length = 0,
          fallback_for = {},
          score_offset = 0,
          override = nil,

        },

        path = {

          name = 'Path',
          module = 'blink.cmp.sources.path',
          score_offset = 0,

          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
            show_hidden_files_by_default = false,
          }

        },

        snippets = {

          name = 'Snippets',
          module = 'blink.cmp.sources.snippets',
          score_offset = 3,

          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath('config') .. '/snippets' },
            global_snippets = { 'all' },
            extended_filetypes = {},
            ignored_filetypes = {},
          }

        },

        buffer = {

          name = 'Buffer',
          module = 'blink.cmp.sources.buffer',
          fallback_for = { 'lsp' },

        },
      },
    },

    kind_icons = {

      Text = '',
      Method = '',
      Function = '',
      Constructor = '',

      Field = '',
      Variable = '',
      Property = '',

      Class = '',
      Interface = '',
      Struct = '',
      Module = '',

      Unit = '',
      Value = '',
      Enum = '',
      EnumMember = '',

      Keyword = '',
      Constant = '',

      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      Event = '',
      Operator = '',
      TypeParameter = '',

    },

  },

}
