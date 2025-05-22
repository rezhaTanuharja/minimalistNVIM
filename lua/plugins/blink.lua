---
-- @file lua/plugins/blink.lua
--
-- @brief
-- The configuration file for the plugin blink
--
-- @author Tanuharja, R.A.
-- @date 2024-11-02
--


return {

  "saghen/blink.cmp",

  event = "UIEnter",

  version = "1.*",

  opts = {

    keymap = {

      ["<return>"] = { "accept", "fallback" },
      ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },

      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

    },

    completion = {

      accept = {
        auto_brackets = { enabled = false },
      },

      documentation = {

        auto_show = false,

        window = {

          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = "single",
          scrollbar = false,

          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None,Pmenu:Normal",

          direction_priority = {
            menu_north = { "e", "w", "n", "s" },
            menu_south = { "e", "w", "s", "n" },
          }

        },


      },

      ghost_text = {
        enabled = false,
      },

      keyword = {
        range = "full"
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },

      menu = {

        auto_show = true,
        min_width = 15,
        max_height = 10,
        border = "single",

        scrollbar = false,

        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None,Pmenu:Normal",

        direction_priority = { "s", "n" },

        draw = {
          columns = {
            { "label", "kind", gap = 1 },
          },
        },

      },

    },

    sources = {

      default = {
        "snippets",
        "lsp",
        "path",
        "buffer",
      },

      providers = {

        lsp = {

          name = "LSP",
          module = "blink.cmp.sources.lsp",

          enabled = true,
          transform_items = nil,
          should_show_items = true,
          max_items = nil,
          min_keyword_length = 0,
          fallbacks = { "buffer", "path", },
          score_offset = 0,
          override = nil,

        },

        path = {

          name = "Path",
          module = "blink.cmp.sources.path",
          min_keyword_length = 2,
          score_offset = 0,

          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context) return vim.fn.expand( ("#%d:p:h"):format(context.bufnr) ) end,
            show_hidden_files_by_default = false,
          }

        },

        snippets = {

          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          min_keyword_length = 2,
          score_offset = 3,

          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {},
            ignored_filetypes = {},
          }

        },

        buffer = {

          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 5,

        },
      },

    },

    fuzzy = {

      implementation = "prefer_rust_with_warning",

      use_frecency = true,
      use_proximity = false,

      sorts = {
        "exact",
        "score",
        "sort_text"
      },

      prebuilt_binaries = {
        download = true,
      },


    },


  },

}
