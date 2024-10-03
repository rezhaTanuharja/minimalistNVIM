---
-- @file lua/external_plugins/cmp.lua
--
-- @brief
-- The configuration file for the plugin cmp
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  -- github repository for nvim-cmp
  'hrsh7th/nvim-cmp',

  -- load when first entering insert mode
  -- event = 'UIEnter',
  ft = { 'python' },

  dependencies = {

    -- completion from LSP, buffer, and path
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    -- completion from luasnip
    require('external_plugins.luasnip'),

    'saadparwaiz1/cmp_luasnip',

  },

  config = function()

    local success, cmp = pcall(require, 'cmp')
    if not success then
      vim.notify('Failed to load plugin: cmp')
      return
    end

    local luasnip
    success, luasnip = pcall(require, 'luasnip')
    if not success then
      vim.notify('Failed to load plugin: luasnip')
      return
    end

    -- just don't use icons
    local kind_icons = {
      Text = '',
      Method = '<method>',
      Function = '<function>',
      Constructor = '',
      Field = '',
      Variable = '<variable>',
      Class = '<class>',
      Interface = '',
      Module = '<module>',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '<snippet>',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '',
      Misc = '',
    }

    cmp.setup {

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {

        completion = cmp.config.window.bordered(
          {
            border = 'rounded',
            scrollbar = false,
          }
        ),

        documentation = cmp.config.window.bordered(
          {
            border = 'rounded'
          }
        ),

      },

      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = {

        -- press return to confirm completion
        ['<CR>'] = cmp.mapping.confirm{ select = true },

        -- press tab to select the next item
        ['<Tab>'] = cmp.mapping(
          function(fallback)
            if luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

        -- press shift-tab to select prev item
        ['<C-S-j>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

        ['<C-S-k>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

      },

      formatting = {

        fields = { 'kind', 'abbr', 'menu' },

        format = function(entry, vim_item)

          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])

          vim_item.menu = (
            {
              luasnip = 'luasnip',
              nvim_lsp = 'lsp',
              buffer = 'buff',
              path = 'path',
            }
          )[entry.source.name]

          return vim_item

        end,

      },

      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      experimental = {
        ghost_text = false,
        native_menu = false,
      },

    }

  end,

}
